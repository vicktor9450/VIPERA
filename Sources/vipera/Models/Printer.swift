
class Printer {
    func print(message: MessageType) {
        Swift.print(message.string)
    }
    
    func print(_ error: Error) {
        Swift.print(error.localizedDescription)
    }
    
    enum MessageType {
        case footer
        case help
        case moduleCreated(moduleName: String, isTemplateLocal: Bool)
        case version
        
        var string: String {
            switch self {
            case .footer:
                return Messages.footer
            case .help:
                return Messages.help
            case let .moduleCreated(moduleName, isTemplateLocal):
                let templateLocalization = isTemplateLocal ? "local" : "global"
                return String(format: Messages.moduleCreated, moduleName, templateLocalization)
            case .version:
                return Messages.version
            }
        }
    }
}
