//
//  NewAllController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/04.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class NewAllController: UIViewController,UITextViewDelegate, UITextFieldDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var abstTextView: UITextView!
    @IBOutlet weak var figureTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var figureTextViewHeight: NSLayoutConstraint!

    
    @IBOutlet weak var memoPlace: UILabel!
    @IBOutlet weak var abstPlace: UILabel!
    @IBOutlet weak var figurePlace: UILabel!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    var isObserving = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.saveButton.isEnabled = false

        titleTextField.delegate = self
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
        super.viewWillAppear(animated)
                // Viewの表示時にキーボード表示・非表示を監視するObserverを登録する
        if(!isObserving) {
            let notification = NotificationCenter.default
            notification.addObserver(self,
                                     selector: #selector(self.keyboardWillShow),
                                     name: UIResponder.keyboardWillShowNotification,
                                     object: nil)
            
            notification.addObserver(self,
                                     selector: #selector(self.keyboardWillHide),
                                     name: UIResponder.keyboardWillHideNotification,
                                     object: nil)
            isObserving = true
        }
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
    
    func textViewDidEndEditing(_ textView: UITextView) {
        memoTextView.resignFirstResponder()
        abstTextView.resignFirstResponder()
        figureTextView.resignFirstResponder()
        
    }
    

    
    @IBAction func saveBtn(_ sender: Any) {
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL)
        
        try! realm.write {
            let memo = Memos()
            
            //現在の日付を取得
            let date:Date = Date()
            //日付のフォーマットを指定する。
            let format = DateFormatter()
            format.dateFormat = "MMdd"
            //日付をStringに変換する
            let sDate = format.string(from: date)
            
            
            if memo.id <= Memos.lastId(){
                memo.id = Memos.lastId() + 1
            }else{
                memo.id = Memos.lastId()
            }
            
            
            
            memo.createTime = date
            
            memo.creatDay = sDate
            memo.memoTitle = titleTextField.text ?? ""
            memo.memoDetail = memoTextView.text ?? ""
            memo.abstDetail = abstTextView.text ?? ""
            memo.figureDetail = figureTextView.text ?? ""
            
//            // 登録件数を取得します。
//            let count = memos.count
//            // プライマリキーのIDが重複しないように設定します。
//            if (count == 0) {
//                // 登録データが0件の場合
//                memo.id = 0
//            } else {
//                // 登録データがある場合
//                // IDは既存のID+1とします。
//                // データを削除している場合、"id"が歯抜けの可能性がありますが、
//                // 今回は考慮しません。
//                memo.id = cellNumber
//            }
            realm.add(memo)
        }
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }
    

    
    //*********************** キーボード選択時に画面が上がる ***********************
    @objc func keyboardWillShow() {
        // キーボード表示時の動作をここに記述する
        // let rect = (notification?.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        // let duration:TimeInterval = notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double
        UIView.animate(withDuration: 100, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -250)
            self.view.transform = transform},completion:nil)
    }
    @objc func keyboardWillHide() {
        // キーボード消滅時の動作をここに記述する
        // let duration = (notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
        UIView.animate(withDuration: 100, animations:{
            self.view.transform = CGAffineTransform.identity},completion:nil)
    }
//*********************** キーボード選択時に画面が上がる ***********************
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
