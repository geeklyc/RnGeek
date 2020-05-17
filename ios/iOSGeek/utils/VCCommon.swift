//
//  VCCommon.swift
//  iOSGeek
//
//  Created by liyoucheng on 2020/5/14.
//  Copyright © 2020年 geeklyc. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    static func findBestViewController(vc: UIViewController?) -> UIViewController? {
        guard let newVc = vc else {
            return nil;
        }
        if ((newVc.presentedViewController) != nil) {
            // presented
            return UIViewController.findBestViewController(vc: newVc.presentedViewController);
        } else if (newVc.isKind(of: UISplitViewController.self)) {
            /// hand side
            let svc = newVc as! UISplitViewController;
            if (svc.viewControllers.count > 0) {
                return UIViewController.findBestViewController(vc: svc.viewControllers.last);
            }
            return newVc;
        } else if (newVc.isKind(of: UINavigationController.self)) {
            // top view
            let nav = newVc as! UINavigationController;
            if (nav.viewControllers.count > 0) {
                return UIViewController.findBestViewController(vc: nav.topViewController);
            }
            return newVc;
        } else if (newVc.isKind(of: UITabBarController.self)) {
            // visible
            let tab = newVc as! UITabBarController;
            if (tab.viewControllers?.count ?? 0 > 0) {
                return UIViewController.findBestViewController(vc: tab.selectedViewController);
            }
            return newVc;
        }
        return newVc;
        
    }
    
    static func currentViewController() -> UIViewController? {
        let viewController = UIApplication.shared.keyWindow?.rootViewController;
        return UIViewController.findBestViewController(vc: viewController);
    }
}
