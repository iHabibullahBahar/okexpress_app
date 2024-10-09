import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:okexpress/src/common/services/custom_snackbar_service.dart';
import 'package:okexpress/src/utils/colors.dart';

class WebViewPage extends StatefulWidget {
  String url;
  String? authToken;
  String title;
  String pageName;
  String method;
  String refCode;
  WebViewPage({
    Key? key,
    required this.url,
    this.authToken = "",
    required this.title,
    this.pageName = "",
    this.method = 'GET',
    this.refCode = "",
  }) : super(key: key);

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  double _progress = 0;

  @override
  Widget build(BuildContext context) {
    Map<String, String> body = {
      "code": widget.refCode,
    };
    String jsonBody = jsonEncode(body);
    Uint8List bodyBytes = Uint8List.fromList(utf8.encode(jsonBody));
    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        backgroundColor: zBackgroundColor,
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          backgroundColor: zBackgroundColor,
          elevation: 0,
          centerTitle: true,
          title: Text(
            widget.title,
            style: const TextStyle(color: zTextColor),
          ),
          iconTheme: const IconThemeData(color: zTextColor),
        ),
        body: SafeArea(
          child: Stack(
            children: [SizedBox()],
          ),
        ),
      ),
    );
  }
}
