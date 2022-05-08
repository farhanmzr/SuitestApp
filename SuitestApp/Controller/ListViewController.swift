//
//  ListViewController.swift
//  SuitestApp
//
//  Created by Farhan Mazario on 02/05/22.
//

import UIKit
import MapKit

// protocol used for sending data back
protocol DataEnteredDelegate: AnyObject {
    func userDidEnterInformation(user: User.UserData)
}

class ListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var mapView: MKMapView!
    
    // making this a weak variable so that it won't create a strong reference cycle
    weak var delegate: DataEnteredDelegate?
    
    var users = [User.UserData](){
        didSet{
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var apiService = ApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //show/hide
        tableView.isHidden = false
        mapView.isHidden = true
        
        //FetchData
        apiService.fetchData { userData in
            self.users = userData
        }
        //TableView
        tableView.dataSource = self
        tableView.register(UINib(nibName: "UserTableViewCell", bundle: nil), forCellReuseIdentifier: "UserCell")
        tableView.delegate = self
        //menuRight
        let icMaps = UIImage(named: "ic_maps")?.withRenderingMode(.alwaysOriginal)
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: icMaps, style: .plain, target: self, action: #selector(MapsTapped))
        
        
    }
    
    @objc func MapsTapped() {
        //show/hide
        tableView.isHidden = true
        mapView.isHidden = false
        
        let icList = UIImage(named: "ic_list")?.withRenderingMode(.alwaysOriginal)
         navigationItem.rightBarButtonItem = UIBarButtonItem(image: icList, style: .plain, target: self, action: #selector(viewDidLoad))
        
        //maps
        let longTapGesture = UILongPressGestureRecognizer(target: self, action: #selector(longTap))
        mapView.addGestureRecognizer(longTapGesture)
        
    }
    
    @objc func longTap(sender: UIGestureRecognizer){
        print("long tap")
        if sender.state == .began {
            let locationInView = sender.location(in: mapView)
            let locationOnMap = mapView.convert(locationInView, toCoordinateFrom: mapView)
            addAnnotation(location: locationOnMap)
        }
    }

    func addAnnotation(location: CLLocationCoordinate2D){
            let annotation = MKPointAnnotation()
            annotation.coordinate = location
            annotation.title = "Some Title"
            annotation.subtitle = "Some Subtitle"
            mapView.addAnnotation(annotation)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "UserCell", for: indexPath) as? UserTableViewCell {
            
            let userData = self.users[indexPath.row]
            let fullName = userData.first_name + userData.last_name
            cell.nameUser.text = fullName
            cell.emailUser.text = userData.email
            
            cell.imagesUser.loadImage(url: URL(string: userData.avatar)!)
            
            cell.imagesUser.layer.cornerRadius = cell.imagesUser.frame.height / 2
            cell.imagesUser.clipsToBounds = true
            
            
            return cell
            
        } else {
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let userData = self.users[indexPath.row]
        
        //method implements the delegate protocol
        self.delegate?.userDidEnterInformation(user: userData)
        // go back to the previous view controller
        self.navigationController?.popToRootViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}

extension UIImageView {
    func loadImage(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}


