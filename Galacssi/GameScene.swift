//
//  GameScene.swift
//  Galacssi
//
//  Created by Gabriel Nopper on 21/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit
import AVFoundation


class GameScene: SKScene {
   
    let labelNode = (SKLabelNode (fontNamed: "Bariol-Bold"))
    let labelNode2 = (SKLabelNode (fontNamed: "Bariol-Regular"))
    var text = "NOME DO JOGO"
    var text2 = "HAKUNAMATATA"
    
    var coinSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Musica", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    
    //MAPA PRINCIPAL
    let background = SKSpriteNode(imageNamed: "mapa.png")
    let lifeCity = SKSpriteNode(imageNamed: "barraDeVidaMapa.png")
    let predios = SKSpriteNode(imageNamed: "predios.png")
    var lifeCityStatus = SKSpriteNode(color: UIColor(red: 92/255.0, green: 192/255.0, blue: 0/255.0, alpha: 1.0), size: CGSizeMake(0, 0))
    let smoke1 = SKSpriteNode(imageNamed: "fumaca")
    let smoke2 = SKSpriteNode(imageNamed: "fumaca")
    let btnHouse = SKSpriteNode(imageNamed: "btnCasa.png")
    let btnSafeHouse = SKSpriteNode(imageNamed: "btnArvore.png")
    let btnFactory = SKSpriteNode(imageNamed: "btnIndustria.png")
    let btnFarm = SKSpriteNode(imageNamed: "btnSitio.png")
    let btnForest = SKSpriteNode(imageNamed: "btnFloresta.png")
    let btnBuilding = SKSpriteNode(imageNamed: "btnPredio.png")
    var botaoSom = SKSpriteNode(imageNamed: "btnComSom.png")
    var botaoSemSom = SKSpriteNode(imageNamed: "btnSemSom.png")
    var save: SaveHandler = SaveHandler()
    
    //POPUPS FASES
    let popupHouse = SKSpriteNode(imageNamed: "popupMissao.png")
    let popupFarm = SKSpriteNode(imageNamed: "popupMissao.png")
    let popupFactory = SKSpriteNode(imageNamed: "popupMissao.png")
    let popupForest = SKSpriteNode(imageNamed: "popupMissao.png")
    let popupBuilding = SKSpriteNode(imageNamed: "popupMissao.png")
    
    //LABELS E TEXTOS MISSOES
    let missionHouse = SKNode()
//    let missionFarm = SKNode()
//    let missionFactory = SKNode()
//    let missionForest = SKNode()
//    let missionBuilding = SKNode()
    
    var labelMissionHouse = (SKLabelNode (fontNamed: "Bariol-Regular"))
    var labelMissionHouse2 = (SKLabelNode (fontNamed: "Bariol-Regular"))
//    let missionFarm = (SKLabelNode (fontNamed: "Bariol-Bold"))
//    let missionFactory = (SKLabelNode (fontNamed: "Bariol-Bold"))
//    let missionForest = (SKLabelNode (fontNamed: "Bariol-Bold"))
//    let missionBuilding = (SKLabelNode (fontNamed: "Bariol-Bold"))
    
    //let textMissionHouse = "Me ajude a encontrar os"
    //let textMissionHouse2 = "problemas na casa."
    let textMissionHouse = "Me ajude a apagar as luzes"
    let textMissionHouse2 = "e fechar as torneiras."
    let textMissionFarm = "HAKUNAMATATA"
    let textMissionFactory = "É LINDO DIZER"
    let textMissionForest = "HAKUNAMATATA"
    let textMissionBuilding = "HUAHUAHUAHUAHUA"

    //CAMADAS
    let layerHide:CGFloat = -1
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
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let a = defaults.integerForKey("personagem")
        if a == 1 {
            //POPUPS FASES
            popupHouse.texture = SKTexture(imageNamed:"popupMissaoMenina")
            popupFarm.texture = SKTexture(imageNamed:"popupMissaoMenina")
            popupFactory.texture = SKTexture(imageNamed:"popupMissaoMenina")
            popupForest.texture = SKTexture(imageNamed:"popupMissaoMenina")
            popupBuilding.texture = SKTexture(imageNamed:"popupMissaoMenina")
            
        } else {
            
        }
        
        self.updateLifeBar()
        
        save.playAudio()
        var path = documentFilePath(fileName: "missoes.plist")
        var gameData : NSDictionary? = NSDictionary(contentsOfFile: path)
        // Load gamedata template from mainBundle if no saveFile exists
        if gameData == nil {
            var mainBundle = NSBundle.mainBundle()
            path = mainBundle.pathForResource("missoes", ofType: "plist")!
            gameData = NSDictionary(contentsOfFile: path)
        }


        //TESTE DE FONTE
        labelNode.text = text
        labelNode.position = CGPoint(x: 512, y: 700)
        labelNode.zPosition = layerHud
//        addChild(labelNode)
        
        labelNode2.text = text2
        labelNode2.position = CGPoint(x: 512, y: 600)
        labelNode2.zPosition = layerHud
//        addChild(labelNode2)
        
        //TEXTOS DAS MISSOES
//        missionHouse.zPosition = layerBackground
        missionHouse.position = centerPopUp
        labelMissionHouse.text = textMissionHouse
        labelMissionHouse.zPosition = layerHide
        labelMissionHouse.fontColor = SKColor.blackColor()
        labelMissionHouse.fontSize = 30
        labelMissionHouse2.text = textMissionHouse2
        labelMissionHouse2.zPosition = layerHide
        labelMissionHouse2.fontColor = SKColor.blackColor()
        labelMissionHouse2.fontSize = 30
        missionHouse.addChild(labelMissionHouse)
        missionHouse.addChild(labelMissionHouse2)
        labelMissionHouse.position = CGPoint(x: 60, y: -10)
        labelMissionHouse2.position = CGPoint(x: 60, y: -50)
//        missionHouse.addChild(labelMissionHouse2)
//        labelMissionHouse.text = textMissionHouse2
//        labelMissionHouse.position = CGPoint(x: centerPopUp.x, y: centerPopUp.y-20)
//        missionHouse.zPosition = layerBackground
//        missionHouse.addChild(labelMissionHouse)
//        missionHouse.position = centerPopUp
////        missionHouse.text = textMissionHouse
//        missionFarm.zPosition = layerBackground
//        missionFarm.position = centerPopUp
////        missionFarm.text = textMissionFarm
//        missionFactory.zPosition = layerBackground
//        missionFactory.position = centerPopUp
////        missionFactory.text = textMissionFactory
//        missionForest.zPosition = layerBackground
//        missionForest.position = centerPopUp
////        missionForest.text = textMissionForest
//        missionBuilding.zPosition = layerBackground
//        missionBuilding.position = centerPopUp
////        missionBuilding.text = textMissionBuilding
        
        //MAPA
        background.position = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        background.xScale = 0.5
        background.yScale = 0.5
        background.zPosition = layerBackground
//        println("\(self.frame.size.width/2, self.frame.size.height/2)")
        
        botaoSom.position = CGPoint(x: 950, y: 45)
        botaoSom.setScale(0.5)
        
        botaoSemSom.position = CGPoint(x: 950, y: 45)
        botaoSemSom.setScale(0.5)
        
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
        lifeCityStatus.position = CGPoint(x:-323, y: -36.5)
        lifeCityStatus.anchorPoint = CGPointZero
        lifeCityStatus.zPosition = layerHud
        
        btnSafeHouse.position = CGPoint(x: 100, y: 120)
        btnSafeHouse.xScale = 0.5
        btnSafeHouse.yScale = 0.5
        btnSafeHouse.zPosition = layerHud
        
        self.addChild(missionHouse)
//        self.addChild(missionFactory)
//        self.addChild(missionFarm)
//        self.addChild(missionForest)
//        self.addChild(missionBuilding)
        self.addChild(popupHouse)
        self.addChild(popupFactory)
        self.addChild(popupFarm)
        self.addChild(popupForest)
        self.addChild(popupBuilding)
        self.addChild(background)
        self.addChild(predios)
        self.addChild(lifeCity)
        lifeCity.addChild(lifeCityStatus)
        self.addChild(btnHouse)
        self.addChild(btnSafeHouse)
        self.addChild(btnFactory)
        self.addChild(btnFarm)
        self.addChild(btnForest)
        self.addChild(btnBuilding)
        self.addChild(smoke1)
        self.addChild(smoke2)
        self.addChild(botaoSom)
        
        basicAnimations()
        save.save()

    
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
            missionHouse.zPosition = layerObject3
            labelMissionHouse.zPosition = layerObject3
            labelMissionHouse2.zPosition = layerObject3
            changeScene = true
            house = true
        }
        
        if (btnFarm.containsPoint(touchLocation)){
            popupFarm.zPosition = layerObject3
//            missionFarm.zPosition = layerObject3
            changeScene = true
            farm = true
        }
        
        if (btnFactory.containsPoint(touchLocation)){
            popupFactory.zPosition = layerObject3
//            missionFactory.zPosition = layerObject3
            changeScene = true
            factory = true
        }
        
        if (btnBuilding.containsPoint(touchLocation)){
            popupBuilding.zPosition = layerObject3
//            missionBuilding.zPosition = layerObject3
            changeScene = true
            building = true
        }
        
        if (btnForest.containsPoint(touchLocation)){
            popupForest.zPosition = layerObject3
//            missionForest.zPosition = layerObject3
            changeScene = true
            forest = true
        }
        
        if (btnSafeHouse.containsPoint(touchLocation)){
            let cenarioCasaDaArvore = ArvoreScene(size: self.size)
            cenarioCasaDaArvore.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(cenarioCasaDaArvore, transition: transition)
        }
        
        if(botaoSom.containsPoint(touchLocation) && save.musicIsOn()){
            save.callMute()
            botaoSom.removeFromParent()
            save.audioPlayer.stop()
            botaoSemSom.zPosition = 10
            addChild(botaoSemSom)
        }
        else if(botaoSom.containsPoint(touchLocation) && !save.musicIsOn()){
            save.callMute()
            botaoSemSom.removeFromParent()
            save.audioPlayer.play()
            addChild(botaoSom)
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
    
    func updateLifeBar(){
        var saveFile = self.save.getSave()
        var factor : CGFloat = 788.0 / 100.0
        self.lifeCityStatus.size = CGSizeMake(factor * CGFloat(saveFile.cleanLevel), CGFloat(61.0))
    }
    
    func completeScene(){
        self.save.increaseCleanLevelByCompletedScene()
        self.updateLifeBar()
    }
    
    func documentFilePath(#fileName: String) -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentsDirectory = paths[0] as! String
        var path = documentsDirectory.stringByAppendingPathComponent(fileName)
        return path
    }
    
}
