import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_supabase/utils/constants.dart';
import 'package:todo_supabase/widgets/rounded_button.dart';
import 'package:todo_supabase/widgets/todo_body.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String dateTime = DateTime.now().toLocal().toString();
  String selectColor = "0XFFe63946";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Todo List"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SlidingUpPanel(
          parallaxEnabled: true,
          isDraggable: true,
          borderRadius: BorderRadius.circular(15),
          panel: GestureDetector(
            onTap: () {
              FocusScopeNode currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) currentFocus.unfocus();
            },
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Icon(
                    Icons.maximize_rounded,
                    size: 50,
                  ),
                ),
                Text(
                  "Swipe me up",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    left: 10,
                  ),
                  child: TextFormField(
                    controller: _taskNameController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      hintText: 'Task name',
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    left: 10,
                  ),
                  child: TextFormField(
                    controller: _descriptionController,
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                      hintText: 'Task description',
                    ),
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    left: 10,
                  ),
                  child: DateTimePicker(
                    calendarTitle: "Remainder date",
                    icon: Icon(Icons.event),
                    decoration: InputDecoration(
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15),
                        borderSide: BorderSide(
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ),
                    type: DateTimePickerType.dateTimeSeparate,
                    dateMask: 'd MMM, yyyy',
                    initialValue: DateTime.now().toString(),
                    firstDate: DateTime(2000),
                    lastDate: DateTime(2100),
                    dateLabelText: 'Date',
                    timeLabelText: "Hour",
                    onChanged: (val) => setState(() {
                      dateTime = val;
                    }),
                    validator: (val) {
                      setState(() {
                        dateTime = val!;
                      });
                      return null;
                    },
                    onSaved: (val) => setState(() {
                      dateTime = val!;
                    }),
                  ),
                ),
                SizedBox(height: 25),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    left: 10,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            selectColor = "0XFFe63946";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0XFFe63946),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            selectColor = "0XFFfb8500";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0XFFfb8500),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            selectColor = "0XFFa8dadc";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0XFFa8dadc),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            selectColor = "0XFF457b9d";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0XFF457b9d),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            selectColor = "0XFF1d3557";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0XFF1d3557),
                        ),
                      ),
                      SizedBox(
                        width: 15,
                      ),
                      InkWell(
                        onTap: () {
                          HapticFeedback.lightImpact();
                          setState(() {
                            selectColor = "0XFFbc6c25";
                          });
                        },
                        child: CircleAvatar(
                          backgroundColor: Color(0XFFbc6c25),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 25),
                Container(
                  width: 50,
                  child: Divider(
                    thickness: 5,
                    color: Color(
                      int.parse(selectColor),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    left: 10,
                  ),
                  child: RoundedButtonWidget(
                    buttonText: 'Add task',
                    width: MediaQuery.of(context).size.width * 0.90,
                    onpressed: () async {
                      await supabase.from('TodoList').insert([
                        {
                          'email': supabase.auth.currentUser?.email,
                          'task_name': _taskNameController.text,
                          'task_description': _descriptionController.text,
                          'date_time': dateTime,
                          'color': selectColor,
                        }
                      ]).execute();
                      _descriptionController.text = "";
                      _taskNameController.text = "";
                      context.showSnackBar(message: "Successfully inserted!");
                      Navigator.pushReplacementNamed(context, '/home');
                    },
                  ),
                )
              ],
            ),
          ),
          body: todoBody(),
        ),
      ),
    );
  }
}
