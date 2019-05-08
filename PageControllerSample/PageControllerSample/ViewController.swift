//
//  ViewController.swift
//  PageControllerSample
//
//  Created by 古賀賢司 on 2019/05/07.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var viewController1: UIView!
    @IBOutlet weak var viewController2: UIView!
    
    var containers: Array<UIView> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewController1.isHidden = false
        viewController2.isHidden = true
        
    }

    @IBAction func button1(_ sender: Any) {
        viewController1.isHidden = false
        viewController2.isHidden = true
    }
    
    @IBAction func button2(_ sender: Any) {
        viewController1.isHidden = true
        viewController2.isHidden = false
    }
}

