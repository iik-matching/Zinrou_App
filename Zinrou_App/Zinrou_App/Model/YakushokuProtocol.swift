import Foundation

//役職プロトコル
protocol YakushokuProtocol {
    //名前
    var name: String { get set }
    //陣営
    var zinnei: String { get set }
    //アクションテキスト
    var actionText:String{get set}
    //夜のアクションの確認メッセージ
    var yoruActionMessage:String{get set}
    //アクションの説明文
    var extentionMessage:String{get set}
    
    //朝のアクション
    func action1(name:String, delegate:SelectProtocol)
    //夜のアクション
    func action2(name:String, delegate:SelectProtocol)
}

