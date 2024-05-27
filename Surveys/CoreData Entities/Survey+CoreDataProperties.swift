//
//  Survey+CoreDataProperties.swift
//  Surveys
//
//  Created by Nizaam Haffejee on 2024/05/27.
//
//

import Foundation
import CoreData


extension Survey {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Survey> {
        return NSFetchRequest<Survey>(entityName: "Survey")
    }

    @NSManaged public var fullName: String?
    @NSManaged public var email: String?
    @NSManaged public var birthDate: Date?
    @NSManaged public var contactNumber: String?
    @NSManaged public var foodPreference: String?
    @NSManaged public var watchMovies: String?
    @NSManaged public var listenRadio: String?
    @NSManaged public var eatOut: String?
    @NSManaged public var watchTelevision: String?

}

extension Survey : Identifiable {

}
