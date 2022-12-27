//
//  CheckoutViewController.swift
//  HyperPPDemo
//
//  Created by Harshit Srivastava on 20/04/22.
//  Copyright © 2022 Juspay Technologies. All rights reserved.
//

import HyperSDK
import UIKit


class CheckoutViewController: UIViewController {
    
    var hyper : HyperServices!
    let random = Int.random(in: 000000000...999999999)
    var loader : UIView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 13.0, *) {
            overrideUserInterfaceStyle = .light
        } else {
            // Fallback on earlier versions
        }
        viewFrame()
    }
    
    func getSignatureForPayload(payload : String, callback: @escaping (String) -> ()) { //fetch signature key for payload
        
        let encodePayload = payload.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        if let url = URL(string:"https://dry-cliffs-89916.herokuapp.com/sign-hyper-beta?payload=\(encodePayload)") {
            let request = NSMutableURLRequest(url: url,cachePolicy: .useProtocolCachePolicy,timeoutInterval: 10.0)
            
            request.httpMethod = "GET"
            let session = URLSession.shared
            let dataTask = session.dataTask(with: request as URLRequest, completionHandler: { (data, response, error) -> Void in
                if (error != nil) {
                    print(error!)
                } else {
                    if let d = data {
                        let signature = NSString(data: d, encoding: String.Encoding.utf8.rawValue)! as String
                        callback(signature)
                    }
                }
            })
            dataTask.resume()
            
        }
    }
    @objc func checkout(sender: UIButton) { //calling PP SDK
        
        loadingScreenOn(onView : self.view)
        let ranStr = String(format: "%d", random)
        let orderDetails = ["amount":self.totalPayableAmount,
                            "customer_email":"test@gmail.com",
                            "customer_id":"test_customer",
                            "customer_phone":"9739534710",
                            "merchant_id":"geddit",
                            "order_id":ranStr,
                            "timestamp":"1629198472335",
                            "return_url":"https://sandbox.juspay.in/end"] as [String:Any]
        
        var orderDetailsString = ""
        if let jsonData = try? JSONSerialization.data(withJSONObject: orderDetails, options: .fragmentsAllowed) {
            orderDetailsString = String(data: jsonData, encoding: .utf8) ?? ""
        }
        
        getSignatureForPayload(payload: orderDetailsString) { signature in
            
            // generate process payload
            let processPayload :  [String:Any] =
            ["requestId" : "8cbc3fad-8b3f-40c0-ae93-2d7e75a8624a",
             "service" : "in.juspay.hyperpay",
             "payload" : [
                "action" : "paymentPage",
                "merchantId" : "geddit",
                "clientId": "geddit",
                "orderId": ranStr,
                "amount": self.totalPayableAmount,
                "customerId": "test_customer",
                "customerEmail": "test@gmail.com",
                "customerMobile": "9739534710",
                "orderDetails": orderDetailsString,
                "signature": signature,
                "merchantKeyId": "4853",
                "language": "english",
                "environment": "sandbox"]
            ]
            // call process
            DispatchQueue.main.async {
                
                self.hyper.baseViewController = self
                self.hyper.hyperSDKCallback = { [unowned self] (response) in
                    if let data = response {
                        let event = data["event"] as? String ?? ""
                        if event == "hide_loader" {
                            loadingScreenOff()// Hide Loader
                        }
                        else if event == "process_result" {
                            // Get the payload
                            let payload = data["payload"] as! [String: Any]
                            print("CVCV\(payload)")
                            
                            if let status = payload["status"] as? String
                            {
                                loadingScreenOff()
                                if status != "backpressed"
                                {
                                    let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "third") as? StatusViewController
                                    vc?.status = status
                                    self.navigationController?.pushViewController(vc!, animated: true)
                                    
                                }
                            }
                        }
                    }
                } //process payload
                if self.hyper.isInitialised() {
                    self.hyper.process(processPayload)
                }
            }
        }
    }
    
    func loadingScreenOn(onView : UIView) { //show loader
        let loaderView = UIView.init(frame: onView.bounds)
        loaderView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        var ai = UIActivityIndicatorView()
        if #available(iOS 13.0, *) {
             ai = UIActivityIndicatorView.init(style: .large)
          } else {
             ai = UIActivityIndicatorView.init(style: .whiteLarge)
          }
       
        ai.startAnimating()
        ai.center = loaderView.center
        
        DispatchQueue.main.async {
            loaderView.addSubview(ai)
            onView.addSubview(loaderView)
        }
        
        loader = loaderView
    }
    
    func loadingScreenOff() { //hide loader
        DispatchQueue.main.async {
            self.loader?.removeFromSuperview()
            self.loader = nil
        }
    }
    
    
    @objc func goBack() {
        
        _ = navigationController?.popViewController(animated: true)
    }
    
    var product1Value = ""
    var product2Value = ""
    var totalPayableAmount = 0.0
    var topBarAnchor : NSLayoutConstraint!
    
}

extension CheckoutViewController {
    
    override func viewDidLayoutSubviews() {
        topBarAnchor.constant =  self.view.safeAreaInsets.top
    }
    
    func viewFrame() { //UI
        
        let topBarView = TopBarView()
        topBarView.text1.text = "Juspay SDK Integration Demo"
        topBarView.text2.text = "Checkout Screen"
        topBarView.backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        view.addSubview(topBarView)
        topBarView.translatesAutoresizingMaskIntoConstraints = false
        topBarAnchor = topBarView.topAnchor.constraint(equalTo: view.topAnchor, constant: self.view.safeAreaInsets.top)
        topBarAnchor.isActive = true
        topBarView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        topBarView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        topBarView.heightAnchor.constraint(equalToConstant: 70).isActive = true
        
        
        let midBarView = MidBarView()
        midBarView.text1.text = "Call process on HyperServices instance on Checkout Button Click"
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
        
        let Label1 = UILabel()
        Label1.text = "Cart Details"
        Label1.textColor = UIColor(red: 0.984, green: 0.553, blue: 0.2, alpha: 1)
        Label1.font = Label1.font.withSize(18)
        scrollView.addSubview(Label1)
        Label1.translatesAutoresizingMaskIntoConstraints = false
        Label1.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 10).isActive = true
        Label1.heightAnchor.constraint(equalToConstant: 22).isActive = true
        Label1.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        Label1.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -120).isActive = true
        
        
        //stack view 1
        let cartView = CartView()
        scrollView.addSubview(cartView)
        cartView.translatesAutoresizingMaskIntoConstraints = false
        cartView.topAnchor.constraint(equalTo: Label1.bottomAnchor, constant: 10).isActive = true
        cartView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cartView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cartView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cartView.Label1.text = "Product 1"
        cartView.Label2.text = "x" + product1Value
        let a:Int? = Int(product1Value)
        cartView.Label3.text = "₹" + " " + String(a! * 1)
        
        
        //stack view 2
        let cartView2 = CartView()
        scrollView.addSubview(cartView2)
        cartView2.translatesAutoresizingMaskIntoConstraints = false
        cartView2.topAnchor.constraint(equalTo: cartView.bottomAnchor).isActive = true
        cartView2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        cartView2.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        cartView2.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        cartView2.Label1.text = "Product 2"
        cartView2.Label2.text = "x" + product2Value
        let b:Int? = Int(product2Value)
        cartView2.Label3.text = "₹" + " " + String(b! * 1)
        
        
        let Label4 = UILabel()
        Label4.text = "Amount"
        Label4.textColor = UIColor(red: 0.984, green: 0.553, blue: 0.2, alpha: 1)
        Label4.font = Label4.font.withSize(18)
        scrollView.addSubview(Label4)
        Label4.translatesAutoresizingMaskIntoConstraints = false
        Label4.topAnchor.constraint(equalTo: cartView2.bottomAnchor, constant: 40).isActive = true
        Label4.heightAnchor.constraint(equalToConstant: 22).isActive = true
        Label4.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        Label4.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
        
        //Bar View
        let BarView = UIView()
        BarView.layer.cornerRadius = 6
        BarView.layer.borderWidth = 0.2
        scrollView.addSubview(BarView)
        BarView.translatesAutoresizingMaskIntoConstraints = false
        BarView.topAnchor.constraint(equalTo: Label4.bottomAnchor, constant: 10).isActive = true
        BarView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        BarView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        BarView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        
        let text1 = UILabel()
        text1.text = "Total Amount"
        text1.font = text1.font.withSize(16)
        text1.textColor = .black
        scrollView.addSubview(text1)
        text1.translatesAutoresizingMaskIntoConstraints = false
        text1.topAnchor.constraint(equalTo: BarView.topAnchor, constant: 15).isActive = true
        text1.heightAnchor.constraint(equalToConstant: 15).isActive = true
        text1.leadingAnchor.constraint(equalTo: BarView.leadingAnchor, constant: 20).isActive = true
        text1.trailingAnchor.constraint(equalTo: BarView.trailingAnchor, constant: -20).isActive = true
        
        let text2 = UILabel()
        let totalAmount = (a! + b!)
        text2.text = String(totalAmount)
        text2.font = text2.font.withSize(16)
        text2.textColor = .black
        scrollView.addSubview(text2)
        text2.translatesAutoresizingMaskIntoConstraints = false
        text2.topAnchor.constraint(equalTo: BarView.topAnchor, constant: 15).isActive = true
        text2.heightAnchor.constraint(equalToConstant: 15).isActive = true
        text2.trailingAnchor.constraint(equalTo: BarView.trailingAnchor, constant: -20).isActive = true
        
        let text3 = UILabel()
        text3.text = "Tax"
        text3.font = text3.font.withSize(16)
        text3.textColor = .black
        scrollView.addSubview(text3)
        text3.translatesAutoresizingMaskIntoConstraints = false
        text3.topAnchor.constraint(equalTo: text2.topAnchor, constant: 30).isActive = true
        text3.heightAnchor.constraint(equalToConstant: 15).isActive = true
        text3.leadingAnchor.constraint(equalTo: BarView.leadingAnchor, constant: 20).isActive = true
        text3.trailingAnchor.constraint(equalTo: BarView.trailingAnchor, constant: -20).isActive = true
        
        let text4 = UILabel()
        let taxAmount = (0.1 * Double(totalAmount))
        text4.text = String(format: "%2g", taxAmount)
        text4.font = text4.font.withSize(16)
        text4.textColor = .black
        scrollView.addSubview(text4)
        text4.translatesAutoresizingMaskIntoConstraints = false
        text4.topAnchor.constraint(equalTo: text2.topAnchor, constant: 30).isActive = true
        text4.heightAnchor.constraint(equalToConstant: 15).isActive = true
        text4.trailingAnchor.constraint(equalTo: BarView.trailingAnchor, constant: -20).isActive = true
        
        let text5 = UILabel()
        text5.text = "Total Payable Amount"
        text5.font = text5.font.withSize(16)
        text5.textColor = .black
        scrollView.addSubview(text5)
        text5.translatesAutoresizingMaskIntoConstraints = false
        text5.topAnchor.constraint(equalTo: text4.topAnchor, constant: 30).isActive = true
        text5.heightAnchor.constraint(equalToConstant: 15).isActive = true
        text5.leadingAnchor.constraint(equalTo: BarView.leadingAnchor, constant: 20).isActive = true
        text5.trailingAnchor.constraint(equalTo: BarView.trailingAnchor, constant: -20).isActive = true
        
        let text6 = UILabel()
        self.totalPayableAmount = taxAmount + Double(totalAmount)
        text6.text = "₹" + " " + String(format: "%2g", totalPayableAmount)
        text6.font = text6.font.withSize(16)
        text6.textColor = .black
        scrollView.addSubview(text6)
        text6.translatesAutoresizingMaskIntoConstraints = false
        text6.topAnchor.constraint(equalTo: text4.topAnchor, constant: 30).isActive = true
        text6.heightAnchor.constraint(equalToConstant: 15).isActive = true
        text6.trailingAnchor.constraint(equalTo: BarView.trailingAnchor, constant: -20).isActive = true
        
        //bottom button
        let checkoutButton = UIButton()
        checkoutButton.backgroundColor = UIColor(red: 0.067, green: 0.325, blue: 0.565, alpha: 1)
        checkoutButton.setTitle("Checkout", for: .normal)
        checkoutButton.setTitleColor(.white, for: .normal)
        checkoutButton.addTarget(self, action:#selector(checkout(sender:)), for: .touchUpInside)
        checkoutButton.titleLabel?.font =  UIFont(name: "NunitoSans-SemiBold", size: 16)
        scrollView.addSubview(checkoutButton)
        checkoutButton.translatesAutoresizingMaskIntoConstraints = false
        checkoutButton.topAnchor.constraint(equalTo: text6.bottomAnchor, constant: 60).isActive = true
        checkoutButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        checkoutButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        checkoutButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        checkoutButton.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: -40).isActive = true
    }
}


