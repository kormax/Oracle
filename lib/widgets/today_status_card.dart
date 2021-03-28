import 'package:data/constants/colors.dart';
import 'package:flutter/cupertino.dart';

class TodayStatusCard extends StatelessWidget {
  Color primaryColor;
  Color secondaryColor;
  String title;
  String content;

  TodayStatusCard({this.title, this.content, this.primaryColor, this.secondaryColor});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: secondaryColor,
            borderRadius: BorderRadius.all(Radius.circular(8))
        ),
        padding: EdgeInsets.all(16),
        width: 128 * 3.0,

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
             this.title,
              style: TextStyle(
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                  height: 24/16,
                  color: primaryColor
              ),
            ),

            SizedBox(height: 8,),
            Expanded(child:
            Text(
              this.content,
              style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 16,
                  height: 24/16,
                  color: primaryColor
              ),
            )
            )
          ],
        )
    );
  }
}