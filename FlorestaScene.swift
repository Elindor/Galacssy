//
//  FlorestaScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Floresta. É o cenário em que o jogador deve combater os desperdícios que ocorrem na floresta. */

class FlorestaScene : SKScene {
    
    override func didMoveToView(view: SKView) {
        
        /* texto reponsável em exibir que o cenário da floresta esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoFloresta = SKLabelNode(fontNamed:"Arial")
        textoFloresta.text = "A floresta está em construção!"
        textoFloresta.fontColor = SKColor.blackColor()
        textoFloresta.fontSize = 55
        textoFloresta.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoFloresta)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}