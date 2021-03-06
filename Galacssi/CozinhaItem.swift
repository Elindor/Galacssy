//
//  CozinhaItem.swift
//  TesteSpriteKitMini2
//
//  Created by Gabriel Oliva de Oliveira on 5/26/15.
//  Copyright (c) 2015 gabriel. All rights reserved.
//

import SpriteKit
import AVFoundation

class CozinhaItem : SKNode {
    
    var type : String
    var tile : SKSpriteNode
    var objeto : SKSpriteNode
    var movimento : SKAction
    var isError : Bool
    var msg : String
    var save: SaveHandler = SaveHandler()
    var camada: CasaScene = CasaScene ()
    //var torneira: AVAudioPlayer
    
    private var gameStateDelegate : GameStateDelegate
    
    init(cozinhaItemData: [String: AnyObject], cozinhaItemConfiguration: [String: String], gameStateDelegate: GameStateDelegate, error: Bool) {

        
        isError = error
        
//        var fimFaseSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("waterDropLoop", ofType: "mp3")!) (Comentado, pois nao estava sedo utilizado 24-09-15)
//        torneira = AVAudioPlayer(contentsOfURL: fimFaseSound, error: nil)
//        torneira.volume = 1.0
        
        
        var waterIsOn: Bool = false
        
        
        self.gameStateDelegate = gameStateDelegate
        type = cozinhaItemData["type"] as AnyObject? as! String
        msg = cozinhaItemConfiguration["msg"] as AnyObject? as! String
        objeto = SKSpriteNode()
        movimento = SKAction()
        
        //if type == "luz" {
        if (isError) {
            objeto = SKSpriteNode(imageNamed: "LuzLustre.png")
            objeto.setScale(0.52)
            objeto.position = CGPoint (x: 14.5, y: -292.0)
            tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(110, 70))
        } else {
            tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(110, 70))
        }
        
        if type == "geladeira" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "geladeira.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint (x: -52.0, y: 0.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(225, 575))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(225, 575))
            }
            
        } else if type == "torneira" {
            
            if isError {
                save.torneiraLigada()
                objeto = SKSpriteNode(imageNamed: "gota.png")
                objeto.setScale(0.3)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(50, 85))
                waterIsOn = true
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(50, 85))
            }
            
        }  else if type == "microondas" {
            
            if isError {
                objeto = SKSpriteNode(imageNamed: "portamicroondas.png")
                objeto.setScale(0.5)
                objeto.position = CGPoint(x: -26.5, y: -1.0)
                tile = SKSpriteNode(color: SKColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(167, 100))
            } else {
                tile = SKSpriteNode(color: SKColor(red: 0/255.0, green: 255/255.0, blue: 0/255.0, alpha: 0.0), size: CGSizeMake(167, 100))
            }
            
        }
        
        super.init()

        if waterIsOn{
            
            waterLoop(objeto: objeto)
            
        }
        
        userInteractionEnabled = true
        
        addChild(tile)
        addChild(objeto)
        
        if isError {
            gameStateDelegate.gameStateDelegateSetError()
        }
        
    }
    
    func waterLoop(objeto objeto: SKSpriteNode){
        objeto.alpha = 1
        objeto.position = CGPoint(x: 16.0, y: -3.0)
        movimento = SKAction.moveToY(-33.0, duration: 0.5)
        let fade = SKAction.fadeOutWithDuration(0.7)
        fade.timingMode = SKActionTimingMode.EaseIn
        objeto.runAction(fade)
        objeto.runAction(movimento, completion:{
            if self.save.musicIsOn(){
                let audio = SKAction.playSoundFileNamed("Droplet.wav", waitForCompletion: false)
                self.runAction(audio)
            }
            objeto.runAction(SKAction.waitForDuration(0.5), completion:{                
                self.waterLoop(objeto: objeto)
            })
            
        })
        
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        let touch = touches.first
        let touchLocation = touch!.locationInNode(self)
        
        if (isError && tile.containsPoint(touchLocation)) {
            

            if gameStateDelegate.gameStateDelegateIncrement(msg, node: self) {
                isError = false
                
                save.audioObjetos(type)
            }
        }
        
    }
    
    func displayAlert (msg:String, viewController : UIViewController) {
//        let alert = UIAlertView(title: "Você sabia?", message: msg, delegate: self, cancelButtonTitle: "OK")
//        alert.show()
        let alert = UIAlertController(title: "Você sabia?", message: msg, preferredStyle: .Alert)
        let cancelAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.Cancel) { UIAlertAction in }
        alert.addAction(cancelAction)
        viewController.presentViewController(alert, animated: true, completion: {})
    }
    
    
}

