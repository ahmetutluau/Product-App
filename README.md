# Order-App
An application where you can see various food categories, select the menus you want from these categories, see the details and add them to your shopping cart. At the same time, you can sort these menus by price, date or title.
The main purpose of this project is to consolidate Networking operations and to actively use MVC Dizayn Patter.

## Technologies
MVC,
Delegate Design Patern,
TableView,
KingFisher,
Activity Indicator,
Alert Message,
Extensions,
Segue,
UrlSession,
SwiftSoup,

## Description
In this application which I made using MVC design patter, I first pulled the data from the service using UrlSession, then transferred this data to the relevant pages, I used the Kingfisher 3rd Part Library for convenience while downloading the pictures. I have used Delegate Design Patter to keep sync between my Models and Controllers and I have used Activity Indicator to provide better user experience while data is loading. I made the transition between controllers and data transfer with Segue, on the other hand, I got some of my HTML type data in String type with SwiftSoup library. Finally, I showed the Alert Message using Extensions in order to maintain the clean code quality when the user adds a product to their cart.
