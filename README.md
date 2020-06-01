# TVShowManager

Small case study assignment for a NDA company.

## Contents

- [Specification](#specification)
- [Description](#description)

## Specification

For this assignment, the goal is to create the "TV show manager app". An app for people who watch so many tv shows that they can’t keep track of all of them without the help of an app.

The app consists of the three views:

1. The first view let’s the user choose between adding a new tv show and showing the list of already added shows. If the user taps the "Add new TV show" button, he or she should be taken to the "Add new TV show" view. Tapping on the "Show list of added shows" button should take the user the "TV show list" view.
2. In the "Add new TV show" view, once the user entered all the needed information (`Title (String)`, `Year of release (Number)`, `Number of seasons (Number)`) and taps the save button, the information should be sent to the server and saved in the database and the user should be taken back to the first view. In order to do this you need to create a PFObject with the class named "TVShow" and store the title, year of release and number of seasons in columns called "title", "year" and "seasons".
3. The third view ("TV show list") should show a list of all tv shows which are in the database.

### Evaluation

We evaluate your work by the following points:

- Maintainability and testability of your code. You don’t need to write a unittest.
- How fast you can complete the requirements.
- Creativity in terms of implementation & ideas beyond the requirements

### Additional requirenments from the author

- Do not use third-party libraries
  - note: except Parse (required by original requirements) and Swinject (I like it)
- Create not just a test case but create (almost) production ready application
- Update data reactively
- Localize the application
  - note: I used Google translate for German localization so I assume that it's not correct in terms of grammar

## Description

### Introduction

Software development is always a decision making:

- create new screen fast or with good architecture?
- pay technical debt now or in the future?
- write highly abstract or simple code which will be clear to everyone?
- should I use a third-party library and probably bring vendor lock into a project or should I spend time and implement some functionality myself?

And the most interesting thing is that there is no correct answer. All decisions have cons and pros.

My implementation also has its own drawbacks and advantages. The main decision which I made was "What quality of the application I want to reach?". Quality and time spent always go together. And I've decided "Ok. I'll spend more time but will get better quality". And that's it. Implementation of the whole application took around 8 hours. It includes:

- creating base architecture (~ 2 hours)
- implementing of all business logic (~ 4 hours)
- trying to make design nicely (searching for different images, trying different colors, etc.) (~ 2 hours)

All of this was created completely from scratch.

### Project structure

The structure is pretty straightforward and names of groups are self-explanatory:

- `Application` contains all application related classes
- `Components` contains reusable UI components
- `DataLayer` holds data access objects (`NSManagedObject`s in this case) and class for accessing them (`LocalPersistentStore`)
- `Extensions` is just extensions
- `Factories` contains all factories. Tha main manufacture of objects is here
- `Network` holds all related to network
  - Data Transfer Objects
  - Requests
  - Network itself
- `Providers` are data providers. They know from where and how to get a data and provides it to other classes
- `Resources` just holds all application related resources (images, localizable strings, etc.)
- `Router` contains Router(s) which implements different navigation scenarios
- `Storyboards` holds all storyboards
- `SupportingFiles` is just plists, entitlements, etc.
- `ViewControllers` contains all View Controllers. All of them implements VIP architecture.

### Architecture

I've decided to use `VIP` architecture because it has no such overhead like `VIPER` or `Clean Swift` but at the same time it has almost all advantages of the previous ones.

Building blocks of `VIP` are:

- `View` or in our case is `UIViewController`. It manipulates all the views and knows *how* they should looks like. `View` communicates with `Interactor`
- `Interactor` holds all `View` related business logic and commucates with `Presenter`
- `Presenter` is preparing received from `Interactor` data for `View`. In other words it knows *what* to show.

So let's take a look at the VIP modules.

- **AppStart**
  - we should show custom UIViewController ASAP and not to perform long operation in `applicationDidFinishLaunching`. The main responsobility of this module is initializing of all core subsystems of the application
  - `Interactor` receives as dependencies `NetworkInitializer` and `LocalPersistentStoreInitializer` to initialize these subsystems
  - `View` receives as a dependency `Router` to switch to main screen after the initialization will be finished
- **Home**
  - simple module that just shows navigation buttons
  - `View` receives as a dependency `Router` to switch to other screens
- **AddTVShow**
  - `Interactor` receives as a dependency `TVShowProviderCreator` and implements module related business logic (validates data before saving)
  - `View` receives as a dependency `Router` to switch to previous screen. Also it manages state of containing views (enables and disables Save button)
- **WatchedTVShow**
  - `Interactor` receives as dependencies `TVShowProviderData` and `TVShowProviderCreator`. The `...Data` object needed to receive data and pass it to `Presenter`. The `...Creator` object needed to simulate adding of TV show and for the showing how the data is updated *reactively*.
  - `View` shows list of TV shows with a custom Layout (animated) and support *reactively* updating of data without third-party libraries and bringing up vendor lock to the project.

### Further steps

As any other application in the world this one has technical debt too. What should be improved:

- Need to create some of `Synchronization` class which will be responcible for synchronization of data and implementing all business logic related to synchronization, e.g. implementing of retry policy, periodically pulling new data from a server or supporting of pushing of data from the server
- Need to implement better work with CoreData and implement better work with background tasks
- Need to hire a designer and create cool UI :)
