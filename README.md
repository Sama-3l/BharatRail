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

[![Demo Video](https://img.youtube.com/vi/fwKU_yVqePY/0.jpg)](https://youtu.be/fwKU_yVqePY)

## 3. Methodology

### 3.1 Design

The idea behind the design was to keep it minimal and also provide a sense of luxury to the app. You can check out the [Figma file](https://www.figma.com/file/pp2Ut9OoujR0rgnDRGNUB3/Untitled?type=design&node-id=0%3A1&mode=design&t=ASj9OkNrEIiSe4jL-1) for this app to get more details on the designing of this app.

### 3.2 Architecture

#### 3.2.1 Trains

Starting with how the trains work in the app, we have Train objects that store attributes that would belong to a train's data.

[Classes](#322-class) have all the classes that a train might have (Sleeper, AC1, AC2, etc.)

TrainCity is an object that stores a [City](#323-city) object along with the time of arrival for the train and time of departure from the same city.

```dart
    class Train {
        String name;
        int number;
        List<TrainCity> citiesCovered;
        List<int> daysOperational;
        List<Class> classes;

        Train(
            {required this.name,
            required this.number,
            required this.citiesCovered,
            required this.daysOperational,
            required this.classes});
    }
```

#### 3.2.2 Class

Now every class has a certain metrics related to it which are number of available seats, number of RAC seats and number of WL seats (There are others but right now this is what the app is built for). 

Along with metrics, we also have the [coaches](#324-coach) (For AC3 - B1, B2, B3, etc.) that are associated to the same.

```dart
class Class {
    String name;
    int dimensionOfClass; // No of seats on one side; S, 3A - 4; 2A - 3; 1A - 2
    List<int> metrics;
    List<Coach> coaches;

    Class(
        {required this.name,
        required this.dimensionOfClass,
        required this.metrics,
        required this.coaches});
}
```

#### 3.2.3 City

This just stores the name but it has been made into an object to allow further scaling when we need to add stations, etc.

```dart
class City{
    String name;

    City({required this.name});
}
```

#### 3.2.4 Coach

Now we have a coach that has a number associated to it, along with a number of seats.

```dart
class Coach {
    String coachNumber;
    List<List<bool>> seats = [
        [],
        []
    ]; // Contains 2 bool values first stores if it's already booked second stores if it's selected now

    Coach({required this.coachNumber});
}
```

#### 3.2.5 User

On the other hand, we need an object to handle the information provided by the user to filter our backend(if the app is actually completed) accordingly.

The arrival and departure City along with depTime which actually contains the departure date is set by the user with an empty [tickets](#326-ticket) list.

```dart
class User {
    String name;
    City arrCity;
    City depCity;
    DateTime depTime;
    List<Ticket> tickets = [];

    User(
        {required this.name,
        required this.arrCity,
        required this.depCity,
        required this.depTime});
}
```

#### 3.2.6 Ticket

Now, generally the ticket stores a ticket number along with the rest of the information about the coach, class, etc. but this way we'll be able to have more tickets and avoid a clutter.

The ticket is distinguished by the [class](#322-class) it is defined to and stores information about the train and the coach which in turn stores the information about the tickets that have already been booked and that have been selected by the user in an array. This array is given by seats in [coach](#324-coach).

```dart
class Ticket {
    String seatClass;
    Coach coach;
    Train train;

    Ticket({required this.seatClass, required this.coach, required this.train});
}
```

## 4. Additional Screens

### 4.1 Splash Screen

This is not a real splash screen but I added one to smooth out the flow of the app. It shows the logo which I made (it's basically just urbanist font), and then it leads you into the home page.

<div style="text-align:center">
<img src="https://github.com/Sama-3l/BharatRail/blob/master/ReadmeImages/splashScreen.jpg?raw=true" alt="Splash-Screen" width="150"/>
</div>

### 4.2 Home Page

The task didn't specify a home page but there always is just too much information that needs to be provided beforehand, that a ticketing system rarely ever comes without one. It made design sense to have a onboarding and provide a varied number of options there.

<div style="text-align:center">
<img src="https://github.com/Sama-3l/BharatRail/blob/master/ReadmeImages/home_screen.jpg?raw=true" alt="Home-Screen" width="150"/>
</div>

### 4.3 Main Page

This is the main ticket selector page that displays train details and then allows you to select class of ticket and also which coach.

<div style="text-align:center">
<img src="https://github.com/Sama-3l/BharatRail/blob/master/ReadmeImages/buy_ticket.jpg?raw=true" alt="Buy-Ticket" width="150"/>
</div>

### 4.4 Payment Overlay

Payment overlay for completing the seat bookings.

<div style="text-align:center">
<img src="https://github.com/Sama-3l/BharatRail/blob/master/ReadmeImages/payment_screen.jpg?raw=true" alt="Payment-Screen" width="150"/>
</div>

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

<div style="text-align:center">
<img src="https://github.com/Sama-3l/BharatRail/blob/master/ReadmeImages/classes.png?raw=true" alt="Classes"/>
</div>

---