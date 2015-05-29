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
    var isError : Bool
    
    private var gameStateDelegate : GameStateDelegate
    
    init(quartoItemData: [String: AnyObject], quartoItemConfiguration: [String: String], gameStateDelegate: GameStateDelegate, error: Bool) {
        
        /*let diceRoll = Int(arc4random_uniform(2))
        
        if diceRoll == 0 {
            isError = true
        } else {
            isError = false
        }*/
        
        isError = error
        
        self.gameStateDelegate = gameStateDelegate
        type = quartoItemData["type"] as AnyObject? as! String
        
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
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(140, 115))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(140, 115))
            }
            
        }
        
        super.init()
        
        userInteractionEnabled = true
        
        addChild(tile)
        
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
            tile.color = SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3)
            NSLog("%@", type)
            isError = false
        }
        
    }

}
