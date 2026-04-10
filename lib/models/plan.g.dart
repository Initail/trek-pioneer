// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class TrainingPlanHiveAdapter extends TypeAdapter<TrainingPlanHive> {
  @override
  final int typeId = 0;

  @override
  TrainingPlanHive read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return TrainingPlanHive(
      id: fields[0] as String,
      name: fields[1] as String,
      description: fields[2] as String,
      totalWeeks: fields[3] as int,
      weeklyDays: fields[4] as int,
      sessionMinutes: fields[5] as int,
      createdAt: fields[6] as DateTime,
      currentWeek: fields[7] as int,
      isActive: fields[8] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, TrainingPlanHive obj) {
    writer
      ..writeByte(9)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.description)
      ..writeByte(3)
      ..write(obj.totalWeeks)
      ..writeByte(4)
      ..write(obj.weeklyDays)
      ..writeByte(5)
      ..write(obj.sessionMinutes)
      ..writeByte(6)
      ..write(obj.createdAt)
      ..writeByte(7)
      ..write(obj.currentWeek)
      ..writeByte(8)
      ..write(obj.isActive);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is TrainingPlanHiveAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class DailyCheckInAdapter extends TypeAdapter<DailyCheckIn> {
  @override
  final int typeId = 1;

  @override
  DailyCheckIn read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return DailyCheckIn(
      id: fields[0] as String,
      planId: fields[1] as String,
      week: fields[2] as int,
      day: fields[3] as int,
      date: fields[4] as DateTime,
      completed: fields[5] as bool,
      actualDuration: fields[6] as int,
      actualCalories: fields[7] as int,
      notes: fields[8] as String?,
      completedAt: fields[9] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, DailyCheckIn obj) {
    writer
      ..writeByte(10)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.planId)
      ..writeByte(2)
      ..write(obj.week)
      ..writeByte(3)
      ..write(obj.day)
      ..writeByte(4)
      ..write(obj.date)
      ..writeByte(5)
      ..write(obj.completed)
      ..writeByte(6)
      ..write(obj.actualDuration)
      ..writeByte(7)
      ..write(obj.actualCalories)
      ..writeByte(8)
      ..write(obj.notes)
      ..writeByte(9)
      ..write(obj.completedAt);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is DailyCheckInAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class UserStatsAdapter extends TypeAdapter<UserStats> {
  @override
  final int typeId = 2;

  @override
  UserStats read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return UserStats(
      totalWorkouts: fields[0] as int,
      totalDuration: fields[1] as int,
      totalCalories: fields[2] as int,
      longestStreak: fields[3] as int,
      currentStreak: fields[4] as int,
      lastWorkoutDate: fields[5] as DateTime?,
    );
  }

  @override
  void write(BinaryWriter writer, UserStats obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.totalWorkouts)
      ..writeByte(1)
      ..write(obj.totalDuration)
      ..writeByte(2)
      ..write(obj.totalCalories)
      ..writeByte(3)
      ..write(obj.longestStreak)
      ..writeByte(4)
      ..write(obj.currentStreak)
      ..writeByte(5)
      ..write(obj.lastWorkoutDate);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserStatsAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
