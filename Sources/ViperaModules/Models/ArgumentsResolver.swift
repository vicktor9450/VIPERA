import Foundation

public class ArgumentsResolver {
    private let printer: PrinterInterface
    
    public init(printer: PrinterInterface = Printer()) {
        self.printer = printer
    }
    
    // MARK: - Public
    public func resolve(args: Set<Argument>) -> Result<Parameters, ExitError> {
        guard !args.isEmpty else {
            self.printer.print(message: .help)
            return .failure(ExitError(code: 0))
        }
        guard !args.contains(.help) else {
            self.printer.print(message: .help)
            return .failure(ExitError(code: 0))
        }
        guard !args.contains(.version) else {
            self.printer.print(message: .version)
            return .failure(ExitError(code: 0))
        }
        var dirPath: String?
        var moduleName: String?
        for arg in args {
            switch arg {
            case .version: fatalError()
            case .help: fatalError()
            case let .moduleName(name):
                moduleName = name
            case let .path(path):
                guard path != nil else {
                    self.printer.print(message: .invalidUsageOfPath)
                    return .failure(ExitError(code: -1))
                }
                dirPath = path
            case let .unknown(arg):
                self.printer.print(message: .unknownArgument(arg))
            }
        }
        guard let name = moduleName else {
            self.printer.print(message: .moduleNameNotFound)
            return .failure(ExitError(code: -1))
        }
        return .success(Parameters(moduleParentDirRelativePath: dirPath, moduleName: name))
    }
    
    // MARK: - Structures
    public struct Parameters: Equatable {
        public let moduleParentDirRelativePath: String?
        public let moduleName: String
    }
}
