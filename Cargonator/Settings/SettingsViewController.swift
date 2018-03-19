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
    
    var logInButton:TWTRLogInButton = TWTRLogInButton()
    @IBOutlet weak var twitterStatusLabel: UILabel!
    
    override var prefersStatusBarHidden : Bool {
        return true
    }
    
    func printTwitterActivated(session: TWTRSession) {
        self.twitterStatusLabel.text = "Logged in as " + session.userName
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        logInButton = TWTRLogInButton(logInCompletion: { session, error in
            if (session != nil) {
                self.printTwitterActivated(session: session!)
                self.logInButton.isEnabled = false
            } else {
                print(error?.localizedDescription)
            }
        })
        
        if (TWTRTwitter.sharedInstance().sessionStore.session() != nil) {
            self.printTwitterActivated(session: TWTRTwitter.sharedInstance().sessionStore.session() as! TWTRSession)
            self.logInButton.isEnabled = false
        } else {
            print("session not active")
        }
        
        self.view.addSubview(logInButton)
        
        let horizontalConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.centerX, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.centerX, multiplier: 1, constant: 0)
        let widthConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.width, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: logInButton.frame.size.width)
        let heightConstraint = NSLayoutConstraint(item: logInButton, attribute: NSLayoutAttribute.height, relatedBy: NSLayoutRelation.equal, toItem: nil, attribute: NSLayoutAttribute.notAnAttribute, multiplier: 1, constant: logInButton.frame.size.height)
        let pinTop = NSLayoutConstraint(item: logInButton, attribute: .top, relatedBy: .equal,
                                        toItem: twitterStatusLabel, attribute: .bottom, multiplier: 1.0, constant: 20)
        
        NSLayoutConstraint.activate([horizontalConstraint, widthConstraint, heightConstraint, pinTop])
        logInButton.translatesAutoresizingMaskIntoConstraints = false;
    }
    
    @IBAction func donePressed(_ sender: Any) {
        self.navigationDelegate?.initMenuScene()
        self.dismiss(animated: false, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}
