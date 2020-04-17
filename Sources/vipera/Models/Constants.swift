import Foundation

struct Constants {
    static let version: String = "2.1.0"
    static let scriptName: String = URL(fileURLWithPath: CommandLine.arguments.first!).lastPathComponent
}
