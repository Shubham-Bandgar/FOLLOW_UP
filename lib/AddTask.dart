import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:followup/EditTask.dart';
import 'package:followup/Recorder.dart';
import 'package:followup/constant/conurl.dart';
import 'package:http_parser/http_parser.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';
import 'package:path/path.dart' as path;
import 'package:image_picker/image_picker.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:firebase_core/firebase_core.dart';
import 'ListAll.dart';
import 'dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:followup/notification_services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
TextEditingController title=TextEditingController();
TextEditingController startdate=TextEditingController();
TextEditingController deadlinedate=TextEditingController();
TextEditingController starttime=TextEditingController();
TextEditingController endtime=TextEditingController();

bool isButtonEnabled=false;
var pic;
var mainid;
String? userid;
String? cmpid;
String? admintype;
String? titleaudio;
String? startdateaudio;
String? deadlinedateaudio;
String? starttimeaudio;
String? endtimeaudio;
List<dynamic>? assigntoaudio;
String? picaudio;

Timer? _toastTimer;
var uui=Uuid();
var uniqueId=uuid.v1();

class TaskForm extends StatelessWidget{
  final String audiopath;

  TaskForm({
    Key? key,
    required this.audiopath,
}):super(key: key);

  @override
  Widget build(BuildContext context) {
     return MaterialApp(
       debugShowCheckedModeBanner: false,
       title: "Follow Up",
       theme: ThemeData(
       primarySwatch: Colors.blue,
       ),
       home: AddTask  (
         audioPath:audiopath,
       ),
     );
  }

}


class AddTask extends StatefulWidget {
  final String audioPath;

  const AddTask({
    Key? key,
    required this.audioPath,
  }) : super(key: key);

  @override
  _AddTaskState createState() => _AddTaskState(audioPath: audioPath);
}


class _AddTaskState extends State<AddTask>{
  String audioPath;
  _AddTaskState({required this.audioPath});
  ScrollController controller = ScrollController();
  int? randomNumber;

  Future<List>? get dynamicValues => null;

  void getdata() async{
    SharedPreferences preferences=await SharedPreferences.getInstance();
    title.text=preferences.getString('titleaudio')?? '';
    startdate.text = preferences.getString('startdateaudio') ?? '';
    deadlinedate.text = preferences.getString('deadlinedateaudio') ?? '';
    starttime.text = preferences.getString('starttimeaudio') ?? '';
    endtime.text = preferences.getString('endtimeaudio') ?? '';
    pic = preferences.getString('picaudio');

    var date;
    String currentTime="${date.hour.toString().padLeft(2,'0')}:${date.minute.toString().padLeft(2,'0')}:${date.second.toString().padLeft(2, '0')}";

    if(starttime.text==''){
      setState(() {
        starttime.text=currentTime;
      });
    }
    if(endtime.text==''){
      setState(() {
        endtime.text=currentTime;
      });
    }
    if (startdate.text == '') {
      setState(() {
        DateTime date = DateTime.now();
        startdate.text = DateFormat('dd-MM-yyyy').format(date);
      });
    }
    if (deadlinedate.text == '') {
      setState(() {
        DateTime date = DateTime.now();
        deadlinedate.text = DateFormat('dd-MM-yyyy').format(date);
      });
    }

  }
  Future<void> saveSelectedValuesToPrefis(List<dynamic> values) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String> stringValues =
    values.map((value) => value.toString()).toList();
    await preferences.setStringList('selectedValues', stringValues);
  }
  Future<Future<List>?> getSelectedValuesFromPrefs() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    List<String>? stringValues = preferences.getStringList('selectedValues');
   // dynamicValues = stringValues?.map((value) => value).toList() ?? [];
    return dynamicValues;
  }
  void startContinuousToast() {
    // Create a Timer that will repeatedly call showContinuousToast every 5 seconds
    _toastTimer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      showContinuousToast();
    });
  }
  void stopContinuousToast() {
    _toastTimer?.cancel();
  }
  void showContinuousToast() {

    Fluttertoast.showToast(
      msg: 'Please wait while task is adding',
      //   toastlength:Toast.LENGTH_
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.black87,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }
  void initState() {
    super.initState();
    getdata();
    //generateRandomNumber();
    getSelectedValuesFromPrefs().then((values) {
      setState(() {
        var selectedData = values;
      });
    });
    // String currentTime =
    //     "${date.hour.toString().padLeft(2, '0')}:${date.minute.toString().padLeft(2, '0')}:${date.second.toString().padLeft(2, '0')}";

    WidgetsBinding.instance!.addPostFrameCallback((_) {});
    fetchDropdownData();
  }
    void savedata(String titlenew,String startdate,String deadlnedata,String starttime,String endtime )async{
    print('hh');
    print('fdgd');
    setState(() {
      var isLoading=false;
    });
    int num = 0;
    // DateTime currentDate = DateTime.now(); // Get the current date
    //String formattedDate = DateFormat('dd-MM-yyyy').format(currentDate); // Format the date
    if (titlenew.isEmpty || titlenew == Null) {
      num = 1;
      print('Title should be add');
      Fluttertoast.showToast(
        backgroundColor: Color.fromARGB(255, 255, 94, 0),
        textColor: Colors.white,
        msg: 'Title should be add',
        toastLength: Toast.LENGTH_SHORT,
      );
    }

      }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }

  void fetchDropdownData() {}

}

