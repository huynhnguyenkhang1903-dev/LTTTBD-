import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================================
// 1. WIDGET GỐC CỦA ỨNG DỤNG (MYAPP)
// ============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Profile & Figma Viewer',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF7F9FC),
      ),
      home: const MainNavigationScreen(),
    );
  }
}

// ============================================================================
// 2. MÀN HÌNH CHÍNH CÓ THANH ĐIỀU HƯỚNG CHUYỂN TAB (MAIN NAVIGATION)
// Cho phép chuyển đổi giữa: Giao diện Flutter và Bản vẽ Figma (có thể Zoom)
// ============================================================================
class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _currentIndex = 0;

  // Danh sách 2 màn hình chính
  final List<Widget> _screens = const [
    ProfileScreen(),     // Tab 1: Giao diện Profile của Huỳnh Nguyên Khang
    FigmaViewerScreen(), // Tab 2: Màn hình xem bản thiết kế Figma (Hỗ trợ Zoom In/Out)
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      // BottomNavigationBar: Thanh điều hướng phía dưới để chuyển đổi giữa 2 tab
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (int index) {
          setState(() {
            _currentIndex = index;
          });
        },
        backgroundColor: Colors.white,
        elevation: 8,
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.person_outline_rounded),
            selectedIcon: Icon(Icons.person_rounded, color: Color(0xFF0284C7)),
            label: 'Giao diện Profile',
          ),
          NavigationDestination(
            icon: Icon(Icons.zoom_in_rounded),
            selectedIcon: Icon(Icons.zoom_in_rounded, color: Color(0xFF0284C7)),
            label: 'Bản vẽ Figma (Zoom)',
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// 3. TAB 1: GIAO DIỆN PROFILE HUỲNH NGUYÊN KHANG
// ============================================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Scaffold: Khung màn hình chuẩn của Material Design
    return Scaffold(
      // SafeArea: Tự động tránh vùng tai thỏ, camera nốt ruồi
      body: SafeArea(
        // Center + ConstrainedBox: Giới hạn độ rộng tối đa chuẩn giao diện điện thoại
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            // SingleChildScrollView: Cho phép cuộn trang mượt mà khi nội dung dài
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              // Column: Sắp xếp các thành phần từ trên xuống dưới
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // --- TOP BAR ---
                  _buildTopBar(),

                  const SizedBox(height: 24),

                  // --- AVATAR GRADIENT & HUY HIỆU XÁC THỰC ---
                  _buildAvatarSection(),

                  const SizedBox(height: 16),

                  // --- THÔNG TIN TÊN & NGHỀ NGHIỆP ---
                  const Text(
                    'Huỳnh Nguyên Khang',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Lead Mobile Engineer',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _buildLocationBadge('TP. Hồ Chí Minh, Việt Nam'),

                  const SizedBox(height: 24),

                  // --- BẢNG THỐNG KÊ (STATS CARD) ---
                  _buildStatsCard(),

                  const SizedBox(height: 28),

                  // --- GIỚI THIỆU BẢN THÂN (ABOUT ME) ---
                  _buildSectionTitle('About Me'),
                  const SizedBox(height: 10),
                  const Text(
                    'Passionate Lead Mobile Engineer specialized in Flutter, Dart, and building high-performance cross-platform applications. Focused on elegant design and clean architecture.',
                    style: TextStyle(
                      fontSize: 13.5,
                      color: Color(0xFF64748B),
                      height: 1.5,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // --- KỸ NĂNG & CHUYÊN MÔN (SKILLS & EXPERTISE) ---
                  _buildSectionTitle('Skills & Expertise'),
                  const SizedBox(height: 12),
                  _buildSkillsWrap(),

                  const SizedBox(height: 28),

                  // --- DỰ ÁN NỔI BẬT (FEATURED PROJECTS) ---
                  _buildSectionTitle('Featured Projects'),
                  const SizedBox(height: 14),
                  _buildFeaturedProjects(),

                  const SizedBox(height: 28),

                  // --- THÔNG TIN LIÊN HỆ (CONTACT INFORMATION) ---
                  _buildContactCard(),

                  const SizedBox(height: 24),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Row: Bố trí theo hàng ngang
  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildCircleButton(icon: Icons.chevron_left_rounded, onTap: () {}),
        const Text(
          'Profile',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF0F172A),
          ),
        ),
        _buildCircleButton(icon: Icons.share_outlined, onTap: () {}),
      ],
    );
  }

  Widget _buildCircleButton({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: const Color(0xFFE2E8F0)),
        ),
        child: Icon(icon, color: const Color(0xFF334155), size: 20),
      ),
    );
  }

  // Stack + Positioned: Xếp chồng huy hiệu tích xanh đè lên góc của avatar
  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(3.5),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              // LinearGradient: Dải màu gradient cam - vàng mềm mại bao quanh viền avatar
              gradient: LinearGradient(
                colors: [Color(0xFFFF8A65), Color(0xFFFFB74D), Color(0xFFFF7043)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
            ),
            // CircleAvatar: Cắt hình ảnh tròn hoàn hảo
            child: const CircleAvatar(
              radius: 54,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('image/avatar.png'),
            ),
          ),
          Positioned(
            bottom: 4,
            right: 4,
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Container(
                padding: const EdgeInsets.all(3.5),
                decoration: const BoxDecoration(
                  color: Color(0xFF0288D1),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.check,
                  size: 13,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLocationBadge(String location) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF4F8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.location_on_outlined, size: 14, color: Color(0xFF64748B)),
          const SizedBox(width: 4),
          Text(
            location,
            style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF475569),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsCard() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 12.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        // BoxShadow: Đổ bóng nhẹ phía dưới thẻ tạo cảm giác nổi khối hiện đại
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildStatItem('148', 'Projects'),
          _buildVerticalDivider(),
          _buildStatItem('9 Yrs', 'Experience'),
          _buildVerticalDivider(),
          _buildStatItem('4.9', 'Rating', hasStar: true),
        ],
      ),
    );
  }

  Widget _buildStatItem(String value, String label, {bool hasStar = false}) {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              value,
              style: TextStyle(
                fontSize: 19,
                fontWeight: FontWeight.bold,
                color: hasStar ? const Color(0xFFD97706) : const Color(0xFF0F172A),
              ),
            ),
            if (hasStar) ...[
              const SizedBox(width: 4),
              const Icon(Icons.star_rounded, size: 20, color: Color(0xFFF59E0B)),
            ],
          ],
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF94A3B8),
          ),
        ),
      ],
    );
  }

  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 32,
      color: const Color(0xFFE2E8F0),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.bold,
          color: Color(0xFF0F172A),
        ),
      ),
    );
  }

  // Wrap: Tự động xuống dòng khi các thẻ chip vượt quá chiều ngang màn hình
  Widget _buildSkillsWrap() {
    return Align(
      alignment: Alignment.centerLeft,
      child: Wrap(
        spacing: 10,
        runSpacing: 10,
        children: [
          _buildSkillChip(
            label: 'Flutter',
            icon: Icons.flutter_dash,
            bgColor: const Color(0xFFE0F2FE),
            textColor: const Color(0xFF0284C7),
          ),
          _buildSkillChip(
            label: 'Dart',
            icon: Icons.code_rounded,
            bgColor: const Color(0xFFDCFCE7),
            textColor: const Color(0xFF16A34A),
          ),
          _buildSkillChip(
            label: 'Clean Arch',
            icon: Icons.layers_outlined,
            bgColor: const Color(0xFFFFE4E6),
            textColor: const Color(0xFFE11D48),
          ),
          _buildSkillChip(
            label: 'UI/UX',
            icon: Icons.palette_outlined,
            bgColor: const Color(0xFFF3E8FF),
            textColor: const Color(0xFF9333EA),
          ),
          _buildSkillChip(
            label: 'Firebase',
            icon: Icons.local_fire_department_outlined,
            bgColor: const Color(0xFFFEF3C7),
            textColor: const Color(0xFFD97706),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip({
    required String label,
    required IconData icon,
    required Color bgColor,
    required Color textColor,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 7),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: textColor),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: textColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturedProjects() {
    return Row(
      children: [
        Expanded(
          child: _buildProjectCard(
            title: 'E-Shop Flutter',
            subtitle: 'Mobile App • 2026',
            isCart: true,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildProjectCard(
            title: 'Crypto Vault',
            subtitle: 'Finance • Clean Arch',
            isGradient: true,
          ),
        ),
      ],
    );
  }

  Widget _buildProjectCard({
    required String title,
    required String subtitle,
    bool isCart = false,
    bool isGradient = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      // ClipRRect: Cắt góc trên của ảnh theo độ bo tròn của thẻ
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
            child: Container(
              height: 100,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: isGradient
                    ? const LinearGradient(
                        colors: [Color(0xFFEC4899), Color(0xFF8B5CF6), Color(0xFF3B82F6)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      )
                    : null,
                color: isGradient ? null : const Color(0xFFE2E8F0),
              ),
              child: isCart
                  ? const Center(
                      child: Icon(
                        Icons.shopping_cart_outlined,
                        size: 42,
                        color: Color(0xFF64748B),
                      ),
                    )
                  : (isGradient
                      ? const Center(
                          child: Icon(
                            Icons.currency_bitcoin,
                            size: 42,
                            color: Colors.white70,
                          ),
                        )
                      : null),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF0F172A),
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 11,
                    color: Color(0xFF94A3B8),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildContactCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        children: [
          _buildContactItem(
            icon: Icons.alternate_email_rounded,
            title: 'Contact Information',
            isHeader: true,
          ),
          // Divider: Đường kẻ phân tách mảnh giữa các hàng
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          _buildContactItem(
            icon: Icons.mail_outline_rounded,
            title: 'khang.huynh@email.com',
          ),
          const Divider(height: 1, thickness: 1, color: Color(0xFFF1F5F9)),
          _buildContactItem(
            icon: Icons.phone_outlined,
            title: '+84 (90) 1234-5678',
          ),
        ],
      ),
    );
  }

  Widget _buildContactItem({
    required IconData icon,
    required String title,
    bool isHeader = false,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 14.0),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(7),
            decoration: BoxDecoration(
              color: const Color(0xFFF8FAFC),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: const Color(0xFF334155)),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: TextStyle(
                fontSize: 13.5,
                fontWeight: isHeader ? FontWeight.bold : FontWeight.w500,
                color: isHeader ? const Color(0xFF0F172A) : const Color(0xFF334155),
              ),
            ),
          ),
          const Icon(Icons.chevron_right_rounded, size: 18, color: Color(0xFF94A3B8)),
        ],
      ),
    );
  }
}

// ============================================================================
// 4. TAB 2: MÀN HÌNH BẢN VẼ FIGMA (INTERACTIVE ZOOM IN / ZOOM OUT VIEWER)
// Sử dụng InteractiveViewer: Hỗ trợ phóng to, thu nhỏ và kéo di chuyển 360 độ
// ============================================================================
class FigmaViewerScreen extends StatefulWidget {
  const FigmaViewerScreen({super.key});

  @override
  State<FigmaViewerScreen> createState() => _FigmaViewerScreenState();
}

class _FigmaViewerScreenState extends State<FigmaViewerScreen> {
  // TransformationController: Bộ điều khiển ma trận tọa độ và tỉ lệ zoom
  final TransformationController _transformationController = TransformationController();
  double _currentScale = 1.0;

  // Đường link trực tiếp đến trang Figma của bạn
  final String _figmaUrl =
      'https://www.figma.com/design/xLOcRrYVXHgQxbHIGlUWx9/B%25C3%25A0i-t%25E1%25BA%25ADp-bu%25E1%25BB%2595i-4?node-id=0-1&p=f&t=DFlYu5EUcPIWyhmP-0';

  // Hàm mở trang Figma trực tiếp trên trình duyệt
  Future<void> _openFigmaInBrowser() async {
    final Uri url = Uri.parse(_figmaUrl);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Không thể mở liên kết Figma')),
        );
      }
    }
  }

  // Hàm phóng to (Zoom In +25%)
  void _zoomIn() {
    setState(() {
      _currentScale = (_currentScale * 1.25).clamp(0.5, 6.0);
      _transformationController.value = Matrix4.diagonal3Values(_currentScale, _currentScale, 1.0);
    });
  }

  // Hàm thu nhỏ (Zoom Out -20%)
  void _zoomOut() {
    setState(() {
      _currentScale = (_currentScale * 0.8).clamp(0.5, 6.0);
      _transformationController.value = Matrix4.diagonal3Values(_currentScale, _currentScale, 1.0);
    });
  }

  // Hàm đặt lại tỉ lệ ban đầu (Reset 100%)
  void _resetZoom() {
    setState(() {
      _currentScale = 1.0;
      _transformationController.value = Matrix4.identity();
    });
  }

  @override
  void dispose() {
    _transformationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1E293B), // Màu nền tối giúp làm nổi bật bản vẽ Figma
      appBar: AppBar(
        backgroundColor: const Color(0xFF0F172A),
        foregroundColor: Colors.white,
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Bản vẽ Figma - Bài tập buổi 4',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Dùng chuột cuộn hoặc 2 ngón tay để Zoom ra / vào',
              style: TextStyle(fontSize: 11, color: Colors.white70),
            ),
          ],
        ),
        actions: [
          // Nút bấm mở trực tiếp trang Figma trên trình duyệt (Chrome/Edge)
          ElevatedButton.icon(
            onPressed: _openFigmaInBrowser,
            icon: const Icon(Icons.open_in_browser_rounded, size: 16),
            label: const Text('Mở Figma Web'),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF0284C7),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 12),
        ],
      ),
      // Stack: Chứa khung xem InteractiveViewer và thanh công cụ zoom nổi bên dưới
      body: Stack(
        children: [
          // ============================================================
          // InteractiveViewer: WIDGET QUAN TRỌNG NHẤT ĐỂ ZOOM RA / ZOOM VÀO
          // - panEnabled: Cho phép kéo di chuyển tự do qua lại
          // - scaleEnabled: Cho phép zoom bằng con lăn chuột hoặc chụm 2 ngón tay
          // - minScale & maxScale: Giới hạn độ thu nhỏ (0.5x) và phóng to (6.0x)
          // ============================================================
          InteractiveViewer(
            transformationController: _transformationController,
            panEnabled: true,
            scaleEnabled: true,
            minScale: 0.5,
            maxScale: 6.0,
            boundaryMargin: const EdgeInsets.all(200),
            onInteractionUpdate: (details) {
              // Cập nhật hệ số scale thực tế khi người dùng dùng cử chỉ zoom
              _currentScale = _transformationController.value.getMaxScaleOnAxis();
            },
            child: Center(
              child: Container(
                margin: const EdgeInsets.all(24.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.5),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                // Hiển thị trực tiếp bản thiết kế Figma sắc nét
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(24),
                  child: Image.asset(
                    'image/figma_design.png',
                    fit: BoxFit.contain,
                  ),
                ),
              ),
            ),
          ),

          // ============================================================
          // THANH CÔNG CỤ ĐIỀU KHIỂN ZOOM NỔI (FLOATING ZOOM CONTROLS)
          // ============================================================
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFF0F172A).withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.white24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 15,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Nút Thu nhỏ (-)
                    IconButton(
                      onPressed: _zoomOut,
                      icon: const Icon(Icons.remove_rounded, color: Colors.white),
                      tooltip: 'Thu nhỏ (Zoom Out)',
                    ),
                    const SizedBox(width: 8),
                    // Nút Đặt lại kích thước (Reset)
                    TextButton(
                      onPressed: _resetZoom,
                      child: Text(
                        '${(_currentScale * 100).toInt()}% (Reset)',
                        style: const TextStyle(
                          color: Color(0xFF38BDF8),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Nút Phóng to (+)
                    IconButton(
                      onPressed: _zoomIn,
                      icon: const Icon(Icons.add_rounded, color: Colors.white),
                      tooltip: 'Phóng to (Zoom In)',
                    ),
                    const VerticalDivider(width: 20, thickness: 1, color: Colors.white24),
                    // Hướng dẫn nhanh
                    const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.touch_app_outlined, color: Colors.white70, size: 16),
                        SizedBox(width: 6),
                        Text(
                          'Cuộn chuột để zoom',
                          style: TextStyle(color: Colors.white70, fontSize: 12),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
