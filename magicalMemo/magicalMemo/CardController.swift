//
//  CardController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/04.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class CardController: UIViewController,UITextViewDelegate {

    
    @IBOutlet weak var memoCard: UIView!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var memoTextView: UITextView!
    @IBOutlet weak var abstTextView: UITextView!
    @IBOutlet weak var figureTextView: UITextView!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var memoPlace: UILabel!
    @IBOutlet weak var abstPlace: UILabel!
    @IBOutlet weak var figurePlace: UILabel!
    
    var centerOfCard:CGPoint!
    var memos: Results<Memos>!
    var cellNumber = 0
    var cardNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        centerOfCard = memoCard.center
        
        memoTextView.delegate = self
        abstTextView.delegate = self
        figureTextView.delegate = self
        
        setPlaceHolder()
        
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
        cardNumber = cellNumber
        
        memoTextView.layer.cornerRadius = 10
        memoTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        abstTextView.layer.cornerRadius = 10
        abstTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]
        figureTextView.layer.cornerRadius = 10
        figureTextView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMaxXMinYCorner, .layerMinXMaxYCorner, .layerMinXMinYCorner]

    }
    
    func reset() {
        memoCard.center = self.centerOfCard
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
            print(cardNumber,cellNumber)
            if card.center.x < 75{
                reset()
                
                realmSet()
                cardNumber += 1
                if cardNumber >= memos.count{
                    cardNumber = 0
                }
                print(cardNumber,cellNumber)
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
                print(cardNumber,cellNumber)
            }
            
            UIView.animate(withDuration: 0.2) {
                self.reset()
            }
        }
    }
    
    

    
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
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        setPlaceHolder()
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
        let memo = Memos()
        memos = realm.objects(Memos.self)
        cellNumber = cardNumber
        let topMemo = memos[cardNumber] as Memos
        //memoTextをRealmに保存
        try! realm.write {
            titleTextField.text = topMemo.memoTitle
            memoTextView.text = topMemo.memoDetail
            abstTextView.text = topMemo.abstDetail
            figureTextView.text = topMemo.figureDetail
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
