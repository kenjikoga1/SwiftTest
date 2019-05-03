//
//  NewAbstController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class NewAbstController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    @IBOutlet weak var abstTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Realmのデータを取得してTitleを表示
        let realm = try! Realm()
        memos = realm.objects(Memos.self)
        let abstTitle = memos[cellNumber].value(forKey: "memoTitle")
        titleLabel.text = abstTitle as? String
        //取得したカラムを代入
        
    }
    
    @IBAction func savrBtn(_ sender: Any) {
        
        //作ったカラムの空白に新たにabstDetailを加える
        let realm = try! Realm()        
        
        //TitleをRealmに保存
        let memo = Memos()
        memos = realm.objects(Memos.self)
        var abst = memos[cellNumber].value(forKey: "abstDetail")
        //memoTextをRealmに保存
        try! realm.write {
            
            abst = abstTextView.text
            print(memos)
            print(memo)
//            memo.abstDetail = abst as! String
//            realm.add(memo)
            print("成功")
        }
        //topに戻る
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func newFigure(_ sender: Any) {
        //TitleをRealmに保存
        //memoTextをRealmに保存
        //abstControllerに遷移
        let realm = try! Realm()
        let memo = Memos()
        //TitleをRealmに保存
        memo.abstDetail = abstTextView.text ?? ""
        
        //memoTextをRealmに保存
        try! realm.write {
            realm.add(memo)
            print("成功")
            
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
