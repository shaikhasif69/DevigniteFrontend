import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyBottomNavigationBar extends StatefulWidget {
  final List<Widget> children;
  final int currentIndex;
  final ValueChanged<int> onTap;

  const MyBottomNavigationBar({
    Key? key,
    required this.children,
    required this.currentIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  State<MyBottomNavigationBar> createState() => _MyBottomNavigationBarState();
}

class _MyBottomNavigationBarState extends State<MyBottomNavigationBar> {
  int _selectedIndex = 0; // Track current index internally

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.currentIndex;
  }

  @override
  void dispose() {
    // Remove volume button listener when the widget is disposed
    // _removeVolumeButtonListener();
    super.dispose();
  }

  void _handleVolumeButtonPress(KeyEvent event) {
    if (event.runtimeType == KeyDownEvent) {
      switch (event.physicalKey) {
        case PhysicalKeyboardKey.audioVolumeDown:
          setState(() {
            _selectedIndex = (_selectedIndex - 1) % widget.children.length;
          });
          widget.onTap(_selectedIndex);
          break;
        case PhysicalKeyboardKey.audioVolumeUp:
          setState(() {
            _selectedIndex = (_selectedIndex + 1) % widget.children.length;
          });
          widget.onTap(_selectedIndex);
          break;
        default:
          break;
      }
    }
  }

 void _addVolumeButtonListener() {
  // Add listener for volume button presses
  WidgetsBinding.instance.addPostFrameCallback((_) {
    HardwareKeyboard.instance.addHandler(( event) {
      // ... handle volume button presses here ...
      print("hello there m i visible ? ");
      return false; // Return false to prevent event propagation
    });
  });
}

  // void _removeVolumeButtonListener() {
  //   // Remove listener to avoid memory leaks
  //   HardwareKeyboard.instance.removeHandler(_handleVolumeButtonPress);
  // }

  @override
  Widget build(BuildContext context) {
    // Add volume button listener on build
    _addVolumeButtonListener();

    return BottomNavigationBar(
      items: widget.children
          .map((Widget item) => BottomNavigationBarItem(
                icon: item,
                label:
                    '', // Remove labels as they are not read by screen readers
              ))
          .toList(),
      currentIndex: _selectedIndex,
      onTap: (index) {
        print("what m i visible ? ");
        setState(() {
          _selectedIndex = index;
        });
        widget.onTap(index);
      },
      type: BottomNavigationBarType.fixed,
      unselectedItemColor: Colors.grey,
      selectedItemColor: Theme.of(context).primaryColor,
    );
  }
}
