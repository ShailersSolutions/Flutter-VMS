
class Block{
  String msg;
  String status;
  Block({this.msg,this.status});

  Block.fromJson(Map<String, dynamic> json){
    msg = json['msg'];
    status = json['status'];
  }
}
