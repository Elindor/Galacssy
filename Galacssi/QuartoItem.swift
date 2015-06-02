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
    var movimento : SKAction
    var isError : Bool
    var msg : String
    
    private var gameStateDelegate : GameStateDelegate
    
    init(quartoItemData: [String: AnyObject], quartoItemConfiguration: [String: String], gameStateDelegate: GameStateDelegate, error: Bool) {
        
        /*let diceRoll = Int(arc4random_uniform(2))
        
        if diceRoll == 0 {
            isError = true
        } else {
            isError = false
        }*/
        
        isError = error
        
        var radioIsOn: Bool = false

        
        self.gameStateDelegate = gameStateDelegate
        type = quartoItemData["type"] as AnyObject? as! String
        msg = quartoItemConfiguration["msg"] as AnyObject? as! String
        objeto = SKSpriteNode()
        movimento = SKAction()

        //if type == "luz" {
        if (isError) {
            tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(110, 70))
        } else {
            tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(110, 70))
        }
            
        if type == "abajur" {
            
            if isError {
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(80, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(80, 100))
            }
            
        } else if type == "computador" {
            
            if isError {
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(165, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(165, 100))
            }
            
        }  else if type == "rádio" {
            
            if isError {
                
                objeto = SKSpriteNode(imageNamed: "partitura.png")
                objeto.setScale(0.3)
                objeto.position = CGPoint (x: -52.0, y: 0.0)
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
        
        if isError {
            gameStateDelegate.gameStateDelegateSetError()
        }
        
    }
    
    func radioLoop(#objeto: SKSpriteNode){
        
        var action1 = SKAction.moveBy(CGVectorMake(-40.0, -40.0), duration: 0.5)
        var action2 = SKAction.moveBy(CGVectorMake(-40.0, 40.0), duration: 0.5)
        var action3 = SKAction.moveBy(CGVectorMake(-40.0, 40.0), duration: 0.5)
        var action4 = SKAction.moveBy(CGVectorMake(-40.0, -40.0), duration: 0.5)
        action1.timingMode = SKActionTimingMode.EaseInEaseOut
        action2.timingMode = SKActionTimingMode.EaseInEaseOut
        action3.timingMode = SKActionTimingMode.EaseInEaseOut
        action4.timingMode = SKActionTimingMode.EaseInEaseOut
        
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
        // Nopper constrruindo isso agora
        newNote.position = CGPoint(x: 16.0, y: -3.0)
        objeto.addChild(newNote)
        movimento = SKAction.moveToY(-33.0, duration: 0.5)
        var fade = SKAction.fadeOutWithDuration(0.7)
        fade.timingMode = SKActionTimingMode.EaseIn
        objeto.runAction(fade)
        objeto.runAction(movimento, completion:{
            objeto.runAction(SKAction.waitForDuration(0.5), completion:{
                self.radioLoop(objeto: objeto)
            })
            
        })
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if isError {
            gameStateDelegate.gameStateDelegateIncrement()
            tile.color = SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3)
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
