//
//  HomeViewController.swift
//  HyperPPDemo
//
//  Created by Harshit Srivastava on 20/04/22.
//  Copyright © 2022 Juspay Technologies. All rights reserved.
//

import HyperSDK
import UIKit

class HomeViewController: UIViewController {
    
    // Initiating HyperServices instance
    let hyperInstance = HyperServices()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        viewFrame() //UI
        
        initiateHyperSDK()
    }
    
    // Get initiate payload
    func getInitiatePayload() -> [String : Any] {
        
        let initiatePayload : [String:Any] = [
            "requestId" : NSUUID().uuidString,
            "service" : "in.juspay.hyperpay",
            "payload" : [
                "action": "initiate",
                "merchantId": "geddit",
                "clientId": "geddit",
                "environment": "sandbox"
            ]
        ]
        
        return initiatePayload
    }
    
    func initiateHyperSDK() {
        
        let initiatePayload = getInitiatePayload()
        hyperInstance.initiate(self, payload: initiatePayload) { [unowned self] (response) in
            if let data = response {
                let event = data["event"] as? String ?? ""
                if event == "show_loader" {
                    // Show some loader here
                } else if event == "hide_loader" {
                    // hide loader here
                } else if event == "initiate_result" {
                    //let payload = data["payload"]
                } else if event == "process_result" {
                    
                }
            }
        }
    }
    
    @objc func goToCart(sender: UIButton) { //go to next page
        if let secondController = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier:"second") as? CheckoutViewController {
            
            // Passing hyperInstance to the next screen
            secondController.hyper = hyperInstance
            
            secondController.product1Value = stackView.cartValueLabel.text ?? ""
            secondController.product2Value = stackView2.cartValueLabel.text ?? ""
            
            self.navigationController?.pushViewController(secondController, animated: true)
        }
    }
    
    var topBarAnchor : NSLayoutConstraint!
    var stackView = StackView()
    var stackView2 = StackView()
}

extension HomeViewController {
    
    override func viewDidLayoutSubviews() {
        topBarAnchor.constant =  self.view.safeAreaInsets.top
    }
    
    func viewFrame() {  //UI
        
        let topBarView = TopBarView()
        topBarView.text1.text = "Juspay SDK Integration Demo"
        topBarView.text2.text = "Home Screen"
        topBarView.backButton.isHidden = true
        view.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        topBarAnchor = topBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.view.safeAreaInsets.top)
        topBarAnchor.isActive = true
        topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        let midBarView = MidBarView()
        midBarView.text1.text = "Juspay Payments SDK should be initiated on this screen."
        view.addSubview(midBarView)
        midBarView.translatesAutoresizingMaskIntoConstraints = false
        midBarView.topAnchor.constraint(equalTo: topBarView.bottomAnchor).isActive = true
        midBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        midBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        midBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        
        let scrollView = UIScrollView()
        view.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.topAnchor.constraint(equalTo: midBarView.bottomAnchor).isActive = true
        scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        
        
        let productLabel = UILabel()
        productLabel.text = "Products"
        productLabel.textColor = UIColor(red: 0.984, green: 0.553, blue: 0.2, alpha: 1)
        productLabel.font = productLabel.font.withSize(18)
        scrollView.addSubview(productLabel)
        productLabel.translatesAutoresizingMaskIntoConstraints = false
        productLabel.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        productLabel.heightAnchor.constraint(equalToConstant: 22).isActive = true
        productLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        productLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120).isActive = true
        
        let prodView =  ProductView()
        scrollView.addSubview(prodView)
        prodView.Label1.text = "Product 1"
        prodView.Label2.text = "Price: Rs. 1/item Awesome product description for product one."
        prodView.translatesAutoresizingMaskIntoConstraints = false
        prodView.topAnchor.constraint(equalTo: productLabel.bottomAnchor, constant: 10).isActive = true
        prodView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        prodView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        prodView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        scrollView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.topAnchor.constraint(equalTo: prodView.bottomAnchor, constant: 60).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        // amount1 = stackView.cartValueLabel.text ?? ""
        
        
        let prodView2 = ProductView()
        scrollView.addSubview(prodView2)
        prodView2.Label1.text = "Product 2"
        prodView2.Label2.text = "Price: Rs. 1/item Awesome product description for product one."
        prodView2.translatesAutoresizingMaskIntoConstraints = false
        prodView2.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 20).isActive = true
        prodView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        prodView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        prodView2.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        
        scrollView.addSubview(stackView2)
        stackView2.translatesAutoresizingMaskIntoConstraints = false
        stackView2.topAnchor.constraint(equalTo: prodView2.bottomAnchor, constant: 60).isActive = true
        stackView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        // amount2 = stackView2.cartValueLabel.text ?? ""
        
        let goToCart = UIButton()
        goToCart.backgroundColor = UIColor(red: 0.067, green: 0.325, blue: 0.565, alpha: 1)
        goToCart.setTitle("Go to Cart", for: .normal)
        goToCart.setTitleColor(.white, for: .normal)
        goToCart.addTarget(self, action:#selector(goToCart(sender:)), for: .touchUpInside)
        goToCart.titleLabel?.font =  UIFont(name: "NunitoSans-SemiBold", size: 16)
        scrollView.addSubview(goToCart)
        goToCart.translatesAutoresizingMaskIntoConstraints = false
        goToCart.topAnchor.constraint(equalTo: prodView2.bottomAnchor, constant: 150).isActive = true
        goToCart.heightAnchor.constraint(equalToConstant: 40).isActive = true
        goToCart.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        goToCart.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        goToCart.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40).isActive = true
    }
}
