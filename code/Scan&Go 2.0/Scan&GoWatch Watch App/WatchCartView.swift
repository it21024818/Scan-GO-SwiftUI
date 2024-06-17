//
//  WatchCartView.swift
//  Scan&GoWatch Watch App
//
//  Created by Dinuka Dissanayake on 6/12/24.
//

import SwiftUI

struct WatchCartView: View {
    @State private var cartItems: [CartItem] = [
        CartItem(image: Image("butter"), name: "Anchor Butter", price: 400.00, description: "This is item 1", quantity: 1),
        CartItem(image: Image("juice"), name: "Orange Juice", price: 290.00, description: "This is item 2", quantity: 2),
    ]

    var body: some View {
        VStack {
            // List of cart items
            List {
                ForEach(cartItems) { item in
                    CartItemRow(item: item)
                }
                .onDelete(perform: deleteCartItem)
            }

            Spacer()

            // Total price of items in the cart
            Text("Total: \(totalPrice())")

            // Checkout button (adapted to a Text view for simplicity)
            Text("Checkout")
                .padding()
                .frame(width: 200)
                .background(Color.red)
                .foregroundColor(.white)
                .cornerRadius(10)
                .onTapGesture {
                    checkout()
                }
                .padding()

            Spacer()
        }
    }

    // Delete a cart item
    func deleteCartItem(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }

    // Calculate the total price
    func totalPrice() -> String {
        let total = cartItems.reduce(0) { $0 + $1.price * Double($1.quantity) }
        return String(format: "LKR %.2f", total)
    }

    // Perform the checkout operation
    func checkout() {
        // Implement checkout operation
    }
}

// View for displaying a row of a cart item
struct CartItemRow: View {
    var item: CartItem

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                // Display item details
                Text(item.name)
                Text("Price: LKR \(String(format: "%.2f", item.price))")
                // Adjusted Stepper for adjusting item quantity
                Stepper(value: .constant(Double(item.quantity)), in: 1...10) {
                    Text("Quantity: \(item.quantity)")
                        .font(.body) // Adjust font size if necessary
                }
                .scaleEffect(0.8) // Scale down the size of the Stepper
            }
        }
        .padding()
    }
}

#Preview {
    WatchCartView()
}
