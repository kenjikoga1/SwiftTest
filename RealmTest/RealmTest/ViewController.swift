//
//  ViewController.swift
//  RealmTest
//
//  Created by 古賀賢司 on 2019/05/02.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var person: Results<Model>! //配列を作ることでRealmデータをindexPathで取れるようにする
    var cellNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        let realm = try! Realm()
        person = realm.objects(Model.self) //Model(Realmデータ)を読込
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let realm = try! Realm()
        person = realm.objects(Model.self) //Model(Realmデータ)を読込
        tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return person.count //Model数のカラム表示
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let realm = try! Realm()
        //各Labelを設定
        let nameLabel = cell.contentView.viewWithTag(1) as! UILabel
        let ageLabel = cell.contentView.viewWithTag(2) as! UILabel
        let genderLabel = cell.contentView.viewWithTag(3) as! UILabel
        
        //読込んだModelを各Labelに代入
        let list = person[indexPath.row]
        nameLabel.text = list.name
        ageLabel.text = list.age
        genderLabel.text = list.gender
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //Cellを選択して編集ページ
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellNumber = indexPath.row //cellNumberにindexPathの番号を代入
        performSegue(withIdentifier: "next", sender: indexPath.row) //indexPath.rowをCellの遷移先に送る
        
    }
    //RegisterVCにindexPath番号を渡す
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next"{
            let rc = segue.destination as! RegisterViewController
            rc.cellNumber = self.cellNumber
        }
    }
    
}

