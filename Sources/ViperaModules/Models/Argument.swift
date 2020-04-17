import Foundation

public enum Argument: Hashable {
    case version
    case help
    case path(String?)
    case moduleName(String)
    case unknown(String)
}
