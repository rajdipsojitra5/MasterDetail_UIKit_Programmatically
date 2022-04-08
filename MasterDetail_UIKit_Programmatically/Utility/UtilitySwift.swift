//
//  UtilitySwift.swift
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 06/04/22.
//

import UIKit
import SystemConfiguration
import Toast_Swift


class UtilitySwift: NSObject {
    
    public static var mBProgressHUD = MBProgressHUD()
    
    
    
    
    
    
    
    
    
    
    //MARK:-
    @objc class func isInternetConnected(isShowPopup: Bool) -> Bool {
        var zeroAddress = sockaddr_in()
        zeroAddress.sin_len = UInt8(MemoryLayout.size(ofValue: zeroAddress))
        zeroAddress.sin_family = sa_family_t(AF_INET)
        
        let defaultRouteReachability = withUnsafePointer(to: &zeroAddress) {
            $0.withMemoryRebound(to: sockaddr.self, capacity: 1) {zeroSockAddress in
                SCNetworkReachabilityCreateWithAddress(nil, zeroSockAddress)
            }
        }
        var flags = SCNetworkReachabilityFlags()
        if !SCNetworkReachabilityGetFlags(defaultRouteReachability!, &flags) {
            if (isShowPopup) {
                self.showAlertControllerOrNotWithOKButtonActionCompletionHandler(STRING_CHECK_INTERNET_TITLE, STRING_CHECK_INTERNET_MESSAGE, true, completionHandlerForOKButtonAction: {
                })
            }
            return false
        }
        let isReachable = (flags.rawValue & UInt32(kSCNetworkFlagsReachable)) != 0
        let needsConnection = (flags.rawValue & UInt32(kSCNetworkFlagsConnectionRequired)) != 0
        
        if (isReachable && !needsConnection) == false{
            if (isShowPopup) {
                self.showAlertControllerOrNotWithOKButtonActionCompletionHandler(STRING_CHECK_INTERNET_TITLE, STRING_CHECK_INTERNET_MESSAGE, true, completionHandlerForOKButtonAction: {
                })
            }
        }
        return (isReachable && !needsConnection)
    }
    
    
    @objc class func showAlertControllerOrNotWithOKButtonActionCompletionHandler(_ stringTitle: String, _ stringMessage: String, _ boolShowAlert: Bool, completionHandlerForOKButtonAction: @escaping () -> Void) {
        if boolShowAlert {
            var topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
            while ((topController.presentedViewController) != nil){
                topController = topController.presentedViewController!
            }
            let alertController = UIAlertController(title: stringTitle, message: stringMessage, preferredStyle: UIAlertController.Style.alert)
            
            let alertActionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                //Just dismiss the action sheet
                print("OK")
                completionHandlerForOKButtonAction()
            }
            alertController.addAction(alertActionOk)
            topController.present(alertController, animated:true, completion:nil)
        }
    }
    
    
    @objc class func showToast(_ stringMessage:String) {
        DispatchQueue.main.async {
            var viewObj = UIView()
            var topController = UIApplication.shared.keyWindow!.rootViewController!
            while ((topController.presentedViewController) != nil) {
                topController = topController.presentedViewController!
            }
            viewObj = topController.view
            
            var styleToast = ToastStyle()
            styleToast.titleAlignment = .center
            styleToast.messageAlignment = .center
            viewObj.makeToast(stringMessage, duration:3.0, position:.center, style: styleToast)
        }
    }
    
    
    class func getUIColorFromhexString(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    class func showAlertControllerOrNotWithOKBACompletionHandler(_ stringTitle: String, _ stringMessage: String, _ boolShowAlert: Bool, completionHandlerForOKBA: @escaping () -> Void) {
        if boolShowAlert {
            var topController = UIApplication.shared.keyWindow!.rootViewController! as UIViewController
            while ((topController.presentedViewController) != nil) {
                topController = topController.presentedViewController!
            }
            let alertController = UIAlertController(title: stringTitle, message: stringMessage, preferredStyle: UIAlertController.Style.alert)
            
            let alertActionOk: UIAlertAction = UIAlertAction(title: "OK", style: .default) { action -> Void in
                print("OK")
                completionHandlerForOKBA()
            }
            alertController.addAction(alertActionOk)
            topController.present(alertController, animated:true, completion:nil)
        }
    }
    
    
    class func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        //UtilitySwift.resizeImage(image: imageObject!, targetSize: CGSize(width: 30.0, height: 30.0))
        let size = image.size
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        }
        else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage!
    }
    
    
    @objc class func showMBProgressHUD() {
        DispatchQueue.main.async {
            var viewObj = UIView()
            var topController = UIApplication.shared.keyWindow!.rootViewController!
            while ((topController.presentedViewController) != nil) {
                topController = topController.presentedViewController!
            }
            viewObj = topController.view
            
            mBProgressHUD = MBProgressHUD.showAdded(to:viewObj, animated:true)
            
            mBProgressHUD.backgroundView.style = MBProgressHUDBackgroundStyle.solidColor
            mBProgressHUD.backgroundView.color = UIColor(white:0.0, alpha:0.2)
            
            mBProgressHUD.label.text = STRING_LOADING_MESSAGE
            // mBProgressHUD.label.font = [UIFont italicSystemFontOfSize:16.f];
        }
    }
    
    
    @objc class func hideMBProgressHUD() {
        DispatchQueue.main.async {
            mBProgressHUD.hide(animated:true)
        }
    }
    
    
    @objc class func hexStringToUIColor(hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt32 = 0
        Scanner(string: cString).scanHexInt32(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    @objc class func getRandomColor() -> UIColor {
        let red:CGFloat = CGFloat(drand48())
        let green:CGFloat = CGFloat(drand48())
        let blue:CGFloat = CGFloat(drand48())
        return UIColor(red:red, green: green, blue: blue, alpha: 1.0)
    }
    
}
