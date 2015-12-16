import UIKit
import Soracom

class ViewController: UIViewController {

    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    @IBAction func loginButtonDidTap(sender: AnyObject) {
        if let email = emailTextField.text, password = passwordTextField.text {
            Soracom.auth(
                email,
                password: password,
                onSuccess: {
                    self.performSegueWithIdentifier("loginToSubscribers", sender: self)
                },
                onError: { error in
                    print(error)
                }
            )
        }
    }
}

