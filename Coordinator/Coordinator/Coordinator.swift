//
//  Coordinator.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class Coordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func goSingIn() {
        let signIn = SignInViewController.instantiate()
        navigationController?.pushViewController(signIn, animated: true)
    }
    
    func goSetting() {
        let setting = SettingViewController.instantiate()
        navigationController?.pushViewController(setting, animated: true)
    }
}
