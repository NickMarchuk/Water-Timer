//
//  ViewController.swift
//  Water Timer
//
//  Created by Nick on 03.04.2020.
//  Copyright © 2020 Nick Marchuk. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var progressBar: UIProgressView!
    
    let waterTimer = ["10 min": 600, "15 min": 900, "20 min": 1200]
    var timer = Timer()
    let systemSoundID: SystemSoundID = 1016
    
    override func viewDidLoad() {
        super.viewDidLoad()
        progressBar.progress = 0.0
    }
    
    @IBAction func pressedGlasses(_ sender: UIButton) {
        
        guard let getTitle = sender.currentTitle else {
            return
        }
        
        guard var getSeconds = waterTimer[getTitle] else {
            return
        }
        
        timer.invalidate()
        let permanentSeconds = getSeconds
        
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { (blockTimer) in
            if getSeconds > 0 {
                self.infoLabel.text = "\(getSeconds) seconds."
                let counterForward = permanentSeconds - getSeconds
                let percentageOfNumber = Float(counterForward) / Float(permanentSeconds)
                self.progressBar.progress = percentageOfNumber
                getSeconds -= 1
            }
            else{
                AudioServicesPlaySystemSound(self.systemSoundID)
                self.infoLabel.text = "Done!\n\nYou need to drink some water!"
                self.timer.invalidate()
                self.progressBar.progress = 1.0
            }
        }
    }
}

