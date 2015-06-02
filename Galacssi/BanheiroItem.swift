//
//  BanheiroItem.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

class BanheiroItem : SKNode, UIAlertViewDelegate {
    
    let type : String
    var tile : SKSpriteNode
    var objeto : SKSpriteNode
    var objetoAuxiliar : SKSpriteNode
    var objetoAuxiliar2 : SKSpriteNode
    var movimento : SKAction
    var movimentoChuveiro: SKAction
    var isError : Bool
    var msg : String
    var save: SaveHandler = SaveHandler()
    
    private var gameStateDelegate : GameStateDelegate
    
    init(banheiroItemData: [String: AnyObject], banheiroItemConfiguration: [String: String], gameStateDelegate: GameStateDelegate, error: Bool) {
        
        isError = error
        
        var waterIsOn: Bool = false
        var waterIsOnChuveiro: Bool = false
        
        self.gameStateDelegate = gameStateDelegate
        type = banheiroItemData["type"] as AnyObject? as! String
        msg = banheiroItemConfiguration["msg"] as AnyObject? as! String
        objeto = SKSpriteNode()
        objetoAuxiliar = SKSpriteNode()
        objetoAuxiliar2 = SKSpriteNode ()
        tile = SKSpriteNode()
        movimento = SKAction()
        movimentoChuveiro = SKAction()
        
        
        if type == "vaso"{
            if (isError) {
                objeto = SKSpriteNode(imageNamed: "luzBanheiro.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: 10.5, y: -1.0)
                objetoAuxiliar = SKSpriteNode(imageNamed: "protecaoLuzBanheiroDireita.png")
                objetoAuxiliar.setScale(0.5)
                objetoAuxiliar.position = CGPoint (x: -10.5, y: 2.3)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(70, 70))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(70, 70))
            }
        }
        
        if type == "pia" {
            
            if isError {
                save.torneiraLigada()
                objeto = SKSpriteNode(imageNamed: "gota.png")
                objeto.setScale(0.3)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(50, 90))
                waterIsOn = true
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(50, 90))
            }
            
        } else if type == "chuveiro" {
            
            if isError {
                save.chuveiroLigado()
                objeto = SKSpriteNode(imageNamed: "gota.png")
                objeto.setScale(0.3)
                objetoAuxiliar = SKSpriteNode(imageNamed: "gota.png")
                objetoAuxiliar.setScale(0.3)
                objetoAuxiliar2 = SKSpriteNode(imageNamed: "poca.png")
                objetoAuxiliar2.setScale(0.5)
                objetoAuxiliar2.position = CGPoint (x: 0.0, y: -500.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(115, 75))
                waterIsOnChuveiro = true
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(115, 75))
            }
            
        }  else if type == "luz" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "luzBanheiro.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: -7.7, y: -0.0)
                objetoAuxiliar = SKSpriteNode(imageNamed: "ProtecaoLuzBanheiroEsquerda.png")
                objetoAuxiliar.setScale(0.5)
                objetoAuxiliar.position = CGPoint (x: 10.5, y: 0.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(70, 70))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(70, 70))
            }
            
        }
        
        super.init()
        
        if waterIsOn{
            
            waterLoop(objeto: objeto)
            
        }
        
        if waterIsOnChuveiro{
            
            waterLoopChuveiro1(objeto: objeto)
            waterLoopChuveiro2(objeto: objetoAuxiliar)
            
        }
        
        userInteractionEnabled = true
        
        addChild(tile)
        addChild(objeto)
        addChild(objetoAuxiliar)
        addChild(objetoAuxiliar2)
        
        if isError {
            gameStateDelegate.gameStateDelegateSetError()
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        if (isError && tile.containsPoint(touchLocation)) {
            if gameStateDelegate.gameStateDelegateIncrement(msg, node: self) {
                isError = false
                save.audioObjetos(type)
            }
            
        }
    }
    
    func displayAlert (msg:String) {
        let alert = UIAlertView(title: "Você sabia?", message: msg, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
    func waterLoop(#objeto: SKSpriteNode){
        objeto.alpha = 1
        objeto.position = CGPoint(x: -11.0, y: -0.0)
        movimento = SKAction.moveToY(-33.0, duration: 0.5)
        var fade = SKAction.fadeOutWithDuration(0.7)
        fade.timingMode = SKActionTimingMode.EaseIn
        objeto.runAction(fade)
        objeto.runAction(movimento, completion:{
            objeto.runAction(SKAction.waitForDuration(0.5), completion:{
                self.waterLoop(objeto: objeto)
            })
            
        })
        
    }
    
    func waterLoopChuveiro1(#objeto: SKSpriteNode){
        objeto.alpha = 1
        objeto.position = CGPoint(x: -11.0, y: -0.0)
        movimentoChuveiro = SKAction.moveToY(-500.0, duration: 2.5)
        var fade = SKAction.fadeOutWithDuration(6)
        fade.timingMode = SKActionTimingMode.EaseIn
        objeto.runAction(fade)
        objeto.runAction(movimentoChuveiro, completion:{
            objeto.runAction(SKAction.waitForDuration(0.5), completion:{
                self.waterLoopChuveiro1(objeto: objeto)
            })
        })
    }
    
    func waterLoopChuveiro2(#objeto: SKSpriteNode){
        objeto.alpha = 1
        objeto.position = CGPoint(x: 15.0, y: -0.0)
        movimentoChuveiro = SKAction.moveToY(-500.0, duration: 2.5)
        var fade = SKAction.fadeOutWithDuration(6)
        fade.timingMode = SKActionTimingMode.EaseIn
        objeto.runAction(fade)
        objeto.runAction(movimentoChuveiro, completion:{
            objeto.runAction(SKAction.waitForDuration(1.5), completion:{
                self.waterLoopChuveiro2(objeto: objeto)
            })
        })
    }
}

