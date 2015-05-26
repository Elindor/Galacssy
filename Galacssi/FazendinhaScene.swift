//
//  FazendinhaScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 25/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Fazenda. É o cenário em que o jogador deve combater os desperdícios que ocorrem na fazenda. */

class FazendinhaScene : SKScene {
    
    override func didMoveToView(view: SKView) {
        
        /* texto reponsável em exibir que o cenário da fazenda esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoFazendinha = SKLabelNode(fontNamed:"Arial")
        textoFazendinha.text = "A fazendinha está em construção!"
        textoFazendinha.fontColor = SKColor.blackColor()
        textoFazendinha.fontSize = 55
        textoFazendinha.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoFazendinha)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

