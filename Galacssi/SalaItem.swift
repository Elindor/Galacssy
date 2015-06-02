//
//  SalaItem.swift
//  TesteSpriteKitMini2
//
//  Created by Gabriel Oliva de Oliveira on 5/26/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import SpriteKit

class SalaItem : SKNode {
    
    let type : String
    var tile : SKSpriteNode
    var objeto : SKSpriteNode
    var objetoAuxiliar : SKSpriteNode
    var isError : Bool
    var msg : String
    
    private var gameStateDelegate : GameStateDelegate
    
    init(salaItemData: [String: AnyObject], salaItemConfiguration: [String: String], gameStateDelegate: GameStateDelegate, error: Bool) {
        
        isError = error
        
        self.gameStateDelegate = gameStateDelegate
        type = salaItemData["type"] as AnyObject? as! String
        msg = salaItemConfiguration["msg"] as AnyObject? as! String
        objeto = SKSpriteNode()
        objetoAuxiliar = SKSpriteNode()
        
        //if type == "luz" {
        if (isError) {
            objeto = SKSpriteNode(imageNamed: "LuzLustre.png")
            objeto.setScale(0.52)
            objeto.position = CGPoint (x: 14.5, y: -301.0)
            tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(115, 75))
        } else {
            tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(115, 75))
        }
        
        if type == "abajur" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "luzAbajur.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: -0.0, y: -10.0)
                objetoAuxiliar = SKSpriteNode(imageNamed: "abajurSala.png")
                objetoAuxiliar.setScale(0.5)
                objetoAuxiliar.position = CGPoint (x: -0.0, y: 25.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(80, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(80, 100))
            }
            
        } else if type == "televisão" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "telaDaTv.png")
                objeto.setScale(0.495)
                objeto.position = CGPoint (x: -3.5, y: 2.5)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(285, 170))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(285, 170))
            }
            
        }  else if type == "video_game" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "bolinhaPS4.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: -13.0, y: 32.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(60, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(60, 100))
            }
            
        }
        
        super.init()
        
        userInteractionEnabled = true
        
        addChild(tile)
        addChild(objeto)
        addChild(objetoAuxiliar)
        
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
            }
        }
        
    }
    
    func displayAlert (msg:String) {
        let alert = UIAlertView(title: "Você sabia?", message: msg, delegate: self, cancelButtonTitle: "OK")
        alert.show()
    }
    
}

