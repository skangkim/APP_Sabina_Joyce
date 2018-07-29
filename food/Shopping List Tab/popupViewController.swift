//
//  popupViewController.swift
//  food
//
//  Created by J Lee on 7/28/18.
//  Copyright © 2018 J Lee. All rights reserved.
//

import UIKit

class popupViewController: UIViewController {

    var addedIngredient: Ingrd?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func addIngredientTapped(_ sender: Any) {
        //MARK: TODO: add the ingredient to the fridge
        //ingredient passed into this view controller as "addedIngredient"
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
