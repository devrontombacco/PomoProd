//
//  GradientView.swift
//  PomoProd
//
//  Created by Devron Tombacco on 27/12/2020.
//

import UIKit

class TopGradientView: UIView {
    
    static let lightBGgrey = UIColor.rgb(red: 76, green: 90, blue: 102, alpha: 0)
    static let darkBGgrey = UIColor.rgb(red: 218, green: 243, blue: 250, alpha: 36)
    
    var darkColor: UIColor = darkBGgrey
    var lightColor: UIColor = lightBGgrey
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [darkColor.cgColor, lightColor.cgColor]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

class BottomGradientView: UIView {
    
    static let lightBGgrey = UIColor.rgb(red: 76, green: 90, blue: 102, alpha: 0)
    static let darkBGgrey = UIColor.rgb(red: 218, green: 243, blue: 250, alpha: 36)
    
    var darkColor: UIColor = darkBGgrey
    var lightColor: UIColor = lightBGgrey
    
    override func layoutSubviews() {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [lightColor.cgColor, darkColor.cgColor]
        gradientLayer.frame = self.bounds
        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}

extension UIColor {

    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha/100)
    }

}
