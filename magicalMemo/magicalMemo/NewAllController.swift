//
//  NewAllController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/04.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class NewAllController: UIViewController {

    @IBOutlet weak var createDayLabel: UITextField!
    @IBOutlet weak var editDayLabel: UITextField!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var abstTextView: UITextView!
    @IBOutlet weak var figureTextView: UITextView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        createDayLabel.isHidden = true
//        editDayLabel.isHidden = true
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //createDayLabelがRealmに入っていた場合表示
        //editDayLabelが修正された場合更新して表示
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        let memo = Memos()
        
        //現在の日付を取得
        let date:Date = Date()
        //日付のフォーマットを指定する。
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd"
        //日付をStringに変換する
        let sDate = format.string(from: date)
        createDayLabel.text = sDate
        
        memo.creatDay = createDayLabel.text ?? ""
        memo.memoTitle = titleTextField.text ?? ""
        memo.memoDetail = memoTextView.text ?? ""
        memo.abstDetail = abstTextView.text ?? ""
        memo.figureDetail = figureTextView.text ?? ""
        
        try! realm.write {
            realm.add(memo)
        }
        
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
