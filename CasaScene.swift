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
    
    var erros = 0
    var acertos = 0
    var onRoom: Bool = false
    
    var banheiro = SKSpriteNode()
    var background = SKSpriteNode()
    var popup = SKSpriteNode()
    
    var banheiroItems = [BanheiroItem]()
    var banheiroItemConfigurations = [String: [String: NSNumber]]()
    
    var erroLabel = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    let textoFinal = SKLabelNode(fontNamed: "TrebuchetMS-Bold")
    
    
    override func didMoveToView(view: SKView) {
        /* Setup your scene here */
        
        // Create banheiro
        banheiro = SKSpriteNode(imageNamed: "banheiro.jpg")
        banheiro.size.height = size.height
        banheiro.size.width = size.width
        //banheiro.position = CGPoint(x: size.width/2, y: size.height/2)
        banheiro.anchorPoint = CGPointZero
        addChild(banheiro)
        
        popup = SKSpriteNode(imageNamed: "popup.png")
        popup.setScale(0.5)
        popup.zPosition = CGFloat(0)
        popup.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        addChild(popup)
        
        // Draw background
        background = SKSpriteNode(imageNamed: "casa_placeholder")
        background.size.height = size.height
        background.size.width = size.width
        background.position = CGPoint(x: size.width/2, y: size.height/2)
        background.zPosition = CGFloat(1)
        addChild(background)
        
        erroLabel.horizontalAlignmentMode = SKLabelHorizontalAlignmentMode.Left
        erroLabel.verticalAlignmentMode = SKLabelVerticalAlignmentMode.Top
        erroLabel.position = CGPoint(x: 300, y: size.height - 30)
        erroLabel.color = SKColor(red: 30/255.0, green: 30/255.0, blue: 175/255.0, alpha: 1.0)
        erroLabel.colorBlendFactor = 1.0
        erroLabel.fontSize = 50
        banheiro.addChild(erroLabel)
        
        textoFinal.text = "PARABÉNS"
        textoFinal.fontColor = SKColor.blackColor()
        textoFinal.fontSize = 20
        popup.zPosition = CGFloat(0)
        textoFinal.position = CGPoint(x:CGRectGetMidX(self.frame), y:CGRectGetMidY(self.frame))
        self.addChild(textoFinal)

        
        
        
        loadGameData()
        
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
        
        if (background.containsPoint(touchLocation) && !self.onRoom){
            println("Chama Cena Banheiro")
            banheiro.zPosition = CGFloat(1);
            background.zPosition = CGFloat(0);
            erroLabel.zPosition = CGFloat(1);
            if(acertos == erros){
                self.onRoom = true
            }
        }
        
        else if(banheiro.containsPoint(touchLocation) || popup.containsPoint(touchLocation) && self.onRoom){
            banheiro.zPosition = CGFloat(0);
            background.zPosition = CGFloat(1);
            erroLabel.zPosition = CGFloat(0);
            popup.zPosition = CGFloat(0);
            textoFinal.zPosition = CGFloat(0);
            self.onRoom = false
        }
    }
    
    func loadGameData() {
        var path = documentFilePath(fileName: "banheiro.plist")
        var gameData : NSDictionary? = NSDictionary(contentsOfFile: path)
        // Load gamedata template from mainBundle if no saveFile exists
        if gameData == nil {
            var mainBundle = NSBundle.mainBundle()
            path = mainBundle.pathForResource("banheiro", ofType: "plist")!
            gameData = NSDictionary(contentsOfFile: path)
        }
        
        banheiroItemConfigurations = gameData!["banheiroItemConfigurations"] as! [String: [String: NSNumber]]
        //erros = gameData!["erros"] as! Int
        erroLabel.text = String(format: "%i/%i", acertos, erros)
        var banheiroItemDataSet = gameData!["banheiroItemData"] as! [[String: AnyObject]]
        for banheiroItemData in banheiroItemDataSet {
            var itemType = banheiroItemData["type"] as AnyObject? as! String
            var banheiroItemConfiguration = banheiroItemConfigurations[itemType] as [String: NSNumber]!
            var banheiroItem = BanheiroItem(banheiroItemData: banheiroItemData, banheiroItemConfiguration: banheiroItemConfiguration, gameStateDelegate: self)
            var relativeX = banheiroItemData["x"] as AnyObject? as! Float
            var relativeY = banheiroItemData["y"] as AnyObject? as! Float
//            banheiroItem.position = CGPoint(x: Int(relativeX * Float(size.width) - Float(size.width)/2), y: Int(relativeY * Float(size.height) - Float(size.height)/2))
            banheiroItem.position = CGPoint(x: Int(relativeX * Float(size.width)), y: Int(relativeY * Float(size.height)))
            banheiroItem.zPosition = CGFloat(1)
            banheiro.addChild(banheiroItem)
            banheiroItems.append(banheiroItem)
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
            popup.zPosition = CGFloat(2)
            textoFinal.zPosition = CGFloat(3)
        }
    }
    
    func gameStateDelegateSetError() {
        erros++
        erroLabel.text = String(format: "%i/%i", acertos, erros)
    }
}
