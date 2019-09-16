//
//  LoginViewController.swift
//  UselessLogin
//
//  Created by Yoltic Cervantes Galeana on 9/16/19.
//  Copyright © 2019 Yoltic Cervantes Galeana. All rights reserved.
//

import Foundation
import UIKit
import LocalAuthentication

class LoginViewController:UIViewController
{
    @IBAction func Biometrics(_ sender: Any)
    {
        let context:LAContext = LAContext()
        var authError:NSError?
        
        if #available(iOS 8.0, *)
        {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError)
            {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Please authenticate with FaceID / TouchID")
                { (success, error) in
                    DispatchQueue.main.async
                    {
                        if success
                        {
                            print("Auth successfull")
                        }
                        else
                        {
                            print(error!)
                        }
                    }
                }
            }
            else
            {
                print("Error, feature not available")
            }
        }
    }
    @IBAction func Pwd(_ sender: Any)
    {
        let context:LAContext = LAContext()
        var authError:NSError?
        
        if #available(iOS 8.0, *)
        {
            if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &authError)
            {
                context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: "Please authenticate with FaceID / TouchID")
                { (success, error) in
                    DispatchQueue.main.async
                        {
                            if success
                            {
                                print("Auth successfull")
                            }
                            else
                            {
                                print(error!)
                            }
                    }
                }
            }
            else
            {
                print("Error, feature not available")
            }
        }
    }
    
}
