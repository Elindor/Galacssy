//
//  SaveHandler.swift
//  Galacssi
//
//  Created by Gabriel Nopper on 25/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import Foundation
import AVFoundation

class SaveHandler {
    
    var fimFaseSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("waterDropLoop", ofType: "mp3")!)
     var radioLigadoSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("RadioOn", ofType: "mp3")!)
    var gameSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Musica", ofType: "mp3")!)
    var audioPlayer = AVAudioPlayer()
    var torneira = AVAudioPlayer()
    var radio = AVAudioPlayer()
    var tempArray:Array<Save> = [];
    //var savedFile: Save
    
        init(){
    
            // encontra endereços de save.
//            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
//            let documentsDirectory = paths[0] as! String
//            let path = documentsDirectory.stringByAppendingPathComponent("Saves.plist")
            let documentsURL = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let fileURL = documentsURL.URLByAppendingPathComponent("Saves.plist")
            let path = fileURL.path!
            let fileManager = NSFileManager.defaultManager()
    
            // Verifica a existencia de um arquivo anterior
            if !fileManager.fileExistsAtPath(path) {
                // Cria o arquivo no caso da não existencia
                if let bundle = NSBundle.mainBundle().pathForResource("DefaultFile", ofType: "plist") {
                    do {
                        try fileManager.copyItemAtPath(bundle, toPath: path)
                    } catch _ {
                    }
                }
            }
    
            // Verifica se há algum conteudo no arquivo de saves.
//            if let rawData = NSData(contentsOfFile: path) {
                // Em caso positivo, le conteudo
//                var scoreArray: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(rawData); //(Comentado, pois nao estava sendo utilizado 24-09-15)
                //self.tempArray = scoreArray as? [Save] ?? []
                //self.savedFile = self.tempArray[0]
//            }
    
            if tempArray.isEmpty{
                let newHighScore = Save(playerNum: 0, name: "Nome")
                self.tempArray.append(newHighScore)

            }
            
            let new: Save = self.tempArray.first!
            new.updateTimeFactor()
            
        }
    
    func save() {
        // find the save directory our app has permission to use, and save the serialized version of self.scores - the HighScores array.
        let saveData = NSKeyedArchiver.archivedDataWithRootObject(self.tempArray)
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as NSArray;
        let documentsDirectory = paths.objectAtIndex(0) as! NSString
        let path = documentsDirectory.stringByAppendingPathComponent("Saves.plist")
        
        saveData.writeToFile(path, atomically: true);
    }
    
    // a simple function to add a new high score, to be called from your game logic
    // note that this doesn't sort or filter the scores in any way
    func addNewScore(newScore:Int) {
        //let newHighScore = Save(score: newScore, dateOfScore: NSDate())
        //self.tempArray.append(newHighScore)
        self.save()
    }
    
    func playAudio(){
        audioPlayer = try! AVAudioPlayer(contentsOfURL: gameSound)
        audioPlayer.volume = 1.0
        audioPlayer.numberOfLoops = -1
        audioPlayer.play()
    }
    
    func audioObjetos(tipo : String){
        
        if (tipo == "geladeira"){
        let geladeiraSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("FridgeClose", ofType: "mp3")!)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: geladeiraSound)
        audioPlayer.volume = 1.0
            audioPlayer.play()
        }
        else if (tipo == "microondas"){
            let microondasSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("Microwave", ofType: "mp3")!)
            audioPlayer = try! AVAudioPlayer(contentsOfURL: microondasSound)
            audioPlayer.volume = 1.0
            audioPlayer.play()
        }
        else if (tipo == "rádio"){
            let radioSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("RadioSHUTOFF", ofType: "mp3")!)
            audioPlayer = try! AVAudioPlayer(contentsOfURL: radioSound)
            audioPlayer.volume = 1.0
            audioPlayer.play()
        }
        else{
            let luzSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("click1", ofType: "mp3")!)
            audioPlayer = try! AVAudioPlayer(contentsOfURL: luzSound)
            audioPlayer.volume = 1.0
            audioPlayer.play()
        }
    }
    
    func audioFimFase(){
        let fimFaseSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("brilinho3", ofType: "mp3")!)
        audioPlayer = try! AVAudioPlayer(contentsOfURL: fimFaseSound)
        audioPlayer.volume = 1.0
        audioPlayer.play()
    }
    
    func torneiraLigada(){
//        var fimFaseSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("WaterDrop", ofType: "mp3")!)
//        audioPlayer = AVAudioPlayer(contentsOfURL: fimFaseSound, error: nil)
//        audioPlayer.volume = 1.0
//        audioPlayer.play()
    }
    
    func chuveiroLigado(){
//        var fimFaseSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("WaterDrop", ofType: "mp3")!)
//        audioPlayer = AVAudioPlayer(contentsOfURL: fimFaseSound, error: nil)
//        audioPlayer.volume = 1.0
//        audioPlayer.play()
    }
    
    func radioLigado(){
//        var radioLigadoSound = NSURL(fileURLWithPath: NSBundle.mainBundle().pathForResource("RadioOn", ofType: "mp3")!)
//        radio = AVAudioPlayer(contentsOfURL: radioLigadoSound, error: nil)
//        radio.numberOfLoops = -1
//        radio.volume = 1.0
//        radio.play()
    }
    
    func getSave() -> Save{
        let new: Save = self.tempArray.first!
        return new
    }
    
    func increaseCleanLevelByCompletedScene(){
        let saveFile = getSave()
        saveFile.increaseCleanLevelBy(ammount: 20)
        save()
    }
    
    func callMute(){
        let saveFile = getSave()
        saveFile.changeSoundOption()
        save()
    }
    
    func changeCharacter(newCharacter character: Int){
        let saveFile = getSave()
        saveFile.changeSoundOption()
        //saveFile.changeCharacterTo(novoPersonagem: 1)
        save()
    }
    
    func getCurrentCharacter() -> Int{
        let saveFile = getSave()
        return saveFile.selectedCharacter
    }
    
    func musicIsOn() -> Bool{
        let saveFile = getSave()
        return saveFile.musicOn
    }

    
};