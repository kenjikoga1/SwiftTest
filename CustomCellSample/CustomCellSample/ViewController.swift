//
//  ViewController.swift
//  CustomCellSample
//
//  Created by 古賀賢司 on 2019/05/02.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
//    var models = TableCell.createModels()
    var cellNumber: Int = 0
    var list: Results<TableCell>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        //CustomCellの接続
        self.tableView.register(UINib(nibName: "CustomTableViewCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        let realm = try! Realm()
        list = realm.objects(TableCell.self)
        tableView.reloadData()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    //Cellの高さを設定
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath)
        if let cell = cell as? CustomTableViewCell{ //CustomCellに接続
            cell.setupCell() //CustomCellにRealmデータを配列に移動してsetup
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailCell", sender: indexPath.row)
        cellNumber = indexPath.row
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detailCell"{
            
            let dc = segue.destination as! DetailViewController
            dc.cellNumber = cellNumber
            
        }
    }

}

