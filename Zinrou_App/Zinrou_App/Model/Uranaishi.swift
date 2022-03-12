import Foundation

struct Uranaishi:YakushokuProtocol{
    //名前
    var name: String = YakushokuConst.URANAISI
    //陣営
    var zinnei: String = ZinneiConst.SIMIN
    //アクションテキスト
    var actionText: String = ActionTextConst.URANAISI
    
    func action1(name:String, delegate:SelectProtocol){
        delegate.select(name: name)
    }
    func action2(name:String, delegate:SelectProtocol){
        delegate.uranau(name: name)
        
    }
}
