//
//  DetailVC.swift
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 06/04/22.
//

import UIKit
import Alamofire
import SwiftyJSON
import SnapKit


class DetailVC: UIViewController {
    
    var didSetupConstraints = false
    var dataGetDetailsOfAPerson: DataGetDetailsOfAPerson? = nil
    
    let scrollView  = UIScrollView()
    let contentView = UIView()
    
    let labelFirstChar : UILabel = {
        let label = UILabel()
        label.text = "-"
        label.numberOfLines = 0
        label.backgroundColor = UtilitySwift.getRandomColor()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 50.0)
        return label
    }()
    let labelNameStatic : UILabel = { let label = UILabel(); label.text = "Name :"; return label; }()
    let labelName : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelLeadStatic : UILabel = { let label = UILabel(); label.text = "Lead :"; return label; }()
    let labelLead : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelOrganizationStatic : UILabel = { let label = UILabel(); label.text = "Organization :"; return label; }()
    let labelOrganization : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelEmailStatic : UILabel = { let label = UILabel(); label.text = "Email :"; return label; }()
    let labelEmail : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelPhoneStatic : UILabel = { let label = UILabel(); label.text = "Phone :"; return label; }()
    let labelPhone : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelClosedDealsStatic : UILabel = { let label = UILabel(); label.text = "Closed deals :"; return label; }()
    let labelClosedDeals : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelOpenDealsStatic : UILabel = { let label = UILabel(); label.text = "Open deals :"; return label; }()
    let labelOpenDeals : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelNextActivityDateStatic : UILabel = { let label = UILabel(); label.text = "Next activity date :"; return label; }()
    let labelNextActivityDate : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    let labelOwnerStatic : UILabel = { let label = UILabel(); label.text = "Owner :"; return label; }()
    let labelOwner : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = UIColor.darkGray; return label; }()
    
    let viewLast: UIView = { let view = UIView(); view.backgroundColor = .white; return view; }()
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeNavigationBar()
        self.view.backgroundColor = .white
        
        self.setupUI()
        view.setNeedsUpdateConstraints()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if (UtilitySwift.isInternetConnected(isShowPopup: false)) {
            if (dataGetDetailsOfAPerson != nil) {
                let arrayParametersAppendURL: NSMutableArray = [dataGetDetailsOfAPerson?.id]
                let hTTPHeaders: HTTPHeaders = [:]
                let parameters: Parameters = ["api_token": API_TOKEN]
                self.getResponseFromAPI_persons(arrayParametersAppendURL, hTTPHeaders, parameters) { (responseSucessOrFail, responseInJSON) in
                    if (responseSucessOrFail) {
                        let dataGetDetailsOfAPerson = DataGetDetailsOfAPerson(json: responseInJSON["data"])
                        self.populateData(dataGetDetailsOfAPerson)
                    }
                }
            }
        }
        else {
            self.populateData(dataGetDetailsOfAPerson)
        } 
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    func customizeNavigationBar() {
        let navigationBarObject = self.navigationController?.navigationBar
        navigationBarObject?.barTintColor = UtilitySwift.getUIColorFromhexString(hex: STRING_HEX_UICOLOR_NAVIGATIONBAR_BARTINT_COLOR)
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.isNavigationBarHidden = false
        
        self.navigationItem.title = "Detail"
        self.navigationItem.hidesBackButton = true
        
        let imageBarButtonItemLeft = (UtilitySwift.resizeImage(image: UIImage(named: "back")!, targetSize: CGSize(width: 20, height: 20))).withRenderingMode(.alwaysOriginal)
        let barButtonItemLeft: UIBarButtonItem = UIBarButtonItem(image: imageBarButtonItemLeft, style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.bABack(_:)))
        self.navigationItem.leftBarButtonItems = [barButtonItemLeft]
    }
    
    
    //MARK:- Setup UI
    func setupUI() {
        //        scrollView.bounces = false
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        labelFirstChar.text = "-".uppercased()
        labelFirstChar.layer.cornerRadius = 50
        labelFirstChar.layer.masksToBounds = true
        contentView.addSubview(labelFirstChar)
        contentView.addSubview(labelNameStatic)
        contentView.addSubview(labelName)
        contentView.addSubview(labelLeadStatic)
        contentView.addSubview(labelLead)
        contentView.addSubview(labelOrganizationStatic)
        contentView.addSubview(labelOrganization)
        contentView.addSubview(labelEmailStatic)
        contentView.addSubview(labelEmail)
        contentView.addSubview(labelPhoneStatic)
        contentView.addSubview(labelPhone)
        contentView.addSubview(labelClosedDealsStatic)
        contentView.addSubview(labelClosedDeals)
        contentView.addSubview(labelOpenDealsStatic)
        contentView.addSubview(labelOpenDeals)
        contentView.addSubview(labelNextActivityDateStatic)
        contentView.addSubview(labelNextActivityDate)
        contentView.addSubview(labelOwnerStatic)
        contentView.addSubview(labelOwner)
        
        contentView.addSubview(viewLast)
    }
    
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            let intGapBetweenTwoLabels = 10
            
            scrollView.snp.makeConstraints { make in
                make.edges.equalTo(view).inset(UIEdgeInsets.zero)
            }
            
            contentView.snp.makeConstraints { make in
                make.edges.equalTo(scrollView).inset(UIEdgeInsets.zero)
                make.width.equalTo(scrollView)
            }
            
            labelFirstChar.snp.makeConstraints { (make) in
                make.top.equalTo(contentView).inset(10)
                //                make.left.equalTo(contentView).inset(10)
                make.centerX.equalTo(view)
                make.width.equalTo(100)
                make.height.equalTo(100)
            }
            
            labelNameStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelFirstChar.snp.bottom).offset(20)
                make.left.equalTo(contentView).inset(10)
                //                make.trailing.equalTo(contentView).inset(10)
                make.width.equalTo(contentView).dividedBy(2.5)
            }
            
            labelName.snp.makeConstraints { (make) in
                make.top.equalTo(labelFirstChar.snp.bottom).offset(20)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(contentView).dividedBy(2)
            }
            
            labelLeadStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelName.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelLead.snp.makeConstraints { (make) in
                make.top.equalTo(labelName.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
            }
            
            labelOrganizationStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelLead.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelOrganization.snp.makeConstraints { (make) in
                make.top.equalTo(labelLead.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
            }
            
            labelEmailStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelOrganization.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelEmail.snp.makeConstraints { (make) in
                make.top.equalTo(labelOrganization.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
            }
            
            labelPhoneStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelEmail.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelPhone.snp.makeConstraints { (make) in
                make.top.equalTo(labelEmail.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
            }
            
            labelClosedDealsStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelPhone.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelClosedDeals.snp.makeConstraints { (make) in
                make.top.equalTo(labelPhone.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
            }
            
            labelOpenDealsStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelClosedDeals.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelOpenDeals.snp.makeConstraints { (make) in
                make.top.equalTo(labelClosedDeals.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
            }
            
            labelNextActivityDateStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelOpenDeals.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelNextActivityDate.snp.makeConstraints { (make) in
                make.top.equalTo(labelOpenDeals.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
            }
            
            labelOwnerStatic.snp.makeConstraints { (make) in
                make.top.equalTo(labelNextActivityDate.snp.bottom).offset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(labelNameStatic)
            }
            
            labelOwner.snp.makeConstraints { (make) in
                make.top.equalTo(labelNextActivityDate.snp.bottom).offset(10)
                make.left.equalTo(labelNameStatic.snp.right).offset(intGapBetweenTwoLabels)
                make.width.equalTo(labelName)
                make.bottom.equalTo(contentView).inset(20)
            }
            
            /*
             viewLast.snp.makeConstraints { make in
             make.centerX.equalTo(view)
             make.top.equalTo(labelOwner.snp.bottom).offset(10)
             make.size.equalTo(CGSize(width: 10, height: 10))
             make.bottom.equalTo(contentView).inset(20)
             }
             */
            
            didSetupConstraints = true
        }
        
        super.updateViewConstraints()
    }
    
    
    //MARK:- Button Actions
    @IBAction func bABack(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    func populateData(_ dataGetDetailsOfAPerson: DataGetDetailsOfAPerson?) {
        if (dataGetDetailsOfAPerson != nil) {
            labelFirstChar.text = dataGetDetailsOfAPerson?.firstChar?.uppercased() ?? "-"
            labelName.text = dataGetDetailsOfAPerson?.name ?? "-"
            labelLead.text = dataGetDetailsOfAPerson?.label == 5 ? "CUSTOMER" : dataGetDetailsOfAPerson?.label == 6 ? "HOT LEAD" : dataGetDetailsOfAPerson?.label == 7 ? "WARM LEAD" : dataGetDetailsOfAPerson?.label == 8 ? "COLD LEAD" : "-"
            labelOrganization.text = dataGetDetailsOfAPerson?.orgName ?? "-"
            
            var emails = "-"
            for email in dataGetDetailsOfAPerson?.email ?? [] {
                print("email = " , email)
                if (email.label != nil) {
                    emails = (emails == "-" ? "" : emails + "\n") + email.label! + ": " + email.value!
                }
            }
            labelEmail.text = emails
            
            var phones = "-"
            for phone in dataGetDetailsOfAPerson?.phone ?? [] {
                print("phone = " , phone)
                if (phone.label != nil) {
                    phones = (phones == "-" ? "" : phones + "\n") + phone.label! + ": " + phone.value!
                }
            }
            labelPhone.text = phones
            
            labelClosedDeals.text = String((dataGetDetailsOfAPerson?.closedDealsCount)!)
            labelOpenDeals.text = String((dataGetDetailsOfAPerson?.openDealsCount)!)
            labelNextActivityDate.text = String(dataGetDetailsOfAPerson?.nextActivityDate ?? "-")
            labelOwner.text = dataGetDetailsOfAPerson?.ownerName
        }
    }
    
    
    //MARK:- Get Reasponse From API
    func getResponseFromAPI_persons(_ arrayParametersAppendURL: NSMutableArray, _ hTTPHeaders: HTTPHeaders, _ parameters: Parameters, completionHandlerResponseSucessOrFail_ResponseInJSON: @escaping (_ responseSucessOrFail: Bool, _ responseInJSON: JSON) -> Void) {
        APIManager.sharedAPIManager.hitAPIStringParametersAppendURL(PERSONS, methodType: .get, arrayParametersAppendURL: arrayParametersAppendURL, hTTPHeaders: hTTPHeaders, parameters: parameters, isShowActivityIndicator: true, isShowErrorPopupIfSuccessFalse: true) { (responseInJSON) in
            if (responseInJSON["success"] == true) {
                completionHandlerResponseSucessOrFail_ResponseInJSON (true, responseInJSON)
            }
            else {
                completionHandlerResponseSucessOrFail_ResponseInJSON (false, responseInJSON)
            }
        } completionHandlerFailure: { (error) in
            print(error?.localizedDescription as Any)
        }
    }
    
}
