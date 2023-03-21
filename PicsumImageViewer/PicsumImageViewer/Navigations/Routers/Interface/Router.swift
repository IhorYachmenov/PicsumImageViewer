//
//  Router.swift
//  PicsumImageViewer
//
//  Created by user on 21.03.2023.
//

import UIKit
// MARK: - Router Components
class RouterComponents {
    fileprivate let navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
}

// MARK: - App Coordinator
extension AppCoordinator {
    func setupWindow() {
        window.rootViewController = router.routerComponents.navigationController
        window.makeKeyAndVisible()
    }
}


protocol Router: AnyObject {
    var routerComponents: RouterComponents { get }
    
    func present(_ viewController: UIViewController, animated: Bool)
    func dismiss(animated: Bool, completion: (() -> Void)?)
    func push(_ viewController: UIViewController, animated: Bool)
    func pop(animated: Bool)
}

// MARK: - Router Extension
extension Router {
    func present(_ viewController: UIViewController, animated: Bool) {
        if (routerComponents.navigationController.presentedViewController != nil) {
            let presendViewController = routerComponents.navigationController.presentedViewController
            presendViewController?.present(viewController, animated: true)
            return
        }
        routerComponents.navigationController.present(viewController, animated: animated, completion: nil)
    }
    
    func dismiss(animated: Bool, completion: (() -> Void)?) {
        routerComponents.navigationController.dismiss(animated: animated) {
            completion?()
        }
    }
    
    func push(_ viewController: UIViewController, animated: Bool) {
        if (routerComponents.navigationController.presentedViewController != nil) {
            let childNavigationController = routerComponents.navigationController.presentedViewController as? UINavigationController
            childNavigationController?.pushViewController(viewController, animated: true)
            return
        }
        routerComponents.navigationController.pushViewController(viewController, animated: animated)
    }
    
    func pop(animated: Bool) {
        // Exist capability to add pop to the root or not UINavigationController
        //        if (navigationController.presentedViewController != nil) {
        //            let childNavigationController = navigationController.presentedViewController as? UINavigationController
        //            childNavigationController?.popViewController(animated: animated)
        //            return
        //        }
        routerComponents.navigationController.popViewController(animated: animated)
    }
}
