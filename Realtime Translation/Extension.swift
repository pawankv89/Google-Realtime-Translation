//
//  Extension.swift
//  Realtime Translation
//
//  Created by Pawan kumar on 19/06/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import UIKit
import Foundation

extension UIView {
    private static let kRotationAnimationKey = "rotationanimationkey"

    func rotate(duration: Double = 1) {
        if layer.animation(forKey: UIView.kRotationAnimationKey) == nil {
            let rotationAnimation = CABasicAnimation(keyPath: "transform.rotation")

            rotationAnimation.fromValue = 0.0
            rotationAnimation.toValue = Float.pi * 2.0
            rotationAnimation.duration = duration
            rotationAnimation.repeatCount = Float.infinity

            layer.add(rotationAnimation, forKey: UIView.kRotationAnimationKey)
        }
    }

    func stopRotating() {
        if layer.animation(forKey: UIView.kRotationAnimationKey) != nil {
            layer.removeAnimation(forKey: UIView.kRotationAnimationKey)
        }
    }
}

extension UIView {

    func addBorderView(color: UIColor) {
        
        self.layer.borderWidth = 2
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderColor = color.cgColor
        self.layer.masksToBounds = true
    }
    
    func addBorderView() {
        
        self.layer.borderWidth = 2
        self.layer.cornerRadius = self.bounds.height / 2
        self.layer.borderColor = UIColor.white.cgColor
        self.layer.masksToBounds = true
    }
    
    func setCardView(){
        layer.cornerRadius = 5.0
        layer.borderColor  =  UIColor.clear.cgColor
        layer.borderWidth = 5.0
        layer.shadowOpacity = 0.5
        layer.shadowColor =  UIColor.lightGray.cgColor
        layer.shadowRadius = 5.0
        layer.shadowOffset = CGSize(width:5, height: 5)
        layer.masksToBounds = true
    }
    
    func setBackgroundCellView(){
        layer.cornerRadius = 3.0
        layer.borderColor  =  UIColor.lightGray.cgColor
        layer.borderWidth = 1.0
        layer.masksToBounds = true
    }

    func addCardView() -> Void {
    
        // The subview inside the collection view cell
        self.layer.cornerRadius = 5.0
        self.layer.shadowColor = UIColor.gray.cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 6.0
        self.layer.shadowOpacity = 0.7
    }
    
    func backgroundPMUColor() -> () {
        self.backgroundColor = UIColor.lightGray
    }
}

//MARK:- UIImageView Extension
extension UIImageView {
    
    func imgAddBorderView(color: UIColor) {
           
           self.layer.borderWidth = 2
           self.layer.cornerRadius = self.bounds.height / 2
           self.layer.borderColor = color.cgColor
           self.layer.masksToBounds = true
       }
    
    func appBackgroundColor() {
        
        self.backgroundColor = UIColor.lightGray
    }
    
    func imgTintColor(color: UIColor) {
        
        if self.image != nil {
            self.image = self.image!.withRenderingMode(.alwaysTemplate)
            self.tintColor = color
        }
    }
    
}

extension String {
    
   func strikeThrough()->NSAttributedString{
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: NSUnderlineStyle.single.rawValue, range: NSMakeRange(0, attributeString.length))
        return attributeString
    }
    
    func substring(from: Int, to: Int) -> String {
        let start = index(startIndex, offsetBy: from)
        let end = index(start, offsetBy: to - from)
        return String(self[start ..< end])
    }
    
    func substring(range: NSRange) -> String {
        return substring(from: range.lowerBound, to: range.upperBound)
    }
    
    var boolValue: Bool {
        return NSString(string: self).boolValue
    }
    
    var intValue: Int32 {
        return NSString(string: self).intValue
    }
    
    var doubleValue: Double {
        return NSString(string: self).doubleValue
    }
    
    var floatValue: Float {
        return NSString(string: self).floatValue
    }
    
    
}


extension CALayer {
    func makeSnapshot() -> UIImage? {
        let scale = UIScreen.main.scale
        UIGraphicsBeginImageContextWithOptions(frame.size, false, scale)
        defer { UIGraphicsEndImageContext() }
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        render(in: context)
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        return screenshot
    }
}

extension UIView {
    func makeSnapshot() -> UIImage? {
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(size: frame.size)
            return renderer.image { _ in drawHierarchy(in: bounds, afterScreenUpdates: true) }
        } else {
            return layer.makeSnapshot()
        }
    }
}

extension UIView {
   var screenShot: UIImage?  {
        if #available(iOS 10, *) {
            let renderer = UIGraphicsImageRenderer(bounds: self.bounds)
            return renderer.image { (context) in
                self.layer.render(in: context.cgContext)
            }
        } else {
            UIGraphicsBeginImageContextWithOptions(bounds.size, false, 5);
            if let _ = UIGraphicsGetCurrentContext() {
                drawHierarchy(in: bounds, afterScreenUpdates: true)
                let screenshot = UIGraphicsGetImageFromCurrentImageContext()
                UIGraphicsEndImageContext()
                return screenshot
            }
            return nil
        }
    }
}

extension UIViewController {
    
    /// Takes the screenshot of the screen and returns the corresponding image
       ///
       /// - Parameter shouldSave: Boolean flag asking if the image needs to be saved to user's photo library. Default set to 'true'
       /// - Returns: (Optional)image captured as a screenshot
       
       open func takeScreenshotlayer(_ shouldSave: Bool = true) -> UIImage? {
           
              var screenshotImage : UIImage?
              let layer = self.view.layer
              print("layers ", layer)
              let scale = self.view.layer.contentsScale
              UIGraphicsBeginImageContextWithOptions(layer.frame.size, false, scale);
              guard let context = UIGraphicsGetCurrentContext() else {return nil}
              layer.render(in: context)
              screenshotImage =
               UIGraphicsGetImageFromCurrentImageContext()
              UIGraphicsEndImageContext()
              if let image = screenshotImage, shouldSave {
                  UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
              }
           
              return screenshotImage
          }
    
    open func takeScreenshotwindow(_ shouldSave: Bool = true) -> UIImage? {
     
        var screenshotImage :UIImage?
        let layer = UIApplication.shared.windows.last?.layer
        let scale = UIScreen.main.scale
        
        UIGraphicsBeginImageContextWithOptions(layer!.frame.size, false, scale);
        guard let context = UIGraphicsGetCurrentContext() else {return nil}
        layer!.render(in: context)
        screenshotImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        if let image = screenshotImage, shouldSave {
            UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        }
     
        return screenshotImage
    }
}

