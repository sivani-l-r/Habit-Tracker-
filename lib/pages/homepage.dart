import 'package:flutter/material.dart';
import 'package:habit_tracker/components/addnew_fab.dart';
import 'package:habit_tracker/components/editalertbox.dart';
import 'package:habit_tracker/components/habit_tile.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/components/newhabitdialog.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Habit_Database db = Habit_Database();
  final _myBox = Hive.box("Habit_Database");

  void initState() {
    if (_myBox.get("CURRENT_HABIT_LIST") == null) {
      db.createDefaultData();
    } else {
      db.loadData();
    }

    db.updateData();
    super.initState();
  }

  void checkBoxTapped(bool? value, int index) {
    setState(() {
      db.todaysHabitList[index][1] = value!;
    });
    db.updateData();
  }

  final _newHabitController = TextEditingController();
  final _editHabitController = TextEditingController();

  void createNewHabit() {
    showDialog(
      context: context,
      builder: (context) {
        return EnterNewHabit(
          controller: _newHabitController,
          onSaved: saveNewHabit,
          onCancel: cancelNewHabit,
        );
      },
    );
    db.updateData();
  }

  void saveNewHabit() {
    setState(() {
      db.todaysHabitList.add([_newHabitController.text, false]);
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateData();
  }

  void cancelNewHabit() {
    _newHabitController.clear();
    Navigator.of(context).pop();
  }

  void openHabitSettings(int index) {
    _editHabitController.text = db.todaysHabitList[index][0];
    showDialog(
      context: context,
      builder: (context) {
        return EditDialog(
          controller: _editHabitController,
          onSaved: () => saveEditedHabit(index),
          onCancel: cancelNewHabit,
        );
      },
    );
  }

  void saveEditedHabit(int index) {
    setState(() {
      db.todaysHabitList[index][0] = _editHabitController.text;
    });
    _newHabitController.clear();
    Navigator.of(context).pop();
    db.updateData();
  }

  void deleteHabit(int index) {
    setState(() {
      db.todaysHabitList.removeAt(index);
    });
    db.updateData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 2, 20, 35),
      floatingActionButton: AddNewFab(
        onPressed: () => createNewHabit(),
      ),
      body: ListView(
        children: [
          MonthlySummary(
            datasets: db.heapMapDataSet,
            startDate: _myBox.get("START_DATE"),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: db.todaysHabitList.length,
            itemBuilder: (context, index) {
              return HabitTile(
                habitName: db.todaysHabitList[index][0],
                habitCompleted: db.todaysHabitList[index][1],
                onChanged: (value) => checkBoxTapped(value, index),
                settingsTapped: (context) => openHabitSettings(index),
                deleteTapped: (context) => deleteHabit(index),
              );
            },
          ),
        ],
      ),
    );
  }
}
