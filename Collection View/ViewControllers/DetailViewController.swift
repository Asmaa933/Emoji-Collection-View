//
//  DetailViewController.swift
//  Collection View
//
//  Created by Asmaa on 2/22/19.
//  Copyright © 2019 Asmaa. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    var selection : String!
    
    @IBOutlet weak var detailsLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
detailsLabel.text = selection
        // Do any additional setup after loading the view.
    }
    
}
