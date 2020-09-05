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

        ProfileImagePickController.delegate = self
        ProfileImagePickController.allowsEditing = true
        
        usernameTextField.delegate = self
        birthdayTextField.delegate = self
        phoneNumberTextField.delegate = self
        commentTextField.delegate = self
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var selectedProfileImage: UIImageView!
    
    let ProfileImagePickController = UIImagePickerController()
    
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

extension newProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func findNewPicture(_ sender: UIButton){
        let alert =  UIAlertController(title: "프로필 사진 선택", message: nil, preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진 앨범", style: .default) {
            (action) in
            self.ProfileImagePickController.sourceType = .photoLibrary
            self.present (self.ProfileImagePickController, animated: true, completion: nil)
        }

        let camera =  UIAlertAction(title: "카메라", style: .default) {
            (action) in
            self.ProfileImagePickController.sourceType = .camera
            self.present (self.ProfileImagePickController, animated: true, completion: nil)
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let newImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedProfileImage.image = newImage
        }

        dismiss(animated: true, completion: nil)
    }
}
