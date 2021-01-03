//
//  GameMode.swift
//  Math Memory
//
//  Created by Asliddin Rasulov on 2/16/20.
//  Copyright © 2020 Asliddin Rasulov. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 13.0, *)
class AlertView: UIView {
    
    let menu = Launch()
    
    static let instance = AlertView()
    
    
    @IBOutlet weak var trailingSelectImageVoice: NSLayoutConstraint!
    @IBOutlet weak var trailingSelectImageMode: NSLayoutConstraint!
    
    @IBOutlet var parentView: UIView!
    
    
    @IBOutlet weak var selectImageMode: UIImageView!
    @IBOutlet weak var selectImageVoice: UIImageView!
    
    @IBOutlet weak var threeXfour: UIButton!
    @IBOutlet weak var fourXfour: UIButton!
    @IBOutlet weak var fiveXfour: UIButton!
    
    @IBOutlet weak var yesVoice: UIButton!
    @IBOutlet weak var noVoice: UIButton!
    
    var mode: Int = 3
    var voice: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        if mode == 4 {
            trailingSelectImageMode.isActive = false
            let trailingConstraint = selectImageMode.trailingAnchor.constraint(equalTo: fourXfour.trailingAnchor)
            trailingSelectImageMode = trailingConstraint
            trailingConstraint.isActive = true
        } else
        if mode == 5 {
            trailingSelectImageMode.isActive = false
            let trailingConstraint = selectImageMode.trailingAnchor.constraint(equalTo: fiveXfour.trailingAnchor)
            trailingSelectImageMode = trailingConstraint
            trailingConstraint.isActive = true
        }
        
        Bundle.main.loadNibNamed("GameMode", owner: self, options: nil)
        
        commonInit()
    }
    
    private func commonInit() {
        parentView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        parentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func showAlert() {
        UIApplication.shared.keyWindow?.addSubview(parentView)
    }
    
    @IBAction func threeXfour(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        mode = 3
        trailingSelectImageMode.isActive = false
        let trailingConstraint = selectImageMode.trailingAnchor.constraint(equalTo: threeXfour.trailingAnchor)
        trailingSelectImageMode = trailingConstraint
        trailingConstraint.isActive = true
    }
    @IBAction func fourXfour(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        mode = 4
        trailingSelectImageMode.isActive = false
        let trailingConstraint = selectImageMode.trailingAnchor.constraint(equalTo: fourXfour.trailingAnchor)
        trailingSelectImageMode = trailingConstraint
        trailingConstraint.isActive = true
    }
    @IBAction func fiveXfour(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        mode = 5
        trailingSelectImageMode.isActive = false
        let trailingConstraint = selectImageMode.trailingAnchor.constraint(equalTo: fiveXfour.trailingAnchor)
        trailingSelectImageMode = trailingConstraint
        trailingConstraint.isActive = true
    }
    @IBAction func yesVoice(_ sender: UIButton) {
        voice = false
        UserDefaults.standard.set(voice, forKey: "voice")
        playSoundWith(fileName: "click", fileExtinsion: "mp3")
        
        trailingSelectImageVoice.isActive = false
        let trailingConstraint = selectImageVoice.trailingAnchor.constraint(equalTo: yesVoice.trailingAnchor)
        trailingSelectImageVoice = trailingConstraint
        trailingConstraint.isActive = true
    }
    @IBAction func noVoice(_ sender: UIButton) {
        voice = true
        UserDefaults.standard.set(voice, forKey: "voice")
        
        trailingSelectImageVoice.isActive = false
        let trailingConstraint = selectImageVoice.trailingAnchor.constraint(equalTo: noVoice.trailingAnchor)
        trailingSelectImageVoice = trailingConstraint
        trailingConstraint.isActive = true
    }
    
    @IBAction func done(_ sender: UIButton) {
        if !UserDefaults.standard.bool(forKey: "voice") {
            playSoundWith(fileName: "click", fileExtinsion: "mp3")
        }
        parentView.isHidden = true
    }
    
}

