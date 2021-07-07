//
//  ViewController.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {
    var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchSignIn(_ sender: Any) {
        let signInCoordinator = SignInCoordinator(navigationController: navigationController)
        signInCoordinator.start()
    }

    @IBAction func touchSetting(_ sender: Any) {
        let settingCoordinator = SettingCoordinator(navigationController: navigationController)
        settingCoordinator.start()
    }
}

