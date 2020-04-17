import Foundation
import Dir
import ViperaModules

func main() {
    let printer = Printer()
    let dirManager = DirectoryManager()
    let args = ArgumentsReader().passedArguments()
    
    if args.contains(.version) {
        printer.print(message: .version)
        exit(0)
    }
    
    if args.contains(.help) {
        printer.print(message: .help)
        exit(0)
    }
    
    guard !args.isEmpty else {
        printer.print(message: .help)
        exit(0)
    }
        
    let currentDir = dirManager.currentDir()
    let localTemplateDir = dirManager.localTemplateDir()
    let templateDir = localTemplateDir ?? dirManager.globalTemplateDir()
    
    let moduleParentDirectory: Dir
    
    let pathArg = args.first(where: {
        guard case .path = $0 else { return false }
        return true
    })
    switch pathArg {
    case .none:
        moduleParentDirectory = currentDir
    case let .path(path):
        guard let path = path else {
            printer.print(message: .invalidUsageOfPath)
            exit(-1)
        }
        do {
            moduleParentDirectory = try dirManager.createChildDir(path: path)
        } catch {
            printer.print(error)
            exit(-1)
        }
    default:
        exit(-1)
    }
    
    let moduleName = args.reduce(into: "") { (result, arg) in
        guard case let .moduleName(moduleName) = arg else { return }
        result = moduleName.capitalizedFirstLetter()
    }
    
    guard !moduleName.isEmpty else {
        printer.print(message: .moduleNameNotFound)
        exit(-1)
    }
    
    let userName = getGitUserName() ?? "VIPERA Generator"
    let date = getFormattedDate()
    let projectName = getProjectName(from: currentDir.url) ?? moduleName
    
    let params = [
        "module": moduleName,
        "project": projectName,
        "author": userName,
        "date": date,
    ]
    
    do {
        let moduleDir = try moduleParentDirectory.add(moduleName)
        try createModuleComponent(from: templateDir.url, to: moduleDir.url, withParams: params)
        
        printer.print(message: .moduleCreated(moduleName: moduleName, isTemplateLocal: localTemplateDir != nil))
    } catch {
        printer.print(error)
        exit(-1)
    }
    
    printer.print(message: .footer)
}

main()
