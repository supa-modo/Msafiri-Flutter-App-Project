import 'package:flutter/material.dart';

import '../../../../size_config/size_config.dart';

class edit_text extends StatelessWidget {
  const edit_text({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      "Edit",
      style: TextStyle(fontSize: getScreenWidth(13)),
    );
  }
}
