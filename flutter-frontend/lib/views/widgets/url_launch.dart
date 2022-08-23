import 'package:movie/views/widgets/loading.dart';
import 'package:url_launcher/url_launcher.dart';

void customLaunch(command , type) async{
  
  if(!RegExp(r"^[http]+").hasMatch(command)){
    if(type == "3"){
      command = 'viber://chat?number=$command';
    }else if(type == "4"){
      command = 'line://ti/p/@$command';
    }else if(type == "5"){
      command = 'https://t.me/$command';
    }
  }

  if(type == "2"){
    command = 'fb://facewebmodal/f?href=$command';
  }

  if(await canLaunch(command)){
    await launch(command);
  }else{
    Loading(1, 'Error', 'Something went wrong');
  }
}