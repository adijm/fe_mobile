import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HistoryScreen extends StatefulWidget {
  const HistoryScreen({super.key});

  @override
  State<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  List<HistoryItem> historyItems = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchHistory();
  }

  Future<void> fetchHistory() async {
    try {
      final response = await http.get(Uri.parse('https://yourdomain.com/api/history'));

      if (response.statusCode == 200) {
        final List data = jsonDecode(response.body);

        setState(() {
          historyItems = data.map((item) => HistoryItem(
            dateTime: item['date_time'],
            message: item['message'],
          )).toList();
          isLoading = false;
        });
      } else {
        setState(() {
          historyItems = [];
          isLoading = false;
        });
      }
    } catch (e) {
      print('Error: $e');
      setState(() {
        historyItems = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('History'),
        centerTitle: true,
        backgroundColor: const Color(0xFFB3D7F3),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : historyItems.isEmpty
              ? const Center(
                  child: Text(
                    'Belum ada aktivitas.',
                    style: TextStyle(fontSize: 16, color: Colors.grey),
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: historyItems.length,
                  separatorBuilder: (context, index) => const Divider(
                    height: 32,
                    thickness: 1,
                    color: Color(0xFFDDDDDD),
                  ),
                  itemBuilder: (context, index) {
                    final item = historyItems[index];
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.dateTime,
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.grey,
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          item.message,
                          style: const TextStyle(
                            fontSize: 15.5,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    );
                  },
                ),
    );
  }
}

class HistoryItem {
  final String dateTime;
  final String message;

  const HistoryItem({
    required this.dateTime,
    required this.message,
  });
}
