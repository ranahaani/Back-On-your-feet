//
//  WeightLossGainViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 12/07/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

class WeightLossGainViewController: UIViewController {
    var selectedWeight = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func weightGainPressed(_ sender: UIButton) {
        selectedWeight = "Weight Gain"
        performSegue(withIdentifier: "toDailyDietPlan", sender: nil)
    }
    
    @IBAction func WeightLossButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toDailyDietPlan", sender: nil)
        selectedWeight = "Weight Loss"
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDailyDietPlan"{
            if let vc = segue.destination as? DailyDietPlanViewController{
                vc.selectedWeight = selectedWeight
            }
        }
    }
 

}
