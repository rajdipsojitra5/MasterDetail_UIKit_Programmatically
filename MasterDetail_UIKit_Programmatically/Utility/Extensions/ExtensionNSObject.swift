//
//  ExtensionNSObject.swift
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 08/04/22.
//

import Foundation


extension NSObject {
    var stringClassName: String {
        return String(describing: type(of: self))
    }
    
    class var stringClassName: String {
        return String(describing: self)
    }
}
