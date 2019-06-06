//
//  Connection.swift
//  Util
//
//  Created by Ilija Stevanovic on 6/5/19.
//  Copyright © 2019 util. All rights reserved.
//

import Foundation

public typealias CompletionHandler = ([String: Any]?, URLResponse?, Error?) -> Void


public func initUrlRequest(endPoint: String, headers: [String: Any]?, body: [String: Any]?, method: RequestMethod) -> URLRequest {
    let url = URL (string: endPoint)
    var request = URLRequest(url: url!)
    if headers != nil {
        for header in headers! {
            request.setValue(header.value as? String, forHTTPHeaderField: header.key)
        }
    }

    var bodyString = ""
    if body != nil {
        for body in body! {
            bodyString.append("\(body.key)=\(body.value)&")
        }
        bodyString.remove(at: bodyString.index(before: bodyString.endIndex))
    }

    if (bodyString.count != 0) {
        let bodyData: Data = bodyString.data(using: String.Encoding.ascii, allowLossyConversion: true)!
        request.httpBody = bodyData
    }

    request.httpMethod = method.rawValue
    request.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
    return request
}

public func executeRequest(request: URLRequest, completionHandler: CompletionHandler?)  {
    let task = URLSession.shared.dataTask(with: request) { data, response, error in
        guard let data = data, error == nil else {
            if (completionHandler != nil) {
                DispatchQueue.main.async {
                    completionHandler!(nil, response, error)
                }
            }
            return
        }

        if (completionHandler != nil) {
            let responseString = String(data: data, encoding: .utf8)
            let responseDict = responseString?.convertToDictionary()
            DispatchQueue.main.async {
                completionHandler!(responseDict, response, error)
            }
        }
        return
    }
    task.resume()
}

extension String {
    func convertToDictionary() -> [String: Any]? {
        if let data = self.data(using: .utf8) {
            do {
                return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
}

public enum RequestMethod: String {
    case GET = "GET"
    case POST = "POST"
}
