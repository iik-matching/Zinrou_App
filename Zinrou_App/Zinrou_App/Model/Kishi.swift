import Foundation

struct Kishi:YakushokuProtocol{
    //名前
    var name: String = YakushokuConst.KISHI
    //陣営
    var zinnei: String = ZinneiConst.SIMIN
    //アクションテキスト
    var actionText: String = ActionTextConst.KISHI
    
    func action1(name:String, delegate:SelectProtocol){
        delegate.select(name: name)
    }
    func action2(name:String, delegate:SelectProtocol){
        delegate.gurde(name: name)
    }
}
