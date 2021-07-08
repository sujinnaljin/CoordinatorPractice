//
//  Coordinator.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    var parentCoordinator: Coordinator? { get set }
    
    func start()
    func start(coordinator: Coordinator)
    func didFinish(coordinator: Coordinator)
    func removeChildCoordinators()
}

class BaseCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    var parentCoordinator: Coordinator?
    var navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        fatalError("Start method must be implemented")
    }
    
    func start(coordinator: Coordinator) {
        childCoordinators.append(coordinator) //addDependency
        coordinator.parentCoordinator = self
        coordinator.start()
    }
    
    //자기 자신 pop 됐을때 parentCoordinator?.didFinish(coordinator: self) 이런식으로
    func didFinish(coordinator: Coordinator) {
        if let index = childCoordinators.firstIndex(where: { $0 === coordinator }) {
            childCoordinators.remove(at: index)
        }
    }
    
    //다른걸로 넘어갈때 다른 vc 지우는 용도
    func removeChildCoordinators() {
        childCoordinators.forEach { $0.removeChildCoordinators() }
        childCoordinators.removeAll()
    }
}

class AppCoordinator: BaseCoordinator {
    override func start() {
        let coordinator = MainCoordinator(navigationController: navigationController)
        start(coordinator: coordinator) //그럼 처음에 자기 자신을 갖고 있는거지
    }
}

enum Transition {
    case signIn
    case setting
}

class MainCoordinator: BaseCoordinator {

    override func start() {
        let main = ViewController.instantiate()
        main.coordinator = self
        navigationController.pushViewController(main, animated: true)
    }
    
    func performTransition(to transition: Transition) {
        switch transition {
        case .signIn:
            removeChildCoordinators()
            let coordinator = SignInCoordinator(navigationController: navigationController)
            start(coordinator: coordinator)
        case .setting:
            removeChildCoordinators()
            let coordinator = SettingCoordinator(navigationController: navigationController)
            start(coordinator: coordinator)
        }
    }
}

class SignInCoordinator: BaseCoordinator {
    
    override func start() {
        let signIn = SignInViewController.instantiate()
        signIn.coordinator = self
        navigationController.pushViewController(signIn, animated: true)
    }
    
    func performTransition(to transition: Transition) {
        switch transition {
        case .setting:
            removeChildCoordinators()
            let coordinator = SettingCoordinator(navigationController: navigationController)
            start(coordinator: coordinator)
        default:
            break
        }
    }
}

class SettingCoordinator: BaseCoordinator {
   
    
    override func start() {
        let setting = SettingViewController.instantiate()
        setting.coordinator = self
        navigationController.pushViewController(setting, animated: true)
    }
    
    func performTransition(to transition: Transition) {
        switch transition {
        case .signIn:
            removeChildCoordinators()
            let coordinator = SignInCoordinator(navigationController: navigationController)
            start(coordinator: coordinator)
        default:
            break
        }
    }
}
