//
//  DailyDietPlanViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 06/07/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit
import SVProgressHUD
class DailyDietPlanViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
   var selectedWeight = ""
    var selectedIndex = 0
    var selectedCurrentAIlment = ""
    var dietPlans:Dictionary<String, AnyObject>?
    var dataArray = ["Bone/Joints","Heart Diesease","Diabetes","None"]
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if selectedWeight == "Weight Gain"{
            print("Heart Diesease")
            if selectedCurrentAIlment == "Bone/Joints"{
                if let path = Bundle.main.path(forResource: "bonesforWeightLoss", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else if selectedCurrentAIlment == "Heart Diesease"{
                print("Heart Diesease")
                if let path = Bundle.main.path(forResource: "HeartPatientWeightGain", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
          
         else if selectedCurrentAIlment == "Diabetes"{
                if let path = Bundle.main.path(forResource: "DiabetesForWeightGain", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else if selectedCurrentAIlment == "None"{
                if let path = Bundle.main.path(forResource: "weightLossForNormalPerson", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else{
                print("No Data Available")
            }
        }
            
            
            
            
        
        else if selectedWeight == "Weight Loss"{
            if selectedCurrentAIlment == "Bone/Joints"{
                if let path = Bundle.main.path(forResource: "bonesforWeightLoss", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else if selectedCurrentAIlment == "Heart Disease"{
                if let path = Bundle.main.path(forResource: "HeartPatientWeightLoss", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
                
            else if selectedCurrentAIlment == "Diabetes"{
                if let path = Bundle.main.path(forResource: "DiabeticWeightLoss", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else if selectedCurrentAIlment == "None"{
                if let path = Bundle.main.path(forResource: "weightLossForNormalPerson", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                        if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                            dietPlans = jsonResult
                            print(jsonResult)
                        }
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
            else{
                print("No Data Available")
            }
        }
            
            
        
            
            
        else{
            dietPlans = ["data":"No data available"] as Dictionary<String, AnyObject>
        }

    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        return dietPlans!.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        if dietPlans?.count == 1{
            cell.textLabel?.text = "Sorry no data availabel"//dietPlans?["DAY\(indexPath.row+1)"]!["Breakfast"] as! String
            cell.selectionStyle = .none
        }
        else{
            cell.textLabel?.text = "Day \(indexPath.row + 1)"//dietPlans?["DAY\(indexPath.row+1)"]!["Breakfast"] as! String

        }
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsPlans"{
            if let vc = segue.destination as? DietPlanDetailsViewController{
                vc.dinner = (dietPlans?["DAY\(selectedIndex)"]?["Dinner"] as? String)!
                vc.breakFast = (dietPlans?["DAY\(selectedIndex)"]?["Breakfast"] as? String)!
                vc.snacks = (dietPlans?["DAY\(selectedIndex)"]?["Snacks"] as? String)!
                vc.lunch = (dietPlans?["DAY\(selectedIndex)"]?["Lunch"] as? String)!

            }
        }
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedIndex = indexPath.row + 1
        performSegue(withIdentifier: "toDetailsPlans", sender: self)
    }
    
    
    
}
