//
//  ApiService.swift
//  SuitestApp
//
//  Created by Farhan Mazario on 29/04/22.
//

import Foundation

struct ApiService
{
    
    func fetchData(completionHandler: @escaping (([User.UserData]) -> Void))
    {
        //code for calling web api and get the data
        let apiUrl = "https://reqres.in/api/users?per_page=12"
        guard let url = URL(string: apiUrl) else {fatalError("Invalid URL")}
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else {return}
            print(data)
            do {
                let decoder = JSONDecoder()
                let users = try decoder.decode(User.self, from: data)
                completionHandler(users.data)
                
                print(users as Any)
            } catch DecodingError.dataCorrupted(let context) {
                print(context)
            } catch DecodingError.keyNotFound(let key, let context) {
                print("Key '\(key)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.valueNotFound(let value, let context) {
                print("Value '\(value)' not found:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch DecodingError.typeMismatch(let type, let context) {
                print("Type '\(type)' mismatch:", context.debugDescription)
                print("codingPath:", context.codingPath)
            } catch {
                print("error: ", error)
            }
            
        }.resume()
        
    }
}



