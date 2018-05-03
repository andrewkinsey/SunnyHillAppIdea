//
//  ViewController.swift
//  SunnyHillAppIdeaSolo
//
//  Created by Andrew James Kinsey on 4/29/18.
//  Copyright © 2018 The Cabinents. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var commentTextFields: [UITextField]!
    @IBOutlet var segmentedControllers: [UISegmentedControl]!
    @IBOutlet weak var teacherModeButton: UIBarButtonItem!
    
    let defaults = UserDefaults.standard
    var password = "test"
    var scores = [Int]() {
        didSet {
            defaults.set(scores, forKey: "SCORE")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let savedData = defaults.object(forKey: "SCORE") as? [Int] {
            scores = savedData
        }
        for i in 0..<segmentedControllers.count
        {
           segmentedControllers[i].selectedSegmentIndex = scores[i]
        }
    }
    
    @IBAction func editButtonTapped(_ sender: Any)
    {
        if teacherModeButton.title == "Edit"
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
                    for i in 0..<self.commentTextFields.count
                    {
                        self.commentTextFields[i].isEnabled = true
                    }
                    self.teacherModeButton.title = "Save"
                }
            }))
            present(alert, animated: true, completion: nil)
        }
        else if teacherModeButton.title == "Save"
        {
            scores.removeAll()
            for i in 0..<segmentedControllers.count
            {
                segmentedControllers[i].isEnabled = false
                scores.append(segmentedControllers[i].selectedSegmentIndex)
            }
            for i in 0..<commentTextFields.count
            {
                commentTextFields[i].isEnabled = false
            }
            teacherModeButton.title = "Edit"
            
        }
    }

}

