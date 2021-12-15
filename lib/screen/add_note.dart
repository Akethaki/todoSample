import 'package:flutter/material.dart';
import 'package:todo_my/screen/all_notes.dart';
import 'package:todo_my/widgets/addnote_widget.dart';
import 'package:todo_my/repositories/db_helper.dart';
import 'package:todo_my/model/note.dart';


class AddNote extends StatefulWidget {
  final Note? note;

  
  const AddNote({
    Key? key,
    this.note,
  }) : super(key: key);

  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  final _formKey = GlobalKey<FormState>();
  late bool isImportant;
  late int number;
  late String title;
  late String task;

  @override
  void initState() {
    super.initState();

    isImportant = widget.note?.isImportant ?? false;
    number = widget.note?.number ?? 0;
    title = widget.note?.title ?? '';
    task = widget.note?.task?? '';
  }
  
 Object? value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        title: Text('Add New Task', style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold), ),
        backgroundColor: Colors.cyan[800],
        leading: 
            IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => AllNotes()));
              }, 
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,))
      ),

      body: Container(
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/addnote.jpg"),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: Column(
          children: [
            SizedBox(height: 15),
            Form(
              key: _formKey,
              child: AddNoteWidget(
                isImportant: isImportant,
                number: number,
                title: title,
                task: task,
                onChangedImportant: (isImportant) =>
                    setState(() => this.isImportant = isImportant),
                onChangedNumber: (number) => setState(() => this.number = number),
                onChangedTitle: (title) => setState(() => this.title = title),
                onChangedTask: (task) =>
                    setState(() => this.task = task),
              ),
            ),
            SizedBox(height: 25),
            Row(
              children: [buildSavebutton()],
            )
          ],
        )
      ),
    );
  }

Widget buildSavebutton() {
  return Padding(
    padding: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20)
          ),
        primary: Colors.cyan[700],
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
        textStyle: TextStyle(
          fontStyle: FontStyle.italic, 
          fontSize: 15.0, 
          fontWeight: FontWeight.bold
      ),
        elevation: 20,
    ),
      child: Text('SAVE'),
      onPressed: AddorUpdateNote,
  ),
);
}

void AddorUpdateNote() async {
    final isValid = _formKey.currentState!.validate();

    if (isValid) {
      final isUpdating = widget.note != null;

      if (isUpdating) {
        await update();
      } else {
        await add();
      }

      Navigator.of(context).pop();
    }
  }


  Future update() async {
    final note = widget.note!.copy(
      isImportant: isImportant,
      number: number,
      title: title,
      task: task,
    );

    await DBHelper.instance.update(note);
  }


  Future add() async {
    final note = Note(
      title: title,
      isImportant: true,
      number: number,
      task: task,
      createdTime: DateTime.now(),
    );

    await DBHelper.instance.create(note);
  }


}