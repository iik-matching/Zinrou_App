import Foundation

struct Zinrou:YakushokuProtocol{
    //名前
    var name: String = YakushokuConst.ZINROU
    //陣営
    var zinnei: String = ZinneiConst.ZINROU
    //アクションテキスト
    var actionText: String = ActionTextConst.ZINROU
    func action1(name:String, delegate:SelectProtocol) {
        delegate.select(name: name)
    }
    func action2(name:String, delegate:SelectProtocol){
        delegate.kill(name: name)
    }
}
