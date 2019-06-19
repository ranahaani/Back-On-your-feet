//
//  ProgressViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 04/05/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import Charts
class ProgressViewController: UIViewController {
    @IBOutlet weak var pieChartView: PieChartView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateChartData()        // Do any additional setup after loading the view.
    }
    func updateChartData()  {
        
        let chart = PieChartView(frame: self.view.frame)
        // 2. generate chart data entries
        let track = ["Blood Pressure Diastolic", "Diabetes", "Systolic", "Overall health"]
        let progress = [650, 456.13, 78.67, 856.52]
        
        var entries = [PieChartDataEntry]()
        for (index, value) in progress.enumerated() {
            let entry = PieChartDataEntry()
            entry.y = value
            entry.label = track[index]
            entries.append( entry)
        }
        
        // 3. chart setup
        let set = PieChartDataSet( values: entries, label: "Performance")
        // this is custom extension method. Download the code for more details.
        var colors: [UIColor] = []
        
        for _ in 0..<progress.count {
            let red = Double(arc4random_uniform(256))
            let green = Double(arc4random_uniform(256))
            let blue = Double(arc4random_uniform(256))
            let color = UIColor(red: CGFloat(red/255), green: CGFloat(green/255), blue: CGFloat(blue/255), alpha: 1)
            colors.append(color)
        }
        set.colors = colors
        let data = PieChartData(dataSet: set)
        chart.data = data
        chart.noDataText = "No data available"
        // user interaction
        chart.isUserInteractionEnabled = true
        
        let d = Description()
        d.text = "iOSCharts.io"
        chart.chartDescription = d
        chart.centerText = "Progress"
        chart.holeRadiusPercent = 0.2
        chart.transparentCircleColor = UIColor.clear
        self.view.addSubview(chart)
        
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
