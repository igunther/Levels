import SwiftUI

struct ContentView: View {
    @ObservedObject var stockTakeViewModel = StockTakeViewModel()
    
    var body: some View {
        NavigationStack {
            StockTakesView(stockTakes: $stockTakeViewModel.stockTakes)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

// MARK: - Views

/// View 1
struct StockTakesView: View {
    @Binding var stockTakes: [StockTake]
    var body: some View {
        VStack {
            Text("StockTakesView: View 1")
                .font(.title2)
            
            LazyVStack {
                ForEach($stockTakes) { $stockTake in
                    NavigationLink {
                        StockTakeView(stockTake: $stockTake)
                    } label: {
                        Text("\(stockTake.name) - Counted: \(stockTake.counted) ")
                    }
                }
            }
        }
    }
}

/// View 2
struct StockTakeView: View {
    @Binding var stockTake: StockTake
    var body: some View {
        VStack {
            Text("StockTakeView: View 2")
                .font(.title)
         
            Text("\(stockTake.name) - Counted: \(stockTake.counted) ")
            
            LazyVStack {
                ForEach($stockTake.stockCounts) { $stockCount in
                    NavigationLink {
                        StockCountsView(stockCount: $stockCount)
                    } label: {
                        Text(stockCount.employee)
                    }
                }
            }
        }
    }
}

/// View 3
struct StockCountsView: View {
    @Binding var stockCount: StockCount
    @State private var productNumber: Int = 0
    var body: some View {
        VStack {
            Text("StockCountsView: View 3")
                .font(.title)
            
            Text("Counted: \(stockCount.counted)")
            
            Button {
                productNumber += 1
                let stockProduct = StockProduct(productName: "New Product \(productNumber)", counted: 1)
                stockCount.stockProducts.append(stockProduct)
                
            } label: {
                Text("Add product")
            }
            
            LazyVStack {
                ForEach(stockCount.stockProducts) { stockProduct in
                    Text(stockProduct.productName)
                }
            }
        }
    }
}
