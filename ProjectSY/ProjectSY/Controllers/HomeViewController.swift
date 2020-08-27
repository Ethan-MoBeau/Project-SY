//
//  HomeViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/07/29.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        BGImagePickController.delegate = self
        BGImagePickController.allowsEditing = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var BGImage: UIImageView!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userEditButton: UIButton!
    @IBOutlet weak var settingGetOutButton: UIButton!
    @IBOutlet weak var editBGButton: UIButton!
    @IBOutlet weak var editBGCloseButton: UIButton!
    
    let BGImagePickController = UIImagePickerController()
    
    @IBAction func settingOpen(_ sender: UIButton) {
        // buttons show
        settingGetOutButton.isHidden = false
        editButton.isHidden = false
        userEditButton.isHidden = false
    }
    
    @IBAction func settingClose(_ sender: UIButton) {
        settingGetOutButton.isHidden = true
        editButton.isHidden = true
        userEditButton.isHidden = true
    }
    
    @IBAction func editOpen(_ sender: UIButton) {
        settingGetOutButton.isHidden = true
        editBGButton.isHidden = false
        editBGCloseButton.isHidden = false
    }
    
    @IBAction func editClose(_ sender: UIButton) {
        settingGetOutButton.isHidden = false
        editBGButton.isHidden = true
        editBGCloseButton.isHidden = true
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

extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBAction func findNewPicture(_ sender: UIButton) {
        let alert =  UIAlertController(title: "배경화면 변경", message: nil, preferredStyle: .actionSheet)

        let library =  UIAlertAction(title: "사진 앨범", style: .default) {
            (action) in
            self.BGImagePickController.sourceType = .photoLibrary
            self.present (self.BGImagePickController, animated: true, completion: nil)
        }

        let camera =  UIAlertAction(title: "카메라", style: .default) {
            (action) in
            self.BGImagePickController.sourceType = .camera
            self.present (self.BGImagePickController, animated: true, completion: nil)
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        present(alert,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let newImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {

            BGImage.image = newImage
            FileManager.default
        }
        
        dismiss(animated: true, completion: nil)
        settingGetOutButton.isHidden = true
        editBGButton.isHidden = true
        editBGCloseButton.isHidden = true
    }
}
