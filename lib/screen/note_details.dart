import 'package:flutter/material.dart';
import 'package:todo_my/screen/add_note.dart';
import 'package:todo_my/model/note.dart';
import 'package:todo_my/repositories/db_helper.dart';
import 'package:intl/intl.dart';

class NoteDetails extends StatefulWidget {

  final int noteId;
  
  const NoteDetails({
    Key? key,
    required this.noteId,
  }) : super(key: key);


  @override
  _NoteDetailsState createState() => _NoteDetailsState();
}

class _NoteDetailsState extends State<NoteDetails> {
  late Note note;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNote();
  }

  Future refreshNote() async {
    setState(() => isLoading = true);

    this.note = await DBHelper.instance.readNote(widget.noteId);

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          actions: [buildEditbutton(), buildDeletebutton()],
        ),
        body: isLoading
            ? Center(child: CircularProgressIndicator())
            : Padding(
                padding: EdgeInsets.all(12),
                child: ListView(
                  padding: EdgeInsets.symmetric(vertical: 8),
                  children: [
                    Text(
                      note.title,
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      DateFormat.yMMMd().format(note.createdTime),
                      style: TextStyle(color: Colors.white38),
                    ),
                    SizedBox(height: 8),
                    Text(
                      note.task,
                      style: TextStyle(color: Colors.white70, fontSize: 18),
                    )
                  ],
                ),
              ),  
    );
  }

  Widget buildEditbutton() => IconButton(
      icon: Icon(Icons.edit_outlined),
      onPressed: () async {
        if (isLoading) return;

        await Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => AddNote(note: note),
        ));

        refreshNote();
      });


  Widget buildDeletebutton() => IconButton(
        icon: Icon(Icons.delete),
        onPressed: () async {
          await DBHelper.instance.delete(widget.noteId);

          Navigator.of(context).pop();
        },
      );
}