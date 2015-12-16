import Foundation
import Alamofire

extension Soracom {
    public class func auth(email: String,
        password: String,
        timeout: Int = 86400,
        onSuccess: (() -> ())? = nil,
        onError: ((NSError) -> ())? = nil) {
            Alamofire.request(Router.Auth(["email" : email, "password": password, "tokenTimeoutSeconds" : timeout])).responseJSON { response in
                if let error = response.result.error {
                    onError?(error)
                } else {
                    if let value = response.result.value as? [String: String],
                        let apiKey = value["apiKey"],
                        let token = value["token"],
                        let operatorId = value["operatorId"]
                    {
                        Router.token = token
                        Router.apiKey = apiKey
                        Router.operatorId = operatorId
                        onSuccess?()
                    } else {
                        print(response.result.value)
                    }
                }
            }
    }

    public static var isLoggedIn: Bool {
        return Router.apiKey != nil
    }

    public static var operatorId: String? {
        return Router.operatorId
    }
}
