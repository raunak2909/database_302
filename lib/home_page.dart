import 'package:database_302/add_note_page.dart';
import 'package:database_302/db_helper.dart';
import 'package:database_302/db_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {

  List<Map<String, dynamic>> allNotes = [];
  DateFormat mFormat = DateFormat.yMd();


  @override
  Widget build(BuildContext context) {

    context.read<DBProvider>().getInitialNotes();



    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Consumer<DBProvider>(
        builder: (_, provider, __){

          allNotes = provider.getAllNotes();

          return allNotes.isNotEmpty
              ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                      Text(mFormat.format(DateTime.fromMillisecondsSinceEpoch(int.parse(allNotes[index][DBHelper.COLUMN_NOTE_CREATED_AT]))), style: TextStyle(fontSize: 10),),
                    ],
                  ),
                  subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        ///update
                        IconButton(
                            onPressed: () async{
                              var title = allNotes[index][DBHelper.COLUMN_NOTE_TITLE];
                              var desc = allNotes[index][DBHelper.COLUMN_NOTE_DESC];
                              Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(isUpdate: true, id: allNotes[index][DBHelper.COLUMN_NOTE_ID], title: title, desc: desc,),));

                              /*showModalBottomSheet(context: context, builder: (_){
                                return getBottomSheetUI(isUpdate: true, id: allNotes[index][DBHelper.COLUMN_NOTE_ID]);
                              });*/

                            },
                            icon: Icon(Icons.edit)),
                        ///delete
                        IconButton(
                            onPressed: () async{
                              /*bool check = await dbHelper.deleteNote(id: allNotes[index][DBHelper.COLUMN_NOTE_ID]);
                              if(check){
                                getMyNotes();
                              }*/
                            },
                            icon: Icon(
                              Icons.delete,
                              color: Colors.red,
                            )),
                      ],
                    ),
                  ),
                );
              })
              : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('No Notes yet'),
                OutlinedButton(
                    onPressed: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(),));

                      /*showModalBottomSheet(
                            isDismissible: false,
                            enableDrag: false,
                            context: context,
                            builder: (_) {
                              return getBottomSheetUI();
                            });*/
                    },
                    child: Text('Add First Note'))
              ],
            ),
          );
        },
      ),
      floatingActionButton: context.watch<DBProvider>().getAllNotes().isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                Navigator.push(context, MaterialPageRoute(builder: (context) => AddNotePage(),));
                /*showModalBottomSheet(
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (_) {
                      return getBottomSheetUI();
                    });*/
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  /*void getMyNotes() async {
    allNotes = await dbHelper.getAllNotes();
    setState(() {});
  }*/

/*Widget getBottomSheetUI({bool isUpdate = false, int id = 0}){
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(11),
      child: Column(
        children: [
          Text(
            isUpdate ? 'Update Note' : 'Add Note',
            style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold),
          ),
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
                            check = await dbHelper.updateNote(
                                updatedTitle:
                                titleController.text,
                                updatedDesc: descController.text,
                                updatedAt: DateTime.now().millisecondsSinceEpoch.toString(),
                                id: id);

                          } else {
                            check = await dbHelper.addNote(
                                title: titleController.text,
                                desc: descController.text,
                                createdAt: DateTime.now().millisecondsSinceEpoch.toString(),
                            );

                          }

                          if (check) {
                            getMyNotes();
                            Navigator.pop(context);
                          }
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
    );
  }*/
}
