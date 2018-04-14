//
//  FinishGoalVC.swift
//  GoalPost
//
//  Created by Have a Mission on 4/5/18.
//  Copyright © 2018 Have a Mission. All rights reserved.
//

import UIKit
import CoreData

class FinishGoalVC: UIViewController , UITextFieldDelegate{

    @IBOutlet weak var BtnCreateGoal: UIButton!
    @IBOutlet weak var txtPoints: UITextField!
    
   var goalDescription: String!
    var goalType: GoalType!
    // initData func
    func initData(description:String , type: GoalType)
    {
            self.goalDescription = description
            self.goalType = type
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        BtnCreateGoal.bindToKeyboard()
        txtPoints.delegate = self
    }
    @IBAction func BtnCreateGoalWsPressed(_ sender: Any) {
        // Pass data into core data here
        if txtPoints.text != ""
        {
            self.save {(complete) in
                if complete
                {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func BtnBackButtonWasPressed(_ sender: Any) {
        dissmisDetail()
    }
    func save(completion:(_ finished: Bool) -> ())
    {
        guard  let mangedContext = appDelegate?.persistentContainer.viewContext else {return}
        let goal = Goal(context: mangedContext)
        goal.goalDescription = goalDescription
        goal.goalType = goalType.rawValue
        goal.goalCompletionValue = Int32(txtPoints.text!)!
        goal.goalProgress = Int32(0)
        
        do{
            try mangedContext.save()
            completion (true)
            print("sucessfully sava data")
        }
        catch{
            debugPrint("debuge error \(error.localizedDescription)")
            completion(false)
        }
    }
    // End of the class
}
