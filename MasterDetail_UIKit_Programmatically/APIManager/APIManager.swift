//
//  APIManager.swift
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 06/04/22.
//

import UIKit
import Alamofire
import SwiftyJSON


class APIManager: NSObject {
    
    static let sharedAPIManager = APIManager()
    
    
    
    
    
    
    
    
    
    
    func hitAPIStringParametersAppendURL(_ stringURLToAppend:String, methodType:Alamofire.HTTPMethod, arrayParametersAppendURL:NSMutableArray, hTTPHeaders:HTTPHeaders, parameters:Parameters, isShowActivityIndicator:Bool, isShowErrorPopupIfSuccessFalse:Bool, completionHandlerSuccess:@escaping(_ responseInJSON:JSON) -> Void, completionHandlerFailure:@escaping(_ error:Error?) -> Void) {
        if UtilitySwift.isInternetConnected(isShowPopup:true) {
            if isShowActivityIndicator {
                UtilitySwift.showMBProgressHUD()
            }
            let stingParametersAppendURL = UtilityObjectiveC.getStringToAppendURLForAPI(from:arrayParametersAppendURL)
            let hTTPHeadersTemp: HTTPHeaders = hTTPHeaders
            let parametersTemp = parameters
            print(stingParametersAppendURL as Any)
            print(hTTPHeadersTemp)
            print(parametersTemp)
            
            switch methodType {
            case .get:
                print("get Method")
                AF.request(BASEURL + stringURLToAppend + stingParametersAppendURL, method:.get, parameters:parametersTemp, headers:hTTPHeadersTemp)
                    //                .validate(statusCode: 200..<402) //200 To 401
                    .responseJSON { response in
                        print(response.request as AnyObject)  // original URL request
                        print(response.response as AnyObject) // HTTP URL response
                        print(response.data as AnyObject)     // server data
                        print(response.result)   // result of response serialization
                        print(response.value as Any)
                        print(response.error as Any)
                        
                        let statusCode = response.response?.statusCode
                        
                        switch response.result {
                        case .success(let responseValue):
                            if isShowActivityIndicator {
                                UtilitySwift.hideMBProgressHUD()
                            }
                            
                            let responseInJSON = JSON(responseValue)
                            print(responseInJSON)
                            
                            if (statusCode == 200) {
                                completionHandlerSuccess(responseInJSON)
                            }
                            else {
                                if isShowErrorPopupIfSuccessFalse {
                                    var stringErrorMessage = responseInJSON["error"].string
                                    if (stringErrorMessage == "" || stringErrorMessage == nil) {
                                        stringErrorMessage = String(STRING_ERROR_MESSAGE)
                                    }
                                    UtilitySwift.showToast(stringErrorMessage!)
                                    completionHandlerSuccess(responseInJSON)
                                }
                                else {
                                    completionHandlerSuccess(responseInJSON)
                                }
                            }
                            
                        case .failure(let error):
                            if isShowActivityIndicator {
                                UtilitySwift.hideMBProgressHUD()
                            }
                            print("Error")
                            print(error)
                            print(error.localizedDescription)
                            if isShowErrorPopupIfSuccessFalse {
                                UtilitySwift.showToast(error.localizedDescription)
                                completionHandlerFailure(error)
                            }
                            else {
                                completionHandlerFailure(error)
                            }
                        }
                    }
                
                break
                
            case  .post :
                print("post Method") //JSONEncoding.default and etc., //URLEncoding.default and etc
                AF.request(BASEURL + stringURLToAppend + stingParametersAppendURL, method:.post, parameters:parameters, encoding:JSONEncoding.default, headers:hTTPHeadersTemp)
                    //                .validate(statusCode: 200..<402) //200 To 401
                    .responseJSON { response in
                        print(response.request as AnyObject)  // original URL request
                        print(response.response as AnyObject) // HTTP URL response
                        print(response.data as AnyObject)     // server data
                        print(response.result)   // result of response serialization
                        print(response.value as Any)
                        print(response.error as Any)
                        
                        if let status = response.response?.statusCode {
                            switch(status){
                            case 200:
                                print("example success")
                            default:
                                print("error with response status: \(status)")
                            }
                        }
                        
                        switch response.result {
                        case .success(let responseValue):
                            if isShowActivityIndicator {
                                UtilitySwift.hideMBProgressHUD()
                            }
                            let responseInJSON = JSON(responseValue)
                            print(responseInJSON)
                            if (responseInJSON["errCode"] == -1) {
                                completionHandlerSuccess(responseInJSON)
                            }
                            else {
                                if isShowErrorPopupIfSuccessFalse {
                                    var stringErrorMessage = responseInJSON["errMsg"].string
                                    if (stringErrorMessage == "" || stringErrorMessage == nil) {
                                        stringErrorMessage = String(STRING_ERROR_MESSAGE)
                                    }
                                    print(stringErrorMessage as Any)
                                    UtilitySwift.showToast(stringErrorMessage!)
                                    completionHandlerSuccess(responseInJSON)
                                }
                                else {
                                    completionHandlerSuccess(responseInJSON)
                                }
                            }
                            
                        case .failure(let error):
                            if isShowActivityIndicator {
                                UtilitySwift.hideMBProgressHUD()
                            }
                            print("Error")
                            print(error)
                            print(error.localizedDescription)
                            if isShowErrorPopupIfSuccessFalse {
                                UtilitySwift.showToast(error.localizedDescription)
                                completionHandlerFailure(error)
                            }
                            else {
                                completionHandlerFailure(error)
                            }
                        }
                    }
                break
                
            case  .delete :
                break
                
            case  .put :
                break
                
            default:
                print("default")
                
            }
        }
    }
    
}
