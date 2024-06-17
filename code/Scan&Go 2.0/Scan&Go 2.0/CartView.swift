//
//  CartView.swift
//  Scan&Go 2.0
//
//  Created by Dinuka Dissanayake on 5/20/24.
//

import SwiftUI

// View for displaying the cart
struct CartView: View {
    @State private var cartItems: [CartItem] = [
        CartItem(image: Image("butter"), name: "Anchor Butter", price: 400.00, description: "This is item 1", quantity: 1),
        CartItem(image: Image("juice"), name: "Orange Juice", price: 290.00, description: "This is item 2", quantity: 2),
    ]
    
    var body: some View {
        VStack {
            // List of cart items
            List {
                ForEach(cartItems.indices, id: \.self) { index in
                    CartItemRow(item: $cartItems[index])
                }
                .onDelete(perform: deleteCartItem)
            }
            
            Spacer()
            
            // Total price of items in the cart
            Text("Total: \(totalPrice())")
            
            // Checkout button
            Button(action: checkout) {
                Text("Checkout")
                    .padding()
                    .frame(width: 200)
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            Spacer()
        }
    }
    
    // Delete a cart item at the specified offsets
    func deleteCartItem(at offsets: IndexSet) {
        cartItems.remove(atOffsets: offsets)
    }
    
    // Calculate the total price of items in the cart
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
    @Binding var item: CartItem
    
    var body: some View {
        HStack {
            // Display item image
            item.image
                .resizable()
                .frame(width: 80, height: 80)
            VStack(alignment: .leading) {
                // Display item details
                Text(item.name)
                Text(item.description)
                Text("Price: LKR \(String(format: "%.2f", item.price))")
                // Stepper for adjusting item quantity
                Stepper(value: $item.quantity, in: 1...10) {
                    Text("Quantity: \(item.quantity)")
                }
            }
        }
    }
}

// Preview for CartView
struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        CartView()
    }
}
