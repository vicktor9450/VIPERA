import Foundation
@testable import ViperaModules

class PrinterMock: PrinterInterface {
    private(set) var printMessageCalls: [Printer.MessageType] = []
    func print(message: Printer.MessageType) {
        self.printMessageCalls.append(message)
    }
    
    private(set) var printErrorCalls: [Error] = []
    func print(_ error: Error) {
        self.printErrorCalls.append(error)
    }
}
