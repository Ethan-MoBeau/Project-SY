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
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
