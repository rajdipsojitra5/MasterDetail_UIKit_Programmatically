//
//  AdditionalData.swift
//
//  Created by rs on 07/04/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class AdditionalData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let pagination = "pagination"
  }

  // MARK: Properties
  public var pagination: Pagination?

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
    pagination = Pagination(json: json[SerializationKeys.pagination])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = pagination { dictionary[SerializationKeys.pagination] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.pagination = aDecoder.decodeObject(forKey: SerializationKeys.pagination) as? Pagination
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(pagination, forKey: SerializationKeys.pagination)
  }

}
