//
//  QuartoItem.swift
//  TesteSpriteKitMini2
//
//  Created by Gabriel Oliva de Oliveira on 5/26/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import SpriteKit

class QuartoItem : SKNode {
    
    let type : String
    var tile : SKSpriteNode
    var objeto : SKSpriteNode
    var objetoAuxiliar : SKSpriteNode
    var movimento : SKAction
    var isError : Bool
    var msg : String
    var save: SaveHandler = SaveHandler()
    
    private var gameStateDelegate : GameStateDelegate
    
    init(quartoItemData: [String: AnyObject], quartoItemConfiguration: [String: String], gameStateDelegate: GameStateDelegate, error: Bool) {
        
        isError = error
        
        var radioIsOn: Bool = false

        
        self.gameStateDelegate = gameStateDelegate
        type = quartoItemData["type"] as AnyObject? as! String
        msg = quartoItemConfiguration["msg"] as AnyObject? as! String
        objeto = SKSpriteNode()
        objetoAuxiliar = SKSpriteNode()
        movimento = SKAction()

        //if type == "luz" {
        if (isError) {
            tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(110, 70))
        } else {
            tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(110, 70))
        }
        
        
            
        if type == "abajur" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "luzAbajur.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: -0.0, y: -10.0)
                objetoAuxiliar = SKSpriteNode(imageNamed: "abajurQuarto.png")
                objetoAuxiliar.setScale(0.5)
                objetoAuxiliar.position = CGPoint (x: -0.0, y: 25.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(80, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(80, 100))
            }
            
        } else if type == "computador" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "telaComputador.png")
                objeto.setScale(0.49)
                objeto.position = CGPoint (x: -1.0, y: -1.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(165, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(165, 100))
            }
            
        }  else if type == "rádio" {
            
            if isError {
                save.radioLigado()
                objeto = SKSpriteNode(imageNamed: "partitura.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: -112.0, y: -30.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(50, 85))
                radioIsOn = true
                
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(140, 115))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(140, 115))
            }
            
        }
        
        super.init()
        
        if radioIsOn{
            radioLoop(objeto: objeto)
        }
        
        userInteractionEnabled = true
        
        addChild(tile)
        addChild(objeto)
        addChild(objetoAuxiliar)
        
        if isError {
            gameStateDelegate.gameStateDelegateSetError()
        }
        
    }
    
    func radioLoop(#objeto: SKSpriteNode){
        
        var action1 = SKAction.moveBy(CGVectorMake(-50.0, -40.0), duration: 0.5)
        var action2 = SKAction.moveBy(CGVectorMake(-50.0, 40.0), duration: 0.5)
        var action3 = SKAction.moveBy(CGVectorMake(-50.0, 40.0), duration: 0.5)
        var action4 = SKAction.moveBy(CGVectorMake(-50.0, -40.0), duration: 0.5)
        
        var fader = SKAction.fadeOutWithDuration(1.8)
        var timer = SKAction.waitForDuration(0.9)
        movimento = SKAction.sequence([action1, action2, action3, action4])

        var random = (arc4random() % 40) % 4  // Double Seed
        let newNote: SKSpriteNode

        switch random{
            case 1:
            newNote = SKSpriteNode(imageNamed: "nota2")
            break;
        case 2:
            newNote = SKSpriteNode(imageNamed: "nota3")
            break;
        case 3:
            newNote = SKSpriteNode(imageNamed: "nota4")
            break;
        default:
            newNote = SKSpriteNode(imageNamed: "nota1")
            break;
        }
        newNote.position = CGPoint(x: 106.0, y: 0.0)
        newNote.zPosition = objeto.zPosition + 1
        objeto.addChild(newNote)
        
        newNote.runAction(timer, completion:{
            self.radioLoop(objeto: objeto)
        })
        newNote.runAction(fader)
        newNote.runAction(movimento, completion:{
            newNote.removeFromParent()
            
        })
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if (isError && tile.containsPoint(touchLocation)) {
            gameStateDelegate.gameStateDelegateIncrement()
            save.audioObjetos(type)
            tile.color = SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0)
            objeto.removeFromParent()
            objetoAuxiliar.removeFromParent()
            NSLog("%@", type)
            isError = false
            displayAlert(msg)
        }
        
    }
    
    func displayAlert (msg:String) {
        let alert = UIAlertView(title: "Você sabia?", message: msg, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }

}
