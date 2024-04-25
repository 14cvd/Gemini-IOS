import UIKit

class ChatTableViewCell: UITableViewCell {
    static var id: String = "\(ChatTableViewCell.self)"
    
    public var chatMessage: ChatMessage?
    private lazy var  chatItem : ChatBubbleView = {
        let view = UILabel()
        let label = UILabel()
        
        label.text = chatMessage?.message
        
        print(label.text)
        view.addSubview(label)
        let item = ChatBubbleView(direction: self.chatMessage!.role == .model ? .left : .right, content: view)
        return item
    }()
//    var data: String
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
//        self.data = ""
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(chatItem)
    }
    
    init(style: UITableViewCell.CellStyle, reuseIdentifier: String?, data: String) {
//        self.data = /*data*/
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
