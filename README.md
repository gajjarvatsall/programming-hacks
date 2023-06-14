# Programming Hacks 🚀

Programming Hacks Application is a mobile application built with Flutter and Appwrite that provides a curated list of technologies along with tips and tricks for each technology. The application aims to assist programmers and developers in enhancing their knowledge and skills in various programming languages, frameworks, tools, and technologies. 💡

## Preview 📱
![loginScreen](https://github.com/gajjarvatsall/programming-hacks/assets/114209867/42b77caf-ec8f-4325-be0f-32e98f3119f0)![splashScreen](https://github.com/gajjarvatsall/programming-hacks/assets/114209867/f05ff87a-6f37-451b-9a37-8ec906a001c8)![homeScreen](https://github.com/gajjarvatsall/programming-hacks/assets/114209867/73f2ae34-4985-4fff-9ffb-245261d35fa0)![detailScreen](https://github.com/gajjarvatsall/programming-hacks/assets/114209867/6051e92f-ddc2-43a5-b78a-51183f8f7b6f)


## Features ✨

- **Technology List**: Browse through a comprehensive list of technologies including programming languages, frameworks, and tools. 📚
- **Tips and Tricks**: Access a collection of useful tips and tricks for each technology to improve proficiency and efficiency. 💪
- **User Interface and Experience**: Enjoy an intuitive and visually appealing user interface for seamless navigation and readability. 🎨
- **Daily Notifications**: Receive daily notifications with random programming hacks to keep you motivated and expand your knowledge. 📲
- **Hacks Sharing**: Share interesting hacks with your friends and colleagues through various communication channels. 🚀
- **Hacks Bookmarking**: Bookmark the hacks you like and read them later. 🔖

## Tech Stack 🛠️

- **Flutter**: We built the application using Flutter to enable cross-platform development for Android, iOS, Web, and Desktop. Flutter provides a rich set of widgets, allowing for fast rendering and smooth animations, resulting in a responsive user experience. Additionally, Flutter's hot-reload feature enables real-time UI changes, enhancing development speed. 📱💻

- **Appwrite**: We switched to Appwrite as the backend service provider. Appwrite is an open-source, self-hosted backend-as-a-service (BaaS) platform that simplifies server-side development tasks. It offers features such as a database, user authentication, file storage, and more, making it easier to build scalable and secure applications. 🔐🌐

## Documentation 📖

In the Application, we replaced Supabase with Appwrite as the backend service provider. Here's an overview of how Appwrite is utilized in the application:

**Technologies Collection**:

- The **Technologies** collection is created in the Appwrite database to store information about various programming technologies such as programming languages, frameworks, and tools.
- Each document in the **Technologies** collection represents a specific technology and holds relevant data, including the technology's name and any other attributes useful for categorizing or identifying the technology. 📂

**Hacks Collection**:

- The **Hacks** collection is created in the Appwrite database to store tips and tricks related to specific technologies.
- Each document in the **Hacks** collection represents a tip or trick and includes fields such as the hack's description, example code snippets, or any other relevant information.
- To establish a relationship with the "Technologies" collection, each document in the **Hacks** collection includes a reference field that points to the corresponding technology document in the **Technologies** collection. 🔗

**Authentication and User Management**:

Appwrite provides user authentication and management features. Here's a brief description of how Appwrite authentication is used:

**Authentication with Email and Password**:
- When a user wants to create an account in the application, they can use the signup feature.
- The user provides their email address and password as input.
- The Appwrite authentication system handles the signup process by calling the appropriate API endpoint from the Flutter application.
- Appwrite validates the provided email and password, creates a new user account, and securely stores the user's credentials in its authentication system. 🔑

**Authentication with Google**:
- When a user wants to create an account in the application, they can use the signup feature with their Google account.
- The user selects the option to sign up with Google and is redirected to the Google authentication page.
- After successful authentication with Google, Appwrite creates a new user account and securely stores the user's credentials. 🌐

## About Us 👥

Welcome to our project! We are a dedicated team of four members working together to create something awesome. Here's a little bit about each of us:

**Pratik Butani** 🎯
- GitHub: [pratikbutani](https://github.com/pratikbutani)
- Twitter: [pratik13butani](https://twitter.com/pratik13butani)
- Role: Team Lead

**Cavin Macwan** 💻
- GitHub: [cavin6080](https://github.com/cavin6080)
- Twitter: [cavin_1910](https://twitter.com/cavin_1910)
- Role: Flutter Developer

**Nikunj Panchal** 📱
- GitHub: [nikunjpanchall](https://github.com/nikunjpanchall)
- Twitter: [its_me_nikunj_](https://twitter.com/its_me_nikunj_)
- Role: Flutter Developer

**Vatsal Gajjar** 🚀
- GitHub: [gajjarvatsall](https://github.com/gajjarvatsall)
- Twitter: [gajjarvatsall](https://twitter.com/gajjarvatsall)
- Role: Flutter Developer

We are excited to bring you an amazing programming hacks application. Stay tuned for updates and new features! 🎉✨

Feel free to reach out to us if you have any questions or suggestions. Happy coding! 💻😊
