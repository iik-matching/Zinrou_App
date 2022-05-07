import Foundation

struct Kishi:YakushokuProtocol{
    //名前
    var name: String = YakushokuConst.KISHI
    //陣営
    var zinnei: String = ZinneiConst.Murabito
    //アクションテキスト
    var actionText: String = ActionTextConst.KISHI
    //夜のアクション確認メッセージ
    var yoruActionMessage: String = YoruActionMessageConst.KISHI
    //アクションの説明文
    var extentionMessage:String = ExtentionMessageConst.KISHI
    
    func action1(name:String, delegate:SelectProtocol){
        delegate.select(name: name)
    }
    func action2(name:String, delegate:SelectProtocol){
        delegate.gurde(name: name)
    }
}
