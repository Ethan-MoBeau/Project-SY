//
//  newProfileViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/05.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit
import FirebaseStorage

class newProfileViewController: UIViewController, UITextFieldDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

        ProfileImagePickController.delegate = self
        ProfileImagePickController.allowsEditing = true
        
        usernameTextField.delegate = self
        birthdayTextField.delegate = self
        phoneNumberTextField.delegate = self
        commentTextField.delegate = self
        
        let userData = User.shared.getUserData()
        usernameTextField.text = userData?["name"] as? String
        birthdayTextField.text = userData?["birthday"] as? String
        phoneNumberTextField.text = userData?["phone"] as? String
        commentTextField.text = userData?["comment"] as? String
        
        selectedProfileImage.layer.cornerRadius = selectedProfileImage.frame.size.width/2.5
        
        let recognizer = UITapGestureRecognizer(target: self, action: #selector(self.scrollViewTouch))
        recognizer.numberOfTapsRequired = 1
        recognizer.isEnabled = true
        recognizer.cancelsTouchesInView = false
        textScrollView.addGestureRecognizer(recognizer)
    }
    
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var birthdayTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var commentTextField: UITextField!
    
    @IBOutlet weak var selectedProfileImage: UIImageView!
    
    @IBOutlet weak var textScrollView: UIScrollView!
    
    let ProfileImagePickController = UIImagePickerController()
    var isAllTextFieldValid: Bool = false
    
    // MARK: Text Edit
    // 반응형으로 데이터 입력 완료되면 그때그때 시작하는 방향으로 개선하면 좋을듯
    func checkVaildity(){
        isAllTextFieldValid = isTextFieldValid(textField: phoneNumberTextField, regex: "^01([0|1|6|7|8|9])-([0-9]{3,4})-([0-9]{4})") && isTextFieldValid(textField: birthdayTextField, regex: "([0-9]{4}).([0-1]{1})([0-9]{1}.([0-3]{1})([0-9]{1}))")
    }
    
    @objc func scrollViewTouch(){
        checkVaildity()
        self.view.endEditing(true)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?){
        checkVaildity()
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textfield: UITextField) -> Bool{
        checkVaildity()
        textfield.resignFirstResponder()
        return true
    }
    
    func isTextFieldValid(textField: UITextField, regex: String) -> Bool{
        if textField.text == nil { return false }
        
        if !NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: textField.text) {
            textField.textColor = UIColor.red
            return false
        }
        else {
            textField.textColor = Colors.shared.customGrayFont
            return true
        }
    }
    
    var profileImage: UIImage? = nil
    
    // MARK: User Data Writing Finished
    @IBAction func finishWritingProfile(_ sender: Any) {
        isAllTextFieldValid = isAllTextFieldValid && (usernameTextField.text != nil) && (commentTextField.text != nil)
        
        if isAllTextFieldValid == true && profileImage != nil{
            guard let userIdToken = User.shared.getUserIdToken() else {
                print("No Sign In Status")
                return
            }
            guard let profileImageData = profileImage?.jpegData(compressionQuality: 1) else {
                print("jpeg Image Converting Failed")
                return
            }
            
            let uploadData: [String: Any] = [
                "name" : usernameTextField.text!,
                "birthday" : birthdayTextField.text!,
                "phone": phoneNumberTextField.text!,
                "comment": commentTextField.text!,
            ]
            
            let metadata = StorageMetadata()
            metadata.contentType = "image/jpg"
            let fileName: String = usernameTextField.text! + phoneNumberTextField.text!
            
            AppStorage.shared.upload(subPath: "images/\(fileName)/profile.jpg", uploadData: profileImageData,metadata: metadata)
            AppDB.shared.addData(collection: "users", id: userIdToken, data: uploadData)
            
            User.shared.setUserData(uploadData)
            UserDefaults.standard.set(uploadData, forKey: "userData")
            
            // To makeConnectVC
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "makeNewConnect") else {
                print("Cannot Segue to makeNewConnect ViewController")
                return
            }
            
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
        else if profileImage == nil {
            let alert = UIAlertController(title: "프로필 사진 등록", message: "프로필 사진이 등록되었는지 확인해주세요", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alert.addAction(cancel)
            present(alert,animated: true,completion: nil)
        }
        else {
            let alert = UIAlertController(title: "입력 오류", message: "빈 칸 없이 정확히 입력되었는지 확인해주세요", preferredStyle: .alert)
            
            let cancel = UIAlertAction(title: "확인", style: .cancel, handler: nil)
            
            alert.addAction(cancel)
            present(alert,animated: true,completion: nil)
        }
    }
    
    // MARK: Back to SignIn View
    @IBAction func backToSignIn(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃", message: "로그아웃 하시겠습니까?", preferredStyle: .alert)
        
        let yes = UIAlertAction(title: "예", style: .default) { action in
            User.shared.clean()
            
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") else {
                print("Cannot Segue to SignIn ViewController")
                return
            }
            
            viewController.modalPresentationStyle = .fullScreen
            self.present(viewController, animated: true)
        }
       
        let no = UIAlertAction(title: "아니오", style: .cancel, handler: nil)
        
        alert.addAction(no)
        alert.addAction(yes)
        present(alert, animated: true, completion: nil)
    }
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
            profileImage = newImage
        }

        dismiss(animated: true, completion: nil)
    }
}
