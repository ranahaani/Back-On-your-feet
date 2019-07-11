//
//  DailyDietPlanViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 06/07/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

class DailyDietPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   
    var selectedIndex = 0
    var dietPlans:Dictionary<String, AnyObject>?
    var days = ["Day 1","Day 2","Day 3","Day 4","Day 5","Day 6","Day 7"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "fileAboutLoss", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    dietPlans = jsonResult
                    
                }
            } catch {
                // handle error
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dietPlans!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Days \(indexPath.row + 1)"//dietPlans?["DAY\(indexPath.row+1)"]!["Breakfast"] as! String
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsPlans"{
            if let vc = segue.destination as? DietPlanDetailsViewController{
                print(selectedIndex)
                print(dietPlans?["DAY\(selectedIndex)"]?["Dinner"] as? String!)
                vc.dinner = (dietPlans?["DAY\(selectedIndex)"]?["Dinner"] as? String)!
                vc.breakFast = (dietPlans?["DAY\(selectedIndex)"]?["Breakfast"] as? String)!
                vc.snacks = (dietPlans?["DAY\(selectedIndex)"]?["A.M.Snack"] as? String)!
                vc.lunch = (dietPlans?["DAY\(selectedIndex)"]?["Lunch"] as? String)!

            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row + 1
        performSegue(withIdentifier: "toDetailsPlans", sender: self)
    }
    
    
    
}
