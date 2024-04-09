# RICOH Live Streaming Client SDK for iOS
株式会社リコーが提供するRICOH Live Streaming Serviceを利用するためのRICOH Live Streaming Client SDK for iOS です。

RICOH Live Streaming Serviceは、映像/音声などのメディアデータやテキストデータなどを 複数の拠点間で双方向かつリアルタイムにやりとりできるプラットフォームです。

サービスのご利用には、API利用規約への同意とアカウントの登録、ソフトウェア利用許諾書への同意が必要です。 詳細は下記Webサイトをご確認ください。

サービスサイト: https://livestreaming.ricoh/

ソフトウェア開発者向けサイト: https://api.livestreaming.ricoh/

アカウント登録: https://console.livestreaming.mw.smart-integration.ricoh.com/login/register

ソフトウェア使用許諾契約書 : [Software License Agreement](SoftwareLicenseAgreement.txt)

NOTICE: This package includes SDK and sample application(s) for "RICOH Live Streaming Service". At this moment, we provide API license agreement / software license agreement only in Japanese.

## プロジェクト構成
- [Frameworks](Frameworks)
    - ライブラリ本体
- [ios_app](ios_app)
    - 内蔵マイク、カメラによる映像配信のサンプル
  
## 依存ライブラリ
Client SDK は以下のライブラリを使用しています。
- CocoaLumberjack/Swift:3.8.2
- SwiftyJSON:4.3.0
- AnyCodable-FlightSchool:0.6.7

※アプリでSDKを使用する際は上記のライブラリをリンクする必要があります

## バージョンアップ時の更新方法
下記のフォルダに配置されたclient_sdk.xcframeworkを置き換える。
- Frameworks