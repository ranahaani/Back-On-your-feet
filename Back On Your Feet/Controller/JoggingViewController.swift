//
//  JoggingViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 04/05/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import MZTimerLabel
class JoggingViewController: UIViewController {
    var redStopwatch = MZTimerLabel()
    
   
    var counter = 0
    var timer = Timer()
    @IBOutlet weak var countLabel: MZTimerLabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        countLabel.isHidden = true
        redStopwatch.frame = CGRect(x: 100, y: 200, width: 150, height: 100)
        redStopwatch.timeLabel.font = UIFont.systemFont(ofSize: 30.0)
        redStopwatch.timeLabel.textColor = UIColor.red
        redStopwatch.timeFormat = "HH:mm:ss SS"
        
         view.addSubview(redStopwatch)
        redStopwatch.start()

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
       // timer.invalidate()
        //countLabel.start()
    }
    
    // called every time interval from the timer
    @objc func timerAction() {
        counter += 1
        countLabel.text = "\(counter)"
    }
   

}
