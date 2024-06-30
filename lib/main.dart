import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Currency Converter',
      theme: ThemeData(
        primarySwatch: Colors.brown,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.white,
        ),
      ),
      home: InputPage(),
    );
  }
}

class InputPage extends StatefulWidget {
  @override
  _InputPageState createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {
  TextEditingController _controller = TextEditingController();
  late int _inputValue;
  final double conversionRate = 15500;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
        title: Row(
          children: [
            SizedBox(width:10),
            Text('Currency Converter'),
          ],
        ),
      ),

      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money, 
                    color: Colors.white,
                    size: 38.0, 
                  ),
                  Text('USD from IDR', style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                    ),),
                ],
              ),
            ),
           
              Container(
              margin: EdgeInsets.all(0),
              height: 500,
              width:700,
              decoration: BoxDecoration (
                color: Colors.white,
                borderRadius: BorderRadius.circular(30),
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    
                      Container(
                      child: Column(
                        children: [
                          Text('IDR', style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold
                           ,color: Colors.brown
                            ),),
                          Text('Indonesian Rupiah',style: TextStyle(
                            color: Colors.brown
                          ),),
                          SizedBox(height: 0),
                        ],
                      ),
                    ),
            
            
            Container(
              margin: EdgeInsets.all(20),
              height: 300,
              width:600,
              decoration: BoxDecoration (
                color: Colors.white,
                borderRadius: BorderRadius.circular(0),
              ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Container(
                      width: 900,
                      height: 200,
                      margin: EdgeInsets.all(0),
                      child: Image.network(
                          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRgViZG843ap3UTS4ZRPGDlePTylZoN8qxjxhA_OWIZDQrXU2x8EDu7Lq2sBDm6NN1FVs&usqp=CAU'),
                    ),
                  
                    TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Input Nominal (Rp)',
                        border: OutlineInputBorder()
                        ),
                    ),
                    SizedBox(height:20),
                    ElevatedButton(
                      onPressed: () {
                        _convertCurrency();
                      },
                      child: Text('Convert to USD', style: TextStyle(
                      color: Colors.white
                      ),),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    ]
        )
      )
    );
  }

void _convertCurrency() {
  String inputValue = _controller.text;
  try {
    _inputValue = int.parse(inputValue);

    switch (_inputValue) {
      case <0:
        _showErrorDialog('$_inputValue Does Not Match');
        break;
      case var value when value < 15500:
        _showErrorDialog('Rp$_inputValue Less than Rp15500, Can Not Converted');
        break;
      default:
        _navigateToResultPage();
        break;
    }
  } catch (e) {
    _showErrorDialog('$inputValue does not match, input the Rp nominal');
  }
}

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error!'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void _navigateToResultPage() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ResultPage(inputValue: _inputValue, conversionRate: conversionRate),
      ),
    );
  }
}

class ResultPage extends StatelessWidget {
  final int inputValue;
  final double conversionRate;

  ResultPage({required this.inputValue, required this.conversionRate});
  @override
  Widget build(BuildContext context) {
    int result = (inputValue / conversionRate).round();
    return Scaffold(
      backgroundColor: Colors.brown[300],
      appBar: AppBar(
                title: Row(
                  children: [
                    Text('Conversion Result'),
                  ],
                ),
              ),
      body: Center(
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              padding: EdgeInsets.all(20),
              child: Row(
                children: [
                  Icon(
                    Icons.attach_money, 
                    color: Colors.white,
                    size: 38.0, 
                  ),
                  Text('USD from IDR', style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                    ),),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(70),
                  height: 400,
                  width: 500,
                  decoration: BoxDecoration (
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                  ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      margin: EdgeInsets.only(top: 5),
                      padding: EdgeInsets.all(10),
                      child: Column(
                        children: [
                          Text('USD', style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold, color: Colors.brown)),
                          Text('United State Dollar', style: TextStyle(
                            color: Colors.brown[300]
                          ),),
                        ],
                      ),
                    ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    padding: EdgeInsets.all(50),
                    decoration: BoxDecoration (
                      color: Colors.brown[200],
                      border: Border.all(
                        color: Colors.brown,
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        const Text(
                          'Input Nominal (Rp)',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.brown
                            ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom : 25),
                    width: 200,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.brown, width: 1)),
                    child: Center(
                      child: Text('Rp${inputValue}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black)),
                    ),
                  ),
                  
                  
                  const Text(
                    'Convert Result (USD)',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 15,
                      color: Colors.brown
                      
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.all(0),
                    width: 200,
                    height: 35,
                    decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.all(Radius.circular(5)),
                        border: Border.all(color: Colors.brown, width: 1)),
                    child: Center(
                      child: Text('USD${result}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.black)),
                    ),
                  ),
                      ],
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Back', style: TextStyle(
                      color: Colors.white
                    ),),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
