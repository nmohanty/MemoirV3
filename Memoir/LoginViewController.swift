//
//  LoginViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 11/30/16.
//
//

import UIKit
import Parse

class LoginViewController: UIViewController {
    
    @IBOutlet weak var emailField: UITextField!
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillShow, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to display
        }
        
        NotificationCenter.default.addObserver(forName: Notification.Name.UIKeyboardWillHide, object: nil, queue: OperationQueue.main) { (notification: Notification) in
            // Any code you put in here will be called when the keyboard is about to hide
        }
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapNewUser(_ sender: Any) {
        self.performSegue(withIdentifier: "LoginToSignupSegue", sender: nil)
        print("Welcome, you are logged in")
    }
    
    @IBAction func onDidTapLogin(_ sender: UIButton) {
        
        PFUser.logInWithUsername(inBackground: emailField.text!, password: passwordField.text!)
        { (user: PFUser?, error: Error?) in
            //code that runs after login
            if user == nil {
                print ("Wrong credentials")
                let alertcontroller = UIAlertController(title: "Invalid email or password", message: "Please enter a valid email or password", preferredStyle: .alert)
                
                // create an OK action
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // handle response here
                    print("ok")
                }
                alertcontroller.addAction(OKAction)
                
                self.present(alertcontroller, animated: true) {
                    print("ok")
                    
                }

            }
            else{
                self.performSegue(withIdentifier: "loginSegue", sender: nil)
                print("Welcome, you are logged in")
            }
      
           }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
