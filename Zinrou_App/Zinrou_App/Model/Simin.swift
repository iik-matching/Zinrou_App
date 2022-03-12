import Foundation
//市民モデル
struct Simin:YakushokuProtocol{
    
    //名前
    var name: String = YakushokuConst.SIMIN
    //陣営
    var zinnei: String = ZinneiConst.SIMIN
    //アクションテキスト
    var actionText: String = ActionTextConst.SIMIN
    //朝のアクション
    func action1(name:String, delegate:SelectProtocol){
        delegate.select(name: name)
    }
    //夜のアクション
    func action2(name:String, delegate:SelectProtocol) {
        delegate.select(name: name)
    }
}
