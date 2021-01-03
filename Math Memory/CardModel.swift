//
//  CardModel.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/13/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import Foundation

class CardModel {
    
    var calc = Calc()
    
    func getCards() -> [Card] {
        
        var generatedCards = [Card]()
        
        for i in 0..<arr.count {
            
            let cardOne = Card()
            
            cardOne.textCard = arr[i]
            generatedCards.append(cardOne)
            
            let cardTwo = Card()
            do {
                cardTwo.textCard = try calc.compute(str: cardOne.textCard.replacingOccurrences(of: " ", with: "")).result
            } catch { }
            
            generatedCards.append(cardTwo)
            
        }
        
        return generatedCards
    }
}
