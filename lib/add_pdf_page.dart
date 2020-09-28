import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_google_ad_manager/ad_size.dart';
import 'package:flutter_google_ad_manager/banner.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:mtdocs/ads.dart';
import 'package:mtdocs/pdf_view_page.dart';
import 'package:mtdocs/textform.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'create_pdf.dart';
import 'db_provider.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

import 'main.dart';


//double _kPickerSheetHeight = 216.0;
//Widget _buildBottomPicker(Widget picker) {
//  return Container(
//    height: _kPickerSheetHeight,
//    padding: const EdgeInsets.only(top: 6.0),
//    color: CupertinoColors.white,
//    child: DefaultTextStyle(
//      style: const TextStyle(
//        color: CupertinoColors.black,
//        fontSize: 22.0,
//      ),
//      child: GestureDetector(
//        // Blocks taps from propagating to the modal sheet and popping.
//        onTap: () {},
//        child: SafeArea(
//          top: false,
//          child: picker,
//        ),
//      ),
//    ),
//  );
//}


class AddPdfPage extends StatefulWidget {
  final int isNew;
  final AllData data;

  AddPdfPage({this.isNew,this.data});

  @override
  _AddPdfPageState createState() => _AddPdfPageState();
}

class FileController {
  // ドキュメントのパスを取得
  static Future get localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static saveLocalImage(File image,String id) async {
    final String path = await localPath;

    final imagePath = '$path/image$id.jpg';
    print(imagePath);
    print(imagePath);
    final byteData = await image.readAsBytes();

    await File(imagePath).writeAsBytes(byteData);

    return imagePath;
  }

  static Future<String> saveTmpImage(File image) async {
    final String path = await localPath;
    final imagePath = '$path/image.jpg';

    print(imagePath);
    final byteData = await image.readAsBytes();
    await File(imagePath).writeAsBytes(byteData);

    return imagePath;
  }
}

class _AddPdfPageState extends State<AddPdfPage> {
  AllData allData = AllData();
  File _image;
  String _imagePath;
  List<bool> _sex = [];
  DateTime now = DateTime.now();
  List<bool> expand;
  ContentsLabel contents = ContentsLabel();
  PermissionStatus _permissionCameraStatus = PermissionStatus.undetermined;
  PermissionStatus _permissionPhotosStatus = PermissionStatus.undetermined;
  Ads banner = Ads();
  // DFPBannerViewController _bannerViewController;
  //
  // _reload() {
  //   _bannerViewController?.reload();
  // }


  Future _getFileFromDevice() async{
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['png','jpg'],
    );

    if (result == null) {
      return;
    }
    var savePath = await FileController.saveTmpImage(File(result.files.single.path));
    setState(() {
      _image = File(result.files.single.path);
      _imagePath = savePath;
    });
  }

  Future _getImageFromDevice(ImageSource source) async {
    // 撮影/選択したFileが返ってくる
    final PickedFile imageFile = await ImagePicker().getImage(source: source);
    // 撮影せずに閉じた場合はnullになる
    if (imageFile == null) {
      return;
    }
    var savePath = await FileController.saveTmpImage(File(imageFile.path));
    setState(() {
      _image = File(savePath);
      _imagePath = savePath;
    });
  }

  Future<void> _requestCameraPermission() async {
    var status = await Permission.camera.request();
    setState(() {
      _permissionCameraStatus = status;
      if(_permissionCameraStatus == PermissionStatus.granted) _getImageFromDevice(ImageSource.camera);
    });
  }

  Future<void> _requestPhotosPermission() async {
    var status = await Permission.photos.request();
    setState(() {
      _permissionPhotosStatus = status;
      if(_permissionPhotosStatus == PermissionStatus.granted) _getImageFromDevice(ImageSource.gallery);
    });
  }



  _checkCameraPermissionStatus() {
    switch (_permissionCameraStatus) {
      case PermissionStatus.undetermined:
        print('カメラの使用許可/不許可が未選択');
        _requestCameraPermission();
        return Container();
      case PermissionStatus.permanentlyDenied:
        print('カメラの権限が手動で設定しない限り不許可');
        return _showDialogCamera();
      case PermissionStatus.restricted:
        print('カメラの使用制限');
        return _showDialogCamera();
      case PermissionStatus.denied:{
        print('カメラの使用不許可');
      }return _showDialogCamera();
      case PermissionStatus.granted:
        print('カメラの使用許可');
        return _getImageFromDevice(ImageSource.camera);
      default:
        return _showDialogCamera();
    }
  }

  _checkPhotosPermissionStatus() {
    switch (_permissionPhotosStatus) {
      case PermissionStatus.undetermined:
        print('カメラロール の使用許可/不許可が未選択');
        _requestPhotosPermission();
        return Container();
      case PermissionStatus.permanentlyDenied:
        print('カメラロール の権限が手動で設定しない限り不許可');
        return _showDialogPhotos();
      case PermissionStatus.restricted:
        print('カメラロール の使用制限');
        return _showDialogPhotos();
      case PermissionStatus.denied:{
        print('カメラロール の使用不許可');
      }return _showDialogPhotos();
      case PermissionStatus.granted:
        print('カメラロール の使用許可');
        return _getImageFromDevice(ImageSource.gallery);
      default:
        return _showDialogPhotos();
    }
  }

  void _showDialogCamera() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("カメラが許可されていません。"),
          content: Text("このアプリではカメラを使用します。"),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text("キャンセル"),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
            CupertinoDialogAction(
                child: Text("設定"),
                onPressed: () {
                  Navigator.pop(context);
                  _showDialogSave();
                }
            ),
          ],
        );
      },
    );
  }

  void _showDialogPhotos() {
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("カメラロールが許可されていません。"),
          content: Text("このアプリではカメラロールを使用します。"),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text("キャンセル"),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
            CupertinoDialogAction(
                child: Text("設定"),
                onPressed: (){
                  Navigator.pop(context);
                  _showDialogSave();// 設定アプリに遷移
                }
            ),
          ],
        );
      },
    );
  }

  void _showDialogSave(){
    showDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("ファイルの保存"),
          content: Text("設定画面に移動すると一度このファイルは保存されます。"),
          actions: <Widget>[
            CupertinoDialogAction(
                child: Text("キャンセル"),
                isDestructiveAction: true,
                onPressed: () {
                  Navigator.of(context).pop();
                }
            ),
            CupertinoDialogAction(
                child: Text("OK"),
                onPressed: () async{
                  contents.textFieldMap.forEach((key, value) {
                    allData.changeText(key, value.text);
                  });
                  allData.date = DateFormat.yMMMMd("ja_JP").format(DateTime.now());
                  if(widget.isNew == 1){
                    await DBProvider.insertFileData(allData);
                  }
                  else{
                    await DBProvider.updateFileData(allData, allData.id);
                  }
                  openAppSettings();
                  while(Navigator.canPop(context)) {
                    Navigator.of(context).pop();
                  }
                }
            ),
          ],
        );
      },
    );
  }

  // Widget getBanner(){
  //   return Center(
  //     child: DFPBanner(
  //       isDevelop: false,
  //       testDevices: MyTestDevices(),
  //       adUnitId: getBannerAdUnitId(),
  //       adSize: DFPAdSize.BANNER,
  //       onAdLoaded: () {
  //         print('Banner onAdLoaded');
  //       },
  //       onAdFailedToLoad: (errorCode) {
  //         print('Banner onAdFailedToLoad: errorCode:$errorCode');
  //       },
  //       onAdOpened: () {
  //         print('Banner onAdOpened');
  //       },
  //       onAdClosed: () {
  //         print('Banner onAdClosed');
  //       },
  //       onAdLeftApplication: () {
  //         print('Banner onAdLeftApplication');
  //       },
  //       onAdViewCreated: (controller){
  //         _bannerViewController = controller;
  //       },
  //     ),
  //   );
  // }

  Widget _checkBox(String text, bool check){
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Checkbox(
              activeColor: Colors.blue,
              value: check,
              onChanged: (bool e){
                setState(() {
                  allData.changeBool(text,e);
                });
              },
            ),
            Container(
              width: 50,
            ),
            Text(text,style: TextStyle(color: Colors.black),),
            Container(
              width: 50,
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(5),),
      ],
    );
  }

  Widget txtBox(TextEditingController controller,String hint, String label){
    return TextField(
      maxLines: 20,
      minLines: 1,
      controller: controller,
      enabled: true,
      maxLengthEnforced: false,
      obscureText: false,
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue),
        ),
        hintText: hint,
        labelText: label,
      ),
    );
  }

  void showProgressDialog() {
    showGeneralDialog(
        context: context,
        barrierDismissible: false,
        transitionDuration: Duration(milliseconds: 300),
        barrierColor: Colors.black.withOpacity(0.5),
        pageBuilder: (BuildContext context, Animation animation, Animation secondaryAnimation) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }
    );
  }

  @override
  void initState() {
//    _requestCameraPermission();
//    _requestContactsPermission();

    for(int i = 0; i < 10; i++) _sex.add(false);
    initializeDateFormatting("ja_JP");
    expand = List.filled(9, false);
    if(widget.isNew == 0){
      allData = widget.data;
      contents.textFieldMap.forEach((key, value) {
        value.text = widget.data.toMap()[key];
      });
      if(allData.path != null){
        _image = File(allData.path);
        _imagePath = allData.path;
      }
      if(widget.data.id1Sex == "男"){
        _sex[0] = true;
      }
      else if(widget.data.id1Sex == "女"){
        _sex[1] = true;
      }
      if(widget.data.id2Sex == "男"){
        _sex[2] = true;
      }
      else if(widget.data.id2Sex == "女"){
        _sex[3] = true;
      }
      if(widget.data.id3Sex == "男"){
        _sex[4] = true;
      }
      else if(widget.data.id3Sex == "女"){
        _sex[5] = true;
      }
      if(widget.data.id4Sex == "男"){
        _sex[6] = true;
      }
      else if(widget.data.id4Sex == "女"){
        _sex[7] = true;
      }
      if(widget.data.id5Sex == "男"){
        _sex[8] = true;
      }
      else if(widget.data.id5Sex == "女"){
        _sex[9] = true;
      }
    }
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: widget.isNew == 1 ? Text("Add Information") : Text("編集"),
        ),
        body: Container(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Column(
              children: [
                // banner.getBanner(),
                ExpansionPanelList(
                  expansionCallback: (int index, bool isExpanded) {
                    setState(() {
                      expand[index] = !expand[index];
                    });
                  },
                  children: [
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('ファイル名'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
//                          txtBox(contents.textFieldMap[ContentsLabel.file], ContentsLabel.hintLabelMap[ContentsLabel.file], ContentsLabel.file),
                          TextField(
                            controller: contents.textFieldMap[ContentsLabel.file],
                            maxLines: 20,
                            minLines: 1,
                            inputFormatters: [
                              FilteringTextInputFormatter.deny(RegExp("/")),
                            ],
                            enabled: true,
                            maxLengthEnforced: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintText: ContentsLabel.hintLabelMap[ContentsLabel.file],
                              labelText: ContentsLabel.file,
                            ),
                          ),
                            ]
                        ),
                      ),
                      isExpanded: expand[0],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('提出先機関'),
                        );
                      },
                      body:
                      Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              txtBox(contents.textFieldMap[ContentsLabel.head], ContentsLabel.hintLabelMap[ContentsLabel.head], ContentsLabel.head),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("提出日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Center(
                                        child: allData.firstDate == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                            : Text(allData.firstDate),
                                      )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 1, 1, 1),
                                                maxTime: DateTime(now.year + 5, 12, 31),
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.firstDate = DateFormat.yMMMMd("ja_JP").format(date);
                                                  });
                                                  },
                                                currentTime: allData.firstDate == null ? now : allData.firstDate,
                                                locale: LocaleType.jp
                                            );
                                          }
                                          ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                      icon: Icon(Icons.backspace),
                                      onPressed: ()async{
                                        setState(() {
                                          allData.firstDate = null;
                                        });
                                      },
                                    ),
                                    ),
//                                Text("  提出日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.firstDate == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
//                                    : Text(allData.firstDate),
//                                Container(
//                                    width: 10
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: (){
//                                    DatePicker.showDatePicker(context,
//                                        showTitleActions: true,
//                                        minTime: DateTime(now.year-1, 1, 1),
//                                        maxTime: DateTime(now.year+5, 12, 31),
//                                        onConfirm: (date) {
//                                          setState(() {
//                                            allData.firstDate = DateFormat.yMMMMd("ja_JP").format(date);
//                                          });
//                                        },
//                                        currentTime: now,
//                                        locale: LocaleType.jp
//                                    );
////                                    showCupertinoModalPopup<void>(
////                                      context: context,
////                                      builder: (BuildContext context) {
////                                        return _buildBottomPicker(
////                                          CupertinoDatePicker(
////                                            mode: CupertinoDatePickerMode.date,
////                                            initialDateTime: now,
////                                            onDateTimeChanged: (DateTime selected) {
////                                              if (mounted) {
////                                                setState(() => allData.firstDate = DateFormat.yMMMMd("ja_JP").format(selected));
////                                              }
////                                            },
////                                          ),
////                                        );
////                                      },
////                                    );
////                                    final DateTime selected = await showDatePicker(
////                                      context: context,
////                                      locale: const Locale("ja"),
////                                      initialDate: now,
////                                      firstDate: DateTime(now.year-1),
////                                      lastDate: DateTime(now.year+5),
////                                    );
////                                    if (selected != null) {
////                                      setState(() {
////                                        allData.firstDate = DateFormat.yMMMMd("ja_JP").format(selected);
////                                      });
////                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.firstDate = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),
                            ]
                        ),
                      ),
                      isExpanded: expand[1],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('代表者情報'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              txtBox(contents.textFieldMap[ContentsLabel.belongs], ContentsLabel.hintLabelMap[ContentsLabel.belongs], ContentsLabel.belongs),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.groupName], ContentsLabel.hintLabelMap[ContentsLabel.groupName], ContentsLabel.groupName),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("代表者情報",style: TextStyle(fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.represent], ContentsLabel.hintLabelMap[ContentsLabel.represent], ContentsLabel.represent),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.firstAddress1], ContentsLabel.hintLabelMap[ContentsLabel.firstAddress1], ContentsLabel.firstAddress1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.firstAddress2], ContentsLabel.hintLabelMap[ContentsLabel.firstAddress2], ContentsLabel.firstAddress2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.firstAddress3], ContentsLabel.hintLabelMap[ContentsLabel.firstAddress3], ContentsLabel.firstAddress3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.firstAddress4], ContentsLabel.hintLabelMap[ContentsLabel.firstAddress4], ContentsLabel.firstAddress4),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.firstTel], ContentsLabel.hintLabelMap[ContentsLabel.firstTel], ContentsLabel.firstTel),
                            ]
                        ),
                      ),
                      isExpanded: expand[2],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('緊急連絡先情報'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              txtBox(contents.textFieldMap[ContentsLabel.emergeName], ContentsLabel.hintLabelMap[ContentsLabel.emergeName], ContentsLabel.emergeName),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.emergeTel], ContentsLabel.hintLabelMap[ContentsLabel.emergeTel], ContentsLabel.emergeTel),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.emergeAddress1], ContentsLabel.hintLabelMap[ContentsLabel.emergeAddress1], ContentsLabel.emergeAddress1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.emergeAddress2], ContentsLabel.hintLabelMap[ContentsLabel.emergeAddress2], ContentsLabel.emergeAddress2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.emergeAddress3], ContentsLabel.hintLabelMap[ContentsLabel.emergeAddress3], ContentsLabel.emergeAddress3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.emergeAddress4], ContentsLabel.hintLabelMap[ContentsLabel.emergeAddress4], ContentsLabel.emergeAddress4),
                            ]
                        ),
                      ),
                      isExpanded: expand[3],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('現地連絡先情報'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              txtBox(contents.textFieldMap[ContentsLabel.localPoint1], ContentsLabel.hintLabelMap[ContentsLabel.localPoint1], ContentsLabel.localPoint1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.localTel1], ContentsLabel.hintLabelMap[ContentsLabel.localTel1], ContentsLabel.localTel1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.localPoint2], ContentsLabel.hintLabelMap[ContentsLabel.localPoint2], ContentsLabel.localPoint2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.localTel2], ContentsLabel.hintLabelMap[ContentsLabel.localTel2], ContentsLabel.localTel2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.localPoint3], ContentsLabel.hintLabelMap[ContentsLabel.localPoint3], ContentsLabel.localPoint3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.localTel3], ContentsLabel.hintLabelMap[ContentsLabel.localTel3], ContentsLabel.localTel3),
                            ]
                        ),
                      ),
                      isExpanded: expand[4],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('メンバー情報'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("メンバー１",style: TextStyle(fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.all(10),),
//                          txtBox(contents.textFieldMap[ContentsLabel.id1Role], ContentsLabel.hintLabelMap[ContentsLabel.id1Role], ContentsLabel.id1Role),
                          TextField(
                            maxLength: 2,
                            controller: contents.textFieldMap[ContentsLabel.id1Role],
                            enabled: true,
                            maxLengthEnforced: false,
                            obscureText: false,
                            decoration: InputDecoration(
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.blue),
                              ),
                              hintText: ContentsLabel.hintLabelMap[ContentsLabel.id1Role],
                              labelText: ContentsLabel.id1Role,
                            ),
                          ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1Name], ContentsLabel.hintLabelMap[ContentsLabel.id1Name], ContentsLabel.id1Name),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1NameH], ContentsLabel.hintLabelMap[ContentsLabel.id1NameH], ContentsLabel.id1NameH),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                      children: <Widget>[
                                        Text("  性別",style: TextStyle(color: Colors.black54),),
                                        Container(
                                          width: 50,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[0],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[0] = value;
                                              if(_sex[0]){
                                                allData.id1Sex = "男";
                                                _sex[1] = !_sex[0];
                                              }
                                              else{
                                                allData.id1Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　　男"),
                                        Container(
                                          width: 30,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[1],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[1] = value;
                                              if(_sex[1]){
                                                allData.id1Sex = "女";
                                                _sex[0] = !_sex[1];
                                              }
                                              else{
                                                allData.id1Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　女"),
                                      ]
                                  )
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1Age], ContentsLabel.hintLabelMap[ContentsLabel.id1Age], ContentsLabel.id1Age),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text("生年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.id1Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.id1Birth),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 130, 1, 1),
                                                maxTime: now,
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.id1Birth = DateFormat.yMMMMd("ja_JP").format(date);
                                                  });
                                                },
                                                currentTime: allData.id1Birth == null ? now : allData.id1Birth,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.id1Birth = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  生年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.id1Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
//                                    : Text(allData.id1Birth),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-110),
//                                      lastDate: DateTime(now.year+1),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.id1Birth = DateFormat.yMMMMd("ja_JP").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.id1Birth = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),

                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1Blood], ContentsLabel.hintLabelMap[ContentsLabel.id1Blood], ContentsLabel.id1Blood),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("住所",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1Address1], ContentsLabel.hintLabelMap[ContentsLabel.id1Address1], ContentsLabel.id1Address1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1Address2], ContentsLabel.hintLabelMap[ContentsLabel.id1Address2], ContentsLabel.id1Address2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1Address3], ContentsLabel.hintLabelMap[ContentsLabel.id1Address3], ContentsLabel.id1Address3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1Address4], ContentsLabel.hintLabelMap[ContentsLabel.id1Address4], ContentsLabel.id1Address4),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1HouseTel], ContentsLabel.hintLabelMap[ContentsLabel.id1HouseTel], ContentsLabel.id1HouseTel),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1SelTel], ContentsLabel.hintLabelMap[ContentsLabel.id1SelTel], ContentsLabel.id1SelTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("緊急連絡先",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1EmergeName], ContentsLabel.hintLabelMap[ContentsLabel.id1EmergeName], ContentsLabel.id1EmergeName),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id1EmergeTel], ContentsLabel.hintLabelMap[ContentsLabel.id1EmergeTel], ContentsLabel.id1EmergeTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Divider(
                                color: Colors.black,

                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("メンバー２",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.all(10),),
//                          txtBox(contents.textFieldMap[ContentsLabel.id2Role], ContentsLabel.hintLabelMap[ContentsLabel.id2Role], ContentsLabel.id2Role),
                              TextField(
                                maxLength: 2,
                                controller: contents.textFieldMap[ContentsLabel.id2Role],
                                enabled: true,
                                maxLengthEnforced: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintText: ContentsLabel.hintLabelMap[ContentsLabel.id2Role],
                                  labelText: ContentsLabel.id2Role,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2Name], ContentsLabel.hintLabelMap[ContentsLabel.id2Name], ContentsLabel.id2Name),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2NameH], ContentsLabel.hintLabelMap[ContentsLabel.id2NameH], ContentsLabel.id2NameH),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                      children: <Widget>[
                                        Text("  性別",style: TextStyle(color: Colors.black54),),
                                        Container(
                                          width: 50,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[2],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[2] = value;
                                              if(_sex[2]){
                                                allData.id2Sex = "男";
                                                _sex[3] = !_sex[2];
                                              }
                                              else{
                                                allData.id2Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　　男"),
                                        Container(
                                          width: 30,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[3],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[3] = value;
                                              if(_sex[3]){
                                                allData.id2Sex = "女";
                                                _sex[2] = !_sex[3];
                                              }
                                              else{
                                                allData.id2Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　女"),
                                      ]
                                  )
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2Age], ContentsLabel.hintLabelMap[ContentsLabel.id2Age], ContentsLabel.id2Age),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text("生年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.id2Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.id2Birth),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 130, 1, 1),
                                                maxTime: now,
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.id2Birth = DateFormat.yMMMMd("ja_JP").format(date);
                                                  });
                                                },
                                                currentTime: allData.id2Birth == null ? now : allData.id2Birth,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.id2Birth = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  生年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.id2Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
//                                    : Text(allData.id2Birth),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-110),
//                                      lastDate: DateTime(now.year+1),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.id2Birth = DateFormat.yMMMMd("ja_JP").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.id2Birth = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),

                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2Blood], ContentsLabel.hintLabelMap[ContentsLabel.id2Blood], ContentsLabel.id2Blood),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("住所",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2Address1], ContentsLabel.hintLabelMap[ContentsLabel.id2Address1], ContentsLabel.id2Address1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2Address2], ContentsLabel.hintLabelMap[ContentsLabel.id2Address2], ContentsLabel.id2Address2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2Address3], ContentsLabel.hintLabelMap[ContentsLabel.id2Address3], ContentsLabel.id2Address3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2Address4], ContentsLabel.hintLabelMap[ContentsLabel.id2Address4], ContentsLabel.id2Address4),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2HouseTel], ContentsLabel.hintLabelMap[ContentsLabel.id2HouseTel], ContentsLabel.id2HouseTel),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2SelTel], ContentsLabel.hintLabelMap[ContentsLabel.id2SelTel], ContentsLabel.id2SelTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("緊急連絡先",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2EmergeName], ContentsLabel.hintLabelMap[ContentsLabel.id2EmergeName], ContentsLabel.id2EmergeName),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id2EmergeTel], ContentsLabel.hintLabelMap[ContentsLabel.id2EmergeTel], ContentsLabel.id2EmergeTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Divider(
                                color: Colors.black,

                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("メンバー3",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.all(10),),
//                          txtBox(contents.textFieldMap[ContentsLabel.id3Role], ContentsLabel.hintLabelMap[ContentsLabel.id3Role], ContentsLabel.id3Role),
                              TextField(
                                maxLength: 2,
                                controller: contents.textFieldMap[ContentsLabel.id3Role],
                                enabled: true,
                                maxLengthEnforced: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintText: ContentsLabel.hintLabelMap[ContentsLabel.id3Role],
                                  labelText: ContentsLabel.id3Role,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3Name], ContentsLabel.hintLabelMap[ContentsLabel.id3Name], ContentsLabel.id3Name),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3NameH], ContentsLabel.hintLabelMap[ContentsLabel.id3NameH], ContentsLabel.id3NameH),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                      children: <Widget>[
                                        Text("  性別",style: TextStyle(color: Colors.black54),),
                                        Container(
                                          width: 50,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[4],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[4] = value;
                                              if(_sex[4]){
                                                allData.id3Sex = "男";
                                                _sex[5] = !_sex[4];
                                              }
                                              else{
                                                allData.id3Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　　男"),
                                        Container(
                                          width: 30,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[5],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[5] = value;
                                              _sex[4] = !value;
                                              if(_sex[5]){
                                                allData.id3Sex = "女";
                                                _sex[4] = !_sex[5];
                                              }
                                              else{
                                                allData.id3Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　女"),
                                      ]
                                  )
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3Age], ContentsLabel.hintLabelMap[ContentsLabel.id3Age], ContentsLabel.id3Age),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text("生年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.id3Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.id3Birth),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 130, 1, 1),
                                                maxTime: now,
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.id3Birth = DateFormat.yMMMMd("ja_JP").format(date);
                                                  });
                                                },
                                                currentTime: allData.id3Birth == null ? now : allData.id3Birth,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.id3Birth = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  生年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.id3Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
//                                    : Text(allData.id3Birth),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-110),
//                                      lastDate: DateTime(now.year+1),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.id3Birth = DateFormat.yMMMMd("ja_JP").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.id3Birth = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),

                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3Blood], ContentsLabel.hintLabelMap[ContentsLabel.id3Blood], ContentsLabel.id3Blood),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("住所",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3Address1], ContentsLabel.hintLabelMap[ContentsLabel.id3Address1], ContentsLabel.id3Address1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3Address2], ContentsLabel.hintLabelMap[ContentsLabel.id3Address2], ContentsLabel.id3Address2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3Address3], ContentsLabel.hintLabelMap[ContentsLabel.id3Address3], ContentsLabel.id3Address3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3Address4], ContentsLabel.hintLabelMap[ContentsLabel.id3Address4], ContentsLabel.id3Address4),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3HouseTel], ContentsLabel.hintLabelMap[ContentsLabel.id3HouseTel], ContentsLabel.id3HouseTel),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3SelTel], ContentsLabel.hintLabelMap[ContentsLabel.id3SelTel], ContentsLabel.id3SelTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("緊急連絡先",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3EmergeName], ContentsLabel.hintLabelMap[ContentsLabel.id3EmergeName], ContentsLabel.id3EmergeName),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id3EmergeTel], ContentsLabel.hintLabelMap[ContentsLabel.id3EmergeTel], ContentsLabel.id3EmergeTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Divider(
                                color: Colors.black,

                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("メンバー4",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.all(10),),
//                          txtBox(contents.textFieldMap[ContentsLabel.id4Role], ContentsLabel.hintLabelMap[ContentsLabel.id4Role], ContentsLabel.id4Role),
                              TextField(
                                maxLength: 2,
                                controller: contents.textFieldMap[ContentsLabel.id4Role],
                                enabled: true,
                                maxLengthEnforced: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintText: ContentsLabel.hintLabelMap[ContentsLabel.id4Role],
                                  labelText: ContentsLabel.id4Role,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4Name], ContentsLabel.hintLabelMap[ContentsLabel.id4Name], ContentsLabel.id4Name),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4NameH], ContentsLabel.hintLabelMap[ContentsLabel.id4NameH], ContentsLabel.id4NameH),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                      children: <Widget>[
                                        Text("  性別",style: TextStyle(color: Colors.black54),),
                                        Container(
                                          width: 50,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[6],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[6] = value;
                                              if(_sex[6]){
                                                allData.id4Sex = "男";
                                                _sex[7] = !_sex[6];
                                              }
                                              else{
                                                allData.id4Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　　男"),
                                        Container(
                                          width: 30,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[7],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[7] = value;
                                              if(_sex[7]){
                                                allData.id4Sex = "女";
                                                _sex[6] = !_sex[7];
                                              }
                                              else{
                                                allData.id4Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　女"),
                                      ]
                                  )
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4Age], ContentsLabel.hintLabelMap[ContentsLabel.id4Age], ContentsLabel.id4Age),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text("生年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.id4Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.id4Birth),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 130, 1, 1),
                                                maxTime: now,
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.id4Birth = DateFormat.yMMMMd("ja_JP").format(date);
                                                  });
                                                },
                                                currentTime: allData.id4Birth == null ? now : allData.id4Birth,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.id4Birth = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  生年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.id4Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
//                                    : Text(allData.id4Birth),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-110),
//                                      lastDate: DateTime(now.year+1),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.id4Birth = DateFormat.yMMMMd("ja_JP").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.id4Birth = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),

                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4Blood], ContentsLabel.hintLabelMap[ContentsLabel.id4Blood], ContentsLabel.id4Blood),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("住所",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4Address1], ContentsLabel.hintLabelMap[ContentsLabel.id4Address1], ContentsLabel.id4Address1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4Address2], ContentsLabel.hintLabelMap[ContentsLabel.id4Address2], ContentsLabel.id4Address2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4Address3], ContentsLabel.hintLabelMap[ContentsLabel.id4Address3], ContentsLabel.id4Address3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4Address4], ContentsLabel.hintLabelMap[ContentsLabel.id4Address4], ContentsLabel.id4Address4),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4HouseTel], ContentsLabel.hintLabelMap[ContentsLabel.id4HouseTel], ContentsLabel.id4HouseTel),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4SelTel], ContentsLabel.hintLabelMap[ContentsLabel.id4SelTel], ContentsLabel.id4SelTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("緊急連絡先",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4EmergeName], ContentsLabel.hintLabelMap[ContentsLabel.id4EmergeName], ContentsLabel.id4EmergeName),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id4EmergeTel], ContentsLabel.hintLabelMap[ContentsLabel.id4EmergeTel], ContentsLabel.id4EmergeTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Divider(
                                color: Colors.black,

                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("メンバー5",style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.all(10),),
//                          txtBox(contents.textFieldMap[ContentsLabel.id5Role], ContentsLabel.hintLabelMap[ContentsLabel.id5Role], ContentsLabel.id5Role),
                              TextField(
                                maxLength: 2,
                                controller: contents.textFieldMap[ContentsLabel.id5Role],
                                enabled: true,
                                maxLengthEnforced: false,
                                obscureText: false,
                                decoration: InputDecoration(
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.blue),
                                  ),
                                  hintText: ContentsLabel.hintLabelMap[ContentsLabel.id5Role],
                                  labelText: ContentsLabel.id5Role,
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5Name], ContentsLabel.hintLabelMap[ContentsLabel.id5Name], ContentsLabel.id5Name),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5NameH], ContentsLabel.hintLabelMap[ContentsLabel.id5NameH], ContentsLabel.id5NameH),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                  height: 65,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: Colors.black),
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                      children: <Widget>[
                                        Text("  性別",style: TextStyle(color: Colors.black54),),
                                        Container(
                                          width: 50,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[8],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[8] = value;
                                              if(_sex[8]){
                                                allData.id5Sex = "男";
                                                _sex[9] = !_sex[8];
                                              }
                                              else{
                                                allData.id5Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　　男"),
                                        Container(
                                          width: 30,
                                        ),
                                        Checkbox(
                                          activeColor: Colors.blueAccent,
                                          value: _sex[9],
                                          onChanged: (bool value){
                                            setState(() {
                                              _sex[9] = value;
                                              if(_sex[9]){
                                                allData.id5Sex = "女";
                                                _sex[8] = !_sex[9];
                                              }
                                              else{
                                                allData.id5Sex = null;
                                              }
                                            });
                                          },
                                        ),
                                        Text("　女"),
                                      ]
                                  )
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5Age], ContentsLabel.hintLabelMap[ContentsLabel.id5Age], ContentsLabel.id5Age),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 2,
                                      child: Center(
                                        child: Text("生年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.id5Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.id5Birth),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 130, 1, 1),
                                                maxTime: now,
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.id5Birth = DateFormat.yMMMMd("ja_JP").format(date);
                                                  });
                                                },
                                                currentTime: allData.id5Birth == null ? now : allData.id5Birth,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.id5Birth = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  生年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.id5Birth == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
//                                    : Text(allData.id5Birth),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-110),
//                                      lastDate: DateTime(now.year+1),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.id5Birth = DateFormat.yMMMMd("ja_JP").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.id5Birth = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),

                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5Blood], ContentsLabel.hintLabelMap[ContentsLabel.id5Blood], ContentsLabel.id5Blood),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("住所",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5Address1], ContentsLabel.hintLabelMap[ContentsLabel.id5Address1], ContentsLabel.id5Address1),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5Address2], ContentsLabel.hintLabelMap[ContentsLabel.id5Address2], ContentsLabel.id5Address2),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5Address3], ContentsLabel.hintLabelMap[ContentsLabel.id5Address3], ContentsLabel.id5Address3),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5Address4], ContentsLabel.hintLabelMap[ContentsLabel.id5Address4], ContentsLabel.id5Address4),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5HouseTel], ContentsLabel.hintLabelMap[ContentsLabel.id5HouseTel], ContentsLabel.id5HouseTel),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5SelTel], ContentsLabel.hintLabelMap[ContentsLabel.id5SelTel], ContentsLabel.id5SelTel),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("緊急連絡先",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5EmergeName], ContentsLabel.hintLabelMap[ContentsLabel.id5EmergeName], ContentsLabel.id5EmergeName),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.id5EmergeTel], ContentsLabel.hintLabelMap[ContentsLabel.id5EmergeTel], ContentsLabel.id5EmergeTel),
                              Padding(padding: EdgeInsets.all(10),),
                            ]
                        ),
                      ),
                      isExpanded: expand[5],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('行動予定'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              txtBox(contents.textFieldMap[ContentsLabel.destination], ContentsLabel.hintLabelMap[ContentsLabel.destination], ContentsLabel.destination),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.method], ContentsLabel.hintLabelMap[ContentsLabel.method], ContentsLabel.method),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("登山開始日時",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: allData.start == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                                  : Text(allData.start),
                                            )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              icon: Icon(Icons.date_range),
                                              onPressed: () {
                                                DatePicker.showDatePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime(now.year - 1, 1, 1),
                                                    maxTime: DateTime(now.year + 5, 12, 31),
                                                    onConfirm: (date) {
                                                      setState(() {
                                                        allData.start = DateFormat.yMMMMd("ja_JP").format(date);
                                                      });
                                                    },
                                                    currentTime: allData.start == null ? now : allData.start,
                                                    locale: LocaleType.jp
                                                );
                                              }
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:
                                          IconButton(
                                            icon: Icon(Icons.backspace),
                                            onPressed: ()async{
                                              setState(() {
                                                allData.start = null;
                                              });
                                            },
                                          ),
                                        ),
//                                    Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                    Container(
//                                      width: 30,
//                                    ),
//                                    allData.start == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                        : Text(allData.start),
//                                    Container(
//                                      width: 10,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.date_range),
//                                      onPressed: ()async{
//                                        final DateTime selected = await showDatePicker(
//                                          context: context,
//                                          locale: const Locale("ja"),
//                                          initialDate: now,
//                                          firstDate: DateTime(now.year-1),
//                                          lastDate: DateTime(now.year+5),
//                                        );
//                                        if (selected != null) {
//                                          setState(() {
//                                            allData.start = DateFormat.yMMMMd("ja_JP").format(selected);
//                                          });
//                                        }
//                                      },
//                                    ),
//                                    Container(
//                                      width: 5,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.backspace),
//                                      onPressed: ()async{
//                                        setState(() {
//                                          allData.start = null;
//                                        });
//                                      },
//                                    ),
                                      ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(10),),
                                  Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text("時刻",style: TextStyle(color: Colors.black54),),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: allData.sTime == null ? Text("時刻を選択",style: TextStyle(color: Colors.black54))
                                                : Text(allData.sTime),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                          icon: Icon(Icons.access_time),
                                          onPressed: ()async{
                                            final TimeOfDay selected = await showTimePicker(
                                                context: context,
                                                initialTime: TimeOfDay.now()
                                            );
                                            if (selected != null) {
                                              setState(() {
                                                allData.sTime = "${selected.format(context)}";
                                              });
                                            }
                                          },
                                        ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                          icon: Icon(Icons.backspace),
                                          onPressed: ()async{
                                            setState(() {
                                              allData.sTime = null;
                                            });
                                          },
                                        ),
                                        ),
//                                    Text("  時刻",style: TextStyle(color: Colors.black54),),
//                                    Container(
//                                      width: 30,
//                                    ),
//                                    allData.sTime == null ? Text("時刻を選択",style: TextStyle(color: Colors.black54))
//                                        : Text(allData.sTime),
//                                    Container(
//                                      width: 10,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.access_time),
//                                      onPressed: ()async{
//                                        final TimeOfDay selected = await showTimePicker(
//                                            context: context,
//                                            initialTime: TimeOfDay.now()
//                                        );
//                                        if (selected != null) {
//                                          setState(() {
//                                            allData.sTime = "${selected.format(context)}";
//                                          });
//                                        }
//                                      },
//                                    ),
//                                    Container(
//                                      width: 5,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.backspace),
//                                      onPressed: ()async{
//                                        setState(() {
//                                          allData.sTime = null;
//                                        });
//                                      },
//                                    ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("下山予定日時",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Column(
                                children: <Widget>[
                                  Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                          ),
                                        ),
                                        Expanded(
                                            flex: 3,
                                            child: Center(
                                              child: allData.finish == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                                  : Text(allData.finish),
                                            )
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                              icon: Icon(Icons.date_range),
                                              onPressed: () {
                                                DatePicker.showDatePicker(
                                                    context,
                                                    showTitleActions: true,
                                                    minTime: DateTime(now.year - 1, 1, 1),
                                                    maxTime: DateTime(now.year + 5, 12, 31),
                                                    onConfirm: (date) {
                                                      setState(() {
                                                        allData.finish = DateFormat.yMMMMd("ja_JP").format(date);
                                                      });
                                                    },
                                                    currentTime: allData.finish == null ? now : allData.finish,
                                                    locale: LocaleType.jp
                                                );
                                              }
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child:
                                          IconButton(
                                            icon: Icon(Icons.backspace),
                                            onPressed: ()async{
                                              setState(() {
                                                allData.finish = null;
                                              });
                                            },
                                          ),
                                        ),
//                                    Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                    Container(
//                                      width: 30,
//                                    ),
//                                    allData.finish == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                        : Text(allData.finish),
//                                    Container(
//                                      width: 10,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.date_range),
//                                      onPressed: ()async{
//                                        final DateTime selected = await showDatePicker(
//                                          context: context,
//                                          locale: const Locale("ja"),
//                                          initialDate: now,
//                                          firstDate: DateTime(now.year-1),
//                                          lastDate: DateTime(now.year+5),
//                                        );
//                                        if (selected != null) {
//                                          setState(() {
//                                            allData.finish = DateFormat.yMMMMd("ja_JP").format(selected);
//                                          });
//                                        }
//                                      },
//                                    ),
//                                    Container(
//                                      width: 5,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.backspace),
//                                      onPressed: ()async{
//                                        setState(() {
//                                          allData.finish = null;
//                                        });
//                                      },
//                                    ),
                                      ],
                                    ),
                                  ),
                                  Padding(padding: EdgeInsets.all(10),),
                                  Container(
                                    height: 65,
                                    decoration: BoxDecoration(
                                      border: Border.all(color: Colors.black),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      children: <Widget>[
                                        Expanded(
                                          flex: 1,
                                          child: Center(
                                            child: Text("時刻",style: TextStyle(color: Colors.black54),)
                                          ),
                                        ),
                                        Expanded(
                                          flex: 3,
                                          child: Center(
                                            child: allData.fTime == null ? Text("時刻を選択",style: TextStyle(color: Colors.black54))
                                                : Text(allData.fTime),
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: Icon(Icons.access_time),
                                            onPressed: ()async{
                                              final TimeOfDay selected = await showTimePicker(
                                                  context: context,
                                                  initialTime: TimeOfDay.now()
                                              );
                                              if (selected != null) {
                                                setState(() {
                                                  allData.fTime = "${selected.format(context)}";
                                                });
                                              }
                                            },
                                          ),
                                        ),
                                        Expanded(
                                          flex: 1,
                                          child: IconButton(
                                            icon: Icon(Icons.backspace),
                                            onPressed: ()async{
                                              setState(() {
                                                allData.fTime = null;
                                              });
                                            },
                                          ),
                                        ),
//                                    Text("  時刻",style: TextStyle(color: Colors.black54),),
//                                    Container(
//                                      width: 30,
//                                    ),
//                                    allData.fTime == null ? Text("時刻を選択",style: TextStyle(color: Colors.black54))
//                                        : Text(allData.fTime),
//                                    Container(
//                                      width: 10,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.access_time),
//                                      onPressed: ()async{
//                                        final TimeOfDay selected = await showTimePicker(
//                                            context: context,
//                                            initialTime: TimeOfDay.now()
//                                        );
//                                        if (selected != null) {
//                                          setState(() {
//                                            now = DateTime.now();
//                                            allData.fTime = "${selected.format(context)}";
//                                          });
//                                        }
//                                      },
//                                    ),
//                                    Container(
//                                      width: 5,
//                                    ),
//                                    IconButton(
//                                      icon: Icon(Icons.backspace),
//                                      onPressed: ()async{
//                                        setState(() {
//                                          allData.fTime = null;
//                                        });
//                                      },
//                                    ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("1日目",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.date1 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.date1),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 1, 1, 1),
                                                maxTime: DateTime(now.year + 5, 12, 31),
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.date1 = DateFormat("M/d").format(date);
                                                  });
                                                },
                                                currentTime: allData.date1 == null ? now : allData.date1,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.date1 = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.date1 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                    : Text(allData.date1),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-1),
//                                      lastDate: DateTime(now.year+5),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.date1 = DateFormat("M/dd").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.date1 = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.action1], ContentsLabel.hintLabelMap[ContentsLabel.action1], ContentsLabel.action1),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("2日目",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.date2 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.date2),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 1, 1, 1),
                                                maxTime: DateTime(now.year + 5, 12, 31),
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.date2 = DateFormat("M/d").format(date);
                                                  });
                                                },
                                                currentTime: allData.date2 == null ? now : allData.date2,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.date2 = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.date2 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                    : Text(allData.date2),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-1),
//                                      lastDate: DateTime(now.year+5),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.date2 = DateFormat("M/dd").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.date2 = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.action2], ContentsLabel.hintLabelMap[ContentsLabel.action2], ContentsLabel.action2),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("3日目",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.date3 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.date3),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 1, 1, 1),
                                                maxTime: DateTime(now.year + 5, 12, 31),
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.date3 = DateFormat("M/d").format(date);
                                                  });
                                                },
                                                currentTime: allData.date3 == null ? now : allData.date3,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.date3 = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.date3 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                    : Text(allData.date3),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-1),
//                                      lastDate: DateTime(now.year+5),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.date3 = DateFormat("M/dd").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.date3 = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.action3], ContentsLabel.hintLabelMap[ContentsLabel.action3], ContentsLabel.action3),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("4日目",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.date4 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.date4),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 1, 1, 1),
                                                maxTime: DateTime(now.year + 5, 12, 31),
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.date4 = DateFormat("M/d").format(date);
                                                  });
                                                },
                                                currentTime: allData.date4 == null ? now : allData.date4,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.date4 = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.date4 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                    : Text(allData.date4),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-1),
//                                      lastDate: DateTime(now.year+5),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.date4 = DateFormat("M/dd").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.date4 = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.action4], ContentsLabel.hintLabelMap[ContentsLabel.action4], ContentsLabel.action4),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("5日目",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.date5 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.date5),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 1, 1, 1),
                                                maxTime: DateTime(now.year + 5, 12, 31),
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.date5 = DateFormat("M/d").format(date);
                                                  });
                                                },
                                                currentTime: allData.date5 == null ? now : allData.date5,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.date5 = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.date5 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                    : Text(allData.date5),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-1),
//                                      lastDate: DateTime(now.year+5),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.date5 = DateFormat("M/dd").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.date5 = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.action5], ContentsLabel.hintLabelMap[ContentsLabel.action5], ContentsLabel.action5),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("6日目",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              Container(
                                height: 65,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: <Widget>[
                                    Expanded(
                                      flex: 1,
                                      child: Center(
                                        child: Text("年月日",style: TextStyle(color: Colors.black54),),
                                      ),
                                    ),
                                    Expanded(
                                        flex: 3,
                                        child: Center(
                                          child: allData.date6 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54))
                                              : Text(allData.date6),
                                        )
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child: IconButton(
                                          icon: Icon(Icons.date_range),
                                          onPressed: () {
                                            DatePicker.showDatePicker(
                                                context,
                                                showTitleActions: true,
                                                minTime: DateTime(now.year - 1, 1, 1),
                                                maxTime: DateTime(now.year + 5, 12, 31),
                                                onConfirm: (date) {
                                                  setState(() {
                                                    allData.date6 = DateFormat("M/d").format(date);
                                                  });
                                                },
                                                currentTime: allData.date6 == null ? now : allData.date6,
                                                locale: LocaleType.jp
                                            );
                                          }
                                      ),
                                    ),
                                    Expanded(
                                      flex: 1,
                                      child:
                                      IconButton(
                                        icon: Icon(Icons.backspace),
                                        onPressed: ()async{
                                          setState(() {
                                            allData.date6 = null;
                                          });
                                        },
                                      ),
                                    ),
//                                Text("  年月日",style: TextStyle(color: Colors.black54),),
//                                Container(
//                                  width: 30,
//                                ),
//                                allData.date6 == null ? Text("日付を選択",style: TextStyle(color: Colors.black54),)
//                                    : Text(allData.date6),
//                                Container(
//                                  width: 10,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.date_range),
//                                  onPressed: ()async{
//                                    final DateTime selected = await showDatePicker(
//                                      context: context,
//                                      locale: const Locale("ja"),
//                                      initialDate: now,
//                                      firstDate: DateTime(now.year-1),
//                                      lastDate: DateTime(now.year+5),
//                                    );
//                                    if (selected != null) {
//                                      setState(() {
//                                        allData.date6 = DateFormat("M/dd").format(selected);
//                                      });
//                                    }
//                                  },
//                                ),
//                                Container(
//                                  width: 5,
//                                ),
//                                IconButton(
//                                  icon: Icon(Icons.backspace),
//                                  onPressed: ()async{
//                                    setState(() {
//                                      allData.date6 = null;
//                                    });
//                                  },
//                                ),
                                  ],
                                ),
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.action6], ContentsLabel.hintLabelMap[ContentsLabel.action6], ContentsLabel.action6),
                            ]
                        ),
                      ),
                      isExpanded: expand[6],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('概念図／エスケープルート他'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("概念図",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),),
                              Padding(padding: EdgeInsets.all(10),),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  (_image == null)
                                      ? Icon(Icons.no_sim)
                                      : Image.memory(
                                    _image.readAsBytesSync(),
                                    height: 100.0,
                                    width: 100.0,
                                  ),
                                  // _image == null ? Container(
                                  //     padding: EdgeInsets.all(10.0),
                                  //     child: RaisedButton(
                                  //       child: Text('カメラで撮影'),
                                  //       onPressed: () {
                                  //         if(Platform.isAndroid){
                                  //           _getImageFromDevice(ImageSource.camera);
                                  //         }
                                  //         else if(Platform.isIOS){
                                  //           _checkCameraPermissionStatus();
                                  //         }
                                  //       },
                                  //     )) : Container(),
                                  _image == null ? Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: RaisedButton(
                                        child: Text('ライブラリから選択'),
                                        onPressed: () {
                                          if(Platform.isAndroid){
                                            _getImageFromDevice(ImageSource.gallery);
                                          }
                                          else if(Platform.isIOS){
                                            _checkPhotosPermissionStatus();
                                          }
                                        },
                                      )) : Container(),
                                  _image == null ? Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: RaisedButton(
                                        child: Text('ファイルから選択'),
                                        onPressed: () async{
                                          _getFileFromDevice();
                                        },
                                      )) : Container(),
                                  _image != null ? Container(
                                      padding: EdgeInsets.all(10.0),
                                      child: RaisedButton(
                                        child: Text('取り消し'),
                                        onPressed: () {
                                          setState(() {
                                            _image = null;
                                            _imagePath = null;
                                          });
                                        },
                                      )) : Container(),
                                ],
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.other1], ContentsLabel.hintLabelMap[ContentsLabel.other1], ContentsLabel.other1),
                            ]
                        ),
                      ),
                      isExpanded: expand[7],
                      canTapOnHeader: true,
                    ),
                    ExpansionPanel(
                      headerBuilder: (BuildContext context, bool isExpanded) {
                        return ListTile(
                          title: Text('装備情報'),
                        );
                      },
                      body:Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Text("個人装備",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              _checkBox(ContentsLabel.zack, allData.zack),
                              _checkBox(ContentsLabel.shoes, allData.shoes),
                              _checkBox(ContentsLabel.rainWear, allData.rainWear),
                              _checkBox(ContentsLabel.sleepBag, allData.sleepBag),
                              _checkBox(ContentsLabel.headLmp, allData.headLmp),
                              _checkBox(ContentsLabel.light, allData.light),
                              _checkBox(ContentsLabel.battery, allData.battery),
                              _checkBox(ContentsLabel.compass, allData.compass),
                              _checkBox(ContentsLabel.planDoc, allData.planDoc),
                              _checkBox(ContentsLabel.selPhone, allData.selPhone),
                              _checkBox(ContentsLabel.lighter, allData.lighter),
                              _checkBox(ContentsLabel.zackCover, allData.zackCover),
                              _checkBox(ContentsLabel.sleepBagCover, allData.sleepBagCover),
                              _checkBox(ContentsLabel.helmet, allData.helmet),
                              _checkBox(ContentsLabel.crampons, allData.crampons),
                              _checkBox(ContentsLabel.iceAx, allData.iceAx),
                              _checkBox(ContentsLabel.snack, allData.snack),
                              _checkBox(ContentsLabel.mask, allData.mask),
                              _checkBox(ContentsLabel.alMeter, allData.alMeter),
                              _checkBox(ContentsLabel.tissue, allData.tissue),
                              _checkBox(ContentsLabel.map, allData.map),
                              _checkBox(ContentsLabel.winterClothes, allData.winterClothes),
                              _checkBox(ContentsLabel.medicalCase, allData.medicalCase),
                              _checkBox(ContentsLabel.towel, allData.towel),
                              _checkBox(ContentsLabel.stick, allData.stick),
                              _checkBox(ContentsLabel.knife, allData.knife),
                              _checkBox(ContentsLabel.thermometer, allData.thermometer),
                              _checkBox(ContentsLabel.changeClothes, allData.changeClothes),
                              _checkBox(ContentsLabel.gloves, allData.gloves),
                              _checkBox(ContentsLabel.workGloves, allData.workGloves),
                              _checkBox(ContentsLabel.cap, allData.cap),
                              _checkBox(ContentsLabel.rainSpats, allData.rainSpats),
                              _checkBox(ContentsLabel.insects, allData.insects),
                              _checkBox(ContentsLabel.copy, allData.copy),
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.blue,
                                        value: allData.food,
                                        onChanged: (bool e){
                                          setState(() {
                                            allData.changeBool(ContentsLabel.num1,e);
                                          });
                                        },
                                      ),
                                      Container(
                                        width: 50,
                                      ),
                                      Text(ContentsLabel.num1,style: TextStyle(color: Colors.black),),
                                      Container(
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                  !allData.food ? Container() : Row(
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child:TextField(
                                          controller: contents.textFieldMap[ContentsLabel.num1],
                                          enabled: true,
                                          maxLengthEnforced: false,
                                          obscureText: false,
                                        ),
                                      ),
                                      Text("食分"),
                                    ],
                                  ),

                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5),),
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.blue,
                                        value: allData.subFood,
                                        onChanged: (bool e){
                                          setState(() {
                                            allData.changeBool(ContentsLabel.num2, e);
                                          });
                                        },
                                      ),
                                      Container(
                                        width: 50,
                                      ),
                                      Text(ContentsLabel.num2,style: TextStyle(color: Colors.black),),
                                      Container(
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                  !allData.subFood ? Container() : Row(
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child:TextField(
                                          controller: contents.textFieldMap[ContentsLabel.num2],
                                          enabled: true,
                                          maxLengthEnforced: false,
                                          obscureText: false,
                                        ),
                                      ),
                                      Text(" 食分"),
                                    ],
                                  ),

                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5),),
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.blue,
                                        value: allData.emergeFood,
                                        onChanged: (bool e){
                                          setState(() {
                                            allData.changeBool(ContentsLabel.cal, e);
                                          });
                                        },
                                      ),
                                      Container(
                                        width: 50,
                                      ),
                                      Text(ContentsLabel.cal,style: TextStyle(color: Colors.black),),
                                      Container(
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                  !allData.emergeFood ? Container() : Row(
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child:TextField(
                                          controller: contents.textFieldMap[ContentsLabel.cal],
                                          enabled: true,
                                          maxLengthEnforced: false,
                                          obscureText: false,
                                        ),
                                      ),
                                      Text(" kcal"),
                                    ],
                                  ),

                                ],
                              ),
                              Padding(padding: EdgeInsets.all(5),),
                              Row(
                                children: <Widget>[
                                  Row(
                                    children: <Widget>[
                                      Checkbox(
                                        activeColor: Colors.blue,
                                        value: allData.water,
                                        onChanged: (bool e){
                                          setState(() {
                                            allData.changeBool(ContentsLabel.amount, e);
                                          });
                                        },
                                      ),
                                      Container(
                                        width: 50,
                                      ),
                                      Text(ContentsLabel.amount,style: TextStyle(color: Colors.black),),
                                      Container(
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                  !allData.water ? Container() : Row(
                                    children: <Widget>[
                                      Container(
                                        width: 50,
                                        height: 50,
                                        child:TextField(
                                          controller: contents.textFieldMap[ContentsLabel.amount],
                                          enabled: true,
                                          maxLengthEnforced: false,
                                          obscureText: false,
                                        ),
                                      ),
                                      Text(" L"),
                                    ],
                                  ),

                                ],
                              ),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.perOther], ContentsLabel.hintLabelMap[ContentsLabel.perOther], ContentsLabel.perOther),
                              Padding(padding: EdgeInsets.all(10),),
                              Text("共同装備",style: TextStyle(color: Colors.black54),),
                              Padding(padding: EdgeInsets.all(10),),
                              _checkBox(ContentsLabel.tent, allData.tent),
                              _checkBox(ContentsLabel.hob, allData.hob),
                              _checkBox(ContentsLabel.gas, allData.gas),
                              _checkBox(ContentsLabel.subGas, allData.subGas),
                              _checkBox(ContentsLabel.rope, allData.rope),
                              _checkBox(ContentsLabel.celtic, allData.celtic),
                              _checkBox(ContentsLabel.mat, allData.mat),
                              _checkBox(ContentsLabel.cup, allData.cup),
                              _checkBox(ContentsLabel.cook, allData.cook),
                              Padding(padding: EdgeInsets.all(10),),
                              txtBox(contents.textFieldMap[ContentsLabel.joinOther], ContentsLabel.hintLabelMap[ContentsLabel.joinOther], ContentsLabel.joinOther),
//                        TextField(
//                            enabled: true,
//                            maxLengthEnforced: false,
//                            obscureText: false,
//                            decoration: InputDecoration(
//                              enabledBorder: OutlineInputBorder(
//                                borderSide: BorderSide(),
//                              ),
//                              focusedBorder: OutlineInputBorder(
//                                borderSide: BorderSide(color: Colors.blue),
//                              ),
//                              hintText: "食材／ペグ予備／...",
//                              labelText: "その他共同装備",
//                            ),
//                            onChanged: (String value){
//                              setState(() {
//                                allData.joinOther = value;
//                              });
//                            }
//                        ),
                            ]
                        ),
                      ),
                      isExpanded: expand[8],
                      canTapOnHeader: true,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),

        persistentFooterButtons:<Widget>[
          FlatButton(
            child: Text("PreView →",style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
            onPressed: ()async{
              contents.textFieldMap.forEach((key, value) {
                allData.changeText(key, value.text);
              });
              allData.date = DateFormat.yMMMMd("ja_JP").format(DateTime.now());
              String _filePath = await CreatePdf.createPdfA4(allData:allData,imagePath: _imagePath,isNew: widget.isNew == 1 ? 1 : 2);
              print(_filePath);
              Navigator.of(context).push(
                  MaterialPageRoute(
                      builder: (context) => PdfViewPage(filePath: _filePath,data: allData,image: _image,isNew: widget.isNew == 1 ? 1 : 2,id: widget.isNew == 0 ? widget.data.id : null)));
            },
          ),
        ]
    );
  }
}
