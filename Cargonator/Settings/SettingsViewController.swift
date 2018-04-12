//
//  SettingsViewController.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 19.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import TwitterKit

class SettingsViewController: UIViewController {
    
    var navigationDelegate: GameViewController?
    
    @IBOutlet weak var navigationBar: UINavigationBar!
    
    @IBOutlet weak var difficultyLabel: UILabel!
    
    @IBOutlet weak var difficultySlider: UISlider!
    
    @IBOutlet weak var twitterStatusLabel: UILabel!
    
    var logInButton:TWTRLogInButton = TWTRLogInButton()
    var logoutButton: UIButton = UIButton()
    
    // - MARK: Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view
        
        placeTwitterLoginButton()
        setLoginButtonConstraints()
        
        placeTwitterLogoutButton()
        setLogoutButtonConstraints()
    }
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.navigationDelegate?.initMenuScene()
        self.dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // - MARK: Difficulty + Slider
    
    @IBAction func difficultySliderChanged(_ sender: Any) {
        let fixed = roundf((sender as AnyObject).value / 2.5) * 2.5;
        (sender as AnyObject).setValue(fixed, animated: true)
    }
    // - MARK: Twitter Settings
    
    func printTwitterActivated(session: TWTRSession) {
        self.twitterStatusLabel.text = "Logged in as " + session.userName
    }
    
    func placeTwitterLoginButton () {
        logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                self.printTwitterActivated(session: session!)
                self.logInButton.isEnabled = false
            }
        })
        
        if (TWTRTwitter.sharedInstance().sessionStore.session() != nil) {
            self.printTwitterActivated(session: TWTRTwitter.sharedInstance().sessionStore.session() as! TWTRSession)
            self.logInButton.isEnabled = false
            self.logoutButton.isEnabled = true
        } else {
            self.logInButton.isEnabled = true
            self.logoutButton.isEnabled = false
        }
        
        self.view.addSubview(logInButton)
    }
    
    func setLoginButtonConstraints () {
        let horizontalConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: logInButton.frame.size.width)
        let heightConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: logInButton.frame.size.height)
        let pinTop = NSLayoutConstraint(item: logInButton, attribute: .top, relatedBy: .equal,
                                        toItem: twitterStatusLabel, attribute: .bottom, multiplier: 1.0, constant: 20)
        
        NSLayoutConstraint.activate([horizontalConstraint, widthConstraint, heightConstraint, pinTop])
        logInButton.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    func placeTwitterLogoutButton () {
        logoutButton = UIButton()
        logoutButton.titleLabel?.text = "Disconnect Twitter"
        logoutButton.titleLabel?.font = logInButton.titleLabel?.font
        logoutButton.titleLabel?.textColor = UIColor.black
        logoutButton.backgroundColor = logInButton.backgroundColor
        logoutButton.titleLabel?.isHidden = false
        logoutButton.frame = logInButton.frame
        logoutButton.layer.cornerRadius = logInButton.layer.cornerRadius
        
        logoutButton.addTarget(self, action: #selector(self.twitterLogoutPress), for: .touchUpInside)
        
        self.view.addSubview(logoutButton)
    }
    
    @objc func twitterLogoutPress(sender: UIButton!) {
        if (TWTRTwitter.sharedInstance().sessionStore.session() != nil) {
            TWTRTwitter.sharedInstance().sessionStore.logOutUserID((TWTRTwitter.sharedInstance().sessionStore.session()?.userID)!)
            self.twitterStatusLabel.text = "Not logged in"
            self.logoutButton.isEnabled = false
            self.logoutButton.isEnabled = true
        }
    }
    
    func setLogoutButtonConstraints() {
        let horizontalConstraint = NSLayoutConstraint(item: logoutButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: logoutButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: logoutButton.frame.size.width)
        let heightConstraint = NSLayoutConstraint(item: logoutButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: logoutButton.frame.size.height)
        let pinTop = NSLayoutConstraint(item: logoutButton, attribute: .top, relatedBy: .equal,
                                        toItem: logInButton, attribute: .bottom, multiplier: 1.0, constant: 20)
        
        NSLayoutConstraint.activate([horizontalConstraint, widthConstraint, heightConstraint, pinTop])
        logoutButton.translatesAutoresizingMaskIntoConstraints = false;
    }
}
