import 'package:flutter/material.dart';
import 'package:simple_calc/repository/repository_operations.dart';

class OperationController extends ChangeNotifier {
  bool _flagError = false;

  bool verifyError() {
    if (_flagError) {
      _flagError = false;  
      return true;
    } else {
      return false;
    }
  }
  String getResult(String input) {
    
    final regex = RegExp(r'(?<!\d)-?\d+(?:\.\d+)?|[+\-x/]');

    final numOp = regex
      .allMatches(input)
      .map((match) => match.group(0)!)
      .toList();

    if (numOp.isEmpty) {
      _flagError = true;
      return 'error';
    }

    final lastToken = numOp.last;
    final firstToken = numOp.first;

    if (['+', '-', 'x', '/'].contains(lastToken)) {
      _flagError = true;
      return 'error';
    }
    if (['x', '/'].contains(firstToken)) {
      _flagError = true;
      return 'error';
    }

    num result = 0; 
    try {
      for (int i = 0; i < numOp.length; i++) {
        if (numOp[i] == 'x') {
          if (i > 0 && i < numOp.length - 1) {
            if (num.tryParse(numOp[i - 1]) == null || num.tryParse(numOp[i + 1]) == null) {
              _flagError = true;
              return 'error';
            } else {
              num esq = num.parse(numOp[i - 1]);
              num dir = num.parse(numOp[i + 1]);
              result = esq * dir;
              numOp[i] = '_';
              numOp[i - 1] = '_';
              numOp[i + 1] = result.toString();
            }
          }
        } else if (numOp[i] == '/') {
          if (i > 0 && i < numOp.length - 1) {
            if (num.tryParse(numOp[i - 1]) == null || num.tryParse(numOp[i + 1]) == null) {
              _flagError = true;
              return 'error';
            } else {
              num esq = num.parse(numOp[i - 1]);
              num dir = num.parse(numOp[i + 1]);
              if (dir == 0) {
                _flagError = true;
                return 'error';
              }
              result = esq / dir;
              numOp[i] = '_';
              numOp[i - 1] = '_';
              numOp[i + 1] = result.toString();
            }
          }
        }
        result = 0;
      }
      numOp.removeWhere((x) => x == '_');

      for (int i = 0; i < numOp.length; i++) {
        if (numOp[i] == '+') {
          if (i > 0 && i < numOp.length - 1) {
            if (num.tryParse(numOp[i - 1]) == null || num.tryParse(numOp[i + 1]) == null) {
              _flagError = true;
              return 'error';
            } else {
              num esq = num.parse(numOp[i - 1]);
              num dir = num.parse(numOp[i + 1]);
              result = esq + dir;
              numOp[i] = '_';
              numOp[i - 1] = '_';
              numOp[i + 1] = result.toString();
            }
          }
        } else if (numOp[i] == '-') {
          if (i > 0 && i < numOp.length - 1) {
            if (num.tryParse(numOp[i - 1]) == null || num.tryParse(numOp[i + 1]) == null) {
              _flagError = true;
              return 'error';
            } else {
              num esq = num.parse(numOp[i - 1]);
              num dir = num.parse(numOp[i + 1]);
              result = esq - dir;
              numOp[i] = '_';
              numOp[i - 1] = '_';
              numOp[i + 1] = result.toString();
            }
          }
        }
      }
    } catch (e) {
      _flagError = true;
      return 'error by catch';
    }

    
    RepositoryOperations.putOnBox(input, num.parse(numOp.last));

    if(int.tryParse(numOp.last) != null) {
      return int.parse(numOp.last).toString();
    } else {
      return double.parse(numOp.last).toStringAsFixed(2);
    }
  }
}