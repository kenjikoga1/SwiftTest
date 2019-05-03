//
//  EditFigureController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class EditFigureController: UIViewController {

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
            editTextView.text = topMemo.figureDetail
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let realm = try! Realm()
        let memo = Memos()
        memos = realm.objects(Memos.self)
        let topMemo = memos[cellNumber] as Memos
        //memoTextをRealmに保存
        try! realm.write {
            topMemo.memoTitle = titleTextField.text ?? ""
            topMemo.figureDetail = editTextView.text
        }
        //topに戻る
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }
    


}
