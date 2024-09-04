import Flutter
import UIKit
import UserXKit

public class SwiftUserxFlutterPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "userx_flutter", binaryMessenger: registrar.messenger())
    let instance = SwiftUserxFlutterPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    let args = call.arguments as? [String: Any]
    switch call.method {
    case "getPlatformVersion":
        result("iOS " + UIDevice.current.systemVersion)
    case "start":
        guard let apiKey = args?.first?.value as? String else { break }
        UserX.start(apiKey)
    case "startWithMarkSessionToUpload":
        guard let apiKey = args?.first?.value as? String else { break }
        UserX.start(apiKey, uploadIfMarked: true)
    case "markSessionToUpload":
        UserX.markSessionToUpload()
    case "configure":
        guard let apiKey = args?.first?.value as? String else { break }
        UserX.configure(apiKey)
    case "startSession":
        UserX.startSession()
    case "stopSession":
        UserX.stopSession()
    case "setUserId":
        guard let userId = args?.first?.value as? String else { break }
        UserX.userId = userId
    case "addEvent":
        guard let eventName = args?["name"] as? String else { return }
        let eventAttrs = args?["attributes"] as? [String: Any]
        UserX.addEvent(eventName, with: eventAttrs)
    case "applyUserAttributes":
        guard let attributes = args?["attributes"] as? Attributes else { return }
        applyUserAttributes(attributes)
    case "addScreenName":
        guard let title = args?["title"] as? String else { return }
        UserX.startScreen(named: title)
    case "stopScreenRecording":
        UserX.stopScreenRecording()
    case "startScreenRecording":
        UserX.startScreenRecording()
    case "sessionUrl":
        result(UserX.sessionUrl)
    case "allSessionsUrl":
        result(UserX.externalAnalyticsUrl)
    case "setCatchExceptions":
        guard let enabled = args?.first?.value as? Bool else { return }
        UserX.catchExceptions = enabled
    default:
        result(FlutterMethodNotImplemented)
    }
  }
}

private extension SwiftUserxFlutterPlugin {
    typealias Attributes = [[String:Any]]
    
    func applyUserAttributes(_ attributes: Attributes) {
        let attributes = attributes.compactMap(Attribute.fromInfo)
        if attributes.isEmpty { return }
        UserX.applyUserAttributes(attributes)
    }
}

private extension Attribute {
    static func fromInfo(_ info: [String:Any]) -> Attribute? {
        guard
            let name = info["name"] as? String,
            let value = info["value"],
            let valueType = info["valueType"] as? String,
            let kind = info["kind"] as? String,
            let action = info["action"] as? String
        else {
            return nil
        }
        
        switch kind {
        case "AttributeKind.counter":
            guard let value = value as? Int64 else { return nil }
           
            switch action {
            case "AttributeAction.set":
                return .counter(name, value: value)
            case "AttributeAction.inc":
                return .increasedCounter(name, by: value)
            case "AttributeAction.dec":
                return .decreasedCounter(name, by: value)
            default:
                return nil
            }
            
        case "AttributeKind.simple":
            guard "AttributeAction.set" == action else { return nil }
            switch valueType {
            case "AttributeValueType.bool":
                guard let value = value as? Bool else { return nil }
                return .key(name, value: value)
            case "AttributeValueType.int":
                guard let value = value as? Int64 else { return nil }
                return .key(name, value: value)
            case "AttributeValueType.double":
                guard let value = value as? Double else { return nil }
                return .key(name, value: value)
            case "AttributeValueType.string":
                guard let value = value as? String else { return nil }
                return .key(name, value: value)
            default:
                return nil
            }
            
        default:
            return nil
        }
    }
}
