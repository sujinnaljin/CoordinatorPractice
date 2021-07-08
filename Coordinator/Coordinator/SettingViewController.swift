//
//  SettingViewController.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class SettingViewController: UIViewController {
    weak var coordinator: SettingCoordinator?
    
    @IBAction func touchSignIn(_ sender: Any) {
        coordinator?.performTransition(to: .signIn)
    }
}
