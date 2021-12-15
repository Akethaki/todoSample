import 'package:flutter/material.dart';

class AddNoteWidget extends StatelessWidget {
  final bool? isImportant;
  final int? number;
  final String? title;
  final String? task;
  final ValueChanged<bool> onChangedImportant;
  final ValueChanged<int> onChangedNumber;
  final ValueChanged<String> onChangedTitle;
  final ValueChanged<String> onChangedTask;


  const AddNoteWidget({
    Key? key,
    this.isImportant = false,
    this.number = 0,
    this.title = '',
    this.task = '',
    required this.onChangedImportant,
    required this.onChangedNumber,
    required this.onChangedTitle,
    required this.onChangedTask,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      
      child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Switch(
                    value: isImportant ?? false,
                    onChanged: onChangedImportant,
                  ),
                  Expanded(
                    child: Slider(
                      value: (number ?? 0).toDouble(),
                      min: 0,
                      max: 5,
                      divisions: 5,
                      onChanged: (number) => onChangedNumber(number.toInt()),
                    ),
                  )
                ],
              ),
              buildTitle(),
              SizedBox(height: 36),
              buildTask(),
              SizedBox(height: 36),
            ],
          ),
        ),

    );
  }

  Widget buildTitle(){
    return TextFormField(
      keyboardType: TextInputType.text,
      decoration: const InputDecoration(
        labelText: 'Task Title',
        labelStyle: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
          color: Colors.black
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(6.0)),
          borderSide: BorderSide(color: Colors.cyan)
        )
        ),

      maxLines: 1,
      validator: (title) => title != null && title.isEmpty
            ? 'Title cannot be empty....'
            : null,
      onChanged: onChangedTitle,
    );
  }


  Widget buildTask(){
    return TextFormField(
    keyboardType: TextInputType.text,
    decoration: InputDecoration(
      labelText: 'What Task is to be done?',
      labelStyle: TextStyle(
        fontSize: 18.0,
        fontWeight: FontWeight.bold,
        color: Colors.black
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
        borderSide: BorderSide(color: Colors.cyan)
      ),
      ),

    maxLines: 5,
    validator: (title) => title != null && title.isEmpty
            ? 'The description cannot be empty'
            : null,
    onChanged: onChangedTask,
    ); 
  }

}