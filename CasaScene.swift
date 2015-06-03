//
//  CasaScene.swift
//  Galacssi
//
//  Created by Gabriela  Gomes Pires on 26/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import SpriteKit
import AVFoundation

/* Cenário: Casa. É o cenário em que o jogador deve combater os desperdícios que ocorrem na casa. */

class CasaScene: SKScene, GameStateDelegate {
    
    var save: SaveHandler = SaveHandler()
    
    let barrasProgresso = [
        "barraProgresso1.png",
        "barraProgresso2.png",
        "barraProgresso3.png",
        "barraProgresso4.png"
    ]
    
    var a = 0
    
    enum comodo : Int {
        //nothing
        case nenhum = 0
        case banheiro = 1
        case sala = 2
        case quarto = 3
        case cozinha = 4
    }
    
//    var erros = 0
    var errosBanheiro = 0
    var errosSala = 0
    var errosQuarto = 0
    var errosCozinha = 0
    
//    var acertos = 0
    var acertosBanheiro = 0
    var acertosSala = 0
    var acertosQuarto = 0
    var acertosCozinha = 0
    
    var onRoom: Bool = false
    var isFinish = false
    var isItem = false
    
    //CAMADAS
    var camadaHide:CGFloat = 0
    var camadaMenu:CGFloat = 1
    var camadaButtons:CGFloat = 2
    var camadaAmbiente:CGFloat = 3
    var camadaObjects:CGFloat = 4
    var camadaPontos:CGFloat = 5
    var camadaPontosMask:CGFloat = 6
    var camadaFimFase:CGFloat = 7
    var camadaFimTexto:CGFloat = 8
    
    var camadaItem:CGFloat = 15
    var camadaItemTexto:CGFloat = 16
    
    //AMBIENTES
    var banheiro = SKSpriteNode()
    var sala = SKSpriteNode()
    var quarto = SKSpriteNode()
    var cozinha = SKSpriteNode()
    var quartoButton = SKSpriteNode()
    var banheiroButton = SKSpriteNode()
    var salaButton = SKSpriteNode()
    var cozinhaButton = SKSpriteNode()
    var background = SKSpriteNode()
    var voltarButton = SKSpriteNode()
    var sky = SKSpriteNode()
    
    //CHECKING
    var checkQuarto = SKSpriteNode(imageNamed: "btnCheck.png")
    var checkBanheiro = SKSpriteNode(imageNamed: "btnCheck.png")
    var checkSala = SKSpriteNode(imageNamed: "btnCheck.png")
    var checkCozinha = SKSpriteNode(imageNamed: "btnCheck.png")
    
    var estaNoComodo = comodo.nenhum
    
    //OBJETOS ANIMADOS
    let nuvem1 = SKSpriteNode(imageNamed: "nuvem1.png")
    let nuvem2 = SKSpriteNode(imageNamed: "nuvem2.png")
    let nuvemG1 = SKSpriteNode(imageNamed: "nuvem1.png")
    
    var popup = SKSpriteNode()
    
    var banheiroItems = [BanheiroItem]()
    var banheiroItemConfigurations = [String: [String: String]]()
    var salaItems = [SalaItem]()
    var salaItemConfigurations = [String: [String: String]]()
    var quartoItems = [QuartoItem]()
    var quartoItemConfigurations = [String: [String: String]]()
    var cozinhaItems = [CozinhaItem]()
    var cozinhaItemConfigurations = [String: [String: String]]()

    //var erroLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    //let textoFinal = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    
    var popupItem = SKSpriteNode()
    //var textoItem = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    var textoItem = SKNode()
    
    var barra = SKSpriteNode()
    //var mask = SKSpriteNode()
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
//        var musicaDeFundo = SKAction.playSoundFileNamed("Musica.mp3", waitForCompletion: true)
//        self.runAction(SKAction.repeatActionForever(musicaDeFundo))
        if(!save.musicIsOn()){
            save.playAudio()
        }

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
        
        voltarButton = SKSpriteNode(imageNamed: "btnVoltar.png")
        voltarButton.setScale(0.5)
        voltarButton.position = CGPointMake(40,730);
        voltarButton.zPosition = CGFloat(10)
        addChild(voltarButton)
        
        //Create Checks
        checkQuarto.position = CGPoint(x: 190, y: 520)
        checkQuarto.xScale = 0.25
        checkQuarto.yScale = 0.25
        checkQuarto.zPosition = camadaHide
        addChild(checkQuarto)
        
        checkBanheiro.position = CGPoint(x: 550, y: 520)
        checkBanheiro.xScale = 0.25
        checkBanheiro.yScale = 0.25
        checkBanheiro.zPosition = camadaHide
        addChild(checkBanheiro)
        
        checkSala.position = CGPoint(x: 190, y: 240)
        checkSala.xScale = 0.25
        checkSala.yScale = 0.25
        checkSala.zPosition = camadaHide
        addChild(checkSala)
        
        checkCozinha.position = CGPoint(x: 505, y: 240)
        checkCozinha.xScale = 0.25
        checkCozinha.yScale = 0.25
        checkCozinha.zPosition = camadaHide
        addChild(checkCozinha)
        
        
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
        banheiro = SKSpriteNode(imageNamed: "Banheiro.png")
        banheiro.size.height = size.height
        banheiro.size.width = size.width
        //banheiro.position = CGPoint(x: size.width/2, y: size.height/2)
        banheiro.anchorPoint = CGPointZero
        addChild(banheiro)
        
        // Create sala
        sala = SKSpriteNode(imageNamed: "Sala.png")
        sala.size.height = size.height
        sala.size.width = size.width
        sala.anchorPoint = CGPointZero
        addChild(sala)
        
        // Create quarto
        quarto = SKSpriteNode(imageNamed: "Quarto.png")
        quarto.size.height = size.height
        quarto.size.width = size.width
        quarto.anchorPoint = CGPointZero
        addChild(quarto)
        
        // Create cozinha
        cozinha = SKSpriteNode(imageNamed: "Cozinha.png")
        cozinha.size.height = size.height
        cozinha.size.width = size.width
        cozinha.anchorPoint = CGPointZero
        addChild(cozinha)
        
        // Create popup
        let defaults = NSUserDefaults.standardUserDefaults()
        a = defaults.integerForKey("personagem")
        if a == 1 {
            popup = SKSpriteNode(imageNamed: "popupFimMenina.png")
        } else {
            popup = SKSpriteNode(imageNamed: "popupFim.png")
        }
        popup.setScale(0.5)
        popup.zPosition = camadaHide
        if a == 1 {
            popup.position = CGPoint(x:CGFloat(CGRectGetMidX(self.frame)+10), y:CGFloat(CGRectGetMidY(self.frame)-11))
        } else {
            popup.position = CGPoint(x:CGFloat(CGRectGetMidX(self.frame)), y:CGFloat(CGRectGetMidY(self.frame)-10.5))
        }
        
        addChild(popup)
        
        // Create popup de itens
        //var a = save.getCurrentCharacter()
        if a == 1 {
            popupItem = SKSpriteNode(imageNamed: "popupItemMenina.png")
        } else {
            popupItem = SKSpriteNode(imageNamed: "popupItem.png")
        }
        popupItem.setScale(0.5)
        popupItem.zPosition = camadaHide
        popupItem.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(popupItem)
        
        // Draw background
        background = SKSpriteNode(imageNamed: "menuCasa")
        background.size.height = size.height
        background.size.width = size.width
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = camadaMenu
        addChild(background)
        
        /*erroLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        erroLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        erroLabel.position = CGPoint(x: 300, y: size.height - 30)
        erroLabel.color = SKColor(red: 30/255.0, green: 30/255.0, blue: 175/255.0, alpha: 1.0)
        erroLabel.colorBlendFactor = 1.0
        erroLabel.fontSize = 50
//        banheiro.addChild(erroLabel)*/
        
        //BARRA DE PROGRESSÃO DO BANHEROa
        barra = SKSpriteNode()
        barra.size.height = 40
        barra.size.width = 200
        barra.texture = SKTexture(imageNamed: barrasProgresso[0])
        barra.position = CGPoint(x: 250, y: size.height - 35)
        //mask = SKSpriteNode(color: UIColor.blueColor(), size: CGSizeMake(5, 17))
        //mask.position = CGPoint(x: 234, y: size.height - 51)
        //mask.zPosition = cama
        banheiro.addChild(barra)
        //banheiro.addChild(mask)
        
        //textoFinal.text = "PARABÉNS"
        //textoFinal.fontColor = SKColor.blackColor()
        //textoFinal.fontSize = 20
        //popup.zPosition = camadaHide
        //textoFinal.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        //self.addChild(textoFinal)
        
        //textoItem.text = ""
        //textoItem.fontColor = SKColor.blackColor()
        //textoItem.fontSize = 20
        textoItem.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        //textoItem.
        self.addChild(textoItem)

        // Draw Sky
        var temp = SKSpriteNode(color: UIColor(red: 62.0/255, green: 205.0/255, blue: 1, alpha: 1), size: CGSize(width: self.frame.width,height: self.frame.height))
        sky = temp
        sky.anchorPoint = CGPointZero
        sky.zPosition = camadaMenu
        addChild(sky)
        
        basicAnimations()
        
    }
    
    override func touchesBegan(touches: Set<NSObject>, withEvent event: UIEvent) {
        
        if isItem {
            
            isItem = false
            popupItem.zPosition = camadaHide
            textoItem.zPosition = camadaHide
            textoItem.removeAllChildren()
            
        } else {
           
            /* Called when a touch begins */
            let touch = touches.first as! UITouch
            let touchLocation = touch.locationInNode(self)
            
            callScene(touchLocation)
            
        }
    }
    
    override func update(currentTime: CFTimeInterval) {
        /* Called before each frame is rendered */
    }
    
    func callScene(touchLocation: CGPoint){
        
        //VERIFICA SE TOCOU NO AMBIENTE
        if(banheiroButton.containsPoint(touchLocation) && !self.onRoom){
            self.onRoom = true
            println("Chama Cena Banheiro")
            loadGameData("banheiro")
            banheiro.zPosition = camadaAmbiente
            barra.zPosition = camadaPontos
            barra.texture = SKTexture(imageNamed: barrasProgresso[acertosBanheiro])
            //mask.zPosition = camadaPontosMask
            //mask.size.width = CGFloat(54 * acertosBanheiro + 5)
            //mask.position = CGPoint(x: CGFloat(234 + 27 * acertosBanheiro), y: mask.position.y)
            
        }
        else if(salaButton.containsPoint(touchLocation) && !self.onRoom){
            self.onRoom = true
            println("Chama Cena Sala")
            loadGameData("sala")
            sala.zPosition = camadaAmbiente
            barra.zPosition = camadaPontos
            barra.texture = SKTexture(imageNamed: barrasProgresso[acertosSala])
            //mask.zPosition = camadaPontosMask
            //mask.size.width = CGFloat(54 * acertosSala + 5)
            //mask.position = CGPoint(x: CGFloat(234 + 27 * acertosSala), y: mask.position.y)
        }
        else if(quartoButton.containsPoint(touchLocation) && !self.onRoom){
            self.onRoom = true
            println("Chama Cena Quarto")
            loadGameData("quarto")
            quarto.zPosition = camadaAmbiente
            barra.zPosition = camadaPontos
            barra.texture = SKTexture(imageNamed: barrasProgresso[acertosQuarto])
            //mask.zPosition = camadaPontosMask
            //mask.size.width = CGFloat(54 * acertosQuarto + 5)
            //mask.position = CGPoint(x: CGFloat(234 + 27 * acertosQuarto), y: mask.position.y)
        }
        else if(cozinhaButton.containsPoint(touchLocation) && !self.onRoom){
            self.onRoom = true
            println("Chama Cena Cozinha")
            loadGameData("cozinha")
            cozinha.zPosition = camadaAmbiente
            barra.zPosition = camadaPontos
            barra.texture = SKTexture(imageNamed: barrasProgresso[acertosCozinha])
            //mask.zPosition = camadaPontosMask
            //mask.size.width = CGFloat(54 * acertosCozinha + 5)
            //mask.position = CGPoint(x: CGFloat(234 + 27 * acertosCozinha), y: mask.position.y)
        }
            
        //ATIVA A VOLTA PARA A CASA ATRAVES DO BOTAO DE VOLTAR
        else if (voltarButton.containsPoint(touchLocation) && self.onRoom){
            callChecks()
            hideAll()
            background.zPosition = camadaMenu
            if (cozinha == camadaAmbiente){
                save.torneira.stop()
            }
        }
            
        //ATIVA A VOLTA PARA A CIDADE ATRAVES DO BOTAO DE VOLTAR
        else if (voltarButton.containsPoint(touchLocation) || sky.containsPoint(touchLocation) && !self.onRoom){
            println("Chama Mapa")
            let transition = SKTransition()
            let cenarioMapa = GameScene(size: self.size)
            cenarioMapa.scaleMode = SKSceneScaleMode.AspectFill
            self.scene!.view?.presentScene(cenarioMapa, transition: transition)
        }
    }
    
    func hideAll(){
        
        banheiro.zPosition = camadaHide
        sala.zPosition = camadaHide
        quarto.zPosition = camadaHide
        cozinha.zPosition = camadaHide
        barra.zPosition = camadaHide
        //mask.zPosition = camadaHide
        popup.zPosition = camadaHide;
        //textoFinal.zPosition = camadaHide
        textoItem.zPosition = camadaHide
        estaNoComodo = comodo.nenhum
        
        
        //REMOVE OBJETOS DOS AMBIENTES
        for itens in banheiroItems{
            var temp: SKNode = itens
            temp.removeFromParent()
        }
        for itens in salaItems{
            var temp: SKNode = itens
            temp.removeFromParent()
        }
        for itens in cozinhaItems{
            var temp: SKNode = itens
            temp.removeFromParent()
        }
        for itens in quartoItems{
            var temp: SKNode = itens
            temp.removeFromParent()
        }
        self.onRoom = false

    }
    
    func loadGameData(ambiente: String) {
        
        var plist = "null"
        
        if(ambiente == "quarto"){
            if barra.parent == nil{
                quarto.addChild(barra)
                //quarto.addChild(mask)
            }
            plist = "quarto.plist"
            estaNoComodo = comodo.quarto
        }
        
        if(ambiente == "banheiro"){
            if barra.parent == nil{
                banheiro.addChild(barra)
                //banheiro.addChild(mask)
            }
            plist = "banheiro.plist"
            estaNoComodo = comodo.banheiro
        }
        
        
        if(ambiente == "sala"){
            if barra.parent == nil {
                sala.addChild(barra)
                //sala.addChild(mask)
            }
            plist = "sala.plist"
            estaNoComodo = comodo.sala
        }
        
       if(ambiente == "cozinha"){
           if barra.parent == nil{
            cozinha.addChild(barra)
            //cozinha.addChild(mask)
            }
            plist = "cozinha.plist"
            estaNoComodo = comodo.cozinha
       }
        
        
        var path = documentFilePath(fileName: plist)
        var gameData : NSDictionary? = NSDictionary(contentsOfFile: path)
        // Load gamedata template from mainBundle if no saveFile exists
        if gameData == nil {
            var mainBundle = NSBundle.mainBundle()
            path = mainBundle.pathForResource(ambiente, ofType: "plist")!
            gameData = NSDictionary(contentsOfFile: path)
        }
        
        let diceRoll = Int(arc4random_uniform(4))+1
        
        //ATIVA OS OBJETOS DO AMBIENTE
        switch estaNoComodo{
        case comodo.banheiro:
            ativaBanheiro(gameData, diceRoll: diceRoll)
            break
        case comodo.sala:
            ativaSala(gameData, diceRoll: diceRoll)
            break
        case comodo.cozinha:
            ativaCozinha(gameData, diceRoll: diceRoll)
            break
        case comodo.quarto:
            ativaQuarto(gameData, diceRoll: diceRoll)
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
    
    //ADICIONA OS ACERTOS DO AMBIENTE
    func gameStateDelegateIncrement(mensagem: String, node: SKNode) -> Bool{
        
        if !isItem {
            
            var posX : CGFloat = 0.0
            if a == 1 {
                posX = 100.0
            } else {
                posX = 70.0
            }
           
            switch estaNoComodo{
            case comodo.banheiro:
                acertosBanheiro++
                barra.texture = SKTexture(imageNamed: barrasProgresso[acertosBanheiro])
                break
            case comodo.cozinha:
                acertosCozinha++
                barra.texture = SKTexture(imageNamed: barrasProgresso[acertosCozinha])
                //mask.size.width = CGFloat(54 * acertosCozinha + 5)
                //mask.position = CGPoint(x: CGFloat(234 + 27 * acertosCozinha), y: mask.position.y)
                break
            case comodo.sala:
                acertosSala++
                barra.texture = SKTexture(imageNamed: barrasProgresso[acertosSala])
                //mask.size.width = CGFloat(54 * acertosSala + 5)
                //mask.position = CGPoint(x: CGFloat(234 + 27 * acertosSala), y: mask.position.y)
                break
            case comodo.quarto:
                acertosQuarto++
                barra.texture = SKTexture(imageNamed: barrasProgresso[acertosQuarto])
                //mask.size.width = CGFloat(54 * acertosQuarto + 5)
                //mask.position = CGPoint(x: CGFloat(234 + 27 * acertosQuarto), y: mask.position.y)
                break
            default:
                break
            }
            //            acertos++
            node.removeAllChildren()
            var tamanho = count(mensagem)
            if tamanho > 30 {
                
                println("Entrou no if")
                
                var isOver = false
                var pos : CGFloat =  0.0
                var corte = 30
                var texto = mensagem
                
                popupItem.zPosition = camadaItem
                textoItem.zPosition = camadaItemTexto
                isItem = true
                
                
                while !isOver {
                    
                    println("Passou no while com texto: \(texto)")
                    
                    var label = SKLabelNode(fontNamed: "Bariol-Regular")
                    label.fontColor = SKColor.blackColor()
                    label.fontSize = 25
                    label.text = texto.substringToIndex(advance(texto.startIndex, 30))
                    
                    label.position = CGPoint(x:posX, y:0 - pos)
                    pos += 30
                    //label.zPosition = camadaItemTexto + 15
                    textoItem.addChild(label)
                    texto = texto.substringFromIndex(advance(texto.startIndex,30))
                    if count(texto) < 30 {
                        var label2 = SKLabelNode(fontNamed: "Bariol-Regular")
                        label2.fontColor = SKColor.blackColor()
                        label2.fontSize = 25
                        label2.text = texto.substringToIndex(advance(texto.startIndex, count(texto)))
                        label2.position = CGPoint(x:posX, y:0 - pos)
                        textoItem.addChild(label2)
                        isOver = true
                    }
                }
                
            } else {
                
                var label = SKLabelNode(fontNamed: "Bariol-Regular")
                label.fontColor = SKColor.blackColor()
                label.fontSize = 25
                label.text = mensagem
                label.position = CGPoint(x:posX, y:0)
                textoItem.addChild(label)
            }
            
            callWinner()
            
            return true
        }
        
        return false
    }
    
    //DEFINE QUANTIDADE DE ERROS DO AMBIENTE
    func gameStateDelegateSetError() {
        switch estaNoComodo{
        case comodo.banheiro:
            errosBanheiro++
            break
        case comodo.cozinha:
            errosCozinha++
            break
        case comodo.sala:
            errosSala++
            break
        case comodo.quarto:
            errosQuarto++
            break
        default:
            break
        }

//        erros++
//        println("Erros: \(erros)")
//        erroLabel.text = String(format: "%i/%i", acertos, erros)
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
    func ativaBanheiro(gameData: NSDictionary?, diceRoll: Int){
        
        if banheiroItems.count > 0{
            for itens in banheiroItems{
                
                var temp: SKNode = itens
                banheiro.addChild(temp)
            }
        }
        
        else{
            banheiroItemConfigurations = gameData!["banheiroItemConfigurations"] as! [String: [String: String]]
            //erros = gameData!["erros"] as! Int
            //erroLabel.text = String(format: "%i/%i", acertos, erros)
            var banheiroItemDataSet = gameData!["banheiroItemData"] as! [[String: AnyObject]]
            var auxErrosBanheiro = 0
            let diceRollBanheiro = Int(arc4random_uniform(2))+1
            for banheiroItemData in banheiroItemDataSet {
                var isError : Bool
                auxErrosBanheiro++
                if auxErrosBanheiro == diceRollBanheiro {
                    isError = false
                } else {
                    isError = true
                }
                var itemType = banheiroItemData["type"] as AnyObject? as! String
                var banheiroItemConfiguration = banheiroItemConfigurations[itemType] as [String: String]!
                var banheiroItem = BanheiroItem(banheiroItemData: banheiroItemData, banheiroItemConfiguration: banheiroItemConfiguration, gameStateDelegate: self, error: isError)
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

    func ativaSala(gameData: NSDictionary?, diceRoll: Int){
        
        if salaItems.count > 0{
            for itens in salaItems{
                var temp: SKNode = itens
                sala.addChild(temp)
            }
        }
            
        else{
            salaItemConfigurations = gameData!["salaItemConfigurations"] as! [String: [String: String]]
            //erros = gameData!["erros"] as! Int
            //erroLabel.text = String(format: "%i/%i", acertos, erros)
            var salaItemDataSet = gameData!["salaItemData"] as! [[String: AnyObject]]
            var auxErrosSala = 0
            for salaItemData in salaItemDataSet {
                var isError : Bool
                auxErrosSala++
                if auxErrosSala == diceRoll {
                    isError = false
                } else {
                    isError = true
                }
                var itemType = salaItemData["type"] as AnyObject? as! String
                var salaItemConfiguration = salaItemConfigurations[itemType] as [String: String]!
                var salaItem = SalaItem(salaItemData: salaItemData, salaItemConfiguration: salaItemConfiguration, gameStateDelegate: self, error: isError)
                var relativeX = salaItemData["x"] as AnyObject? as! Float
                var relativeY = salaItemData["y"] as AnyObject? as! Float
                //            banheiroItem.position = CGPoint(x: Int(relativeX * Float(size.width) - Float(size.width)/2), y: Int(relativeY * Float(size.height) - Float(size.height)/2))
                salaItem.position = CGPoint(x: Int(relativeX * Float(size.width)), y: Int(relativeY * Float(size.height)))
                salaItem.zPosition = camadaObjects
                //                erroLabel.zPosition = camadaPontos
                sala.addChild(salaItem)
                salaItems.append(salaItem)
            }
        }
    }
    
    func ativaCozinha(gameData: NSDictionary?, diceRoll: Int){
        
        if cozinhaItems.count > 0{
            for itens in cozinhaItems{
                var temp: SKNode = itens
                cozinha.addChild(temp)
                
            }
        }
            
        else{
            cozinhaItemConfigurations = gameData!["cozinhaItemConfigurations"] as! [String: [String: String]]
            //erros = gameData!["erros"] as! Int
            //erroLabel.text = String(format: "%i/%i", acertos, erros)
            var cozinhaItemDataSet = gameData!["cozinhaItemData"] as! [[String: AnyObject]]
            var auxErrosCozinha = 0
            for cozinhaItemData in cozinhaItemDataSet {
                var isError : Bool
                auxErrosCozinha++
                if auxErrosCozinha == diceRoll {
                    isError = false
                } else {
                    isError = true
                }
                var itemType = cozinhaItemData["type"] as AnyObject? as! String
                var cozinhaItemConfiguration = cozinhaItemConfigurations[itemType] as [String: String]!
                var cozinhaItem = CozinhaItem(cozinhaItemData: cozinhaItemData, cozinhaItemConfiguration: cozinhaItemConfiguration, gameStateDelegate: self, error: isError)
                var relativeX = cozinhaItemData["x"] as AnyObject? as! Float
                var relativeY = cozinhaItemData["y"] as AnyObject? as! Float
                //            banheiroItem.position = CGPoint(x: Int(relativeX * Float(size.width) - Float(size.width)/2), y: Int(relativeY * Float(size.height) - Float(size.height)/2))
                cozinhaItem.position = CGPoint(x: Int(relativeX * Float(size.width)), y: Int(relativeY * Float(size.height)))
                cozinhaItem.zPosition = camadaObjects
                //                erroLabel.zPosition = camadaPontos
                cozinha.addChild(cozinhaItem)
                cozinhaItems.append(cozinhaItem)
            }
        }
    }
    
    func ativaQuarto(gameData: NSDictionary?, diceRoll: Int){
        
        if quartoItems.count > 0{
            for itens in quartoItems{
                var temp: SKNode = itens
                quarto.addChild(temp)
            }
        }
            
        else{
            quartoItemConfigurations = gameData!["quartoItemConfigurations"] as! [String: [String: String]]
            //erros = gameData!["erros"] as! Int
            //erroLabel.text = String(format: "%i/%i", acertos, erros)
            var quartoItemDataSet = gameData!["quartoItemData"] as! [[String: AnyObject]]
            var auxErrosQuarto = 0
            for quartoItemData in quartoItemDataSet {
                var isError : Bool
                auxErrosQuarto++
                if auxErrosQuarto == diceRoll {
                    isError = false
                } else {
                    isError = true
                }
                var itemType = quartoItemData["type"] as AnyObject? as! String
                var quartoItemConfiguration = quartoItemConfigurations[itemType] as [String: String]!
                var quartoItem = QuartoItem(quartoItemData: quartoItemData, quartoItemConfiguration: quartoItemConfiguration, gameStateDelegate: self, error: isError)
                var relativeX = quartoItemData["x"] as AnyObject? as! Float
                var relativeY = quartoItemData["y"] as AnyObject? as! Float
                //            banheiroItem.position = CGPoint(x: Int(relativeX * Float(size.width) - Float(size.width)/2), y: Int(relativeY * Float(size.height) - Float(size.height)/2))
                quartoItem.position = CGPoint(x: Int(relativeX * Float(size.width)), y: Int(relativeY * Float(size.height)))
                quartoItem.zPosition = camadaObjects
                //                erroLabel.zPosition = camadaPontos
                quarto.addChild(quartoItem)
                quartoItems.append(quartoItem)
            }
        }
    }
    
    
        
    
    //VERIFICA SE TERMINOU O AMBIENTE E ATIVA POPUP DE PARABENS
    func callWinner(){
        switch estaNoComodo{
        case comodo.banheiro:
            if(acertosBanheiro == errosBanheiro && checkBanheiro.zPosition == camadaHide){
                var audiFimFase = SKAction.playSoundFileNamed("brilinho3.mp3", waitForCompletion: false)
                self.runAction(audiFimFase)
                //save.audioFimFase()
                popup.zPosition = camadaFimFase
                //textoFinal.zPosition = camadaFimTexto
            }
            break
        case comodo.cozinha:
            if(acertosCozinha == errosCozinha && checkCozinha.zPosition == camadaHide){
                var audiFimFase = SKAction.playSoundFileNamed("brilinho3.mp3", waitForCompletion: false)
                self.runAction(audiFimFase)
                //save.audioFimFase()
                popup.zPosition = camadaFimFase
                //textoFinal.zPosition = camadaFimTexto
            }
            break
        case comodo.sala:
            if(acertosSala == errosSala && checkSala.zPosition == camadaHide){
                var audiFimFase = SKAction.playSoundFileNamed("brilinho3.mp3", waitForCompletion: false)
                self.runAction(audiFimFase)
                //save.audioFimFase()
                popup.zPosition = camadaFimFase
                //textoFinal.zPosition = camadaFimTexto
            }
            break
        case comodo.quarto:
            if(acertosQuarto == errosQuarto && checkQuarto.zPosition == camadaHide){
                var audiFimFase = SKAction.playSoundFileNamed("brilinho3.mp3", waitForCompletion: false)
                self.runAction(audiFimFase)
                //save.audioFimFase()
                popup.zPosition = camadaFimFase
                //textoFinal.zPosition = camadaFimTexto
            }
            break
        default:
            break
        }
    }
    
    //VERIFICA SE PODE ATIVAR O CHECK DOS AMBIENTES
    func callChecks(){
        
        if(acertosBanheiro == errosBanheiro && acertosBanheiro != 0){
            checkBanheiro.zPosition = camadaButtons
        }
        
        if(acertosCozinha == errosCozinha && acertosCozinha != 0){
            checkCozinha.zPosition = camadaButtons
        }
        
        if(acertosSala == errosSala && acertosSala != 0){
            checkSala.zPosition = camadaButtons
        }
        
        if(acertosQuarto == errosQuarto && acertosQuarto != 0){
            checkQuarto.zPosition = camadaButtons
        }
 
    }

}
