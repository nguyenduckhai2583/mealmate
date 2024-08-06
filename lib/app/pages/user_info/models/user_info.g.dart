// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserInfoAdapter extends TypeAdapter<UserInfo> {
  @override
  final int typeId = 1;

  @override
  UserInfo read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserInfo(
      gender: fields[0] as String?,
      height: fields[1] as int?,
      goal: fields[2] as String?,
      goalEnums: (fields[3] as List?)?.cast<String>(),
      medicalCondition: fields[4] as String?,
      medicalConditionEnums: (fields[5] as List?)?.cast<String>(),
      weight: fields[6] as int?,
      age: fields[7] as int?,
    );
  }

  @override
  void write(BinaryWriter writer, UserInfo obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.gender)
      ..writeByte(1)
      ..write(obj.height)
      ..writeByte(2)
      ..write(obj.goal)
      ..writeByte(3)
      ..write(obj.goalEnums)
      ..writeByte(4)
      ..write(obj.medicalCondition)
      ..writeByte(5)
      ..write(obj.medicalConditionEnums)
      ..writeByte(6)
      ..write(obj.weight)
      ..writeByte(7)
      ..write(obj.age);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserInfoAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
