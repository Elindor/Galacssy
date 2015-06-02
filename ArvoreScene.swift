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
    var save: SaveHandler = SaveHandler()
    //var menino = SKSpriteNode(color: SKColor(red: 0/255.0, green: 0/255.0, blue: 255/255.0, alpha: 1.0), size: CGSizeMake(225, 575))
    //var menina = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0), size: CGSizeMake(225, 575))
    var menino = SKSpriteNode(imageNamed: "menino.png")
    var menina = SKSpriteNode(imageNamed: "menina.png")
    var isMenino = false
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        //var a = save.getCurrentCharacter()
        let name = defaults.integerForKey("personagem")
        menino.position = CGPoint(x:(self.size.width/2)+200, y:self.size.height/2)
        menino.zPosition = 2
        menina.position = CGPoint(x:(self.size.width/2)-200, y:self.size.height/2)
        menina.zPosition = 2
        addChild(menino)
        addChild(menina)
        if name == 1 {
            menino.alpha = 0.3
            menina.alpha = 1.0
            isMenino = false
        } else {
            menina.alpha = 0.3
            menino.alpha = 1.0
            isMenino = true
        }
        
        /* cenário casa da árvore */
        casaPersonagem.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        addChild(casaPersonagem)
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent){
        /* Called when a touch begins */
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)

            if (menino.containsPoint(touchLocation)) {
                
                println("clicou no muleque")
                
                if !isMenino {
                    
                    menina.alpha = 0.3
                    menino.alpha = 1.0
                    isMenino = true
                    //save.changeCharacter(newCharacter: 0)
                    defaults.setInteger(0, forKey: "personagem")
                    
                }
                
            } else if (menina.containsPoint(touchLocation)) {
                
                println("clicou na mina")
                
                if isMenino {
                    
                    menina.alpha = 1.0
                    menino.alpha = 0.3
                    isMenino = false
                    //save.changeCharacter(newCharacter: 1)
                    defaults.setInteger(1, forKey: "personagem")
                }
                
            } else {
                
                println("sai da casa")
                
                let cenarioMapa = GameScene(size: self.size)
                cenarioMapa.scaleMode = SKSceneScaleMode.AspectFill
                self.scene!.view?.presentScene(cenarioMapa, transition: transition)
            }
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

