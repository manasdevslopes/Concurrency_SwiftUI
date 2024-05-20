//
//  ConcurrencyApp.swift
//  Concurrency
//
//  Created by MANAS VIJAYWARGIYA on 13/05/24.
//

import SwiftUI

@main
struct ConcurrencyApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

// MARK: - Concurrency - Trying to do multiple things at the same exact time.

/*
 How Concurrency handled in Swift by using DispatchQueue.
 
 Grand Central Dispatch (GCD)
 1. UserInterface is part of main thread (also know as UI Thread). This UI Thread is Searial Queue - means the event comes in that order it is processed (First In First Out).
 2. Another type of Queue which can run Concurrently.
 3. Global Queue have diff priority settings -
   a. User Interactive - This is a type of quality of service(qos) such as animations, event handling or updating your apps interface.
   b. User Initiated - This is a type of qos for task prevent the user from actively using your app.
   c. Default - This is going to take a decision on your behalf in selecting the default or whatever kind of qos for the priority.
   d. Utility - This qos is for task that the user doesn't track actively.
   e. Background - Task to be done in the Background like updating something in the background & cleanup type of the task.
   f. Unspecified - There is no qos or priority setting that you defined.
 
 */

/*
 Now, Creating a Serial Queue
 let queue = DispatchQueue(label: "SerialQueue")
 queue.async {
   // This task is executed first. When it finishes, then second task starts
 }
 
 queue.async {
   // This task is executed second
 }
 */

/*
 Now, Creating a Concurrent Queue
 let queue = DispatchQueue(label: "ConcurrentQueue", attributes: .concurrent)
 queue.async { }
 
 queue.async { }
 
 // Tasks will start in the order they are added but they can finish in any order.
 */

/*
 Now, Creating a Baclground Queue
 DispatchQueue.global().async {
   // download the image
 
   DispatchQueue.main.async {
     // refresh the UI 
   }
 }
 */

/*
 Structured Concurrency
 
 1. Async Let - async let
 2. Task Group - group.addTask
 3. Unstructured Tasks - Calling ASync Func in non-async environment. For Eg - Calling async func in Button Action.
 Eg - Button {
 Task {
 await asyncFunc()
 }
 }
 4. Detached Tasks - when particular detached Task is not really going to be inheriting anything from their parent which includ priorities, task locals everything
 func updateUI() async {
     let thumbnails = await fetchThumbnails()
     Task.detached(priority: .background) {
         writeToCache(images: thumbnails)
     }
 }
 
 5. Task Cancellation - Task.checkCancellation()
 */

/*
 Async Sequence -
 
 */
