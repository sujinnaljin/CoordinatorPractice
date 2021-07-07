//
//  SettingViewController.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class SettingViewController: UIViewController {
    var coordinator: Coordinator?
    
    @IBAction func touchSignIn(_ sender: Any) {
        coordinator?.goSingIn()
    }
}
