//
//  WelcomeViewController.swift
//  Memoir
//
//  Created by Namrata Mohanty on 11/30/16.
//
//

import UIKit
import Parse

class WelcomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIView.animate(withDuration: 1, delay:
            0.4, options:
            [], animations:
            {
        //code
                self.performSegue(withIdentifier: "ToComposeSegue", sender: nil)
        }
            , completion:
        nil)
        

        // Do any additional setup after loading the view.
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
