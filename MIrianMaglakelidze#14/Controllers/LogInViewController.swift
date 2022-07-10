import UIKit

protocol LogInViewControllerDelegat: class {
    func getInfo(user: User)
}
class LogInViewController: UIViewController {
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var password: UITextField!
    private var registeredUsers: [User] = []
    
    // MARK:- CONTROLLER LIFE CYCLE FUNCTION
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        setUpControllerOutlet()
    }
    
    func setUpControllerOutlet() {
        navigationController?.setNavigationBarHidden(true, animated: true)
        self.userName.text = ""
        self.password.text = ""
        self.userName.placeholder = "User Name"
        self.password.placeholder = "Password"
        
    }
    // MARK:- BUTTON FUNCTION
    @IBAction func goToRegistration(_ sender: Any) {
        guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "RegistrationViewController") as? RegistrationViewController else { return }
        vc.delegat = self
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func goToDetails(_ sender: Any) {
        if let user = checkRegistration()?.first {
            guard let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(identifier: "DetailsViewController") as? DetailsViewController else { return }
            vc.user = User(name: user.name, email: user.email, passwor: user.passwor)
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            showAlert()
        }
    }
}

// MARK: - EXTENSION
extension LogInViewController: LogInViewControllerDelegat {
    
    // PROTOCOL function
    func getInfo(user: User) {
        registeredUsers.append(user)
    }
    
    // Check IF User is registrate
    private func checkRegistration() -> [User]? {
        return registeredUsers.filter { $0.name == userName.text && $0.passwor == password.text }
    }
    
    // Show alert method
    private func showAlert() {
        let alert = UIAlertController(title: "ERROR", message: "\nIncorrect Credentials", preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
}
