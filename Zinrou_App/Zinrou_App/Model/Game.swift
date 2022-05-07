import Foundation

//ゲーム終了判定
struct Game{
    //プレイヤーズ
    var players:[Player]
    //会議時間
    var kaigizikan:Int = GameConst.KAIGI_TIME
    //朝か夜
    var asaOrYoru:String = GameConst.YORU
    
    //終了判定　終了ならtrue 　継続ならfalse
    func endHantei()->String{
        var siminCount = 0
        var zinrouCount = 0
        for player in players{
            if player.zinnei == ZinneiConst.Murabito{
                if player.isDeath == false{
                    siminCount = siminCount + 1
                }
            }else{
                if player.isDeath == false{
                    zinrouCount = zinrouCount + 1
                }
            }
        }
        if (siminCount == zinrouCount){
            return GameConst.ZINROUSHOURI
        }else if(zinrouCount == 0){
            return GameConst.SIMINSHOURI
        }else{
            return GameConst.KEIZOKU
        }
    }
    
    
    mutating func switchAsaYoru(){
        if asaOrYoru == GameConst.YORU{
            asaOrYoru = GameConst.ASA
        }else{
            asaOrYoru = GameConst.YORU
        }
    }
}
