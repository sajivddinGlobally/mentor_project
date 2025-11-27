// // To parse this JSON data, do
// //
// //     final profileGetModel = profileGetModelFromJson(jsonString);

// import 'dart:convert';

// ProfileGetModel profileGetModelFromJson(String str) => ProfileGetModel.fromJson(json.decode(str));

// String profileGetModelToJson(ProfileGetModel data) => json.encode(data.toJson());

// class ProfileGetModel {
//     int? id;
//     String? fullName;
//     String? profilePic;
//     dynamic usersField;
//     dynamic description;
//     dynamic totalExperience;
//     dynamic skills;
//     dynamic languageKnown;
//     dynamic linkedinUser;
//     dynamic companiesWorked;
//     dynamic resumeUpload;
//     List<MentorRequest>? mentorRequests;

//     ProfileGetModel({
//         this.id,
//         this.fullName,
//         this.profilePic,
//         this.usersField,
//         this.description,
//         this.totalExperience,
//         this.skills,
//         this.languageKnown,
//         this.linkedinUser,
//         this.companiesWorked,
//         this.resumeUpload,
//         this.mentorRequests,
//     });

//     factory ProfileGetModel.fromJson(Map<String, dynamic> json) => ProfileGetModel(
//         id: json["id"],
//         fullName: json["full_name"],
//         profilePic: json["profile_pic"],
//         usersField: json["users_field"],
//         description: json["description"],
//         totalExperience: json["total_experience"],
//         skills: json["skills"],
//         languageKnown: json["language_known"],
//         linkedinUser: json["linkedin_user"],
//         companiesWorked: json["companies_worked"],
//         resumeUpload: json["resume_upload"],
//         mentorRequests: json["mentorRequests"] == null ? [] : List<MentorRequest>.from(json["mentorRequests"]!.map((x) => MentorRequest.fromJson(x))),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "full_name": fullName,
//         "profile_pic": profilePic,
//         "users_field": usersField,
//         "description": description,
//         "total_experience": totalExperience,
//         "skills": skills,
//         "language_known": languageKnown,
//         "linkedin_user": linkedinUser,
//         "companies_worked": companiesWorked,
//         "resume_upload": resumeUpload,
//         "mentorRequests": mentorRequests == null ? [] : List<dynamic>.from(mentorRequests!.map((x) => x.toJson())),
//     };
// }

// class MentorRequest {
//     int? id;
//     int? studentId;
//     int? mentorId;
//     String? status;
//     DateTime? createdAt;
//     DateTime? updatedAt;

//     MentorRequest({
//         this.id,
//         this.studentId,
//         this.mentorId,
//         this.status,
//         this.createdAt,
//         this.updatedAt,
//     });

//     factory MentorRequest.fromJson(Map<String, dynamic> json) => MentorRequest(
//         id: json["id"],
//         studentId: json["student_id"],
//         mentorId: json["mentor_id"],
//         status: json["status"],
//         createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
//         updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
//     );

//     Map<String, dynamic> toJson() => {
//         "id": id,
//         "student_id": studentId,
//         "mentor_id": mentorId,
//         "status": status,
//         "created_at": createdAt?.toIso8601String(),
//         "updated_at": updatedAt?.toIso8601String(),
//     };
// }


// To parse this JSON data, do
//
//     final profileGetModel = profileGetModelFromJson(jsonString);

import 'dart:convert';

ProfileGetModel profileGetModelFromJson(String str) => ProfileGetModel.fromJson(json.decode(str));

String profileGetModelToJson(ProfileGetModel data) => json.encode(data.toJson());

class ProfileGetModel {
    int? id;
    String? fullName;
    String? profilePic;
    String? usersField;
    String? description;
    String? totalExperience;
    String? skills;
    String? languageKnown;
    String? linkedinUser;
    dynamic companiesWorked;
    String? resumeUpload;
    MentorRequests? mentorRequests;

    ProfileGetModel({
        this.id,
        this.fullName,
        this.profilePic,
        this.usersField,
        this.description,
        this.totalExperience,
        this.skills,
        this.languageKnown,
        this.linkedinUser,
        this.companiesWorked,
        this.resumeUpload,
        this.mentorRequests,
    });

    factory ProfileGetModel.fromJson(Map<String, dynamic> json) => ProfileGetModel(
        id: json["id"],
        fullName: json["full_name"],
        profilePic: json["profile_pic"],
        usersField: json["users_field"],
        description: json["description"],
        totalExperience: json["total_experience"],
        skills: json["skills"],
        languageKnown: json["language_known"],
        linkedinUser: json["linkedin_user"],
        companiesWorked: json["companies_worked"],
        resumeUpload: json["resume_upload"],
        mentorRequests: json["mentorRequests"] == null ? null : MentorRequests.fromJson(json["mentorRequests"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_pic": profilePic,
        "users_field": usersField,
        "description": description,
        "total_experience": totalExperience,
        "skills": skills,
        "language_known": languageKnown,
        "linkedin_user": linkedinUser,
        "companies_worked": companiesWorked,
        "resume_upload": resumeUpload,
        "mentorRequests": mentorRequests?.toJson(),
    };
}

class MentorRequests {
    int? id;
    int? studentId;
    int? mentorId;
    String? status;
    DateTime? createdAt;
    DateTime? updatedAt;

    MentorRequests({
        this.id,
        this.studentId,
        this.mentorId,
        this.status,
        this.createdAt,
        this.updatedAt,
    });

    factory MentorRequests.fromJson(Map<String, dynamic> json) => MentorRequests(
        id: json["id"],
        studentId: json["student_id"],
        mentorId: json["mentor_id"],
        status: json["status"],
        createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "student_id": studentId,
        "mentor_id": mentorId,
        "status": status,
        "created_at": createdAt?.toIso8601String(),
        "updated_at": updatedAt?.toIso8601String(),
    };
}
