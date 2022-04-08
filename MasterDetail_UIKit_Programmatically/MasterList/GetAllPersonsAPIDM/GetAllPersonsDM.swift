//
//  GetAllPersonsDM.swift
//
//  Created by rs on 07/04/22
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public final class GetAllPersonsDM: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private struct SerializationKeys {
    static let data = "data"
    static let additionalData = "additional_data"
  }

  // MARK: Properties
  public var data: [DataGetDetailsOfAPerson]?
  public var additionalData: AdditionalData?

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
    if let items = json[SerializationKeys.data].array { data = items.map { DataGetDetailsOfAPerson(json: $0) } }
    additionalData = AdditionalData(json: json[SerializationKeys.additionalData])
  }

  /// Generates description of the object in the form of a NSDictionary.
  ///
  /// - returns: A Key value pair containing all valid values in the object.
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = data { dictionary[SerializationKeys.data] = value.map { $0.dictionaryRepresentation() } }
    if let value = additionalData { dictionary[SerializationKeys.additionalData] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.data = aDecoder.decodeObject(forKey: SerializationKeys.data) as? [DataGetDetailsOfAPerson]
    self.additionalData = aDecoder.decodeObject(forKey: SerializationKeys.additionalData) as? AdditionalData
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(data, forKey: SerializationKeys.data)
    aCoder.encode(additionalData, forKey: SerializationKeys.additionalData)
  }

}
