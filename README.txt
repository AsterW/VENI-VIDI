# CSE439-Project

Will Ma, xiaoteng.ma@wustl.edu, 456979
Xiaowen Ma, maxiaowen@wustl.edu, 465589
Andy Wang, haolin.w@wustl.edu, 464458

Note: `pod install` required before compiling. 

1 & 2. Utility & Novelty/Creativity of App Concept
  - Designed to encourage reading books
  - No other APPs with similar concept/purpose on the AppStore
  - Help users remember and revive their memories about inspiring or touching creations

3. Error-free
  - All data service tested with zero error
  - UI tested periodically with multiple testers
  - Xcode warnings all resolved, excepting one from the 3rd-party SDK (not in our hands)
  - Codes that might hurt the smooth running of the application are also optimized.

4. Consistency
  - DCFrame used for structuring the APP in MVVM
  - Design language is consistent between pages

5. Framework Usage
  - DCFrame for MVVM structure and framing
  - SnapKit for layout
  - 3 APIs for books, movies, and games
  - Core Data for back-end
  - CloudKit for syncing

6. Optimization
  - Heavy API use optimized by only requesting for the data needed
    - cover images are requested after the first layer JSON data is acquired and filtered
    - async calls used for all API calls
  - Data stored to Core Data for faster access in the future
  - DCFrame data communication module
    - faster communication between different pages
    - coupling between modules is mostly avoided
    
7. iOS Feel
  - Color/font selections followed an iOS design language
  - APP looks like an APP developed by APPLE
  - Large navigation titles followed the latest iOS styling conventions
  
8. Accessibility
  - Optimized the layout and logic of the APP specifically for a better voice-over support
  - Contents of the pages can be read through by voice-over and easily understood

9. Testing
  - Internal services were all tested with their respective unit tests, ensuring service quality and reliability
  - The process of writing tests also promoted the action of designing user-friendly interfaces/function calls for these internal services
  - Due to the fast and dynamic changes that happen to our UIs frequently, the UI views reply more on human testing
    - more dynamic and can better adapt to the frequent updates that occur to our UI views.

10. Modern iOS Features
  - Widgets support
  - Swift UI design language for specific portions of the APP, such as the picker view

11. Swifty Code
  - Strictly followed swift coding principles
    - guard / if let all possible nil/optional occurrences
  - Implemented SwiftFormat for formatting and SwiftLint for bad code style detection
  - Organized in a tidy MVVM structure

12, 13 User Interface, User Experience
  - All the UIs are designed with a focus intuitive user interactions
  - Consistency between different pages provides a nice flow of navigation
  - Easy to use without any learning cost
  - Auto-filling APIs allow users to add an entry without knowing any details about the book

14 & 15. Technical Difficulty & Complexity
Although this app doesn’t seem to be sophisticated at first glance, the careful design of its components requires much effort so that things look simple and happen smoothly. With the use of multiple, including some hard-to-use, APIs, this app delivers more than what the users would expect. When it comes to recording one’s thoughts and feelings of literary works and movies, the capability to also record games played is definitely a feature that users don’t expect but need.



