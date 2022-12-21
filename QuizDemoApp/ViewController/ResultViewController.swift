//
//  AnswerViewController.swift
//  QuizDemoApp
//
//  Created by hiren  mistry on 20/12/22.
//

import UIKit

class ResultViewController: UIViewController {
    @IBOutlet weak var lblEmoji: UILabel!
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    
    var correctAnswer: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initView()
        // Do any additional setup after loading the view.
    }
    
    //MARK: functions
    func initView() {
        self.lblResult.text = correctAnswer > 6 ? "CONGRATULATIONS!!" : "OOPS!!"
        self.lblScore.text = "Your Score: \(correctAnswer)/10"
        self.lblEmoji.text = correctAnswer > 6 ? "😍" : "🥺"
    }
    
    @IBAction func btnHomeClick(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
