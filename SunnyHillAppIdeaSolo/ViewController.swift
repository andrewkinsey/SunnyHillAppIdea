//
//  ViewController.swift
//  SunnyHillAppIdeaSolo
//
//  Created by Andrew James Kinsey on 4/29/18.
//  Copyright © 2018 The Cabinents. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var scoreLabelsV: [UILabel]!
    @IBOutlet var scoreLabels: [UILabel]!
    @IBOutlet var commentTextFields: [UITextField]!
    @IBOutlet var segmentedControllers: [UISegmentedControl]!
    @IBOutlet weak var teacherModeButton: UIBarButtonItem!
    @IBOutlet weak var clearButton: UIBarButtonItem!
    
    let defaults = UserDefaults.standard
    var password = "test"
    var scores = [Int]() {
        didSet {
            defaults.set(scores, forKey: "SCORE")
        }
    }
    var comments = [String]() {
        didSet {
            defaults.set(comments, forKey: "COMMENT")
        }
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        if let savedData = defaults.object(forKey: "SCORE") as? [Int] {
            scores = savedData
        }
        else
        {
            for _ in 0..<segmentedControllers.count
            {
                scores.append(-1)
            }
        }
        if let savedData = defaults.object(forKey: "COMMENT") as? [String] {
            comments = savedData
        }
        else
        {
            comments = ["","","","","","","","","",""]
        }
        for i in  0..<commentTextFields.count
        {
            commentTextFields[i].text = comments[i]
        }
        for i in 0..<segmentedControllers.count
        {
           segmentedControllers[i].selectedSegmentIndex = scores[i]
        }
        
        totalScores()
    }
    
    func totalScores()
    {
        for i in 0..<scores.count
        {
            if scores[i] == -1
            {
                scores[i] = 0
            }
        }
        for i in 0...9
        {
                let totalHorizontalValue = scores[0+(3*i)] + scores[1+(3*i)] + scores[2+(3*i)]
                scoreLabels[i].text = "\(totalHorizontalValue)"
        }
        for i in 0...2
        {
            let totalVerticleValue = scores[0+i] + scores[3+i] + scores[6+i] + scores[9+i] + scores[12+i] + scores[15+i] + scores[18+i] + scores[21+i] + scores[24+i] + scores[27+i]
            scoreLabelsV[i].text = "\(totalVerticleValue)"
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
                    self.clearButton.isEnabled = true
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
            comments.removeAll()
            clearButton.isEnabled = false
            for i in 0..<segmentedControllers.count
            {
                segmentedControllers[i].isEnabled = false
                scores.append(segmentedControllers[i].selectedSegmentIndex)
            }
            for i in 0..<commentTextFields.count
            {
                commentTextFields[i].isEnabled = false
                if commentTextFields[i].text != nil
                {
                    comments.append(commentTextFields[i].text!)
                }
            }
            teacherModeButton.title = "Edit"
            totalScores()
        }
    }
    
    @IBAction func clearButtonTapped(_ sender: Any)
    {
        for i in 0..<segmentedControllers.count
        {
            segmentedControllers[i].selectedSegmentIndex = -1
        }
        for i in 0..<commentTextFields.count
        {
            commentTextFields[i].text = ""
        }
        totalScores()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        let dvc = segue.destination as? CommentViewController
        dvc?.commentsArray = comments
    }
}

