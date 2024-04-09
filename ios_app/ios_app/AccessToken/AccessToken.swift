/// Copyright (c) 2024 RICOH Company, Ltd. All rights reserved.

import Foundation
import SwiftJWT
import SwiftyJSON

class AccessToken {

    func getAccessToken() -> String {
        struct MyPayload: Claims {
            let nbf: Int
            let exp: Int
            let room_id: String
            let room_spec: JSON
            let connection_id: String
        }
        
        let dateNow = Date()
        // reference to Android SDK
        // now - 30 min
        let nbf = Int(Date(timeInterval: -60*30, since: dateNow as Date).timeIntervalSince1970)
        // now + 30 min
        let exp = Int(Date(timeInterval: 60*30, since: dateNow as Date).timeIntervalSince1970)
        // reference to Web SDK
        let connection_id = "iOSSampleApp" + getRandomEncodedString()
        
        let type = "sfu"
        let classification_label = "default"
        let max_connections = 50
        let room_spec: JSON = [
            "classification_label": classification_label,
            "max_connections": max_connections,
            "media_control": ["bitrate_reservation_mbps": 25],
            "type": type
        ]
        
        let header = Header(cty: "JWT")
        
        // Notice: reset to empty before git commit and push
        let clientSecret = CLIENT_SECRET.data(using: .utf8)!
        let jwtSign = JWTSigner.hs256(key: clientSecret)
        
        let payload = MyPayload(
            nbf: nbf,
            exp: exp,
            room_id: ROOM_ID,
            room_spec: room_spec,
            connection_id: connection_id
        )
        
        var jwt = JWT(header: header, claims: payload)
        let signedJWT: String
        
        do {
            signedJWT = try jwt.sign(using: jwtSign)
        } catch {
            signedJWT = ""
        }
        
        return signedJWT
    }
    
    private func getRandomEncodedString() -> String {
        let randomStr = Double.random(in: 0...1).description
        let randomData: Data = randomStr.data(using: .utf8)!
        let encodedStr = randomData.base64EncodedString()
            .replacingOccurrences(of: "=", with: "")
            .replacingOccurrences(of: "+", with: "")
            .replacingOccurrences(of: "/", with: "")
            .replacingOccurrences(of: "\n", with: "")
        
        return encodedStr
    }
    
}
