
# IRCTC-Flights

## Overview
IRCTC-Flights is a web application designed to facilitate flight bookings through the IRCTC platform. This project leverages Java and web technologies to provide a robust and user-friendly interface for flight searches and bookings.

## Table of Contents
- [Overview](#overview)
- [Project Structure](#project-structure)
- [Getting Started](#getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation](#installation)
  - [Configuration](#configuration)
  - [Running the Application](#running-the-application)
- [Usage](#usage)
- [Features](#features)
- [Technologies Used](#technologies-used)
- [Contributing](#contributing)


## Project Structure
The project is structured as follows:

- `README.md` - The main README file for the project.
- `json-simple.jar` - The library for JSON parsing.
- `src` - The directory containing the source code:
  - `main` - The main Java application code.
  - `resources` - The resource files.
- `web` - The directory containing web application files.

## Getting Started

### Prerequisites
To run this project, you will need:

- JDK 8 or later
- Apache Tomcat 8 or later
- MySQL or another relational database

### Installation

1. **Clone the repository:**
   ```sh
   git clone https://github.com/Parmeet15/IRCTC-Flights.git
   cd IRCTC-Flights
   ```

2. **Build the project:**
   Use the following command to compile the project:
   ```sh
   javac -cp json-simple.jar src/main/java/com/irctc/flights/*.java -d out
   ```

### Configuration

Update the configuration settings in the `src/main/resources/application.properties` file:

```properties
spring.datasource.url=jdbc:mysql://<your-server>:3306/irctcflightsdb
spring.datasource.username=<your-username>
spring.datasource.password=<your-password>
spring.jpa.hibernate.ddl-auto=update
```

### Database Setup

1. **Create the database:**
   Ensure your MySQL instance is running and create a new database named `irctcflightsdb`.

2. **Run the application:**
   The application will automatically create the necessary tables when it starts up.

### Running the Application

1. **Deploy to Tomcat:**
   Copy the compiled classes and web files to the Tomcat webapps directory.

2. **Start the Tomcat server:**
   Use the following command to start the server:
   ```sh
   catalina.sh start
   ```

3. **Access the application:**
   Open your web browser and go to `http://localhost:8080/IRCTC-Flights` to access the application.

## Usage
After running the application, you can search for flights, view flight details, and make bookings through the user interface.

## Features
- **Flight Search:** Search for available flights based on user criteria.
- **Booking Management:** Book flights and manage existing bookings.
- **User Authentication:** Secure login and registration functionality.
- **Responsive Design:** The application is fully responsive and works on all devices.

## Technologies Used
- **Java:** The main programming language for the application.
- **Spring Boot:** For building the backend services.
- **MySQL:** The relational database management system.
- **JSON-simple:** For parsing JSON data.
- **JSP:** For server-side rendering of web pages.
- **Bootstrap:** For responsive design and styling.

## Contributing
Contributions are welcome! To contribute:

1. **Fork the repository:**
   Click the "Fork" button on the repository page to create a copy of the repository in your GitHub account.

2. **Clone the forked repository:**
   ```sh
   git clone <your-forked-repository-url>
   cd IRCTC-Flights-master
   ```

3. **Create a new branch:**
   ```sh
   git checkout -b feature/your-feature-name
   ```

4. **Make your changes:**
   Implement your feature or bug fix.

5. **Commit your changes:**
   ```sh
   git add .
   git commit -m "Add your commit message"
   ```

6. **Push to your branch:**
   ```sh
   git push origin feature/your-feature-name
   ```

7. **Create a pull request:**
   Go to the original repository and create a pull request from your forked repository.


