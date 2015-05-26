//
//  GameScene.swift
//  Galacssi
//
//  Created by Gabriel Nopper on 21/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

class GameScene: SKScene {
    
    //MAPA PRINCIPAL
    let background = SKSpriteNode(imageNamed: "mapa.png")
    let lifeCity = SKSpriteNode(imageNamed: "barraDeVidaMapa.png")
    let smoke1 = SKSpriteNode(imageNamed: "fumaca")
    let smoke2 = SKSpriteNode(imageNamed: "fumaca")
    let btnHouse = SKSpriteNode(imageNamed: "btnCasa.png")
    let btnSafeHouse = SKSpriteNode(imageNamed: "btnArvore.png")
    let btnFactory = SKSpriteNode(imageNamed: "btnIndustria.png")
    let btnFarm = SKSpriteNode(imageNamed: "btnSitio.png")
    let btnForest = SKSpriteNode(imageNamed: "btnFloresta.png")
    let btnBuilding = SKSpriteNode(imageNamed: "btnPredio.png")
    
    //CAMADAS
    let layerBackground:CGFloat = 0
    let layerHud:CGFloat = 99
    let layerObject1:CGFloat = 1
//    let layerObject2:CGFloat = 2
    
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        let myLabel = SKSpriteNode(imageNamed: "teste.ai")
        myLabel.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame));
        myLabel.setScale(0.6)
       
        
        //MAPA
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.xScale = 0.5
        background.yScale = 0.5
        background.zPosition = layerBackground
//        println("\(self.frame.size.width/2, self.frame.size.height/2)")
        
        //LOCAIS
        btnHouse.position = CGPoint(x: self.frame.size.width/2+15, y: self.frame.size.height/3.2)
        btnHouse.xScale = 0.5
        btnHouse.yScale = 0.5
        btnHouse.zPosition = layerObject1
        
        btnFactory.position = CGPoint(x: 780, y: 180)
        btnFactory.xScale = 0.5
        btnFactory.yScale = 0.5
        btnFactory.zPosition = layerObject1
        
        btnFarm.position = CGPoint(x: 863, y: 664)
        btnFarm.xScale = 0.5
        btnFarm.yScale = 0.5
        btnFarm.zPosition = layerObject1
        
        btnForest.position = CGPoint(x: 120, y: 690)
        btnForest.xScale = 0.5
        btnForest.yScale = 0.5
        btnForest.zPosition = layerObject1
        
        btnBuilding.position = CGPoint(x: self.frame.size.width/2+15, y: 470)
        btnBuilding.xScale = 0.5
        btnBuilding.yScale = 0.5
        btnBuilding.zPosition = layerObject1
        
        //OBJETOS ANIMADOS
        smoke1.position = CGPoint(x: 767, y: 230)
        smoke1.xScale = 0.01
        smoke1.yScale = 0.01
        smoke1.zPosition = layerObject1
        
        smoke2.position = CGPoint(x: 815, y: 253)
        smoke2.xScale = 0.01
        smoke2.yScale = 0.01
        smoke2.zPosition = layerObject1
        
        //HUD
        lifeCity.position = CGPoint(x: self.frame.size.width/2, y: 50)
        lifeCity.xScale = 0.5
        lifeCity.yScale = 0.5
        lifeCity.zPosition = layerHud
        
        btnSafeHouse.position = CGPoint(x: 100, y: 120)
        btnSafeHouse.xScale = 0.5
        btnSafeHouse.yScale = 0.5
        btnSafeHouse.zPosition = layerHud
    
        
        self.addChild(background)
        self.addChild(lifeCity)
        self.addChild(btnHouse)
        self.addChild(btnSafeHouse)
        self.addChild(btnFactory)
        self.addChild(btnFarm)
        self.addChild(btnForest)
        self.addChild(btnBuilding)
        self.addChild(smoke1)
        self.addChild(smoke2)
        
        basicAnimations()

    
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
    }
   
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
        
    }
    
    
    //ANIMACAO MAPA
    func basicAnimations(){
        
        
        //NUVENS DE POLUICAO
        let origin1 = CGPointMake(smoke1.position.x, smoke1.position.y)
        let move1 = CGPointMake(smoke1.position.x+30, smoke1.position.y+40)
        
        let origin2 = CGPointMake(smoke2.position.x, smoke2.position.y)
        let move2 = CGPointMake(smoke2.position.x+30, smoke2.position.y+40)
        
        var resizeSmoke1 = Array<SKAction>()
        resizeSmoke1.append(SKAction.scaleTo(0.5, duration: 1.5))
        resizeSmoke1.append(SKAction.scaleTo(0.01, duration: 0.500))
        
        var moveSmoke1 = Array<SKAction>()
        moveSmoke1.append(SKAction.moveTo(move1, duration: 1.999))
        moveSmoke1.append(SKAction.moveTo(origin1, duration: 0.001))
        
        var resizeSmoke2 = Array<SKAction>()
        resizeSmoke2.append(SKAction.scaleTo(0.5, duration: 2.5))
        resizeSmoke2.append(SKAction.scaleTo(0.01, duration: 0.5))
        
        var moveSmoke2 = Array<SKAction>()
        moveSmoke2.append(SKAction.moveTo(move2, duration: 2.999))
        moveSmoke2.append(SKAction.moveTo(origin2, duration: 0.001))
        
        var actions2 = Array<SKAction>()
        actions2.append(SKAction.sequence(resizeSmoke2))
        actions2.append(SKAction.sequence(moveSmoke2))

        smoke1.runAction(SKAction.repeatActionForever(SKAction.sequence(resizeSmoke1)))
        smoke1.runAction(SKAction.repeatActionForever(SKAction.sequence(moveSmoke1)))
        smoke2.runAction(SKAction.repeatActionForever(SKAction.sequence(resizeSmoke2)))
        smoke2.runAction(SKAction.repeatActionForever(SKAction.sequence(moveSmoke2)))
        
        return;
    }
    
    //CHAMA CENARIO
    func callScene(touchLocation: CGPoint){
        
        if (btnHouse.containsPoint(touchLocation)){
            println("Chama Cena Casa")
        }
        
        if (btnFarm.containsPoint(touchLocation)){
            println("Chama Cena Fazenda")
        }
        
        if (btnFactory.containsPoint(touchLocation)){
            println("Chama Cena Fabrica")
        }
        
        if (btnBuilding.containsPoint(touchLocation)){
            println("Chama Cena Predio")
        }
        
        if (btnSafeHouse.containsPoint(touchLocation)){
            println("Chama Cena Casa da Arvore")
        }
        
        if (btnForest.containsPoint(touchLocation)){
            println("Chama Cena Floresta")
        }
    }
}
