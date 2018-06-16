//
//  ViewController.swift
//  8
//
//  Created by Кривогузов Владислав on 15.06.18.
//  Copyright © 2018 Кривогузов Владислав. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var birthYearTF: UITextField!
    @IBOutlet weak var weightTF: UITextField!
    @IBOutlet weak var heightTF: UITextField!
    
    @IBOutlet weak var isMaleSC: UISegmentedControl!
    override func viewDidAppear(_ animated:Bool) {
        super.viewDidAppear(false)        
        let userDef = UserDefaults();
        if userDef.object(forKey: "name") != nil
        {
            print(String(describing: userDef.object(forKey: "name")))
            performSegue(withIdentifier: "afterReg", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    @IBAction func saveButtonClick(_ sender: Any) {
        //не проверяю на корректность
        if nameTF.text != "",birthYearTF.text != "",weightTF.text != "", heightTF.text != ""{
            let userDef = UserDefaults();
            userDef.set(nameTF.text , forKey: "name")
            userDef.set(birthYearTF.text, forKey: "birthYear")
            if(isMaleSC.selectedSegmentIndex==0){
                userDef.set("Male", forKey: "sex")
            }
            else{
                userDef.set("Female", forKey: "sex")
            }
            userDef.set(heightTF.text, forKey: "height")
            userDef.set(weightTF.text, forKey: "weight")
            print("User is added")
            performSegue(withIdentifier: "afterReg", sender: self)
        }
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

