# Crypto App

Welcome to Crypto App, This app allows users to browse cryptocurrencies, examine their details.

## Table of Contents
- [Features](#features)
- [Screenshots](#screenshots)
- [Tech Stack](#tech-stack)
- [Architecture](#architecture)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Usage](#usage)
    - [Listing - Browse Coins](#listing---browse-coins)
    - [Coin Detail](#coin-detail)
- [Known Issues](#known-issues)
- [Improvements](#improvements)

## Features
### Browse Coins:
Explore various coins.
(Note that none of the coins are real, they are provided by a fake api).

### Check out the details:
Check the details and chart of your chosen coin. 

## Screenshots

| Image 1 | Image 2 | Image 3 |
|---------|---------|---------|
![image1](https://github.com/Alihizardere/denemess/assets/79551625/3a2eab31-68ee-49b8-aa21-220e00275d89)|  ![image2](https://github.com/Alihizardere/denemess/assets/79551625/2307f46e-1048-4a5f-a45b-b0f883fe35d0)| ![image3](https://github.com/Alihizardere/denemess/assets/79551625/522fb475-96fa-424f-939e-eef71dd7b853) |
| Homepage | Detail | Web View |

## Tech Stack
- Xcode: Version 15.3
- Language: Swift 5.10
- Minimum iOS Version: 13.0
- Dependency Manager: SPM

## Architecture
![mvvm](https://github.com/Alihizardere/denemess/assets/79551625/d80cf99a-f971-400d-9736-9d6e0dc3e8c9)

When developing the Crypto Project, the MVVM (Model-View-ViewModel) architecture is used for these fundamental reasons:
- **Net Separation:** MVVM clearly separates the user interface (View), business logic (Model) and connectivity (ViewModel), which makes the code more modular and maintainable.
- **Data Binding:** MVVM uses data binding between View and ViewModel. This reduces code repetition, makes UI code cleaner, and enables View to get data from ViewModel and ViewModel to provide data to View.
- **Scalability:** MVVM offers a modular structure and allows new features or changes to be easily added. This makes the application scalable and streamlines the development process.

## Getting Started
### Prerequisites
Before you begin, ensure you have the following:
- Xcode installed

Also, make sure that these dependencies are added in your project's target:
- [Kingfisher](https://github.com/onevcat/Kingfisher): Kingfisher is a lightweight and pure Swift library for downloading and caching images from the web.
- [Alamofire](https://github.com/Alamofire/Alamofire): Alamofire is an elegant HTTP networking library written in Swift.

### Installation
1. Clone the repository:
```bash
git clone https://github.com/lochmidth/GetirFinalProject.git
```

2. Open the project in Xcode:
```bash
cd Crypto-App
open Crypto-App.xcodeproj
```
3. Add required dependencies using Swift Package Manager:
```bash
- Kingfisher
- Alamofire 
```

4. Build and run the project.

### Usage
#### Listing - Browse Coins
- Open the app on your simulator or device.
- Browse coins, tap on the relevant product to go to the coin Detail.

#### Coin Detail
- See additional information about Coin and its chart.
-  Visit the website

## Known Issues
- A few coins have minor bugs when pulling the price or image from the API.

## Improvements
- A more pleasant and seamless animations can be added for a better user experience.
- Localization for other languages can be added to reach more users.
