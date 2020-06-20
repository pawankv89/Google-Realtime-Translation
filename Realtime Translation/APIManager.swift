//
//  APIManager.swift
//  Realtime Translation
//
//  Created by Pawan kumar on 19/06/20.
//  Copyright © 2020 Pawan Kumar. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    public enum HTTPMethod: String {
        case OPTIONS = "OPTIONS"
        case GET     = "GET"
        case HEAD    = "HEAD"
        case POST    = "POST"
        case PUT     = "PUT"
        case PATCH   = "PATCH"
        case DELETE  = "DELETE"
        case TRACE   = "TRACE"
        case CONNECT = "CONNECT"
    }
    
    static let shared = APIManager()
    
    //Constructor
    private init() { }
    
    func isValidObjectValue(value: String) -> String {
        
        var isValidString = value
        if isValidString == "null" || isValidString == "<null>" || isValidString == "(null)"  {
            isValidString = ""
        }
        return isValidString
    }
    
    func customCommonHeaders() -> [String : String] {

          var headers: Dictionary <String, String> = [:]
          
          //Fixed Headers Authorization
          //headers["Accept"] = "application/json"
          //headers["Content-Type"] = "application/json"
          //headers["Content-Type"] = "application/json; charset=utf-8"
          //headers["Content-Type"] = "application/x-www-form-urlencoded"
          
          return headers
      }
    
    // Translate Googleapis
    func translateGoogleapisApi(parameters: Dictionary<String, String>, completionHandler: @escaping ( Array<Any>)-> ()) {
    
        //Check Internet Connection
        if NetworkManager.shared.isConnected == false {
            //Toast.shared.showToastMessage(message: "You are not connected to the internet please try later")
            completionHandler([]) //Go back
            return
        }
        
        let sl: String = parameters["sl"]!
        let tl: String = parameters["tl"]!
        let dt: String = parameters["dt"]!
        let q: String = parameters["q"]!
       
        // Set up the URL request
        var urlEndpoint: String = "https://translate.googleapis.com/translate_a/single?client=gtx&sl=\(sl)&tl=\(tl)&dt=\(dt)&q=\(q)"
        
           //Encoaded URL before Request
           urlEndpoint = urlEndpoint.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)!
           
           //Print
           DLogs.logs(printMessage: "Request", printDetails: urlEndpoint)
           
           //Print
           DLogs.logs(printMessage: "Parameters", printDetails: parameters)
           
           //HTTP REQUEST HERE
           var request = URLRequest(url: URL(string: urlEndpoint)!)
           
           request.httpMethod = HTTPMethod.GET.rawValue
           
           //Add Custom Common Headers
           request.allHTTPHeaderFields = self.customCommonHeaders()
           
           let task = URLSession.shared.dataTask(with: request as URLRequest) {
               (data, response, error) -> Void in
               if let unwrappedData = data {
                do {
                    let responseObject: Any = try JSONSerialization.jsonObject(with: unwrappedData, options: JSONSerialization.ReadingOptions.mutableContainers)
                       
                       //Print
                       DLogs.logs(printMessage: "Response", printDetails: responseObject)
                       
                       //Check Status Code
                       if let httpStatus = response as? HTTPURLResponse {
                           
                           if  httpStatus.statusCode <= 299  && httpStatus.statusCode >= 200 {
                               //Print
                               DLogs.logs(printMessage: "statusCode should be 200, but is", printDetails: httpStatus.statusCode)
                               
                               if responseObject is NSDictionary {
                              
                                   //let resposeList: NSDictionary = responseObject as! NSDictionary
                                   //completionHandler(resposeList)
                                   completionHandler([])
                               }
                               if responseObject is Array<Any> {
                                
                                   let resposeList: Array<Any> = (responseObject as? Array<Any>)!
                                   completionHandler(resposeList)
                                    
                               }
                           }
                           else{
                               //Wrong Status code here
                           }
                       }
                   }
                   catch {
                       
                       //Got Respomnse here
                       completionHandler([])
                   }
               }
           }
        
        task.resume()
    }
}
