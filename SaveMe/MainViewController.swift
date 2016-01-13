//
//  MainViewController.swift
//  SaveMe
//
//  Created by Nolan Dey on 2016-01-09.
//  Copyright © 2016 Nolan Dey. All rights reserved.
//

import UIKit
import KAProgressLabel
import Hex

class MainViewController: UIViewController, KAProgressLabelDelegate {

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
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Camera, target: nil, action: nil)
        self.callManager = CallManager()
        self.layoutViews()
    }
    
    func layoutViews()
    {
        didLayoutViews = true
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let frameWidth = CGRectGetWidth(self.view.frame)
        let frameHeight = CGRectGetHeight(self.view.frame)
        
        helpButton = UIButton.init(frame: CGRect(
            x: (frameWidth - HelpButtonSize) / 2,
            y: (frameHeight - HelpButtonSize) / 2,
            width: HelpButtonSize,
            height: HelpButtonSize))
        helpButton.backgroundColor = UIColor(hex: "f25555")
        helpButton.layer.cornerRadius = HelpButtonSize / 2
        helpButton.layer.masksToBounds = true
        self.view.addSubview(helpButton)
        
        helpButtonLabel = UILabel(frame: CGRect(x: (HelpButtonSize - (HelpButtonSize - 2 * 32)) / 2,
            y: (HelpButtonSize - 3 * LabelFontSize) / 2,
            width: HelpButtonSize - 2 * 32,
            height: 3 * LabelFontSize))
        helpButtonLabel.backgroundColor = UIColor.clearColor()
        helpButtonLabel.textColor = UIColor.whiteColor()
        helpButtonLabel.text = "Call 911"
        helpButtonLabel.textAlignment = NSTextAlignment.Center
        helpButtonLabel.font = UIFont.systemFontOfSize(LabelFontSize)
        helpButtonLabel.lineBreakMode = NSLineBreakMode.ByWordWrapping
        helpButtonLabel.numberOfLines = 2
        helpButtonLabel.userInteractionEnabled = false
        helpButton.addSubview(helpButtonLabel)
        helpButton.addTarget(self, action: "callTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        progressBar = KAProgressLabel(frame: CGRect(
            x: (frameWidth - ProgressBarRadius) / 2,
            y: (frameHeight - ProgressBarRadius) / 2,
            width: ProgressBarRadius,
            height: ProgressBarRadius))
        progressBar.progressColor = UIColor(hex: "c1c1c1")
        progressBar.progressWidth = ProgressBarWidth
        progressBar.trackColor = UIColor.clearColor()
        progressBar.userInteractionEnabled = false
        progressBar.delegate = self
    }

    func showProgressBar()
    {
        self.view.addSubview(progressBar)
        progressBar.setProgress(1, timing: TPPropertyAnimationTimingEaseOut, duration:2.5, delay: 0.0)
    }
    
    func hideProgressBar() {
        progressBar.removeFromSuperview()
        progressBar.progress = 0
    }
    
    func callTapped(sender : UIButton!) {
        self.showProgressBar()
        helpButton.removeTarget(self, action: "callTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        helpButton.addTarget(self, action: "cancelTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        helpButtonLabel.text = "Cancel"
    }

    func cancelTapped(sender : UIButton!) {
        helpButton.removeTarget(self, action: "cancelTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        helpButton.addTarget(self, action: "callTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        progressBar.stopAnimations()
        self.hideProgressBar()
        self.resetHelpButton()
    }
    
    func resetHelpButton() {
        helpButton.backgroundColor = UIColor(hex: "f25555")
        helpButtonLabel.text = "Call 911"
        helpButton.userInteractionEnabled = true
    }
    
    func progressBarDidFinishAnimating() {
        self.hideProgressBar()
        self.helpButton.userInteractionEnabled = false
        helpButtonLabel.text = "Dialing"
        helpButton.backgroundColor = UIColor(hex: "97c671")
        self.callManager.call911()
    }
    
}
