//
//  GameStateDelegate.swift
//  TesteSpriteKitMini2
//
//  Created by Gabriel Oliva de Oliveira on 5/25/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import SpriteKit

protocol GameStateDelegate {
    
    func gameStateDelegateIncrement(mensagem: String, node: SKNode) -> Bool
    func gameStateDelegateSetError()
    
}