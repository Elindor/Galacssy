//
//  CozinhaItem.swift
//  TesteSpriteKitMini2
//
//  Created by Gabriel Oliva de Oliveira on 5/26/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import SpriteKit

class CozinhaItem : SKNode {
    
    var type : String
    var tile : SKSpriteNode
    var objeto : SKSpriteNode
    var isError : Bool
    var msg : String
    
    private var gameStateDelegate : GameStateDelegate
    
    init(cozinhaItemData: [String: AnyObject], cozinhaItemConfiguration: [String: String], gameStateDelegate: GameStateDelegate, error: Bool) {

        
        isError = error
        
        self.gameStateDelegate = gameStateDelegate
        type = cozinhaItemData["type"] as AnyObject? as! String
        msg = cozinhaItemConfiguration["msg"] as AnyObject? as! String
        objeto = SKSpriteNode()
        
        
        //if type == "luz" {
        if (isError) {
            objeto = SKSpriteNode(imageNamed: "btnvoltar.png")
            objeto.setScale(0.52)
            tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(110, 70))
        } else {
            tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(110, 70))
        }
        
        if type == "geladeira" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "geladeira.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: -52.0, y: 0.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(225, 575))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(225, 575))
            }
            
        } else if type == "torneira" {
            
            if isError {
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(50, 85))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(50, 85))
            }
            
        }  else if type == "microondas" {
            
            if isError {
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(167, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(167, 100))
            }
            
        }
        
        super.init()


        userInteractionEnabled = true
        
        addChild(tile)
        addChild(objeto)
        
        if isError {
            gameStateDelegate.gameStateDelegateSetError()
        }
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if isError {
            gameStateDelegate.gameStateDelegateIncrement()
            tile.color = SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0)
            objeto.removeFromParent()
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

