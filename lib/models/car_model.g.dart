// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'car_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CarAdapter extends TypeAdapter<Car> {
  @override
  final int typeId = 0;

  @override
  Car read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Car(
      id: fields[0] as String,
      brand: fields[1] as String,
      model: fields[2] as String,
      pricePerDay: fields[3] as double,
      rating: fields[4] as double,
      reviewsCount: fields[5] as int,
      images: (fields[6] as List).cast<String>(),
      description: fields[7] as String,
      category: fields[8] as String,
      specifications: (fields[9] as Map).cast<String, String>(),
      isAvailable: fields[10] as bool,
      isFavorite: fields[11] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, Car obj) {
    writer
      ..writeByte(12)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.brand)
      ..writeByte(2)
      ..write(obj.model)
      ..writeByte(3)
      ..write(obj.pricePerDay)
      ..writeByte(4)
      ..write(obj.rating)
      ..writeByte(5)
      ..write(obj.reviewsCount)
      ..writeByte(6)
      ..write(obj.images)
      ..writeByte(7)
      ..write(obj.description)
      ..writeByte(8)
      ..write(obj.category)
      ..writeByte(9)
      ..write(obj.specifications)
      ..writeByte(10)
      ..write(obj.isAvailable)
      ..writeByte(11)
      ..write(obj.isFavorite);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CarAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
