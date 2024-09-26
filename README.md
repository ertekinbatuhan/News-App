 <h1 align="center">News App</h1>
<p align="center">
  The News App is an iOS application that allows you to stay updated with the latest news articles, using a modern and intuitive interface.
</p>

## Features

- Latest News Updates: Stay informed with the most recent news articles from various sources.
- User-Friendly Interface: Intuitive and easy-to-navigate design for an enhanced user experience.
- Favorite Articles: Save your favorite articles for easy access later.
- Article Details: View detailed news articles with images and descriptions.
- AI-Powered Question Assistant: Ask questions about news articles or general topics, and get AI-generated answers to enhance your understanding.
- Dark/Light Mode Support: Seamlessly switch between dark and light themes according to your preference.

##
![Screenshot 2024-05-13 at 17 39 36](https://github.com/ertekinbatuhan/News-App/assets/101355515/5e9f02c8-73c5-4006-86f1-24b11f90709a)
![Screenshot 2024-05-13 at 17 37 43](https://github.com/ertekinbatuhan/News-App/assets/101355515/f0c25cd1-f32b-49a1-882b-809fa308fa12)

## Technologies Used

- **UIKit**: 
  - Utilizing Apple's UIKit framework to build and manage the app’s user interface.
  
- **MVVM**: 
  - Employing the Model-View-ViewModel architecture to separate concerns, making the app more modular and easier to maintain.
  
- **Firebase**: 
  - Integrated for backend services such as real-time data synchronization, authentication, and cloud storage.
  
- **SQLite**: 
  - Used for local data storage, ensuring quick access and efficient data management on the device.
  
- **RxSwift**: 
  - Implementing reactive programming to manage asynchronous tasks and data binding, enhancing the app's responsiveness.
  
- **SDWebImage**: 
  - A third-party library used to download and cache images asynchronously, improving performance and user experience.
 
 ## Architecture Used 
The News app is built using the MVVM (Model-View-ViewModel) architectural pattern. This architecture helps to separate the business logic and data handling from the user interface, making the app more modular, testable, and maintainable.

- **Model**: Represents the data and business logic of the application. It handles the data operations and communicates with external services or databases.
- **View**: The user interface of the app, responsible for displaying the data and handling user interactions.
- **ViewModel**: Acts as an intermediary between the Model and the View. It processes the data received from the Model and prepares it for display in the View, also handling user input and updating the Model accordingly.

![Screenshot 2024-08-09 at 12 31 02](https://github.com/user-attachments/assets/f79044cc-7b40-4d2f-abc1-716dd6384964)
