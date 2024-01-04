# Bharatrail: A New Way to Buy Train Tickets

## Overview

Welcome to Bharatrail, your innovative solution for hassle-free train ticket purchases. This README provides essential information to get started with the demo app.

## Features

- **Minimal Design:** With an eye for design, I worked on crafting a minimal but unique UI experience.
- **Coach Selection:** Along with being able to select seats, user can also select coach.
- **Crowd Visualization:** The app helps you get an idea of how crowded your surrounding might be on a particular train.

## Installation

### Prerequisites

Before you begin, ensure you have the following prerequisites installed on your system:

- [Flutter](https://flutter.dev/docs/get-started/install) (version 3.13.8 or higher)
- [Dart](https://dart.dev/get-dart) (version 3.1.4 or higher)
- [Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)  

### Installation Steps

1. **Clone the Repository:**
   ```bash
   git clone https://github.com/Sama-3l/BharatRail.git

2. **Move into the repository**
   ```bash
   cd BharatRail

3. **Get all dependencies and run on connected device**
   ```bash
   flutter pub get
   flutter run

If you are looking for the apk, you can get the Bharatrail_v1.0.0.apk in the folder:
```bash
    cd .\BharatRail\apk
```

## 2. Demo Video

[![Demo Video](https://img.youtube.com/vi/sYhKiPzGPYc/0.jpg)](https://www.youtube.com/watch?v=sYhKiPzGPYc)

## 3. Methodology

### 3.1 Architecture

Bharatrail follows a robust and scalable architecture to provide a seamless user experience. Describe the overall architecture, design principles, and any noteworthy patterns.

## 4. Additional Screens

### 4.1 Splash Screen

This is not a real splash screen but I added one to smooth out the flow of the app. It shows the logo which I made (it's basically just urbanist font), and then it leads you into the home page.

![Splash-Screen](https://github.com/Sama-3l/BharatRail/blob/master/ReadmeImages/splashScreen.jpg?raw=true)

### 4.2 Home Page

The task didn't specify a home page but there always is just too much information that needs to be provided beforehand, that a ticketing system rarely ever comes without one. It made design sense to have a onboarding and provide a varied number of options there.

![Splash-Screen](https://github.com/Sama-3l/BharatRail/blob/master/ReadmeImages/home_screen.jpg?raw=true)

## 5. App Features

### 5.1 Auto-Scrolling of Coaches

This is a code snipet from [functions.dart](https://github.com/Sama-3l/BharatRail/blob/master/lib/functions/functions.dart) which controls the auto-scrolling which is triggered when you select a coach. It scrolls by a height which is 2.1 times the height of user's screen (done using [MediaQuery](https://api.flutter.dev/flutter/widgets/MediaQuery-class.html)).

I will implement scroll back to top button too.
```dart
    // Function called when a new coach is selected from
    // The dropdownmenu in Buy Ticket screen         (select_coach_drop_down.dart)
    void onCoachChange(Ticket ticket, Class currClass, String? newValue,
        ScrollController controller, double height) {

        int indexOfCoach = currClass.coaches.indexWhere((element) {
        return element.coachNumber == newValue!;
        });

        if (indexOfCoach != -1) {
        scroll(controller, height, indexOfCoach);
        }
        ticket.coach = currClass.coaches[indexOfCoach];
    }


    // Called to scroll the listview (5 lines above us)
    void scroll(ScrollController controller, double height, int index) async {
        controller.animateTo(height * index,
            duration: Duration(milliseconds: scrollDuration),
            curve: Curves.easeInOutCubic);
    }
```

### 5.2 Different Types of Seats

There are total three types of seats and I went through some literature to finally learn, for myself too actually, what RAC, WL, etc. actually mean and I did my best to implement the same into the app.

---