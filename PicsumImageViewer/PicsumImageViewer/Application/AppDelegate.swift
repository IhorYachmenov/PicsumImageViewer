//
//  AppDelegate.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit

/*
The interview test
Consume this public API https://picsum.photos/
written by using Swift above with collection view not SwiftUI
Imagine that this project is part of a really big app that needs long
maintenance. We'll evaluate your coding styles.
List page
- Show auto reload an infinite list of images with a good
collection view layout. (up to your decisions) Tips: don't
load too many photos at the same time.
- Open specific image page while tap
Image page
- It has segmented control button to change image to
normal/blur/grayscale (get these images from API)
- Blur image has a slider to change the blur ratio. And the app
only gets blur images from API.
- Show all image informations eg. author
- Go back to previous page
*/

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, ListScreenDelegate {
    func openImageScreen() {
        //
    }
    
    var window: UIWindow?
    private var appCoordinator : AppCoordinator?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)

        guard let window = window else { return false }
        
        let routerComponents = RouterComponents()
        let appRouter = AppRouter(routerComponents: routerComponents)
        appCoordinator = AppCoordinator(window: window, router: appRouter)
        appCoordinator!.start()

        return true
    }
}

