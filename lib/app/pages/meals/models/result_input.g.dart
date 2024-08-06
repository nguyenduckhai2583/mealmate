// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result_input.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class MealTypeAdapter extends TypeAdapter<MealType> {
  @override
  final int typeId = 4;

  @override
  MealType read(BinaryReader reader) {
    switch (reader.readByte()) {
      case 0:
        return MealType.mealMatch;
      case 1:
        return MealType.mealSuggestion;
      case 2:
        return MealType.mealIngredient;
      default:
        return MealType.mealMatch;
    }
  }

  @override
  void write(BinaryWriter writer, MealType obj) {
    switch (obj) {
      case MealType.mealMatch:
        writer.writeByte(0);
        break;
      case MealType.mealSuggestion:
        writer.writeByte(1);
        break;
      case MealType.mealIngredient:
        writer.writeByte(2);
        break;
    }
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is MealTypeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
