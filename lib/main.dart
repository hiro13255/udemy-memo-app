import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'pages/top_page.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TopPage(title: 'Flutter Demo Home Page'),
    );
  }
}

//todo Topページにメモリスト表示
//todo リストタップでメモ詳細表示
//todo メモ追加画面のUI作成
//todo 追加ボタンタップでメモ追加
//todo 追加したメモのリアルタイム取得表示
//todo リスト右下のボタンタップでボトムシート表示
//todo 編集画面作成、メモ更新機能
//todo メモ削除機能
