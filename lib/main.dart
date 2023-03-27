import 'package:flutter/material.dart';
import 'package:flutter_file_downloader/flutter_file_downloader.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Download file from internet',
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: downloadfile,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void downloadfile()async {
   var status=await Permission.storage.request();
   if(status==PermissionStatus.granted){
     FileDownloader.downloadFile(
         url: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRoYGn3240M2CIIt30G9sZebbfm45pIjW-N6gWUyEdR&s",
         name: "filename.png",
         onProgress: (String? filename,double process){
           print("FILE $filename HAS PROGRESS $process") ;
         },
         onDownloadCompleted: (String path){
           print("FILE DOWNLOADED TO PATH $path");
         },
         onDownloadError: (String error){
           print("DOWNLOAD ERROR $error");
         }
     );
   }else{
     print("Permission is not granted");
   }
  }
}
