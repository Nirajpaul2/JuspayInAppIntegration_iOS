//
//  StatusViewController.swift
//  HyperPPDemo
//
//  Created by Harshit Srivastava on 20/04/22.
//  Copyright © 2022 Juspay Technologies. All rights reserved.
//

import UIKit

class StatusViewController: UIViewController {
    
    var status : String?
    @IBOutlet weak var img: UIImageView!
    
    
    @objc func done(sender: Any)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        viewFrame()
        self.navigationItem.setHidesBackButton(true, animated: true)
        
        if status == "charged" || status == "cod_initiated" {
            img.image = UIImage(named: "tick.png")
            view.addSubview(img)
            
            img.translatesAutoresizingMaskIntoConstraints = false
            img.heightAnchor.constraint(equalToConstant: 150).isActive = true
            img.widthAnchor.constraint(equalToConstant: 150).isActive = true
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
            
            
        }
        
        else {
            img.image = UIImage(named: "cross.png")
            view.addSubview(img)
            
            img.translatesAutoresizingMaskIntoConstraints = false
            img.heightAnchor.constraint(equalToConstant: 150).isActive = true
            img.widthAnchor.constraint(equalToConstant: 150).isActive = true
            img.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
            img.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        }
        
    }
    
    @IBAction func done(_ sender: Any)
    {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    var topBarAnchor : NSLayoutConstraint!
    
}

extension StatusViewController {
    
    override func viewDidLayoutSubviews() {
        topBarAnchor.constant =  self.view.safeAreaInsets.top
    }
    
    func viewFrame() { //UI
        
        let topBarView = TopBarView()
        topBarView.text1.text = "Juspay SDK Integration Demo"
        topBarView.text2.text = "Payment Status"
        topBarView.backButton.isHidden = true
        view.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        topBarAnchor = topBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.view.safeAreaInsets.top)
        topBarAnchor.isActive = true
        topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        let midBarView = MidBarView()
        midBarView.text1.text = "Handle Juspay Payments SDK Response"
        view.addSubview(midBarView)
        midBarView.translatesAutoresizingMaskIntoConstraints = false
        midBarView.topAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
        midBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        midBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        midBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        let doneButton = UIButton()
        doneButton.backgroundColor = UIColor(red: 0.067, green: 0.325, blue: 0.565, alpha: 1)
        doneButton.setTitle("Done", for: .normal)
        doneButton.setTitleColor(.white, for: .normal)
        doneButton.addTarget(self, action:#selector(done(sender:)), for: .touchUpInside)
        doneButton.titleLabel?.font =  UIFont(name: "NunitoSans-SemiBold", size: 16)
        view.addSubview(doneButton)
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        doneButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        doneButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        doneButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -40).isActive = true
    }
}




