//
//  SaveHandler.swift
//  Galacssi
//
//  Created by Gabriel Nopper on 25/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import Foundation

class SaveHandler {
    var tempArray:Array<Save> = [];
    //var savedFile: Save
    
        init(){
    
            // encontra endereços de save.
            let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)
            let documentsDirectory = paths[0] as! String
            let path = documentsDirectory.stringByAppendingPathComponent("Saves.plist")
            let fileManager = NSFileManager.defaultManager()
    
    
            // Verifica a existencia de um arquivo anterior
            if !fileManager.fileExistsAtPath(path) {
                // Cria o arquivo no caso da não existencia
                if let bundle = NSBundle.mainBundle().pathForResource("DefaultFile", ofType: "plist") {
                    fileManager.copyItemAtPath(bundle, toPath: path, error:nil)
                }
            }
    
            // Verifica se há algum conteudo no arquivo de saves.
            if let rawData = NSData(contentsOfFile: path) {
                // Em caso positivo, le conteudo
                var scoreArray: AnyObject? = NSKeyedUnarchiver.unarchiveObjectWithData(rawData);
                //self.tempArray = scoreArray as? [Save] ?? []
                //self.savedFile = self.tempArray[0]
            }
            
            if tempArray.isEmpty{
                let newHighScore = Save(playerNum: 0, name: "Nome")
                self.tempArray.append(newHighScore)

            }
            
            var new: Save = self.tempArray.first!
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
    
    
    func getSave() -> Save{
        var new: Save = self.tempArray.first!
        return new
    }
    
    func increaseCleanLevelByCompletedScene(){
        var saveFile = getSave()
        saveFile.increaseCleanLevelBy(ammount: 20)
        save()
    }
    
    func callMute(){
        var saveFile = getSave()
        saveFile.changeSoundOption()
        save()
    }
    
    func changeCharacter(newCharacter character: Int){
        var saveFile = getSave()
        saveFile.changeSoundOption()
        save()
    }
    
    func getCurrentCharacter() -> Int{
        var saveFile = getSave()
        return saveFile.selectedCharacter
    }
    
    func musicIsOn() -> Bool{
        var saveFile = getSave()
        return saveFile.musicOn
    }

    
};