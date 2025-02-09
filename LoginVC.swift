import UIKit
import FirebaseAuth
import FirebaseCore
import FirebaseFirestore



class loginVC: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var emailTF: UITextField!
    
    @IBOutlet weak var passwordTF: UITextField!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var sexLabel: UILabel!
    @IBOutlet weak var sexTF: UITextField!
    
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var dobTF: UITextField!
    
    @IBOutlet weak var enterButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hideSignUpFields()
        view.backgroundColor = UIColor(hex: "#ADD8E6")
        AudioManager.shared.setupAudioSession()
        AudioManager.shared.playAudio(named: "piano")
    }
    
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        let isHidden = sender.selectedSegmentIndex == 0
        nameLabel.isHidden = isHidden
        nameTF.isHidden = isHidden
        sexLabel.isHidden = isHidden
        sexTF.isHidden = isHidden
        dobLabel.isHidden = isHidden
        dobTF.isHidden = isHidden
    }
   
    func hideSignUpFields() {
        nameLabel.isHidden = true
        nameTF.isHidden = true
        sexLabel.isHidden = true
        sexTF.isHidden = true
        dobLabel.isHidden = true
        dobTF.isHidden = true
    }

    func showSignUpFields() {
        nameLabel.isHidden = false
        nameTF.isHidden = false
        sexLabel.isHidden = false
        sexTF.isHidden = false
        dobLabel.isHidden = false
        dobTF.isHidden = false
    }
    
    @IBAction func enterButtonTapped(_ sender: Any) {
        let email = emailTF.text ?? ""
        let password = passwordTF.text ?? ""
    
        if email.isEmpty || password.isEmpty {
            showErrorAlert(message: "Please enter your email and password.")
            return
        }
        if segmentedControl.selectedSegmentIndex == 0 {
            signIn(email: email, password: password)
        }
        else {
            let name = nameTF.text ?? ""
            let sex = sexTF.text ?? ""
            let dob = dobTF.text ?? ""
            
            if name.isEmpty || sex.isEmpty || dob.isEmpty {
                showErrorAlert(message: "Please fill in all required fields.")
                return
            }
            
            signUp(email: email, password: password, name: name, sex: sex, dob: dob)
        }
    }
    
    func signIn(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error = error {
                self.showErrorAlert(message: "Failed to sign in: \(error.localizedDescription)")
            } else {
                // Sign in successful, perform segue
                self.performSegue(withIdentifier: "goToVC", sender: self)
            }
        }
    }
    
    func signUp(email: String, password: String, name: String, sex: String, dob: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            if let error = error {
                self.showErrorAlert(message: "Failed to sign up: \(error.localizedDescription)")
            } else {
                self.saveAdditionalUserInfo(name: name, sex: sex, dob: dob)
                
                self.performSegue(withIdentifier: "goToVC", sender: self)
            }
        }
    }
    
    func saveAdditionalUserInfo(name: String, sex: String, dob: String) {
        let user = Auth.auth().currentUser
        guard let uid = user?.uid else { return }
        
        let db = Firestore.firestore()
        let userRef = db.collection("users").document(uid)
        
        userRef.setData([
            "name": name,
            "sex": sex,
            "dob": dob
        ]) { error in
            if let error = error {
                print("Error saving additional user info: \(error.localizedDescription)")
            } else {
                print("User info saved successfully!")
            }
        }
    }

    func showErrorAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
}


extension UIColor {
    convenience init(hex: String) {
        var hexSanitized = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        if hexSanitized.hasPrefix("#") {
            hexSanitized.removeFirst()
        }

        var rgb: UInt64 = 0
        Scanner(string: hexSanitized).scanHexInt64(&rgb)

        let red = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
        let green = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
        let blue = CGFloat(rgb & 0x0000FF) / 255.0

        self.init(red: red, green: green, blue: blue, alpha: 1.0)
    }
}
