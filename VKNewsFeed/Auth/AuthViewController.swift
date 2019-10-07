//
//  AuthViewController.swift
//  VKNewsFeed
//
//  Created by Macbook on 06/10/2019.
//  Copyright © 2019 Big Nerd Ranch. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    private var authService: AuthService!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        authService = AppDelegate.shared().authService
    }
    

    @IBAction func signInTouch(){
        authService.wakeUpSession()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
