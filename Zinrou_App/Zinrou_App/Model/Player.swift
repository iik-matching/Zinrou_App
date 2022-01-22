import Foundation

//プレイヤー
struct Player{
    //名前
    var name:String
    //役職
    var yakushoku: YakushokuProtocol?
    //陣営
    var zinnei:String{
        get{
            return yakushoku!.zinnei
        }
    }
    //投票カウント
    var count:Int = 0
    //生死フラグ
    var isDeath:Bool = false
    //騎士防御フラグ
    var isGuard:Bool = false
    //人狼襲撃フラグ
    var isShuugeki:Bool = false
}
