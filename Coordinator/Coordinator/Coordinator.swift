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
    
    func start() {
        let main = ViewController.instantiate()
        main.coordinator = self
        navigationController?.pushViewController(main, animated: true)
    }
    
    func goSingIn() {
        let signIn = SignInViewController.instantiate()
        signIn.coordinator = self
        navigationController?.pushViewController(signIn, animated: true)
    }
    
    func goSetting() {
        let setting = SettingViewController.instantiate()
        setting.coordinator = self
        navigationController?.pushViewController(setting, animated: true)
    }
}
