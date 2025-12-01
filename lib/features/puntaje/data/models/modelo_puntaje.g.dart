// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'modelo_puntaje.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ModeloPuntajeAdapter extends TypeAdapter<ModeloPuntaje> {
  @override
  final int typeId = 1;

  @override
  ModeloPuntaje read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return ModeloPuntaje(
      nombreJugador: fields[0] as String,
      puntaje: fields[1] as int,
      fecha: fields[2] as DateTime,
      idCategoria: fields[3] as String,
      dificultad: fields[4] as String,
      idioma: fields[5] as String,
    );
  }

  @override
  void write(BinaryWriter writer, ModeloPuntaje obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.nombreJugador)
      ..writeByte(1)
      ..write(obj.puntaje)
      ..writeByte(2)
      ..write(obj.fecha)
      ..writeByte(3)
      ..write(obj.idCategoria)
      ..writeByte(4)
      ..write(obj.dificultad)
      ..writeByte(5)
      ..write(obj.idioma);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ModeloPuntajeAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
