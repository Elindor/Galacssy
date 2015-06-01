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
    let casaPersonagem = SKSpriteNode(imageNamed: "CasaPersonagem.png")
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* cenário casa da árvore */
        casaPersonagem.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(casaPersonagem)
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

