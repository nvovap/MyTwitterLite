//
//  LoginViewController.swift
//  LiteTwitter
//
//  Created by Vladimir Nevinniy on 4/18/18.
//  Copyright © 2018 Vladimir Nevinniy. All rights reserved.
//

import UIKit
import TwitterKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var username: UITextField!
    
    
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    
    @IBAction func LoginwithBrouser(_ sender: UIButton) {
//        let account = ACAccountStore()
//
//        let accountType = account.accountType(withAccountTypeIdentifier: ACAccountTypeIdentifierTwitter)
//
//        account.requestAccessToAccounts(with: accountType, options: nil, completion: {(success, error) in
//            if success {
//                if let twitterAccount = account.accounts(with: accountType).last as? ACAccount {
//                    print("signed in as \(twitterAccount.accountType)");
//                }
//            }
//        })
        
//        TWTRTwitter.sharedInstance().logIn(with: self) { session, error in
//            guard let _ = session else {
//                print("boo")
//                return
//            }
//
//            print(session?.authToken ?? "")
//        }
        
        
        TWTRTwitter.sharedInstance().logIn { session, error in
            guard let _ = session else {
                print("no login")
                return
            }
            
           self.performSegue(withIdentifier: "loginSucces", sender: nil)
        }
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
