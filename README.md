# Sports App 🏆

Sports App is an iOS application built using Swift and UIKit that allows users to explore different sports, leagues, events, and teams using real-time data from TheSportsDB API.

The application provides a smooth and modern user experience with responsive UI, favorite leagues management, and detailed information about leagues, matches, and teams.

---

# ✨ Main Features

## 🥎 Sports Screen
- Displays all available sports in a CollectionView
- Clean two-column layout
- Each item contains:
  - Sport image
  - Sport name
- Selecting a sport navigates to its leagues

---

## 🏆 Leagues Screen
- Displays all leagues related to the selected sport
- Custom UITableViewCell design
- Each league contains:
  - League badge
  - League name
- Selecting a league opens League Details screen

---

# 📋 League Details Screen

The screen is divided into three main sections:

## ⏳ Upcoming Events
Horizontal CollectionView displaying:
- Event name
- Event date
- Event time
- Teams images

---

## ⚽ Latest Events
Vertical CollectionView displaying:
- Home team vs Away team
- Match score
- Date
- Time
- Teams images

---

## 👥 Teams Section
Horizontal CollectionView displaying:
- Team logo in circular shape

Selecting a team opens Team Details screen.

---

# 👕 Team Details Screen
- Displays important information about the selected team
- Elegant and responsive UI design

---

# ❤️ Favorites Screen
- Save favorite leagues locally using CoreData
- Display all favorite leagues
- Internet connection checking before opening details
- Alert appears when there is no internet connection

---

# 🛠 Technologies & Tools

- Swift
- UIKit
- Alamofire
- CoreData
- Auto Layout Constraints
- Swift Package Manager (SPM)
- Unit Testing

---

# 🧠 Architecture Pattern

The project follows the MVP Architecture Pattern to maintain:
- Clean code
- Separation of concerns
- Better scalability and testability

---

# 🌐 API

Data is fetched using:

https://allsportsapi.com/

---

# 🎨 UI/UX

- Responsive design for all screen sizes
- Smooth navigation between screens
- Circular images and clean layouts
- Consistent theme across the application

# 🚀 How to Run the Project

1. Clone the repository
2. Open the project using Xcode
3. Wait for Swift Packages to resolve automatically
4. Build and Run the application on Simulator or Physical Device

