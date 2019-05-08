//
//  ViewController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    @IBOutlet weak var container3: UIView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    var results: Results<Memos>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        container1.isHidden = false
        container2.isHidden = true
        container3.isHidden = true
        
    }
    
    override func viewWillAppear(_ animated: Bool) {

    }

    @IBAction func sortMakeDay(_ sender: Any) {
        container1.isHidden = false
        container2.isHidden = true
        container3.isHidden = true
        
        let realm = try! Realm()
        let results = realm.objects(Memos.self).sorted(byKeyPath: "createTime", ascending: false)
    }
    
    @IBAction func sortUpdateDay(_ sender: Any) {
        container1.isHidden = true
        container2.isHidden = false
        container3.isHidden = true
        
        let realm = try! Realm()
        let results = realm.objects(Memos.self).sorted(byKeyPath: "updateTime", ascending: false)
    }
    @IBAction func sortFavo(_ sender: Any) {
        container1.isHidden = true
        container2.isHidden = true
        
        let realm = try! Realm()
        let results = realm.objects(Memos.self).sorted(byKeyPath: "createTime", ascending: false)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let tc1 = segue.destination as? TableContainer1
        tc1?.results = self.results
        let tc2 = segue.destination as? TableContainer2
        tc2?.results = self.results
    }

}

