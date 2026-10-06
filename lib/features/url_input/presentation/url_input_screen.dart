import 'package:flutter/material.dart';

class UrlInputScreen extends StatefulWidget {
  const UrlInputScreen({super.key});

  @override
  State<UrlInputScreen> createState() => _UrlInputScreenState();
}

class _UrlInputScreenState extends State<UrlInputScreen> {
  final _apiController = TextEditingController();
  String? _errorMessage;

  @override
  void dispose() {
    _apiController.dispose();
    super.dispose();
  }

  bool _isValidUrl(String value) {
    try {
      final uri = Uri.parse(value.trim());

      if (uri.scheme != 'http' && uri.scheme != 'https') {
        throw ArgumentError();
      }
      if (uri.host.isEmpty) {
        throw ArgumentError();
      }
      return true;
    } catch (_) {
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Home Screen',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 55),

            Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Text(
                'Set valid API base URL in order to continue',
                style: TextStyle(
                  fontSize: 14,

                  fontWeight: FontWeight.w600,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),

            SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _apiController,
                keyboardType: TextInputType.url,
                decoration: InputDecoration(
                  labelText: 'API URL',
                  hintText: 'Enter API URL',
                  border: const OutlineInputBorder(),
                  errorText: _errorMessage,
                  suffixIcon: const Icon(Icons.link),
                ),
              ),
            ),

            const Spacer(),

            Padding(
              padding: const EdgeInsets.all(24.0),
              child: SizedBox(
                width: double.infinity,
                height: 58,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    final url = _apiController.text.trim();
                    if (!_isValidUrl(url)) {
                      setState(() {
                        _errorMessage = 'Invalid URL';
                      });
                      return;
                    }
                    setState(() {
                      _errorMessage = null;
                      _apiController.text = url;
                    });
                  },
                  child: const Text('Start'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
