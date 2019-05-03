//
//  EditMemoController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class EditMemoController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var editTextView: UITextView!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let realm = try! Realm()
        let memo = Memos()
        memos = realm.objects(Memos.self)
        let topMemo = memos[cellNumber] as Memos
        //memoTextをRealmに保存
        try! realm.write {
            titleTextField.text = topMemo.memoTitle
            editTextView.text = topMemo.memoDetail
        }
    }
    
    @IBAction func abstBtn(_ sender: Any) {
        let realm = try! Realm()
        
        let memo = Memos()
        //TitleをRealmに保存
        
        //memoTextをRealmに保存
        memos = realm.objects(Memos.self)
        let topMemo = memos[cellNumber] as Memos
        //memoTextをRealmに保存
        try! realm.write {
            topMemo.memoTitle = titleTextField.text ?? ""
            topMemo.memoDetail = editTextView.text
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