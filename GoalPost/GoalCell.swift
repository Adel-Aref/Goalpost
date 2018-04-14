//
//  GoalCell.swift
//  GoalPost
//
//  Created by Have a Mission on 4/5/18.
//  Copyright © 2018 Have a Mission. All rights reserved.
//

import UIKit

class GoalCell: UITableViewCell {

    @IBOutlet weak var laGoalDescription: UILabel!
    @IBOutlet weak var laGoalType: UILabel!
    @IBOutlet weak var laGoalProgress: UILabel!
    
    /// func configure
    func configureCell(goal :Goal)
    {
        self.laGoalDescription.text = goal.goalDescription
        self.laGoalType.text = goal.goalType
        self.laGoalProgress.text = String(describing: goal.goalProgress)
    }
}
