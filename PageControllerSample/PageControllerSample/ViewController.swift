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
        
        containers = [viewController1,viewController2]
        
    }


}

