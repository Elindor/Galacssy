//
//  CasaScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit

/* Cenário: Casa. É o cenário em que o jogador deve combater os desperdícios que ocorrem na casa. */

class CasaScene: SKScene, GameStateDelegate {
    enum comodo : Int {
        //nothing
        case nenhum = 0
        case banheiro = 1
        case sala = 2
        case quarto = 3
        case cozinha = 4
    }
    
    var erros = 0
    var acertos = 0
    var onRoom: Bool = false
    var isFinish = false
    
    //CAMADAS
    var camadaHide:CGFloat = 0
    var camadaMenu:CGFloat = 1
    var camadaButtons:CGFloat = 2
    var camadaAmbiente:CGFloat = 3
    var camadaObjects:CGFloat = 4
    var camadaPontos:CGFloat = 5
    var camadaFimFase:CGFloat = 6
    
    //AMBIENTES
    var banheiro = SKSpriteNode()
    var quartoButton = SKSpriteNode()
    var banheiroButton = SKSpriteNode()
    var salaButton = SKSpriteNode()
    var cozinhaButton = SKSpriteNode()
    var background = SKSpriteNode()
    
    var sky = SKSpriteNode()
    
    var estaNoComodo = comodo.nenhum
    
    //OBJETOS ANIMADOS
    let nuvem1 = SKSpriteNode(imageNamed: "nuvem1.png")
    let nuvem2 = SKSpriteNode(imageNamed: "nuvem2.png")
    let nuvemG1 = SKSpriteNode(imageNamed: "nuvem1.png")
    
    var popup = SKSpriteNode()
    
    var banheiroItems = [BanheiroItem]()
    var banheiroItemConfigurations = [String: [String: String]]()
    
    var erroLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    let textoFinal = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        //Create House's buttons
        quartoButton = SKSpriteNode(imageNamed: "banheiro.jpg")
        quartoButton.size.height = 260
        quartoButton.size.width = 380
        quartoButton.alpha = 0
        quartoButton.position = CGPoint(x: 360, y: 415)
        quartoButton.zPosition = camadaButtons
        addChild(quartoButton)
        
        banheiroButton = SKSpriteNode(imageNamed: "banheiro.jpg")
        banheiroButton.size.height = 260
        banheiroButton.size.width = 290
        banheiroButton.alpha = 0
        banheiroButton.position = CGPoint(x: 700, y: 415)
        banheiroButton.zPosition = camadaButtons
        addChild(banheiroButton)
        
        salaButton = SKSpriteNode(imageNamed: "banheiro.jpg")
        salaButton.size.height = 250
        salaButton.size.width = 310
        salaButton.alpha = 0
        salaButton.position = CGPoint(x: 325, y: 135)
        salaButton.zPosition = camadaButtons
        addChild(salaButton)
        
        cozinhaButton = SKSpriteNode(imageNamed: "banheiro.jpg")
        cozinhaButton.size.height = 255
        cozinhaButton.size.width = 355
        cozinhaButton.alpha = 0
        cozinhaButton.position = CGPoint(x: 665, y: 135)
        cozinhaButton.zPosition = camadaButtons
        addChild(cozinhaButton)
        
        //OBJETOS ANIMADOS
        nuvemG1.position = CGPoint(x: -nuvemG1.size.width, y: 600)
        nuvemG1.zPosition = camadaMenu
        addChild(nuvemG1)
        
        nuvem1.position = CGPoint(x: -nuvem1.size.width, y: 530)
        nuvem1.xScale = 0.5
        nuvem1.yScale = 0.5
        nuvem1.zPosition = camadaMenu
        addChild(nuvem1)
        
        nuvem2.position = CGPoint(x: -nuvem2.size.width, y: 700)
        nuvem2.xScale = 0.5
        nuvem2.yScale = 0.5
        nuvem2.zPosition = camadaMenu
        addChild(nuvem2)
        
        // Create banheiro
        banheiro = SKSpriteNode(imageNamed: "banheiro.jpg")
        banheiro.size.height = size.height
        banheiro.size.width = size.width
        //banheiro.position = CGPoint(x: size.width/2, y: size.height/2)
        banheiro.anchorPoint = CGPointZero
        addChild(banheiro)
        
        popup = SKSpriteNode(imageNamed: "popup.png")
        popup.setScale(0.5)
        popup.zPosition = camadaHide
        popup.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(popup)
        
        // Draw background
        background = SKSpriteNode(imageNamed: "menuCasa")
        background.size.height = size.height
        background.size.width = size.width
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = camadaMenu
        addChild(background)
        
        erroLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        erroLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        erroLabel.position = CGPoint(x: 300, y: size.height - 30)
        erroLabel.color = SKColor(red: 30/255.0, green: 30/255.0, blue: 175/255.0, alpha: 1.0)
        erroLabel.colorBlendFactor = 1.0
        erroLabel.fontSize = 50
//        banheiro.addChild(erroLabel)
//        
        textoFinal.text = "PARABÉNS"
        textoFinal.fontColor = SKColor.blackColor()
        textoFinal.fontSize = 20
        popup.zPosition = camadaHide
        textoFinal.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoFinal)

        // Draw Sky
        var temp = SKSpriteNode(color: UIColor(red: 0.2, green: 0.5, blue: 0.8, alpha: 1), size: CGSize(width: self.frame.width,height: self.frame.height))
        sky = temp
        sky.anchorPoint = CGPointZero
        sky.zPosition = camadaMenu
        addChild(sky)
        
        basicAnimations()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        /* Called when a touch begins */
        let touch = touches.first as! UITouch
        let touchLocation = touch.locationInNode(self)
        
        callScene(touchLocation)
        
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func callScene(touchLocation: CGPoint){
        
        println("Camada banheiro: \(banheiro.zPosition)) Camada ceu: \(sky.zPosition)")
        
        if(banheiroButton.containsPoint(touchLocation) && !self.onRoom){
            self.onRoom = true
//            estaNoComodo = true
            println("Chama Cena Banheiro")
            loadGameData("banheiro")
            banheiro.zPosition = camadaAmbiente
            erroLabel.zPosition = camadaPontos
            
            if(acertos == erros){
                self.onRoom = true
            }
        }
        
//        if (background.containsPoint(touchLocation) && !self.onRoom){
//            println("Chama Cena Banheiro")
//            banheiro.zPosition = CGFloat(1);
//            background.zPosition = CGFloat(0);
//            erroLabel.zPosition = CGFloat(1);
//            self.onRoom = true
//        if (background.containsPoint(touchLocation) && !self.onRoom){
//            println("Chama Cena Banheiro")
//            banheiro.zPosition = CGFloat(1);
//            background.zPosition = CGFloat(0);
//            erroLabel.zPosition = CGFloat(1);
//            self.onRoom = true
//        }
//        
//        else if(banheiro.containsPoint(touchLocation) && popup.containsPoint(touchLocation) && self.onRoom && isFinish){
            
        else if(banheiro.containsPoint(touchLocation) && self.onRoom){
            println("Chama Cena da Casa")
                hideAll()
                background.zPosition = camadaMenu
        }
        
        else if(sky.containsPoint(touchLocation)){
            println("jjjj")
            let transition = SKTransition()
            let cidade = GameScene(size: self.size)
            cidade.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(cidade, transition: transition)
        }
        
        
    }
    
    func hideAll(){
        
        banheiro.zPosition = camadaHide
        erroLabel.zPosition = camadaHide
        popup.zPosition = camadaHide;
        textoFinal.zPosition = camadaHide
        estaNoComodo = comodo.nenhum
        
        for itens in banheiroItems{
            var temp: SKNode = itens
            temp.removeFromParent()
        }
        self.onRoom = false
        self.isFinish = false
    }
    
    func loadGameData(ambiente: String) {
        
        var plist = "null"
        
//        if(ambiente == "quarto"){
//            if banheiro.parent == nil{
//                banheiro.addChild(erroLabel)
//            }
//            plist = "quarto.plist"
//        
//        }
        
        if(ambiente == "banheiro"){
            if erroLabel.parent == nil{
                banheiro.addChild(erroLabel)
            }
            plist = "banheiro.plist"
            estaNoComodo = comodo.banheiro

            
        }
        
//        if(ambiente == "sala"){
//            if erroLabel.parent == nil{
//                banheiro.addChild(erroLabel)
//            }
//            plist = "sala.plist"
//        }
        
//        if(ambiente == "cozinha"){
//            if banheiro.parent == nil{
//                banheiro.addChild(erroLabel)
//            }
//            plist = "cozinha.plist"
//        }
        
        
        var path = documentFilePath(fileName: plist)
        var gameData : NSDictionary? = NSDictionary(contentsOfFile: path)
        // Load gamedata template from mainBundle if no saveFile exists
        if gameData == nil {
            var mainBundle = NSBundle.mainBundle()
            path = mainBundle.pathForResource(ambiente, ofType: "plist")!
            gameData = NSDictionary(contentsOfFile: path)
        }
        
        switch estaNoComodo{
        case comodo.banheiro:
            ativaBanheiro(gameData)
            break
        case comodo.cozinha:
            //                ativaBanheiro(gameData)
            break
        case comodo.cozinha:
            //                ativaBanheiro(gameData)
            break
        case comodo.cozinha:
            //                ativaBanheiro(gameData)
            break
        default:
            break
        }
        

    }
    
    func documentFilePath(#fileName: String) -> String {
        var paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
        var documentsDirectory = paths[0] as! String
        var path = documentsDirectory.stringByAppendingPathComponent(fileName)
        return path
    }
    
    ////////////////////////////// trocar
    
    func gameStateDelegateIncrement() {
            acertos++
        erroLabel.text = String(format: "%i/%i", acertos, erros)
        if(acertos == erros){
            popup.zPosition = camadaFimFase
            textoFinal.zPosition = camadaFimFase
            self.isFinish = true
        }
    }
    
    func gameStateDelegateSetError() {
        erros++
        erroLabel.text = String(format: "%i/%i", acertos, erros)
    }

    //ANIMACAO CASA
    func basicAnimations(){
        
        //NUVENS
        let origin1 = CGPointMake(nuvem1.position.x, nuvem1.position.y)
        let move1 = CGPointMake(self.frame.size.width+nuvem1.size.width/2, nuvem1.position.y)
        
        let origin2 = CGPointMake(nuvem2.position.x, nuvem2.position.y)
        let move2 = CGPointMake(self.frame.size.width+nuvem2.size.width/2, nuvem2.position.y)
        
        let originG1 = CGPointMake(nuvemG1.position.x, nuvemG1.position.y)
        let moveG1 = CGPointMake(self.frame.size.width+nuvemG1.size.width/2, nuvemG1.position.y)
        
        var moveNuvem1 = Array<SKAction>() //Left to Right - Close
        moveNuvem1.append(SKAction.moveTo(move1, duration: 10))
        moveNuvem1.append(SKAction.fadeAlphaTo(0, duration: 0.1))
        moveNuvem1.append(SKAction.moveTo(origin1, duration: 0.1))
        moveNuvem1.append(SKAction.fadeAlphaTo(1, duration: 0.1))
        
        var moveNuvem2 = Array<SKAction>() //Left to Right - Close
        moveNuvem2.append(SKAction.moveTo(move2, duration: 5))
        moveNuvem2.append(SKAction.fadeAlphaTo(0, duration: 0.1))
        moveNuvem2.append(SKAction.moveTo(origin2, duration: 0.1))
        moveNuvem2.append(SKAction.fadeAlphaTo(1, duration: 0.1))
        
        var moveNuvemGrande1 = Array<SKAction>() //Left to Right - Close
        moveNuvemGrande1.append(SKAction.moveTo(moveG1, duration: 20))
        moveNuvemGrande1.append(SKAction.fadeAlphaTo(0, duration: 0.1))
        moveNuvemGrande1.append(SKAction.moveTo(originG1, duration: 0.1))
        moveNuvemGrande1.append(SKAction.fadeAlphaTo(1, duration: 0.1))
        
        nuvem1.runAction(SKAction.repeatActionForever(SKAction.sequence(moveNuvem1)))
        nuvem2.runAction(SKAction.repeatActionForever(SKAction.sequence(moveNuvem2)))
        nuvemG1.runAction(SKAction.repeatActionForever(SKAction.sequence(moveNuvemGrande1)))
        
    }

    
    
    //ATIVA OS CENARIOS
    func ativaBanheiro(gameData: NSDictionary?){
        
        if banheiroItems.count > 0{
            for itens in banheiroItems{
                var temp: SKNode = itens
                banheiro.addChild(temp)
            }
        }
        
        else{
            banheiroItemConfigurations = gameData!["banheiroItemConfigurations"] as! [String: [String: String]]
            //erros = gameData!["erros"] as! Int
            erroLabel.text = String(format: "%i/%i", acertos, erros)
            var banheiroItemDataSet = gameData!["banheiroItemData"] as! [[String: AnyObject]]
            for banheiroItemData in banheiroItemDataSet {
                var itemType = banheiroItemData["type"] as AnyObject? as! String
                var banheiroItemConfiguration = banheiroItemConfigurations[itemType] as [String: String]!
                var banheiroItem = BanheiroItem(banheiroItemData: banheiroItemData, banheiroItemConfiguration: banheiroItemConfiguration, gameStateDelegate: self)
                var relativeX = banheiroItemData["x"] as AnyObject? as! Float
                var relativeY = banheiroItemData["y"] as AnyObject? as! Float
                //            banheiroItem.position = CGPoint(x: Int(relativeX * Float(size.width) - Float(size.width)/2), y: Int(relativeY * Float(size.height) - Float(size.height)/2))
                banheiroItem.position = CGPoint(x: Int(relativeX * Float(size.width)), y: Int(relativeY * Float(size.height)))
                banheiroItem.zPosition = camadaObjects
//                erroLabel.zPosition = camadaPontos
                banheiro.addChild(banheiroItem)
                banheiroItems.append(banheiroItem)
            }
        }
        
        
        
    }


}
