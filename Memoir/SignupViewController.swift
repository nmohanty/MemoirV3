//
//  SignupViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 11/30/16.
//
//

import UIKit
import Parse

class SignupViewController: UIViewController {

    @IBOutlet weak var firstNameField: UITextField!

    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onTapNewuser(_ sender: UIButton) {
        self.performSegue(withIdentifier: "SignupToLoginSegue", sender: nil)
    }

    @IBAction func onTapView(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    @IBAction func onTapCreateButton(_ sender: Any) {
        let user = PFUser()
        
        user.username = usernameField.text
        user.password = passwordField.text
        
        user.signUpInBackground { (success: Bool,error: Error?) in
            if error != nil {
                print("something went wrong")}
            else {
                print("Welcome, you are signedup")
                self.performSegue(withIdentifier: "SignupSegue", sender: nil)
            }
            
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
