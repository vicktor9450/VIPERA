import Foundation
import Dir

let version = "1.0.2"

if CommandLine.arguments.contains("--version") {
    print("VIPERA code generator - v\(version)")
    exit(0)
}

guard CommandLine.arguments.count > 1 else {
    print("You have to to provide a module name as the first argument.")
    exit(-1)
}

let moduleName = CommandLine.arguments[1].capitalizedFirstLetter()
let scriptName = URL(fileURLWithPath: CommandLine.arguments.first!).lastPathComponent
var templateName = "default"
if CommandLine.arguments.count > 2 {
    templateName = CommandLine.arguments[2]
}

let currentDir = Dir.current
let homeDir = Dir()
let workDir = homeDir.child(scriptName, isHidden: true)
let templatesDir = workDir.child("Templates")
let templateDir = templatesDir.child(templateName)

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
    let moduleDir = try currentDir.add(moduleName)
    try createModuleComponent(from: templateDir.url, to: moduleDir.url)
    print("🐍 VIPER module `\(moduleName)` is ready to use. (based on the `\(templateName)` template)")
}
catch {
    print(error.localizedDescription)
}


if templateName == "default" || templateName == "generic" {
    print("\n⚠️  In order to use the module you'll need the following library:\n\n\thttps://github.com/corekit/viper\n")
}
