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

enum Transition {
    case signIn
    case setting
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
    
    func performTransition(to transition: Transition) {
        var coordinator: Coordinator?
        switch transition {
        case .signIn:
            coordinator = SignInCoordinator(navigationController: navigationController)
        case .setting:
            coordinator = SettingCoordinator(navigationController: navigationController)
        }
        coordinator?.start()
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
    
    func performTransition(to transition: Transition) {
        var coordinator: Coordinator?
        switch transition {
        case .setting:
            coordinator = SettingCoordinator(navigationController: navigationController)
        default:
            break
        }
        coordinator?.start()
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
    
    func performTransition(to transition: Transition) {
        var coordinator: Coordinator?
        switch transition {
        case .signIn:
            coordinator = SignInCoordinator(navigationController: navigationController)
        default:
            break
        }
        coordinator?.start()
    }
}
