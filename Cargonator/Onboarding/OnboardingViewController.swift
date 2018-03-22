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
    
    func onboardingItemsCount() -> Int {
        return 3
    }
    
    @IBOutlet weak var letsTryButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letsTryButton.isHidden = true
        
        setupPaperOnboardingView()
        
        view.bringSubview(toFront: letsTryButton)
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
            OnboardingItemInfo(informationImage: UIImage(named:"TruckRightPNG")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(),
                               color: UIColor.blue,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 15),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 15)),
            
            OnboardingItemInfo(informationImage: UIImage(named:"TruckRightPNG")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(),
                               color: UIColor.blue,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 15),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 15)),
            OnboardingItemInfo(informationImage: UIImage(named:"TruckRightPNG")!,
                               title: "title",
                               description: "description",
                               pageIcon: UIImage(),
                               color: UIColor.blue,
                               titleColor: UIColor.white,
                               descriptionColor: UIColor.white,
                               titleFont: UIFont.boldSystemFont(ofSize: 15),
                               descriptionFont: UIFont.boldSystemFont(ofSize: 15))
            ][index]
    }
}

extension OnboardingViewController: PaperOnboardingDelegate {
    
    func onboardingWillTransitonToIndex(_ index: Int) {
        letsTryButton.isHidden = index == 2 ? false : true
    }
    
    func onboardingDidTransitonToIndex(_: Int) {
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        //item.titleLabel?.backgroundColor = .redColor()
        //item.descriptionLabel?.backgroundColor = .redColor()
        //item.imageView = ...
    }
}
