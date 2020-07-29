//
//  StartViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/07/29.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var AppName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        StartButton.layer.cornerRadius = 16
        StartButton.titleLabel?.font = StartButton.titleLabel?.font.withSize(self.view.frame.height * 15 / 896)
        AppName.font = AppName.font.withSize(self.view.frame.height * 17 / 896)
        // Do any additional setup after loading the view.
    }
    
    @IBAction func goToMainStorybaord(_ sender: UIButton) {

        let storyboard = UIStoryboard(name: "TabBar", bundle: nil)

        guard let viewController = storyboard.instantiateViewController(withIdentifier: "MainHome") as? UITabBarController else {
            print("에러 : Main으로 갈 수 없습니다")
            return
        }
        
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
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
