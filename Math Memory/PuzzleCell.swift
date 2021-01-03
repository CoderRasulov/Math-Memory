//
//  PuzzleCell.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/13/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit

class PuzzleCell: UICollectionViewCell {
    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    

    var card : Card?
    
    func setCard(_ card : Card) {
        
        self.card = card
        
        frontLabel.text = card.textCard
        
    }
    func flip() {
        UIView.transition(from: backLabel, to: frontLabel, duration: 0.5, options: [.transitionFlipFromLeft, .showHideTransitionViews], completion: nil)
    }
    func flipBack() {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.7) {
            UIView.transition(from: self.frontLabel, to: self.backLabel, duration: 0.5, options: [.transitionFlipFromRight, .showHideTransitionViews], completion: nil)
        }
    }
    func remove() {
        
        self.backLabel.alpha = 0
        
        UIView.animate(withDuration: 1, delay: 0.1, options: .curveEaseOut, animations: {
            self.frontLabel.alpha = 0
            if !UserDefaults.standard.bool(forKey: "voice") {
                playSoundWith(fileName: "flip", fileExtinsion: "mp3")
            }
        }) { _ in
            if !UserDefaults.standard.bool(forKey: "voice") {
                audioPlayer.currentTime = 0
                audioPlayer.play()
                playSoundWith(fileName: "timer", fileExtinsion: "mp3")
            }
        }
    }
}
