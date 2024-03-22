import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

class WebViewContainer extends StatefulWidget {
  const WebViewContainer({super.key});

  @override
  State<WebViewContainer> createState() => _WebViewContainerState();
}

class _WebViewContainerState extends State<WebViewContainer> {

  static String sampleHTML = '''
<html>
<body>
<h1>Hello World</h1>
<iframe title="ksp-prototype" width="1140" height="541.25" src="https://app.powerbi.com/reportEmbed?reportId=52aefa0d-8f6a-400d-8f25-5fbf820b5fb8&autoAuth=true&ctid=813e6569-4e44-4d95-88a0-16a97bd5277c" frameborder="0" allowFullScreen="true"></iframe>
</body>
</html>
''';


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
      title : const Text("Web Container")
    ),
    body: HtmlWidget(sampleHTML),
    );
  }
}