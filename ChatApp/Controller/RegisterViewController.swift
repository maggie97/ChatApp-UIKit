//
//  RegisterViewController.swift
//  ChatApp
//
//  Created by maggie mendez on 03/10/20.
//

import UIKit

class RegisterViewController: UIViewController {
    
    // MARK: - Propieties
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmPasswordTextField: UITextField!
    @IBOutlet weak var contactNumberTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    // MARK: - Handlers
    @IBAction func registerClick(_ sender: Any) {
        let storyboard = UIStoryboard(name: Storyboard.ContactsFlow.rawValue, bundle: Bundle.main)
        guard let firstname = firstNameTextField.text, let lastname = lastNameTextField.text,
              let email = emailTextField.text, let number = contactNumberTextField.text, let password = passwordTextField.text else {
            let alertAction = UIAlertController(title: "Error", message: "Alguno de los campos esta vacio", preferredStyle: .alert)
            alertAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alertAction, animated: true, completion: nil)
            return
        }
        Authentication.instance.register(User(firstName: firstname , lastName: lastname, email: email, contactNumber: number, avatarImage: ""), password: password) {
            if let contactList = storyboard.instantiateViewController(withIdentifier: IdentifiersViews.navigationContact.rawValue) as? UINavigationController {
                UIApplication.shared.windows[0].rootViewController = contactList
            }
        } onFailure: {[weak self] (message) in
            let alertAction = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
            alertAction.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self?.present(alertAction, animated: true, completion: nil)
        }
    }
}
