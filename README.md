# Flutter Movies Application

<img src="assets/images/logo.png" alt="drawing" width="500"/>

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

![forthebadge](https://badgen.net/pub/flutter-platform/xml)

[![Website](https://img.shields.io/website?down_color=red&down_message=offline&up_color=green&up_message=online&url=http%3A%2F%2Fwww.esentis.gr)](www.esentis.gr)

![Flutter CI](https://github.com/esentis/Flutter-News-Application/workflows/Flutter%20CI/badge.svg)

## Overview

A movies application that connects to the [IMDB - Internet Movie Database (Unofficial) API](https://rapidapi.com/hmerritt/api/imdb-internet-movie-database-unofficial/). Get detailed information about movies.

## Screenshots

>Coming soon.

## Features

- [x] When the app is loaded, top headlines are fetched based on your country.
- [x] You can search for movies by typing in the search field.
**When on desktop there is a search button below TextField.**
**On Mobile or Tablet you can press the ok button on the virtual keyboard to start searching.**
- [x] When you tap on a news card, you get redirected to a new screen with the article details.
- [x] Some articles have no image, so an image placeholder is shown instead.
- [x] On movie's screen there is a heart icon, by tapping it you favorite the movie. On successful addition, a snackbar is shown.
- [x] A favorited movie is indicated by a red heart. By tapping on the heart the movie will be removed from your favorites. On successful deletion, a snackbar is shown.
- [x] Favorited movies can be retrieved by opening the app's drawer.
- [ ] Favorited movies don't hold state since the project has no back-end, meaning on refresh all will be flushed. ***This is not an issue***.
- [x] The grid design is responsive.

- 5 cards per row on Desktop (widescreen).
- 4 cards per row on Desktop.
- 3 cards per row on Laptop.
- 2 cards per row on Tablet.
- 1 card per row on Mobile.

- [x] There is a settings icon (three dots) where you can change theme (Dark, Light), send e-mail and visit the source code of the app.

## Libraries

| Name        | Version           | Use case |
| :------------- |:-------------:|:-------------:|
| [get](https://pub.dev/packages/get)| ^3.4.4 | ***Routing*** |
| [provider](https://pub.dev/packages/provider)     | ^4.3.2      | ***State Management***|
| [pedantic](https://pub.dev/packages/pedantic) | ^1.9.0     |***Static Analysis*** |
| [url_launcher](https://pub.dev/packages/url_launcher) | ^5.5.0   | ***Url Launcher***  |
| [dio](https://pub.dev/packages/dio) | ^3.0.10   | ***HTTP Requests***  |
| [google_fonts](https://pub.dev/packages/google_fonts) |  ^1.1.0   | ***Fonts***  |
| [responsive_builder](https://pub.dev/packages/responsive_builder) | ^0.2.0+2   | ***Responsiveness***  |
| [logger](https://pub.dev/packages/logger) | ^0.9.2  | ***Logging***  |
