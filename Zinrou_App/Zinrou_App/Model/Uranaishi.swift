import Foundation

struct Uranaishi:YakushokuProtocol{
    //名前
    var name: String = YakushokuConst.URANAISI
    //陣営
    var zinnei: String = ZinneiConst.SIMIN
    //アクションテキスト
    var actionText: String = ActionTextConst.URANAISI
    //夜のアクション確認メッセージ
    var yoruActionMessage: String = YoruActionMessageConst.URANAISI
    //アクションの説明文
    var extentionMessage:String = ExtentionMessageConst.URANAISI
    
    func action1(name:String, delegate:SelectProtocol){
        delegate.select(name: name)
    }
    func action2(name:String, delegate:SelectProtocol){
        delegate.uranau(name: name)
        
    }
}
