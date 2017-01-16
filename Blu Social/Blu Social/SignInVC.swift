//
//  ViewController.swift
//  Blu Social
//
//  Created by Blu on 1/10/17.
//  Copyright © 2017 Blu. All rights reserved.
//

import UIKit
import FacebookCore
import FacebookLogin
import FirebaseAuth
import Firebase

class SignInVC: UIViewController {
    
    @IBOutlet weak var emailTextfield: FancyText!
    @IBOutlet weak var passwordTextfield: FancyText!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInTapped(_ sender: Any) {
        if let email = emailTextfield.text, let password = passwordTextfield.text {
            FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                if error == nil {
                    print("RICH: Email User authenticated with Firebase")
                } else {
                    print("RICH: User doesn't exists")
                    FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                        if error != nil {
                            print("RICH: Unable to create user with Firebase. Email possibly exists.")
                        } else {
                            print("RICH: Successfully created Email user with Firebase")
                        }
                    })
                }
            })
        }
        emailTextfield.text = ""
        passwordTextfield.text = ""
    }
    
    @IBAction func facebookSignInPressed(_ sender: Any) {
        let loginManager = LoginManager()
        loginManager.logIn([.publicProfile], viewController: self) { (loginResults) in
            switch loginResults {
            case .failed(let error):
                print("RICH: An error occured - \(error)")
            case .cancelled:
                print("RICH: User has cancelled Permissions")
            case .success(let grantedPermissions, let declinedPermissions, let accessToken):
                print("User has logged in through Facebook!")
                let credential = FIRFacebookAuthProvider.credential(withAccessToken: accessToken.authenticationToken) //Saves credential string as a variable
                self.firebaseAuth(credential) //Calls firebase function to pass in credentials
                //You can also simply pass the credentials by uncommeting this code
                //FIRFacebookAuthProvider.credential(withAccessToken: credential)
            }
        }
    }
    
    func firebaseAuth(_ credential: FIRAuthCredential) { //Authenticates fb login through firebase
        FIRAuth.auth()?.signIn(with: credential, completion: { (user, error) in
            if error != nil {
                print("RICH: We got an error. - \(error)")
            } else {
                print("Firebase Authentication Successful!")
            }
        })
    }

}

