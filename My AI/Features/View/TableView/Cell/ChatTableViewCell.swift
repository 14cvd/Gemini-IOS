import UIKit
import SnapKit

class ChatTableViewCell: UITableViewCell {
    static var id: String = "\(ChatTableViewCell.self)"
    
    var label: UILabel = UILabel()
    
    private var leftConstraint: Constraint!
    private var rightConstraint: Constraint!
    
    private var  chatView : UIView = {
        let view = UIView()
        view.layer.cornerRadius = 20
        
        return view
    }()
    
    var isModel : Bool = false {
        didSet {
            chatView.backgroundColor = isModel  ? .systemGray4 : UIColor(named: "main")
            label.textColor = isModel ? .black : .white
            label.font = isModel ? UIFont.systemFont(ofSize: 13) : UIFont(name: "Nunito-Bold", size: 13)
        
//            constraintfConfig(isModel: isModel)
        }
    }
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        config()
        constraintfConfig(isModel: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ChatTableViewCell : UIConfig{
    func constraintConfig() {
    }
    
    func config() {
        contentView.addSubview(chatView)
        chatView.addSubview(label)
        
        chatView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(8)
            leftConstraint = make.left.equalToSuperview().constraint
            rightConstraint = make.right.equalToSuperview().constraint
        }
        
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(18)
        }
        
        leftConstraint.activate()
        rightConstraint.activate()
    }
    
    func constraintfConfig(isModel : Bool) {
        if isModel  {
            rightConstraint.update(inset:120)
            leftConstraint.update(inset: 20)
    
        }
        else {
            leftConstraint.update(inset: 120)
            rightConstraint.update(inset: 20)
        }
    }
}
