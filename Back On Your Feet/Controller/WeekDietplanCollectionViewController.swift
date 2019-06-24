//
//  WeekDietplanCollectionViewController.swift
//  Back On Your Feet
//
//  Created by Muhammad Abdullah on 23/06/2019.
//  Copyright © 2019 Muhammad Abdullah. All rights reserved.
//

import UIKit


class WeekDietplanCollectionViewController: UIViewController, UICollectionViewDelegate,UICollectionViewDataSource {
    let weeklyDeitPlan = ["Week 1","Week 2","Week 3"]
    let imagesArray = ["firstWeekDietPlan","secondWeek","thirdWeek"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }




     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return weeklyDeitPlan.count
    }

     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! WeeklyCollectionViewCell
        cell.WeeklyDietPlanImage.image = UIImage(named: imagesArray[indexPath.row])
        cell.WeekLyDietPlanLabel.text = weeklyDeitPlan[indexPath.row]
    
        return cell
    }



}
