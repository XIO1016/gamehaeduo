import 'package:flutter/material.dart';

Widget tierImage(String tier){
  if (tier=='Bronze'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Bronze.png",
      width: 18,
      height: 18,
    );
  }
  else if(tier=='Iron'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Iron.png",
      width: 18,
      height: 18,
    );
  }else if(tier=='Silver'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Silver.png",
      width: 18,
      height: 18,
    );
  }else if(tier=='Gold'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Gold.png",
      width: 18,
      height: 18,
    );
  }else if(tier=='Platinum'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Platinum.png",
      width: 18,
      height: 18,
    );
  }else if(tier=='Master'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Master.png",
      width: 18,
      height: 18,
    );
  }else if(tier=='Grandmaster'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Grandmaster.png",
      width: 18,
      height: 18,
    );
  }else if(tier=='Challenger'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Challenger.png",
      width: 18,
      height: 18,
    );
  }else if(tier=='Diamond'){
    return Image.asset(
      "images/ranked_emblems/Emblem_Diamond.png",
      width: 18,
      height: 18,
    );
  }
  return Container();
}