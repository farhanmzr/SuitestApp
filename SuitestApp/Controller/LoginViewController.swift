//
//  LoginViewController.swift
//  SuitestApp
//
//  Created by Farhan Mazario on 03/05/22.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var tfName: UITextField!
    @IBOutlet weak var tfPalindrome: UITextField!
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func check(_ sender: Any) {
        
        if tfPalindrome.text == "suitmedia" {
            showDialog(status: false)
        } else {
            showDialog(status: true)
        }
    }
    
    func showDialog(status: Bool){
        let alert = UIAlertController(
            title: "Hasil check isPalindrome",
            message: "\(status)",
            preferredStyle: .alert
        )
        self.present(alert, animated: true) {
            alert.view.superview?.isUserInteractionEnabled = true
            alert.view.superview?.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.dismissOnTapOutside)))
        }
        
    }
    
    @objc func dismissOnTapOutside() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func next(_ sender: Any) {
        
        let mainVc = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
        mainVc.name = tfName.text
        let navigationController = UINavigationController(rootViewController: mainVc)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
        
    }
    
}
