# flutter_application_1

Dự án Flutter môn Lập trình trên thiết bị di động.

## Cấu trúc dự án
- **`lib/main.dart`**: Chương trình chính tích hợp giao diện Notification Bell Badge và kết nối HTTP API.
- **`lib/layout_notification_bell.xml`**: Layout XML mô phỏng quả chuông và badge số lượng thông báo.
- **`lib/res/drawable/bg_badge_circle.xml`**: Drawable XML định nghĩa hình tròn nền đỏ cho badge thông báo.
- **`android/app/src/main/res/`**: Tài nguyên Android Native tương ứng.
- **Thư viện**: Tích hợp package `http` gọi REST API.

## Hướng dẫn chạy
```bash
flutter pub get
flutter run -d chrome
```
