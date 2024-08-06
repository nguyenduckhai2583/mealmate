// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_response.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ResultResponseAdapter extends TypeAdapter<ResultResponse> {
  @override
  final int typeId = 2;

  @override
  ResultResponse read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ResultResponse(
      id: fields[0] as String,
      explain: fields[4] as String?,
      dish: (fields[3] as List?)?.cast<Dish>(),
      createDate: fields[5] as DateTime?,
      path: fields[6] as String?,
      alreadyAte: fields[7] as bool?,
      mealType: fields[9] as MealType?,
    );
  }

  @override
  void write(BinaryWriter writer, ResultResponse obj) {
    writer
      ..writeByte(7)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(3)
      ..write(obj.dish)
      ..writeByte(4)
      ..write(obj.explain)
      ..writeByte(5)
      ..write(obj.createDate)
      ..writeByte(6)
      ..write(obj.path)
      ..writeByte(7)
      ..write(obj.alreadyAte)
      ..writeByte(9)
      ..write(obj.mealType);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ResultResponseAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
