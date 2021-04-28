import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddEditMemoPage extends StatefulWidget {
  final QueryDocumentSnapshot memo;
  AddEditMemoPage({this.memo});

  @override
  _AddEditMemoPageState createState() => _AddEditMemoPageState();
}

class _AddEditMemoPageState extends State<AddEditMemoPage> {
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

  Future<void> updateMemo() async{
    var document = FirebaseFirestore.instance.collection('memo').doc(widget.memo.id);
    document.update({
      'title': titleControllor.text,
      'detail': detailControllor.text,
      'update_time': Timestamp.now()
    });
  }

  @override
  void initState() {
    super.initState();

    if(widget.memo != null) {
      titleControllor.text = widget.memo.data()['title'];
      detailControllor.text = widget.memo.data()['detail'];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.memo == null ? 'メモ追加' : 'メモを編集'),
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
                    if (widget.memo == null) {
                      await addMemo();
                    } else {
                      await updateMemo();
                    }
                    Navigator.pop(context);
                  },
                  child: Text(widget.memo == null ? '追加' : '編集', style: TextStyle(color: Colors.white),),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
