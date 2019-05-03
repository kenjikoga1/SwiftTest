//
//  ViewController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var titleView: UIView!
    @IBOutlet weak var abstView: UIView!
    @IBOutlet weak var figureView: UIView!
    
    @IBOutlet weak var tableView: UITableView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "CustomCell", bundle: nil), forCellReuseIdentifier: "CustomCell")
        
        //Realmにデータが有ればデータを取得
        //読み込んだデータをtableCellに
        //tableViewをリロード

        let realm = try! Realm()
        memos = realm.objects(Memos.self)
        tableView.reloadData()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Realmを読み込む
        let realm = try! Realm()
        memos = realm.objects(Memos.self)
        tableView.reloadData()
        //読み込んだデータをtableCellに
        //tableViewをリロード
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CustomCell", for: indexPath) as! CustomCell
        //Realmのデータを読み込む
        let realm = try! Realm()
        let memo = memos[indexPath.row]
        //各Labelに保存内容を反映 indexPathでわける
        cell.titleLabel.text = memo.memoTitle
        cell.memoLabel.text = memo.memoDetail
        cell.abstLabel.text = memo.abstDetail
        cell.figureLabel.text = memo.figureDetail
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    //cellをクリックした場合
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellNumber = indexPath.row
        performSegue(withIdentifier: "editMemo", sender: memos[indexPath.row])
    }
    //遷移時にcellNumberをNewMemoControllerに送る
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //editMemoで遷移の場合
        if segue.identifier == "editMemo"{
            let em = segue.destination as? EditMemoController
            em?.cellNumber = self.cellNumber
        //newMemoで遷移の場合
        }else if segue.identifier == "newMemo"{
            let nm = segue.destination as? NewMemoController
            nm?.cellNumber = memos.count
        }
    }

}

