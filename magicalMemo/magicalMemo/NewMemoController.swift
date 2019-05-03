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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        memoTextView.delegate = self
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        //TitleをRealmに保存
        //memoTextをRealmに保存
        //topに戻る
    }
    
    @IBAction func newAbst(_ sender: Any) {
        //TitleをRealmに保存
        //memoTextをRealmに保存
        //abstControllerに遷移
        
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
