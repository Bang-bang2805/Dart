import 'package:flutter/material.dart';
import 'dart:math' as math; // Để tạo dữ liệu ngẫu nhiên

void main() {
  runApp(MyApp());
}

// --- THAY ĐỔI 1: TẠO LỚP CONTACT ---
class Contact {
  final String name;
  final String phone;

  Contact({required this.name, required this.phone});
}
// --- KẾT THÚC THAY ĐỔI 1 ---

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Contact List Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ContactListScreen(),
    );
  }
}

class ContactListScreen extends StatefulWidget {
  @override
  _ContactListScreenState createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<Contact> _allContacts = [];
  Map<String, List<Contact>> _groupedContacts = {};
  bool _isGrouped = true;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _generateContacts();
    _searchController.addListener(_filterContacts);
  }

  String _generateRandomPhone() {
    final math.Random random = math.Random();
    String phone = '09';
    for (int i = 0; i < 8; i++) {
      phone += random.nextInt(10).toString();
    }
    return phone;
  }

  void _generateContacts() {
    final List<String> ho = [
      'Nguyễn', 'Trần', 'Lê', 'Phạm', 'Hoàng', 'Huỳnh', 'Võ', 'Phan', 'Đặng',
      'Bùi', 'Đỗ', 'Hồ', 'Ngô', 'Dương', 'Lý', 'Đinh', 'Vũ', 'Tạ'
    ];
    final List<String> tenDem = [
      'Văn', 'Thị', 'Minh', 'Ngọc', 'Bảo', 'Gia', 'Đức', 'Quốc', 'Hữu',
      'Phương', 'Khánh', 'Trọng'
    ];
    final List<String> ten = [
      'An', 'Anh', 'Bảo', 'Bình', 'Châu', 'Chi', 'Cường', 'Dũng', 'Dương', 'Đạt',
      'Đức', 'Giang', 'Hà', 'Hải', 'Hiếu', 'Hoà', 'Hoàng', 'Hùng', 'Huy',
      'Khánh', 'Khoa', 'Kiên', 'Lan', 'Linh', 'Long', 'Mai', 'Minh', 'Mạnh',
      'My', 'Nam', 'Nga', 'Ngân', 'Ngọc', 'Nguyên', 'Nhân', 'Nhung', 'Phúc',
      'Phương', 'Quân', 'Quang', 'Quỳnh', 'Sơn', 'Tâm', 'Thảo', 'Thi', 'Thịnh',
      'Thu', 'Thủy', 'Tiến', 'Trang', 'Trí', 'Trung', 'Tuấn', 'Tú', 'Tùng',
      'Vi', 'Việt', 'Vinh', 'Vũ'
    ];

    final math.Random random = math.Random();

    _allContacts = List.generate(150, (index) {
      final hoNgauNhien = ho[random.nextInt(ho.length)];
      final demNgauNhien = tenDem[random.nextInt(tenDem.length)];
      final tenNgauNhien = ten[random.nextInt(ten.length)];

      return Contact(
        name: '$hoNgauNhien $demNgauNhien $tenNgauNhien',
        phone: _generateRandomPhone(),
      );
    });

    _allContacts.sort((a, b) => a.name.compareTo(b.name));
    _filterContacts();
  }

  void _filterContacts() {
    final String query = _searchController.text.toLowerCase();

    final List<Contact> filteredList = _allContacts.where((contact) {
      return contact.name.toLowerCase().contains(query);
    }).toList();

    final Map<String, List<Contact>> grouped = {};

    if (_isGrouped) {
      for (var contact in filteredList) {
        final String firstLetter = contact.name[0].toUpperCase();
        if (grouped[firstLetter] == null) {
          grouped[firstLetter] = [];
        }
        grouped[firstLetter]!.add(contact);
      }
    } else {
      if (filteredList.isNotEmpty) {
        grouped['Tất cả liên hệ'] = filteredList;
      }
    }

    setState(() {
      _groupedContacts = grouped;
    });
  }

  Future<void> _refreshData() async {
    setState(() {
      _isLoading = true;
      _isGrouped = !_isGrouped;
    });

    await Future.delayed(Duration(seconds: 2));

    setState(() {
      _generateContacts();
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh Bạ (${_allContacts.length})'),
        actions: [
          Icon(
            _isGrouped ? Icons.segment : Icons.list,
            size: 30,
          ),
          SizedBox(width: 16),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                labelText: 'Tìm Kiếm Danh Bạ',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: _refreshData,
              child: _groupedContacts.isEmpty && !_isLoading
                  ? Center(child: Text('Không tìm thấy liên hệ nào.'))
                  : CustomScrollView(
                slivers: _groupedContacts.keys.map((String letter) {
                  final List<Contact> contacts = _groupedContacts[letter]!;

                  return [
                    SliverPersistentHeader(
                      pinned: true,
                      delegate: _SectionHeaderDelegate(title: letter),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                            (context, index) {
                          final contact = contacts[index];
                          return ListTile(
                            leading: CircleAvatar(
                              child: Text(contact.name[0]),
                            ),
                            title: Text(contact.name),
                            subtitle: Text(contact.phone),
                          );
                        },
                        childCount: contacts.length,
                      ),
                    ),
                  ];
                }).expand((sliver) => sliver).toList(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeaderDelegate extends SliverPersistentHeaderDelegate {
  final String title;
  final double height;

  _SectionHeaderDelegate({required this.title, this.height = 50});

  @override
  double get minExtent => height;
  @override
  double get maxExtent => height;

  @override
  Widget build(
      BuildContext context,
      double shrinkOffset,
      bool overlapsContent,
      ) {
    return Container(
      color: Colors.grey[300],
      padding: EdgeInsets.symmetric(horizontal: 16),
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(_SectionHeaderDelegate oldDelegate) {
    return title != oldDelegate.title || height != oldDelegate.height;
  }
}
