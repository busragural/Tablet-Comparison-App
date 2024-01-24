# Tablet-Comparison-App
- TabletFinder - Hybrid Site for Tablet Filtering with Web Crawling

Welcome to TabletFinder, an application designed to streamline the tablet selection process for users on a budget. This project utilizes web scraping techniques to gather information about tablets from popular e-commerce sites such as Vatan, Mediamarkt, and Teknosa. The collected data is then presented to users through a mobile application built with Flutter and Firebase.

Why TabletFinder?
In today's market, users are extensively researching to find tablets that not only meet their technical specifications but also fit within their budget constraints. TabletFinder aims to simplify this process by automating the collection of tablet information and providing users with a user-friendly interface for efficient filtering.

What TabletFinder Offers:
Automatic Data Gathering: Tablet information from Vatan, Mediamarkt, and Teknosa e-commerce sites is automatically collected using web scraping techniques, specifically utilizing Beautiful Soup and Requests Python libraries.

Filtering Options: Users can filter tablets based on various criteria such as brand, price range, size, and technical specifications within the mobile application.

Hybrid Interface: The mobile application is built using Flutter and Firebase. The Dio library in Flutter is employed to display tablet data from different sites retrieved from the Firebase database, providing a seamless and hybrid user experience.

How TabletFinder Works:
Web Scraping: Information about tablets is obtained from e-commerce sites using web scraping methods. Beautiful Soup and Requests Python libraries are employed for this purpose.

Data Storage: The collected data is saved in a database, which is later utilized to display information within the Flutter mobile application.

Mobile Application: The Flutter framework is used to create a user-friendly mobile application. The application pulls tablet data from the Firebase database using the Dio library, providing users with a hybrid experience.