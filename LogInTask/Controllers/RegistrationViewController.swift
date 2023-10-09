import UIKit

final class RegistrationViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    // MARK: - PROPERTIES
    private var user: User {
        get {
            return User(name: userName.text ?? "",  password: password.text ?? "")
        }
    }
    private let numberString: [String] = (0...9).map { String($0) }
    private let alphabet = [
        "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"
    ]
    
    weak var delegat: LogInViewControllerDelegat?
    
    // MARK: - CONTROLLER LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItem()
    }
    
    // MARK: - BUTTON ACTIONS
    @IBAction func signUp(_ sender: Any) {
        registrationCheckFor(
            password: password.text ?? "",
            name: userName.text ?? "",
            confirmPassword: confirmPassword.text ?? ""
        )
    }
}

// MARK: - EXTENSION
extension RegistrationViewController {
    
    // Setup Function
    func setupNavigationBarItem() {
        let image = UIImage(systemName: "arrowshape.turn.up.backward")
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.backIndicatorImage = image
        navigationController?.navigationBar.backIndicatorTransitionMaskImage = image
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    // MARK: - VALIDITY FUNCTIONS
    
    // Checking password validity
    private func isPasswordValid(_ passowrd: String) -> Bool {
        return passowrd.count >= 8 &&
            passowrd.map({ alphabet.contains(String($0)) }).contains(true) &&
            passowrd.map({ numberString.contains(String($0)) }).contains(true)
    }
    
    // checking if confirm password is matched to main password
    private func isConfirmdPasswordMatch(_ confirmedPassword: String) -> Bool {
        return confirmedPassword == password.text
    }
    
    // Check registration
    func registrationCheckFor(password: String, name: String, confirmPassword: String) {
        switch false {
        case isPasswordValid(password):
            showAlertWith(title: "ERROR", text: "This password is not Secure")
        case isConfirmdPasswordMatch(confirmPassword):
            showAlertWith(title: "ERROR", text: "Passwords doesn't Match")
        case !name.isEmpty:
            showAlertWith(title: "ERROR", text: "Please fill in all Fields")
        default:
            showSuccessMessageAndGoBackToLogIn()
        }
    }
    
    // SHOWALERT FUNCTIONS
    func showSuccessMessageAndGoBackToLogIn() {
        let alert = UIAlertController(title: "SUCCESS", message: "\nRegistration completed Successfully\nClick 'OK' to return to the LogIn page", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default) { [weak self] (result: UIAlertAction) -> Void in
            self?.delegat?.register(user: self!.user)
            self?.navigationController?.popViewController(animated: true)
        }
        alert.addAction(action)
        alert.view.tintColor = .green
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWith(title: String, text: String) {
        let alert = UIAlertController(title: title, message: "\n\(text)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        alert.view.tintColor = .red
        present(alert, animated: true, completion: nil)
    }
}
