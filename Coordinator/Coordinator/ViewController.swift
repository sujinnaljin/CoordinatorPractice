//
//  ViewController.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

class ViewController: UIViewController {

    var coordinator: Coordinator?
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func touchSignIn(_ sender: Any) {
        coordinator?.goSingIn()
    }

    @IBAction func touchSetting(_ sender: Any) {
        coordinator?.goSetting()
    }
}

