//
//  StartViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/07/29.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit

public enum SignInStatus {
    case signInSuccess
    case noUserProfile
    case noUserConnection
    case noSignInData
}

class StartViewController: UIViewController {

    @IBOutlet weak var StartButton: UIButton!
    @IBOutlet weak var AppName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StartButton.layer.cornerRadius = StartButton.frame.size.height / 3
        StartButton.titleLabel?.font = StartButton.titleLabel?.font.withSize(self.view.frame.height * 15 / 896)
        AppName.font = AppName.font.withSize(self.view.frame.height * 17 / 896)
        // Do any additional setup after loading the view.
    }
    
    // MARK: To Move VC
    @IBAction func goToNextStorybaord(_ sender: UIButton) {
        switch searchUserFromKeychain() {
            
        case .signInSuccess:
            let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
            guard let viewController = storyboard.instantiateViewController(withIdentifier: "MainHome") as? UITabBarController else {
                print("Cannot Segue to MainHome ViewController")
                return
            }
            
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
            
        case .noUserConnection:
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "makeNewConnect") else {
                print("Cannot Segue to MakeNewConnect ViewController")
                return
            }
            
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
            
        case .noUserProfile:
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "newProfile") else {
                print("Cannot Segue to newProfile ViewController")
                return
            }
            
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
            
        case .noSignInData:
            guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "SignIn") else {
                print("Cannot Segue to SignIn ViewController")
                return
            }
            
            viewController.modalPresentationStyle = .fullScreen
            present(viewController, animated: true)
        }
    }
    
    // MARK: Check Sign In Status
    func searchUserFromKeychain() -> SignInStatus {
        if let idToken = UserDefaults.standard.string(forKey: "userIdToken") {
            User.shared.setUserIdToken(idToken)
            
            if let userData = UserDefaults.standard.dictionary(forKey: "userData") {
                User.shared.setUserData(userData)
                
                if let connectionToken = UserDefaults.standard.string(forKey: "connectionToken"){
                    User.shared.setConnectionToken(connectionToken)
                    return .signInSuccess
                }
                else {
                    return .noUserConnection
                    
                }
            }
            else {
                return .noUserProfile
                
            }
        }
        else {
            return .noSignInData
        }
    }
}
