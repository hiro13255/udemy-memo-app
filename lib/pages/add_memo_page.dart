import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddMemoPage extends StatefulWidget {
  @override
  _AddMemoPageState createState() => _AddMemoPageState();
}

class _AddMemoPageState extends State<AddMemoPage> {
  TextEditingController titleControllor = TextEditingController();
  TextEditingController detailControllor = TextEditingController();

  Future<void> addMemo() async {
    var collection = FirebaseFirestore.instance.collection('memo');
    await collection.add({
      'title': titleControllor.text,
      'detail': detailControllor.text,
      'created_date': Timestamp.now()
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('メモ追加'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Text('タイトル'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey)
                ),
                width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: titleControllor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10)
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top:40.0),
              child: Text('メモ内容'),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey)),
                  width: MediaQuery.of(context).size.width * 0.8,
                  child: TextField(
                    controller: detailControllor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.only(left: 10)
                    ),
                  )
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30.0),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.8,
                alignment: Alignment.center,
                child: RaisedButton(
                  color: Theme.of(context).primaryColor,
                  onPressed: () async{
                    //メモ追加の処理
                    await addMemo();
                    Navigator.pop(context);
                  },
                  child: Text('追加', style: TextStyle(color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}