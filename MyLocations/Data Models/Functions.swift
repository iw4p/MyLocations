//
//  Functions.swift
//  MyLocations
//
//  Created by Nima Akbarzade on 11/12/1397 AP.
//  Copyright © 1397 AP Nima Akbarzade. All rights reserved.
//

import Foundation

func afterDelay(_ seconds: Double, run: @escaping () -> Void) {
    DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: run)
}

let applicationDocumentsDirectory: URL = {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
                                         return paths[0]
}()

let CoreDataSaveFailedNotification =
    Notification.Name(rawValue: "CoreDataSaveFailedNotification")
func fatalCoreDataError(_ error: Error) {
    print("*** Fatal error: \(error)")
    NotificationCenter.default.post(name: CoreDataSaveFailedNotification, object: nil)

}
