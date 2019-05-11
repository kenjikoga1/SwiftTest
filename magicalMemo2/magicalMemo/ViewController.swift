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
    
    var table1: TableContainer1!
    var table2: TableContainer2!
    var table3: TableContainer3!
    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    @IBOutlet weak var container3: UIView!
    
    var memos: Results<Memos>!
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
        table1.reloadTable()
        table2.reloadTable()
        table3.reloadTable()
        
        container1.isHidden = false
        container2.isHidden = true
        container3.isHidden = true
        
        
//        let t2 = ViewController.self as! TableContainer2
//        t2.tableView.reloadData()
//        let t3 = ViewController.self as! TableContainer3
//        t3.tableView.reloadData()

    }
    
    @IBAction func sortUpdateDay(_ sender: Any) {
        table1.reloadTable()
        table2.reloadTable()
        table3.reloadTable()
        
        container1.isHidden = true
        container2.isHidden = false
        container3.isHidden = true
        
        
        
//        let t1 = ViewController.self as! TableContainer1
//        t1.tableView.reloadData()
//        let t3 = ViewController.self as! TableContainer3
//        t3.tableView.reloadData()

    }
    @IBAction func sortFavo(_ sender: Any) {
        table1.reloadTable()
        table2.reloadTable()
        table3.reloadTable()
        
        container1.isHidden = true
        container2.isHidden = true
        
        
//
//        let t1 = ViewController.self as! TableContainer1
//        t1.tableView.reloadData()
//        let t2 = ViewController.self as! TableContainer2
//        t2.tableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let t1 = segue.destination as? TableContainer1{
            self.table1 = t1
        }
        if let t2 = segue.destination as? TableContainer2{
            self.table2 = t2
        }
        if let t3 = segue.destination as? TableContainer3{
            self.table3 = t3
        }
        
        
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == "makeTable"{
//            let tc1 = segue.destination as? TableContainer1
//            tc1?.results = self.results
//        }
//        if segue.identifier == "updateTable" {
//            let tc2 = segue.destination as? TableContainer2
//            tc2?.results = self.results
//        }
//    }

}

