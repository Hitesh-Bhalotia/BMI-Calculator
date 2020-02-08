import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'Icon_Content.dart';
import 'reusable_card.dart';
import 'constants.dart';
import 'results_page.dart';
import 'bottom_button.dart';
import 'round_icon_button.dart';
import 'package:bmi_calculator/calculator_brain.dart';

enum Gender { male, female }

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  Gender selectedGender;
  int height = 180;
  int weight = 50;
  int age = 18;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('BMI CALCULATOR'),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Expanded(
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: ReusableCard(
                          onPress: () {
                            setState(() {
                              selectedGender = Gender.male;
                            });
                          },
                          colour: selectedGender == Gender.male
                              ? kActiveCardColor
                              : kInactiveCardColor,
                          cardChild: IconContent('MALE', FontAwesomeIcons.mars),
                        )),
                    Expanded(
                        child: ReusableCard(
                            onPress: () {
                              setState(() {
                                selectedGender = Gender.female;
                              });
                            },
                            colour: selectedGender == Gender.female
                                ? kActiveCardColor
                                : kInactiveCardColor,
                            cardChild:
                            IconContent('FEMALE', FontAwesomeIcons.venus))),
                  ],
                )),
            Expanded(
              child: ReusableCard(
                colour: kInactiveCardColor,
                cardChild: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text('HEIGHT', style: kLabelTextStyle),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: <Widget>[
                        Text(
                          height.toString(),
                          style: kNumberTextStyle,
                        ),
                        SizedBox(
                          width: 5.0,
                        ),
                        Text(
                          'cm',
                          style: kLabelTextStyle,
                        )
                      ],
                    ),
                    SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        activeTrackColor: Color(0xFFFC5F37),
                        inactiveTrackColor: Colors.white,
                        thumbColor: Color(0xFFFC5F37),
                        thumbShape:
                        RoundSliderThumbShape(enabledThumbRadius: 15.0),
                        overlayShape:
                        RoundSliderOverlayShape(overlayRadius: 27.0),
                      ),
                      child: Slider(
                        value: height.toDouble(),
                        min: 120.0,
                        max: 220.0,
                        onChanged: (double newValue) {
                          setState(() {
                            height = newValue.round();
                          });
                        },
                      ),
                    )
                  ],
                ),
              ),
            ),
            Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Expanded(
                        child: ReusableCard(
                          colour: kInactiveCardColor,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text(
                                'WEIGHT',
                                style: kLabelTextStyle,
                              ),
                              SizedBox(
                                width: 5.0,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                textBaseline: TextBaseline.alphabetic,
                                crossAxisAlignment: CrossAxisAlignment.baseline,
                                children: <Widget>[
                                  Text(
                                    weight.toString(),
                                    style: kNumberTextStyle,
                                  ),
                                  Text(
                                    'kg',
                                    style: kLabelTextStyle,
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RoundIconButton(
                                    onPressed: () {
                                      setState(() {
                                        weight++;
                                      });
                                    },
                                    icon: FontAwesomeIcons.plus,
                                  ),
                                  SizedBox(width: 10.0),
                                  RoundIconButton(
                                    onPressed: () {
                                      setState(() {
                                        weight--;
                                      });
                                    },
                                    icon: FontAwesomeIcons.minus,
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                    Expanded(
                        child: ReusableCard(
                          colour: kInactiveCardColor,
                          cardChild: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Text('AGE', style: kLabelTextStyle),
                              Text(
                                age.toString(),
                                style: kNumberTextStyle,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  RoundIconButton(
                                    onPressed: () {
                                      setState(() {
                                        age++;
                                      });
                                    },
                                    icon: FontAwesomeIcons.plus,
                                  ),
                                  SizedBox(width: 10.0),
                                  RoundIconButton(
                                    onPressed: () {
                                      setState(() {
                                        age--;
                                      });
                                    },
                                    icon: FontAwesomeIcons.minus,
                                  )
                                ],
                              )
                            ],
                          ),
                        )),
                  ],
                )),
            BottomButton(
              buttonTitle: 'CALCULATE',
              onTap: () {
                CalculatorBrain calc = CalculatorBrain(height: height,weight: weight);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ResultsPage(
                      bmiResult: calc.calculateBMI(),
                      interpretation: calc.getInterpretation(),
                      resultText: calc.getResult(),
                    ),
                  ),
                );
              },
            )
          ],
        ));
  }
}