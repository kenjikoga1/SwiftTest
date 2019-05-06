//
//  NewAllController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/04.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class NewAllController: UIViewController,UITextViewDelegate {
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var abstTextView: UITextView!
    @IBOutlet weak var figureTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var memoPlace: UILabel!
    @IBOutlet weak var abstPlace: UILabel!
    @IBOutlet weak var figurePlace: UILabel!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isEnabled = false

        memoTextView.delegate = self
        abstTextView.delegate = self
        figureTextView.delegate = self
        
        memoTextView.layer.cornerRadius = 10
        memoTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        abstTextView.layer.cornerRadius = 10
        abstTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        figureTextView.layer.cornerRadius = 10
        figureTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]

    }
    
    override func viewWillAppear(_ animated: Bool) {

        //createDayLabelがRealmに入っていた場合表示
        //editDayLabelが修正された場合更新して表示
    }
    
    func textViewDidChange(_ textView: UITextView) {
        if memoTextView.text.isEmpty{
            self.saveButton.isEnabled = false
            memoPlace.isHidden = false
        }else{
            self.saveButton.isEnabled = true
            memoPlace.isHidden = true
        }
        if abstTextView.text.isEmpty{
            abstPlace.isHidden = false
        }else{
            abstPlace.isHidden = true
            self.saveButton.isEnabled = true
        }
        if figureTextView.text.isEmpty{
            figurePlace.isHidden = false
        }else{
            self.saveButton.isEnabled = true
            figurePlace.isHidden = true
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        let memo = Memos()

        //現在の日付を取得
        let date:Date = Date()
        //日付のフォーマットを指定する。
        let format = DateFormatter()
        format.dateFormat = "MMdd"
        //日付をStringに変換する
        let sDate = format.string(from: date)

        memos = realm.objects(Memos.self)

        memo.createTime = date
        
        memo.creatDay = sDate
        memo.memoTitle = titleTextField.text ?? ""
        memo.memoDetail = memoTextView.text ?? ""
        memo.abstDetail = abstTextView.text ?? ""
        memo.figureDetail = figureTextView.text ?? ""
        

        try! realm.write {
//            // 登録済みのデータを、プライマリキー"id"の降順で検索します。
//            let results = realm.objects(Memos.self).value(forKey: "id")
//            
//            // 登録件数を取得します。
//            let count = memos.count
//            
//            // プライマリキーのIDが重複しないように設定します。
//            let id: Int
//            if (count == 0) {
//                // 登録データが0件の場合
//                id = 0
//                
//            } else {
//                // 登録データがある場合
//                // IDは既存のID+1とします。
//                // データを削除している場合、"id"が歯抜けの可能性がありますが、
//                // 今回は考慮しません。
//                id = memo.id + 1
                
            realm.add(memo)
//            }
        }
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
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
