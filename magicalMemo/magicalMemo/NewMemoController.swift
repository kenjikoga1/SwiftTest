//
//  NewMemoController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class NewMemoController: UIViewController,UITextViewDelegate {

    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    var sameColum = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.delegate = self
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        let realm = try! Realm()
//        memos = realm.objects(Memos.self)
//        //戻ってきたときの読込にRealmデータを加える
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        let memo = Memos()
        //TitleをRealmに保存
        memo.memoTitle = titleTextField.text ?? ""
        memo.memoDetail = memoTextView.text ?? ""
        //memoTextをRealmに保存
        try! realm.write {
            realm.add(memo)
            print("成功")
        }
        //topに戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func newAbst(_ sender: Any) {
        //TitleをRealmに保存
        //memoTextをRealmに保存
        //abstControllerに遷移
        let realm = try! Realm()
        let memo = Memos()
        //TitleをRealmに保存
        memo.memoTitle = titleTextField.text ?? ""
        memo.memoDetail = memoTextView.text ?? ""
        
        //memoTextをRealmに保存
        try! realm.write {
            realm.add(memo)
            print("成功")
        
        }
    }
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let na = segue.destination as? NewAbstController
        na?.cellNumber = self.cellNumber
    }
}
