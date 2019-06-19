//
//  JoggingViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 04/05/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit

class JoggingViewController: UIViewController {

    var counter = 0
    var timer = Timer()
    
    @IBOutlet weak var countLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    
    // start timer
    @IBAction func startTimerButtonTapped(sender: UIButton) {
        timer.invalidate() // just in case this button is tapped multiple times
        // start the timer
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(timerAction), userInfo: nil, repeats: true)
    }
    @IBAction func resetTimerButtonTapped(sender: UIButton) {
        timer.invalidate()
        counter = 0
        countLabel.text = "0"
    }    // stop timer
    @IBAction func cancelTimerButtonTapped(sender: UIButton) {
        timer.invalidate()
    }
    
    // called every time interval from the timer
    @objc func timerAction() {
        counter += 1
        countLabel.text = "\(counter)"
    }
   

}
