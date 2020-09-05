//
//  HomeViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/07/29.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        BGImagePickController.delegate = self
        BGImagePickController.allowsEditing = true
        
        DdayLabel.font = DdayLabel.font?.withSize(self.view.frame.height * 15 / 896)
        
        user1Button.layer.cornerRadius = user1Button.layer.frame.size.width/2.5
        user2Button.layer.cornerRadius = user2Button.layer.frame.size.width/2.5
        
        if let savedBG = localImageLoad(directory: .documentDirectory, fileName: "HomeBG") {
            BGImage.image = savedBG
        }
    }
    
    @IBOutlet weak var DdayLabel: UILabel!
    
    @IBOutlet weak var BGImage: UIImageView!
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userEditButton: UIButton!
    @IBOutlet weak var settingGetOutButton: UIButton!
    @IBOutlet weak var editBGButton: UIButton!
    @IBOutlet weak var editBGCloseButton: UIButton!
    
    @IBOutlet weak var user1Button: UIButton!
    @IBOutlet weak var user2Button: UIButton!
    
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

    func localImageLoad(directory: FileManager.SearchPathDirectory, fileName: String) -> UIImage? {
        let url = FileManager.default.urls(for: directory, in: .userDomainMask)[0].appendingPathComponent("\(fileName).jpeg")
        
        if FileManager.default.fileExists(atPath: url.path) {
            guard let cachedData = FileManager.default.contents(atPath: url.path) else { return nil }
            
            // 변환 가능 한 경우 success, 불가한 경우 failure
            if let cachedImage = UIImage(data: cachedData){
                return cachedImage
            }
        }
        
        return nil
    }
    
    func localImageSave(image: UIImage, directory :FileManager.SearchPathDirectory, fileName: String){
        let url = FileManager.default.urls(for: directory, in: .userDomainMask)[0].appendingPathComponent("\(fileName).jpeg")
        
        if FileManager.default.fileExists(atPath: url.path) {
            do {
               try FileManager.default.removeItem(atPath: url.path)
               // 기존 사진 제거
            }
            catch {
                fatalError("Home BG Image Not Exists")
            }
        }
        
        guard let transformedImage = image.jpegData(compressionQuality: 1) else {
            return
        }
        
        FileManager.default.createFile(atPath: url.path, contents: transformedImage)
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

// Ma
extension HomeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
    @IBAction func findNewPicture(_ sender: UIButton){
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

            localImageSave(image: newImage, directory: .documentDirectory, fileName: "HomeBG")
        }

        dismiss(animated: true, completion: nil)
        settingGetOutButton.isHidden = true
        editBGButton.isHidden = true
        editBGCloseButton.isHidden = true
    }
}
