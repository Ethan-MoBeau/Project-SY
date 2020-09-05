//
//  imagePicker.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/05.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit

// 일단 관짝. 이 class 안에서 무조건 image를 처리해야 하다보니 작업 순서가 안 맞음.
class imagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    static let shared = imagePicker()
    
    private let ImagePickController = UIImagePickerController()
    var pickedImage: UIImage?
    private var callerVC: UIViewController!
    
    func findNewPicture(alertTitle: String, viewController: UIViewController){
        callerVC = viewController
        
        ImagePickController.delegate = self
        ImagePickController.allowsEditing = true
        
        let alert =  UIAlertController(title: alertTitle, message: nil, preferredStyle: .alert)

        let library =  UIAlertAction(title: "사진 앨범", style: .default) {
            (action) in
            self.ImagePickController.sourceType = .photoLibrary
            viewController.present (self.ImagePickController, animated: true, completion: nil)
        }

        let camera =  UIAlertAction(title: "카메라", style: .default) {
            (action) in
            self.ImagePickController.sourceType = .camera
            viewController.present (self.ImagePickController, animated: true, completion: nil)
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)

        alert.addAction(library)
        alert.addAction(camera)
        alert.addAction(cancel)
        
        viewController.present(alert,animated: true,completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let newImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage else {
            return
        }
        
        pickedImage = newImage
        //callerVC.dismiss(animated: true, completion: nil)
    }
}
