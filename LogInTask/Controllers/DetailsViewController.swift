import UIKit

protocol DetailsViewControllerDelegate: AnyObject {
    func backToRootViewController()
}

final class DetailsViewController: UIViewController {
    
    // MARK:- Outlets
    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var saveBtn: UIButton! {
        didSet {
            saveBtn.layer.cornerRadius = 15
            saveBtn.isHidden = true
        }
    }
    @IBOutlet weak var editBtn: UIButton! {
        didSet {
            editBtn.layer.cornerRadius = 15
        }
    }
    
    // MARK:- Properties
    public var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    
    @IBAction func signOut(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil)
                .instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
        
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func saveChanges(_ sender: UIButton) {
        sender.isHidden = true
        editBtn.isHidden = false
        self.textfields(isEnabled: false)
        
        let newUser = User(name: userNameTextField.text ?? "", password: passwordTextField.text ?? "")
        user = newUser
    }
    
    @IBAction func updateData(_ sender: UIButton) {
        sender.isHidden = true
        saveBtn.isHidden = false
        self.textfields(isEnabled: true)
    }
    
    private func textfields(isEnabled: Bool) {
        passwordTextField.isEnabled = isEnabled
        userNameTextField.isEnabled = isEnabled
        passwordTextField.backgroundColor = isEnabled ? .white : .clear
        userNameTextField.backgroundColor = isEnabled ? .white : .clear
    }
    
    private func setupOutlets() {
        userNameTextField.text = user.name
        passwordTextField.text = user.password
    }
}

// MARK:- EXTENSION

extension DetailsViewController: DetailsViewControllerDelegate {
    func backToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }

}
