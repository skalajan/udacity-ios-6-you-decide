//
//  WorkoutResultViewModel.swift
//  QuarantineWorkout
//
//  Created by Jan Skála on 17/04/2020.
//  Copyright © 2020 Jan Skála. All rights reserved.
//

import Foundation

class WorkoutResultViewModel : BaseViewModel{
    let finishedPlan =  ObservableProperty<FinishedPlan>()
    let finishedWorkouts = ObservableProperty<[Workout]>()
    
    init(finishedPlan: FinishedPlan?) {
        self.finishedPlan.setValue(finishedPlan)
        
        self.finishedWorkouts.setValue(
            finishedPlan?.workouts?.allObjects
                .sorted(by: { (f1, f2) -> Bool in
                    let finished1 = f1 as! FinishedWorkout
                    let finished2 = f2 as! FinishedWorkout
                    
                    return finished1.itemIndex < finished2.itemIndex
                })
                .map({ (finished) -> Workout in return Workout.fromFinishedWorkout(finishedWorkout: finished as! FinishedWorkout)})
        )
    }
    
}
