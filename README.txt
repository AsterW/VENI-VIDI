# CSE439-Project

Will Ma, xiaoteng.ma@wustl.edu, 456979
Xiaowen Ma, maxiaowen@wustl.edu, 465589
Andy Wang, haolin.w@wustl.edu, 464458

1 & 2. Utility & Novelty/Creativity of App Concept
This app is designed to help users remember and revive their memories about inspiring or touching creations, whether it’s movies or TV shows, or books, and even games. This is obvious from the app’s UI and can be hinted at by the selector in the timeline/create entry view and the automatic title completion & cover photo retrieval mechanism. 

3. Consistency
Different components of this app use standardized structs, protocols, and interfaces to communicate and collaborate, allowing complex run-time behavior based on simple, concise underlying logic.

4. Framework Usage
This app uses SnapKit and DCFrame for modeling the UI components and delivering the iOS-feeling user experience. CoreData and CloudKit integration is also used to provide an elegant data storage and syncing solution and experience.

5. Optimization
At any and every stage, this app is made with performance in mind. Codes are written to do exactly what’s needed. API search agents are designed to be async and adjusted for API that takes more time to respond. UI handlings are also intended to precisely what’s needed so that fewer resources are required.

6. Modern iOS Features
This app uses widgets so that users can view their recent entries without opening the app, serving as a way to help users remember what they have recently watched and a way to motivate users to spend more mindful minutes appreciating the works they are interested in.

7. Swifty Code
From bigger things like implementation styles to more detailed ones like function signatures, we wrote the code to meet the coding conventions of Swift. 
This is also helped by the use of SwiftFormat and SwiftLint during the development process, which make the code look better and require them to be well-organized.

8. Testing
The internal services were all tested with their respective unit tests, ensuring service quality and reliability. The process of writing tests also promoted the action of designing user-friendly interfaces/function calls for these internal services.
Due to the fast and dynamic changes that happen to our UIs frequently, the UI views reply more on human testing, which is more dynamic and can better adapt to the frequent updates that occur to our UI views.

9. Error-free
This app is tested to be error-free. Xcode warnings are all resolved, with the exception of Pod and 3rd-party framework-related warnings (2 in total), which can be fixed with the release of newer versions of the frameworks.
Codes that might hurt the smooth running of the application are also optimized.

10, 11, 12 User Interface, User Experience, iOS Feel
This app features simplistic UIs with intuitive navigation within and between different UI views. It also interacts with its users in the way an iOS user would expect. It also has small, nice features such as clickable text in floating text view and clickable covers in bookshelf view, which takes the users right to the entry they want to view

13 & 14. Technical Difficulty & Complexity
Although this app doesn’t seem to be sophisticated at first glance, the careful design of its components requires much effort so that things look simple and happen smoothly. With the use of multiple, including some hard-to-use, APIs, this app delivers more than what the users would expect. When it comes to recording one’s thoughts and feelings of literary works and movies, the capability to also record games played is definitely a feature that users don’t expect but need.

15. Accessibility – The app shows a strong consideration of accessibility.
With a careful arrangement of UI components, this app supports VoiceOver well.

