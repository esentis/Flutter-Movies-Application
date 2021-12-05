# Flutter Movies Application

<img src="assets/images/logo.png" alt="drawing" width="500"/>
</br>
<img src="screenshots/showcase.png" alt="drawing" width="500"/>

[![forthebadge](https://forthebadge.com/images/badges/built-with-love.svg)](https://forthebadge.com)

![Last commit](https://img.shields.io/github/last-commit/esentis/Flutter-Movies-Application?style=for-the-badge)

![forthebadge](https://badgen.net/pub/flutter-platform/xml)

[![Website](https://img.shields.io/website?down_color=red&down_message=Offline&style=for-the-badge&up_color=green&up_message=Online&url=https%3A%2F%2Fflutter-movies-application.web.app%2F)](https://flutter-movies-application.web.app)

![Lines of Code](https://img.shields.io/tokei/lines/github/esentis/Flutter-Movies-Application?style=for-the-badge)

## Overview

A movies application that connects to the <a href="https://www.themoviedb.org/"><img src="assets/images/tmdb.png" width="100" title="TMDB" alt="TMDB Log"></a> .
Get trending and newly released movies with in-depth details.
[Live Version](https://flutter-movies-application.web.app)

## Screenshots

| On Load                                                 | Navigation                                                       | Toggle Theme                                                           |
| ------------------------------------------------------- | ---------------------------------------------------------------- | ---------------------------------------------------------------------- |
| ![On Load](/screenshots/on_load.gif?raw=true "On load") | ![Navigation](/screenshots/navigation.gif?raw=true "Navigation") | ![Toggle Theme](/screenshots/toggle_theme.gif?raw=true "Toggle Theme") |

| Toggle Drawer                                                             | Refresh                                                 | Toggle Search                                                             |
| ------------------------------------------------------------------------- | ------------------------------------------------------- | ------------------------------------------------------------------------- |
| ![Toggle Drawer](/screenshots/toggle_drawer.gif?raw=true "Toggle Drawer") | ![Refresh](/screenshots/refresh.gif?raw=true "Refresh") | ![Toggle Search](/screenshots/toggle_search.gif?raw=true "Toggle Search") |

| Search Error                                                           | Search No Results                                                                   | Search Success                                                              |
| ---------------------------------------------------------------------- | ----------------------------------------------------------------------------------- | --------------------------------------------------------------------------- |
| ![Search Error](/screenshots/search_error.gif?raw=true "Search Error") | ![Search No Results](/screenshots/search_notfound.gif?raw=true "Search No Results") | ![Toggle Search](/screenshots/search_success.gif?raw=true "Search Success") |

| To Movie Screen                                                          | From Movie Screen                                                              | Favorites                                                     |
| ------------------------------------------------------------------------ | ------------------------------------------------------------------------------ | ------------------------------------------------------------- |
| ![To Movie Screen](/screenshots/to_movie.gif?raw=true "To Movie Screen") | ![From Movie Screen](/screenshots/from_movie.gif?raw=true "From Movie Screen") | ![Favorites](/screenshots/favorites.gif?raw=true "Favorites") |

| Email                                             | LinkedIn                                                   | Source                                               |
| ------------------------------------------------- | ---------------------------------------------------------- | ---------------------------------------------------- |
| ![Email](/screenshots/email.gif?raw=true "Email") | ![LinkedIn](/screenshots/linkedin.gif?raw=true "LinkedIn") | ![Source](/screenshots/source.gif?raw=true "Source") |

## Features

- [x] When the app is loaded, trending movies and upcoming movies are loaded.
- [x] You can search for movies by typing in the search field and pressing enter.
      **When on desktop there is a search button below TextField.**
      **On Mobile or Tablet you can press the ok button on the virtual keyboard to start searching.**
- [x] When you tap on a movie , you get redirected to a new screen with detailed info.
- [x] On movie's screen there is a heart icon, by tapping it you favorite the movie. On successful addition, a snackbar is shown.
- [x] A favorited movie is indicated by a red heart. By tapping on the heart the movie will be removed from your favorites. On successful deletion, a snackbar is shown.
- [x] Favorited movies can be retrieved by opening the app's drawer.
- [ ] Favorited movies don't hold state since the project has no back-end, meaning on refresh all will be flushed. **_This is not an issue_**.
- [x] The grid design is responsive.

| Mobile & Tablet                                     | Desktop                                          |
| --------------------------------------------------- | ------------------------------------------------ |
| ![Mobile/Tablet](/screenshots/pageview.gif "Email") | ![LinkedIn](/screenshots/desktop.gif "LinkedIn") |

- [x] There is a settings icon (three dots) where you can change theme (Dark, Light), send e-mail and visit the source code of the app.
