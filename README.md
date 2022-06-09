# Marvelpedia

1. Installation:
    - Run 'pod install' in order to generate workspace

2. Application architecture & setup:
    - Using MVP as a ui pattern
    
    - Presenters are fully tested by unit tests (49% total app coverage)
    
    - Using a generic network layer exposing api via protocols (using RxSwift)
    
    - Using Repository design pattern for data providers (network / other ..) that is injected into the presenter
    
    - Handling navigation through the app via a Router
    
    - Using RxSwift in handling search operations for better UX
    
    - Using animations in displaying tableview cells
    
    - Using presentation transitions tto display comics/series/stories info in character details page
    
    - Storing marvel API keys in a plist file for better maintainability
    
    - All strings are stored into Localizable.strings
    
    - A clean design that's easy to maintain (using SOLID principles), and a clean project structure

3. Additional features:
    - Displaying info about comics, series and stories in character details page
    
    - Using a custom transition opening the character details page using Hero
    
    - Adding a scroll up button in characters list
    
    - Using custom fonts (Comic Sans)

4. Data structures used:
    - Observer
    - Repository
    - Delegate
    - Singleton
    
5. Libraries used:
    - Alamofire + RxAlamofire
    - RxSwift, RxCocoa
    - Kingfisher
    - Hero
    
6. Credits:
    - This app was developed using marvel apis http://developer.marvel.com/
    - APIs used are:
        - /v1/public/characters
        - /v1/public/characters/{characterId}
        - URIs retrieved from character objects:
            - /v1/public/comics/{comicId}
            - /v1/public/series/{seriesId}
            - /v1/public/stories/{storyId}
    
Other notes: I have also attached a demo of the application for reference.

Thanks!
