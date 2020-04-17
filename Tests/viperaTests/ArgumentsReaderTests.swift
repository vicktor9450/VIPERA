import XCTest
@testable import ViperaModules

final class ArgumentsReaderTest: XCTestCase {
    
    static let allTests = [
        ("testPassedArguments_emptyArray_returnsEmptySet", testPassedArguments_emptyArray_returnsEmptySet)
    ]
    
    // MARK: - passedArguments(in:)
    func testPassedArguments_emptyArray_returnsEmptySet() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = []
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssert(returnedSet.isEmpty)
    }
    
    func testPassedArguments_scriptNameOnly_returnsEmptySet() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = [Constants.scriptName]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssert(returnedSet.isEmpty)
    }
    
    // MARK: Help
    func testPassedArguments_fullHelpArg_returnsHelpArg() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = ["--help"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.help])
    }
    
    func testPassedArguments_shortHelpArg_returnsHelpArg() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = ["-h"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.help])
    }
    
    func testPassedArguments_multipleHelpArgs_returnsOnlyOneHelpArg() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = ["-h", "-h", "--help"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.help])
    }
    
    // MARK: Version
    func testPassedArguments_fullVersionArg_returnsVersionArg() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = ["--version"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.version])
    }
    
    func testPassedArguments_multipleVersionArgs_returnsOnlyOneVersionArg() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = ["--version", "--version", "--version"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.version])
    }
    
    // MARK: Path
    func testPassedArguments_fullPathArg_returnsPathArg() {
        //Arrange
        let sut = ArgumentsReader()
        let path: String = "someDirectory"
        let stringArguments: [String] = ["--path", path]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.path(path)])
    }
    
    func testPassedArguments_shortPathArg_returnsPathArg() {
        //Arrange
        let sut = ArgumentsReader()
        let path: String = "someDirectory"
        let stringArguments: [String] = ["-p", path]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.path(path)])
    }
    
    func testPassedArguments_emptyPathArg_returnsNilPathArg() {
        //Arrange
        let sut = ArgumentsReader()
        let stringArguments: [String] = ["-p"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.path(nil)])
    }
    
    func testPassedArguments_multiplePathArgs_returnsFirstPathArg() {
        //Arrange
        let sut = ArgumentsReader()
        let path: String = "someDirectory"
        let stringArguments: [String] = ["-p", path, "-p", "notThisOne", "-p"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.path(path)])
    }
    
    // MARK: Module name
    func testPassedArguments_normalModuleNameArg_returnsModuleNameArg() {
        //Arrange
        let sut = ArgumentsReader()
        let moduleName: String = "MyModule"
        let stringArguments: [String] = [moduleName]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.moduleName(moduleName)])
    }
    
    func testPassedArguments_dashBeforeModuleNameArg_returnsUnknownArg() {
        //Arrange
        let sut = ArgumentsReader()
        let moduleName: String = "-MyModule"
        let stringArguments: [String] = [moduleName]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.unknown(moduleName)])
    }
    
    func testPassedArguments_dashInModuleNameArg_returnsModuleNameArg() {
        //Arrange
        let sut = ArgumentsReader()
        let moduleName: String = "My-Module"
        let stringArguments: [String] = [moduleName]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.moduleName(moduleName)])
    }
    
    func testPassedArguments_ModuleNameArgWithUnknownOption_returnsModuleNameArg() {
        //Arrange
        let sut = ArgumentsReader()
        let unknownOption: String = "-unknown-option"
        let moduleName: String = "MyModule"
        let stringArguments: [String] = [unknownOption, moduleName]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.moduleName(moduleName), .unknown(unknownOption)])
    }
    
    // MARK: Mixed args
    func testPassedArguments_allArgs_returnsProperArgs() {
        //Arrange
        let sut = ArgumentsReader()
        let moduleName: String = "MyModule"
        let path: String = "someDirectory"
        let stringArguments: [String] = [moduleName, "--path", path, "--version", "--help"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.moduleName(moduleName), .path(path), .version, .help])
    }
    
    func testPassedArguments_moduleNameAndPath_returnsProperArgs() {
        //Arrange
        let sut = ArgumentsReader()
        let moduleName: String = "MyModule"
        let path: String = "someDirectory"
        let stringArguments: [String] = [moduleName, "-p", path]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.moduleName(moduleName), .path(path)])
    }
    
    func testPassedArguments_pathAndModuleName_returnsProperArgs() {
        //Arrange
        let sut = ArgumentsReader()
        let moduleName: String = "MyModule"
        let path: String = "someDirectory"
        let stringArguments: [String] = ["-p", path, moduleName]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.moduleName(moduleName), .path(path)])
    }
    
    func testPassedArguments_allArgsMultipleTimes_returnsProperArgs() {
        //Arrange
        let sut = ArgumentsReader()
        let moduleName: String = "MyModule"
        let path: String = "someDirectory"
        let stringArguments: [String] = [
            moduleName,
            "--path", path,
            "anotherModule",
            "--path", "nothingHere",
            "--version",
            "--help",
            "--version",
            "--help"]
        //Act
        let returnedSet = sut.passedArguments(in: stringArguments)
        //Assert
        XCTAssertEqual(returnedSet, [.moduleName(moduleName), .path(path), .version, .help, .unknown("anotherModule")])
    }
}
