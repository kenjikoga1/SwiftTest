//
//  TableContainer3.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/08.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class TableContainer3: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var noDateView: UIView!
    @IBOutlet weak var noDataBar: UIView!
    @IBOutlet weak var noDataCreate: UIView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(UINib(nibName: "RoundCell", bundle: nil), forCellReuseIdentifier: "RoundCell")
        
        let realm = try! Realm()
        memos = realm.objects(Memos.self)
        tableView.reloadData()
        
        noDateView.isHidden = true
        
        noDataBar.layer.cornerRadius = 5
        self.noDataBar.layer.shadowOpacity = 0.2
        self.noDataBar.layer.shadowRadius = 5
        self.noDataBar.layer.shadowColor = UIColor.black.cgColor
        self.noDataBar.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        noDataCreate.layer.cornerRadius = 25
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if memos.count == 0{
            noDateView.isHidden = false
        }else{
            noDateView.isHidden = true
        }
        //Realmを読み込む
        let realm = try! Realm()
        memos = realm.objects(Memos.self)
        tableView.reloadData()
        //読み込んだデータをtableCellに
        //tableViewをリロード
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if memos.count == 0{
            noDateView.isHidden = false
        }else{
            noDateView.isHidden = true
        }
        return memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RoundCell", for: indexPath) as! RoundCell
        //Realmのデータを読み込む
        let realm = try! Realm()
        let memo = memos[indexPath.row]
        //各Labelに保存内容を反映 indexPathでわける
        cell.uploadDayLabel.text = memo.updateDay
        cell.createDayLabel.text = memo.creatDay
        cell.titleLabel.text = memo.memoTitle
        cell.memoLabel.text = "F: " + memo.memoDetail
        cell.abstLabel.text = "A: " + memo.abstDetail
        cell.figureLabel.text = "D: " + memo.figureDetail
        
        let date = Date()
        let timeInterval = date.timeIntervalSince(memo.updateTime)
        let daySpan = timeInterval / 60 / 60 / 24
        //        print(timeInterval)
        //        print(daySpan)
        //更新日が一週間以上前なら枠だけにする
        //更新日が一週間以内なら塗りつぶす
        if daySpan >= 0.01{
            cell.round.backgroundColor = UIColor.white
            //枠線
            cell.round.layer.borderWidth = 1.0
            //枠線の色
            cell.round.layer.borderColor = UIColor(red: 0/255, green: 190/255, blue: 255/255, alpha: 1).cgColor
            cell.createDayLabel.textColor = UIColor(red: 0/255, green: 190/255, blue: 255/255, alpha: 1)
        }else{
            cell.round.backgroundColor = UIColor(red: 0/255, green: 190/255, blue: 255/255, alpha: 1)
            cell.createDayLabel.textColor = UIColor.white
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 85
    }
    //cellをクリックした場合
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        cellNumber = memos[indexPath.row].id
        performSegue(withIdentifier: "card", sender: memos[indexPath.row])
    }
    //Cellの削除
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        //Realmデータを削除
        let realm = try! Realm()
        try! realm.write {
            realm.delete(memos[indexPath.row])
            
        }
        //スワイプでCellを削除
        tableView.deleteRows(at: [indexPath], with: .automatic)
    }
    
    //遷移時にcellNumberをNewMemoControllerに送る
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //editMemoで遷移の場合
        if segue.identifier == "card"{
            let cd = segue.destination as? CardController
            cd?.cellNumber = self.cellNumber
            //newMemoで遷移の場合
        }else if segue.identifier == "newMemo"{
            let na = segue.destination as? NewAllController
            na?.cellNumber = memos.count
        }
    }
    
    func reloadTable()  {
        tableView.reloadData()
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
