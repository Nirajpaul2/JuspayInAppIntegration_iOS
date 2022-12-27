//
//  UIComponents.swift
//  HyperPPDemo
//
//  Created by Harshit Srivastava on 20/04/22.
//  Copyright © 2022 Juspay Technologies. All rights reserved.
//

import UIKit

class TopBarView: UIView {
    
    let text1 = UILabel()
    let text2 = UILabel()
    let backButton = UIButton(type: UIButton.ButtonType.custom)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        
        //for top bar
        self.backgroundColor = UIColor(red: 0.18, green: 0.17, blue: 0.17, alpha: 1)
        
        let image = UIImage(named: "back")
        backButton.setImage(image, for: .normal)
        //backButton.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        self.addSubview(backButton)
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        backButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 10).isActive = true
        
        
        
        //top text
        text1.font = text1.font.withSize(15)
        text1.textColor = .white
        self.addSubview(text1)
        text1.translatesAutoresizingMaskIntoConstraints = false
        text1.topAnchor.constraint(equalTo: self.topAnchor, constant: 10).isActive = true
        text1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        text1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28).isActive = true
        text1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
        //bottom text
        text2.font = text2.font.withSize(18)
        text2.textColor = .white
        self.addSubview(text2)
        text2.translatesAutoresizingMaskIntoConstraints = false
        text2.topAnchor.constraint(equalTo: self.topAnchor, constant: 32).isActive = true
        text2.heightAnchor.constraint(equalToConstant: 22).isActive = true
        text2.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 28).isActive = true
        text2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
    }
}

class MidBarView: UIView {
    
    let text1 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        
        //for mid bar
        self.backgroundColor = UIColor(red: 0.971, green: 0.963, blue: 0.963, alpha: 1)
        
        //text
        text1.font = text1.font.withSize(12)
        text1.textColor = .black
        self.addSubview(text1)
        text1.translatesAutoresizingMaskIntoConstraints = false
        text1.topAnchor.constraint(equalTo: self.topAnchor, constant: 15).isActive = true
        text1.heightAnchor.constraint(equalToConstant: 15).isActive = true
        text1.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20).isActive = true
        text1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20).isActive = true
        
    }
}

class ProductView: UIView {
    
    let Label1 = UILabel()
    let Label2 = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createSubviews()
    }
    
    func createSubviews() {
        
        
        let rec1 = UIView()
        rec1.backgroundColor = UIColor(red: 0.962, green: 0.962, blue: 0.962, alpha: 1)
        rec1.layer.cornerRadius = 8
        self.addSubview(rec1)
        rec1.translatesAutoresizingMaskIntoConstraints = false
        rec1.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        rec1.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        rec1.trailingAnchor.constraint(equalTo: self.trailingAnchor).isActive = true
        rec1.heightAnchor.constraint(equalToConstant: 140).isActive = true
        
        //product 1
        
        Label1.textColor = UIColor.black
        Label1.font = Label1.font.withSize(14)
        self.addSubview(Label1)
        Label1.translatesAutoresizingMaskIntoConstraints = false
        Label1.topAnchor.constraint(equalTo: rec1.bottomAnchor, constant: 10).isActive = true
        Label1.heightAnchor.constraint(equalToConstant: 20).isActive = true
        Label1.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        Label1.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120).isActive = true
        
        
        
        Label2.numberOfLines = 0
        Label2.lineBreakMode = .byWordWrapping
        Label2.textColor = UIColor.black
        Label2.font = Label2.font.withSize(14)
        self.addSubview(Label2)
        Label2.translatesAutoresizingMaskIntoConstraints = false
        Label2.topAnchor.constraint(equalTo: Label1.bottomAnchor, constant: 10).isActive = true
        Label2.heightAnchor.constraint(equalToConstant: 50).isActive = true
        Label2.leadingAnchor.constraint(equalTo: self.leadingAnchor).isActive = true
        Label2.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -120).isActive = true
        
        
    }
}

class StackView: UIStackView {
    
    @objc func plus(sender: UIButton) {
        
        if(sender.tag == 1)
        {
            guard let presentValue = Int(self.cartValueLabel.text ?? "0") else { return }
            
            let newValue = presentValue + 1
            self.cartValueLabel.text = String(newValue)
        }
        else
        {
            guard let presentValue = Int(self.cartValueLabel.text ?? "0") else { return }
            
            let newValue = presentValue + 1
            self.cartValueLabel.text = String(newValue)
            
        }
    }
    @objc func minus(sender: UIButton) {
        
        if(sender.tag == 1)
        {
            guard let presentValue = Int(self.cartValueLabel.text ?? "0") else { return }
            
            let newValue = presentValue - 1
            self.cartValueLabel.text = String(newValue)
        }
        else
        {
            guard let presentValue = Int(self.cartValueLabel.text ?? "0") else { return }
            
            let newValue = presentValue - 1
            cartValueLabel.text = String(newValue)
            
        }
    }
    
    
    let cartValueLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createSubviews() {
        
        
        
        self.axis = .horizontal
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 2
        
        
        let plus = UIButton()
        plus.setTitle("+", for: .normal)
        plus.addTarget(self, action:#selector(plus(sender:)), for: .touchUpInside)
        plus.tag = 1
        plus.setTitleColor(.blue, for: .normal)
        
        
        self.cartValueLabel.textAlignment = .center
        self.cartValueLabel.text = "1"
        self.cartValueLabel.textColor = UIColor(red: 0.984, green: 0.553, blue: 0.2, alpha: 1)
        self.cartValueLabel.font = cartValueLabel.font.withSize(14)
        
        let minus = UIButton()
        minus.setTitle("-", for: .normal)
        minus.addTarget(self, action:#selector(minus(sender:)), for: .touchUpInside)
        minus.tag = 1
        minus.setTitleColor(.blue, for: .normal)
        
        
        self.alignment = .fill
        self.distribution = .fillEqually
        self.spacing = 6.0
        self.addArrangedSubview(minus)
        self.addArrangedSubview(self.cartValueLabel)
        self.addArrangedSubview(plus)
        
        
    }
}

class CartView: UIStackView {
    
    var Label1 = UILabel()
    var Label2 = UILabel()
    var Label3 = UILabel()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createSubviews()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func createSubviews() {
        
        self.axis = .horizontal
        self.layer.borderWidth = 0.2
        self.layer.cornerRadius = 3
        self.translatesAutoresizingMaskIntoConstraints = false
        
        Label1.textAlignment = .left
        Label1.textColor = UIColor.black
        Label1.font = Label1.font.withSize(16)
        
        Label2.textAlignment = .center
        Label2.textColor = UIColor.black
        Label2.font = Label2.font.withSize(16)
        
        Label3.textAlignment = .right
        Label3.textColor = UIColor.black
        Label3.font = Label3.font.withSize(16)
        
        self.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        self.isLayoutMarginsRelativeArrangement = true
        self.alignment = .fill
        self.distribution = .fillProportionally
        self.spacing = 7.0
        self.addArrangedSubview(Label1)
        self.addArrangedSubview(Label2)
        self.addArrangedSubview(Label3)
        
    }
}
