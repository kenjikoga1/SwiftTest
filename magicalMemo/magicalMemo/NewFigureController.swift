//
//  NewFigureController.swift
//  magicalMemo
//
//  Created by 古賀賢司 on 2019/05/03.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class NewFigureController: UIViewController {

    @IBOutlet weak var figureTextView: UITextView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var memos: Results<Memos>!
    var cellNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let realm = try! Realm()
        memos = realm.objects(Memos.self)
        let abstTitle = memos[cellNumber].value(forKey: "memoTitle")
        titleLabel.text = abstTitle as? String
    }
    

    @IBAction func savrBtn(_ sender: Any) {
        //作ったカラムの空白に新たにabstDetailを加える
        let realm = try! Realm()
        //TitleをRealmに保存
        let memo = Memos()
        memos = realm.objects(Memos.self)
        let figure = memos[cellNumber] as Memos
        //memoTextをRealmに保存
        try! realm.write {
            figure.figureDetail = figureTextView.text
            realm.add(memo)
        }
        //topに戻る
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
