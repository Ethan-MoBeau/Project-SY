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
                guard let token = userIdToken else {
                    print("No IdToken Result")
                    return
                }
                
                self.newUserKeyChainAdd(email: result.user.email ?? "", idToken: token)
                User.shared.setUserIdToken(token)
                
                /// 여기서 firestore에서 해당 토큰의 커넥션 찾기
                
                guard let viewController = self.storyboard?.instantiateViewController(withIdentifier: "makeNewConnect") else {
                    print("Cannot Segue to makeNewConnect ViewController")
                    return
                }
//                let storyboard = UIStoryboard(name: "TabBar", bundle: nil)
//                guard let viewController = storyboard.instantiateViewController(withIdentifier: "MainHome") as? UITabBarController else {
//                    print("Cannot Segue to MainHome ViewController")
//                    return
//                }
                
                viewController.modalPresentationStyle = .fullScreen
                self.present(viewController, animated: true)
            }
        }
    }
    
    func newUserKeyChainAdd(email: String, idToken: String){
        UserDefaults.standard.set(idToken, forKey: "idToken")
        UserDefaults.standard.set(email, forKey: "email")
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}
