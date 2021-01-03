//
//  Menu.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/19/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit

@available(iOS 13.0, *)
class Menu: UIViewController {

    var types = ["+", "-", "×", "÷", "logo"]
    var colors: [UIColor] = [
        .init(red: 138 / 255.0, green: 196 / 255.0, blue: 74 / 255.0, alpha: 1),
        .init(red: 254 / 255.0, green: 194 / 255.0, blue: 8 / 255.0, alpha: 1),
        .init(red: 243 / 255.0, green: 66 / 255.0, blue: 52 / 255.0, alpha: 1),
        .init(red: 20 / 255.0, green: 187 / 255.0, blue: 212 / 255.0, alpha: 1),
        .clear
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func goHome(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        let vc = storyboard?.instantiateViewController(identifier: "launch") as! Launch
        present(vc, animated: true, completion: nil)
    }
    @IBAction func gameMode(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        let vc = storyboard?.instantiateViewController(identifier: "puzzle") as! MemoryPuzzle
        vc.type = types[sender.tag]
        vc.colorCard = colors[sender.tag]
        present(vc, animated: true, completion: nil)
    }
}
