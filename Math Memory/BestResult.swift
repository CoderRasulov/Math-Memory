//
//  BestResult.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/15/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class BestResult: UIViewController {

    @IBOutlet weak var modeLabel: UILabel!
    @IBOutlet weak var pairsLabel: UILabel!
    @IBOutlet weak var flipsLabel: UILabel!
    @IBOutlet weak var bestScore: UILabel!
    
    var mode: Int = AlertView.instance.mode
    var maxInxex: Int = 0
    var type = ["+", "-", "×", "÷", "MIX"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var max = UserDefaults.standard.integer(forKey: "score\(type[0])\(mode)")
        
        for i in 0..<type.count {
            if UserDefaults.standard.integer(forKey: "score\(type[i])\(mode)") > max {
                max = UserDefaults.standard.integer(forKey: "score\(type[i])\(mode)")
                maxInxex = i
            }
        }
        let pairs = UserDefaults.standard.integer(forKey: "pairs\(type[maxInxex])\(mode)")
        let flips = UserDefaults.standard.integer(forKey: "flips\(type[maxInxex])\(mode)")
        
        modeLabel.text = "\(mode)" + " × 4"
        pairsLabel.text = "\(pairs)" + " * 1000 = " + "\(pairs * 500)"
        flipsLabel.text = "\(flips)" + "  * 200 = " + "\(flips * 200)"
        bestScore.text = "\(UserDefaults.standard.integer(forKey: "score\(type[maxInxex])\(mode)"))"
    }
    @IBAction func back(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        let vc = storyboard?.instantiateViewController(identifier: "launch") as! Launch
        present(vc, animated: true, completion: nil)
    }
    @IBAction func clear(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
        
        let vc = storyboard?.instantiateViewController(identifier: "launch") as! Launch
        present(vc, animated: true, completion: nil)
    }
}
