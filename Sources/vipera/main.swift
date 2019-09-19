import Foundation
import Dir

let version = "2.0.0"

if CommandLine.arguments.contains("--version") {
    print("""
    🐍 VIPERA code generator

        Version: \(version)

        Global template dir: `~/.vipera`

        VIPER interfaces: `https://github.com/corekit/viper`

            .package(url: \"https://github.com/CoreKit/VIPER\", from: \"3.0.0\"


        💡 VIPERA will always use the local `.vipera` folder as a template source.

    """)
    exit(0)
}

guard CommandLine.arguments.count > 1 else {
    print("You have to to provide a module name as the first argument.")
    exit(-1)
}

let moduleName = CommandLine.arguments[1].capitalizedFirstLetter()
let scriptName = URL(fileURLWithPath: CommandLine.arguments.first!).lastPathComponent

let currentDir = Dir.current
let homeDir = Dir()
let workDir = homeDir.child(scriptName, isHidden: true)
var templateDir = workDir

let localTemplateDir = currentDir.child(scriptName, isHidden: true)
if localTemplateDir.isExistingDirectory {
    templateDir = localTemplateDir
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
    let moduleDir = try currentDir.add(moduleName)
    try createModuleComponent(from: templateDir.url, to: moduleDir.url)

    print("🐍 VIPER module `\(moduleName)` is ready to use, based on the `\(localTemplateDir.isExistingDirectory ? "local" : "global")` template.")
}
catch {
    print(error.localizedDescription)
}


print("""

    💡 In order to use the module you'll need the following library:

        https://github.com/corekit/viper

        .package(url: "https://github.com/CoreKit/VIPER", from: "3.0.0")

    🍺 Enjoy!

""")

