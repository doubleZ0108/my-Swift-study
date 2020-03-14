//
//  ConcentrationStore.swift
//  Study
//
//  Created by double Z on 2020/3/13.
//  Copyright © 2020 Tongji University. All rights reserved.
//

import SwiftUI
import Combine

class ConcentrationStore: ObservableObject{
    var cards = [
        Card(emoji: "💨"),
        Card(emoji: "🎃"),
        Card(emoji: "💝"),
        Card(emoji: "🥶"),
        Card(emoji: "📚"),
        Card(emoji: "🌙")
    ]
    
    @Published var cardArray = [[Card]]()
    
    var leftCardNumber = 0
    var length = 0
    
    init() {
        let cardBuf = (cards + cards).shuffled()
        length = cardBuf.count
        cardArray.append([Card](cardBuf[0..<length/3]))
        cardArray.append([Card](cardBuf[length/3..<2*length/3]))
        cardArray.append([Card](cardBuf[2*length/3..<length]))
        
        restart()
    }
    
    func restart(){
        for row in 0..<self.cardArray.count{
            for index in 0..<self.cardArray[row].count{
                self.cardArray[row][index].show = false
                self.cardArray[row][index].disappear = false
                self.cardArray[row][index].row = row
                self.cardArray[row][index].index = index
            }
        }
        leftCardNumber = length
    }
}

