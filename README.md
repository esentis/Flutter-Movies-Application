# Flutter Movies Application

<img src="assets/images/logo.png" alt="drawing" width="500"/>
</br>
<img src="screenshots/showcase.png" alt="drawing" width="500"/>

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

![forthebadge](https://badgen.net/pub/flutter-platform/xml)

[![Website](https://img.shields.io/website?down_color=red&down_message=offline&up_color=green&up_message=online&url=http%3A%2F%2Fhypothermal-mixture.000webhostapp.com)](https://hypothermal-mixture.000webhostapp.com/)

![Flutter CI](https://github.com/esentis/Flutter-News-Application/workflows/Flutter%20CI/badge.svg)

## Overview

A movies application that connects to the <a href="https://www.themoviedb.org/"><img src="assets/images/tmdb.png" width="100" title="TMDB" alt="TMDB Log"></a> .
Get trending and newly released movies with in-depth details.
[Live Version](https://hypothermal-mixture.000webhostapp.com)

## Screenshots

On Load |Navigation| Search Product |
------------ |------------ | -------------|
![On Load](/screenshots/on_load.gif?raw=true "On load") | ![Navigation](/screenshots/navigation.gif?raw=true "Navigation") |![Toggle Theme](/screenshots/toggle_theme.gif?raw=true "Toggle Theme")

Toggle Drawer |Refresh| Toggle Search |
------------ |------------ | -------------|
![Toggle Drawer](/screenshots/toggle_drawer.gif?raw=true "Toggle Drawer") | ![Refresh](/screenshots/refresh.gif?raw=true "Refresh") |![Toggle Search](/screenshots/toggle_search.gif?raw=true "Toggle Search")

Search Error |Search No Results| Search Success |
------------ |------------ | -------------|
![Search Error](/screenshots/search_error.gif?raw=true "Search Error") | ![Search No Results](/screenshots/search_notfound.gif?raw=true "Search No Results") |![Toggle Search](/screenshots/search_success.gif?raw=true "Search Success")

To Movie Screen |From Movie Screen| Favorites |
------------ |------------ | -------------|
![To Movie Screen](/screenshots/to_movie.gif?raw=true "To Movie Screen") | ![From Movie Screen](/screenshots/from_movie.gif?raw=true "From Movie Screen") |![Favorites](/screenshots/favorites.gif?raw=true "Favorites")

Email |LinkedIn| Source |
------------ |------------ | -------------|
![Email](/screenshots/email.gif?raw=true "Email") | ![LinkedIn](/screenshots/linkedin.gif?raw=true "LinkedIn") |![Source](/screenshots/source.gif?raw=true "Source")

## Features

- [x] When the app is loaded, trending movies and upcoming movies are loaded.
- [x] You can search for movies by typing in the search field and pressing enter.
**When on desktop there is a search button below TextField.**
**On Mobile or Tablet you can press the ok button on the virtual keyboard to start searching.**
- [x] When you tap on a movie , you get redirected to a new screen with detailed info.
- [x] On movie's screen there is a heart icon, by tapping it you favorite the movie. On successful addition, a snackbar is shown.
- [x] A favorited movie is indicated by a red heart. By tapping on the heart the movie will be removed from your favorites. On successful deletion, a snackbar is shown.
- [x] Favorited movies can be retrieved by opening the app's drawer.
- [ ] Favorited movies don't hold state since the project has no back-end, meaning on refresh all will be flushed. ***This is not an issue***.
- [x] The grid design is responsive.

**Mobile & Tablet**
<br>
<img src="/screenshots/pageview.gif" alt="drawing" width="200"/>
<br>
**Laptop & Tablet**
<br>
<img src="/screenshots/desktop.gif" alt="drawing" width="450"/>

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
| [responsive_builder](https://pub.dev/packages/responsive_builder) | ^0.2.0+2   | ***Responsiveness***  
| [logger](https://pub.dev/packages/logger) | ^0.9.2  | ***Logging***  |
| [flutter_dotenv](https://pub.dev/packages/flutter_dotenv) | ^2.1.0  | ***Environment Variables***  |
| [flutter_spinkit](https://pub.dev/packages/flutter_spinkit) | ^4.1.2+1  | ***Beautiful Spinkits***  |
| [modal_progress_hud](https://pub.dev/packages/modal_progress_hud) | ^0.1.3  | ***Loading HUD***  |
| [pull_to_refresh](https://pub.dev/packages/pull_to_refresh) | ^1.6.1  | ***Pull to Refresh***  |
| [flare_flutter](https://pub.dev/packages/flare_flutter) | ^2.0.6  | ***Flare Animations***  |
