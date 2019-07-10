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
    var days = ["Day 1","Day 2","Day 3","Day 4","Day 5","Day 6","Day 7"]
    override func viewDidLoad() {
        super.viewDidLoad()
        if let path = Bundle.main.path(forResource: "heartPatientWeightLoss", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    print(jsonResult)
                }
            } catch {
                // handle error
            }
        }
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return days.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = days[indexPath.row]
        return cell
    }
    
   

    

}
