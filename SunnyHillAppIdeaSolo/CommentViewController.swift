//
//  CommentViewController.swift
//  SunnyHillAppIdeaSolo
//
//  Created by Andrew James Kinsey on 5/15/18.
//  Copyright © 2018 The Cabinents. All rights reserved.
//

import UIKit

class CommentViewController: UIViewController {

    @IBOutlet var commentLabels: [UILabel]!
    var commentsArray = [String]()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        for i in 0..<commentLabels.count
        {
            commentLabels[i].text = commentsArray[i]
        }
    }
    

    
}
