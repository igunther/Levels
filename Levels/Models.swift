import Foundation

class StockTakeViewModel: ObservableObject {
    @Published var stockTakes = [StockTake]()
        
    init() {
        let stockTake1 = StockTake(name: "Stocktake1",
                                   stockCounts: [.init(employee: "John Doe",
                                                       stockProducts: [.init(productName: "Initial Product1", counted: 1),
                                                                       .init(productName: "Initial Product2", counted: 1),
                                                                       .init(productName: "Initial Product3", counted: 1),
                                                                       .init(productName: "Initial Product4", counted: 1)])])
        
        self.stockTakes.append(stockTake1)
    }
}

struct StockTake: Identifiable, Hashable {
    var id = UUID()
    var name: String
        
    var counted: Int32 {
        get {
            return stockCounts.reduce(0) { $0 + $1.counted }
        }
    }
    
    var stockCounts = [StockCount]()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct StockCount: Identifiable, Hashable {
    var id = UUID()
    var employee: String
    
    var counted: Int32 {
        get {
            return stockProducts.reduce(0) { $0 + $1.counted }
        }
    }
    
    var stockProducts = [StockProduct]()
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

struct StockProduct: Identifiable, Hashable {
    var id = UUID()
    var productName: String
    var counted: Int32 = 0
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

