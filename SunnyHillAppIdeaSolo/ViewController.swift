//
//  ViewController.swift
//  SunnyHillAppIdeaSolo
//
//  Created by Andrew James Kinsey on 4/29/18.
//  Copyright © 2018 The Cabinents. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var segmentedControllers: [UISegmentedControl]!
    
    var password = "test"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    
    @IBAction func editButtonTapped(_ sender: Any)
    {
        let alert = UIAlertController(title: "Enter Teacher Password", message: nil, preferredStyle: .alert)
        alert.addTextField { (passwordTextField) in
        }
        alert.addAction(UIAlertAction(title: "Done", style: .default, handler: { (action) in
            let userEnteredPassword = alert.textFields![0] as UITextField
            if userEnteredPassword.text == self.password
            {
                for i in 0..<self.segmentedControllers.count
                {
                    self.segmentedControllers[i].isEnabled = true
                }
                
            }
        }))
        present(alert, animated: true, completion: nil)
    }
    

}

