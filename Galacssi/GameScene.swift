//
//  GameScene.swift
//  Galacssi
//
//  Created by Gabriel Nopper on 21/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit


class GameScene: SKScene {
   
    let labelNode = (SKLabelNode (fontNamed: "Bariol-Bold"))
    let labelNode2 = (SKLabelNode (fontNamed: "Bariol-Regular"))
    var text = "NOME DO JOGO"
    var text2 = "HAKUNAMATATA"
    
    //MAPA PRINCIPAL
    let background = SKSpriteNode(imageNamed: "mapa.png")
    let lifeCity = SKSpriteNode(imageNamed: "barraDeVidaMapa.png")
    let predios = SKSpriteNode(imageNamed: "predios.png")
    let smoke1 = SKSpriteNode(imageNamed: "fumaca")
    let smoke2 = SKSpriteNode(imageNamed: "fumaca")
    let btnHouse = SKSpriteNode(imageNamed: "btnCasa.png")
    let btnSafeHouse = SKSpriteNode(imageNamed: "btnArvore.png")
    let btnFactory = SKSpriteNode(imageNamed: "btnIndustria.png")
    let btnFarm = SKSpriteNode(imageNamed: "btnSitio.png")
    let btnForest = SKSpriteNode(imageNamed: "btnFloresta.png")
    let btnBuilding = SKSpriteNode(imageNamed: "btnPredio.png")
    
    //POPUPS FASES
    let popupHouse = SKSpriteNode(imageNamed: "popup.png")
    let popupFarm = SKSpriteNode(imageNamed: "popup.png")
    let popupFactory = SKSpriteNode(imageNamed: "popup.png")
    let popupForest = SKSpriteNode(imageNamed: "popup.png")
    let popupBuilding = SKSpriteNode(imageNamed: "popup.png")

    //CAMADAS
    let layerBackground:CGFloat = 0
    let layerHud:CGFloat = 99
    let layerObject1:CGFloat = 1
    let layerObject2:CGFloat = 2
    let layerObject3:CGFloat = 3
    
    //AMBIENTE ATIVO
    var house = false
    var factory = false
    var farm = false
    var forest = false
    var building = false
    var safeHouse = false
    
    var centerPopUp: CGPoint = CGPoint(x: 512, y: 384)
    var changeScene = false
    
    override func didMoveToView(view: SKView) {
        
        //TESTE DE FONTE
        labelNode.text = text
        labelNode.position = CGPoint(x: 512, y: 700)
        labelNode.zPosition = layerHud
//        addChild(labelNode)
        
        labelNode2.text = text2
        labelNode2.position = CGPoint(x: 512, y: 600)
        labelNode2.zPosition = layerHud
//        addChild(labelNode2)
        
        //MAPA
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.xScale = 0.5
        background.yScale = 0.5
        background.zPosition = layerBackground
//        println("\(self.frame.size.width/2, self.frame.size.height/2)")
        
        //PREDIOS
        predios.position = CGPoint(x: self.frame.size.width/2+20, y: self.frame.size.height/2)
        predios.setScale(0.5)
        predios.zPosition = layerObject2
        predios.name = "predios"
        
        //LOCAL CASA
        btnHouse.position = CGPoint(x: self.frame.size.width/2+15, y: self.frame.size.height/3.2)
        btnHouse.xScale = 0.5
        btnHouse.yScale = 0.5
        btnHouse.zPosition = layerObject1
        btnHouse.name = "botaoCasa"
        
        popupHouse.position = centerPopUp
        popupHouse.xScale = 0.5
        popupHouse.yScale = 0.5
        popupHouse.zPosition = layerBackground
        
        //LOCAL FABRICA
        btnFactory.position = CGPoint(x: 780, y: 180)
        btnFactory.xScale = 0.5
        btnFactory.yScale = 0.5
        btnFactory.zPosition = layerObject1
        btnFactory.name = "botaoIndustria"
       
        popupFactory.position = centerPopUp
        popupFactory.xScale = 0.5
        popupFactory.yScale = 0.5
        popupFactory.zPosition = layerBackground
        
        //LOCAL FAZENDA
        btnFarm.position = CGPoint(x: 863, y: 664)
        btnFarm.xScale = 0.5
        btnFarm.yScale = 0.5
        btnFarm.zPosition = layerObject1
        btnFarm.name = "botaoFazenda"
        
        popupFarm.position = centerPopUp
        popupFarm.xScale = 0.5
        popupFarm.yScale = 0.5
        popupFarm.zPosition = layerBackground
        
        //LOCAL FLORESTA
        btnForest.position = CGPoint(x: 120, y: 690)
        btnForest.xScale = 0.5
        btnForest.yScale = 0.5
        btnForest.zPosition = layerObject1
        btnForest.name = "botaoFloresta"
        
        popupForest.position = centerPopUp
        popupForest.xScale = 0.5
        popupForest.yScale = 0.5
        popupForest.zPosition = layerBackground
        
        //LOCAL PREDIOS
        btnBuilding.position = CGPoint(x: self.frame.size.width/2+15, y: 470)
        btnBuilding.xScale = 0.5
        btnBuilding.yScale = 0.5
        btnBuilding.zPosition = layerObject1
        btnBuilding.name = "botaoPredio"
        
        popupBuilding.position = centerPopUp
        popupBuilding.xScale = 0.5
        popupBuilding.yScale = 0.5
        popupBuilding.zPosition = layerBackground
        
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
        
        self.addChild(popupHouse)
        self.addChild(popupFactory)
        self.addChild(popupFarm)
        self.addChild(popupForest)
        self.addChild(popupBuilding)
        self.addChild(background)
        self.addChild(predios)
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
        
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        callScene(touchLocation)
        callInfo(touchLocation)
        

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
    func callInfo(touchLocation: CGPoint){
        
        let transition = SKTransition()
        
        if (btnHouse.containsPoint(touchLocation)){
            popupHouse.zPosition = layerObject3
            changeScene = true
            house = true
        }
        
        if (btnFarm.containsPoint(touchLocation)){
            popupFarm.zPosition = layerObject3
            changeScene = true
            farm = true
        }
        
        if (btnFactory.containsPoint(touchLocation)){
            popupFactory.zPosition = layerObject3
            changeScene = true
            factory = true
        }
        
        if (btnBuilding.containsPoint(touchLocation)){
            popupBuilding.zPosition = layerObject3
            changeScene = true
            building = true
        }
        
        if (btnForest.containsPoint(touchLocation)){
            popupForest.zPosition = layerObject3
            changeScene = true
            forest = true
        }
        
        if (btnSafeHouse.containsPoint(touchLocation)){
            let cenarioCasaDaArvore = ArvoreScene(size: self.size)
            cenarioCasaDaArvore.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(cenarioCasaDaArvore, transition: transition)
        }
    }
    
    func callScene(touchLocation: CGPoint){
        
        let transition = SKTransition()

        if(changeScene){
            
            if (popupHouse.containsPoint(touchLocation) && house){
                changeScene = false
                let cenarioCasa = CasaScene(size: self.size)
                cenarioCasa.scaleMode = SKSceneScaleMode.AspectFill
                self.scene!.view?.presentScene(cenarioCasa, transition: transition)
            }
            
            if (popupFarm.containsPoint(touchLocation) && farm){
                changeScene = false
                let cenarioFazenda = FazendinhaScene(size: self.size)
                cenarioFazenda.scaleMode = SKSceneScaleMode.AspectFill
                self.scene!.view?.presentScene(cenarioFazenda, transition: transition)
            }
            
            if (popupFactory.containsPoint(touchLocation) && factory){
                changeScene = false
                let cenarioFabrica = IndustriaScene(size: self.size)
                cenarioFabrica.scaleMode = SKSceneScaleMode.AspectFill
                self.scene!.view?.presentScene(cenarioFabrica, transition: transition)
            }
            
            if (popupBuilding.containsPoint(touchLocation) && building){
                changeScene = false
                let cenarioPredio = CidadeScene(size: self.size)
                cenarioPredio.scaleMode = SKSceneScaleMode.AspectFill
                self.scene!.view?.presentScene(cenarioPredio, transition: transition)
            }
            
            if (popupForest.containsPoint(touchLocation) && forest){
                changeScene = false
                let cenarioFloresta = FlorestaScene(size: self.size)
                cenarioFloresta.scaleMode = SKSceneScaleMode.AspectFill
                self.scene!.view?.presentScene(cenarioFloresta, transition: transition)
            }
        }
    }
    
    
}
