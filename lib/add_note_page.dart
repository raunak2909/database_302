import 'package:database_302/db_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'db_helper.dart';

class AddNotePage extends StatelessWidget {
  bool isUpdate;
  int id;
  String title;
  String desc;
  DBHelper dbHelper = DBHelper.getInstance();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  AddNotePage({this.isUpdate = false, this.id = 0, this.title = "", this.desc = ""});

  @override
  Widget build(BuildContext context) {

    if(isUpdate){
      titleController.text = title;
      descController.text = desc;
    }


    return Scaffold(
      appBar: AppBar(
        title: Text('Add Note'),
      ),
      body: Container(
        width: double.infinity,
        padding: EdgeInsets.all(11),
        child: Column(
          children: [
            /*Text(
              isUpdate ? 'Update Note' : 'Add Note',
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold),
            ),*/
            SizedBox(
              height: 21,
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Enter title here..",
                label: Text('Title'),
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(11)),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(11)),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            TextField(
              controller: descController,
              minLines: 2,
              maxLines: 3,
              decoration: InputDecoration(
                label: Text('Description'),
                hintText: "Enter desc here..",
                enabledBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(11)),
                focusedBorder: OutlineInputBorder(
                    borderRadius:
                    BorderRadius.circular(11)),
              ),
            ),
            SizedBox(
              height: 11,
            ),
            Row(
              children: [
                Expanded(
                    child: OutlinedButton(
                        onPressed: () async {
                          if (titleController.text.isNotEmpty &&
                              descController.text.isNotEmpty) {

                            bool check = false;

                            if(isUpdate){

                              context.read<DBProvider>().updateNote(mTitle: titleController.text, mDesc: descController.text, mCreatedAt: DateTime.now().millisecondsSinceEpoch.toString(), id: id);
                             /* check = await dbHelper.updateNote(
                                  updatedTitle:
                                  titleController.text,
                                  updatedDesc: descController.text,
                                  updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                  id: id);*/

                            } else {
                              context.read<DBProvider>().addNote(mTitle: titleController.text,
                                mDesc: descController.text,
                                mCreatedAt: DateTime.now().millisecondsSinceEpoch.toString(),);

                              /*check = await dbHelper.addNote(
                                title: titleController.text,
                                desc: descController.text,
                                createdAt: DateTime.now().millisecondsSinceEpoch.toString(),*/

                            }

                            Navigator.pop(context);

                          }
                        },
                        child: Text(isUpdate ? 'Update' : 'Add'))),
                SizedBox(
                  width: 11,
                ),
                Expanded(
                    child: OutlinedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Cancel'))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
