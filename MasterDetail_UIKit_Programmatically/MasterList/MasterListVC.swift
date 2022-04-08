//
//  MasterVC.swift
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 06/04/22.
//

import UIKit
import Alamofire
import SwiftyJSON


class MasterListVC: UIViewController {
    
    var didSetupConstraints = false
    
    let contentView = UIView()
    var tableView: UITableView!
    
    var intFromIndexTableView = 0
    var intBatchSizeTableView = 20
    
    var arrayTableView = [DataGetDetailsOfAPerson]()
    
    
    
    
    
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.customizeNavigationBar()
        self.view.backgroundColor = .white
        
        self.setupUI()
        view.setNeedsUpdateConstraints()
        
        tableView.register(MasterListTableViewCell.self, forCellReuseIdentifier: MasterListTableViewCell.stringClassName)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 50
        
        if UtilitySwift.isInternetConnected(isShowPopup:true) {
            let arrayParametersAppendURL: NSMutableArray = [""]
            let hTTPHeaders: HTTPHeaders = [:]
            let parameters: Parameters = ["api_token": API_TOKEN,
                                          "start": intFromIndexTableView,
                                          "limit": intBatchSizeTableView]
            self.getResponseFromAPI_persons(arrayParametersAppendURL, hTTPHeaders, parameters) { (responseSucessOrFail, responseInJSON) in
                if (responseSucessOrFail) {
                    let getAllPersonsDM = GetAllPersonsDM(json: responseInJSON)
                    let data = getAllPersonsDM.data
                    if (data != nil) {
                        UserDefaults.standard.removeArrayDataGetDetailsOfAPerson()
                        self.arrayTableView = data!
                        self.tableView.reloadData()
                        UserDefaults.standard.setArrayDataGetDetailsOfAPerson(self.arrayTableView)
                    }
                }
            }
        }
        else {
            let arrayTableViewTemp = UserDefaults.standard.getArrayDataGetDetailsOfAPerson()
            if (arrayTableViewTemp.count > 0) {
                arrayTableView.removeAll()
                arrayTableView = arrayTableViewTemp
                tableView.reloadData()
            }
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.populateData()
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
        
        self.navigationItem.title = "Master"
        self.navigationItem.hidesBackButton = true
    }
    
    
    //MARK:- Setup UI
    func setupUI() {
        //        contentView.backgroundColor = .green
        view.addSubview(contentView)
        
        tableView = UITableView(frame: .zero)
        tableView.backgroundColor = .white
        contentView.addSubview(tableView)
    }
    
    
    override func updateViewConstraints() {
        if (!didSetupConstraints) {
            contentView.snp.makeConstraints { make in
                make.edges.equalTo(view).inset(UIEdgeInsets.zero)
            }
            
            tableView.snp.makeConstraints { (make) in
                make.top.equalTo(contentView).inset(10)
                make.left.equalTo(contentView).inset(10)
                make.width.equalTo(contentView).dividedBy(1.07)
                make.bottom.equalTo(contentView).inset(20)
            }
            
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    
    //MARK:- Button Actions
    @IBAction func bABack(_ sender: Any) {
        if UtilitySwift.isInternetConnected(isShowPopup: true) {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    
    func populateData() {
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
    
    
    func getNavigationBarHeightPlusStatusBarHeight() -> CGFloat {
        let height = self.navigationController!.navigationBar.frame.size.height + (view.window?.windowScene?.statusBarManager?.statusBarFrame.height)!
        return height
    }
    
}










extension MasterListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayTableView.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MasterListTableViewCell.stringClassName, for: indexPath) as! MasterListTableViewCell
        //        cell.minHeight = 60
        cell.setUpCellData(self.arrayTableView[indexPath.row])
        cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        if UtilitySwift.isInternetConnected(isShowPopup: true) {
        let viewController = DetailVC()
        viewController.dataGetDetailsOfAPerson = self.arrayTableView[indexPath.row]
        self.navigationController?.pushViewController(viewController, animated: true)
        //        }
    }
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        print("scrollViewDidEndDragging")
        if ((self.tableView.contentOffset.y + self.tableView.frame.size.height) >= self.tableView.contentSize.height) {
            if (UtilitySwift.isInternetConnected(isShowPopup: true)) {
                intFromIndexTableView = intFromIndexTableView + intBatchSizeTableView
                
                let arrayParametersAppendURL: NSMutableArray = [""]
                let hTTPHeaders: HTTPHeaders = [:]
                let parameters: Parameters = ["api_token": API_TOKEN,
                                              "start": intFromIndexTableView,
                                              "limit": intBatchSizeTableView]
                self.getResponseFromAPI_persons(arrayParametersAppendURL, hTTPHeaders, parameters) { (responseSucessOrFail, responseInJSON) in
                    if (responseSucessOrFail) {
                        let getAllPersonsDM = GetAllPersonsDM(json: responseInJSON)
                        let data = getAllPersonsDM.data
                        if (data != nil) {
                            self.arrayTableView.append(contentsOf: data!)
                            self.tableView.reloadData()
                            UserDefaults.standard.setArrayDataGetDetailsOfAPerson(self.arrayTableView)
                        }
                    }
                }
                tableView.reloadData()
            }
        }
    }
    
}
