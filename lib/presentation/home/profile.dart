import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muniafu_hotel/presentation/home/widgets/text_widget.dart';
import 'package:provider/provider.dart';
import 'package:muniafu_hotel/providers/auth.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:muniafu_hotel/domain/models/user.dart';
import '../../data/dummy_user.dart';
import '../../domain/services/admin.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  
  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context, listen: true);
    final UserModel? user = authProvider.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // User Greeting
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'Hi,  ',
                          style: const TextStyle(
                            color: Colors.cyan,
                            fontSize: 27,
                            fontWeight: FontWeight.bold,
                          ),
                          children: <TextSpan>[
                            TextSpan(
                              text: user!.displayName,
                              style: const TextStyle(
                                color: Colors.cyan,
                                fontSize: 25,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()..onTap = () {
                                if (kDebugMode) {
                                  print('Display name tapped');
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 5),
                      TextWidget(
                        text: user.email,
                        color: Colors.cyan,
                        textSize: 18,
                      ),
                      const Divider(thickness: 2),
                      const SizedBox(height: 20),

                      // Profile Options
                      _listTiles(
                        title: 'Address 2',
                        subtitle: 'My subtitle',
                        icon: IconlyLight.profile,
                        onPressed: () {
                          AdminService().setAdmin(dummyUser);
                        },
                        color: Colors.cyan,
                      ),
                      _listTiles(
                        title: 'Bookings',
                        icon: IconlyLight.bag,
                        onPressed: () {},
                        color: Colors.cyan,
                      ),
                      _listTiles(
                        title: 'Viewed',
                        icon: IconlyLight.show,
                        onPressed: () {},
                        color: Colors.cyan,
                      ),
                      _listTiles(
                        title: 'Change Password',
                        icon: IconlyLight.unlock,
                        onPressed: () {},
                        color: Colors.cyan,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          // Logout Button at the Bottom
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  authProvider.signOut(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16.0), backgroundColor: Colors.redAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                ),
                child: const Text(
                  'Logout',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // Custom list tiles with ripple effects
  Widget _listTiles({
    required String title,
    String? subtitle,
    required IconData icon,
    required Function onPressed,
    required Color color,
  }) {
    return InkWell(
      onTap: () {
        onPressed();
      },
      splashColor: Colors.cyan.withOpacity(0.2),
      child: ListTile(
        title: TextWidget(
          text: title,
          color: color,
          textSize: 22,
        ),
        subtitle: subtitle != null
            ? TextWidget(
                text: subtitle,
                color: color.withOpacity(0.7),
                textSize: 18,
              )
            : null,
        leading: Icon(icon, color: color),
        trailing: const Icon(IconlyLight.arrowRight2, color: Colors.cyan),
      ),
    );
  }
}