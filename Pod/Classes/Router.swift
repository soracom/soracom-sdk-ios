import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    static let defaultEndpoint = "https://api.soracom.io/v1"
    static var token: String?
    static var apiKey: String?
    static var operatorId: String?
    static var endpoint: String = defaultEndpoint
    
    case Auth([String: AnyObject])
    case Subscribers([String: AnyObject])
    case SubscriberUpdateSpeedClass(String, [String: AnyObject])
    
    var method: Alamofire.Method {
        switch self {
        case .Auth:
            return .POST
        case .Subscribers:
            return .GET
        case .SubscriberUpdateSpeedClass:
            return .POST
        }
    }
    
    var path: String {
        switch self {
        case .Auth:
            return "/auth"
        case .Subscribers:
            return "/subscribers"
        case .SubscriberUpdateSpeedClass(let imsi, _):
            return "/subscribers/\(imsi)/update_speed_class"
        }
    }
    
    var contentType: String? {
        switch self {
        case .Auth:
            return "application/json"
        default:
            return nil
        }
    }
    
    var URLRequest: NSMutableURLRequest {
        let URL = NSURL(string: Router.endpoint)!
        let mutableURLRequest = NSMutableURLRequest(URL: URL.URLByAppendingPathComponent(path))
        mutableURLRequest.HTTPMethod = method.rawValue
        
        mutableURLRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        if let token = Router.token, apiKey = Router.apiKey {
            mutableURLRequest.setValue(token, forHTTPHeaderField: "X-Soracom-Token")
            mutableURLRequest.setValue(apiKey, forHTTPHeaderField: "X-Soracom-API-Key")
        }
        if let contentType = contentType {
            mutableURLRequest.setValue(contentType, forHTTPHeaderField: "Content-Type")
        }

        switch self {
        case .Auth(let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        case .Subscribers(let parameters):
            return Alamofire.ParameterEncoding.URL.encode(mutableURLRequest, parameters: parameters).0
        case .SubscriberUpdateSpeedClass(_, let parameters):
            return Alamofire.ParameterEncoding.JSON.encode(mutableURLRequest, parameters: parameters).0
        }
    }
}