//
//  getMedicinesViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 12/07/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

class getMedicinesViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var medicines:Dictionary<String, AnyObject>!
    override func viewDidLoad() {
        super.viewDidLoad()
        //heartPatient
        //navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = "Medicines"
        if let path = Bundle.main.path(forResource: "heartPatient", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let jsonResult = jsonResult as? Dictionary<String, AnyObject> {
                    medicines = jsonResult
                    
                }
            } catch {
                // handle error
            }
        }
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return medicines?.count ?? 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! medicinesTableViewCell
        cell.nameLabel.text = Array(medicines)[indexPath.row].key
        cell.descriptionLabel.text = Array(medicines)[indexPath.row].value as? String

        cell.descriptionLabel?.isEditable = false
        return cell
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
