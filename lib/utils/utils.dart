import 'package:flutter/material.dart';
import 'package:markdown/markdown.dart';
import 'package:webview_flutter/webview_flutter.dart';

Widget buildWebView(String text,WebViewController controller) {
  markdownToHtml(text,extensionSet: ExtensionSet.gitHubFlavored);
  WebViewWidget widget = WebViewWidget(controller: controller);
  return Container(child: widget,);
}