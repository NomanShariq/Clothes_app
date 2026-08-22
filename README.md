# MONARQ

<p align="center">
  <strong>Luxury Fashion E-Commerce App</strong>
</p>

<p align="center">
  A modern Flutter e-commerce application focused on premium fashion, clean UI, and a smooth shopping experience — now backed by a real Django REST API.
</p>

## 📱 About

MONARQ is a modern mobile e-commerce application designed for a premium fashion brand.

The app uses a dark luxury aesthetic with a deep navy/black interface, refined typography, subtle gold accents, and a clean product-focused shopping experience — with a fully theme-driven design system that adapts consistently between light and dark modes.

The project has evolved from a static frontend prototype into a full-stack application, with a Django REST Framework backend serving real product data, and Flutter consuming it over HTTP with persistent user authentication.

## ✨ Features

- 🏠 Modern fashion-focused home screen
- 🛍️ Product browsing and catalog, powered by a live Django backend
- 🔎 Product search experience
- ❤️ Wishlist
- 🛒 Shopping cart with quantity management
- 🎟️ Promo code support
- 💳 Checkout flow
- 📦 Order placement flow with an animated, branded order-confirmation experience
- 👤 Profile / account
- 📋 My Orders
- 🚚 Order status categories
- 💰 Currency formatting
- 🌙 Fully theme-driven light/dark design system (MONARQ gold accent in dark mode)
- 🔐 User authentication (Sign Up / Login) via Django REST API
- 💾 Persistent login — session survives app restarts and hot reloads
- 🎬 Custom branded loading animation (MONARQ emblem draw-in + shimmer)
- ⚠️ Animated "Invalid Credentials" error dialog for failed logins
- 🖼️ Smart image loading (local assets + network images from the backend)
- 🎨 Custom app icon and native splash screen
- 📱 Responsive mobile UI
- 🎨 Reusable themed UI components

### Order Status

- All
- Processing
- Shipped
- Delivered
- Cancelled

## 🛒 Shopping Flow

```
Home
  ↓
Product Details
  ↓
Add to Cart
  ↓
Cart
  ↓
Checkout
  ↓
Place Order
  ↓
Animated Order Confirmation
  ↓
My Orders
  ↓
Order Details
```

**Auth flow:**

```
App Launch
  ↓
Splash Screen (native, branded)
  ↓
Auth Gate — checks saved session
  ├── Session found  → Home
  └── No session      → Login
                          ├── Sign In  → (invalid → animated error dialog)
                          └── Sign Up  → Home
```

**Profile navigation:**

```
Profile
 ├── My Orders
 ├── Wishlist
 ├── Addresses
 ├── Payment Methods
 ├── Settings
 └── Logout
```

## 🎨 Design System

MONARQ follows a minimal luxury fashion design language:

- **Background:** Deep navy / near-black (`#021032` family)
- **Primary text:** White (dark mode) / Black (light mode)
- **Secondary text:** Muted gray
- **Accent:** Premium gold (`colorScheme.secondary`)
- **Components:** Rounded cards and buttons
- **Typography:** Clean and sophisticated
- **UI approach:** Minimal, spacious, product-focused

All colors are pulled from `Theme.of(context)` rather than hardcoded — every screen automatically adapts between the light and dark MONARQ palettes, including the sale filters, cart, checkout, product details, and profile screens.

## 🎬 Branded Motion

Two custom animated components give the app a distinct, recognizable identity:

- **MonarqLoader** — a reusable global loading animation. The MONARQ emblem (clock ring + hanger hook + hands) draws itself stroke-by-stroke, a gold shimmer passes across it, and it settles into a soft breathing fade — looping seamlessly. Wrapped by `MonarqLoadingSwitcher`, which only shows the loader after a short delay, avoiding flicker on fast loads.
- **Order Confirmation Sheet** — a 4-phase animated bottom sheet shown after placing an order: *Order Confirmed → Packed With Care → On The Way → Order Placed*, complete with a moving delivery truck illustration and order details.
- **Invalid Credentials Dialog** — a short, polished authentication-error animation (drawn circle, shake, subtle particles) replacing the old plain error SnackBar.

## 🛠️ Tech Stack

**Frontend**
- Flutter / Dart
- Provider for state management
- `http` for REST API communication
- `shared_preferences` for persistent login sessions
- `flutter_dotenv` for environment-based API configuration
- Material UI / custom `CustomPainter` animations
- `flutter_launcher_icons` & `flutter_native_splash` for branded app icon/splash

**Backend**
- Python / Django
- Django REST Framework
- SQLite (development database)
- Django Admin for product/catalog management

## 🧩 Project Structure

```
lib/
├── models/          # Cart, Wishlist, UserSession, data models
├── pages/            # Screens (Home, Product Detail, Checkout, Profile, Auth Gate, etc.)
├── screens/          # Cart & related full screens
├── services/          # API service layer (Django REST integration)
├── widgets/           # Reusable themed UI components & animations
├── theme/             # AppColors, AppTextStyles, AppTheme (light/dark)
└── main.dart
```

The project uses reusable widgets and theme-based styling to keep the UI consistent and maintainable, with a clean separation between UI, state, and the API layer.

## 🔐 Environment Configuration

API endpoints are configured via a local `.env` file (not committed to version control):

```
API_BASE_URL=http://YOUR_LOCAL_IP:8000/api
MEDIA_BASE_URL=http://YOUR_LOCAL_IP:8000
```

Copy `.env.example` to `.env` and set your own backend IP before running the app.

## 📸 Screenshots

### Home & Product Discovery

<p align="center">
  <img src="https://github.com/user-attachments/assets/29ed4881-a639-4e14-a2eb-e713157b8916" width="250" />
  <img src="https://github.com/user-attachments/assets/57936288-2a76-4bdb-ad7d-485a25f9f310" width="250" />
  <img src="https://github.com/user-attachments/assets/c9260a53-0323-4ad3-adca-97c94ab4866e" width="250" />
</p>

### Product, Wishlist & Shopping

<p align="center">
  <img src="https://github.com/user-attachments/assets/836801a5-e767-4348-9402-67691a24d24d" width="250" />
  <img src="https://github.com/user-attachments/assets/1f9bb31c-4194-4f08-9410-dfe280feb022" width="250" />
  <img src="https://github.com/user-attachments/assets/bd8533e5-4def-4035-b4cf-1d4fd64b3abd" width="250" />
</p>

### Cart & Checkout

<p align="center">
  <img src="https://github.com/user-attachments/assets/8bfda2a5-73dc-41f7-807a-b34b72a5f8c3" width="250" />
  <img src="https://github.com/user-attachments/assets/eb5cef4b-741d-49aa-b28a-e8edbb44a6c6" width="250" />
  <img src="https://github.com/user-attachments/assets/93d71958-7763-445a-9369-bd7a7d037533" width="250" />
</p>

### Profile & Orders

<p align="center">
  <img src="https://github.com/user-attachments/assets/c8bde88d-100f-43ac-928e-00b84897f0bf" width="250" />
  <img src="https://github.com/user-attachments/assets/ddf7f306-9da6-446f-b401-ab5a96719ad2" width="250" />
  <img src="https://github.com/user-attachments/assets/5f3b7332-0614-4532-af27-6dd41323f017" width="250" />
</p>

## 🚧 Current Status

MONARQ is currently under active development.

**Implemented**

- Core mobile UI
- Product browsing backed by a live Django REST API
- Product details navigation
- Wishlist
- Cart with quantity sync
- Promo code UI
- Checkout UI
- User registration & login (Django backend)
- Persistent login sessions (`shared_preferences`)
- Animated invalid-credentials error dialog
- Animated order-confirmation flow
- Custom global loading animation
- Profile
- My Orders structure
- Full light/dark theme integration
- Reusable UI components
- Currency formatting
- Custom app icon & branded native splash screen
- Environment-based API configuration (`.env`)

**Planned**

- Full order processing (placing real orders against the backend)
- Wishlist & cart persistence per user account
- Address management (CRUD against backend)
- Payment gateway integration
- Order tracking with live status updates
- Push notifications
- Forgot-password flow
- Final UI/UX polish and micro-animations
- Production deployment (backend hosting + release builds)

## 🎯 Future Goal

The goal is to turn MONARQ into a complete production-ready fashion e-commerce platform with a polished frontend, reliable backend, secure authentication, dynamic order management, and a premium shopping experience.

## 👨‍💻 Developer

**Noman Shariq**

Built as a full-stack Flutter + Django e-commerce project with a focus on modern mobile UI/UX, branded motion design, reusable components, and scalable application architecture.

## 📄 License

This project is currently intended for learning, development, and portfolio purposes.
