//
//  DonateView.swift
//  Sobretium
//
//  Created by Tarball on 10/7/22.
//

// most of this is ripped from Apple's demo, i can't be bothered

import StoreKit
import SwiftUI

typealias Transaction = StoreKit.Transaction

public enum StoreError: Error {
    case failedVerification
}

struct DonateView: View {
    @State var products: [Product] = []
    var body: some View {
        VStack {
            Image(systemName: "giftcard")
                .resizable()
                .scaledToFit()
                .frame(width: 125, height: 125)
                .foregroundColor(.red)
            Spacer()
                .frame(maxWidth: 100, maxHeight: 100)
            Group {
                Text("This app is completely free of charge, and will stay that way forever.")
                    .font(.title2)
                Text("")
                Text("However, if you'd like to show your support for the developer, you may do so here.")
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 5)
            Spacer()
                .frame(maxWidth: 100, maxHeight: 100)
            HStack {
                ForEach(products) { product in
                    Button {
                        Task.init(priority: .background) {
                            do {
                                _ = try await purchase(product)
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        Text(product.displayPrice)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color.accentColor)
                            .foregroundColor(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .font(.headline)
                    }
                    .padding(.horizontal, 2)
                }
            }
            .onAppear(perform: fetchProducts)
        }
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Donate")
                    .fixedSize(horizontal: true, vertical: false)
                    .font(.headline)
            }
        }
    }
    func fetchProducts() {
        Task.init(priority: .background) {
            do {
                products = try await Product.products(for: ["com.alyxferrari.Sobretium.donation1", "com.alyxferrari.Sobretium.donation5", "com.alyxferrari.Sobretium.donation10"])
                products = products.sorted(by: { $0.price < $1.price })
            } catch {
                print(error)
            }
        }
    }
    func purchase(_ product: Product) async throws -> Transaction? {
        let result = try await product.purchase()
        switch result {
        case .success(let verification):
            let transaction = try DonateView.checkVerified(verification)
            await transaction.finish()
            return transaction
        default:
            return nil
        }
    }
    static func checkVerified<T>(_ result: VerificationResult<T>) throws -> T {
        switch result {
        case .unverified:
            throw StoreError.failedVerification
        case .verified(let safe):
            return safe
        }
    }
}
