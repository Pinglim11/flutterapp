import 'dart:io';
import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';


//Headless
class HeadlessWebViewPage extends StatefulWidget {
  @override
  _HeadlessWebViewPageState createState() => new _HeadlessWebViewPageState();
}

class _HeadlessWebViewPageState extends State<HeadlessWebViewPage> {
  HeadlessInAppWebView? headlessWebView;
  String url = "";

  @override
  void initState() {
    super.initState();

    headlessWebView = new HeadlessInAppWebView(
      initialUrlRequest:
      URLRequest(url: Uri.parse("https://github.com/flutter")),
      onWebViewCreated: (controller) {
        final snackBar = SnackBar(
          content: Text('HeadlessInAppWebView created!'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onConsoleMessage: (controller, consoleMessage) {
        final snackBar = SnackBar(
          content: Text('Console Message: ${consoleMessage.message}'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      },
      onLoadStart: (controller, url) async {
        final snackBar = SnackBar(
          content: Text('onLoadStart $url'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
      onLoadStop: (controller, url) async {
        final snackBar = SnackBar(
          content: Text('onLoadStop $url'),
          duration: Duration(seconds: 1),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);

        setState(() {
          this.url = url?.toString() ?? '';
        });
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    headlessWebView?.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: Text(
              "HeadlessInAppWebView Example",
            )),
        body: SafeArea(
            child: Column(children: <Widget>[
              Container(
                padding: EdgeInsets.all(20.0),
                child: Text(
                    "URL: ${(url.length > 50) ? url.substring(0, 50) + "..." : url}"),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      await headlessWebView?.dispose();
                      await headlessWebView?.run();
                    },
                    child: Text("Run HeadlessInAppWebView")),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () async {
                      if (headlessWebView?.isRunning() ?? false) {
                        await headlessWebView?.webViewController.evaluateJavascript(
                            source: "console.log('Here is the message!');");
                      } else {
                        final snackBar = SnackBar(
                          content: Text(
                              'HeadlessInAppWebView is not running. Click on "Run HeadlessInAppWebView"!'),
                          duration: Duration(milliseconds: 1500),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      }
                    },
                    child: Text("Send console.log message")),
              ),
              Center(
                child: ElevatedButton(
                    onPressed: () {
                      headlessWebView?.dispose();
                      setState(() {
                        this.url = '';
                      });
                    },
                    child: Text("Dispose HeadlessInAppWebView")),
              )
            ])));
  }
}

//Headless


class WebViewPage extends StatefulWidget {
  WebViewPage({Key? key,required this.title}) : super(key: key);

  final String title;

  @override
  _WebViewPageState createState() => new _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
      crossPlatform: InAppWebViewOptions(
        useShouldOverrideUrlLoading: true,
        mediaPlaybackRequiresUserGesture: false,
      ),
      android: AndroidInAppWebViewOptions(
        useHybridComposition: true,
      ),
      ios: IOSInAppWebViewOptions(
        allowsInlineMediaPlayback: true,
      ));

  late PullToRefreshController pullToRefreshController;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
              title: Center(
                child: Text(widget.title),
              ),
            actions: [
            ],
          ),
          body: SafeArea(
              child: Column(children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back),
                      constraints: const BoxConstraints(maxWidth:32),
                      onPressed: () {
                        webViewController?.goBack();
                        },
                    ),
                    IconButton(
                      icon: Icon(Icons.arrow_forward),
                      constraints: const BoxConstraints(maxWidth:32),
                      onPressed: () {
                        webViewController?.goForward();
                      },
                    ),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search)
                        ),
                        controller: urlController,
                        keyboardType: TextInputType.url,
                        onSubmitted: (value) {
                          var url = Uri.parse(value);
                          if (url.scheme.isEmpty) {
                            url = Uri.parse("https://www.google.com/search?q=" + value);
                          }
                          webViewController?.loadUrl(
                              urlRequest: URLRequest(url: url));
                        },
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.refresh),
                      onPressed: () {
                        webViewController?.reload();
                      },
                    ),
                  ]
                ),
                Expanded(
                  child: Stack(
                    children: [
                      InAppWebView(
                        key: webViewKey,
                        initialUrlRequest: URLRequest(url: Uri.parse("https://www.google.com/")),
                        initialOptions: options,
                        pullToRefreshController: pullToRefreshController,
                        onWebViewCreated: (controller) {
                          webViewController = controller;
                        },
                        onLoadStart: (controller, url) {
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        androidOnPermissionRequest: (controller, origin, resources) async {
                          return PermissionRequestResponse(
                              resources: resources,
                              action: PermissionRequestResponseAction.GRANT);
                        },
                        shouldOverrideUrlLoading: (controller, navigationAction) async {
                          var uri = navigationAction.request.url!;

                          if (![ "http", "https", "file", "chrome",
                            "data", "javascript", "about"].contains(uri.scheme)) {
                            if (await canLaunch(url)) {
                              // Launch the App
                              await launch(
                                url,
                              );
                              // and cancel the request
                              return NavigationActionPolicy.CANCEL;
                            }
                          }

                          return NavigationActionPolicy.ALLOW;
                        },
                        onLoadStop: (controller, url) async {
                          pullToRefreshController.endRefreshing();
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        onLoadError: (controller, url, code, message) {
                          pullToRefreshController.endRefreshing();
                        },
                        onProgressChanged: (controller, progress) {
                          if (progress == 100) {
                            pullToRefreshController.endRefreshing();
                          }
                          setState(() {
                            this.progress = progress / 100;
                            urlController.text = this.url;
                          });
                        },
                        onUpdateVisitedHistory: (controller, url, androidIsReload) {
                          setState(() {
                            this.url = url.toString();
                            urlController.text = this.url;
                          });
                        },
                        onConsoleMessage: (controller, consoleMessage) {
                          print(consoleMessage);
                        },
                      ),
                      progress < 1.0
                          ? LinearProgressIndicator(value: progress)
                          : Container(),
                    ],
                  ),
                ),

              ]))),
    );
  }
}