import XCTest
@testable import ViperaModules

final class ArgumentsResolverTests: XCTestCase {
    private var printerMock: PrinterMock!
    
    override func setUp() {
        super.setUp()
        self.printerMock = PrinterMock()
    }
    
    // MARK: - resolve(args:)
    func testResolveArguments_emptyArgs() {
        //Arrange
        let sut = self.buildSUT()
        //Act
        let result = sut.resolve(args: [])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .help)
        XCTAssertEqual(result, .failure(ExitError(code: 0)))
    }
    
    func testResolveArguments_version() {
        //Arrange
        let sut = self.buildSUT()
        //Act
        let result = sut.resolve(args: [.version])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .version)
        XCTAssertEqual(result, .failure(ExitError(code: 0)))
    }
    
    func testResolveArguments_help() {
        //Arrange
        let sut = self.buildSUT()
        //Act
        let result = sut.resolve(args: [.help])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .help)
        XCTAssertEqual(result, .failure(ExitError(code: 0)))
    }
    
    func testResolveArguments_moduleName_returnsModuleName() {
        //Arrange
        let sut = self.buildSUT()
        let moduleName: String = "MyModule"
        //Act
        let result = sut.resolve(args: [.moduleName(moduleName)])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 0)
        XCTAssertEqual(result, .success(ArgumentsResolver.Parameters(moduleParentDirRelativePath: nil, moduleName: moduleName)))
    }
    
    func testResolveArguments_fullPathAndModuleName_returnsParameters() {
        //Arrange
        let sut = self.buildSUT()
        let path: String = "directory"
        let moduleName: String = "MyModule"
        //Act
        let result = sut.resolve(args: [.moduleName(moduleName), .path(path)])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 0)
        XCTAssertEqual(result, .success(ArgumentsResolver.Parameters(moduleParentDirRelativePath: path, moduleName: moduleName)))
    }
    
    func testResolveArguments_fullPath() {
        //Arrange
        let sut = self.buildSUT()
        let path: String = "directory"
        //Act
        let result = sut.resolve(args: [.path(path)])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .moduleNameNotFound)
        XCTAssertEqual(result, .failure(ExitError(code: -1)))
    }
    
    func testResolveArguments_missingPathSecondComponent() {
        //Arrange
        let sut = self.buildSUT()
        //Act
        let result = sut.resolve(args: [.path(nil)])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .invalidUsageOfPath)
        XCTAssertEqual(result, .failure(ExitError(code: -1)))
    }
    
    func testResolveArguments_unknownArgument() {
        //Arrange
        let sut = self.buildSUT()
        let arg: String = "-unknown-option"
        //Act
        let result = sut.resolve(args: [.unknown(arg), .moduleName("some")])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .unknownArgument(arg))
        XCTAssertEqual(result, .success(ArgumentsResolver.Parameters(moduleParentDirRelativePath: nil, moduleName: "some")))
    }
    
    // MARK: Mixed
    func testResolveArguments_helpAndVersion() {
        //Arrange
        let sut = self.buildSUT()
        //Act
        let result = sut.resolve(args: [.help, .version])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .help)
        XCTAssertEqual(result, .failure(ExitError(code: 0)))
    }
    
    func testResolveArguments_moduleNameAndVersion() {
        //Arrange
        let sut = self.buildSUT()
        //Act
        let result = sut.resolve(args: [.moduleName("Some"), .version])
        //Assert
        XCTAssertEqual(self.printerMock.printMessageCalls.count, 1)
        XCTAssertEqual(self.printerMock.printMessageCalls.last, .version)
        XCTAssertEqual(result, .failure(ExitError(code: 0)))
    }
}

// MARK: - Private
extension ArgumentsResolverTests {
    private func buildSUT() -> ArgumentsResolver {
        return ArgumentsResolver(printer: self.printerMock)
    }
}
