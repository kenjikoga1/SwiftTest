//
//  DetailViewController.swift
//  CustomCellSample
//
//  Created by 古賀賢司 on 2019/05/02.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class DetailViewController: UIViewController,UITextFieldDelegate {
    
    @IBOutlet weak var nameTextFIeld: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    var cellNumber: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameTextFIeld.delegate = self
        ageTextField.delegate = self
        genderTextField.delegate = self
        
        //新規ボタンから遷移してきた場合
        
        //cellから遷移してきた場合 各textFieldに追記
        let realm = try! Realm()
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //編集の場合 Realmから読み込む
        let realm = try! Realm()
        let person = realm.objects(TableCell.self)
        
    }
    

    @IBAction func registerBtn(_ sender: Any) {
        do{
            let realm = try! Realm()
            print(Realm.Configuration.defaultConfiguration.fileURL)
            let person = TableCell()
            person.name = nameTextFIeld.text ?? ""
            person.age = Int(ageTextField.text!)!
            person.gender = genderTextField.text ?? ""
            //Realmに記録
            try! realm.write {
                realm.add(person)
                print("成功")
            }
            
        }catch{
            print("エラー")
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
