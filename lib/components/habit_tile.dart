// import 'package:flutter/material.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';

// class HabitTile extends StatelessWidget {

//   final String habitName;
//   final bool habitCompleted;
//   final Function(bool?)? onChanged;

// const HabitTile({
//     Key? key,
//     required this.habitName,
//     required this.habitCompleted,
//     required this.onChanged,
//   }) : super(key: key);
  

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(10.0),
//       child: Slidable(
//         endActionPane: ActionPane(
//           motion: StretchMotion(), 
//         children: [
//           SlidableAction(
//             onPressed: (context){},
//             backgroundColor: Colors.blue,
//             icon: Icons.settings,
//             borderRadius: BorderRadius.circular(10), ),


//             SlidableAction(
//             onPressed: (context){},
//             backgroundColor: Colors.blue.shade900,
//             icon: Icons.delete,
//             borderRadius: BorderRadius.circular(10), ),


//         ]),
//         child: Container(
//           padding: EdgeInsets.all(16),
//           decoration: BoxDecoration(
//             color: Colors.pink,
//             borderRadius: BorderRadius.circular(10),
//           ),
//           child: Row(
//             children: [
//               Checkbox(
//                 value: habitCompleted,
//                 onChanged: onChanged,
//               ),
//               Text(
//                 habitName,
//                 style: TextStyle(color: Colors.white),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }


import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTile extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext)? settingsTapped;
  final Function(BuildContext)? deleteTapped;



  const HabitTile({
    Key? key,
    required this.habitName,
    required this.habitCompleted,
    required this.onChanged,
    required this.settingsTapped,
    required this.deleteTapped,
  }) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    return Slidable(
      
      endActionPane: ActionPane(
        
        motion: StretchMotion(),
        children: [
          SlidableAction(
            onPressed: settingsTapped,
            backgroundColor: Color.fromARGB(255, 2, 20, 35),
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(10),
            
            foregroundColor: Colors.yellow, 
          ),
          SlidableAction( 
          onPressed: deleteTapped,
          backgroundColor: Color.fromARGB(255, 2, 20, 35),
          icon: Icons.delete,
          borderRadius: BorderRadius.circular(10),
          foregroundColor: Colors.yellow, // Text color
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: ListTile(
          contentPadding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          leading: Checkbox(
            value: habitCompleted,
            onChanged: onChanged,
          ),
          title: Text(
            habitName,
            style: TextStyle(
              color: habitCompleted ? Colors.grey : Colors.black,
              decoration: habitCompleted
                  ? TextDecoration.lineThrough
                  : TextDecoration.none,
            ),
          ),
        ),
      ),
    );
  }
}

