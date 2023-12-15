import 'package:habit_tracker/datetime/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class Habit_Database{
late Box<dynamic> _myBox;
List todaysHabitList = [];
Map<DateTime,int> heapMapDataSet = {};
 Habit_Database() {
    // This instantiation might be causing a loop
    _myBox = Hive.box("Habit_Database");
    loadData();
  }

// initial default data

 void createDefaultData()
 {

      todaysHabitList =
      [
        ['Morning Run', false],
        ['Read Book', true]
      ];

      _myBox.put("START_DATE",todaysDateFormatted());

 }

 // load data

 void loadData()
 {

  if(_myBox.get(todaysDateFormatted())==null)
  {
      todaysHabitList = _myBox.get("CURRENT_HABIT_LIST");

      for (int i=0 ; i< todaysHabitList.length ; i++)
      {
        todaysHabitList[i][1]=false;
      }

  }
  else
  {
     todaysHabitList =  _myBox.get(todaysDateFormatted());
  }

 }

 // update data

 void updateData()
 {

  _myBox.put(todaysDateFormatted(),todaysHabitList);

  _myBox.put("CURRENT_HABIT_LIST", todaysHabitList);

  calculateHabitPercentages();
  loadHeatMap();


 }

 void calculateHabitPercentages()
 {
    int countCompleted = 0;
    for(int i=0;i<todaysHabitList.length; i++)
    {
      if(todaysHabitList[i][1] == true )
      {
        countCompleted++;

      }
    }

    String percent = todaysHabitList.isEmpty ? '0.0' :  (countCompleted / todaysHabitList.length).toStringAsFixed(1);

    _myBox.put("PERCENTAGE_SUMMARY_${todaysDateFormatted()})",percent);

 }

void loadHeatMap() {
  heapMapDataSet = {}; // Initialize the map outside the loop

  DateTime startDate = createDateTimeObject(_myBox.get("START_DATE"));
  int daysInBetween = DateTime.now().difference(startDate).inDays;

  for (int i = 0; i < daysInBetween; i++) {
    String yyyymmdd = convertDateTimeToString(startDate.add(Duration(days: i)));

    // double strengthAsPercent = double.parse(
    //   _myBox.get("PERCENTAGE_SUMMARY_$yyyymmdd") ?? "0.0",
    // );

    int completedHabitsCount = todaysHabitList
    .where((habit) => habit[1] == true)
    .length;


    int year = startDate.add(Duration(days: i)).year;
    int month = startDate.add(Duration(days: i)).month;
    int day = startDate.add(Duration(days: i)).day;

    // final percentForEachDay = {
    //   DateTime(year, month, day): (10 * strengthAsPercent).toInt(),
    // };

    final percentForEachDay = {
      DateTime(year, month, day): completedHabitsCount,
    };

    heapMapDataSet.addEntries(percentForEachDay.entries);
    print(heapMapDataSet);
  }
}






}
