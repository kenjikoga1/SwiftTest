//
//  CardController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/04.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class CardController: UIViewController,UITextViewDelegate,UITextFieldDelegate {

    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var memoCard: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var abstTextView: UITextView!
    @IBOutlet weak var figureTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var memoPlace: UILabel!
    @IBOutlet weak var abstPlace: UILabel!
    @IBOutlet weak var figurePlace: UILabel!
    @IBOutlet weak var make: UILabel!
    
    var centerOfCard:CGPoint!
    var memos: Results<Memos>!
    var cellNumber = 0
    var cardNumber = 0
    
    var isFirstText = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = memoCard.center
        
        memoTextView.delegate = self
        abstTextView.delegate = self
        figureTextView.delegate = self
        titleTextField.delegate = self
        
        setPlaceHolder()
        
        let realm = try! Realm()
        let memos = realm.objects(Memos.self)
        let topMemo = realm.object(ofType: Memos.self, forPrimaryKey: cellNumber)
        
        try! realm.write {
            titleTextField.text = topMemo?.memoTitle
            memoTextView.text = topMemo?.memoDetail
            abstTextView.text = topMemo?.abstDetail
            figureTextView.text = topMemo?.figureDetail
        }
        //index番号を取得
        let indexNumber = memos.index(of: topMemo!)
        //cardNumberにindex番号を入れる
        cardNumber = indexNumber!
        print(cardNumber)

        
        memoTextView.layer.cornerRadius = 10
        memoTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        abstTextView.layer.cornerRadius = 10
        abstTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        figureTextView.layer.cornerRadius = 10
        figureTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        
        memoCard.layer.cornerRadius = 10
        memoCard.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        // 影の設定
        self.memoCard.layer.shadowOpacity = 0.2
        self.memoCard.layer.shadowRadius = 20
        self.memoCard.layer.shadowColor = UIColor.black.cgColor
        self.memoCard.layer.shadowOffset = CGSize(width: 0, height: 5)
        
        var date = Date()
        date = topMemo!.createTime
        let format = DateFormatter()
        format.dateFormat = "yyyy/MM/dd H:mm"
        let sDate = format.string(from: date)
        make.text = "create" + sDate
        
        //Doneボタンの設定
        let kbToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 320, height: 40))
        kbToolBar.barStyle = UIBarStyle.default  // スタイルを設定
        kbToolBar.sizeToFit()  // 画面幅に合わせてサイズを変更
        // スペーサー
        let spacer = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: self, action: nil)
        // 閉じるボタン
        let commitButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.done, target: self, action: #selector(self.commitButtonTapped))
        kbToolBar.items = [spacer, commitButton]
        titleTextField.inputAccessoryView = kbToolBar
        memoTextView.inputAccessoryView = kbToolBar
        abstTextView.inputAccessoryView = kbToolBar
        figureTextView.inputAccessoryView = kbToolBar
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setPlaceHolder()
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        titleTextField.resignFirstResponder()
        return true
    }
    
    func reset() {
//        memoCard.center = self.centerOfCard
//        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height

        memoCard.center = CGPoint(x: view.frame.width / 2, y: (view.frame.height / 2) - 20)
        memoCard.transform = .identity
    }
    
    
    @IBAction func swip(_ sender: UIPanGestureRecognizer) {
        let card = sender.view!
        let point = sender.translation(in: view)
        
        card.center = CGPoint(x: card.center.x + point.x, y: card.center.y + point.y)
        
//        let xPointCard = card.center.x - view.center.x
//        card.transform = CGAffineTransform(rotationAngle: xPointCard / (view.frame.width / 2) * -0.785)
        //ドラッグを離した時
        if sender.state == UIGestureRecognizer.State.ended{
//            print(cardNumber,cellNumber)
            if card.center.x < 75{
                reset()
                
                realmSet()
                cardNumber += 1
                if cardNumber >= memos.count{
                    cardNumber = 0
                }
//                print(cardNumber,cellNumber)
            }else if card.center.x > view.frame.width - 75{
                reset()
                
                realmSet()
                cardNumber -= 1
                if cardNumber >= memos.count{
                    cardNumber = memos.count - 1
                }
                if cardNumber <= -1{
                    cardNumber = memos.count - 1
                }
//                print(cardNumber,cellNumber)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.reset()
            }
        }
    }
    
    @IBAction func saveBtn(_ sender: Any) {
        
        let realm = try! Realm()
        
//        let memos = realm.objects(Memos.self)
        let topMemo = realm.object(ofType: Memos.self, forPrimaryKey: cellNumber)
        
        //memoTextをRealmに保存
        try! realm.write {
            
            //現在の日付を取得
            let date:Date = Date()
            //日付のフォーマットを指定する。
            let format = DateFormatter()
            format.dateFormat = "MM/dd"
            //日付をStringに変換する
            let sDate = format.string(from: date)
            
            topMemo?.updateTime = date
            
            topMemo?.updateDay = "up: " + sDate
            topMemo?.memoTitle = titleTextField.text ?? ""
            topMemo?.memoDetail = memoTextView.text
            topMemo?.abstDetail = abstTextView.text
            topMemo?.figureDetail = figureTextView.text

        }
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func add(_ sender: Any) {
        let realm = try! Realm()
        //TitleをRealmに保存
//        let memos = realm.objects(Memos.self)
        let topMemo = realm.object(ofType: Memos.self, forPrimaryKey: cellNumber)
        
        //memoTextをRealmに保存
        try! realm.write {
            
            //現在の日付を取得
            let date:Date = Date()
            //日付のフォーマットを指定する。
            let format = DateFormatter()
            format.dateFormat = "MM/dd"
            //日付をStringに変換する
            let sDate = format.string(from: date)
            
            topMemo?.updateDay = "up: " + sDate
            topMemo?.memoTitle = titleTextField.text ?? ""
            topMemo?.memoDetail = memoTextView.text
            topMemo?.abstDetail = abstTextView.text
            topMemo?.figureDetail = figureTextView.text
        }
        
        let title = "保存しました"
        let message = "新規メモを作成します。"
        let oeText = "OK"
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okayButton = UIAlertAction(title: oeText, style: UIAlertAction.Style.cancel, handler: nil)
        alert.addAction(okayButton)
        present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func trash(_ sender: Any) {
        let realm = try! Realm()
//        let memos = realm.objects(Memos.self)
        try! realm.write {
            realm.delete(realm.object(ofType: Memos.self, forPrimaryKey: cellNumber)!)
            self.navigationController?.popToViewController(navigationController!.viewControllers[0], animated: true)
        }
    }
    
//    func textViewDidChange(_ textView: UITextView) {
//        setPlaceHolder()
//    }
    
    func setPlaceHolder(){
        if memoTextView.text.isEmpty{
            memoPlace.isHidden = false
        }else{
            memoPlace.isHidden = true
        }
        if abstTextView.text.isEmpty{
            abstPlace.isHidden = false
        }else{
            abstPlace.isHidden = true
        }
        if figureTextView.text.isEmpty{
            figurePlace.isHidden = false
        }else{
            figurePlace.isHidden = true
        }
    }
    
    func realmSet() {
        let realm = try! Realm()
        memos = realm.objects(Memos.self)
        let moveMemo = memos[cardNumber] as Memos
        //memoTextをRealmに保存
        try! realm.write {
            titleTextField.text = moveMemo.memoTitle
            memoTextView.text = moveMemo.memoDetail
            abstTextView.text = moveMemo.abstDetail
            figureTextView.text = moveMemo.figureDetail
        }
    }
    
    //textViewのアクティブ状況を返す
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {

        if textView.tag == 1{
            isFirstText = true
        }else{
            isFirstText = false
        }
        return true
    }
    
    @objc func handleKeyBoardWillShowNotification(notification: NSNotification){
        if isFirstText == true {
            return
        }

        let myBoundSize: CGSize = UIScreen.main.bounds.size

            UIView.animate(withDuration: 100, animations: {
            let transform = CGAffineTransform(translationX: 0, y: -(myBoundSize.height / 3))
            self.view.transform = transform},completion:nil)
        
    }
    
    @objc func handleKeyboardWillHideNotification(_ notification: Notification?) {
        let duration = (notification?.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! Double)
                UIView.animate(withDuration: 100, animations:{
                    self.view.transform = CGAffineTransform.identity},completion:nil)
    }
    
    @objc func commitButtonTapped() {
        self.view.endEditing(true)
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
