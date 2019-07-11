//
//  DietPlanDetailsViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 10/07/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

class DietPlanDetailsViewController: UIViewController {

    @IBOutlet weak var snacksView: UITextView!
    @IBOutlet weak var breakFastView: UITextView!
    @IBOutlet weak var lunchView: UITextView!
    @IBOutlet weak var DinnerView: UITextView!
    var breakFast = ""
    var dinner = ""
    var snacks = ""
    var lunch = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        snacksView.isEditable = false
//        breakFastView.isEditable = false
//        lunchView.isEditable = false
//        DinnerView.isEditable = false
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        snacksView.text = snacks
        DinnerView.text = dinner
        breakFastView.text = breakFast
        lunchView.text = lunch
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
