//
//  TabBarController.swift
//  Navigation
//
//  Created by Юлия Самсонова on 27.02.2022.
//

import UIKit

class TabBarController: UITabBarController {


    private enum TabBarItem {
        case feed
        case profile

        var title: String {
            switch self {
            case .feed:
                return "Лента"
            case .profile:
                return "Профиль"
            }
        }

        var image: UIImage? {
            switch self {
            case .feed:
                return UIImage(systemName: "newspaper")
            case .profile:
                return UIImage(systemName: "person.circle")
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupTabBar()
    }

    func setupTabBar() {
        let tabBarItems: [TabBarItem] = [.feed, .profile]

        self.viewControllers = tabBarItems.map ({ tabBarItem in
            switch tabBarItem {
            case .feed:
                return UINavigationController(rootViewController: FeedViewController())
            case .profile:
                return UINavigationController(rootViewController: ProfileViewController())
            }
        })


        self.viewControllers?.enumerated().forEach({ (index, vc) in
            vc.tabBarItem.title = tabBarItems[index].title
            vc.tabBarItem.image = tabBarItems[index].image
        })
    }
}
