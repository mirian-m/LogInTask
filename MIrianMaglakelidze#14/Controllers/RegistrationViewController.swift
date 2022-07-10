import UIKit

class RegistrationViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    // MARK: - PROPERTIES
    private var user: User {
        get {
            return User(name: userName.text ?? "", email: email.text ?? "", passwor: password.text ?? "")
        }
    }
    weak var delegat: LogInViewControllerDelegat?
    private let numberString: [String] = (0...9).map { String($0) }
    private let alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    // MARK: - CONTROLLER LIFE CYCLE METHODS
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBarItem()
    }
    
    // MARK: - BUTTON ACTIONS
    @IBAction func signUp(_ sender: Any) {
        registrationCheckFor(email: email.text ?? "", password: password.text ?? "", name: userName.text ?? "", confirmPas: confirmPassword.text ?? "")
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
    
    // Check Email validity
    private func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Checking password validity
    private func isPasswordValid(_ passowrd: String) -> Bool {
        return passowrd.count >= 8 &&
            passowrd.map({ alphabet.contains(String($0)) }).contains(true) &&
            passowrd.map({ numberString.contains(String($0)) }).contains(true)
    }
    
    // checking if confirm password is matche to main password
    private func isConfirmdPasswordMatch(_ confirmedPassword: String) -> Bool {
        return confirmedPassword == password.text
    }
    
    // Check registration
    func registrationCheckFor(email: String, password: String, name: String, confirmPas: String) {
        switch false {
        case isValidEmail(email):
            showAlertWith(title: "ERROR", text: "Email is not Valid")
        case isPasswordValid(password):
            showAlertWith(title: "ERROR", text: "This password is not Secure")
        case isConfirmdPasswordMatch(confirmPas):
            showAlertWith(title: "ERROR", text: "Passwords doesn't Match")
        case !name.isEmpty:
            showAlertWith(title: "ERROR", text: "Please fill in all Fields")
        default:
            let alert = UIAlertController(title: "SUCCESS", message: "\nRegistration completed Successfully\nPress 'OK' To go Log In Pages", preferredStyle: .alert)
            let action = UIAlertAction(title: "OK", style: .default) { [weak self](result: UIAlertAction) -> Void in
                self?.delegat?.getInfo(user: self!.user)
                self?.navigationController?.popViewController(animated: true)
            }
            alert.addAction(action)
            present(alert, animated: true, completion: nil)
        }
    }
    
    // ALERT FUNCTION
    func showAlertWith(title: String, text: String) {
        let alert = UIAlertController(title: title, message: "\n\(text)", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
