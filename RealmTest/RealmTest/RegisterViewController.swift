//
//  RegisterViewController.swift
//  RealmTest
//
//  Created by 古賀賢司 on 2019/05/02.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class RegisterViewController: UIViewController {

    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var genderTextField: UITextField!
    
    var person: Results<Model>!
    var cellNumber: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //新規で遷移した場合
        let realm = try! Realm()
        person = realm.objects(Model.self) //Model(Realmデータ)を読込
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //Cellから遷移した場合
        let realm = try! Realm()
        let setData = person[cellNumber]
        nameTextField.text = setData.name
        ageTextField.text = setData.age
        genderTextField.text = setData.gender
    }
    
    @IBAction func registerBtn(_ sender: Any) {
        
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let setData = person[cellNumber]
        
        try! realm.write {
            setData.name = nameTextField.text ?? ""
            setData.age = ageTextField.text ?? ""
            setData.gender = genderTextField.text ?? ""
            print("成功")
        }
        self.navigationController?.popViewController(animated: true)
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
