import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/model/memo.dart';
import 'package:udemy_flutter/pages/memo_page.dart';

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  List<Memo> memoList = [];

  Future<void> getMemo() async {
    // getの処理に時間がかかる為、awaitで終了するまで待つ
    var snapshot = await FirebaseFirestore.instance.collection('memo').get();
    // docsというのがFirebaseで登録したドキュメントに対応する
    var docs = snapshot.docs;
    docs.forEach((doc) {
      memoList.add(Memo(
        title: doc.data()['title'],
        detail: doc.data()['detail']
      ));
    });
    // 画面を再描画
    setState(() {

    });
  }

  @override
  void initState() {
    super.initState();
    getMemo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase x Flutter'),
      ),
      //複数のウィジェットを自動生成してくれる。
      body: ListView.builder(
        itemCount: memoList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(memoList[index].title),
            onTap: () {
              //確認画面へ遷移
              Navigator.push(context, MaterialPageRoute(builder: (context) => MemoPage(memoList[index])));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
