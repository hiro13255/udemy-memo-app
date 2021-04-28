import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/model/memo.dart';
import 'package:udemy_flutter/pages/memo_page.dart';

import 'add_edit_memo_page.dart';

class TopPage extends StatefulWidget {
  TopPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _TopPageState createState() => _TopPageState();
}

class _TopPageState extends State<TopPage> {
  CollectionReference memos;

  @override
  void initState() {
    super.initState();
    memos = FirebaseFirestore.instance.collection('memo');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase x Flutter'),
      ),
      //複数のウィジェットを自動生成してくれる。
      // Stremeの内容の変化を感知してbuilderが動作する
      body: StreamBuilder<QuerySnapshot>(
        stream: memos.snapshots(),
        builder: (context, snapshot) {
          //　ドキュメントのdocsを取得街だったときに読込中のウィジェットを表示する。
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(snapshot.data.docs[index].data()['title']),
                // リストの右側に表示
                trailing: IconButton(
                  icon: Icon(Icons.edit),
                  onPressed: () {
                    //ダイアログ表示処理
                    showModalBottomSheet(context: context, builder: (context) {
                      return SafeArea(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            ListTile(
                              leading: Icon(Icons.edit, color: Colors.blueAccent,),
                              title: Text('編集'),
                              onTap: (){
                                Navigator.pop(context);
                                Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditMemoPage(memo: snapshot.data.docs[index])));
                              },
                            ),
                            ListTile(
                              leading: Icon(Icons.delete, color: Colors.redAccent,),
                              title: Text('削除'),
                              onTap: (){

                              },
                            )
                          ],
                        ),
                      );
                    });

                  },
                ),
                onTap: () {
                  //確認画面へ遷移
                  Navigator.push(context, MaterialPageRoute(builder: (context) => MemoPage(snapshot.data.docs[index])));
                },
              );
            },
          );
        }
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddEditMemoPage()));
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
