//
//  Coordinator.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class MainCoordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let main = ViewController.instantiate()
        main.coordinator = self
        navigationController?.pushViewController(main, animated: true)
    }
}

class SignInCoordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signIn = SignInViewController.instantiate()
        signIn.coordinator = self
        navigationController?.pushViewController(signIn, animated: true)
    }
}


class SettingCoordinator {
    let navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let setting = SettingViewController.instantiate()
        setting.coordinator = self
        navigationController?.pushViewController(setting, animated: true)
    }
}
