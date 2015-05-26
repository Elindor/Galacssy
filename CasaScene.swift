//
//  CasaScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Casa. É o cenário em que o jogador deve combater os desperdícios que ocorrem na casa. */

class CasaScene : SKScene {
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        /* texto reponsável em exibir que o cenário da casa esta em construção. */
        self.backgroundColor = SKColor.whiteColor()
        let textoCasa = SKLabelNode(fontNamed:"Arial")
        textoCasa.text = "A casa está em construção!"
        textoCasa.fontColor = SKColor.blackColor()
        textoCasa.fontSize = 55
        textoCasa.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoCasa)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}
