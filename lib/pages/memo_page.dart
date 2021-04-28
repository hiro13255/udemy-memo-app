import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:udemy_flutter/model/memo.dart';

class MemoPage extends StatelessWidget {
  //　メモ型の値を送って来てねという意味になる。
  final QueryDocumentSnapshot memo;
  MemoPage(this.memo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(memo.data()['title']),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('メモ内容',style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(memo.data()['detail'], style: TextStyle(fontSize: 18),)
         ],
        ),
      )
    );
  }
}
