//
//  MemoryPuzzle.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/13/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit

var arr : [String] = []

@available(iOS 13.0, *)
class MemoryPuzzle: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var progressTime: UIProgressView!
    @IBOutlet weak var typeImageView: UIImageView!
    @IBOutlet weak var typeBorder: UIView!
    
    var calc = Calc()
    var model = CardModel()
    var cardArray = [Card]()
    
    var firstFlippedCardIndex: IndexPath?
    
    var cardOneResult: String?
    var cardTwoResult: String?
    
    var timer: Timer?
    
    var progress: CGFloat = 1
    var gameMode: Int = AlertView.instance.mode

    var colorCard: UIColor = .black
    var type: String = ""
    var mixType: String = ""
    var num: [Int] = []
    
    var pairs: Int = 0
    var flips: Int = 0
    
    var max: Int = 0
    
    override func viewWillAppear(_ animated: Bool) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "timer", fileExtinsion: "mp3")
            audioPlayer.numberOfLoops = -1
            audioPlayer.play()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        max += 20
        
        typeImageView.image = UIImage(named: type)
        typeBorder.borderColor = colorCard
        progressTime.progress = Float(progress)
        
        timer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(timerElapsed), userInfo: nil, repeats: true)
        
        if type == "logo" {
            
            mixType = "logo"
            
            for _ in 0..<gameMode * 2 {
                
                var num1: Int = 0
                var num2: Int = 0
                
                type = randType()
                    
                if type == "÷" {
                    
                    num2 = getNumber(min: 1, max: max)
                    num1 = getNumber(min: 1, max: 5) * num2
                    
                } else
                if type == "×" {
                    
                    num1 = getNumber(min: 1, max: 5)
                    num2 = getNumber(min: 1, max: max)
                    
                } else {
                    
                    num1 = getNumber(min: 1, max: max)
                    num2 = getNumber(min: 1, max: max)
                    
                }
                
                arr.append("\(num1)" + " \(type) " + "\(num2)")
                
            }
            
        } else
        if type == "÷" {
            
            var num1 : [Int] = []
            let num2 = getNumbersInRange(min: 1, max: max, count: 2 * gameMode)
            
            let rand = getNumbersInRange(min: 1, max: 5, count: 2 * gameMode)
            
            for i in 0..<num2.count {
                num1.append(rand[i] * num2[i])
            }
            
            num = num1 + num2
            
        } else
        if type == "×" {
            
            var num1: [Int] = []
            var num2: [Int] = []
            
            num1 += getNumbersInRange(min: 1, max: 5, count: 2 * gameMode)
            num2 += getNumbersInRange(min: 1, max: max, count: 2 * gameMode)
            
            num = num1 + num2
            
        } else {
            
            num = getNumbersInRange(min: 1, max: max, count: 4 * gameMode)

        }
        
        for i in 0..<num.count / 2 {
            
            if mixType == "" {
            
                arr.append("\(num[i])" + " \(type) " + "\(num[i + 2 * gameMode])")
                
            }
            
        }
        cardArray = model.getCards()
        cardArray.shuffle()
    }
    
    @objc func timerElapsed() {
        progressTime.progress -= 0.003
        checkGameEnded()
    }
    
    func result(str : String) -> String {
        var result : String!
        do {
            result = try calc.compute(str: str.replacingOccurrences(of: " ", with: "")).result
        } catch { }
        return result
    }
    func checkForMatches(_ secondFlippedCardIndex : IndexPath) {
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as! PuzzleCell
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as! PuzzleCell
        
        let cardOne = cardArray[firstFlippedCardIndex!.row]
        let cardTwo = cardArray[secondFlippedCardIndex.row]
    
        do {
            cardOneResult = try calc.compute(str: cardOne.textCard.replacingOccurrences(of: " ", with: "")).result
            cardTwoResult = try calc.compute(str: cardTwo.textCard.replacingOccurrences(of: " ", with: "")).result
        } catch { }
        
       
        if cardOneResult == cardTwoResult {
            
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell.remove()
            cardTwoCell.remove()
        
            pairs += 1
            
            progressTime.progress += 0.03
            
            checkGameEnded()
            
        } else {
            
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
            cardOneCell.flipBack()
            cardTwoCell.flipBack()
            
            flips += 1
        }
        firstFlippedCardIndex = nil
    }
    func checkGameEnded() {
        
        if progressTime.progress <= 0 {
            
            let vc = storyboard?.instantiateViewController(identifier: "result") as! HighScore
            timer?.invalidate()
            vc.mode = gameMode ; vc.flips = flips ; vc.pairs = pairs
            vc.typeScore = pairs * 500 - flips * 200
            if mixType == "" {
                vc.type = self.type
            } else {
                vc.type = self.mixType
            }
            audioPlayer.stop()
            vc.colorCard = colorCard
            present(vc, animated: true, completion: nil)
            
            return
        } 
        
        var isWon = true
        
        for card in cardArray {
            if card.isMatched == false {
                isWon = false
                break
            }
        }
        
        if isWon == true {
            
            self.timer?.invalidate()
            playSoundWith(fileName: "levelup", fileExtinsion: "mp3")
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 2) {
                let vc = self.storyboard?.instantiateViewController(identifier: "puzzle") as! MemoryPuzzle
                if self.mixType == "logo" {
                    vc.type = "logo"
                } else {
                    vc.type = self.type
                }
                vc.max = self.max ; vc.flips = self.flips ; vc.pairs = self.pairs
                vc.progress = CGFloat(self.progressTime.progress + 0.1)
                vc.colorCard = self.colorCard
                arr.removeAll()
                audioPlayer.currentTime = 0
                audioPlayer.play()
                self.present(vc, animated: true, completion: nil)
            }
        }
    }
    
    func randType() -> String {
        
        return ["+", "-", "×", "÷"].randomElement()!
        
    }
    
    @IBAction func back(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        let vc = storyboard?.instantiateViewController(identifier: "menu") as! Menu
        arr.removeAll()
        present(vc, animated: true, completion: nil)
    }
}

@available(iOS 13.0, *)

extension MemoryPuzzle: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cardArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PuzzleCell", for: indexPath) as! PuzzleCell
        let card = cardArray[indexPath.row]
        cell.setCard(card)
        
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (0.9 * view.frame.width - 10 * (CGFloat(gameMode) - 1)) / CGFloat(gameMode)
        let heigth = (0.9 * view.frame.width - 30) / 4
        if gameMode < 5 {
            return CGSize(width: width, height: heigth)
        } else {
            return CGSize(width: heigth, height: width)
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let cell = collectionView.cellForItem(at: indexPath) as! PuzzleCell
        
        let card = cardArray[indexPath.row]
        
        if card.isFlipped == false {
            
            cell.flip() ; card.isFlipped = true
            
            if firstFlippedCardIndex == nil {
                
                firstFlippedCardIndex = indexPath
            } else {
                
                checkForMatches(indexPath)
            }
        }
    }
    
}
func getNumbersInRange(min:Int, max:Int, count:Int) -> [Int] {
    var arr = [Int]()
    let getRandom = randomSequenceGenerator(min: min, max: max)
    for _ in 1...count {
        arr.append(getRandom())
    }
    return arr
}

func getNumber(min:Int, max:Int) -> Int {
    return randomSequenceGenerator(min: min, max: max)()
}

func randomSequenceGenerator(min: Int, max: Int) -> () -> Int {
    var numbers: [Int] = []
    return {
        if numbers.isEmpty {
            numbers = Array(min ... max)
        }
        let index = Int(arc4random_uniform(UInt32(numbers.count)))
            return numbers.remove(at: index)
    }
}


