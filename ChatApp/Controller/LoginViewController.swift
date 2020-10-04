//
//  LoginViewController.swift
//  ChatApp
//
//  Created by maggie mendez on 03/10/20.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        Authentication.instance.detectCurrentUser(onSuccessfull: goToContactsList)
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func loginClick(_ sender: UIButton) {
        Authentication.instance.singIn(emailTextField.text ?? "", passwordTextField.text ?? "", onSuccessfull: goToContactsList){ [weak self] (message) in
            let alertAction = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alertAction, animated: true, completion: nil)
        }
        
    }
    
    func goToContactsList(){
        let storyboard = UIStoryboard(name: Storyboard.ContactsFlow.rawValue, bundle: Bundle.main)
        if let contactList = storyboard.instantiateViewController(withIdentifier: IdentifiersViews.navigationContact.rawValue) as? UINavigationController {
            UIApplication.shared.windows[0].rootViewController = contactList
        }
    }
    
    @IBAction func registerClick(_ sender: UIButton) {
        let storyboard = UIStoryboard(name: Storyboard.LoginFlow.rawValue, bundle: Bundle.main)
        if let contactList = storyboard.instantiateViewController(withIdentifier: "register") as? RegisterViewController{
            UIApplication.shared.windows[0].rootViewController = contactList
        }
    }
    
    @IBAction func forgotPasswordClick(_ sender: Any) {
       
    }
}
