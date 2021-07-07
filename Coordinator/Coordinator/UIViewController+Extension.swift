//
//  UIViewController+Extension.swift
//  Coordinator
//
//  Created by 강수진 on 2021/07/08.
//

import UIKit

extension UIViewController {
    static func instantiate() -> Self {
        let className = String(describing: self)
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        return storyboard.instantiateViewController(withIdentifier: className) as! Self
    }
}
