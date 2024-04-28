import UIKit

class ChatTableViewCell: UITableViewCell {
    static var id: String = "\(ChatTableViewCell.self)"
    
    
    var label: UILabel = UILabel() 
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
//        contentView.backgroundColor = .blue
//        contentView.addSubview(chatItem)
        config()
        constraintConfig()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension ChatTableViewCell : UIConfig{
    func config() {
//        contentView.addSubview(chat)
//        label.backgroundColor = .red
        
        contentView.addSubview(label)
        label.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
    }
    
    func constraintConfig() {
//        chat.snp.makeConstraints { make in
//            make.left.equalTo(10)
//            make.top.equalTo(200)
//            make.width.equalTo(300)
//            make.height.equalTo(100)
//            
//        }
    }
    
    
}
