
extension Array {
    subscript(safeIndex index: Index) -> Element? {
        return (startIndex..<endIndex).contains(index) ? self[index] : nil
    }
}
