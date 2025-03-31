// import 'package:hive_ce/hive.dart';
// import 'package:osc_system/features/salkhana/data/model/member.dart';

// class MemberTypeAdaptor extends TypeAdapter<SalkhanaMemberModel> {
//   @override
//   read(BinaryReader reader) {
//     throw SalkhanaMemberModel.fromHive(
//         indexAtDb: reader.readInt(),
//         id: reader.readString(),
//         name: reader.readString(),
//         email: reader.readString(),
//         phone: reader.readString(),
//         academicYear: reader.readString(),
//         college: reader.readString(),
//         committee1: reader.readString(),
//         committee2: reader.readString(),
//         resultCommittee1: reader.readString(),
//         resultCommittee2: reader.readString(),
//         attendanceDate: reader.readString(),
//         emailSent: reader.readBool());
//   }

//   @override
//   int get typeId => 0;

//   @override
//   void write(BinaryWriter writer, SalkhanaMemberModel obj) {
//     writer.writeInt(obj.indexAtDb!);
//     writer.writeString(obj.id);
//     writer.writeString(obj.name);
//     writer.writeString(obj.email);
//     writer.writeString(obj.phone);
//     writer.writeString(obj.academicYear);
//     writer.writeString(obj.college);
//     writer.writeString(obj.committee1);
//     writer.writeString(obj.resultCommittee2);
//     writer.writeString(obj.attendanceDate);
//     writer.writeBool(obj.emailSent);
//   }
// }
