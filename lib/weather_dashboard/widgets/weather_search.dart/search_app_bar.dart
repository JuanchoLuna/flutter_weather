import 'package:flutter/material.dart';

class WeatherSearchAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  const WeatherSearchAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(
        bottomLeft: Radius.circular(24),
        bottomRight: Radius.circular(24),
      ),
      child: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black38,
        elevation: 4,
        title: const Row(
          children: [
            Text(
              'Flutter Weather',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(60);
}
