//
//  AppDelegate.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.setupInitialViewController()
        return true
    }
    
    func setupInitialViewController() {
        if let vcLoginOp = Common.shared.viewController("CategoryViewController", onStoryboard: "Main") as? CategoryViewController {
            let navigationController = UINavigationController(rootViewController: vcLoginOp)
            navigationController.navigationBar.isHidden = true
            self.window?.rootViewController = navigationController
            self.window?.makeKeyAndVisible()
        }
    }
}

//let params : [String : Any] = ["amount":10,"category":11,"difficulty":"easy","type":"multiple"]
//
//Services.callAPI(serverURL: .getQuestionsList(params)) { res in
//    print(res)
//    self.quiz = try? JSONDecoder().decode(CategoryModel.self, from: res)
//} failure: { message in
//
//}

