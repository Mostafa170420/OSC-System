// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'member.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class SalkhanaMemberModelAdapter extends TypeAdapter<SalkhanaMemberModel> {
  @override
  final int typeId = 1;

  @override
  SalkhanaMemberModel read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return SalkhanaMemberModel(
      indexAtDb: fields[0] as int?,
      id: fields[1] as String,
      name: fields[2] as String,
      email: fields[3] as String,
      phone: fields[4] as String,
      academicYear: fields[5] as String,
      college: fields[6] as String,
      committee1: fields[7] as String,
      committee2: fields[8] as String,
      resultCommittee1: fields[9] as String,
      resultCommittee2: fields[10] as String,
      rejectionReasonCommittee1: fields[11] as String?,
      rejectionReasonCommittee2: fields[12] as String?,
      attendanceDate: fields[13] as String,
      emailSent: fields[14] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, SalkhanaMemberModel obj) {
    writer
      ..writeByte(15)
      ..writeByte(0)
      ..write(obj.indexAtDb)
      ..writeByte(1)
      ..write(obj.id)
      ..writeByte(2)
      ..write(obj.name)
      ..writeByte(3)
      ..write(obj.email)
      ..writeByte(4)
      ..write(obj.phone)
      ..writeByte(5)
      ..write(obj.academicYear)
      ..writeByte(6)
      ..write(obj.college)
      ..writeByte(7)
      ..write(obj.committee1)
      ..writeByte(8)
      ..write(obj.committee2)
      ..writeByte(9)
      ..write(obj.resultCommittee1)
      ..writeByte(10)
      ..write(obj.resultCommittee2)
      ..writeByte(11)
      ..write(obj.rejectionReasonCommittee1)
      ..writeByte(12)
      ..write(obj.rejectionReasonCommittee2)
      ..writeByte(13)
      ..write(obj.attendanceDate)
      ..writeByte(14)
      ..write(obj.emailSent);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SalkhanaMemberModelAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
