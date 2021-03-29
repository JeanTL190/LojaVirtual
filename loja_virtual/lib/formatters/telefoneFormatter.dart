import 'package:flutter/services.dart';

class TelefoneTextInputFormatter extends TextInputFormatter {
  // (##)####-####
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final int newTextLength = newValue.text.length;
    int selectionIndex = newValue.selection.end;
    int usedSubstringIndex = 0;
    final StringBuffer newText = StringBuffer();
    newText.clear();
    if (newTextLength >= 1) {
      newText.write('(');
      if (newValue.selection.end >= 1) selectionIndex++;
    }
    if (newTextLength >= 3) {
      newText.write(newValue.text.substring(0, usedSubstringIndex = 2) + ') ');
      if (newValue.selection.end >= 3) selectionIndex += 2;
    }
    if (newTextLength >= 7) {
      if (newTextLength == 10) {
        newText.write(newValue.text.substring(2, usedSubstringIndex = 6) + '-');
        if (newValue.selection.end >= 6) selectionIndex++;
      } else if (newTextLength == 11) {
        newText.write(newValue.text.substring(2, usedSubstringIndex = 7) + '-');
        if (newValue.selection.end >= 7) selectionIndex++;
      }
    }
    // Dump the rest.
    if (newTextLength >= usedSubstringIndex)
      newText.write(newValue.text.substring(usedSubstringIndex));
    return TextEditingValue(
      text: newText.toString(),
      selection: TextSelection.collapsed(offset: selectionIndex),
    );
  }
}
