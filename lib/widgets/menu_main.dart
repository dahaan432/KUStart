import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MenuMain extends StatefulWidget {
  const MenuMain({Key? key}) : super(key: key);

  @override
  State<MenuMain> createState() => _MenuMainState();
}

class _MenuMainState extends State<MenuMain> {
  late Color buttonColor1;
  late Color buttonColor2;
  late Color buttonColor3;
  late bool isFirstRun; // 첫 실행 여부를 저장하기 위한 변수

  @override
  void initState() {
    super.initState();
    loadButtonColors();
  }

  void loadButtonColors() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      // SharedPreferences에서 저장된 값을 불러옵니다. 없을 경우 기본값을 설정합니다.
      buttonColor1 = prefs.getBool('buttonColor1') == true
          ? const Color(0xFF7B2D35)
          : Colors.transparent;
      buttonColor2 = prefs.getBool('buttonColor2') == true
          ? const Color(0xFF7B2D35)
          : Colors.transparent;
      buttonColor3 = prefs.getBool('buttonColor3') == true
          ? const Color(0xFF7B2D35)
          : Colors.transparent;

      isFirstRun = prefs.getBool('isFirstRun') ?? true; // 첫 실행 여부를 가져옵니다.
    });

    if (isFirstRun) {
      // 첫 실행인 경우 Corner 1 버튼을 선택합니다.
      saveButtonColor(1);
    }
  }

  void saveButtonColor(int buttonNumber) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      buttonColor1 = buttonNumber == 1 ? const Color(0xFF7B2D35) : Colors.transparent;
      buttonColor2 = buttonNumber == 2 ? const Color(0xFF7B2D35) : Colors.transparent;
      buttonColor3 = buttonNumber == 3 ? const Color(0xFF7B2D35) : Colors.transparent;

      // 선택한 버튼의 정보를 SharedPreferences에 저장합니다.
      prefs.setBool('buttonColor1', buttonNumber == 1);
      prefs.setBool('buttonColor2', buttonNumber == 2);
      prefs.setBool('buttonColor3', buttonNumber == 3);

      // 첫 실행 여부를 false로 업데이트합니다.
      prefs.setBool('isFirstRun', false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 420,
      decoration: ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        shadows: const [
          BoxShadow(
            color: Color(0x3F000000),
            blurRadius: 4,
            offset: Offset(0, 0),
            spreadRadius: 1,
          )
        ],
      ),
      child: Column(
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(16, 11, 0, 10),
                child: Text(
                  '2023.9.3 (일)',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontFamily: 'Ubuntu',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              buildCornerButton('Corner 1', buttonColor1, 1),
              buildVerticalDivider(),
              buildCornerButton('Corner 2', buttonColor2, 2),
              buildVerticalDivider(),
              buildCornerButton('Corner 3', buttonColor3, 3),
            ],
          )
        ],
      ),
    );
  }

  Widget buildCornerButton(String label, Color buttonColor, int buttonNumber) {
    return GestureDetector(
      onTap: () {
        saveButtonColor(buttonNumber);
      },
      child: Container(
        width: 105,
        height: 35,
        decoration: ShapeDecoration(
          color: buttonColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Center(
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: buttonColor == Colors.transparent
                  ? const Color(0xFF000000)
                  : const Color(0xFFFFFFFF),
              fontSize: 15,
              fontFamily: 'Ubuntu',
              fontWeight: FontWeight.w400,
              height: 0,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildVerticalDivider() {
    return Container(
      height: 25,
      width: 0.50,
      color: Colors.black,
    );
  }
}