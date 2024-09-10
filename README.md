E-Commerce Flutter Application
This is a feature-rich e-commerce application built with Flutter. The application provides an intuitive user interface with a seamless shopping experience, AI animations, and a dynamic cart and checkout system. It includes user authentication (signup and login), product browsing, scratch card rewards for new users, and Lottie AI animations to enhance the user experience.

Screens Overview
1. Authentication (Login/SignUp)
Features login and signup options with simple validation.
If a new user signs up, they are rewarded with a scratch card that reveals a product available for Rs. 0.
2. Scratch Card
A scratch card is revealed after successful signup. The user scratches the card to reveal a random product, which is added to the cart for free.
AI animation enhances the visual appeal after the scratch card is revealed.
3. Home Screen
Product listings with a search bar.
Users can view available products, search for specific items, and see the percentage-off labels.
4. Product Detail Screen
Provides detailed information about a product.
Users can either add the product to their cart or buy it immediately.
5. Cart Screen
Displays all items added to the cart along with their quantities and total price.
Users can increment or remove items from the cart.
6. Checkout Screen
Provides a summary of the order.
Generates a downloadable or shareable PDF receipt of the transaction with all relevant details.

App Architecture
This application follows a structured architecture to ensure modularity and scalability. Below are the key components:

1. UI Layer
Screens: Contains individual pages like AuthScreen, ScratchCardScreen, HomeScreen, ProductDetailScreen, CartScreen, and CheckoutScreen.
Widgets: Modular widgets like ProductItem, CartItem, and custom buttons.
Animations: Integration of Lottie animations for AI effects, such as a sparkles animation on successful reward revelation.
2. State Management
Provider: ChangeNotifierProvider is used for managing the state of the cart (CartProvider) throughout the app, ensuring that the cart details and product listings are updated dynamically.
3. Backend Integration
Firebase: Integrated with Firebase for user authentication.
Local Storage: Optionally uses SharedPreferences for caching certain user preferences.
4. Features
Scratch Card Reward System: A new user signing up is presented with a scratch card. The scratch card reveals a product that the user can add to their cart for Rs. 0.
Product Listing & Details: Displays a dynamic list of products. Clicking on a product reveals its details with options to add to the cart or buy immediately.
Cart Management: Users can add or remove items, adjust item counts, and view total prices in the cart.
Checkout & PDF Generation: At checkout, a PDF is generated with the order details, including the product names, quantities, total price, transaction ID, and purchase date. Users can download or share the PDF.
5. AI Animation
Lottie Integration: The application incorporates Lottie animations to create visually appealing AI animations. After revealing a scratch card product, an AI-powered sparkle animation is triggered to enhance user engagement. This adds a fun and interactive touch, making the application more engaging.


