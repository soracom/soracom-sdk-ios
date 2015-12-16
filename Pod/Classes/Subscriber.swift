import Foundation


public enum TagValueMatchMode: String {
    case Exact = "exact"
    case Prefix = "prefix"
}

public enum SubscriberStatus: String {
    case Active = "active"
    case Inactive = "inactive"
    case Ready = "ready"
    case InStock = "instock"
    case Shipped = "shipped"
    case Suspended = "suspended"
    case Terminated = "terminated"
}

public enum SpeedClass: String {
    case S1Minimum = "s1.minimum"
    case S1Slow = "s1.slow"
    case S1Standard = "s1.standard"
    case S1Fast = "s1.fast"
}

public class Subscriber {
    public var IMSI: String
    public var MSISDN: String
    public var ipAddress: String?
    public var APN: String?
    public var speedClass: SpeedClass?
    public var status: SubscriberStatus
    public var tags: [String: String]

    init(value: [String: AnyObject]) {
        self.IMSI = value["imsi"] as! String
        self.MSISDN = value["msisdn"] as! String
        self.APN = value["apn"] as! String?
        if let ipAddress = value["ipAddress"] as? String {
            self.ipAddress = ipAddress
        }
        if let speedClass = value["speedClass"] as? String {
            self.speedClass = SpeedClass(rawValue: speedClass)
        }
        self.status = SubscriberStatus(rawValue: value["status"] as! String)!
        self.tags = value["tags"] as! [String: String]
    }
}

