//
//  ArvoreScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Casa na Árvore. Cenário responsável para troca de personagens e futuramente uma lojinha. */

class ArvoreScene : SKScene {
    
    let transition = SKTransition()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* texto reponsável em exibir que o cenário da casa esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoCasaDaArvore = SKLabelNode(fontNamed:"Arial")
        textoCasaDaArvore.text = "A casa da árvore está em construção!"
        textoCasaDaArvore.fontColor = SKColor.blackColor()
        textoCasaDaArvore.fontSize = 55
        textoCasaDaArvore.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoCasaDaArvore)
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
