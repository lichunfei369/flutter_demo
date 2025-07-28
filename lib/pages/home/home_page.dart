import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _isLoading = true;
  List<dynamic> _burgers = [];
  String? _errorMessage;

  // 汉堡数据模型
  Map<String, dynamic> _createBurgerModel(Map<String, dynamic> json) {
    return {
      'id': json['id'] ?? '',
      'img': json['img'] ?? '',
      'name': json['name'] ?? '',
      'dsc': json['dsc'] ?? '',
      'price': json['price'] ?? 0,
      'rate': json['rate'] ?? 0,
      'country': json['country'] ?? '',
    };
  }

  // 请求汉堡数据的方法
  Future<void> fetchBurgers() async {
    print('=== 自动获取汉堡数据 ===');

    try {
      print('=== 发起HTTP请求到汉堡API ===');

      // 发起GET请求到汉堡API
      final response = await http.get(
        Uri.parse('https://free-food-menus-api-two.vercel.app/burgers'),
        headers: {'Content-Type': 'application/json'},
      );

      print('=== 收到响应：${response.statusCode} ===');

      // 检查响应状态
      if (response.statusCode == 200) {
        // 解析JSON数据
        List<dynamic> burgers = jsonDecode(response.body);

        // 打印完整的JSON数据到控制台
        print('==================== 完整汉堡JSON响应 ====================');
        print(response.body);
        print('=======================================================');

        // 打印前3条数据（格式化显示）
        print('\n==================== 前3条汉堡数据详情 ====================');
        for (int i = 0; i < (burgers.length > 3 ? 3 : burgers.length); i++) {
          var burger = _createBurgerModel(burgers[i]);
          print('--- 汉堡 ${i + 1} ---');
          print('ID: ${burger['id']}');
          print('名称: ${burger['name']}');
          print('描述: ${burger['dsc']}');
          print('价格: \$${burger['price']}');
          print('评分: ${burger['rate']}');
          print('地区: ${burger['country']}');
          print('图片: ${burger['img']}');
          print('');
        }
        print('=====================================================');

        setState(() {
          _burgers = burgers;
          _isLoading = false;
          _errorMessage = null;
        });

        print('✅ 成功加载 ${burgers.length} 个汉堡数据');
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = '请求失败：状态码 ${response.statusCode}';
        });
      }
    } catch (e) {
      print('=== 请求错误：$e ===');
      setState(() {
        _isLoading = false;
        _errorMessage = '网络请求失败: $e';
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print('HomePage 已初始化，开始自动加载汉堡数据');
    // 页面加载时自动请求数据
    fetchBurgers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('汉堡菜单'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
        actions: [
          // 刷新按钮
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              setState(() {
                _isLoading = true;
                _errorMessage = null;
              });
              fetchBurgers();
            },
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    // 加载中状态
    if (_isLoading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
            SizedBox(height: 16),
            Text(
              '正在加载汉堡数据...',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
          ],
        ),
      );
    }

    // 错误状态
    if (_errorMessage != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 80, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              '加载失败',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.red[700],
              ),
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Text(
                _errorMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton.icon(
              onPressed: () {
                setState(() {
                  _isLoading = true;
                  _errorMessage = null;
                });
                fetchBurgers();
              },
              icon: const Icon(Icons.refresh),
              label: const Text('重新加载'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
        ),
      );
    }

    // 数据为空状态
    if (_burgers.isEmpty) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu, size: 80, color: Colors.grey),
            SizedBox(height: 16),
            Text('暂无汉堡数据', style: TextStyle(fontSize: 18, color: Colors.grey)),
          ],
        ),
      );
    }

    // 汉堡列表
    return RefreshIndicator(
      color: Colors.orange,
      onRefresh: () async {
        await fetchBurgers();
      },
      child: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _burgers.length,
        itemBuilder: (context, index) {
          var burger = _createBurgerModel(_burgers[index]);
          return Card(
            margin: const EdgeInsets.only(bottom: 16),
            elevation: 4,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 汉堡图片
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(12),
                  ),
                  child:
                      burger['img'].isNotEmpty
                          ? Image.network(
                            burger['img'],
                            width: double.infinity,
                            height: 200,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey[200],
                                child: Center(
                                  child: CircularProgressIndicator(
                                    value:
                                        loadingProgress.expectedTotalBytes !=
                                                null
                                            ? loadingProgress
                                                    .cumulativeBytesLoaded /
                                                loadingProgress
                                                    .expectedTotalBytes!
                                            : null,
                                    valueColor:
                                        const AlwaysStoppedAnimation<Color>(
                                          Colors.orange,
                                        ),
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                width: double.infinity,
                                height: 200,
                                color: Colors.grey[300],
                                child: const Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.fastfood,
                                      size: 50,
                                      color: Colors.grey,
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      '图片加载失败',
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          )
                          : Container(
                            width: double.infinity,
                            height: 200,
                            color: Colors.grey[300],
                            child: const Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.fastfood,
                                  size: 50,
                                  color: Colors.grey,
                                ),
                                SizedBox(height: 8),
                                Text(
                                  '暂无图片',
                                  style: TextStyle(
                                    color: Colors.grey,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                ),

                // 汉堡信息
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 标题和评分
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  burger['name'],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  burger['dsc'],
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          // 评分
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.amber,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  size: 16,
                                  color: Colors.white,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  '${burger['rate']}',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 12),

                      // 价格和地区
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // 价格
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              '\$${burger['price']}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ),

                          // 地区
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on,
                                size: 16,
                                color: Colors.grey,
                              ),
                              const SizedBox(width: 4),
                              Text(
                                burger['country'],
                                style: TextStyle(
                                  color: Colors.grey[600],
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
