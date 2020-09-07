//
//  SignInViewController.swift
//  ProjectSY
//
//  Created by 한상현 on 2020/09/01.
//  Copyright © 2020 한상현. All rights reserved.
//

import UIKit
import FirebaseAuth
import GoogleSignIn

class SignInViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appName.font = appName.font.withSize(40 * self.view.frame.height / 812)
        
        googleSignInButton.layer.cornerRadius = googleSignInButton.frame.height/3
    }
    
    // MARK: Firebase Sign In
    func firebaseSignIn(firCredential credential: AuthCredential, userAuthentication authentication: GIDAuthentication){
        
        Auth.auth().signIn(with: credential) { (authDataResult, error) in
            guard error == nil else {
                print("Sign In Error")
                return
            }
            guard let result = authDataResult else {
                print("No Sign In Result")
                return
            }
            
            result.user.getIDToken { (userIdToken, error) in
                guard error == nil else {
                    print("Getting idToken Error")
                    return
                }
                guard let idToken = userIdToken else {
                    print("No IdToken Result")
                    return
                }
                
                UserDefaults.standard.set(userIdToken, forKey: "userIdToken")
                User.shared.setUserIdToken(idToken)
                
                /// 여기서 firestore에서 해당 토큰의 커넥션 찾기 필요  : 현재는 유저 확인까지만 완료된 상태
                
                if self.checkProfile(userIdToken: idToken){
                    let userData = User.shared.getUserData()
                    if userData?["connectionToken"] != nil {
                        /// 커넥션 매칭
                    }
                    else {
                        guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "makeNewConnect") else {
                            print("Cannot Segue to makeNewConnect ViewController")
                            return
                        }
                        
                        viewController.modalPresentationStyle = .fullScreen
                        self.present(viewController, animated: true)
                    }
                }
                else {
                    guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "newProfile") else {
                        print("Cannot Segue to newProfile ViewController")
                        return
                    }
                    
                    viewController.modalPresentationStyle = .fullScreen
                    self.present(viewController, animated: true)
                }
            }
//                let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
//                guard let viewController = storyboard.instantiateViewController(withIdentifier: "MainHome") as? UITabBarController else {
//                    print("Cannot Segue to MainHome ViewController")
//                    return
//                }
        }
    }
    
    func checkProfile(userIdToken: String) -> Bool{
        let db = AppDB.shared.db
        
        let ref = db.collection("users")
        
        ref.document(userIdToken).getDocument { (documentSnapshot, error) in
            if error != nil {
                print("Error getting documents: \(String(describing: error))")
            }
            else {
                if let downloadedData = documentSnapshot!.data() {
                    User.shared.setUserData(downloadedData)
                }
                else { print("No User Data from Server") }
            }
        }
        
        if User.shared.getUserData() == nil { return false }
        else { return true }
    }
    
    // MARK: Google Sign In
    
    @IBAction func googleSignInButtonTouchedDown(){
        googleSignInButton.layer.backgroundColor = CGColor.init(srgbRed: 66/255, green: 133/255, blue: 244/255, alpha: 1)
        googleSignInButton.titleLabel?.textColor = UIColor.white
    }
    
    @IBAction func googleSignInButtonTouchedUp(){
        googleSignInButton.layer.backgroundColor = UIColor.white.cgColor
        googleSignInButton.titleLabel?.textColor = UIColor.black
    }
    
    @IBAction func googleSignIn(){
        googleSignInButtonTouchedUp()
        
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().signIn()
    }
    
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var googleSignInButton: UIButton!
}
