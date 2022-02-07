import 'package:flutter/material.dart';
import 'package:flutter_ios_calculator/models/button.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String display = '0';
  String previousNumber = '';
  String currentNumber = '';
  String selectedOperation = '';

  String _formatDisplayNumber(String val) {
    var formatter = NumberFormat('###,###.##', 'en_US');

    return formatter.format(parseStringToDouble(val));
  }

  void _dragToDelete() {
    setState(() {
      currentNumber = currentNumber.substring(0, currentNumber.length - 1);
      display = currentNumber;
    });
  }

  void _handleReset() {
    display = '0';
    previousNumber = '';
    currentNumber = '';
    selectedOperation = '';
  }

  void _handleReverseNumSign() {
    currentNumber = parseStringToDouble(currentNumber) < 0
        ? currentNumber.replaceAll('-', '')
        : '-$currentNumber';
    display = currentNumber;
  }

  void _handlePercentage() {
    currentNumber = (parseStringToDouble(currentNumber) / 100).toString();
    display = currentNumber;
  }

  double parseStringToDouble(String val) {
    return double.tryParse(val) ?? 0;
  }

  void _calculate() {
    double _prev = parseStringToDouble(previousNumber);
    double _curr = parseStringToDouble(currentNumber);

    switch (selectedOperation) {
      case '÷':
        _prev = _prev / _curr;
        break;
      case '×':
        _prev = _prev * _curr;
        break;
      case '−':
        _prev = _prev - _curr;
        break;
      case '+':
        _prev = _prev + _curr;
        break;
    }

    currentNumber = (_prev % 1 == 0 ? _prev.toInt() : _prev).toString();
    selectedOperation = '';
    display = currentNumber;
  }

  void _onButtonPressed(String btnText) {
    setState(() {
      switch (btnText) {
        case 'C':
          _handleReset();
          break;
        case '⁺∕₋':
          _handleReverseNumSign();
          break;
        case '%':
          _handlePercentage();
          break;
        case '÷':
        case '×':
        case '−':
        case '+':
          selectedOperation = btnText;
          previousNumber = currentNumber;
          currentNumber = '';
          break;
        case '=':
          _calculate();
          break;
        case '.':
          if (!currentNumber.contains('.')) {
            currentNumber = currentNumber + btnText;
            display = currentNumber;
          }
          break;
        default:
          currentNumber = currentNumber + btnText;
          display = currentNumber;
      }
    });
  }

  Widget _buildButtonsGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      children: buttons.map((e) {
        return StaggeredGridTile.count(
          mainAxisCellCount: 1,
          crossAxisCellCount: e.value == '0' ? 2 : 1,
          child: MaterialButton(
            onPressed: () {
              _onButtonPressed(e.value);
            },
            padding: e.value == '0'
                ? const EdgeInsets.only(right: 100)
                : EdgeInsets.zero,
            color: e.value == selectedOperation
                ? e.foregroundColor
                : e.backgroundColor,
            textColor: e.value == selectedOperation
                ? e.backgroundColor
                : e.foregroundColor,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(60))),
            child: Text(
              e.value,
              style: const TextStyle(fontSize: 32),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              GestureDetector(
                onHorizontalDragEnd: (details) => _dragToDelete(),
                child: Text(
                  _formatDisplayNumber(display),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize:
                          display.length > 5 ? 100 - display.length * 4 : 80,
                      fontWeight: FontWeight.w200),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 50, top: 12),
                child: Container(
                  child: _buildButtonsGrid(),
                ),
              )
            ],
          ),
        ));
  }
}
