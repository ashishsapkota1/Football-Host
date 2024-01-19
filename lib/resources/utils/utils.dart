import 'package:fluttertoast/fluttertoast.dart';
import 'package:football_host/resources/app_colors.dart';

class Utils{
  static toastMessage(String msg){
    Fluttertoast.showToast(msg: msg,
    backgroundColor: AppColor.appBarColor,
    textColor: AppColor.backGroundColor
    );
  }

}