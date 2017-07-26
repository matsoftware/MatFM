# MatFM

Test application for the LastFM API.

# Install notes
The project has been developed using Swift 3.1 on Xcode 8.3.3 and Carthage as dependency management framework. It runs on both iPhone and iPad.

# Architecture
The project is built using a layered architecture where components on the lower levels have no knoledge of the ones in the upper level to avoid coupling. 
The layers are identified with a specific class prefix and group in the Xcode project, and they can be easily moved to separate frameworks if the project grows up.
Starting from the bottom, the layers are:
- **Utility** : Foundation layer to put low level components (in this case, it contains a wrapper around DispatchQueue to improve the stability of tests)
- **Networing**: The core networking layer of the app, containing the logic to perform URL request to retrieve data and parse JSON responses; depends on Utility
- **MusicService**: It's the lowest business logic layer, containg the service responsible to provide the list of tracks using a query text; depends on Networking
- **MusicLibrary**: UI module built with a simplified version of VIPER responsible of presenting the main functionalities of the app to the user; depends on MusicService

# Third party libraries
For convenience and time constraints it has been made use of SDWebImage to fetch UIImages asynchronously and avoid the implementation of a tedious caching mechanism for thumbnails; same reasons stands for PKHUD library, while the choice of SwiftlyJSON comes from the necessity of a solid, handy and easy to use JSON parser in Swift (until Swift 4 becomes stable and it will be possible to make use of the Codable functionalities).

# Known issues
- the caching and timeout settings can be improved
- the async image fetching from the ViewController might constitue a violation of the VIPER approach, but it provides the best trade-off in terms of code complexity and efficiency
- finalize test coverage of the routing component
- improve the look and feel :)

----
Mattia Campolese - info@matsoftware.net - 26th of July 2017.
