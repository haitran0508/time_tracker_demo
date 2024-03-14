import 'package:flutter/material.dart';

class RoundedButton extends ElevatedButton {
  RoundedButton({
    Key? key,
    VoidCallback? onPressed,
    Size? size,
    required String label,
    required Color color,
  }) : super(
          key: key,
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.resolveWith<Color?>(
                (Set<MaterialState> states) {
                  if (states.contains(MaterialState.disabled)) {
                    return Colors.black.withOpacity(0.2);
                  }
                  return color;
                },
              ),
              fixedSize: (size != null) ? MaterialStateProperty.all<Size>(size) : null,
              minimumSize: (size == null) ? MaterialStateProperty.all<Size>(Size.infinite) : null,
              elevation: MaterialStateProperty.all<double>(0),
              shape: MaterialStateProperty.all<OutlinedBorder>(
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              alignment: Alignment.center),
          child: Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
        );
}
