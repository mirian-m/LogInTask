import UIKit

protocol LogInViewControllerDelegat: AnyObject {
    func register(user: User)
}

final class LogInViewController: UIViewController {
    
    // MARK:- Private properties
    private let manager = UserDataManager()
    private var logInedUser: User!
    
    // MARK:- Outlets
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK:- CONTROLLER LIFE CYCLE FUNCTION
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        resetUI()
    }
    
    // MARK:- BUTTON Actions
    
    @IBAction func goToRegistration(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                .instantiateViewController(identifier: "RegistrationViewController") as? RegistrationViewController else { return }
        
        vc.delegat = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        if  logInWith(userName: userNameTextField.text ?? "", and: passwordTextField.text ?? "") {
            guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main)
                    .instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else { return }

            vc.user = logInedUser
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlert()
        }
    }
}

// MARK: - EXTENSION
extension LogInViewController: LogInViewControllerDelegat {
    
    // PROTOCOL function
    func register(user: User) { manager.register(data: user) }
}

extension LogInViewController {
    
    // Log in if user is registered
    private func logInWith(userName: String, and password: String) -> Bool {
        guard let user = manager.search(by: userName, and: password) else { return false }
        logInedUser = user
        return true
    }
    
    // Show alert
    private func showAlert() {
        let alert = UIAlertController(title: "ERROR", message: "\nIncorrect Credentials", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.view.tintColor = .red
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func resetUI() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.userNameTextField.text = ""
        self.passwordTextField.text = ""
        self.userNameTextField.placeholder = "User Name"
        self.passwordTextField.placeholder = "Password"
    }
}
