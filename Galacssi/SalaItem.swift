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
    var isError : Bool
    
    private var gameStateDelegate : GameStateDelegate
    
    init(salaItemData: [String: AnyObject], salaItemConfiguration: [String: NSNumber], gameStateDelegate: GameStateDelegate, error: Bool) {
        
        isError = error
        
        self.gameStateDelegate = gameStateDelegate
        type = salaItemData["type"] as AnyObject? as! String
        
        //if type == "luz" {
        if (isError) {
            tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(140, 140))
        } else {
            tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(140, 140))
        }
        
        if type == "abajur" {
            
            if isError {
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(75, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(75, 100))
            }
            
        } else if type == "televisão" {
            
            if isError {
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(75, 75))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(75, 75))
            }
            
        }  else if type == "video_game" {
            
            if isError {
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(75, 75))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.3), size: CGSizeMake(75, 75))
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

