import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(const MyApp());
}

// ============================================================================
// WIDGET GỐC CỦA ỨNG DỤNG (MYAPP)
// StatelessWidget: Widget tĩnh không lưu trữ trạng thái thay đổi
// ============================================================================
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // MaterialApp: Widget bao bọc toàn bộ ứng dụng, cung cấp theme và định tuyến
    return MaterialApp(
      title: 'Profile Huỳnh Nguyên Khang',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        scaffoldBackgroundColor: const Color(0xFFF7F9FC), // Nền xám nhạt hiện đại
      ),
      home: const ProfileScreen(), // Mở trực tiếp giao diện Profile của Huỳnh Nguyên Khang
    );
  }
}

// ============================================================================
// MÀN HÌNH CHÍNH: HỒ SƠ CÁ NHÂN (PROFILE HUỲNH NGUYÊN KHANG)
// ============================================================================
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Hàm mở đường dẫn Figma trên trình duyệt khi cần
  Future<void> _openFigmaLink() async {
    final Uri url = Uri.parse(
      'https://www.figma.com/design/xLOcRrYVXHgQxbHIGlUWx9/B%25C3%25A0i-t%25E1%25BA%25ADp-bu%25E1%25BB%2595i-4?node-id=0-1&p=f&t=DFlYu5EUcPIWyhmP-0',
    );
    await launchUrl(url, mode: LaunchMode.externalApplication);
  }

  @override
  Widget build(BuildContext context) {
    // Scaffold: Khung giao diện chuẩn (quản lý vùng hiển thị chính của màn hình)
    return Scaffold(
      // SafeArea: Tự động căn lề tránh tai thỏ, camera đục lỗ trên điện thoại
      body: SafeArea(
        // Center + ConstrainedBox: Căn giữa và giới hạn độ rộng tối đa chuẩn giao diện mobile (480px)
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            // SingleChildScrollView: Cho phép cuộn trang mượt mà khi nội dung vượt quá chiều cao màn hình
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0),
              // Column: Sắp xếp các thành phần từ trên xuống dưới theo chiều dọc
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  // 1. THANH TIÊU ĐỀ TRÊN CÙNG (TOP BAR)
                  _buildTopBar(),

                  const SizedBox(height: 24),

                  // 2. HÌNH ẢNH AVATAR VIỀN GRADIENT & HUY HIỆU XÁC THỰC
                  _buildAvatarSection(),

                  const SizedBox(height: 16),

                  // 3. THÔNG TIN TÊN, NGHỀ NGHIỆP & VỊ TRÍ
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

                  // 4. BẢNG THỐNG KÊ CHỈ SỐ (STATS CARD)
                  _buildStatsCard(),

                  const SizedBox(height: 28),

                  // 5. GIỚI THIỆU BẢN THÂN (ABOUT ME)
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

                  // 6. KỸ NĂNG & CHUYÊN MÔN (SKILLS & EXPERTISE)
                  _buildSectionTitle('Skills & Expertise'),
                  const SizedBox(height: 12),
                  _buildSkillsWrap(),

                  const SizedBox(height: 28),

                  // 7. DỰ ÁN NỔI BẬT (FEATURED PROJECTS)
                  _buildSectionTitle('Featured Projects'),
                  const SizedBox(height: 14),
                  _buildFeaturedProjects(),

                  const SizedBox(height: 28),

                  // 8. THÔNG TIN LIÊN HỆ (CONTACT INFORMATION)
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

  // --- HÀM TẠO THANH TIÊU ĐỀ TRÊN CÙNG ---
  // Row: Xếp các phần tử con theo chiều ngang từ trái qua phải
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
        // Nút Share: Bấm để mở liên kết Figma trên trình duyệt
        _buildCircleButton(icon: Icons.share_outlined, onTap: _openFigmaLink),
      ],
    );
  }

  // Nút tròn bo góc có viền nhẹ
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

  // --- HÀM TẠO AVATAR CÓ VIỀN GRADIENT VÀ HUY HIỆU XÁC MINH ---
  // Stack: Cho phép các widget xếp đè lên nhau
  Widget _buildAvatarSection() {
    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Container có Gradient: Tạo vòng tròn viền ngoài chuyển sắc cam - hồng
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
            // CircleAvatar bên trong: Chứa hình ảnh avatar thật của Huỳnh Nguyên Khang
            child: const CircleAvatar(
              radius: 54,
              backgroundColor: Colors.white,
              backgroundImage: AssetImage('image/avatar.png'),
            ),
          ),
          // Positioned: Định vị huy hiệu tích xanh ở góc dưới bên phải avatar
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
                  color: Color(0xFF0288D1), // Màu xanh dương xác minh
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

  // Huy hiệu vị trí (Location Badge)
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

  // --- HÀM TẠO THẺ THỐNG KÊ (STATS CARD) ---
  // Container: Nền trắng, bo góc 20, đổ bóng mềm mại
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

  // Mục con trong bảng thống kê
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

  // Vạch kẻ ngăn cách dọc mảnh
  Widget _buildVerticalDivider() {
    return Container(
      width: 1,
      height: 32,
      color: const Color(0xFFE2E8F0),
    );
  }

  // Tiêu đề các mục lớn (Section Title)
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

  // --- HÀM TẠO DANH SÁCH KỸ NĂNG (SKILLS) ---
  // Wrap: Tự động xuống dòng khi các phần tử vượt quá chiều rộng màn hình
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

  // Thẻ chip kỹ năng có bo tròn và màu sắc theo chủ đề
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

  // --- HÀM TẠO DỰ ÁN NỔI BẬT (FEATURED PROJECTS) ---
  // Row + Expanded: Chia 2 thẻ dự án bằng nhau sang 2 bên
  Widget _buildFeaturedProjects() {
    return Row(
      children: [
        Expanded(
          child: _buildProjectCard(
            title: 'E-Shop Flutter',
            subtitle: 'Mobile App • 2026',
            imagePlaceholderColor: const Color(0xFF334155),
            isCart: true,
          ),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: _buildProjectCard(
            title: 'Crypto Vault',
            subtitle: 'Finance • Clean Arch',
            imagePlaceholderColor: const Color(0xFF8B5CF6),
            isGradient: true,
          ),
        ),
      ],
    );
  }

  // Thẻ dự án con gồm hình ảnh phía trên và chữ phía dưới
  Widget _buildProjectCard({
    required String title,
    required String subtitle,
    required Color imagePlaceholderColor,
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

  // --- HÀM TẠO THẺ THÔNG TIN LIÊN HỆ (CONTACT INFORMATION) ---
  // Container bọc các mục liên hệ phân cách bởi Divider
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

  // Mục chi tiết trong thẻ liên hệ
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
