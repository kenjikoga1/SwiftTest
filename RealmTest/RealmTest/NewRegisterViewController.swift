//
//  NewRegisterViewController.swift
//  RealmTest
//
//  Created by 古賀賢司 on 2019/05/02.
//  Copyright © 2019 古賀賢司. All rights reserved.
//

import UIKit
import RealmSwift

class NewRegisterViewController: UIViewController {

    
    @IBOutlet weak var newNameTextFIeld: UITextField!
    @IBOutlet weak var newAgeTextField: UITextField!
    @IBOutlet weak var newGenderTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    @IBAction func newRegister(_ sender: Any) {
        let realm = try! Realm()
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        let model = Model()
        model.name = newNameTextFIeld.text ?? ""
        model.age = newAgeTextField.text ?? ""
        model.gender = newGenderTextField.text ?? ""
        
        try! realm.write {
            realm.add(model)
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
