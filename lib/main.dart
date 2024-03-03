import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Home> {
  double? bmi;
  int? age = 0;
  double? height = 0;
  double? weight = 0;
  bool genderMale = true;
  String? img = "";
  String imagee(double bmi) {
    if (bmi < 18.5) {
      img = "assets/images/now.png";
    } else if (bmi >= 18.5 && bmi < 25) {
      img = "assets/images/fit.png";
    } else {
      img = "assets/images/fat.png";
    }

    return img!;
  }

  double calculateBMI(bool genderMale, int age, double height, double weight) {
    double cmHei = height / 100;
    double bmiT = weight / (cmHei * cmHei);

    if (!genderMale) {
      bmiT += 1.5;
      bmiT -= (age > 30) ? ((age - 30) / 5) : 0;
    } else {
      bmiT += (age > 30) ? ((age - 30) / 5) : 0;
    }

    bmi = bmiT;

    return bmiT < 100 ? bmiT : 100;
  }

  bool canAffic = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [
        TextField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Enter your age",
            errorMaxLines: 2,
          ),
          onChanged: (value) {
            setState(() {
              age = double.parse(value).toInt();
            });
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Enter your height",
            suffixText: "cm",
          ),
          onChanged: (value) {
            height = double.parse(value);
            print(height);
            setState(() {});
          },
        ),
        TextField(
          keyboardType: TextInputType.number,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            suffixText: "kg",
            floatingLabelBehavior: FloatingLabelBehavior.never,
            labelText: "Enter your weight",
          ),
          onChanged: (value) {
            setState(() {
              weight = double.parse(value);
              print(weight);
            });
          },
        ),
        const SizedBox(height: 45),
        Padding(
          padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
          child: TextButton.icon(
              style: ButtonStyle(
                  fixedSize: const MaterialStatePropertyAll(Size(50, 50)),
                  textStyle:
                      MaterialStateProperty.all(const TextStyle(fontSize: 17)),
                  backgroundColor: MaterialStateProperty.all(Colors.red),
                  foregroundColor: MaterialStateProperty.all(Colors.white)),
              onPressed: () {
                setState(() {
                  canAffic = true;
                  print(age);
                  print(height);
                  print(weight);

                  print(canAffic);

                  var bmo = calculateBMI(genderMale, age!, height!, weight!);

                  print(bmo);
                  img = imagee(bmo);
                  print(img);
                });
              },
              icon: const Icon(Icons.calculate),
              label: const Text("Calculate")),
        ),
        const SizedBox(height: 20),
        if (canAffic == true)
          Container(height: 100, width: 100, child: Image.asset(img!))
        else
          SizedBox()
      ]),
    );
  }
}
