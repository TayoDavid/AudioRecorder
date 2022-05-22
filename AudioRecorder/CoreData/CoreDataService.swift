//
//  CoreDataService.swift
//  AudioRecorder
//
//  Created by Omotayo on 22/05/2022.
//

import UIKit
import CoreData

enum CoreDataState {
    case save, load
}

class CoreDataService {
    
    static let shared = CoreDataService()
    
    private init() {}
    
    lazy var recordedData: [Recorded] = []
    
    func numberOfItems() -> Int {
        return recordedData.count
    }
    
    func appViewContext() -> NSManagedObjectContext {
        return (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    }
    
    private func shouldLoadCoreData() {
        
        let fetchRequest: NSFetchRequest<Recorded> = Recorded.fetchRequest()
        fetchRequest.sortDescriptors = [
            NSSortDescriptor(key: #keyPath(Recorded.date), ascending: false)
        ]
        
        do {
            recordedData = try appViewContext().fetch(fetchRequest)
        } catch let error as NSError {
            print(error)
        }
    }
    
    private func shouldSaveCoreDataObject() {
        
        do {
            try appViewContext().save()
        } catch let error as NSError {
            print(error)
        }
        
    }
    
    func currentCoreData(state: CoreDataState) {
        switch state {
            case .save: shouldSaveCoreDataObject()
            case .load: shouldLoadCoreData()
        }
    }
    
}
