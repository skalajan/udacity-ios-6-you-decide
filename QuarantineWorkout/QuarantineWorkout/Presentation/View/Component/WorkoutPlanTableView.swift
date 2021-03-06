//
//  WorkoutPlanTableView.swift
//  QuarantineWorkout
//
//  Created by Jan Skála on 18/04/2020.
//  Copyright © 2020 Jan Skála. All rights reserved.
//

import Foundation
import UIKit

class WorkoutPlanTableView: UITableView{
    weak var workoutPlanDelegate: WorkoutPlanTableViewDelegate? = nil
    private var workouts: [Workout] = []
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    func setup(){
        register(UINib(nibName: "WorkoutTableCell", bundle: nil), forCellReuseIdentifier: "WorkoutTableCell")
        
        self.delegate = self
        self.dataSource = self
    }
    
    func updateWorkouts(workouts: [Workout]){
        self.workouts = workouts
        reloadData()
    }
    
}

extension WorkoutPlanTableView: UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}

extension WorkoutPlanTableView: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return workouts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "WorkoutTableCell") as! WorkoutTableCell
        
        let index = indexPath.row
        let workout = workouts[index]
        cell.title.text = workout.name
        cell.position.text = String(index + 1)
        
        var repsText: String = ""
        if workout.type == .reps{
            if let reps = workout.reps{
                repsText = String(reps)
                if reps > 1{
                    repsText = repsText + " reps"
                }else{
                    repsText = repsText + " rep"
                }
            }
        }else if workout.type == .duration || workout.type == .rest{
            repsText = String(workout.duration!) + " s"
        }
        cell.reps.text = repsText
        
        return cell
    }
}

protocol WorkoutPlanTableViewDelegate: class{
    
}
