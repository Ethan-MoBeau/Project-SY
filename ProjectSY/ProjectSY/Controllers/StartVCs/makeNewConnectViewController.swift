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

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var codeLabel: UILabel!
    
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
