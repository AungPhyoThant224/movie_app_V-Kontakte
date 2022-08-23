import 'package:flutter/material.dart';
import 'package:movie/utils/providers.dart';
import 'package:provider/provider.dart';
import 'package:movie/utils/shared_preference.dart';
import 'package:movie/views/widgets/app_bar.dart';

class Settings extends StatefulWidget {

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  int radioValue = SharedPreference.getInt('theme') ?? 3;

  clickRadioButton(value) async{
    radioValue = value;
    await context.read<Providers>().setTheme(value);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: appBar(context, 'Settings'),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Theme',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  fontFamily: 'FiraSans',
                ),
              ),
              Container(
                padding: EdgeInsets.fromLTRB(0, 15, 0, 10),
                child: GestureDetector(
                  onTap: (){
                    clickRadioButton(1);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Light',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FiraSans',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Radio(
                              value: 1,
                              activeColor: Theme.of(context).primaryColor,
                              groupValue: radioValue,
                              onChanged: clickRadioButton,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: (){
                    clickRadioButton(2);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'Dark',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FiraSans',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Radio(
                              value: 2,
                              activeColor: Theme.of(context).primaryColor,
                              groupValue: radioValue,
                              onChanged: clickRadioButton,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 10),
                child: GestureDetector(
                  onTap: (){
                    clickRadioButton(3);
                  },
                  child: Row(
                    children: [
                      Expanded(
                        flex: 5,
                        child: Text(
                          'System Default',
                          style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'FiraSans',
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 1,
                        child: Container(
                          alignment: Alignment.centerRight,
                          child: SizedBox(
                            width: 20,
                            height: 20,
                            child: Radio(
                              value: 3,
                              activeColor: Theme.of(context).primaryColor,
                              groupValue: radioValue,
                              onChanged: clickRadioButton,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}