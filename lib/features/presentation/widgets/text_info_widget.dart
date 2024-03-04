import 'package:flutter/widgets.dart';
import 'package:ingfo_movies/conf/themes/typography.dart';

class TextInfoWidget {
  static Widget buildSingleInfo(IconData? icon, String text) {
    return Text.rich(
      TextSpan(
        children: [
          WidgetSpan(
            child: Icon(
              icon,
              size: 24.0,
            ),
            alignment: PlaceholderAlignment.middle,
          ),
          const WidgetSpan(child: SizedBox(width: 16.0)),
          TextSpan(
            text: text,
            style: MovieTypography.category,
          )
        ],
      ),
    );
  }

  static Widget buildTwoInfos(IconData? firstIcon, IconData? secondIcon,
      String firstText, String secondText) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(firstIcon, size: 24.0),
                  alignment: PlaceholderAlignment.middle,
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 16.0,
                )),
                TextSpan(
                  text: firstText,
                  style: MovieTypography.category,
                )
              ],
            ),
          ),
        ),
        const SizedBox(
          width: 24.0,
        ),
        Expanded(
          flex: 1,
          child: Text.rich(
            TextSpan(
              children: [
                WidgetSpan(
                  child: Icon(secondIcon, size: 24.0),
                  alignment: PlaceholderAlignment.middle,
                ),
                const WidgetSpan(
                    child: SizedBox(
                  width: 16.0,
                )),
                TextSpan(
                  text: secondText,
                  style: MovieTypography.category,
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}
