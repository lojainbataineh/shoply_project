# Shoply

E-commerce app built with Flutter, Cubit (flutter_bloc) and Firebase
(Auth + Cloud Firestore). Profile pictures are uploaded to Supabase Storage.

## Screens
<img width="1206" height="2622" alt="Screenshot iPhone 18 Pro 31-10-2026 at 3 55 51 PM" src="https://github.com/user-attachments/assets/54da4277-b753-4a01-8428-afe244a0cb67" />

<img width="1206" height="2622" alt="Screenshot iPhone 18 Pro 31-10-2026 at 3 56 28 PM" src="https://github.com/user-attachments/assets/3068b1a1-4e8d-413b-8376-5ecadeceaf41" />

<img width="1206" height="2622" alt="Screenshot iPhone 18 Pro 31-10-2026 at 3 56 33 PM" src="https://github.com/user-attachments/assets/0f0ca7b2-cc1e-4004-9900-0ed4f2fb32cf" />

<img width="1206" height="2622" alt="Screenshot iPhone 18 Pro 31-10-2026 at 3 56 46 PM" src="https://github.com/user-attachments/assets/43c2d6d7-5124-4a62-90a1-2e1820401bfb" />

<img width="1206" height="2622" alt="Screenshot iPhone 18 Pro 31-10-2026 at 3 56 54 PM" src="https://github.com/user-attachments/assets/39a775de-e035-4d61-926b-fa80a61507f2" />

<img width="1206" height="2622" alt="Screenshot iPhone 18 Pro 31-10-2026 at 3 57 06 PM" src="https://github.com/user-attachments/assets/d3eb3e35-b883-44ed-83aa-8a546947eccc" />

Splash · Onboarding · Login · Sign Up · Forgot Password · Home · Categories ·
Products (by category / trending, with sorting) · Product Details · Favorites ·
Cart · Checkout · Drawer · My Orders · Order Details · Settings ·
Update Profile · Change Password · About · Contact Us · Privacy Policy ·
Terms & Conditions

## Connect Firebase (one time)

1. Create a project on <https://console.firebase.google.com>.
2. **Authentication → Sign-in method →** enable **Email/Password**.
3. **Firestore Database → Create database** (any location, production mode).
4. **Firestore → Rules →** paste the contents of [`firestore.rules`](firestore.rules) and publish.
5. From the project root run:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

   Pick your project and the Android + iOS platforms. This replaces the
   placeholder `lib/firebase_options.dart` and adds the platform config files.
6. `flutter pub get` then `flutter run`.

### Sample data

You don't need to add anything to Firestore by hand. The first time a user logs
in, the app uploads [`assets/data/shoply_firestore_sample_data.json`](assets/data/shoply_firestore_sample_data.json)
(5 categories, 10 products with images, 1 home banner) if the `Products`
collection is empty. After that you can lock catalog writes in the rules
(see the comment in `firestore.rules`).

New accounts must verify their email (link sent on sign up) before they can log in.

## Firestore structure

| Path | Content |
|---|---|
| `Categories/{id}` | `id, name, image` |
| `Products/{id}` | `id, categoryId, name, description, price, images[], isTrending, rating, reviewsCount` |
| `Sales/{id}` | `id, title, subtitle, image` (home banner) |
| `User/{uid}` | `uid, email, fullName, userName, address, profileImage` |
| `User/{uid}/cart/{productId}` | `id, name, price, quantity, image[]` |
| `User/{uid}/favorites/{productId}` | product data |
| `Order/{id}` | `id, userUid, fullName, address, subTotal, status, cart[], createdAt` |
| `ContactMessages/{id}` | `userUid, fullName, email, subject, message, createdAt` |

Order `status` values: `pending`, `approved`, `delivered`, `cancelled`
(change them from the Firebase console to see them move between the
My Orders tabs).
