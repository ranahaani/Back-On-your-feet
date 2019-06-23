//
//  HeightWidthViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 23/06/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit

class HeightWidthViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    func loadJson(filename fileName: String) -> [fileData]? {
        if let url = Bundle.main.url(forResource: fileName, withExtension: "json") {
            do {
                let data = try Data(contentsOf: url)
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(ResponseData.self, from: data)
                return jsonData.fileData
            } catch {
                print("error:\(error)")
            }
        }
        return nil
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
     
    */
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.singleLine
        tableView.separatorColor = #colorLiteral(red: 0.05882352963, green: 0.180392161, blue: 0.2470588237, alpha: 1)
        return (loadJson(filename: "infoAboutHeight")?.count)!
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HeightWidthTableViewCell
        let filesData = loadJson(filename: "infoAboutHeight")
        cell.heightLabel.text = filesData?[indexPath.row].Height
        cell.WomenLabel.text = filesData?[indexPath.row].Women
        cell.MenLabel.text = filesData?[indexPath.row].Men
        return cell
    }

}
struct ResponseData: Decodable {
    var fileData: [fileData]
}
struct fileData : Decodable {
    var Height: String
    var Women: String
    var Men: String
}

