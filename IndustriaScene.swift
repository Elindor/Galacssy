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
    
    let transition = SKTransition()
    
    override func didMoveToView(view: SKView) {
        
        let construcao = SKSpriteNode(imageNamed: "splash.png")
        construcao.xScale = 0.5
        construcao.yScale = 0.5
        construcao.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(construcao)
        /* texto reponsável em exibir que o cenário da indústria esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoIndustria = SKLabelNode(fontNamed:"Arial")
        textoIndustria.text = "A indústria está em construção"
        textoIndustria.fontColor = SKColor.whiteColor()
        textoIndustria.fontSize = 55
        textoIndustria.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)+200)
        self.addChild(textoIndustria)
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