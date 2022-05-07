import Foundation

struct Zinrou:YakushokuProtocol{
    //名前
    var name: String = YakushokuConst.ZINROU
    //陣営
    var zinnei: String = ZinneiConst.ZINROU
    //アクションテキスト
    var actionText: String = ActionTextConst.ZINROU
    //夜のアクション確認メッセージ
    var yoruActionMessage: String = YoruActionMessageConst.ZINROU
    //アクションの説明文
    var extentionMessage:String = ExtentionMessageConst.ZINROU
    
    func action1(name:String, delegate:SelectProtocol) {
        delegate.select(name: name)
    }
    func action2(name:String, delegate:SelectProtocol){
        delegate.kill(name: name)
    }
}
