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
    
    let transition = SKTransition()
    
    override func didMoveToView(view: SKView) {
        
        let construcao = SKSpriteNode(imageNamed: "splash.png")
        construcao.xScale = 0.5
        construcao.yScale = 0.5
        construcao.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(construcao)
        /* texto reponsável em exibir que o cenário da floresta esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoFloresta = SKLabelNode(fontNamed:"Arial")
        textoFloresta.text = "A floresta está em construção!"
        textoFloresta.fontColor = SKColor.whiteColor()
        textoFloresta.fontSize = 55
        textoFloresta.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame)-300)
        self.addChild(textoFloresta)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        /* Called when a touch begins */
        
//        let touch = touches.first
//      _on = touch!.locationInNode(self)
        let cenarioMapa = GameScene(size: self.size)
        cenarioMapa.scaleMode = SKSceneScaleMode.AspectFill
        self.scene!.view?.presentScene(cenarioMapa, transition: transition)

    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}