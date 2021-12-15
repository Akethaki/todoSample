final String tableNotes = 'notes';

class NoteFields {
  static final List<String> values = [
    id, isImportant, number, title, task, time
  ];


  static final String id = '_id';
  static final String isImportant = 'isImportant';
  static final String number = 'number';
  static final String title = 'title';
  static final String task = 'task';
  static final String time = 'time';

}

class Note {
  final int? id;
  final bool isImportant;
  final int number;
  final String title;
  final String task;
  final DateTime createdTime;


  const Note({
    this.id, 
    required this.isImportant, 
    required this.number, 
    required this.title, 
    required this.task,
    required this.createdTime,

  });

  Note copy({
    int? id,
    bool? isImportant,
    int? number,
    String? title,
    String? task,
    DateTime? createdTime,

  }) =>
      Note(
        id: id ?? this.id,
        isImportant: isImportant ?? this.isImportant,
        number: number ?? this.number,
        title: title ?? this.title,
        task: task ?? this.task,
        createdTime: createdTime ?? this.createdTime,

      );

  static Note fromJson(Map<String, Object?> json) => Note(
        id: json[NoteFields.id] as int?,
        isImportant: json[NoteFields.isImportant] == 1,
        number: json[NoteFields.number] as int,
        title: json[NoteFields.title] as String,
        task: json[NoteFields.task] as String,
        createdTime: DateTime.parse(json[NoteFields.time] as String),
  );

  Map<String, Object?> toJson() => {
        NoteFields.id : id,
        NoteFields.isImportant : isImportant ? 1 : 0,
        NoteFields.number : number,
        NoteFields.title : title,
        NoteFields.task : task,
        NoteFields.time : createdTime.toIso8601String(),
  };

//   Category.fromMap(Map<String, dynamic> map){
//     id = map["id"];
//     title = map["title"];
//     task = map["task"];
// }
}




// class Category{
//   int? id;
//   late String title;
//   late String task;
//   // late String date;
//   // late String time;

//   categoryMap(){
//     Map<String, dynamic> toMap(){
//     var mapping = Map<String, dynamic>();
//     mapping ['id'] = id;
//     mapping ['title'] = title;
//     mapping ['task'] = task;

//     return mapping;
//   }
//   }

// }







