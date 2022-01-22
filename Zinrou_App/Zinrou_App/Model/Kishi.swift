import Foundation

struct Kishi:YakushokuProtocol{
    //名前
    var name: String = YakushokuConst.KISHI
    //陣営
    var zinnei: String = ZinneiConst.SIMIN
    //アクションテキスト
    var actionText: String = ActionTextConst.KISHI
    
    func action1(name:String, delegate:SelectProtocol){
        print("怪しい人を指名する")
        delegate.select(name: name)
    }
    func action2(name:String, delegate:SelectProtocol){
        print("守る")
        delegate.gurde(name: name)
    }
}
