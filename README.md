# 📱 PokeDex

The **PokeDex App Project** is an application that utilizes Pokémon data, allowing users to explore a list of Pokémon and view detailed information. Built on the RxSwift framework and the MVVM pattern, the app efficiently manages asynchronous data processing with simplicity and effectiveness. Users can browse information such as Pokémon names, images, types, height, weight, and more, with easy access via infinite scrolling and a detailed view.

## 📚 Tech Stacks

<div>
  <a href="https://developer.apple.com/xcode/" target="_blank">
    <img src="https://img.shields.io/badge/Xcode_16.1-147EFB?style=for-the-badge&logo=xcode&logoColor=white" alt="Xcode">
  </a>
  <a href="https://swift.org/" target="_blank">
    <img src="https://img.shields.io/badge/Swift_5-F05138?style=for-the-badge&logo=swift&logoColor=white" alt="Swift">
  </a>
  <br>
  <a href="https://developer.apple.com/documentation/uikit" target="_blank">
    <img src="https://img.shields.io/badge/UIKit-2396F3?style=for-the-badge&logo=uikit&logoColor=white" alt="UIKit">
  </a>
  <a href="https://github.com/SnapKit/SnapKit" target="_blank">
    <img src="https://img.shields.io/badge/SnapKit-00aeb9?style=for-the-badge&logoColor=white" alt="SnapKit">
  </a>
  <a href="https://github.com/devxoul/Then" target="_blank">
    <img src="https://img.shields.io/badge/Then-00aeb9?style=for-the-badge&logoColor=white" alt="Then">
  </a>
  <a href="https://github.com/Alamofire/Alamofire" target="_blank">
    <img src="https://img.shields.io/badge/AlamoFire-d6401b?style=for-the-badge&logoColor=white" alt="Then">
  </a>
  <br>
  <a href="https://www.gitkraken.com/" target="_blank">
    <img src="https://img.shields.io/badge/gitkraken-179287?style=for-the-badge&logo=gitkraken&logoColor=white" alt="GitKraken">
  </a>
  <a href="https://github.com/" target="_blank">
    <img src="https://img.shields.io/badge/github-181717?style=for-the-badge&logo=github&logoColor=white" alt="GitHub">
  </a>
  <br>
</div>

## 📅 Project Scope

| Developer   |  Links                          | Project Timeline      |  
| --------    | --------------------------------- | ---------------------- |  
| DoyleHWorks | [GitHub](https://github.com/DoyleHWorks) <br> [Velog](https://velog.io/@doylehworks/posts?tag=ProjectPokeContact)  | 2024-12-30 <br> ~ 2025-01-05 | 

## 📂 Folder Organization
```
PokeDex
├── App/
│   ├── AppDelegate
│   ├── Info
│   ├── LaunchScreen
│   ├── PokeDex
│   └── SceneDelegate
├── Models/
│   ├── Services/
│   │   ├── APIEndpoints
│   │   ├── PokemonDetailFetcher
│   │   ├── PokemonImageLoader
│   │   └── PokemonListFetcher
│   ├── PokemonDetail
│   └── PokemonListResponse
├── Network/
│   ├── NetworkError
│   └── NetworkManager
├── Resources/
│   ├── Assets
│   └── Colors
├── ViewModels/
│   ├── DetailViewModel
│   └── MainViewModel
└── Views/
    ├── DetailViewController
    ├── MainViewController
    └── PokemonCollectionViewCell

```

## 📐 Key Features

- **Explore Pokémon List**:  
  - Fetch Pokémon data from the API and display it in a list format.  
  - Infinite scroll functionality for continuous Pokémon exploration.  

- **View Pokémon Details**:  
  - Provides detailed information such as name, image, type, height, weight, and more.  
  - Displays data in a user-friendly format.  

- **Fast Data Loading**:  
  - Utilizes RxSwift for asynchronous data loading and seamless UI updates.  
  - Implements Kingfisher for image caching and rapid loading speeds.  

- **Error Handling**:  
  - Displays appropriate error messages to users when API calls fail.  
  - Handles network connectivity issues and data decoding errors effectively.  

- **Responsive User Experience**:  
  - Shows the current Pokémon number at the top of the screen based on the scroll position.  
  - Smooth transitions to `DetailViewController` upon cell selection.  

## 📦 How to Install  
1. Clone this repository:  
   ```bash  
   git clone https://github.com/DoyleHWorks/PokeDex.git  
   ```  
