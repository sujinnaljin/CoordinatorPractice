//
//  Coordinator.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}

class MainCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let main = ViewController.instantiate()
        main.coordinator = self
        navigationController?.pushViewController(main, animated: true)
    }
}

class SignInCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let signIn = SignInViewController.instantiate()
        signIn.coordinator = self
        navigationController?.pushViewController(signIn, animated: true)
    }
}


class SettingCoordinator: Coordinator {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController?) {
        self.navigationController = navigationController
    }
    
    func start() {
        let setting = SettingViewController.instantiate()
        setting.coordinator = self
        navigationController?.pushViewController(setting, animated: true)
    }
}
