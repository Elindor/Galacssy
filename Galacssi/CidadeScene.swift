//
//  CidadeScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 25/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Apartamentos/Prédios. É o cenário em que o jogador deve combater os desperdícios que ocorrem em prédios. */

class CidadeScene : SKScene {
    
    override func didMoveToView(view: SKView) {
        
        /* texto reponsável em exibir que o cenário da cidade esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoCidade = SKLabelNode(fontNamed:"Arial")
        textoCidade.text = "A cidade está em construção!"
        textoCidade.fontColor = SKColor.blackColor()
        textoCidade.fontSize = 55
        textoCidade.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoCidade)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
