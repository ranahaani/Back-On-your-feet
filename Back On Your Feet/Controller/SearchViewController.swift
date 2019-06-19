//
//  SearchViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 29/04/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import SVProgressHUD
import Alamofire
class SearchViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var isFirstTime = true
    var drugsArray = [drugsSearch]()
    var searchActive = false
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SVProgressHUD.setBackgroundColor(#colorLiteral(red: 0.2912590802, green: 0.6273272634, blue: 0.8644545674, alpha: 1))
        tableView.backgroundColor = #colorLiteral(red: 0.2912590802, green: 0.6273272634, blue: 0.8644545674, alpha: 1)
        SVProgressHUD.show(withStatus: "Loading...")
        self.searchController.searchResultsUpdater = self
        self.searchController.delegate = self
        self.searchController.searchBar.delegate = self
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.dimsBackgroundDuringPresentation = true
        self.searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.sizeToFit()
        searchController.searchBar.becomeFirstResponder()
        self.tableView.tableHeaderView = searchController.searchBar
        //self.navigationItem.titleView = searchController.searchBar
        self.definesPresentationContext = true
        self.searchController.searchBar.placeholder = "Search for Medicine"
        
        makingRequest()
       
    }
    
    
    func makingRequest(){
        if drugsArray.isEmpty{}
        else{
            drugsArray.removeAll()
        }
         var jsonUrlString = String()
        if isFirstTime{
             jsonUrlString = "https://rxnav.nlm.nih.gov/REST/rxclass/class/byDrugName.json?drugName=morphine&relaSource=MEDRT&relas=may_treat"
                isFirstTime = false
        }
        else{
            let searchString = searchController.searchBar.text?.replace(string: " ", replacement: "_")
            jsonUrlString = "https://rxnav.nlm.nih.gov/REST/rxclass/class/byDrugName.json?drugName=\(searchString ?? "")&relaSource=MEDRT&relas=may_treat"
        }
        
        
        
        //let url = URL(string: jsonUrlString)
        let url = URL(string: jsonUrlString)
        Alamofire.request(url!, method: .get, parameters: nil, encoding: JSONEncoding.default)
            .responseJSON { response in
                if let status = response.response?.statusCode {
                    switch(status){
                    case 201:
                        print("example success")
                    default:
                        print("error with response status: \(status)")
                        SVProgressHUD.showError(withStatus: "Error")
                    }
                }
                if let result = response.result.value {
                    let JSON = result as! NSDictionary
                    print(JSON.allKeys)
                    if JSON.allKeys.count > 1{
                        
                    
                    let rxclassDrugInfoList = JSON["rxclassDrugInfoList"] as! NSDictionary
                    let rxclassDrugInfo = rxclassDrugInfoList["rxclassDrugInfo"] as! [NSDictionary]
                    
                    for drugs in rxclassDrugInfo{
                        let minConcept = drugs["minConcept"] as! NSDictionary
                        
                        let drugName = minConcept["name"] as! String
                        let rxclassMinConceptItem = drugs["rxclassMinConceptItem"] as! NSDictionary
                        let classId = rxclassMinConceptItem["classId"] as! String
                        let className = rxclassMinConceptItem["className"] as! String
                        let d = drugsSearch(drugName: drugName, disease: className, id: classId)
                        self.drugsArray.append(d)
                    }
                    
                        self.tableView.reloadData()

                    }
                    else{
                        SVProgressHUD.showError(withStatus: "Not Found")
                    }
                    
                    SVProgressHUD.dismiss()
                }
                
        }
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

extension SearchViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return drugsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! SearchTableViewCell
        cell.backgroundColor = #colorLiteral(red: 0.2912590802, green: 0.6273272634, blue: 0.8644545674, alpha: 1)
        cell.idLabel.text = drugsArray[indexPath.row].id
        cell.titleLabel.text = "Name: \(String(describing: drugsArray[indexPath.row].drugName!))"
        cell.diseaseLabel.text = "Disease: \(String(describing: drugsArray[indexPath.row].disease!))"
      cell.selectionStyle = .none
        return cell
    }
    
    
}


extension SearchViewController: UISearchResultsUpdating ,UISearchBarDelegate,UISearchControllerDelegate{
    func updateSearchResults(for searchController: UISearchController) {
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        SVProgressHUD.dismiss()
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchActive = true
        //tableView.reloadData()
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchActive = false
        SVProgressHUD.show(withStatus: "Searching...")
        makingRequest()
        DispatchQueue.main.async{
            self.tableView.reloadData()
            
        }
        //tableView.reloadData()
    }
    
    func searchBarBookmarkButtonClicked(_ searchBar: UISearchBar) {
        if !searchActive {
            searchActive = true
            tableView.reloadData()
        }
        
        searchController.searchBar.resignFirstResponder()
    }
    func searchBarIsEmpty() -> Bool {
        return searchController.searchBar.text?.isEmpty ?? true
    }
    
}
extension String{
    func replace(string:String, replacement:String) -> String {
        return self.replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
}
