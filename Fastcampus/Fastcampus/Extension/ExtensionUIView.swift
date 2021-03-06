//
//  ExtensionUIView.swift
//  Fastcampus
//
//  Created by Lee on 2020/07/16.
//  Copyright © 2020 Kira. All rights reserved.
//

import UIKit

extension UIView {
  var parentViewController: UIViewController? {
    var responder: UIResponder? = self
    while let nextResponder = responder?.next {
      responder = nextResponder
      if let vc = nextResponder as? UIViewController {
        return vc
      }
    }
    return nil
  }
  
  func shadow() {
    self.layer.shadowRadius = 2.0
    self.layer.shadowOpacity = 0.4
    self.layer.shadowOffset = .zero
    self.layer.shadowColor = UIColor.darkGray.cgColor
  }
  

  func setGradientBackground(colors: [UIColor]) {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = colors.map({ $0.cgColor })
    gradient.locations = [0.0, 1.0]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)
    self.layer.insertSublayer(gradient, at: 0)
  }

  func makeGradient() {
    let gradient: CAGradientLayer = CAGradientLayer()
    gradient.colors = [
      #colorLiteral(red: 0.9294117647, green: 0.1490196078, blue: 0.3137254902, alpha: 1).cgColor,
      #colorLiteral(red: 0.9921568627, green: 0.4549019608, blue: 0.3137254902, alpha: 1).cgColor
    ]
    gradient.locations = [0, 1]
    gradient.startPoint = CGPoint(x: 0.0, y: 0.0)
    gradient.endPoint = CGPoint(x: 1.0, y: 1.0)
    gradient.frame = self.bounds
    self.layer.insertSublayer(gradient, at: 0)
  }
}
