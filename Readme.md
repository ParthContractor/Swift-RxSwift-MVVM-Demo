Develop an app that will display SpaceX data.
API documents are available here: https://docs.spacexdata.com
Must have:
• Display a list of launches with minimal information.
• Ability to sort launches by either launch date or mission name.
o When sorted by launch date, group them by year
o When sorted by mission name, group them by the first alphabet
• Ability to filter by launch success.
• When a launch is selected display a screen with detailed launch information and the
rocket details used for the launch.
o Data from One Launch endpoint
o Data from One Rocket endpoint
• Provide a feature to navigate users to Wikipedia page about the rocket.

Please create a public repository on Github and share the link.
In Read Me, please explain the architecture, design patterns and assumptions you’ve made
for the assignment.
Bonus points:
• Try to avoid third party libraries for sorting and grouping
• RxSwift


<---Code Overview--->
* Programming paradigm
  * Combination of Reactive, OOP and POP
* Application Architecture
  * MVVM
* Dependency
  * RxSwift (https://github.com/ReactiveX/RxSwift) 
  * Framework dependency added through Carthage 
  * Required dependency already checked in to github to start/run the application without carthage update required otherwise 
* Deployment target: iOS 11
* Supported devices: iPad and iPhone
* Xcode  version used: 11.1

