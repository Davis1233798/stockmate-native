# StockMate Native

個人庫存與採買提醒系統。iOS 使用 SwiftUI / SwiftData，Android 使用 Kotlin / Jetpack Compose / Room；沒有 Flutter 或跨平台 UI。

## MVP 功能

- 新增、勾選、手動刪除採買項目
- 保存數量、分類、指定賣場與建立時間
- 進入指定賣場地理圍欄時發送本機通知
- iOS App Intent，可由 Siri 說「加入 StockMate 的牛奶」
- Android `ACTION_PROCESS_TEXT` / App Shortcut 語音入口
- 通訊平台與電子發票（載具）採 Adapter 設計；Webhook 收到品項或發票明細後可新增／完成清單

## 專案結構

```text
ios/StockMate/       SwiftUI 原生 App
android/             Kotlin + Compose 原生 App
backend/             TypeScript API 與整合介面
docs/INTEGRATIONS.md 平台申請與限制
```

## 重要限制

LINE、Telegram、WhatsApp、Discord 都需要各平台 Bot/App 憑證及公開 HTTPS webhook。台灣電子發票載具需要財政部 API 的 `appID`、`apiKey` 與使用者授權；正式環境不可僅憑手機條碼任意讀取明細。GPS 背景定位也必須由使用者授權，iOS 對可同時監控的 region 數量有限，Android 可能受省電模式影響。

詳細設定見 [docs/INTEGRATIONS.md](docs/INTEGRATIONS.md)。

## 後端啟動

```bash
cd backend
cp .env.example .env
npm install
npm run dev
```

健康檢查：`GET /health`。所有 webhook 都必須在正式部署時驗證簽章。

## 狀態

這是可延伸的 MVP 原始碼。發佈 App Store / Google Play 前仍需：設定 Bundle ID / applicationId、簽章、隱私權政策、後端 URL、地圖賣場資料與第三方憑證。
