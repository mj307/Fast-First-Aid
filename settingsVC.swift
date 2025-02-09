//
//  settingsVC.swift
//  JambhekarMedhavi-Final
//
//  Created by Medhavi Jam on 11/29/24.
//



import UIKit

class settingsVC: UIViewController {
    
    

    @IBOutlet weak var darkModeSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "#ADD8E6")
        let darkModeEnabled = UserDefaults.standard.bool(forKey: "darkModeEnabled")
        darkModeSwitch.isOn = darkModeEnabled
        applyTheme(darkModeEnabled: darkModeEnabled)

    }

    
    @IBAction func stopMusic(_ sender: Any) {
        AudioManager.shared.pauseAudio()
    }
    
    
    @IBAction func startMusic(_ sender: Any) {
        AudioManager.shared.setupAudioSession()
        AudioManager.shared.playAudio(named: "piano.mp3")
    }
    
    
    @IBAction func darkModeToggled(_ sender: Any) {
        let darkModeEnabled = (sender as AnyObject).isOn
        UserDefaults.standard.set(darkModeEnabled, forKey: "darkModeEnabled") 
        applyTheme(darkModeEnabled: darkModeEnabled!)
    }
    
    func applyTheme(darkModeEnabled: Bool) {
            if darkModeEnabled {
                view.backgroundColor = .black
                navigationController?.navigationBar.barStyle = .black
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .dark
            } else {
                view.backgroundColor = .white
                navigationController?.navigationBar.barStyle = .default
                UIApplication.shared.windows.first?.overrideUserInterfaceStyle = .light
            }
        }
    
    
    
    
}

