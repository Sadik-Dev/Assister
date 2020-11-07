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
    case Consultations
    case east
    case west
}

class HttpRequests{
    
    let session = URLSession.shared
    let apiUrl = "http://192.168.1.8:1025/api/"
    var bearer = ""
    
    
    func setBearer(token : String){
        bearer = token
    }
    
    func getArray(controller : RequestController) -> [Consultation]?{
       
        // Create a URLRequest for an API endpoint
        let endpoint = apiUrl + controller.rawValue
        print(endpoint)
        let url = URL(string: endpoint)!
        var request = URLRequest(url: url)
        var responseCode : Int? = nil
        var resultObject : [Consultation]? = Array<Consultation>()
                  
                         
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json",
            "Accept": "application/json",
            "Authorization": "Bearer \(String(describing: bearer))"
            ]
        
        request.httpMethod = "GET"
        let semaphore = DispatchSemaphore(value: 0)  //1. create a counting semaphore

       // Create the HTTP request
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, response, error) in

            if let error = error {
                // Handle HTTP request error
                print(error)
                semaphore.signal()

            } else if let data = data {
                // Handle HTTP request response
                 if let httpResponse = response as? HTTPURLResponse {
                    
                                    // Handle HTTP request response
                                    responseCode = httpResponse.statusCode
                                   }
                
                                   // Serialize the data into an object
                                   do {
                                        let json = try? JSONSerialization.jsonObject(with: data, options: [])
                            
                                        let decoder = JSONDecoder()
                                        let formatter = DateFormatter()
                                        formatter.dateFormat = "yyyy/MM/dd'T'HH:mm:ss"
                                    
                                        decoder.dateDecodingStrategy = .formatted(formatter)

                                        let res = try decoder.decode([Consultation].self, from: data )
                                   
                                        resultObject = res
                                           
                                        semaphore.signal()
                                                               
                                       }
                                       catch {
                                        print("Error during JSON serialization: \(error.self)")
                                       }
            } else {
                // Handle unexpected error
                print("Unhandled Error")
                semaphore.signal()
            }
        }
        
        task.resume()
        semaphore.wait()
        //Handle Return Value
        if( responseCode != 200 ){
            
            resultObject = Array<Consultation>()
            return resultObject

            }
        else {
            
            return resultObject
            
        }

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
                setBearer(token: (user?.getBearer())!)
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
                   
            
                   
                   request.allHTTPHeaderFields = [
                       "Content-Type": "application/json",
                       "Accept": "application/json",
                       "Authorization": "Bearer \(bearer)"
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
