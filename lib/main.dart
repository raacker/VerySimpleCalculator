import "package:flutter/material.dart";

void main() => runApp(createApp());

MaterialApp createApp() {
  return MaterialApp(
    debugShowCheckedModeBanner: false,
    title: "Interest calculator",
    theme: ThemeData(
      primaryColor: Colors.indigoAccent,
      buttonColor: Colors.blue,
      brightness: Brightness.dark,
    ),
    home: Scaffold(
      appBar: AppBar(
        title: Text("Interest Calculator"),
      ),
      resizeToAvoidBottomPadding: true,
      body: InputForm(),
    ),
  );
}

Widget moneyImageAsset() {
  return Center(
      child: Container(
        margin: EdgeInsets.all(50.0),
        width: 128,
        height: 128,
        child: Image(
          image: ExactAssetImage("images/money-icon.png", scale: 1),
        ),
      ),
  );
}

class InputForm extends StatefulWidget {
  @override
  State<InputForm> createState() {
    return _InputFormState();
  }
}

class _InputFormState extends State<InputForm>{
  var _formKey = GlobalKey<FormState>();

  final double _minimumPadding = 5.0;
  List<String> _currencies = [
    "Won", "Dollar", "Euro",
  ];
  final int _defaultIndex = 0;
  String _currentlySelectedItem;

  _InputFormState() {
    this._currentlySelectedItem = _currencies[_defaultIndex];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController rateController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = "";

  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: EdgeInsets.all(5.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              moneyImageAsset(),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  controller: principalController,
                  keyboardType: TextInputType.text,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Principal value";
                    }
                    if (double.tryParse(value) == null) {
                      return "Only number is allowed";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Principal",
                    hintText: "Enter Principal e.g. 12000",
                    errorStyle: TextStyle(
                      color: Colors.yellow,
                      fontSize: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: TextFormField(
                  controller: rateController,
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value.isEmpty) {
                      return "Please enter Principal value";
                    }
                    if (double.tryParse(value) == null) {
                      return "Only number is allowed";
                    }
                  },
                  decoration: InputDecoration(
                    labelText: "Rate of Interest",
                    hintText: "Enter interest as percentage",
                    errorStyle: TextStyle(
                      color: Colors.yellow,
                      fontSize: 15.0,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: _minimumPadding),
                        child: TextFormField(
                          controller: termController,
                          keyboardType: TextInputType.number,
                          validator: (value) {
                            if (value.isEmpty) {
                              return "Please enter Principal value";
                            }
                            if (double.tryParse(value) == null) {
                              return "Only number is allowed";
                            }
                          },
                          decoration: InputDecoration(
                            labelText: "Term ",
                            hintText: "How many years to calculate",
                            errorStyle: TextStyle(
                              color: Colors.yellow,
                              fontSize: 15.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: _minimumPadding),
                        child: DropdownButton<String>(
                          items: _currencies.map((string) => DropdownMenuItem<String>(
                            value: string,
                            child: Text(string),
                          )).toList(),
                          value: _currentlySelectedItem,
                          onChanged: (value) {
                            setState(() => this._currentlySelectedItem = value);
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        child: Text("Calculate"),
                        onPressed: () {
                          setState(() {
                            if (_formKey.currentState.validate()) {
                              this.displayResult = onCalculation();
                            }
                          });
                        },
                      ),
                    ),
                    Expanded(
                      child: RaisedButton(
                        child: Text("Reset"),
                        onPressed: () {
                          setState(() => this.displayResult = "");
                        },
                      ),
                    ),
                  ],
                )
              ),
              Padding(
                padding: EdgeInsets.only(top: _minimumPadding, bottom: _minimumPadding),
                child: Text(this.displayResult),
              ),
            ],
          ),
        ),
      );
  }

  String onCalculation() {
    if (principalController.text == null) {
      return "";
    }
    double principal = double.parse(principalController.text);
    double rate = double.parse(rateController.text);
    double term = double.parse(termController.text);

    double totalAmountPayable = principal + (principal * rate * term) / 100;

    return "After $term years, your investment will be worth $totalAmountPayable";
  }
}