# ThuanVuNotes

## Project Overview

In this project, I want to create a simple note application that allows users to save a note and share notes with other users.<br />
It has several CRUD features to practice with swiftUI, Combine, and Firebase.<br />
About the share notes feature, I allow users to use the application without requiring them to sign in. They can set their username to let other users know them.

## Features

- Create, update, soft delete, and recover a note.
- View my notes and other users' notes.
- Share my notes with other users.
- See the details of other users' notes.
- Set the username.

## User interface design

About the user interface design, I want to build a simple user interface like the default notes application on iOS devices.
### Main screen
<div>
  <image src="/Documents/Screenshots/My_note_list.png" alt="My note list" width="250" />
  <image src="/Documents/Screenshots/Other_users_note_list.png" alt="Other users' note list" width="250" />
  <image src="/Documents/Screenshots/Search_note.png" alt="Search note list" width="250" />
</div>
<br />
The main view is the note list screen.<br />
When the application starts, the user's list of notes will appear and the user can see a shortcut for each note.<br />
In this screen, the user can see the other users' notes by switching the owner options segment picker (myself or other users) at the middle bottom of the screen. And search notes by search bar on the top view.<br />
On the "my self" mode:

- Each note item in the list has an icon on the right side, which means its shared state. The user can tap on that icon to change the shared state.<br />
- When the user taps on the note item, the update note screen will appear so that the user can edit the note.<br />
- The user can swipe from right to left on the note item to delete it.<br />

On the "other users" mode:

- When the user taps on the note item, the detail note screen will appear so that the user can see all other user note's content.<br />

<div>
  <image src="/Documents/Screenshots/Update_a_note.png" alt="Update a note" width="250" />
  <image src="/Documents/Screenshots/Delete_note.png" alt="Update a note" width="250" />
  <image src="/Documents/Screenshots/Note_detail.png" alt="Note detail" width="250" />
</div>

### Set the username

To set the username, the user can tap the person icon at the top right corner of the screen. If the user has set the username, it will appear next to the person icon.
The popup of the set username will appear, the user can edit the username here.

<image src="/Documents/Screenshots/Change_username.png" alt="Note detail" width="250" />

### Create/update note
<div>
  <image src="/Documents/Screenshots/Create_a_note.png" alt="Create a note" width="250" />
  <image src="/Documents/Screenshots/Update_a_note.png" alt="Update a note" width="250" />
</div>
<br />
To create a new note, the user can tap on the create button (the button with the square and pencil icon) at the bottom right corner, and then the create note screen will appear.<br />
Or when the user taps on the note item to edit.<br />
On this screen, there are a big text editor so the user can enter the note's content and a save button at the bottom right corner. When the user is finished taking the note, the user can tap the save button to complete and back to the previous screen.

### Trash

<div>
  <image src="/Documents/Screenshots/Trash.png" alt="Trash" width="250" />
  <image src="/Documents/Screenshots/Recover_note.png" alt="Recover a note" width="250" />
</div>
<br />
If the user wants to see the deleted notes, the user can tap the trash button at the left bottom corner of the note list screen. when the deleted note list appears, the user can swipe from right to left to a note item to recover the note.
    
## Technology stack

- SwiftUI:<br />
    SwiftUI is a user interface toolkit developed by Apple for building applications across its various platforms, including iOS, macOS, watchOS, and tvOS. It offers a modern, Swift-based syntax, simplifying UI development with features like live preview, data binding, and seamless cross-platform compatibility.
    All views of this application are built by swiftUI.

- Combine:<br />
    Combine is Apple's framework for reactive programming in Swift. It provides a declarative Swift API for handling asynchronous and event-driven code, enabling developers to work with streams of values over time using a functional and reactive paradigm.<br />
    I have used Combine to transform data between the repository and view model easily.

- Firebase realtime database:<br />
    Firebase Realtime Database is a NoSQL cloud database by Google, offering real-time data synchronization across multiple devices. With a JSON data structure, it supports seamless offline access, and CRUD operations, and integrates effortlessly with other Firebase services, providing scalable and secure data storage.<br />
    I have used Firebase Realtime Database to allow users to save data locally and automatically synchronize to remote.<br />
    Database structure:
    <p align="center">
      <image src="/Documents/database.png" alt="Database"/>
    </p>

    And Remote data structure like:
    ```json
        {
          "notes": {
            "3BF7D29E-FE34-4DC1-B17E-258EA9735E54": {
              "content": "Five Keys to Safer Food\nKey 1: Keep clean.\nKey 2: Separate raw and cooked.\nKey 3: Cook completely.\nKey 4: Keep food at safe temperatures.\nKey five: Use safe water and safe raw materials.",
              "createdAt": 723273329.615546,
              "id": "3BF7D29E-FE34-4DC1-B17E-258EA9735E54",
              "ownerId": "PF9A0Wz1bDPHUCMWjbQAkABHhQh1",
              "shared": true,
              "updatedAt": 723273358.136751
            },
            "C4DE8087-08CF-4936-8AF5-CFF2701C96F0": {
              "content": "Why do we make Christmas cookies?\nhttps://spotlightenglish.com/how-to-learn-english/why-do-we-make-christmas-cookies/",
              "createdAt": 723272168.788571,
              "id": "C4DE8087-08CF-4936-8AF5-CFF2701C96F0",
              "ownerId": "7S6DufwmWmdCCJh6fg99X2lFN2H2",
              "shared": true,
              "updatedAt": 723272168.788571
            }
          },
          "users": {
            "NX6IFwDCafh5aMyE6GdzxC7Kg3R2": {
              "id": "NX6IFwDCafh5aMyE6GdzxC7Kg3R2",
              "username": "iPhone 15"
            },
            "PF9A0Wz1bDPHUCMWjbQAkABHhQh1": {
              "id": "PF9A0Wz1bDPHUCMWjbQAkABHhQh1",
              "username": "Thuận iPhone "
            }
          }
        }
    ```

- Firebase Anonymously Authentication:<br />
    Firebase Anonymous Authentication allows users to access Firebase services without requiring them to sign in with identifiable information. Users are assigned a temporary unique identifier, granting them limited, anonymous access to features like data storage and retrieval. <br />
    I used Firebase Anonymously Authentication to identify the user.

## Architecture

In this project, I have implemented the MVVM architecture and the observable pattern. Here is the architectural diagram.
<p align="center">
  <image src="/Documents/MVVM-Architecture.png" alt="MVVM architecture"/>
</p>
With this architecture and this pattern, I will have some benefits to develop the project:
- The MVVM architecture excels in providing a clear separation of concerns among the Model, View, and ViewModel components. This separation has some benefits:
    - The codebase is modular and easier to maintain.
    - I can easily create unit tests that verify the correctness logic of the ViewModel layer.
- The ViewModel can notify the View of changes in the data, I create a responsive user interface that dynamically adapts to the latest information.
- As users engage with the application, the ViewModel reacts to these events, updating the data and notifying the View for immediate visual feedback

## Development process

I spent about 24 hours to complete all phases of this application. During this time, I have a chance to improve my old skills and practice my new skills.<br />
I created UI by SwiftUI and I had the experience to develop with the MVVM architecture in Swiftui, which made me easily build the architecture and the user interface of the application.
About the Firebase, it's easy to install and configure to the project. But in the step of parsing JSON data of the database, I spent a lot of time researching a way to parse data more easily. Finally, I have found a way to automatically parse data, which helped me save a lot of lines of code.<br />
Although the development process had a few minor difficulties, my project was still completed according to my expectations.

## Testing

This is the first time, I'm going to create a unit test for a project, I've tried to implement it but I don't have any good idea to run the test effectively, I want to test with data but it is not ideal to test with Firebase. So I only tested the manual on this project.

[Here is the test video](/Documents/Screenshots/Test_application.mov)

## Checklist completed

#### Project overview:
- [x] Brief introduction to the note application
#### Features:
- [x] List of main features
#### Technology stack:
- [x] Detailed list of technologies and tools used.
- [x] Programming languages, frameworks, databases, etc.
#### Architecture:
- [x] Overview of the overall architecture.
- [x] Descriptions of how components/modules interact.
- [x] Diagrams or visual aids illustrating the architecture.
#### User interface design:
- [x] Screenshots or wireframes showcasing UI.
- [x] Explanation of design choices.
#### Development process:
- [x] Overview of the development lifecycle.
- [x] Mention of methodologies or frameworks used.
#### Testing:
- [x] Description of the testing process.
- [ ] Implement unit test
