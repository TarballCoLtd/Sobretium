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
    @State var thankYouDict: [String: Bool] = [:]
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
                Text("However, if you'd like to support development of the app, you may do so here.")
            }
            .multilineTextAlignment(.center)
            .padding(.horizontal, 5)
            Spacer()
                .frame(maxWidth: 100, maxHeight: 100)
            if products.count == 0 {
                HStack {
                    ProgressView()
                        .progressViewStyle(CircularProgressViewStyle())
                        .padding(.horizontal, 2)
                    Text("Loading...")
                        .foregroundColor(.gray)
                }
                .padding(.vertical)
            }
            HStack {
                ForEach(products) { product in
                    Button {
                        Task.init(priority: .background) {
                            do {
                                let fart = try await purchase(product)
                                if fart != nil { thankYouDict[product.id] = true }
                            } catch {
                                print(error)
                            }
                        }
                    } label: {
                        if thankYouDict[product.id] == nil {
                            Text(product.displayPrice)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .font(.headline)
                        } else {
                            Text("Thank you! ❤️")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.green)
                                .foregroundColor(.white)
                                .clipShape(RoundedRectangle(cornerRadius: 20))
                                .font(.headline)
                        }
                    }
                    .padding(.horizontal, 1)
                }
            }
            .padding(.horizontal, 5)
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
        Task.init(priority: .high) {
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
