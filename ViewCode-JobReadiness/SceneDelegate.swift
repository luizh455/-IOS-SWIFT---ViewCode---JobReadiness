//
//  SceneDelegate.swift
//  ViewCode-JobReadiness
//
//  Created by Luiz Henrique Lage Da Silva on 03/07/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        let tabBarViewController = UITabBarController()
        
        let homeViewController = UINavigationController(rootViewController: HomeViewController())
        let favoritesViewController = UINavigationController(rootViewController: FavoritesViewController())
        let shopsViewController = UINavigationController(rootViewController: EmptyViewController())
        let notificationsViewController = UINavigationController(rootViewController: EmptyViewController())
        let moreViewController = UINavigationController(rootViewController: EmptyViewController())
        
        homeViewController.title = "Inicio"
        favoritesViewController.title = "Favoritos"
        shopsViewController.title = "Compras"
        notificationsViewController.title = "Notificações"
        moreViewController.title = "Mais"
        
        tabBarViewController.setViewControllers([homeViewController, favoritesViewController, shopsViewController, notificationsViewController, moreViewController], animated: false)
        
        guard let tabBarItems = tabBarViewController.tabBar.items else {
            return
        }
        
        let images = ["house", "heart", "bag", "bell", "line.3.horizontal"]
        for itemIndex in 0..<tabBarItems.count{
            tabBarItems[itemIndex].image = UIImage(systemName: images[itemIndex])
        }
        
        configureTabAndNavBar()
        
        
        let window = UIWindow(windowScene: windowScene)
        
            
        
        
        window.rootViewController = tabBarViewController

        self.window = window
        window.makeKeyAndVisible()
    }
    
    func configureTabAndNavBar(){
        
        let tabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithOpaqueBackground()
        UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
        
        let navigationBarAppearance = UINavigationBarAppearance()
        navigationBarAppearance.configureWithOpaqueBackground()
        UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
        let appearance = UINavigationBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .systemYellow
                UINavigationBar.appearance().standardAppearance = appearance
                UINavigationBar.appearance().scrollEdgeAppearance = appearance
                UINavigationBar.appearance().tintColor = .black

    }
    

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

