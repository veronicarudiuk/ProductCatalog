# 🛒 Product Catalog App

This project is a SwiftUI-based iOS application designed to showcase products in a grid layout, featuring an intuitive user interface that supports dark and light themes as well as dynamic text resizing for accessibility. The app fetches product data from a network API, caches images efficiently, and provides a detailed product view with smooth animations and custom design elements.

___

### Features

	•	Product Grid View: Displays products in a responsive grid layout with pagination support.
	•	Product Details Overlay: Tap on a product to view detailed information in an overlay, with images, price, and stock level.
	•	Dynamic Theme Support: The app automatically adapts to both dark and light themes, ensuring a consistent experience across different settings.
	•	Accessibility Ready: Supports dynamic text resizing for improved accessibility, adapting UI elements to the user’s preferred text size.
	•	Pull-to-Refresh: Allows users to refresh the product list with a pull-down gesture.
	•	Lazy Loading: Products load on-demand as the user scrolls, reducing memory usage and improving performance.
	•	Custom Caching: Images are cached locally to reduce network usage and improve loading times.
	•	Error Handling with Alerts: Provides user-friendly error messages when network issues occur, with retry options.
	•	Animated Loading Indicators: Includes a custom loading animation to enhance the user experience.

___

### Technical Highlights

	•	SwiftUI: The app is built entirely in SwiftUI, using Combine for reactive programming.
	•	Dependency Injection: Uses a DependencyContainer to manage dependencies, improving testability and modularity.
	•	Custom Image Loader: Efficient image loading with caching, resizing, and fallback handling.
	•	Network Layer: Abstracted API client with error handling and response validation, designed to handle various network scenarios (e.g., offline mode).
	•	Modular Components: Key components like ProductDetailView, LoadingView, and ScrollTrackingView are modular and reusable.

![light mode](https://github.com/user-attachments/assets/9fc3c449-02f8-48e4-a4b7-7e26a99b0515)

![dark mode](https://github.com/user-attachments/assets/bcf69f28-e0f2-48c5-aed5-74dabf5fae54)


___

### Getting Started

	1.	Clone the Repository:

git clone https://github.com/yourusername/product-catalog-app.git

	2.	Open the Project:
Open ProductCatalogApp.xcodeproj in Xcode.

	3.	Run the App:
Select a target device (iPhone or simulator) and press Run.

___

### Project Structure

	•	Views: SwiftUI views for product list, product detail, custom loading indicators, and more.
	•	ViewModels: Manages data and business logic for each view, including API calls and caching.
	•	Network: Contains network-related classes like APIClient and DummyjsonAPI, handling data requests and response parsing.
	•	Helpers & Extensions: Reusable code such as custom view modifiers, data extensions, and utility functions.

___

### Key Files

	•	HomeView.swift: Main view displaying the grid of products.
	•	ProductDetailView.swift: Overlay view with product details and image carousel.
	•	DependencyContainer.swift: Centralized dependency manager.
	•	ImageLoader.swift: Asynchronous image loading with caching and resizing.
	•	CustomProgressView.swift: Animated loading indicator.
	•	AppRouter.swift: Handles navigation and view selection based on app state.

___

### Customization

The app is easily customizable, including:

	•	Color Scheme: Modify the color scheme to match your brand.
	•	Animations: Customize animations for loading, error handling, and product display.
	•	API Integration: Update the network layer to support different APIs or endpoints as needed.

___

### Requirements

	•	iOS 16.0+
	•	Xcode 14+

Feel free to edit the sections as needed or add specific details related to your project setup and usage.
