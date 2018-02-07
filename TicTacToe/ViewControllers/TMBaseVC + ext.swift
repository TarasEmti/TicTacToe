//
//  TMBaseVC.swift
//  TicTacToe
//
//  Created by Тарас on 03.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMBaseVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(red: 0.927, green: 1.0, blue: 1.0, alpha: 1.0)
    }
}

extension UIViewController {
	
	static func nib() -> UINib {
		let fullName = NSStringFromClass(self.classForCoder())
		let name = fullName.components(separatedBy: ".").last!
		
		return UINib(nibName: name, bundle: Bundle.main)
	}
}
