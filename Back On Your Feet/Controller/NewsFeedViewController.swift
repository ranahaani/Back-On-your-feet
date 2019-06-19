//
//  NewsFeedViewController.swift
//  Back On Your Feet
//
//  Created by Talha khan on 17/04/2019.
//  Copyright © 2019 Talha khan. All rights reserved.
//

import UIKit
import WebKit
import SVProgressHUD
class NewsFeedViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let request = URLRequest(url: URL(string: "https://www.runtastic.com/blog/en")!)
        webView?.load(request)
    }
    


}
