//
//  Pagination.swift
//
//  Created by rs on 07/04/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class Pagination: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let start = "start"
    static let limit = "limit"
    static let moreItemsInCollection = "more_items_in_collection"
  }

  // MARK: Properties
  public var start: Int?
  public var limit: Int?
  public var moreItemsInCollection: Bool? = false

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
    start = json[SerializationKeys.start].int
    limit = json[SerializationKeys.limit].int
    moreItemsInCollection = json[SerializationKeys.moreItemsInCollection].boolValue
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = start { dictionary[SerializationKeys.start] = value }
    if let value = limit { dictionary[SerializationKeys.limit] = value }
    dictionary[SerializationKeys.moreItemsInCollection] = moreItemsInCollection
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.start = aDecoder.decodeObject(forKey: SerializationKeys.start) as? Int
    self.limit = aDecoder.decodeObject(forKey: SerializationKeys.limit) as? Int
    self.moreItemsInCollection = aDecoder.decodeBool(forKey: SerializationKeys.moreItemsInCollection)
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(start, forKey: SerializationKeys.start)
    aCoder.encode(limit, forKey: SerializationKeys.limit)
    aCoder.encode(moreItemsInCollection, forKey: SerializationKeys.moreItemsInCollection)
  }

}
