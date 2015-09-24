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
    
    
    let camadaBackground:CGFloat = 0
    let camadaPersonagem:CGFloat = 1
    let camadaCreditos:CGFloat = 2
    let camadaBotoes:CGFloat = 3
    
    var telaDeSelecao = true
    
    let transition = SKTransition()
    let casaPersonagem = SKSpriteNode(imageNamed: "CasaPersonagem.png")
    var voltarButton = SKSpriteNode(imageNamed: "btnVoltar.png")
    var voltarCreditos = SKSpriteNode(imageNamed: "btnVoltar.png")
    var creditos = SKSpriteNode(imageNamed: "creditos.png")
    var creditosButton = SKSpriteNode(imageNamed: "btnCredito.png")
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
        menino.zPosition = camadaPersonagem
        menina.position = CGPoint(x:(self.size.width/2)-200, y:self.size.height/2)
        menina.zPosition = camadaPersonagem
        
        if name == 1 {
            menino.alpha = 0.3
            menina.alpha = 1.0
            isMenino = false
        } else {
            menina.alpha = 0.3
            menino.alpha = 1.0
            isMenino = true
        }
        
        creditosButton.setScale(0.3)
        creditosButton.position = CGPointMake(940,50);
        creditosButton.zPosition = camadaBotoes
        
        voltarButton.setScale(0.5)
        voltarButton.position = CGPointMake(40,730);
        voltarButton.zPosition = camadaBotoes
        
        voltarCreditos.setScale(0.5)
        voltarCreditos.position = CGPointMake(40,730);
        voltarCreditos.zPosition = camadaBackground
        
        creditos.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        creditos.zPosition = camadaBackground
        
        /* cenário casa da árvore */
        casaPersonagem.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        casaPersonagem.zPosition = camadaBackground
        
        addChild(voltarCreditos)
        addChild(creditos)
        addChild(creditosButton)
        addChild(casaPersonagem)
        addChild(menino)
        addChild(menina)
        addChild(voltarButton)
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?){
        /* Called when a touch begins */
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        
        if telaDeSelecao {
            
            if (menino.containsPoint(touchLocation)) {
                
                if !isMenino {
                    
                    menina.alpha = 0.3
                    menino.alpha = 1.0
                    isMenino = true
                    //save.changeCharacter(newCharacter: 0)
                    defaults.setInteger(0, forKey: "personagem")
                }
                
            } else if (menina.containsPoint(touchLocation)) {
                
                if isMenino {
                    
                    menina.alpha = 1.0
                    menino.alpha = 0.3
                    isMenino = false
                    //save.changeCharacter(newCharacter: 1)
                    defaults.setInteger(1, forKey: "personagem")
                }
                
            } else if(voltarButton.containsPoint(touchLocation)){
    
                let cenarioMapa = GameScene(size: self.size)
                cenarioMapa.scaleMode = SKSceneScaleMode.AspectFill
                self.scene!.view?.presentScene(cenarioMapa, transition: transition)
                
            } else if(creditosButton.containsPoint(touchLocation)){
                
                creditosButton.zPosition = camadaBackground
                creditos.zPosition = camadaCreditos
                voltarButton.zPosition = camadaBackground
                voltarCreditos.zPosition = camadaBotoes
                telaDeSelecao = false
            }
        
        } else {
            
            if(voltarCreditos.containsPoint(touchLocation)){
                creditosButton.zPosition = camadaBotoes
                creditos.zPosition = camadaBackground
                voltarButton.zPosition = camadaBotoes
                voltarCreditos.zPosition = camadaBotoes
                telaDeSelecao = true
            }
        }
    }

    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
}

