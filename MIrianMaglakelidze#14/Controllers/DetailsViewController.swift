import UIKit

protocol DetailsViewControllerDelegate: class {
    func backHomeViewController()
}
class DetailsViewController: UIViewController {
    @IBOutlet weak var signOut: UIButton!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var email: UILabel!
    
    public var user: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpOutlets()
    }
    
    @IBAction func signOut(_ sender: Any) {
        guard let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "BottomSheetViewController") as? BottomSheetViewController else { return }
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func setUpOutlets() {
        userName.text = user?.name
        email.text = user?.email
    }
}

// MARK:- EXTENSION

extension DetailsViewController: DetailsViewControllerDelegate {
    func backHomeViewController() {
        navigationController?.popToRootViewController(animated: true)
    }

}
