//
//  TabBarViewController.swift
//  food
//
//  Created by J Lee on 7/11/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

class TabBarViewController: UIViewController {
    var count = 0
    @IBOutlet weak var myLabel: UILabel!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        myLabel.text = "Count \(count)"
        count += 1
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        count = 1
    }
}
