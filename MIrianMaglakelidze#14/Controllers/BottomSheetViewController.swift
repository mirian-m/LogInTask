import UIKit

class BottomSheetViewController: UIViewController {
    
    // MARK:- OUTLETS
    
    @IBOutlet weak var yesBtn: UIButton! {
        didSet {
            yesBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var noBtn: UIButton! {
        didSet {
            noBtn.layer.cornerRadius = 10
        }
    }
    @IBOutlet weak var presentView: UIView! {
        didSet {
            presentView.layer.cornerRadius = 20
        }
    }
    
    weak var delegate: DetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK:- BUTTON FUNCTIONS
    
    @IBAction func yesBtnTapped(_ sender: Any) {
        self.dismiss(animated: false) { [weak self] in
            self?.delegate?.backHomeViewController()
        }
    }
    @IBAction func noBtnTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
