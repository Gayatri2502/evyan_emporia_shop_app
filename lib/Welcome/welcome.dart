import 'package:evyan_emporia_shop_app/Authentication/loginscreen.dart';
import 'package:flutter/material.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage>
    with SingleTickerProviderStateMixin {
  AnimationController? _animationController;
  Animation<double>? _animation;

  void navigateToLoginPage() {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (_, __, ___) => LoginPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          var begin = 0.0;
          var end = 1.0;
          var curve = Curves.easeInCubic;
          var fadeDuration = Duration(milliseconds: 800);

          var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

          return FadeTransition(
            opacity: Tween(begin: 0.0, end: 1.0)
                .animate(CurvedAnimation(parent: animation, curve: Interval(0.0, 0.5, curve: curve))),
            child: FadeTransition(
              opacity: Tween(begin: 0.0, end: 1.0)
                  .animate(CurvedAnimation(parent: animation, curve: Interval(0.5, 1.0, curve: curve))),
              child: child,
            ),
          );
        },
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(_animationController!);

    // Start the animation
    _animationController!.forward();
  }

  @override
  void dispose() {
    _animationController!.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_animationController == null) {
      return Container(); // Return an empty container if the controller is null
    }

    return GestureDetector(
      onTap: navigateToLoginPage,
      child: SafeArea(
        child: Scaffold(
          body: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
              image: const DecorationImage(
                opacity: 0.35,
                image: NetworkImage(
                    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv9sWDzG8PRF3Lwg6eIjoFzn9Xn6wCx8Hqwg&usqp=CAU"),
                fit: BoxFit.cover,
              ),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.red,
                  Colors.red.shade100,
                  Colors.indigo.shade50,
                  Colors.white
                ],
              ),
            ),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 300),
                      AnimatedBuilder(
                        animation: _animationController!,
                        builder: (BuildContext context, Widget? child) {
                          return Transform.scale(
                            scale: _animation!.value,
                            child: Opacity(
                              opacity: _animation!.value,
                              child: Image.asset(
                                "logo collection/6365189.png",
                              ),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 20),
                      SizedBox(
                        child: Center(
                          child: AnimatedBuilder(
                            animation: _animationController!,
                            builder: (BuildContext context, Widget? child) {
                              return Transform.scale(
                                scale: _animation!.value,
                                child: Opacity(
                                  opacity: _animation!.value,
                                  child: Text(
                                    '𝓔𝓿𝔂𝓪𝓷 𝓔𝓶𝓹𝓸𝓻𝓲𝓪',
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      fontSize: 50,
                                      color: Colors.indigo.shade900,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
