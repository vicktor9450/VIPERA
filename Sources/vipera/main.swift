import Foundation
import Dir
import ViperaModules

func main() throws {
    let printer = Printer()
    let dirManager = DirectoryManager()
    let args = ArgumentsReader().passedArguments()
    let argsResolver = ArgumentsResolver()
    
    let argsReadingResult = argsResolver.resolve(args: args)
    
    let currentDir = dirManager.currentDir()
    
    var moduleParentDirectory: Dir = currentDir
    var moduleName: String = ""
    switch argsReadingResult {
    case let .failure(exitError):
        exit(exitError.code)
    case let .success(params):
        moduleName = params.moduleName
        guard let path = params.moduleParentDirRelativePath else { break }
        moduleParentDirectory = try dirManager.createChildDir(path: path)
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
    
    let localTemplateDir = dirManager.localTemplateDir()
    let templateDir = localTemplateDir ?? dirManager.globalTemplateDir()
    let moduleDir = try moduleParentDirectory.add(moduleName)
    try createModuleComponent(from: templateDir.url, to: moduleDir.url, withParams: params)
    
    printer.print(message: .moduleCreated(moduleName: moduleName, isTemplateLocal: localTemplateDir != nil))
    
    printer.print(message: .footer)
}

do {
    try main()
} catch {
    print(error.localizedDescription)
    exit(-1)
}
