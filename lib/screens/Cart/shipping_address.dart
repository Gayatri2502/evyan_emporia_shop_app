import 'package:evyan_emporia_shop_app/screens/Cart/location.dart';
import 'package:flutter/material.dart';

// 1. "Speed Unleashed: Evyan Emporia, the Fastest Delivery Service!"
// 2. "Swift as Lightning, Reliable as Ever: Choose Evyan Emporia for Fastest Delivery!"
// 3. "From Here to There in No Time: Evyan Emporia, the Fastest Delivery Service Around!"
// 4. "Your Urgency, Our Priority: Experience the Fastest Delivery with Evyan Emporia!"
// 5. "Blazing-Fast Deliveries at Your Doorstep: Evyan Emporia Leads the Way!"
// 6. "Need It Now? Evyan Emporia Delivers in Record Time!"
// 7. "Time is Money: Trust Evyan Emporia for Lightning-Fast Delivery!"
// 8. "No Delays, Just Swiftness: Evyan Emporia, the Epitome of Fastest Delivery!"
// 9. "Quickest Route to Satisfaction: Evyan Emporia, the Fastest Delivery in Town!"
// 10. "Fast, Faster, Evyan Emporia: Unmatched Speed for Your Deliveries!"

class ShippingPage extends StatefulWidget {
  const ShippingPage({Key? key}) : super(key: key);

  @override
  State<ShippingPage> createState() => _ShippingPageState();
}

class _ShippingPageState extends State<ShippingPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              height: MediaQuery.of(context).size.height - 880,
              alignment: Alignment.topLeft,
              child: Image.asset("logo collection/img.png",
                  alignment: Alignment.topLeft),
            ),
            Container(
                alignment: Alignment.center,
                padding: MediaQuery.of(context).padding,
                height: MediaQuery.of(context).size.height - 880,
                width: MediaQuery.of(context).size.width * 0.65,
                child: Column(
                  children: [
                    Text(
                      " 𝐒ω𝗂𝖿𝗍 α𝗌 𝐋𝗂𝗀ɦ𝗍𐓣𝗂𐓣𝗀, 𝐑𝖾ᥣ𝗂αᑲᥣ𝖾 α𝗌 𝐄𝗏𝖾𝗋 :  ",
                      style: TextStyle(
                          color: Colors.teal.shade900,
                          fontSize: 14,
                          fontWeight: FontWeight.w900),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Text("Choose Evyan Emporia for Fastest Delivery!",
                        style: TextStyle(
                            color: Colors.red.shade900,
                            fontWeight: FontWeight.w900))
                  ],
                ))
          ],
        ),
        Container(

          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                offset: Offset(
                  5.0,
                  5.0,
                ),
                blurRadius: 10.0,
                spreadRadius: 2.0,
              ), //BoxShadow
              BoxShadow(
                color: Colors.indigo,
                offset: Offset(0.0, 0.0),
                blurRadius: 0.0,
                spreadRadius: 0.0,
              ),
            ],
            color: Colors.red.shade50,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(45),
              topRight: Radius.circular(320),
              bottomLeft: Radius.circular(45),
              bottomRight: Radius.circular(45)
            ),
          ),
          height: MediaQuery.of(context).size.height -350,
          child: ShippingAddressPage(),
        ),






      ],
    );
  }
}
