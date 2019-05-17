//
//  ViewController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift
import GoogleMobileAds

class ViewController: UIViewController,GADBannerViewDelegate {
    
    var table1: TableContainer1!
    var table2: TableContainer2!
    var table3: TableContainer3!
    
    @IBOutlet weak var container1: UIView!
    @IBOutlet weak var container2: UIView!
    @IBOutlet weak var container3: UIView!
    
    
    @IBOutlet weak var makeLabel: UIButton!
    @IBOutlet weak var updateLabel: UIButton!
    @IBOutlet weak var favoriteLabel: UIButton!
    
    @IBOutlet weak var adBannerView: GADBannerView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    var results: Results<Memos>!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        makeLabel.layer.borderWidth = 0.3
        makeLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        updateLabel.layer.borderWidth = 0.3
        updateLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        favoriteLabel.layer.borderWidth = 0.3
        favoriteLabel.layer.borderColor = UIColor.lightGray.cgColor
        
        container1.isHidden = false
        container2.isHidden = true
        container3.isHidden = true
        
        adBannerView.adUnitID = "ca-app-pub-1331496561960773/3449977736"
        adBannerView.rootViewController = self
        adBannerView.delegate = self
        adBannerView.load(GADRequest())
        
    }
    
//    // 最下部に表示
//    override func viewDidLayoutSubviews(){
//        //  広告インスタンス作成
//        var admobView = GADBannerView()
//        admobView = GADBannerView(adSize:kGADAdSizeBanner)
//
//        //  広告位置設定
//        let safeArea = self.view.safeAreaInsets.bottom
//        admobView.frame.origin = CGPoint(x:0, y:self.view.frame.size.height - safeArea - admobView.frame.height)
//        admobView.frame.size = CGSize(width:self.view.frame.width, height:admobView.frame.height)
//
//        //  広告ID設定
//        admobView.adUnitID = "ca-app-pub-1331496561960773/5194326329"
//
//        //  広告表示
//        admobView.rootViewController = self
//        admobView.load(GADRequest())
//        self.view.addSubview(admobView)
//
//    }
    
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
        container3.isHidden = false
        
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

