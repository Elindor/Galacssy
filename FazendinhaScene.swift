//
//  FazendinhaScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Fazenda. É o cenário em que o jogador deve combater os desperdícios que ocorrem na fazenda. */

class FazendinhaScene : SKScene {
    
    let transition = SKTransition()
    
    override func didMoveToView(view: SKView) {
        
        /* texto reponsável em exibir que o cenário da fazenda esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoFazendinha = SKLabelNode(fontNamed:"Arial")
        textoFazendinha.text = "A fazendinha está em construção!"
        textoFazendinha.fontColor = SKColor.blackColor()
        textoFazendinha.fontSize = 55
        textoFazendinha.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(textoFazendinha)
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        let cenarioMapa = GameScene(size: self.size)
        cenarioMapa.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioMapa, transition: transition)

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
