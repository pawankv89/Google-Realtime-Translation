//
//  SplashScreen.swift
//  Realtime Translation
//
//  Created by Pawan kumar on 19/06/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import UIKit
import Foundation

class SplashScreen: UIViewController
{
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                   
            // your function here
            self.moveToVC()
        }
    }
    
    @objc func moveToVC() -> () {
    
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyboard.instantiateViewController(withIdentifier: "TranslationScreen") as! TranslationScreen
        self.navigationController?.pushViewController(viewController, animated: true)

    }
    
}

