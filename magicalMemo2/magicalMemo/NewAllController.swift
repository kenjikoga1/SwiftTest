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
    var isFirstText = false
    
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

        //Doneボタンの設定
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
        kbToolBar.items = [spacer, commitButton]
        memoTextView.inputAccessoryView = kbToolBar
        abstTextView.inputAccessoryView = kbToolBar
        figureTextView.inputAccessoryView = kbToolBar
        titleTextField.inputAccessoryView = kbToolBar

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector:
            #selector(self.handleKeyBoardWillShowNotification),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        notificationCenter.addObserver(self,
                                       selector:
            #selector(self.handleKeyboardWillHideNotification),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)

    }
    
    
    
//    override func viewDidDisappear(_ animated: Bool) {
//        super.viewDidDisappear(animated)
//
//        let notificationCenter = NotificationCenter.default
//        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
//        notificationCenter.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
//    }
    
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
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if (self.memoTextView.isFirstResponder) {
            self.memoTextView.resignFirstResponder()
        }
        if (self.abstTextView.isFirstResponder) {
            self.abstTextView.resignFirstResponder()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        newSave()
        self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
    }
    @IBAction func add(_ sender: Any) {
        newSave()
        
        let title = "保存しました"
        let message = "続けて新規メモを作成します。"
        let oeText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: oeText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)

        titleTextField.text = ""
        memoTextView.text = ""
        abstTextView.text = ""
        figureTextView.text = ""
        
    }
    
    //textViewにdoneボタンを付ける
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
    }

    func newSave() {
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
            
            realm.add(memo)
        }
        
    }
    

    
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        if (textView.tag == 1) {
            isFirstText = true
        } else {
            isFirstText = false
        }
        return true
    }
    @objc func handleKeyBoardWillShowNotification(notification: NSNotification){
        if (isFirstText == true) {
            return
        }
        let myBoundSize: CGSize = UIScreen.main.bounds.size
        scrollView.contentOffset.y = myBoundSize.height / 3
    }
    
    @objc func handleKeyboardWillHideNotification(notification: NSNotification) {
        scrollView.contentOffset.y = 0
    }
    
}
