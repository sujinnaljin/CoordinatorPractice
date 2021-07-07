//
//  ViewController.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchSignIn(_ sender: Any) {
        let signIn = SignInViewController.instantiate()
        self.navigationController?.pushViewController(signIn, animated: true)
    }

    @IBAction func touchSetting(_ sender: Any) {
        let setting = SettingViewController.instantiate()
        self.navigationController?.pushViewController(setting, animated: true)
    }
}

