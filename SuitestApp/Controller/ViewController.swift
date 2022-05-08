//
//  ViewController.swift
//  SuitestApp
//
//  Created by Farhan Mazario on 29/04/22.
//

import UIKit

class ViewController: UIViewController, DataEnteredDelegate {

    
    @IBOutlet weak var lbFirstName: UILabel!
    @IBOutlet weak var lb_name: UILabel!
    @IBOutlet weak var lbEmail: UILabel!
    @IBOutlet weak var lbWebsite: UILabel!
    @IBOutlet weak var btnChoose: UIButton!
    
    @IBOutlet weak var ivUser: UIImageView!
    
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        lbEmail.isHidden = true
        lbWebsite.isHidden = true
        lbFirstName.text = name
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showListViewController" {
                guard let listVc = segue.destination as? ListViewController else {return}
                listVc.delegate = self
            }
        }

    func userDidEnterInformation(user: User.UserData) {
        lbEmail.isHidden = false
        lbWebsite.isHidden = false
        
        let fullName = user.first_name + user.last_name
        lbFirstName.text = name
        lb_name.text = fullName
        lbEmail.text = user.email
        
        //image
        ivUser.loadImage(url: URL(string: user.avatar)!)
        ivUser.layer.cornerRadius = ivUser.frame.height / 2
        ivUser.clipsToBounds = true
        
        //underline
        let underlineAttribute = [NSAttributedString.Key.underlineStyle: NSUnderlineStyle.thick.rawValue]
        let underlineAttributedString = NSAttributedString(string: "website", attributes: underlineAttribute)
        lbWebsite.attributedText = underlineAttributedString
        //setup clickable
        let tap = UITapGestureRecognizer(target: self, action: #selector(ViewController.tapFunction))
        
        lbWebsite.isUserInteractionEnabled = true
        lbWebsite.addGestureRecognizer(tap)
        
    }
    
    @objc func tapFunction(sender:UITapGestureRecognizer) {
        let webViewController = storyboard?.instantiateViewController(withIdentifier: "WebViewController") as! WebViewController
                
        webViewController.navigationItem.leftBarButtonItem = UIBarButtonItem(
                    title: "Back",
                    style: .done,
                    target: webViewController,
                    action: #selector(webViewController.dismissMe))
        
        /// wrap the new view controller in a navigation controller (this adds the top bar)
        let navigationController = UINavigationController(rootViewController: webViewController)
        navigationController.modalPresentationStyle = .fullScreen
        
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
    
}



