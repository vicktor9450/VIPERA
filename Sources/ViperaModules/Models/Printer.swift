
public protocol PrinterInterface: class {
    func print(message: Printer.MessageType)
    func print(_ error: Error)
}

public class Printer: PrinterInterface {
    
    public init() {}
    
    public func print(message: MessageType) {
        Swift.print(message.string)
    }
    
    public func print(_ error: Error) {
        Swift.print(error.localizedDescription)
    }
    
    public enum MessageType: Equatable {
        case footer
        case help
        case invalidUsageOfPath
        case moduleCreated(moduleName: String, isTemplateLocal: Bool)
        case moduleNameNotFound
        case unknownArgument(String)
        case version
        
        var string: String {
            switch self {
            case .footer:
                return Messages.footer
            case .help:
                return Messages.help
            case .invalidUsageOfPath:
                return Messages.invalidUsageOfPath
            case let .moduleCreated(moduleName, isTemplateLocal):
                let templateLocalization = isTemplateLocal ? "local" : "global"
                return String(format: Messages.moduleCreated, moduleName, templateLocalization)
            case .moduleNameNotFound:
                return Messages.moduleNameNotFound
            case let .unknownArgument(arg):
                return String(format: Messages.unknownArgument, arg)
            case .version:
                return Messages.version
            }
        }
    }
}
