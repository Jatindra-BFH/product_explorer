import 'package:hive/hive.dart';
part 'user.g.dart';
@HiveType(typeId: 2)
class User extends HiveObject{
  @HiveField(0)
  final String accessToken;
  @HiveField(1)
  final String refreshToken;
  User({required this.accessToken, required this.refreshToken});
}