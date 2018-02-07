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
        view.backgroundColor = TMGameLib.backgroundColor
    }
}

extension UIViewController {
	
	static func nib() -> UINib {
		let fullName = NSStringFromClass(self.classForCoder())
		let name = fullName.components(separatedBy: ".").last!
		
		return UINib(nibName: name, bundle: Bundle.main)
	}
}
