import UIKit

protocol DetailsViewControllerDelegate: AnyObject {
    func backToRootViewController()
}

class DetailsViewController: UIViewController {
    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    public var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupOutlets()
    }
    
    @IBAction func signOut(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func setupOutlets() {
        userName.text = user?.name
        email.text = user?.email
    }
}

// MARK:- EXTENSION

extension DetailsViewController: DetailsViewControllerDelegate {
    func backToRootViewController() {
        navigationController?.popToRootViewController(animated: true)
    }

}
