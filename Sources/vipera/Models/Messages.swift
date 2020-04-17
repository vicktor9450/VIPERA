
struct Messages {
    
    static let footer: String = """

        💡 In order to use the module you'll need the following library:

            https://github.com/corekit/viper

            .package(url: "https://github.com/CoreKit/VIPER", from: "3.0.0")

        🍺 Enjoy!

    """
    
    static let help: String = """
    🐍 VIPERA code generator

        Usage:
            vipera [module name]

        Available options:
            --version   |  Prints version of the script
            --help, -h  |  Prints help for the script
        
        Global template dir: `~/.vipera`
    
        VIPER interfaces: `https://github.com/corekit/viper`
    
            .package(url: \"https://github.com/CoreKit/VIPER\", from: \"3.0.0\"
    
    
        💡 VIPERA will always use the local `.vipera` folder as a template source.

    """
    
    static let moduleCreated: String = "🐍 VIPER module `%@` is ready to use, based on the `%@` template."
    
    static let version: String = """
    🐍 VIPERA code generator
    
    You are using version \(Constants.version)
    
    """
}
