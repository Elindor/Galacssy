//
//  IndustriaScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Indústria. É o cenário em que o jogador deve combater os desperdícios que ocorrem na indústria. */

class IndustriaScene : SKScene {
    
    override func didMoveToView(view: SKView) {
        
        /* texto reponsável em exibir que o cenário da indústria esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoIndustria = SKLabelNode(fontNamed:"Arial")
        textoIndustria.text = "A indústria está em construção"
        textoIndustria.fontColor = SKColor.blackColor()
        textoIndustria.fontSize = 55
        textoIndustria.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoIndustria)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}