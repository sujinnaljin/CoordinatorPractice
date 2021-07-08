//
//  ViewController.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {
    weak var coordinator: MainCoordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchSignIn(_ sender: Any) {
        coordinator?.performTransition(to: .signIn)
    }

    @IBAction func touchSetting(_ sender: Any) {
        coordinator?.performTransition(to: .setting)
    }
}

