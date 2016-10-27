//
//  MainViewController.swift
//  SaveMe
//
//  Created by Nolan Dey on 2016-01-09.
//  Copyright © 2016 Nolan Dey. All rights reserved.
//

import UIKit
import KAProgressLabel

class MainViewController: UIViewController {

    let HelpButtonSize : CGFloat = 224
    let LabelFontSize : CGFloat = 48
    let ProgressBarWidth : CGFloat = 18
    let ProgressBarRadius : CGFloat = 225.5
    let ProgressBarDuration : CGFloat = 2.5

    var helpButton : UIButton!
    var helpButtonLabel : UILabel!
    var callManager : CallManager!
    var progressBar : KAProgressLabel!
    var didLayoutViews : Bool
    
    required init?(coder aDecoder: NSCoder) {
        self.didLayoutViews = false
        super.init(coder: aDecoder)
    }
    
    init () {
        self.didLayoutViews = false
        super.init(nibName: nil, bundle: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(MainViewController.resetHelpButton), name: NSNotification.Name.UIApplicationDidBecomeActive, object: nil)
        self.callManager = CallManager()
        self.layoutViews()
    }
    
    func layoutViews() {
        didLayoutViews = true
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image:UIImage(named: "Contact"), style: UIBarButtonItemStyle.plain, target: self, action: #selector(MainViewController.profileTapped(_:)))
        self.view.backgroundColor = UIColor.white
        
        let frameWidth = self.view.frame.width
        let frameHeight = self.view.frame.height
        
        helpButton = UIButton.init(frame: CGRect(
            x: (frameWidth - HelpButtonSize) / 2,
            y: (frameHeight - HelpButtonSize) / 2,
            width: HelpButtonSize,
            height: HelpButtonSize))
        helpButton.backgroundColor = UIColor(red:0.95, green:0.33, blue:0.33, alpha:1.0)
        helpButton.layer.cornerRadius = HelpButtonSize / 2
        helpButton.layer.masksToBounds = true
        self.view.addSubview(helpButton)
        
        helpButtonLabel = UILabel(frame: CGRect(x: (HelpButtonSize - (HelpButtonSize - 2 * 32)) / 2,
            y: (HelpButtonSize - 3 * LabelFontSize) / 2,
            width: HelpButtonSize - 2 * 32,
            height: 3 * LabelFontSize))
        helpButtonLabel.backgroundColor = UIColor.clear
        helpButtonLabel.textColor = UIColor.white
        helpButtonLabel.text = "Call 911"
        helpButtonLabel.textAlignment = NSTextAlignment.center
        helpButtonLabel.font = UIFont.systemFont(ofSize: LabelFontSize)
        helpButtonLabel.lineBreakMode = NSLineBreakMode.byWordWrapping
        helpButtonLabel.numberOfLines = 2
        helpButtonLabel.isUserInteractionEnabled = false
        helpButton.addSubview(helpButtonLabel)
        helpButton.addTarget(self, action: #selector(MainViewController.callTapped(_:)), for: UIControlEvents.touchUpInside)
        
        progressBar = KAProgressLabel(frame: CGRect(
            x: (frameWidth - ProgressBarRadius) / 2,
            y: (frameHeight - ProgressBarRadius) / 2,
            width: ProgressBarRadius,
            height: ProgressBarRadius))
        progressBar.progressColor = UIColor(red:0.76, green:0.76, blue:0.76, alpha:1.0)
        progressBar.progressWidth = ProgressBarWidth
        progressBar.trackColor = UIColor.clear
        progressBar.isUserInteractionEnabled = false
    }

    func showProgressBar() {
        self.view.addSubview(progressBar)
        progressBar.setProgress(1, timing: TPPropertyAnimationTimingEaseOut, duration:2.5, delay: 0.0)
    }
    
    func hideProgressBar() {
        progressBar.removeFromSuperview()
        progressBar.progress = 0
    }
    
    func callTapped(_ sender : UIButton!) {
        self.showProgressBar()
        helpButton.removeTarget(self, action: #selector(MainViewController.callTapped(_:)), for: UIControlEvents.touchUpInside)
        helpButton.addTarget(self, action: #selector(MainViewController.cancelTapped(_:)), for: UIControlEvents.touchUpInside)
        helpButtonLabel.text = "Cancel"
    }

    func cancelTapped(_ sender : UIButton!) {
        helpButton.removeTarget(self, action: #selector(MainViewController.cancelTapped(_:)), for: UIControlEvents.touchUpInside)
        helpButton.addTarget(self, action: #selector(MainViewController.callTapped(_:)), for: UIControlEvents.touchUpInside)
        progressBar.stopAnimations()
        self.hideProgressBar()
        self.resetHelpButton()
    }
    
    func resetHelpButton() {
        helpButton.backgroundColor = UIColor(red:0.95, green:0.33, blue:0.33, alpha:1.0)
        helpButtonLabel.text = "Call 911"
        helpButton.isUserInteractionEnabled = true
    }
    
    func progressBarDidFinishAnimating() {
        self.hideProgressBar()
        self.helpButton.isUserInteractionEnabled = false
        helpButtonLabel.text = "Dialing"
        helpButton.backgroundColor = UIColor(red:0.59, green:0.78, blue:0.44, alpha:1.0)
        self.callManager.call911()
    }
    
    func profileTapped(_ sender : UIBarButtonItem!) {
        self.navigationController?.pushViewController(ProfileViewController(), animated: true)
    }
    
}
