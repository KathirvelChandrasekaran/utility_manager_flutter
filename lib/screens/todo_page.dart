import 'package:date_time_picker/date_time_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:todo_supabase/providers/todo_list_provider.dart';
import 'package:todo_supabase/utils/constants.dart';
import 'package:todo_supabase/widgets/rounded_button.dart';

class TodoPage extends StatefulWidget {
  const TodoPage({Key? key}) : super(key: key);

  @override
  _TodoPageState createState() => _TodoPageState();
}

class _TodoPageState extends State<TodoPage> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  String dateTime = DateTime.now().toLocal().toString();

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
                SizedBox(height: 20),
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
                SizedBox(height: 50),
                Padding(
                  padding: const EdgeInsets.only(
                    right: 25.0,
                    left: 10,
                  ),
                  child: RoundedButtonWidget(
                    buttonText: 'Add task',
                    width: MediaQuery.of(context).size.width * 0.90,
                    onpressed: () async {
                      var res = await supabase.from('TodoList').insert([
                        {
                          'email': supabase.auth.currentUser?.email,
                          'task_name': _taskNameController.text,
                          'task_description': _descriptionController.text,
                          'date_time': dateTime,
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
          body: Consumer(builder: (context, watch, child) {
            final todos = watch(todoListProvider);
            return Center(
                child: todos.map(
              data: (res) {
                return Container(
                  child: res.value.data.length < 1
                      ? Lottie.asset('assets/empty.json')
                      : ListView(
                          children: [
                            for (var i = 0; i < res.value.data.length; i++)
                              Container(
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        width:
                                            MediaQuery.of(context).size.width,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Column(
                                            children: [
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                res.value.data[i]['task_name'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                res.value.data[i]
                                                    ['task_description'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w400,
                                                  fontSize: 20,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                              SizedBox(
                                                height: 15,
                                              ),
                                              Text(
                                                res.value.data[i]['date_time'],
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 25,
                                                ),
                                                textAlign: TextAlign.center,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              )
                          ],
                        ),
                );
              },
              loading: (_) => SizedBox(
                width: 300.0,
                child: LinearProgressIndicator(
                  backgroundColor: Theme.of(context).accentColor,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    Theme.of(context).primaryColor,
                  ),
                ),
              ),
              error: (_) => Text(
                _.error.toString(),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ));
          }),
        ),
      ),
    );
  }
}
