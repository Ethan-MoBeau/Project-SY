//
//  newProfileViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/05.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit

class newProfileViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        usernameTextField.delegate = self
        birthdayTextField.delegate = self
        phoneNumberTextField.delegate = self
        commentTextField.delegate = self
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    // MARK: Text Edit Finish
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
          self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool{
        textfield.resignFirstResponder()
        return true
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
