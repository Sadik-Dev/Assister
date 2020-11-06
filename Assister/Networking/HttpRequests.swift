//
//  HttpRequests.swift
//  Assister
//
//  Created by Sana on 06/11/2020.
//  Copyright © 2020 Sadik-Dev. All rights reserved.
//

import Foundation

enum RequestController : String {
    case Users
    case Posts
    case east
    case west
}

class HttpRequests{
    
    let session = URLSession.shared
    let apiUrl = "http://192.168.1.8:1025/api/"
    
    
    func get(controller : RequestController){
       
        // Create a URLRequest for an API endpoint
        let endpoint = apiUrl + controller.rawValue
        print(endpoint)
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        
//        // Configure request authentication
//        request.setValue(
//            "authToken",
//            forHTTPHeaderField: "Authorization"
//        )
        
        request.httpMethod = "GET"

       // Create the HTTP request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                // Handle HTTP request error
                print(error)
            } else if let data = data {
                // Handle HTTP request response
                print(data)
                print(response as Any)
            } else {
                // Handle unexpected error
            }
        }
        
        task.resume()

    }
    

    func login<T: Any & Codable & Decodable>(controller : RequestController, object : T ) -> User?{
           
            // Create a URLRequest for an API endpoint
            let endpoint = apiUrl + "Users/authenticate"
            print(endpoint)
            let url = URL(string: endpoint)!
            var request = URLRequest(url: url)
            var user : User? = nil
            var responseCode : Int? = nil
            
    //        // Configure request authentication
    //        request.setValue(
    //            "authToken",
    //            forHTTPHeaderField: "Authorization"
    //        )
            
            request.allHTTPHeaderFields = [
                "Content-Type": "application/json",
                "Accept": "application/json"
            ]
          

            // Change the URLRequest to a POST request
            request.httpMethod = "POST"
            request.httpBody = try! JSONEncoder().encode(object)

            let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore

           // Create the HTTP request
            let session = URLSession.shared
            let task = session.dataTask(with: request) { (data, response, error) in

                if let error = error {
                    // Handle HTTP request error
                    print(error)
                    semaphore.signal()

                }
                
                else if let data = data {
                    //Save the status code
                     if let httpResponse = response as? HTTPURLResponse {
                        // Handle HTTP request response
                        responseCode = httpResponse.statusCode
                    }
                    // Serialize the data into an object
                    do {
                                        
                        let res = try JSONDecoder().decode(T.self, from: data )
                    
                        user = res as! User
                            
                        semaphore.signal()
                                                
                        }
                        catch {
                            print("Error during JSON serialization: \(error.localizedDescription)")
                        }
                } else {
                    print("Unhandled Error")
                    semaphore.signal()

                }
            }
            
            task.resume()
            semaphore.wait()  
            //Handle Return Value
            if( responseCode != 200 ){
                
                    return nil

                }
            else {
             return user
                
            }
            
        }
    
         func post<T: Any & Codable>(controller : RequestController, object : T ) -> User?{
                  
                   // Create a URLRequest for an API endpoint
                   let endpoint = apiUrl + "Users/authenticate"
                   print(endpoint)
                   let url = URL(string: endpoint)!
                   var request = URLRequest(url: url)
                   var user : User? = nil
                   var responseCode : Int? = nil
                   
           //        // Configure request authentication
           //        request.setValue(
           //            "authToken",
           //            forHTTPHeaderField: "Authorization"
           //        )
                   
                   request.allHTTPHeaderFields = [
                       "Content-Type": "application/json",
                       "Accept": "application/json"
                   ]
                 

                   // Change the URLRequest to a POST request
                   request.httpMethod = "POST"
                   request.httpBody = try! JSONEncoder().encode(object)

                   let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore

                  // Create the HTTP request
                   let session = URLSession.shared
                   let task = session.dataTask(with: request) { (data, response, error) in

                       if let error = error {
                           // Handle HTTP request error
                           print(error)
                           semaphore.signal()

                       }
                       
                       else if let data = data {
                           //Save the status code
                            if let httpResponse = response as? HTTPURLResponse {
                               // Handle HTTP request response
                               responseCode = httpResponse.statusCode
                           }
                           // Serialize the data into an object
                           do {
                                               
                               let res = try JSONDecoder().decode(User.self, from: data )
                           
                               user = res
                                   
                               semaphore.signal()
                                                       
                               }
                               catch {
                                   print("Error during JSON serialization: \(error.localizedDescription)")
                               }
                       } else {
                           print("Unhandled Error")
                           semaphore.signal()

                       }
                   }
                   
                   task.resume()
                   semaphore.wait()
                   //Handle Return Value
                   if( responseCode != 200 ){
                       
                           return nil

                       }
                   else {
                    return user
                       
                   }
                   
               }
    
}
