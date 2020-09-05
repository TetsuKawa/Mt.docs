import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AllData{
  String file;

  String head;
  String firstDate;
  String belongs;
  String groupName;
  String represent;
  String firstAddress1;
  String firstAddress2;
  String firstAddress3;
  String firstAddress4;
  String firstTel;
  String emergeName;
  String emergeTel;
  String emergeAddress1;
  String emergeAddress2;
  String emergeAddress3;
  String emergeAddress4;

  String localPoint1;
  String localPoint2;
  String localPoint3;
  String localTel1;
  String localTel2;
  String localTel3;

  String id1Role;
  String id1Name;
  String id1NameH;
  String id1Sex;
  String id1Age;
  String id1Birth;
  String id1Blood;
  String id1Address1;
  String id1Address2;
  String id1Address3;
  String id1Address4;
  String id1HouseTel;
  String id1SelTel;
  String id1EmergeName;
  String id1EmergeTel;

  String id2Role;
  String id2Name;
  String id2NameH;
  String id2Sex;
  String id2Age;
  String id2Birth;
  String id2Blood;
  String id2Address1;
  String id2Address2;
  String id2Address3;
  String id2Address4;
  String id2HouseTel;
  String id2SelTel;
  String id2EmergeName;
  String id2EmergeTel;

  String id3Role;
  String id3Name;
  String id3NameH;
  String id3Sex;
  String id3Age;
  String id3Birth;
  String id3Blood;
  String id3Address1;
  String id3Address2;
  String id3Address3;
  String id3Address4;
  String id3HouseTel;
  String id3SelTel;
  String id3EmergeName;
  String id3EmergeTel;

  String id4Role;
  String id4Name;
  String id4NameH;
  String id4Sex;
  String id4Age;
  String id4Birth;
  String id4Blood;
  String id4Address1;
  String id4Address2;
  String id4Address3;
  String id4Address4;
  String id4HouseTel;
  String id4SelTel;
  String id4EmergeName;
  String id4EmergeTel;

  String id5Role;
  String id5Name;
  String id5NameH;
  String id5Sex;
  String id5Age;
  String id5Birth;
  String id5Blood;
  String id5Address1;
  String id5Address2;
  String id5Address3;
  String id5Address4;
  String id5HouseTel;
  String id5SelTel;
  String id5EmergeName;
  String id5EmergeTel;

  String destination;
  String method;
  String start;
  String sTime;
  String finish;
  String fTime;
  String date1;
  String date2;
  String date3;
  String date4;
  String date5;
  String date6;
  String action1;
  String action2;
  String action3;
  String action4;
  String action5;
  String action6;
  String other1;

  bool zack;
  bool shoes;
  bool rainWear;
  bool sleepBag;
  bool headLmp;
  bool light;
  bool battery;
  bool compass;
  bool planDoc;
  bool selPhone;
  bool lighter;
  bool zackCover;
  bool sleepBagCover;
  bool helmet;
  bool crampons;
  bool iceAx;
  bool snack;
  bool mask;
  bool alMeter;
  bool tissue;
  bool map;
  bool winterClothes;
  bool medicalCase;
  bool towel;
  bool stick;
  bool knife;
  bool thermometer;
  bool changeClothes;
  bool gloves;
  bool workGloves;
  bool cap;
  bool rainSpats;
  bool insects;
  bool copy;
  bool food;
  String num1;
  bool subFood;
  String num2;
  bool emergeFood;
  String cal;
  bool water;
  String amount;
  String perOther;

  bool tent;
  bool hob;
  bool gas;
  bool subGas;
  bool rope;
  bool celtic;
  bool mat;
  bool cup;
  bool cook;
  String joinOther;

  int id;
  String date;
  String path;


  Map<String, dynamic> toMap() {
    Map<String, dynamic> map = {};
    map[ContentsLabel.file] = file;
    map[ContentsLabel.head] = head;
    map[ContentsLabel.belongs] = belongs;
    map[ContentsLabel.groupName] = groupName;
    map[ContentsLabel.represent] = represent;
    map[ContentsLabel.firstAddress1] = firstAddress1;
    map[ContentsLabel.firstAddress2] = firstAddress2;
    map[ContentsLabel.firstAddress3] = firstAddress3;
    map[ContentsLabel.firstAddress4] = firstAddress4;
    map[ContentsLabel.firstTel] = firstTel;
    map[ContentsLabel.emergeName] = emergeName;
    map[ContentsLabel.emergeTel] = emergeTel;
    map[ContentsLabel.emergeAddress1] = emergeAddress1;
    map[ContentsLabel.emergeAddress2] = emergeAddress2;
    map[ContentsLabel.emergeAddress3] = emergeAddress3;
    map[ContentsLabel.emergeAddress4] = emergeAddress4;
    map[ContentsLabel.localPoint1] = localPoint1;
    map[ContentsLabel.localTel1] = localTel1;
    map[ContentsLabel.localPoint2] = localPoint2;
    map[ContentsLabel.localTel2] = localTel2;
    map[ContentsLabel.localPoint3] = localPoint3;
    map[ContentsLabel.localTel3] = localTel3;
    map[ContentsLabel.id1Role] = id1Role;
    map[ContentsLabel.id1Name] = id1Name;
    map[ContentsLabel.id1NameH] = id1NameH;
    map[ContentsLabel.id1Age] = id1Age;
    map[ContentsLabel.id1Blood] = id1Blood;
    map[ContentsLabel.id5Address1] = id1Address1;
    map[ContentsLabel.id1Address2] = id1Address2;
    map[ContentsLabel.id1Address3] = id1Address3;
    map[ContentsLabel.id1Address4] = id1Address4;
    map[ContentsLabel.id1HouseTel] = id1HouseTel;
    map[ContentsLabel.id1SelTel] = id1SelTel;
    map[ContentsLabel.id1EmergeName] = id1EmergeName;
    map[ContentsLabel.id1EmergeTel] = id1EmergeTel;
    map[ContentsLabel.id2Role] = id2Role;
    map[ContentsLabel.id2Name] = id2Name;
    map[ContentsLabel.id2NameH] = id2NameH;
    map[ContentsLabel.id2Age] = id2Age;
    map[ContentsLabel.id2Blood] = id2Blood;
    map[ContentsLabel.id2Address1] = id2Address1;
    map[ContentsLabel.id2Address2] = id2Address2;
    map[ContentsLabel.id2Address3] = id2Address3;
    map[ContentsLabel.id2Address4] = id2Address4;
    map[ContentsLabel.id2HouseTel] = id2HouseTel;
    map[ContentsLabel.id2SelTel] = id2SelTel;
    map[ContentsLabel.id2EmergeName] = id2EmergeName;
    map[ContentsLabel.id2EmergeTel] = id2EmergeTel;
    map[ContentsLabel.id2Role] = id3Role;
    map[ContentsLabel.id3Name] = id3Name;
    map[ContentsLabel.id3NameH] = id3NameH;
    map[ContentsLabel.id3Age] = id3Age;
    map[ContentsLabel.id3Blood] = id3Blood;
    map[ContentsLabel.id3Address1] = id3Address1;
    map[ContentsLabel.id3Address2] = id3Address2;
    map[ContentsLabel.id3Address3] = id3Address3;
    map[ContentsLabel.id3Address4] = id3Address4;
    map[ContentsLabel.id3HouseTel] = id3HouseTel;
    map[ContentsLabel.id3SelTel] = id3SelTel;
    map[ContentsLabel.id3EmergeName] = id3EmergeName;
    map[ContentsLabel.id3EmergeTel] = id3EmergeTel;
    map[ContentsLabel.id4Role] = id4Role;
    map[ContentsLabel.id4Name] = id4Name;
    map[ContentsLabel.id4NameH] = id4NameH;
    map[ContentsLabel.id4Age] = id4Age;
    map[ContentsLabel.id4Blood] = id4Blood;
    map[ContentsLabel.id4Address1] = id4Address1;
    map[ContentsLabel.id4Address2] = id4Address2;
    map[ContentsLabel.id4Address3] = id4Address3;
    map[ContentsLabel.id4Address4] = id4Address4;
    map[ContentsLabel.id4HouseTel] = id4HouseTel;
    map[ContentsLabel.id4SelTel] = id4SelTel;
    map[ContentsLabel.id4EmergeName] = id4EmergeName;
    map[ContentsLabel.id4EmergeTel] = id4EmergeTel;
    map[ContentsLabel.id5Role] = id5Role;
    map[ContentsLabel.id5Name] = id5Name;
    map[ContentsLabel.id5NameH] = id5NameH;
    map[ContentsLabel.id5Age] = id5Age;
    map[ContentsLabel.id5Blood] = id5Blood;
    map[ContentsLabel.id5Address1] = id5Address1;
    map[ContentsLabel.id5Address2] = id5Address2;
    map[ContentsLabel.id5Address3] = id5Address3;
    map[ContentsLabel.id5Address4] = id5Address4;
    map[ContentsLabel.id5HouseTel] = id5HouseTel;
    map[ContentsLabel.id5SelTel] = id5SelTel;
    map[ContentsLabel.id5EmergeName] = id5EmergeName;
    map[ContentsLabel.id5EmergeTel] = id5EmergeTel;
    map[ContentsLabel.destination] = destination;
    map[ContentsLabel.method] = method;
    map[ContentsLabel.action1] = action1;
    map[ContentsLabel.action2] = action2;
    map[ContentsLabel.action3] = action3;
    map[ContentsLabel.action4] = action4;
    map[ContentsLabel.action5] = action5;
    map[ContentsLabel.action6] = action6;
    map[ContentsLabel.other1] = other1;
    map[ContentsLabel.num1] = num1;
    map[ContentsLabel.num2] = num2;
    map[ContentsLabel.cal] = cal;
    map[ContentsLabel.amount] = amount;
    map[ContentsLabel.perOther] = perOther;
    map[ContentsLabel.joinOther] = joinOther;

    return map;
  }


  void changeText(String key,String text){
    switch(key){
      case ContentsLabel.file:{
        file = text;
      }break;
      case ContentsLabel.head:{
        head = text;
      }break;
      case ContentsLabel.belongs:{
        belongs = text;
      }break;
      case ContentsLabel.groupName:{
        groupName = text;
      }break;
      case ContentsLabel.represent:{
        represent = text;
      }break;
      case ContentsLabel.firstAddress1:{
        firstAddress1 = text;
      }break;
      case ContentsLabel.firstAddress2:{
        firstAddress2 = text;
      }break;
      case ContentsLabel.firstAddress3:{
        firstAddress3 = text;
      }break;
      case ContentsLabel.firstAddress4:{
        firstAddress4 = text;
      }break;
      case ContentsLabel.firstTel:{
        firstTel = text;
      }break;
      case ContentsLabel.emergeName:{
        emergeName = text;
      }break;
      case ContentsLabel.emergeTel:{
        emergeTel = text;
      }break;
      case ContentsLabel.emergeAddress1:{
        emergeAddress1 = text;
      }break;
      case ContentsLabel.emergeAddress2:{
        emergeAddress2 = text;
      }break;
      case ContentsLabel.emergeAddress3:{
        emergeAddress3 = text;
      }break;
      case ContentsLabel.emergeAddress4:{
        emergeAddress4 = text;
      }break;
      case ContentsLabel.localPoint1:{
        localPoint1 = text;
      }break;
      case ContentsLabel.localTel1:{
        localTel1 = text;
      }break;
      case ContentsLabel.localPoint2:{
        localPoint2 = text;
      }break;
      case ContentsLabel.localTel2:{
        localTel2 = text;
      }break;
      case ContentsLabel.localPoint3:{
        localPoint3 = text;
      }break;
      case ContentsLabel.localPoint3:{
        localTel3 = text;
      }break;
      case ContentsLabel.id1Role:{
        id1Role = text;
      }break;
      case ContentsLabel.id1Name:{
        id1Name = text;
      }break;
      case ContentsLabel.id1NameH:{
        id1NameH = text;
      }break;
      case ContentsLabel.id1Age:{
        id1Age = text;
      }break;
      case ContentsLabel.id1Blood:{
        id1Blood = text;
      }break;
      case ContentsLabel.id1Address1:{
        id1Address1 = text;
      }break;
      case ContentsLabel.id1Address2:{
        id1Address2 = text;
      }break;
      case ContentsLabel.id1Address3:{
        id1Address3 = text;
      }break;
      case ContentsLabel.id1Address4:{
        id1Address4 = text;
      }break;
      case ContentsLabel.id1HouseTel:{
        id1HouseTel = text;
      }break;
      case ContentsLabel.id1SelTel:{
        id1SelTel = text;
      }break;
      case ContentsLabel.id1EmergeName:{
        id1EmergeName = text;
      }break;
      case ContentsLabel.id1EmergeTel:{
        id1EmergeTel = text;
      }break;
      case ContentsLabel.id2Role:{
        id2Role = text;
      }break;
      case ContentsLabel.id2Name:{
        id2Name = text;
      }break;
      case ContentsLabel.id2NameH:{
        id2NameH = text;
      }break;
      case ContentsLabel.id2Age:{
        id2Age = text;
      }break;
      case ContentsLabel.id2Blood:{
        id2Blood = text;
      }break;
      case ContentsLabel.id2Address1:{
        id2Address1 = text;
      }break;
      case ContentsLabel.id2Address2:{
        id2Address2 = text;
      }break;
      case ContentsLabel.id2Address3:{
        id2Address3 = text;
      }break;
      case ContentsLabel.id2Address4:{
        id2Address4 = text;
      }break;
      case ContentsLabel.id2HouseTel:{
        id2HouseTel = text;
      }break;
      case ContentsLabel.id2SelTel:{
        id2SelTel = text;
      }break;
      case ContentsLabel.id2EmergeName:{
        id2EmergeName = text;
      }break;
      case ContentsLabel.id2EmergeTel:{
        id2EmergeTel = text;
      }break;
      case ContentsLabel.id3Role:{
        id3Role = text;
      }break;
      case ContentsLabel.id3Name:{
        id3Name = text;
      }break;
      case ContentsLabel.id3NameH:{
        id3NameH = text;
      }break;
      case ContentsLabel.id3Age:{
        id3Age = text;
      }break;
      case ContentsLabel.id3Blood:{
        id3Blood = text;
      }break;
      case ContentsLabel.id3Address1:{
        id3Address1 = text;
      }break;
      case ContentsLabel.id3Address2:{
        id3Address2 = text;
      }break;
      case ContentsLabel.id3Address3:{
        id3Address3 = text;
      }break;
      case ContentsLabel.id3Address4:{
        id3Address4 = text;
      }break;
      case ContentsLabel.id3HouseTel:{
        id3HouseTel = text;
      }break;
      case ContentsLabel.id3SelTel:{
        id3SelTel = text;
      }break;
      case ContentsLabel.id3EmergeName:{
        id3EmergeName = text;
      }break;
      case ContentsLabel.id3EmergeTel:{
        id3EmergeTel = text;
      }break;
      case ContentsLabel.id4Role:{
        id4Role = text;
      }break;
      case ContentsLabel.id4Name:{
        id4Name = text;
      }break;
      case ContentsLabel.id4NameH:{
        id4NameH = text;
      }break;
      case ContentsLabel.id4Age:{
        id4Age = text;
      }break;
      case ContentsLabel.id4Blood:{
        id4Blood = text;
      }break;
      case ContentsLabel.id4Address1:{
        id4Address1 = text;
      }break;
      case ContentsLabel.id4Address2:{
        id4Address2 = text;
      }break;
      case ContentsLabel.id4Address3:{
        id4Address3 = text;
      }break;
      case ContentsLabel.id4Address4:{
        id4Address4 = text;
      }break;
      case ContentsLabel.id4HouseTel:{
        id4HouseTel = text;
      }break;
      case ContentsLabel.id4SelTel:{
        id4SelTel = text;
      }break;
      case ContentsLabel.id4EmergeName:{
        id4EmergeName = text;
      }break;
      case ContentsLabel.id4EmergeTel:{
        id4EmergeTel = text;
      }break;
      case ContentsLabel.id5Role:{
        id5Role = text;
      }break;
      case ContentsLabel.id5Name:{
        id5Name = text;
      }break;
      case ContentsLabel.id5NameH:{
        id5NameH = text;
      }break;
      case ContentsLabel.id5Age:{
        id5Age = text;
      }break;
      case ContentsLabel.id5Blood:{
        id5Blood = text;
      }break;
      case ContentsLabel.id5Address1:{
        id5Address1 = text;
      }break;
      case ContentsLabel.id5Address2:{
        id5Address2 = text;
      }break;
      case ContentsLabel.id5Address3:{
        id5Address3 = text;
      }break;
      case ContentsLabel.id5Address4:{
        id5Address4 = text;
      }break;
      case ContentsLabel.id5HouseTel:{
        id5HouseTel = text;
      }break;
      case ContentsLabel.id5SelTel:{
        id5SelTel = text;
      }break;
      case ContentsLabel.id5EmergeName:{
        id5EmergeName = text;
      }break;
      case ContentsLabel.id5EmergeTel:{
        id5EmergeTel = text;
      }break;
      case ContentsLabel.destination:{
        destination = text;
      }break;
      case ContentsLabel.method :{
        method = text;
      }break;
      case ContentsLabel.action1:{
        action1 = text;
      }break;
      case ContentsLabel.action2:{
        action2 = text;
      }break;
      case ContentsLabel.action3:{
        action3 = text;
      }break;
      case ContentsLabel.action4:{
        action4 = text;
      }break;
      case ContentsLabel.action5:{
        action5 = text;
      }break;
      case ContentsLabel.action6:{
        action6 = text;
      }break;
      case ContentsLabel.other1:{
        other1 = text;
      }break;
      case ContentsLabel.num1:{
        num1 = text;
      }break;
      case ContentsLabel.num2:{
        num2 = text;
      }break;
      case ContentsLabel.cal:{
        cal = text;
      }break;
      case ContentsLabel.amount:{
        amount = text;
      }break;
      case ContentsLabel.perOther:{
        perOther = text;
      }break;
      case ContentsLabel.joinOther:{
        joinOther = text;
      }break;
    }
  }

  void changeBool(String text,bool e){
    switch(text){
      case ContentsLabel.zack:{
        zack = e;
      }break;
      case ContentsLabel.shoes:{
        shoes = e;
      }break;
      case ContentsLabel.rainWear:{
        rainWear = e;
      }break;
      case ContentsLabel.sleepBag:{
        sleepBag = e;
      }break;
      case ContentsLabel.headLmp:{
        headLmp = e;
      }break;
      case ContentsLabel.light:{
        light = e;
      }break;
      case ContentsLabel.battery:{
        battery = e;
      }break;
      case ContentsLabel.compass:{
        compass = e;
      }break;
      case ContentsLabel.planDoc:{
        planDoc = e;
      }break;
      case ContentsLabel.selPhone:{
        selPhone = e;
      }break;
      case ContentsLabel.lighter:{
        lighter = e;
      }break;
      case ContentsLabel.zackCover:{
        zackCover = e;
      }break;
      case ContentsLabel.sleepBagCover:{
        sleepBagCover = e;
      }break;
      case ContentsLabel.helmet:{
        helmet = e;
      }break;
      case ContentsLabel.crampons:{
        crampons = e;
      }break;
      case ContentsLabel.iceAx:{
        iceAx = e;
      }break;
      case ContentsLabel.snack:{
        snack = e;
      }break;
      case ContentsLabel.mask:{
        mask = e;
      }break;
      case ContentsLabel.alMeter:{
        alMeter = e;
      }break;
      case ContentsLabel.tissue:{
        tissue = e;
      }break;
      case ContentsLabel.map:{
        map = e;
      }break;
      case ContentsLabel.winterClothes:{
        winterClothes = e;
      }break;
      case ContentsLabel.medicalCase:{
        medicalCase = e;
      }break;
      case ContentsLabel.towel:{
        towel = e;
      }break;
      case ContentsLabel.stick:{
        stick = e;
      }break;
      case ContentsLabel.knife:{
        knife = e;
      }break;
      case ContentsLabel.thermometer:{
        thermometer = e;
      }break;
      case ContentsLabel.changeClothes:{
        changeClothes = e;
      }break;
      case ContentsLabel.gloves:{
        gloves = e;
      }break;
      case ContentsLabel.workGloves:{
        workGloves = e;
      }break;
      case ContentsLabel.cap:{
        cap = e;
      }break;
      case ContentsLabel.rainSpats:{
        rainSpats = e;
      }break;
      case ContentsLabel.insects:{
        insects = e;
      }break;
      case ContentsLabel.copy:{
        copy = e;
      }break;
      case ContentsLabel.num1:{
        food = e;
      }break;
      case ContentsLabel.num2:{
        subFood = e;
      }break;
      case ContentsLabel.cal:{
        emergeFood = e;
      }break;
      case ContentsLabel.amount:{
        water = e;
      }break;
      case ContentsLabel.tent:{
        tent = e;
      }break;
      case ContentsLabel.hob:{
        hob = e;
      }break;
      case ContentsLabel.gas:{
        gas = e;
      }break;
      case ContentsLabel.subGas:{
        subGas = e;
      }break;
      case ContentsLabel.rope:{
        rope = e;
      }break;
      case ContentsLabel.celtic:{
        celtic = e;
      }break;
      case ContentsLabel.mat:{
        mat = e;
      }break;
      case ContentsLabel.cup:{
        cup = e;
      }break;
      case ContentsLabel.cook:{
        cook = e;
      }break;
    }
  }

  AllData({this.file,this.head,this.firstDate,this.belongs,this.groupName,this.represent,this.firstAddress1,
    this.firstAddress2,this.firstAddress3,this.firstAddress4, this.firstTel,this.emergeName,
    this.emergeTel,this.emergeAddress1,this.emergeAddress2,this.emergeAddress3,this.emergeAddress4,
    this.localPoint1,this.localPoint2,this.localPoint3,this.localTel1,this.localTel2,this.localTel3,
    this.id1Role,this.id1Name,this.id1NameH,this.id1Sex,this.id1Age,this.id1Birth,this.id1Blood,
    this.id1Address1,this.id1Address2,this.id1Address3, this.id1Address4,this.id1HouseTel,this.id1SelTel,
    this.id1EmergeName,this.id1EmergeTel,
    this.id2Role,this.id2Name,this.id2NameH,this.id2Sex,this.id2Age,this.id2Birth,this.id2Blood,
    this.id2Address1,this.id2Address2,this.id2Address3, this.id2Address4,this.id2HouseTel,this.id2SelTel,
    this.id2EmergeName,this.id2EmergeTel,
    this.id3Role,this.id3Name,this.id3NameH,this.id3Sex,this.id3Age,this.id3Birth,this.id3Blood,
    this.id3Address1,this.id3Address2,this.id3Address3, this.id3Address4,this.id3HouseTel,this.id3SelTel,
    this.id3EmergeName,this.id3EmergeTel,
    this.id4Role,this.id4Name,this.id4NameH,this.id4Sex,this.id4Age,this.id4Birth,this.id4Blood,
    this.id4Address1,this.id4Address2,this.id4Address3, this.id4Address4,this.id4HouseTel,this.id4SelTel,
    this.id4EmergeName,this.id4EmergeTel,
    this.id5Role,this.id5Name,this.id5NameH,this.id5Sex,this.id5Age,this.id5Birth,this.id5Blood,
    this.id5Address1,this.id5Address2,this.id5Address3, this.id5Address4,this.id5HouseTel,this.id5SelTel,
    this.id5EmergeName,this.id5EmergeTel,
    this.destination,this.method,this.start,this.sTime,this.finish,this.fTime,this.date1,this.date2,this.date3,this.date4,this.date5,this.date6,
    this.action1,this.action2,this.action3,this.action4,this.action5,this.action6,this.other1,
    this.zack = false,this.shoes=false,this.rainWear=false,this.sleepBag=false,this.headLmp=false,this.light=false,
    this.battery=false,this.compass=false,this.planDoc=false,this.selPhone=false,
    this.lighter=false,this.zackCover=false,this.sleepBagCover=false,this.helmet=false,this.crampons=false,this.iceAx=false,
    this.snack=false,this.mask=false,this.alMeter=false,this.tissue=false,
    this.map=false,this.winterClothes=false,this.medicalCase=false,this.towel=false,this.stick=false,this.knife=false,
    this.thermometer=false,this.changeClothes=false,this.gloves=false,
    this.workGloves=false,this.cap=false,this.rainSpats=false,this.insects=false,this.copy=false,this.food=false,this.num1,
    this.subFood=false,this.num2,this.emergeFood=false,
    this.cal,this.water=false,this.amount,this.perOther,
    this.tent=false,this.hob=false,this.gas=false,
    this.subGas=false,this.rope=false,this.celtic=false,this.mat=false,this.cup=false,this.cook=false,this.joinOther,
    this.id,this.date,this.path});
}

class ContentsLabel {
  static const String file = "ファイル名";

  static const String head = "宛先";
  static const String firstDate = "提出日";
  static const String belongs = "所属";
  static const String groupName = "団体名";
  static const String represent = "代表者氏名";
  static const String firstAddress1 = "都道府県（代表者住所）";
  static const String firstAddress2 = "市町村区（代表者住所）";
  static const String firstAddress3 = "番地（代表者住所）";
  static const String firstAddress4 = "その他（代表者住所）";
  static const String firstTel = "電話番号（代表者）";
  static const String emergeName = "緊急連絡先氏名";
  static const String emergeTel = "緊急連絡先電話番号";
  static const String emergeAddress1 = "都道府県（緊急連絡先住所）";
  static const String emergeAddress2 = "市町村区（緊急連絡先住所）";
  static const String emergeAddress3 = "番地（緊急連絡先住所）";
  static const String emergeAddress4 = "その他（緊急連絡先住所）";

  static const String localPoint1 = "施設１";
  static const String localTel1 = "電話番号（施設１）";
  static const String localPoint2 = "施設２";
  static const String localTel2 = "電話番号（施設２）";
  static const String localPoint3 = "施設３";
  static const String localTel3 = "電話番号（施設３）";

  static const String id1Role = "役割（メンバー１）";
  static const String id1Name = "氏名（メンバー１）";
  static const String id1NameH = "ふりがな（メンバー１）";
  static const String id1Sex = "性別（メンバー１）";
  static const String id1Age = "年齢（メンバー１）";
  static const String id1Birth = "生年月日（メンバー１）";
  static const String id1Blood = "血液型（メンバー１）";
  static const String id1Address1 = "都道府県（メンバー１住所）";
  static const String id1Address2 = "市町村区（メンバー１住所）";
  static const String id1Address3 = "番地（メンバー１住所）";
  static const String id1Address4 = "その他（メンバー１住所）";
  static const String id1HouseTel = "自宅電話番号（メンバー１）";
  static const String id1SelTel = "携帯電話番号（メンバー１）";
  static const String id1EmergeName = "緊急連絡先氏名（メンバー１）";
  static const String id1EmergeTel = "緊急連絡先電話番号（メンバー１）";

  static const String id2Role = "役割（メンバー２）";
  static const String id2Name = "氏名（メンバー２）";
  static const String id2NameH = "ふりがな（メンバー２）";
  static const String id2Sex = "性別（メンバー２）";
  static const String id2Age = "年齢（メンバー２）";
  static const String id2Birth = "生年月日（メンバー２）";
  static const String id2Blood = "血液型（メンバー２）";
  static const String id2Address1 = "都道府県（メンバー２住所）";
  static const String id2Address2 = "市町村区（メンバー２住所）";
  static const String id2Address3 = "番地（メンバー２住所）";
  static const String id2Address4 = "その他（メンバー２住所）";
  static const String id2HouseTel = "自宅電話番号（メンバー２）";
  static const String id2SelTel = "携帯電話（メンバー２）";
  static const String id2EmergeName = "緊急連絡先氏名（メンバー２）";
  static const String id2EmergeTel = "緊急連絡先電話番号（メンバー２）";

  static const String id3Role = "役割（メンバー３）";
  static const String id3Name = "氏名（メンバー３）";
  static const String id3NameH = "ふりがな（メンバー３）";
  static const String id3Sex = "性別（メンバー３）";
  static const String id3Age = "年齢（メンバー３）";
  static const String id3Birth = "生年月日（メンバー３）";
  static const String id3Blood = "血液型（メンバー３）";
  static const String id3Address1 = "都道府県（メンバー３住所）";
  static const String id3Address2 = "市町村区（メンバー３住所）";
  static const String id3Address3 = "番地（メンバー３住所）";
  static const String id3Address4 = "その他（メンバー３住所）";
  static const String id3HouseTel = "自宅電話番号（メンバー３）";
  static const String id3SelTel = "携帯電話番号（メンバー３）";
  static const String id3EmergeName = "緊急連絡先氏名（メンバー３）";
  static const String id3EmergeTel = "緊急連絡先電話番号（メンバー３）";

  static const String id4Role = "役割（メンバー４）";
  static const String id4Name = "氏名（メンバー４）";
  static const String id4NameH = "ふりがな（メンバー４）";
  static const String id4Sex = "性別（メンバー４）";
  static const String id4Age = "年齢（メンバー４）";
  static const String id4Birth = "生年月日（メンバー４）";
  static const String id4Blood = "血液型（メンバー４）";
  static const String id4Address1 = "都道府県（メンバー４住所）";
  static const String id4Address2 = "市町村区（メンバー４住所）";
  static const String id4Address3 = "番地（メンバー４住所）";
  static const String id4Address4 = "その他（メンバー住所）";
  static const String id4HouseTel = "自宅電話番号（メンバー４）";
  static const String id4SelTel = "携帯電話番号（メンバー４）";
  static const String id4EmergeName = "緊急連絡先氏名（メンバー４）";
  static const String id4EmergeTel = "緊急連絡先電話番号（メンバー４）";

  static const String id5Role = "役割（メンバー５）";
  static const String id5Name = "氏名（メンバー５）";
  static const String id5NameH = "ふりがな（メンバー５）";
  static const String id5Sex = "性別（メンバー５）";
  static const String id5Age = "年齢（メンバー５）";
  static const String id5Birth = "生年月日（メンバー５）";
  static const String id5Blood = "血液型（メンバー５）";
  static const String id5Address1 = "都道府県（メンバー５住所）";
  static const String id5Address2 = "市町村（メンバー５住所）";
  static const String id5Address3 = "番地（メンバー５住所）";
  static const String id5Address4 = "その他（メンバー５住所）";
  static const String id5HouseTel = "自宅電話番号（メンバー５）";
  static const String id5SelTel = "性別（メンバー５）";
  static const String id5EmergeName = "緊急連絡先氏名（メンバー５）";
  static const String id5EmergeTel = "緊急連絡先電話番号（メンバー５）";

  static const String destination = "山（域）名";
  static const String method = "登山方法";
//  static const String start = "登山開始日時";
//  static const String sTime = "下山予定日時";
//  static const String finish = "";
//  static const String fTime = "宛先";
//  static const String date1 = "";
//  static const String date2 = "宛先";
//  static const String date3 = "宛先";
//  static const String date4 = "宛先";
//  static const String date5 = "宛先";
//  static const String date6 = "宛先";
  static const String action1 = "予定１";
  static const String action2 = "予定２";
  static const String action3 = "予定３";
  static const String action4 = "予定４";
  static const String action5 = "予定５";
  static const String action6 = "予定６";
  static const String other1 = "エスケープルートその他";

  static const String zack = "ザック";
  static const String shoes = "靴";
  static const String rainWear = "雨具";
  static const String sleepBag = "シュラフ";
  static const String headLmp = "ヘッドランプ";
  static const String light = "懐中電灯";
  static const String battery = "予備電池";
  static const String compass = "コンパス";
  static const String planDoc = "計画書";
  static const String selPhone = "携帯電話";
  static const String lighter = "ライター";
  static const String zackCover = "ザックカバー";
  static const String sleepBagCover = "シュラフカバー";
  static const String helmet = "ヘルメット";
  static const String crampons = "アイゼン";
  static const String iceAx = "ピッケル";
  static const String snack = "行動食";
  static const String mask = "マスク";
  static const String alMeter = "高度計";
  static const String tissue = "ティッシュ";
  static const String map = "地図";
  static const String winterClothes = "防寒着";
  static const String medicalCase = "医療品";
  static const String towel = "タオル";
  static const String stick = "トレッキングポール";
  static const String knife = "ナイフ";
  static const String thermometer = "温度計";
  static const String changeClothes = "着替え";
  static const String gloves = "手袋";
  static const String workGloves = "軍手";
  static const String cap = "帽子";
  static const String rainSpats = "レインスパッツ";
  static const String insects = "虫除け";
  static const String copy = "保険証コピー";
  static const String num1 = "食糧";
//  static const String num1 = "食糧の量";
  static const String num2 = "予備食";
//  static const String num2 = "";
  static const String cal = "非常食";
//  static const String cal = "宛先";
  static const String amount = "水";
//  static const String amount = "宛先";
  static const String perOther = "その他個人装備";

  static const String tent = "テント";
  static const String hob = "コンロ";
  static const String gas = "ガス缶";
  static const String subGas = "ガス管予備";
  static const String rope = "ロープ";
  static const String celtic = "ツェルト";
  static const String mat = "マット";
  static const String cup = "コッヘル";
  static const String cook = "調理器具";
  static const String joinOther = "その他共同装備";

  static const Map<String,String> hintLabelMap = {
    file : "2021-1-1 〇〇登山",
    head : "〇〇市役所／警察署",
    belongs : "〇〇連盟／□□学校登山部",
    groupName : "〇〇チーム／△△隊",
    represent : "CLもしくは団体責任者の氏名",
    firstAddress1 : "〇〇県",
    firstAddress2 : "〇〇市□□",
    firstAddress3 : "〇-〇-〇",
    firstAddress4 : "マンション名など",
    firstTel :"00011112222",
    emergeName : "登山参加者以外",
    emergeTel : "99988887777",
    emergeAddress1 : "〇〇県",
    emergeAddress2 : "〇〇市□□",
    emergeAddress3 : "〇-〇-〇",
    emergeAddress4 : "マンション名など",

    localPoint1 : "〇〇ロッジ",
    localPoint2 : "00011113333",
    localPoint3 : "△△小屋",
    localTel1 : "99988887777",
    localTel2 : "□□の家",
    localTel3 : "66677778888",

    id1Role : "CL／SL／M1／気象／医療...",
    id1Name : "登山　太郎",
    id1NameH : "とざん　たろう",
    id1Age : "38",
    id1Blood : "A/B/..",
    id1Address1 : "〇〇県",
    id1Address2 : "〇〇市□□",
    id1Address3 : "〇-〇-〇",
    id1Address4 : "マンション名など",
    id1HouseTel : "66677778888",
    id1SelTel : "66677778888",
    id1EmergeName : "登山　花子",
    id1EmergeTel :  "66677778888",

    id2Role : "CL／SL／M1／気象／医療...",
    id2Name : "登山　太郎",
    id2NameH : "とざん　たろう",
    id2Age : "38",
    id2Blood : "A/B/..",
    id2Address1 : "〇〇県",
    id2Address2 : "〇〇市□□",
    id2Address3 : "〇-〇-〇",
    id2Address4 : "マンション名など",
    id2HouseTel : "66677778888",
    id2SelTel : "66677778888",
    id2EmergeName : "登山　花子",
    id2EmergeTel :  "66677778888",

    id3Role : "CL／SL／M1／気象／医療...",
    id3Name : "登山　太郎",
    id3NameH : "とざん　たろう",
    id3Age : "38",
    id3Blood : "A/B/..",
    id3Address1 : "〇〇県",
    id3Address2 : "〇〇市□□",
    id3Address3 : "〇-〇-〇",
    id3Address4 : "マンション名など",
    id3HouseTel : "66677778888",
    id3SelTel : "66677778888",
    id3EmergeName : "登山　花子",
    id3EmergeTel :  "66677778888",

    id4Role : "CL／SL／M1／気象／医療...",
    id4Name : "登山　太郎",
    id4NameH : "とざん　たろう",
    id4Age : "38",
    id4Blood : "A/B/..",
    id4Address1 : "〇〇県",
    id4Address2 : "〇〇市□□",
    id4Address3 : "〇-〇-〇",
    id4Address4 : "マンション名など",
    id4HouseTel : "66677778888",
    id4SelTel : "66677778888",
    id4EmergeName : "登山　花子",
    id4EmergeTel :  "66677778888",

    id5Role : "CL／SL／M1／気象／医療...",
    id5Name : "登山　太郎",
    id5NameH : "とざん　たろう",
    id5Age : "38",
    id5Blood : "A/B/..",
    id5Address1 : "〇〇県",
    id5Address2 : "〇〇市□□",
    id5Address3 : "〇-〇-〇",
    id5Address4 : "マンション名など",
    id5HouseTel : "66677778888",
    id5SelTel : "66677778888",
    id5EmergeName : "登山　花子",
    id5EmergeTel :  "66677778888",

    destination : "〇〇山／□□山域",
    method : "日帰り縦走／テント泊／...",
    action1 : "〇〇出発(9:00)=>〇〇峠休憩(12:00)=>〇〇ロッジ到着(5:00)",
    action2 : "〇〇出発(9:00)=>〇〇峠休憩(12:00)=>〇〇ロッジ到着(5:00)",
    action3 : "〇〇出発(9:00)=>〇〇峠休憩(12:00)=>〇〇ロッジ到着(5:00)",
    action4 : "〇〇出発(9:00)=>〇〇峠休憩(12:00)=>〇〇ロッジ到着(5:00)",
    action5 : "〇〇出発(9:00)=>〇〇峠休憩(12:00)=>〇〇ロッジ到着(5:00)",
    action6 : "〇〇出発(9:00)=>〇〇峠休憩(12:00)=>下山(5:00)",
    other1  : "雨天時：〇〇分岐で□□道にエスケープ＞下山",
    perOther : "個人マット／ゴーグル／...",
    joinOther : "食材／ペグ予備／...",

  };

  Map<String,TextEditingController> textFieldMap = {
    file : TextEditingController(),
    head : TextEditingController(),
    belongs : TextEditingController(),
    groupName : TextEditingController(),
    represent : TextEditingController(),
    firstAddress1 : TextEditingController(),
    firstAddress2 : TextEditingController(),
    firstAddress3 : TextEditingController(),
    firstAddress4 : TextEditingController(),
    firstTel : TextEditingController(),
    emergeName : TextEditingController(),
    emergeTel : TextEditingController(),
    emergeAddress1 : TextEditingController(),
    emergeAddress2 : TextEditingController(),
    emergeAddress3 : TextEditingController(),
    emergeAddress4 : TextEditingController(),

    localPoint1 : TextEditingController(),
    localPoint2 : TextEditingController(),
    localPoint3 : TextEditingController(),
    localTel1 : TextEditingController(),
    localTel2 : TextEditingController(),
    localTel3 : TextEditingController(),

    id1Role : TextEditingController(),
    id1Name : TextEditingController(),
    id1NameH : TextEditingController(),
    id1Age : TextEditingController(),
    id1Blood : TextEditingController(),
    id1Address1 : TextEditingController(),
    id1Address2 : TextEditingController(),
    id1Address3 : TextEditingController(),
    id1Address4 : TextEditingController(),
    id1HouseTel : TextEditingController(),
    id1SelTel : TextEditingController(),
    id1EmergeName : TextEditingController(),
    id1EmergeTel :  TextEditingController(),

    id2Role : TextEditingController(),
    id2Name : TextEditingController(),
    id2NameH : TextEditingController(),
    id2Age : TextEditingController(),
    id2Blood : TextEditingController(),
    id2Address1 : TextEditingController(),
    id2Address2 : TextEditingController(),
    id2Address3 : TextEditingController(),
    id2Address4 : TextEditingController(),
    id2HouseTel : TextEditingController(),
    id2SelTel : TextEditingController(),
    id2EmergeName : TextEditingController(),
    id2EmergeTel :  TextEditingController(),

    id3Role : TextEditingController(),
    id3Name : TextEditingController(),
    id3NameH : TextEditingController(),
    id3Age : TextEditingController(),
    id3Blood : TextEditingController(),
    id3Address1 : TextEditingController(),
    id3Address2 : TextEditingController(),
    id3Address3 : TextEditingController(),
    id3Address4 : TextEditingController(),
    id3HouseTel : TextEditingController(),
    id3SelTel : TextEditingController(),
    id3EmergeName : TextEditingController(),
    id3EmergeTel :  TextEditingController(),

    id4Role : TextEditingController(),
    id4Name : TextEditingController(),
    id4NameH : TextEditingController(),
    id4Age : TextEditingController(),
    id4Blood : TextEditingController(),
    id4Address1 : TextEditingController(),
    id4Address2 : TextEditingController(),
    id4Address3 : TextEditingController(),
    id4Address4 : TextEditingController(),
    id4HouseTel : TextEditingController(),
    id4SelTel : TextEditingController(),
    id4EmergeName : TextEditingController(),
    id4EmergeTel : TextEditingController(),

    id5Role : TextEditingController(),
    id5Name : TextEditingController(),
    id5NameH : TextEditingController(),
    id5Age : TextEditingController(),
    id5Blood : TextEditingController(),
    id5Address1 : TextEditingController(),
    id5Address2 : TextEditingController(),
    id5Address3 : TextEditingController(),
    id5Address4 : TextEditingController(),
    id5HouseTel : TextEditingController(),
    id5SelTel : TextEditingController(),
    id5EmergeName : TextEditingController(),
    id5EmergeTel :  TextEditingController(),

    destination : TextEditingController(),
    method : TextEditingController(),
    action1 : TextEditingController(),
    action2 : TextEditingController(),
    action3 : TextEditingController(),
    action4 : TextEditingController(),
    action5 : TextEditingController(),
    action6 : TextEditingController(),
    other1  : TextEditingController(),
    num1 : TextEditingController(),
    num2 :TextEditingController(),
    cal : TextEditingController(),
    perOther : TextEditingController(),
    joinOther : TextEditingController(),

  };
}



//enum Mochimono {
//  a
//  , b
//  , c
//  , towel
//}
//Mochimono mochimono = Mochimono.a;
//
//Map<Mochimono, TextEditingController> map = {
//  Mochimono.towel : TextEditingController(),
//  Mochimono.a : TextEditingController()
//};
//
//void test() {
//  if(mochimono == Mochimono.a) {
//    print('ok');
//  }
//  map.forEach((key, value) {
//    AllData.changeText(key, value.text);
//  });
//
//  /// case Mochimono.towel:
//}