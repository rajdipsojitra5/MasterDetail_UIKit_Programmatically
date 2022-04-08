//
//  MasterListTableViewCell.swift
//  MasterDetail_UIKit_Programmatically
//
//  Created by ks on 07/04/22.
//

import UIKit

class MasterListTableViewCell: UITableViewCell {
    
    //    var minHeight: CGFloat?
    
    let viewMain : UIView = { let view = UIView(); view.backgroundColor = UtilitySwift.getUIColorFromhexString(hex: "E8E8E8"); return view; }()
    
    let labelFirstChar : UILabel = {
        let label = UILabel()
        label.text = "-"
        label.numberOfLines = 0
        label.backgroundColor = UtilitySwift.getRandomColor()
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        return label
    }()
    
    let labelName : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; return label; }()
    let labelEmail : UILabel = { let label = UILabel(); label.text = "-"; label.numberOfLines = 0; label.textColor = .darkGray; return label; }()
    
    
    
    
    
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 2, left: 0, bottom: 2, right: 0))
    }
    
    
    //    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
    //            let size = super.systemLayoutSizeFitting(targetSize, withHorizontalFittingPriority: horizontalFittingPriority, verticalFittingPriority: verticalFittingPriority)
    //            guard let minHeight = minHeight else { return size }
    //            return CGSize(width: size.width, height: max(size.height, minHeight))
    //        }
    
    
    //MARK:- Setup UI
    func setupUI() {
        //        backgroundColor = UtilitySwift.getUIColorFromhexString(hex: "707070") //F8F8F8
        
        viewMain.layer.cornerRadius = 5
        viewMain.layer.masksToBounds = true
        contentView.addSubview(viewMain)
        viewMain.snp.makeConstraints { (make) in
            //            make.top.equalTo(contentView.snp.top).offset(0)
            //            make.left.equalTo(contentView).inset(10)
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.width.equalTo(contentView.snp.width).dividedBy(1)
            make.height.equalTo(contentView.snp.height).dividedBy(1)
        }
        
        
        viewMain.addSubview(labelFirstChar)
        labelFirstChar.text = "-".uppercased()
        labelFirstChar.layer.cornerRadius = 25
        labelFirstChar.layer.masksToBounds = true
        labelFirstChar.snp.makeConstraints { (make) in
            make.centerY.equalTo(viewMain.snp.centerY)
            make.left.equalTo(viewMain.snp.left).inset(5)
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
        
        
        viewMain.addSubview(labelName)
        //        labelName.backgroundColor = .red
        labelName.snp.makeConstraints { (make) in
            make.top.equalTo(viewMain.snp.top).inset(10)
            make.left.equalTo(labelFirstChar.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).inset(10)
            make.height.greaterThanOrEqualTo(labelFirstChar.snp.height).dividedBy(2)
        }
        
        viewMain.addSubview(labelEmail)
        //        labelEmail.backgroundColor = .green
        labelEmail.snp.makeConstraints { (make) in
            make.top.equalTo(labelName.snp.bottom).offset(0)
            make.left.equalTo(labelFirstChar.snp.right).offset(10)
            make.right.equalTo(contentView.snp.right).inset(10)
            make.height.greaterThanOrEqualTo(55)
            make.bottom.equalTo(contentView.snp.bottom).inset(0)
        }
    }
    
    
    func setUpCellData(_ dataGetDetailsOfAPerson: DataGetDetailsOfAPerson) {
        labelFirstChar.text = dataGetDetailsOfAPerson.firstChar?.uppercased()
        labelName.text = dataGetDetailsOfAPerson.name
        
        var emails = "-"
        for email in dataGetDetailsOfAPerson.email ?? [] {
            print("email = " , email)
            if (email.label != nil) {
                emails = (emails == "-" ? "" : emails + "\n") + email.label! + ": " + email.value!
            }
        }
        print("emails = ", emails)
        labelEmail.text = emails
    }
    
}
