import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:spotify_app/common/appbar/app_bar.dart';
import 'package:spotify_app/common/helpers/is_dark_mode.dart';
import 'package:spotify_app/common/widgets/button/basic_app_button.dart';
import 'package:spotify_app/core/configs/assets/app_images.dart';
import 'package:spotify_app/core/configs/assets/app_vectors.dart';
import 'package:spotify_app/core/configs/theme/app_colors.dart';
import 'package:spotify_app/presentation/auth/pages/register.dart';
import 'package:spotify_app/presentation/auth/pages/signin.dart';

class RegisterOrSignin extends StatelessWidget {
  const RegisterOrSignin({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BasicAppbar(),
          Positioned(
            bottom: 0,
            left: 0,
            right: 60,
            top: 420,
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(image: AssetImage(AppImages.authBG))),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 100),
            child: Column(
              children: [
                const Spacer(),
                Center(child: SvgPicture.asset(AppVectors.logo)),
                const SizedBox(
                  height: 55,
                ),
                Text(
                  'Enjoy Listening To Music',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: context.isDarkMode ? Colors.white : Colors.black,
                      fontSize: 21),
                ),
                const SizedBox(
                  height: 21,
                ),
                const Text(
                  'Spotify is a proprietary Swedish audio streaming and media services provider',
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color: AppColors.grey,
                      fontSize: 19),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: Row(
                    children: [
                      SizedBox(
                        height: 80,
                        width: 160,
                        child: BasicAppButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (BuildContext context) =>
                                           Register()));
                            },
                            title: 'Register'),
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) =>  Register()),
                          );
                        },
                        child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Signin()));
                          },
                          child: Text(
                            'Sign in',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: context.isDarkMode
                                    ? Colors.white
                                    : Colors.black,
                                fontSize: 21),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const Spacer(),
              ],
            ),
          ),
          Align(
              alignment: Alignment.topRight,
              child: SvgPicture.asset(AppVectors.topPattern)),
          Align(
              alignment: Alignment.bottomRight,
              child: SvgPicture.asset(AppVectors.buttomPattern)),
        ],
      ),
    );
  }
}
