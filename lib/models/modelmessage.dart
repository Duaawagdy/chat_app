class message{
  final String text;

  message({required this.text});
  factory message.fromjson(Map<String,dynamic>jsondata){
   return message(text: jsondata['text']) ;
  }
}