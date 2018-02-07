//
//  TMGameMenuVC.swift
//  TicTacToe
//
//  Created by Тарас on 03.02.2018.
//  Copyright © 2018 Taras Minin. All rights reserved.
//

import UIKit

class TMGameMenuVC: TMBaseVC {
	
	let appIcon: UIImageView!
	let buttonPlay: UIButton!
	let buttonSettings: UIButton!
	let buttonStats: UIButton!
	let buttonInfo: UIButton!
	
	init() {
		self.appIcon = UIImageView(image: UIImage(named: "app_icon"))
		self.buttonPlay = UIButton(type: .system)
		self.buttonSettings = UIButton(type: .system)
		self.buttonStats = UIButton(type: .system)
		self.buttonInfo = UIButton(type: .system)
		
		super.init(nibName: nil, bundle: nil)
	}
	required init?(coder aDecoder: NSCoder) { abort() }

    override func viewDidLoad() {
        super.viewDidLoad()
		
		navigationController?.navigationBar.isHidden = true
		
		// Cutomize our subviews
		buttonPlay.setTitle("Play".localized, for: .normal)
		buttonSettings.setTitle("Settings".localized, for: .normal)
		buttonStats.setTitle("Statistics".localized, for: .normal)
		buttonInfo.setTitle("Info".localized, for: .normal)
		
		buttonPlay.addTarget(self, action: #selector(buttonPlayTouchUp(sender:)), for: .touchUpInside)
		
		#if DEBUG
			self.buttonPlayTouchUp(sender: buttonPlay)
		#endif
		
		// Add subviews to controller's view
		view.addSubview(appIcon)
		view.addSubview(buttonPlay)
		view.addSubview(buttonSettings)
		view.addSubview(buttonStats)
		view.addSubview(buttonInfo)
    }
	
	override func viewWillLayoutSubviews() {
		super.viewWillLayoutSubviews()
		//Let's place our subviews
		let bounds: CGRect = self.view.bounds
		
		// Button play shoud be in the center of the screen
		var y: CGFloat = bounds.height/2
		// Constant offset from the left side
		let x: CGFloat = bounds.width/4
		
		// Item width to be centered
		let itemWidth: CGFloat = bounds.width - 2*x
		let buttonHeight: CGFloat = 45
		let offset: CGFloat = 16
		
		let iconY: CGFloat = y - itemWidth - offset
		appIcon.frame = CGRect(x: x, y: iconY, width: itemWidth, height: itemWidth)
		
		buttonPlay.frame = CGRect(x: x, y: y, width: itemWidth, height: buttonHeight)
		y += buttonPlay.bounds.height + offset
		
		buttonSettings.frame = CGRect(x: x, y: y, width: itemWidth, height: buttonHeight)
		y += buttonSettings.bounds.height + offset
		
		buttonStats.frame = CGRect(x: x, y: y, width: itemWidth, height: buttonHeight)
		y += buttonStats.bounds.height + offset
		
		buttonInfo.frame = CGRect(x: x, y: y, width: itemWidth, height: buttonHeight)
		y += buttonInfo.bounds.height + offset
	}
	
	@objc func buttonPlayTouchUp(sender: UIButton) {
		let optionsVC = TMGameOptionsVC()
		navigationController?.show(optionsVC, sender: self)
	}
}
