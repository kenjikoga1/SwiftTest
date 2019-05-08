//
//  ViewController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController{
    
    
    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        container1.isHidden = false
        container2.isHidden = true

    }
    
    override func viewWillAppear(_ animated: Bool) {

    }

    @IBAction func button1(_ sender: Any) {
        container1.isHidden = false
        container2.isHidden = true
    }
    
    @IBAction func button2(_ sender: Any) {
        container1.isHidden = true
        container2.isHidden = false
    }
    
    
}

