import Foundation

struct YakushokuConst{
    static let SIMIN = "市民"
    static let ZINROU = "人狼"
    static let URANAISI = "占い師"
    static let KISHI = "騎士"
}

struct ActionTextConst{
    static let SIMIN = "疑う"
    static let ZINROU = "襲撃する"
    static let URANAISI = "占う"
    static let KISHI = "守る"
}

struct ZinneiConst{
    static let Murabito = "村人"
    static let ZINROU = "人狼"
}

struct GameConst{
    static let KAIGI_TIME = 100
    static let ASA = "朝"
    static let YORU = "夜"
    static let KEIZOKU = "継続"
    static let ZINROUSHOURI = "人狼勝利"
    static let SIMINSHOURI = "市民勝利"
}


struct YoruActionMessageConst{
    static let SIMIN = "さんを人狼だと疑いますか？"
    static let ZINROU = "さんを襲撃しますか？"
    static let URANAISI = "さんを人狼かどうか調べますか？"
    static let KISHI = "さんを今夜守りますか？"
}

struct ExtentionMessageConst{
    static let SIMIN = "この中で人狼だと疑わしいプレイヤーを1人選んでください"
    static let ZINROU = "今夜襲撃するプレイヤーを１人選んでください"
    static let URANAISI = "あなたが人狼か人間か、確認したいプレイヤーを1人選んでください"
    static let KISHI = "あなたが人狼の襲撃から守りたいプレイヤーを1人選んでください"
}
