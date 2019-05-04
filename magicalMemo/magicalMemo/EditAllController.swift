//
//  EditAllController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/04.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class EditAllController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var abstTextView: UITextView!
    @IBOutlet weak var figureTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isEnabled = true
        
        let realm = try! Realm()
        let memo = Memos()
        memos = realm.objects(Memos.self)
        let topMemo = memos[cellNumber] as Memos
        //memoTextをRealmに保存
        try! realm.write {
            titleTextField.text = topMemo.memoTitle
            memoTextView.text = topMemo.memoDetail
            abstTextView.text = topMemo.abstDetail
            figureTextView.text = topMemo.figureDetail
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //createDayLabelがRealmに入っていた場合表示
        //editDayLabelが修正された場合更新して表示
    }
    
    //    func textViewDidChange(_ textView: UITextView) {
    //        if let text = self.memoTextView.text, text.isEmpty{
    //            self.saveButton.isEnabled = true
    //        }else{
    //            self.saveButton.isEnabled = false
    //        }
    //    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
                let realm = try! Realm()
                //TitleをRealmに保存
                let memo = Memos()
                memos = realm.objects(Memos.self)
                let all = memos[cellNumber] as Memos
        
                //memoTextをRealmに保存
                try! realm.write {
        
                    //現在の日付を取得
                    let date:Date = Date()
                    //日付のフォーマットを指定する。
                    let format = DateFormatter()
                    format.dateFormat = "MM/dd"
                    //日付をStringに変換する
                    let sDate = format.string(from: date)
        
                    all.updateDay = "up: " + sDate
                    all.memoTitle = titleTextField.text ?? ""
                    all.memoDetail = memoTextView.text
                    all.abstDetail = abstTextView.text
                    all.figureDetail = figureTextView.text
                }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func add(_ sender: Any) {
        let realm = try! Realm()
        //TitleをRealmに保存
        let memo = Memos()
        memos = realm.objects(Memos.self)
        let all = memos[cellNumber] as Memos
        
        //memoTextをRealmに保存
        try! realm.write {
            
            //現在の日付を取得
            let date:Date = Date()
            //日付のフォーマットを指定する。
            let format = DateFormatter()
            format.dateFormat = "MM/dd"
            //日付をStringに変換する
            let sDate = format.string(from: date)
            
            all.updateDay = "up: " + sDate
            all.memoTitle = titleTextField.text ?? ""
            all.memoDetail = memoTextView.text
            all.abstDetail = abstTextView.text
            all.figureDetail = figureTextView.text
        }
    }
    
    @IBAction func trash(_ sender: Any) {
        let realm = try! Realm()
        try! realm.write {
            realm.delete(memos[cellNumber])
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
        }
    }
    
}
