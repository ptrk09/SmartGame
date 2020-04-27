//
//  MainMenuViewController.swift
//  SmartGame
//
//  Created by Paw.toporkov on 04/11/2019.
//  Copyright © 2019 TemaPasha. All rights reserved.
//

import UIKit

class MainMenuViewController: UIViewController
{
    
    
    @IBOutlet weak var buttonPlay: UIButton!
    @IBOutlet weak var buttonRule: UIButton!
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        //UIApplication.shared.windows.first!.rootViewController = self
        
        
        
        
        buttonPlay.addTarget(self, action: #selector(animationIn(sender:)), for: .touchDown)
        buttonPlay.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchUpOutside, .touchCancel])
        
        buttonRule.addTarget(self, action: #selector(animationIn(sender:)), for: .touchDown)
        buttonRule.addTarget(self, action: #selector(animationOut(sender:)), for: [.touchDragExit, .touchUpInside, .touchCancel])
        
        
    }
    
    
    @objc fileprivate func animationOut(sender: UIButton)
    {
        UIView.animate(withDuration: 0.3,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 1, y: 1)
        })
    }


    @objc fileprivate func animationIn(sender: UIButton)
    {
        UIView.animate(withDuration: 0.2,
        animations: {
            sender.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        })
    }
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        if #available(iOS 13.0, *)
        {
            return .darkContent
        }
        else
        {
            return .default
        }
        
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.identifier == "5e"
        {
            let preGameVC: SelectedViewController = segue.destination as! SelectedViewController
            preGameVC.modalTransitionStyle = .crossDissolve
            preGameVC.modalPresentationStyle = .currentContext
        }
        else if segue.identifier == "11e"
        {
            let ruleVC: RuleViewController = segue.destination as! RuleViewController
            ruleVC.modalTransitionStyle = .crossDissolve
            ruleVC.modalPresentationStyle = .currentContext
        }
    }
    
    
    
}

