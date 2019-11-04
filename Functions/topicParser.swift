//
//  topicParser.swift
//  SmartGame
//
//  Created by Paw.toporkov on 17/10/2019.
//  Copyright © 2019 Paw.toporkov. All rights reserved.
//

import Foundation
import UIKit

private func getNeedWordsByCount(countEasyWords: Int, countHardWords: Int, data: [Any], arrayIndForData: [Int]) -> [WordStruct] {
    
    var finalArrayWords: [WordStruct] = []
    var curCountEasy: Int = 0
    var curCountHard: Int = 0
    var i: Int = 0
    
    while (curCountEasy < countEasyWords || curCountHard < countHardWords) {
    
        var curWord = WordStruct()
        
        guard let userDict = data[arrayIndForData[i]] as? [Any?] else { return [] }
        guard let word = userDict[0] as? String else { return [] }
        guard let points = userDict[1] as? Int else { return [] }
        
        curWord.word = word
        curWord.points = points
        
        if (points == 1 && curCountEasy < countEasyWords) {
            curCountEasy += 1
            finalArrayWords.append(curWord)
        } else if (points == 2 && curCountHard < countHardWords) {
            curCountHard += 1
            finalArrayWords.append(curWord)
        }
        i += 1
    }
    return finalArrayWords
}

func topicParser(fileName: String, teamsNumber: Int, level: LevelType) -> [WordStruct] {
    var finalArrayWords: [WordStruct] = []
    
    guard let path = Bundle.main.path(forResource: fileName as String, ofType: "json") else { return [] }
    let url = URL(fileURLWithPath: path)
    
    do {
        let data = try Data(contentsOf: url) as Data
        let json = try JSONSerialization.jsonObject(with: data, options: .mutableContainers)
        guard let tempArrayWords = json as? [Any] else { return [] }
        
        var arrayInd = [Int](0...tempArrayWords.count) // создаем массив индексов
        arrayInd.shuffle() // Перемешиваем массив индексов.
        
        let countWords: Int = teamsNumber * 25
        switch level {
        case .easy:
            let countEasyWords: Int = countWords * 9 / 10
            let countHardWords: Int = countWords - countEasyWords
            finalArrayWords = getNeedWordsByCount(countEasyWords: countEasyWords, countHardWords: countHardWords, data: tempArrayWords, arrayIndForData: arrayInd)
        case .hard:
            let countHardWords: Int = countWords * 9 / 10
            let countEasyWords: Int = countWords - countHardWords
            finalArrayWords = getNeedWordsByCount(countEasyWords: countEasyWords, countHardWords: countHardWords, data: tempArrayWords, arrayIndForData: arrayInd)
        case .all:
            let countHardWords: Int = countWords * 5 / 10
            let countEasyWords: Int = countWords - countHardWords
            finalArrayWords = getNeedWordsByCount(countEasyWords: countEasyWords, countHardWords: countHardWords, data: tempArrayWords, arrayIndForData: arrayInd)
        }
    }
    catch {
        print(error)
    }
    
    return finalArrayWords
}
