//
//  ExtensionUserDefaults.swift
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 08/04/22.
//

import UIKit
import SwiftyJSON


extension UserDefaults {
    
    enum UserDefaultsKeys : String {
        case arrayDataGetDetailsOfAPerson
    }
    
    
    
    
    
    
    
    
    
    
    func setArrayDataGetDetailsOfAPerson(_ arrayDataGetDetailsOfAPerson: [DataGetDetailsOfAPerson]) {
        var arrayTemp = [[String: Any]]()
        for i in 0..<arrayDataGetDetailsOfAPerson.count {
            arrayTemp.append(arrayDataGetDetailsOfAPerson[i].dictionaryRepresentation())
        }
        set(arrayTemp, forKey: UserDefaultsKeys.arrayDataGetDetailsOfAPerson.rawValue)
    }
    
    
    func getArrayDataGetDetailsOfAPerson() -> [DataGetDetailsOfAPerson] {
        var arrayDataGetDetailsOfAPerson = [DataGetDetailsOfAPerson]()
        
        let arrayTemp: [[String: Any]] = object(forKey: UserDefaultsKeys.arrayDataGetDetailsOfAPerson.rawValue) as? [[String : Any]] ?? []
        if (arrayTemp.count > 0) {
            for i in 0..<arrayTemp.count {
                let dataGetDetailsOfAPerson = DataGetDetailsOfAPerson(object: arrayTemp[i])
                arrayDataGetDetailsOfAPerson.append(dataGetDetailsOfAPerson)
            }
        }
        return arrayDataGetDetailsOfAPerson
    }
    
    
    func removeArrayDataGetDetailsOfAPerson() {
        removeObject(forKey: UserDefaultsKeys.arrayDataGetDetailsOfAPerson.rawValue)
    }
    
}
