# Programming Hacks 

Programming Hacks Application is a mobile application built with Flutter and Supabase that provides a curated list of technologies along with tips and tricks for each technology. The application aims to assist programmers and developers in enhancing their knowledge and skills in various programming languages, frameworks, tools, and technologies.







## Features

- **Technology List**: Browse through a comprehensive list of technologies including programming languages, framework.

- **Tips and Tricks**: Access a collection of useful tips and tricks for each technology to improve proficiency and efficiency.

- **User Interface and Experience**: Enjoy an intuitive and visually appealing user interface for seamless navigation and readability.




## Tech Stack

- **Flutter** : We want to build application for the multiple platform such as Android, IOS, Web, Desktop. The apps built with Flutter have smooth animations and fast rendering, providing a seamless and responsive user experience. The development speed increase because Flutter Provide veriety of the Widgets and Also provide real time changes in UI. 

- **Supabase** : Supabase is an open source Firebase alternative for building secure and performant Postgres backends with minimal configuration.


## Documentation

In the Application ,We use Supabase as Backend as a Service (BaaS) that provides developers with a set of tools and services to build scalable and secure web and mobile applications. We use PostgreSQL database with a real-time WebSocket API and authentication services, making it easier to develop full-stack applications.

**A brief description of how we used Supabase**:

Supabase is utilized by creating two tables one for "Technology" and another for "Hacks".

**Technologies Table**: 
- The **Technologies** table is created in the Supabase database to store information about various programming technologies such as programming languages and frameworks. 
- Each row in the **Technologies** table represents a specific technology and holds relevant data such as the technology's name and any other attributes that may be useful for categorizing or identifying the technology.
- This table serves as the parent table because it holds the primary data for each technology, and other tables, like the **Hacks** table, can establish relationships with it.

**Hacks Table** :

- The **Hacks** table is created in the Supabase database to store tips and tricks related to specific technologies.
- Each row in the **Hacks** table represents a tip or trick and includes fields such as the hack's description, example code snippets, or any other relevant information.
- To establish a relationship with the "Technologies" table, the **Hacks** table includes a foreign key column that references the primary key of the corresponding technology in the "Technologies" table.

**Authentication Part** : 

Supabase authentication feature is utilized to enable user signup and signin functionality using email and password. Here's a brief description of how Supabase authentication is used.

**Signup with Email and Password** :

- When a user wants to create an account in the application, they can use the signup feature.
- The user provides their username,email address and password as input.
- The Supabase authentication system is used to handle the signup process by calling the appropriate function from the Supabase client library in the Flutter application.
- Supabase validates the provided email and password, creates a new user account, and securely stores the user's credentials in its authentication system.

**Signin with Email and Password** :

- Existing users can sign in to their accounts using the signin feature.
- The user enters their email address and password in the application.
- The Supabase authentication system verifies the provided credentials by calling the signin function from the Supabase client library.
- If the provided credentials are correct, Supabase generates an access token or session token for the user, indicating a successful signin.
- The application can store this token securely on the client-side (such as in local storage or secure storage) for subsequent authenticated requests to Supabase.


# About us  

Welcome to our project! We are a dedicated team of four members working together to create something awesome. Here's a little bit about each of us:

## Team members

 **Pratik Butani** 
 - Github : [pratikbutani](https://github.com/pratikbutani)
 - Twitter : [pratik13butani](https://twitter.com/pratik13butani)
 - Role: Team Lead
 

 **Cavin Macwan** 
 - Github : [cavin6080](https://github.com/cavin6080)
 - Twitter : [cavin_1910](https://twitter.com/cavin_1910)
 - Role: Flutter Developer 

 **Nikunj Panchal** 
 - Github : [nikunjpanchall](https://github.com/nikunjpanchall)
 - Twitter : [its_me_nikunj_](https://twitter.com/its_me_nikunj_)
 - Role: Flutter Developer

 **Vatsal Gajjjar** 
 - Github : [gajjarvatsall](https://github.com/gajjarvatsall)
 - Twitter : [gajjarvatsall](https://twitter.com/gajjarvatsall)
 - Role: Flutter Developer








