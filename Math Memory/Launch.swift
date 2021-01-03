//
//  ViewController.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/13/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import UIKit
import AVFoundation

var audioPlayer : AVAudioPlayer!

func playSoundWith(fileName: String, fileExtinsion: String) -> Void {
    
    let audioSourceURL = Bundle.main.path(forResource: fileName, ofType: fileExtinsion)
    
    do {
        audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: audioSourceURL!))
    } catch {
        print(error)
    }
    audioPlayer.play()
}

@IBDesignable extension UIView {
    @IBInspectable var cornerRadius: CGFloat {
        set {
            layer.cornerRadius = newValue
        } get {
            return layer.cornerRadius
        }
    }
    @IBInspectable var borderWidth: CGFloat {
        set {
            layer.borderWidth = newValue
        }
        get {
            return layer.borderWidth
        }
    }
    @IBInspectable var borderColor: UIColor? {
        set {
            guard let uiColor = newValue else { return }
            layer.borderColor = uiColor.cgColor
        }
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color)
        }
    }
}

@available(iOS 13.0, *)
class Launch: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        arr.removeAll()
    }
    
    @IBAction func HighScore(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        let vc = storyboard?.instantiateViewController(identifier: "highscore") as! BestResult
        present(vc, animated: true, completion: nil)
    }
    @IBAction func Play(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        let vc = storyboard?.instantiateViewController(identifier: "menu") as! Menu
        present(vc, animated: true, completion: nil)
        
    }
    @IBAction func Settings(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        AlertView.instance.showAlert()
        AlertView.instance.parentView.isHidden = false
    }
    
}

