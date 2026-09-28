import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bài thực hành Flutter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
      ),
      home: const CustomColumnsScreen(),
    );
  }
}

class CustomColumnsScreen extends StatefulWidget {
  const CustomColumnsScreen({super.key});

  @override
  State<CustomColumnsScreen> createState() => _CustomColumnsScreenState();
}

class _CustomColumnsScreenState extends State<CustomColumnsScreen> {
  // Chỉ số cột đang chọn (mặc định là cột 1 - hiển thị ngôi sao như trong ảnh)
  int _selectedColumnIndex = 0;

  // Danh sách thông tin 3 cột ở hàng trên cùng
  final List<Map<String, dynamic>> _columns = [
    {
      'title': 'Cột 1',
      'icon': Icons.star,
      'iconColor': const Color(0xFFD32F2F), // Màu đỏ
      'bgColor': const Color(0xFFF1D8DB),   // Màu hồng nhạt / pastel red
      'centerIcon': Icons.star,
    },
    {
      'title': 'Cột 2',
      'icon': Icons.favorite,
      'iconColor': const Color(0xFF388E3C), // Màu xanh lá
      'bgColor': const Color(0xFFD6F0DF),   // Màu xanh ngọc nhạt / pastel green
      'centerIcon': Icons.favorite,
    },
    {
      'title': 'Cột 3',
      'icon': Icons.thumb_up,
      'iconColor': const Color(0xFF1976D2), // Màu xanh dương
      'bgColor': const Color(0xFFD2EBF5),   // Màu xanh lam nhạt / pastel blue
      'centerIcon': Icons.thumb_up,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          // Giới hạn độ rộng tối đa để khi chạy trên Web (Chrome) hiển thị chuẩn khung điện thoại như trên màn hình chiếu
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Column(
              children: [
                // 1. HÀNG TRÊN CÙNG: 3 CỘT (Cột 1, Cột 2, Cột 3)
                Row(
                  children: List.generate(_columns.length, (index) {
                    final item = _columns[index];
                    return Expanded(
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _selectedColumnIndex = index;
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 16.0),
                          decoration: BoxDecoration(
                            color: item['bgColor'] as Color,
                            border: _selectedColumnIndex == index
                                ? Border(
                                    bottom: BorderSide(
                                      color: item['iconColor'] as Color,
                                      width: 3.0,
                                    ),
                                  )
                                : null,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                item['icon'] as IconData,
                                color: item['iconColor'] as Color,
                                size: 28,
                              ),
                              const SizedBox(height: 6),
                              Text(
                                item['title'] as String,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black87,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }),
                ),

                // 2. KHỐI CHÍNH Ở GIỮA: CONTAINER CÓ ẢNH BO GÓC CÓ VIỀN & CIRCLEAVATAR CÓ VÒNG NGOÀI MÀU XANH NHẠT
                Expanded(
                  child: Container(
                    width: double.infinity,
                    color: const Color(0xFFF5F7FA), // Màu nền sáng nhẹ nhàng để làm nổi bật các widget
                    child: Center(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // 1. CONTAINER CÓ HÌNH ẢNH, ĐƯỜNG VIỀN VÀ BO GÓC
                            Container(
                              width: 220,
                              height: 150,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                // Bo góc
                                borderRadius: BorderRadius.circular(20.0),
                                // Đường viền (Border)
                                border: Border.all(
                                  color: Colors.blueAccent, // Màu viền
                                  width: 3.5,               // Độ dày viền
                                ),
                                // Thuộc tính hình ảnh (DecorationImage)
                                image: const DecorationImage(
                                  image: AssetImage('image/ddd.jpg'), // Hoặc dùng NetworkImage('https://...')
                                  fit: BoxFit.cover, // Cắt ảnh vừa vặn khung bo góc
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.08),
                                    blurRadius: 10,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'Container viền & bo góc chứa hình ảnh',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),

                            const SizedBox(height: 24),

                            // 2. CIRCLEAVATAR CÓ VÒNG TRÒN NGOÀI MÀU XANH NHẠT
                            // Lồng 2 CircleAvatar: vòng ngoài màu xanh nhạt tạo viền, vòng trong chứa ảnh
                            const CircleAvatar(
                              radius: 56, // Bán kính vòng tròn ngoài
                              backgroundColor: Color(0xFFB3E5FC), // Màu xanh nhạt (Light blue pastel)
                              child: CircleAvatar(
                                radius: 48, // Bán kính vòng tròn bên trong
                                backgroundImage: AssetImage('image/ddd.jpg'), // Hình ảnh hiển thị bên trong
                              ),
                            ),
                            const SizedBox(height: 8),
                            const Text(
                              'CircleAvatar vòng ngoài màu xanh nhạt',
                              style: TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w500,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                // 3. HÀNG DƯỚI CÙNG: HIỂN THỊ "Cột 1: Xin chào" VÀ "Cột 2: Flutter"
                Container(
                  width: double.infinity,
                  color: const Color(0xFFF7F7F7), // Màu nền sáng ở chân trang
                  padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        'Cột 1: Xin chào',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      Text(
                        'Cột 2: Flutter',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
