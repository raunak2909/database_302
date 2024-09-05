import 'package:database_302/db_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  DBHelper dbHelper = DBHelper.getInstance();
  TextEditingController titleController = TextEditingController();
  TextEditingController descController = TextEditingController();

  List<Map<String, dynamic>> allNotes = [];

  @override
  void initState() {
    super.initState();
    getMyNotes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: allNotes.isNotEmpty
          ? ListView.builder(
              itemCount: allNotes.length,
              itemBuilder: (_, index) {
                return ListTile(
                  title: Text(allNotes[index][DBHelper.COLUMN_NOTE_TITLE]),
                  subtitle: Text(allNotes[index][DBHelper.COLUMN_NOTE_DESC]),
                  trailing: SizedBox(
                    width: 100,
                    child: Row(
                      children: [
                        IconButton(
                            onPressed: () async{
                              bool check = await dbHelper.updateNote(
                                  updatedTitle: "Updated Note",
                                  updatedDesc: "Updated desc",
                                  id: allNotes[index][DBHelper.COLUMN_NOTE_ID]);

                              if(check){
                                getMyNotes();
                              }

                            },
                            icon: Icon(Icons.edit)),
                        IconButton(
                            onPressed: () {

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
                        showModalBottomSheet(
                            isDismissible: false,
                            enableDrag: false,
                            context: context,
                            builder: (_) {
                              return Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(11),
                                child: Column(
                                  children: [
                                    Text(
                                      'Add Note',
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
                                                  if (titleController
                                                          .text.isNotEmpty &&
                                                      descController
                                                          .text.isNotEmpty) {
                                                    bool check =
                                                        await dbHelper.addNote(
                                                            title:
                                                                titleController
                                                                    .text,
                                                            desc: descController
                                                                .text);

                                                    if (check) {
                                                      getMyNotes();
                                                      Navigator.pop(context);
                                                    }
                                                  }
                                                },
                                                child: Text('Add'))),
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
                            });
                      },
                      child: Text('Add First Note'))
                ],
              ),
            ),
      floatingActionButton: allNotes.isNotEmpty
          ? FloatingActionButton(
              onPressed: () async {
                titleController.clear();
                descController.clear();
                showModalBottomSheet(
                    isDismissible: false,
                    enableDrag: false,
                    context: context,
                    builder: (_) {
                      return Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(11),
                        child: Column(
                          children: [
                            Text(
                              'Add Note',
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
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
                                    borderRadius: BorderRadius.circular(11)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11)),
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
                                    borderRadius: BorderRadius.circular(11)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(11)),
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
                                            bool check = await dbHelper.addNote(
                                                title: titleController.text,
                                                desc: descController.text);

                                            if (check) {
                                              getMyNotes();
                                              Navigator.pop(context);
                                            }
                                          }
                                        },
                                        child: Text('Add'))),
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
                    });
              },
              child: Icon(Icons.add),
            )
          : null,
    );
  }

  void getMyNotes() async {
    allNotes = await dbHelper.getAllNotes();
    setState(() {});
  }

/*Widget getBottomSheetUI(){
    return Container();
  }*/
}
