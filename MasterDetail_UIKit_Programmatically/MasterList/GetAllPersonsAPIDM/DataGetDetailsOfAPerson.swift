//
//  DataGetDetailsOfAPerson.swift
//
//  Created by rs on 07/04/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class DataGetDetailsOfAPerson: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let id = "id"
    static let label = "label"
    static let name = "name"
    static let ownerName = "owner_name"
    static let openDealsCount = "open_deals_count"
    static let email = "email"
    static let closedDealsCount = "closed_deals_count"
    static let orgName = "org_name"
    static let firstChar = "first_char"
    static let firstName = "first_name"
    static let nextActivityDate = "next_activity_date"
    static let phone = "phone"
  }

  // MARK: Properties
  public var id: Int?
  public var label: Int?
  public var name: String?
  public var ownerName: String?
  public var openDealsCount: Int?
  public var email: [Email]?
  public var closedDealsCount: Int?
  public var orgName: String?
  public var firstChar: String?
  public var firstName: String?
  public var nextActivityDate: String?
  public var phone: [Phone]?

  // MARK: SwiftyJSON Initializers
  /// Initiates the instance based on the object.
  ///
  /// - parameter object: The object of either Dictionary or Array kind that was passed.
  /// - returns: An initialized instance of the class.
  public convenience init(object: Any) {
    self.init(json: JSON(object))
  }

  /// Initiates the instance based on the JSON that was passed.
  ///
  /// - parameter json: JSON object from SwiftyJSON.
  public required init(json: JSON) {
    id = json[SerializationKeys.id].int
    label = json[SerializationKeys.label].int
    name = json[SerializationKeys.name].string
    ownerName = json[SerializationKeys.ownerName].string
    openDealsCount = json[SerializationKeys.openDealsCount].int
    if let items = json[SerializationKeys.email].array { email = items.map { Email(json: $0) } }
    closedDealsCount = json[SerializationKeys.closedDealsCount].int
    orgName = json[SerializationKeys.orgName].string
    firstChar = json[SerializationKeys.firstChar].string
    firstName = json[SerializationKeys.firstName].string
    nextActivityDate = json[SerializationKeys.nextActivityDate].string
    if let items = json[SerializationKeys.phone].array { phone = items.map { Phone(json: $0) } }
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = id { dictionary[SerializationKeys.id] = value }
    if let value = label { dictionary[SerializationKeys.label] = value }
    if let value = name { dictionary[SerializationKeys.name] = value }
    if let value = ownerName { dictionary[SerializationKeys.ownerName] = value }
    if let value = openDealsCount { dictionary[SerializationKeys.openDealsCount] = value }
    if let value = email { dictionary[SerializationKeys.email] = value.map { $0.dictionaryRepresentation() } }
    if let value = closedDealsCount { dictionary[SerializationKeys.closedDealsCount] = value }
    if let value = orgName { dictionary[SerializationKeys.orgName] = value }
    if let value = firstChar { dictionary[SerializationKeys.firstChar] = value }
    if let value = firstName { dictionary[SerializationKeys.firstName] = value }
    if let value = nextActivityDate { dictionary[SerializationKeys.nextActivityDate] = value }
    if let value = phone { dictionary[SerializationKeys.phone] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.id = aDecoder.decodeObject(forKey: SerializationKeys.id) as? Int
    self.label = aDecoder.decodeObject(forKey: SerializationKeys.label) as? Int
    self.name = aDecoder.decodeObject(forKey: SerializationKeys.name) as? String
    self.ownerName = aDecoder.decodeObject(forKey: SerializationKeys.ownerName) as? String
    self.openDealsCount = aDecoder.decodeObject(forKey: SerializationKeys.openDealsCount) as? Int
    self.email = aDecoder.decodeObject(forKey: SerializationKeys.email) as? [Email]
    self.closedDealsCount = aDecoder.decodeObject(forKey: SerializationKeys.closedDealsCount) as? Int
    self.orgName = aDecoder.decodeObject(forKey: SerializationKeys.orgName) as? String
    self.firstChar = aDecoder.decodeObject(forKey: SerializationKeys.firstChar) as? String
    self.firstName = aDecoder.decodeObject(forKey: SerializationKeys.firstName) as? String
    self.nextActivityDate = aDecoder.decodeObject(forKey: SerializationKeys.nextActivityDate) as? String
    self.phone = aDecoder.decodeObject(forKey: SerializationKeys.phone) as? [Phone]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(id, forKey: SerializationKeys.id)
    aCoder.encode(label, forKey: SerializationKeys.label)
    aCoder.encode(name, forKey: SerializationKeys.name)
    aCoder.encode(ownerName, forKey: SerializationKeys.ownerName)
    aCoder.encode(openDealsCount, forKey: SerializationKeys.openDealsCount)
    aCoder.encode(email, forKey: SerializationKeys.email)
    aCoder.encode(closedDealsCount, forKey: SerializationKeys.closedDealsCount)
    aCoder.encode(orgName, forKey: SerializationKeys.orgName)
    aCoder.encode(firstChar, forKey: SerializationKeys.firstChar)
    aCoder.encode(firstName, forKey: SerializationKeys.firstName)
    aCoder.encode(nextActivityDate, forKey: SerializationKeys.nextActivityDate)
    aCoder.encode(phone, forKey: SerializationKeys.phone)
  }

}
