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

        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var moreButton: UIButton!
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var userEditButton: UIButton!
    @IBOutlet weak var settingGetOutButton: UIButton!
    
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
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
