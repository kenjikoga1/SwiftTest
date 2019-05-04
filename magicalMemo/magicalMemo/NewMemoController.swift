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
    @IBOutlet weak var abstButton: UIButton!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.delegate = self
        //abstBtnを非表示
        abstButton.isHidden = true
    }
        
    @IBAction func saveBtn(_ sender: Any) {
        
        if let text = memoTextView.text, !text.isEmpty{
            let realm = try! Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL)
            
            let memo = Memos()
            //TitleをRealmに保存
            let date:Date = Date()
            //日付のフォーマットを指定する。
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd"
            //日付をStringに変換する
            let sDate = format.string(from: date)
            
            memo.creatDay = sDate
            memo.memoTitle = titleTextField.text ?? ""
            memo.memoDetail = memoTextView.text ?? ""
            //memoTextをRealmに保存
            try! realm.write {
                realm.add(memo)
            }
            //topに戻る
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func newAbst(_ sender: Any) {
        //TitleをRealmに保存
        //memoTextをRealmに保存
        //abstControllerに遷移
        if let text = memoTextView.text, !text.isEmpty{
            let realm = try! Realm()
            let memo = Memos()
            //TitleをRealmに保存
            let date:Date = Date()
            //日付のフォーマットを指定する。
            let format = DateFormatter()
            format.dateFormat = "yyyy/MM/dd"
            //日付をStringに変換する
            let sDate = format.string(from: date)
//            createDayLabel.text = sDate
            
            memo.creatDay = sDate
            memo.memoTitle = titleTextField.text ?? ""
            memo.memoDetail = memoTextView.text ?? ""
            
            //memoTextをRealmに保存
            try! realm.write {
                realm.add(memo)
                
            }
        }
    }
    //textViewに文字が入ったら
    func textViewDidChange(_ textView: UITextView) {
        if let text = memoTextView.text, text.isEmpty{
            abstButton.isHidden = true
        }else{
            abstButton.isHidden = false
        }
    }
    


    
     // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let na = segue.destination as? NewAbstController
        na?.cellNumber = self.cellNumber
    }
}
