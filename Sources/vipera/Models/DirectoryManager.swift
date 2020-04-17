import Foundation
import Dir
import ViperaModules

class DirectoryManager {
    
    func currentDir() -> Dir {
        Dir.current
    }
    
    func homeDir() -> Dir {
        Dir()
    }
    
    func globalTemplateDir() -> Dir {
        self.homeDir().child(Constants.scriptName, isHidden: true)
    }
    
    func localTemplateDir() -> Dir? {
        let dir = self.currentDir().child(Constants.scriptName, isHidden: true)
        guard dir.exists else { return nil }
        return dir
    }
    
    func createChildDir(path: String) throws -> Dir {
        let dir = self.currentDir().child(path)
        if !dir.exists {
            try dir.create()
        }
        return dir
    }
}
