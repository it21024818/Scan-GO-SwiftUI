# Project Name - Scan&Go 2.0
# Student Id - IT21024818
# Student Name - Dissanayake D.M.D.B

#### 01. Brief Description of Project - Scan&Go is a self-checkout mobile application designed for supermarket users. It allows customers to scan product barcodes, add them to a virtual cart, and pay for their purchases directly on their phones, eliminating the need to wait in traditional checkout lines.
#### 02. Users of the System - Supermarket Customers: The primary users are shoppers who want a faster and more convenient checkout experience.
#### 03. What is unique about your solution - Focus on a clean and user-friendly interface for a smooth shopping experience.
#### 04. Briefly document the functionality of the screens you have (Include screen shots of images)

Screen 1: Login/ Registration/ Forgot Password

![WhatsApp Image 2024-06-12 at 3 55 06 PM](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/cfa65567-e79b-4382-98ca-606b79604315)
![WhatsApp Image 2024-06-12 at 3 55 08 PM (1)](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/65b926fe-4d4b-4b35-bd25-278e9d269dfc)
![WhatsApp Image 2024-06-12 at 3 55 08 PM](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/b7fc97d1-e55b-4366-9595-2b60c9a50d48)

Functionality: Users can either login with existing credentials or create a new account. In addition, keychain access is integrated so that users credentials can be saved in the keychain and access the applicatoin using biometrics.
UI Components: Text fields for username/password or email/password, buttons for login and registration.

Screen 2: Home Page

![WhatsApp Image 2024-06-12 at 3 55 09 PM](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/7bfab357-45a6-4b53-a3d7-3330ab8042bc)

Functionality: Displays the locations of the supermarkets that supports Scan&Go system and their details.
UI Components: MapKit to dispkay the locations, button to view the details of the locations.

Screen 3: Barcode Scanner

![WhatsApp Image 2024-06-12 at 4 02 12 PM](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/d25a9132-1108-46a7-89bd-def1b0ac76f3)

Functionality: Users scan product barcodes as well as texts using the phone's camera. The app retrieves product information and adds it to the cart upon confirmation.
UI Components: Camera viewfinder, confirmation button to add scanned item.

Screen 4: Cart

![WhatsApp Image 2024-06-12 at 3 55 10 PM (1)](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/35ac8bf6-da20-4ed8-a922-8027e7246d34)

Functionality: Users can review scanned items, adjust quantities, and proceed to checkout.
UI Components: List of scanned items with names, prices, quantities (if applicable), edit/remove buttons, total amount.

Screen 6: Profile

![WhatsApp Image 2024-06-12 at 3 55 10 PM (2)](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/93e4a101-8a0e-408b-9dff-bbfefd772317)

Functionality: Users can view their profile details, past orders, and manage account settings.
UI Components: User information (name, email), order history, settings options.

Screen 7: Grocery List

![WhatsApp Image 2024-06-12 at 3 55 09 PM (1)](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/3b5a8891-5931-4a17-a0cc-f5b7737f739f)
![WhatsApp Image 2024-06-12 at 3 55 10 PM](https://github.com/SE4020/assignment-02-part-a-main-app-it21024818/assets/87381428/4db0d98e-0877-4feb-ab0a-3e24febcb28a)

Functionality: Users can manage their own grocery lists (shopping lists) category wise.
UI Components: Lists, Picker, TextFields, etc.

#### 05. Give examples of best practices used when writing code
Error Handling: Implement proper error handling mechanisms to gracefully handle unexpected situations during scanning, payment processing, etc.
```
// Validator class for validating user input
class Validator {
    
    // Validate email format
    static func isValidEmail(for email: String) -> Bool {
        let email = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.{1}[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    // Validate username format
    static func isValidUsername(for username: String) -> Bool {
        let username = username.trimmingCharacters(in: .whitespacesAndNewlines)
        let usernameRegEx = "\\w{4,24}"
        let usernamePred = NSPredicate(format: "SELF MATCHES %@", usernameRegEx)
        return usernamePred.evaluate(with: username)
    }
    
    // Validate password format
    static func isPasswordValid(for password: String) -> Bool {
        let password = password.trimmingCharacters(in: .whitespacesAndNewlines)
        let passwordRegEx = "^(?=.*[a-z])(?=.*[A-Z])(?=.*[0-9])(?=.*[$@$#!%*?&]).{6,32}$"
        let passwordPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        return passwordPred.evaluate(with: password)
    }
}
```

Descriptive Naming Conventions: Use clear and concise variable and function names that reflect their purpose (e.g., scannedProducts, calculateTotal).
```
    private var bottomContainerView: some View {
        VStack {
            headerView
            ScrollView {
                LazyVStack(alignment: .leading, spacing: 16) {
                    ForEach(vm.recognizedItems) { item in
                        switch item {
                        case .barcode(let barcode):
                            Text(barcode.payloadStringValue ?? "Unknown barcode")
                            
                        case .text(let text):
                            Text(text.transcript)
                            
                        @unknown default:
                            Text("Unknown")
                        }
                    }
                }
                .padding()
            }
        }
    }
```

Modular Code: Break down the code into well-defined functions and classes for better organization and maintainability.
```
struct Location: Identifiable {
    let id = UUID()
    let name: String
    let address: String
    let city: String
    let contactNo: String
    let openingHours: String
    let coordinate: CLLocationCoordinate2D
    let imageName: String 
}

```

Code Comments: Add comments to explain complex logic and improve code readability for future reference.
```
    // Function to handle user registration
    func register() {
        // Validate user input
        if user.isValid() {
            // Create user with Firebase Authentication
            Auth.auth().createUser(withEmail: user.email, password: user.password) { authResult, error in
                if let error = error {
                    user.errorMessage = error.localizedDescription
                } else {
                    if let firebaseUser = authResult?.user {
                        // Update user profile with full name
                        let changeRequest = firebaseUser.createProfileChangeRequest()
                        changeRequest.displayName = user.fullName
                        changeRequest.commitChanges { error in
                            if let error = error {
                                user.errorMessage = error.localizedDescription
                            } else {
                                // Set registration status to true
                                isRegistered = true
                            }
                        }
                    }
                }
            }
        }
    }
```

#### 06. UI Components used

~ Button: Buttons for login, registration, adding items, checkout, etc.
~ TextField: Text fields for username, password, email, etc.
~ Text: To display labels.
~ Image: To display promotional images on the home screen.
~ VStack: To display a list of scanned items in the cart screen.
~ NavigationView: Manages navigation between different screens within the app.
~ Map: To display locations in a map view.

#### 07. Testing carried out

Unit Testing: Focus on testing core functionalities for total calculations. 
```
    func testTotalPriceCalculation() {
        // Given
        let cartItems: [CartItem] = [
            CartItem(image: Image("butter"), name: "Anchor Butter", price: 400.00, description: "This is item 1", quantity: 1),
            CartItem(image: Image("juice"), name: "Orange Juice", price: 290.00, description: "This is item 2", quantity: 2),
        ]
        let cartView = CartView(cartItems: cartItems)
        
        // When
        let totalPrice = cartView.totalPrice()
        
        // Then
        XCTAssertEqual(totalPrice, "LKR 980.00")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
```

UI Testing: Automate tests to validate user interface elements like button clicks, field validation, error messages, and overall checkout flow. 
```
    func testLoginSuccess() throws {
        // Navigate to the Login screen if not already there
        XCTAssertTrue(app.navigationBars["Login"].exists)

        // Fill in email and password fields
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("test@example.com")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("testpassword")

        // Tap on the sign in button
        let signInButton = app.buttons["Sign in"]
        XCTAssertTrue(signInButton.exists)
        signInButton.tap()

        // Assert that the next screen is loaded after successful login
        XCTAssertTrue(app.navigationBars["NextScreen"].exists) // Replace "NextScreen" with the identifier of the next screen
    }

    func testLoginFailure() throws {
        // Navigate to the Login screen if not already there
        XCTAssertTrue(app.navigationBars["Login"].exists)

        // Fill in incorrect email and password fields
        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("invalid@example.com")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("invalidpassword")

        // Tap on the sign in button
        let signInButton = app.buttons["Sign in"]
        XCTAssertTrue(signInButton.exists)
        signInButton.tap()

        // Assert that appropriate error message is displayed
        XCTAssertTrue(app.staticTexts["Invalid email or password."].exists)
    }
    
    func testRegistrationSuccess() throws {
        // Navigate to the Register screen if not already there
        XCTAssertTrue(app.navigationBars["Sign up"].exists)

        // Fill in registration fields
        let fullNameTextField = app.textFields["Full Name"]
        XCTAssertTrue(fullNameTextField.exists)
        fullNameTextField.tap()
        fullNameTextField.typeText("John Doe")

        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("test@example.com")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("testpassword")

        // Tap on the sign up button
        let signUpButton = app.buttons["Sign up"]
        XCTAssertTrue(signUpButton.exists)
        signUpButton.tap()

        // Assert that the success message is displayed after successful registration
        XCTAssertTrue(app.staticTexts["Registration successful! Please log in."].exists)
    }

    func testRegistrationFailure() throws {
        // Navigate to the Register screen if not already there
        XCTAssertTrue(app.navigationBars["Sign up"].exists)

        // Fill in registration fields with invalid data
        let fullNameTextField = app.textFields["Full Name"]
        XCTAssertTrue(fullNameTextField.exists)
        fullNameTextField.tap()
        fullNameTextField.typeText("")

        let emailTextField = app.textFields["Email"]
        XCTAssertTrue(emailTextField.exists)
        emailTextField.tap()
        emailTextField.typeText("invalidemail")

        let passwordTextField = app.secureTextFields["Password"]
        XCTAssertTrue(passwordTextField.exists)
        passwordTextField.tap()
        passwordTextField.typeText("short")

        // Tap on the sign up button
        let signUpButton = app.buttons["Sign up"]
        XCTAssertTrue(signUpButton.exists)
        signUpButton.tap()

        // Assert that appropriate error message is displayed
        XCTAssertTrue(app.staticTexts["Invalid email or password."].exists)
    }


    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
```

#### 08. Documentation 

(a) Design Choices

Rationale for UI Design:
~Focused on a minimalistic and intuitive interface for ease of use.
~Placed core functionalities (scanning, cart access) prominently for quick navigation.
~Used clear and consistent icons for buttons and menus.

MVC Architecture: 
~The app utilizes Model-View-Controller (MVC) architecture for separation of concerns. This promotes cleaner code, easier maintenance, and improved testability.
~The Model layer handles data management, product information retrieval, and cart calculations.
~The View layer manages the user interface elements and displays information based on the Model.
~The Controller layer handles user interactions, processes user input, and updates the Model accordingly.

(b) Implementation Decisions

Firebase for Authentication:
~Firebase offers a user-friendly and scalable solution for user login and registration.
~Considered alternatives like custom backend development but Firebase simplified the process.

VisionKit for Barcode Scanner:
~Integrated a pre-built barcode scanning library to save development time and ensure accuracy.
~Evaluated building a custom scanner but the library offered faster implementation.

MapKit for Map View:
~Integrated the MapKit to display the locations of the stores.

(c) Challenges

Balancing Features and Development Time:
~Aimed to include core functionalities within the project timeframe.
~Prioritized features essential for the core self-checkout experience.

Data Security and User Privacy:
~Emphasized secure data storage for user information and purchase history (if applicable).
~Implemented best practices for handling sensitive data according to privacy regulations.

#### 09. Reflection

~Implement additional features like loyalty program integration.
~Enhance the user interface with animations and micro-interactions for a more polished experience.
~Explore integrating with the supermarket's backend systems for real-time product information and inventory updates.

  

