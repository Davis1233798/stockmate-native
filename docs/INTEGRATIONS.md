# 整合設定

## GPS 與賣場提醒

iOS 使用 Core Location region monitoring，Android 使用 Google Play services Geofencing。App 只註冊仍有未完成品項的賣場；進入範圍後發送本機通知。正式版應提供「只在使用 App 時」與「永遠允許」的用途說明，並允許關閉背景定位。

## 語音

- iOS：`AddShoppingItemIntent` 暴露給 Siri / Shortcuts。
- Android：接收 `ACTION_PROCESS_TEXT`，也可由 Google Assistant Routine 開啟新增頁並帶入文字。
- 其他助手：呼叫後端 `POST /v1/items`，使用使用者專屬 token。

## LINE / Telegram / WhatsApp / Discord

建立官方 Bot/App，將 webhook 指向 `/webhooks/{provider}`。訊息格式建議為「買 牛奶 2」或「完成 牛奶」。正式部署必須依平台規格驗證簽章，並將平台 user id 綁定 StockMate 帳號。

## 台灣電子發票載具

向財政部電子發票整合服務平台申請 API 資格。排程同步已授權使用者的發票明細，將商品名稱正規化後與未完成清單比對；高信心才自動完成，低信心要求使用者確認，避免「鮮乳」與「奶粉」誤判。

必要環境變數請參考 `backend/.env.example`，金鑰不可提交 Git。
