//
//  SignInViewController.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class SignInViewController: UIViewController {
    weak var coordinator: SignInCoordinator?
    @IBAction func touchSetting(_ sender: Any) {
        coordinator?.performTransition(to: .setting)
    }
}
