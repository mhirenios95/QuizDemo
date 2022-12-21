//
//  Services.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import Foundation
import Alamofire

public typealias FailureMessage = String

enum APINames: String {
    case GetCategoryList = "https://opentdb.com/api.php"
}

struct APIs {
    static let baseURL = "https://opentdb.com/"
    static let GetCategoryList = "api_category.php"
    static let GetQuestions = "api.php?"
    
}
struct Services {
    enum URLConvert: URLRequestConvertible {
        case getCategory([String: Any])
        case getQuestionsList([String: Any])
        
        var path: String {
            
            switch self {
            case .getCategory(_):
                return APIs.GetCategoryList
                
            case .getQuestionsList(_):
                return APIs.GetQuestions
            }
        }
        
        
        func asURLRequest() throws -> URLRequest {
            
            let strUrl = APIs.baseURL + path
            
            let URL = Foundation.URL(string: strUrl)!
            var urlRequest = URLRequest(url: URL as URL)
            _ = ""
            
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            urlRequest.addValue("application/json", forHTTPHeaderField: "Accept")
            urlRequest.httpMethod = "GET"
            urlRequest.timeoutInterval =  120
            
            switch self {
            case .getCategory( _ ):
                urlRequest = try JSONEncoding.default.encode(urlRequest)
            case .getQuestionsList(let parameters):
                let url = urlRequest.url?.absoluteString ?? ""
                var urlRequestNew = Services().getURLRequest(url: url)
                urlRequestNew.httpMethod = "GET"
                urlRequest = try URLEncoding.default.encode(urlRequestNew, with: parameters)
            }
            return urlRequest
        }
        
    }
    func getURLRequest(url: String) -> URLRequest {
        let URL = Foundation.URL(string: url)!
        var urlRequestNew = URLRequest(url: URL as URL)
        _ = ""
        urlRequestNew.addValue("application/json", forHTTPHeaderField: "Content-Type")
        urlRequestNew.addValue("application/json", forHTTPHeaderField: "Accept")
        
        return urlRequestNew
    }
    static func callAPI(serverURL: Services.URLConvert, success: @escaping ((Data) -> Void), failure: @escaping ((FailureMessage) -> Void)) {
        
        AF.request(serverURL).validate().response { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String : Any]
                } catch {
                    print("errorMsg")
                }
                success(data)
            case let .failure(error):
                failure(error.localizedDescription)
            }
        }
    }
}
