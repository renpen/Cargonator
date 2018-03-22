//
//  OnboardingViewController.swift
//  Cargonator
//
//  Created by Bosshammer, Benedikt on 22.03.18.
//  Copyright © 2018 Cargonator Inc. All rights reserved.
//

import UIKit
import PaperOnboarding

class OnboardingViewController: UIViewController, PaperOnboardingDataSource {
    
    @IBOutlet weak var letsStartButton: UIButton!
    
    @IBAction func letsStartButtonPressed(_ sender: Any) {
        
        UserDefaults.standard.set(true, forKey: "onboardingFinished")
        
        self.performSegue(withIdentifier: "showGameViewController", sender: self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letsStartButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubview(toFront: letsStartButton)
    }
    
    private func setupPaperOnboardingView() {
        let onboarding = PaperOnboarding()
        onboarding.delegate = self
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        
        // Add constraints
        for attribute: NSLayoutAttribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
        }
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        
        return [
            OnboardingItemInfo(informationImage: UIImage(named:"Onboarding_Package")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(named:"Onboarding_Package_Icon")!,
                               color: UIColor(red: 0.40, green: 0.56, blue: 0.71, alpha: 1.00),
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 15),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 15)),
            
            OnboardingItemInfo(informationImage: UIImage(named:"TruckRightPNG")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(named:"Onboarding_Truck_Icon")!,
                               color: UIColor(red: 0.40, green: 0.69, blue: 0.71, alpha: 1.00),
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 15),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 15))
            ][index]
    }
    
    func onboardingItemsCount() -> Int {
        return 2
    }
}

extension OnboardingViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        letsStartButton.isHidden = index == 1 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}
