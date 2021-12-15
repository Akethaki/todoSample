import 'package:flutter/material.dart';
import 'package:todo_my/screen/add_note.dart';
import 'package:todo_my/screen/note_details.dart';
import 'package:todo_my/widgets/allnote_widget.dart';
import 'package:todo_my/repositories/db_helper.dart';
import 'package:todo_my/model/note.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';



class AllNotes extends StatefulWidget {
  const AllNotes({ Key? key }) : super(key: key);

  @override
  _AllNotesState createState() => _AllNotesState();
}

class _AllNotesState extends State<AllNotes> {

  late List<Note> notes;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();

    refreshNotes();
  }


  @override
  void dispose() {
    DBHelper.instance.close();

    super.dispose();
  }

  Future refreshNotes() async {
    setState(() => isLoading = true);

    this.notes = await DBHelper.instance.readAllNotes();

    setState(() => isLoading = false);
  }


  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          title: Text(
            'All Notes',
            style: TextStyle(fontSize: 24),
          ),
          actions: [Icon(Icons.search), SizedBox(width: 12)],
        ),
        body: Center(
          child: isLoading
              ? CircularProgressIndicator()
              : notes.isEmpty
                  ? Text(
                      'No Notes Available',
                      style: TextStyle(color: Colors.white, fontSize: 24),
                    )
                  : buildNotes(),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.black,
          child: Icon(Icons.add),
          onPressed: () async {
            await Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => AddNote()),
            );

            refreshNotes();
          },
        ),
      );

  Widget buildNotes() => StaggeredGridView.countBuilder(
        padding: EdgeInsets.all(8),
        itemCount: notes.length,
        staggeredTileBuilder: (index) => StaggeredTile.fit(2),
        crossAxisCount: 4,
        mainAxisSpacing: 4,
        crossAxisSpacing: 4,
        itemBuilder: (context, index) {
          final note = notes[index];

          return GestureDetector(
            onTap: () async {
              await Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => NoteDetails(noteId: note.id!),
              ));

              refreshNotes();
            },
            child: AllNoteWidget(note: note, index: index),
          );
        },
      );
}