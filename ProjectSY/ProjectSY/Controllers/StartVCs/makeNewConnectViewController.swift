//
//  makeNewConnectViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/05.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit

class makeNewConnectViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        if let connectionCode = User.shared.getUserData()?["connectionCode"] as? String {
            codeLabel.text = connectionCode
            getCodeButton.isHidden = true
            getCodeAgainButton.isHidden = false
        }
    }
    
    @IBOutlet weak var codeLabel: UILabel!
    
    @IBOutlet weak var getCodeButton: UIButton!
    @IBOutlet weak var getCodeAgainButton: UIButton!
    
    // MARK: Make Connection
    @IBAction func getConnectionCode(_ sender: Any) {
        let randomNum = arc4random_uniform(1000000)
        
        var temp = randomNum
        var digit = 0
        while temp > 0 {
            temp /= 10
            digit += 1
        }
        
        var labeltext: String = ""
        if 6-digit-1 >= 0 {
            for _ in 0...6-digit-1 {
                labeltext += "0"
            }
        }
        
        labeltext += String(randomNum)
        
        codeLabel.isHidden = false
        codeLabel.text = labeltext
        
        // delete last connectionCode
        if let lastConnectionCode = User.shared.getUserData()?["connectionCode"] as? String {
            AppDB.shared.removeData(collection: "connection", id: lastConnectionCode)
        }
        
        // server side
        AppDB.shared.addData(collection: "connection", id: labeltext, data: ["sender": User.shared.getUserIdToken()!])
        AppDB.shared.addSingleData(collection: "users", id: User.shared.getUserIdToken()!, data: ["connectionCode": labeltext])
        
        // local side
        User.shared.setSingleUserData(key: "connectionCode", value: labeltext)
        
        if getCodeButton.isHidden == false {
            getCodeButton.isHidden = true
        }
        if getCodeAgainButton.isHidden == true {
            getCodeAgainButton.isHidden = false
        }
    }
    
    @IBAction func writeConnectionCode(_ sender: Any) {
        let alert = UIAlertController(title: "연결코드 입력", message: nil, preferredStyle: .alert)

        let confirm = UIAlertAction(title: "확인", style: .default) { action in
         
        }

        let cancel = UIAlertAction(title: "취소", style: .cancel, handler: nil)


        alert.addAction(confirm)
        alert.addAction(cancel)
        alert.addTextField {
            textField in
            textField.placeholder = "연결코드 6자리를 입력하세요"
            textField.borderStyle = .roundedRect
            textField.clearButtonMode = .whileEditing
            textField.contentHorizontalAlignment = UIControl.ContentHorizontalAlignment.center
            textField.contentVerticalAlignment = UIControl.ContentVerticalAlignment.center
        }
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: Back to Profile View
    @IBAction func backToProfile(_ sender: Any) {
        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "newProfile") else {
            print("Cannot Segue to newProfile ViewController")
            return
        }
        
        viewController.modalPresentationStyle = .fullScreen
        self.present(viewController, animated: true)
    }
}
