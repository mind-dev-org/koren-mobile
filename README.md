KOREN — Local Food Marketplace

KOREN is a mobile marketplace app that connects local farmers with customers, focusing on transparency, seasonal products, and eco-friendly consumption.

Built with Flutter, the app integrates with a real backend API and demonstrates a complete product flow: browsing, searching, saving favourites, and managing a cart.

🚀 Features:

- Product Catalog
Browse real products fetched from API

- Search
Filter products by name in real time

- Favourites
Save and view favourite products

🛒-Cart with Quantity
Add products, adjust quantity, calculate total price

- Dark / Light Theme
Toggle theme with full UI support

- Responsive UI
Clean layout with custom typography and reusable components

🏗 Architecture:

- Data Layer

ProductRemoteDataSource — API calls (Dio)

ProductRepositoryImpl — abstraction over data source

- Models

ProductModel

CartItemModel

- State Management

Provider

CartProvider

FavoritesProvider

ThemeProvider

🌐 API Integration:

- Uses Dio for HTTP requests

- Fetches data from /products endpoint

- Maps JSON responses into Dart models using fromJson