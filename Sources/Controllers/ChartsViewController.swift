//
//  ChartsViewController.swift
//  CityOS-LED
//
//  Created by Said Sikira on 4/14/16.
//  Copyright © 2016 CityOS. All rights reserved.
//

import UIKit

class ChartsViewController: UIViewController {

    //MARK: Class variables
    var grandientBackgroundLayer = Gradient.mainGradient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackgroundViews()
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        grandientBackgroundLayer.frame = self.view.bounds
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return .LightContent
    }

}

extension ChartsViewController {
    func setupBackgroundViews() {
        grandientBackgroundLayer.frame = view.bounds
        view.layer.insertSublayer(grandientBackgroundLayer, atIndex: 0)
    }
}
