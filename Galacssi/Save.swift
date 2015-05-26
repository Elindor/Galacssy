//
//  Save.swift
//  Galacssi
//
//  Created by Gabriel Nopper on 21/05/15.
//  Copyright (c) 2015 Gabriel Nopper. All rights reserved.
//

import Foundation


public class Save: NSObject, NSCoding {
    // Valores guardados e salvos no sistema.
    var selectedCharacter: Int
    var lastLogin = NSDate()
    var cleanLevel: Int
    
    // Endereços das criptografias. Porque o formato salvo será um arquivo, ele tem um endereço e diretório. Esses arquivos não são visiveis mesmo forándo com hack no aparelho, mas é possivel acessá-los chutando endereços. Por isso, temos um #(Numero aleatório) no final para gerar uma segurança extra)
    let charString : String = "GalacssiSelectedCharacter#1341"
    let loginString : String = "GalacssiLastLogin#1341"
    let cleanString : String = "GalacssiCleanLevel#1341"
    
    
    /**
    init(): Chama o
    **/
    init (playerNum: Int, name: String) {
        self.selectedCharacter = playerNum
        self.lastLogin.timeIntervalSince1970
        self.cleanLevel = 40
        
    }
    
    public required init(coder aDecoder: NSCoder) {
        selectedCharacter = aDecoder.decodeIntegerForKey(charString)
        lastLogin = aDecoder.decodeObjectForKey(loginString) as! NSDate
        cleanLevel = aDecoder.decodeIntegerForKey(cleanString)
    }
    
    public func encodeWithCoder(_aCoder: NSCoder) {
        _aCoder.encodeInteger(selectedCharacter, forKey: charString)
        _aCoder.encodeObject(lastLogin, forKey: loginString)
        _aCoder.encodeInteger(cleanLevel, forKey: cleanString)
    }
    
    /**
    updateTimeFactor(): Esta função atualiza a barra de limpeza, enquanto ela atualiza o ultimo login. Deve ser chamado quando o app é ligado, talvez no app delegate.
    */
    func updateTimeFactor(){
        let currentTime = NSDate(timeIntervalSince1970: 0)
        let diff = currentTime.timeIntervalSinceDate(self.lastLogin)
        let intSec: NSInteger = NSInteger(diff)
        let intMin = (intSec / 60)
        let totalRounds = (intMin/20) + (intMin%20)/10
        self.cleanLevel -= totalRounds
        if self.cleanLevel < 0{
            self.cleanLevel = 0
        }
        lastLogin = currentTime

    }
    
    enum CharacterType: Int{
        case characterHero = 0;
        case characterFairy = 2;
    }
};