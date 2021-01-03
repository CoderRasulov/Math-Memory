//
//  HighScore.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/14/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit

class HighScore: UIViewController {
    
    var calc = Calc()
    
    var type: String = ""
    
    var mode: Int = 0
    var pairs: Int = 0
    var flips: Int = 0
    var typeScore: Int = 0
    var colorCard: UIColor = .white

    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var pairsLabel: UILabel!
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    @IBOutlet weak var typeImageView: UIImageView!

    @IBOutlet weak var home: UIButton!
    @IBOutlet weak var share: UIButton!
    @IBOutlet weak var borderScore: UIView!
    @IBOutlet weak var finalScore: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arr.removeAll()
        typeImageView.image = UIImage(named: type)
        home.backgroundColor = colorCard
        share.backgroundColor = colorCard
        borderScore.borderColor = colorCard
        finalScore.textColor = colorCard
        
        modeLabel.text = "\(mode) × 4"
        pairsLabel.text = "\(pairs) × 500 = " + "\(pairs * 500)"
        flipsLabel.text = "\(flips) × 200 = " + "\(flips * 200)"
        bestScore.text = "\(UserDefaults.standard.integer(forKey: "score\(type)\(mode)"))"
        scoreLabel.text = "\(typeScore)"
        if typeScore > UserDefaults.standard.integer(forKey: "score\(type)\(mode)") {
            UserDefaults.standard.set(typeScore, forKey: "score\(type)\(mode)")
            UserDefaults.standard.set(mode, forKey: "level\(type)\(mode)")
            UserDefaults.standard.set(pairs, forKey: "pairs\(type)\(mode)")
            UserDefaults.standard.set(flips, forKey: "flips\(type)\(mode)")
        }
    }
    @IBAction func backHome(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        if #available(iOS 13.0, *) {
            let vc = storyboard?.instantiateViewController(identifier: "launch") as! Launch
            present(vc, animated: true, completion: nil)
        }
    }
    @available(iOS 13.0, *)
    @IBAction func shareScore(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "puzzle") as! MemoryPuzzle
        vc.type = type
        vc.colorCard = colorCard
        present(vc, animated: true, completion: nil)
    }
    
}
