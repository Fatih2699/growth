// To parse this JSON data, do
//
//     final paketDetay = paketDetayFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Package_model paketDetayFromJson(String str) => Package_model.fromJson(json.decode(str));

String paketDetayToJson(Package_model data) => json.encode(data.toJson());

class Package_model {
    Package_model({
        required this.success,
        required this.message,
        required this.accountTransactionsPackages,
        required this.virtualPosPackages,
        required this.physicalPosPackages,
        required this.vomsisPosPackages,
        required this.erpEntegrasyonPackages,
        required this.topluOdemePackages,
        required this.accountTransactionsInfo,
        required this.virtualPosInfo,
        required this.physicalPosInfo,
        required this.vomsisPosInfo,
        required this.erpEntegrasyonInfo,
        required this.topluOdemeInfo,
        required this.licensePackages,
    });

    bool success;
    String? message;
    List<Package> accountTransactionsPackages;
    List<Package> virtualPosPackages;
    List<Package> physicalPosPackages;
    List<Package> vomsisPosPackages;
    List<Package> erpEntegrasyonPackages;
    List<Package> topluOdemePackages;
    SInfo? accountTransactionsInfo;
    SInfo? virtualPosInfo;
    SInfo? physicalPosInfo;
    SInfo? vomsisPosInfo;
    SInfo? erpEntegrasyonInfo;
    SInfo? topluOdemeInfo;
    LicensePackages licensePackages;

    factory Package_model.fromJson(Map<String, dynamic> json) => Package_model(
        success: json["success"],
        message: json["message"],
        accountTransactionsPackages: List<Package>.from(json["account_transactions_packages"].map((x) => Package.fromJson(x))),
        virtualPosPackages: List<Package>.from(json["virtual_pos_packages"].map((x) => Package.fromJson(x))),
        physicalPosPackages: List<Package>.from(json["physical_pos_packages"].map((x) => Package.fromJson(x))),
        vomsisPosPackages: List<Package>.from(json["vomsis_pos_packages"].map((x) => Package.fromJson(x))),
        erpEntegrasyonPackages: List<Package>.from(json["erp_entegrasyon_packages"].map((x) => Package.fromJson(x))),
        topluOdemePackages: List<Package>.from(json["toplu_odeme_packages"].map((x) => Package.fromJson(x))),
        accountTransactionsInfo: json["account_transactions_info"] == null? null :SInfo.fromJson(json["account_transactions_info"]),
        virtualPosInfo: json["virtual_pos_info"] == null? null :SInfo.fromJson(json["virtual_pos_info"]),
        physicalPosInfo: json["physical_pos_info"]== null? null :SInfo.fromJson(json["physical_pos_info"]),
        vomsisPosInfo: json["vomsis_pos_info"]== null? null :SInfo.fromJson(json["vomsis_pos_info"]),
        erpEntegrasyonInfo: json["erp_entegrasyon_info"]== null? null :SInfo.fromJson(json["erp_entegrasyon_info"]),
        topluOdemeInfo: json["toplu_odeme_info"]== null? null :SInfo.fromJson(json["toplu_odeme_info"]),
        licensePackages: LicensePackages.fromJson(json["license_packages"]),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "account_transactions_packages": List<dynamic>.from(accountTransactionsPackages.map((x) => x.toJson())),
        "virtual_pos_packages": List<dynamic>.from(virtualPosPackages.map((x) => x.toJson())),
        "physical_pos_packages": List<dynamic>.from(physicalPosPackages.map((x) => x.toJson())),
        "vomsis_pos_packages": List<dynamic>.from(vomsisPosPackages.map((x) => x.toJson())),
        "erp_entegrasyon_packages": List<dynamic>.from(erpEntegrasyonPackages.map((x) => x.toJson())),
        "toplu_odeme_packages": List<dynamic>.from(topluOdemePackages.map((x) => x.toJson())),
        "account_transactions_info":accountTransactionsInfo==null?null: accountTransactionsInfo!.toJson(),
        "virtual_pos_info": virtualPosInfo == null ? null: virtualPosInfo!.toJson(),
        "physical_pos_info": physicalPosInfo == null ? null: physicalPosInfo!.toJson(),
        "vomsis_pos_info": vomsisPosInfo == null ? null: vomsisPosInfo!.toJson(),
        "erp_entegrasyon_info": erpEntegrasyonInfo == null ? null: erpEntegrasyonInfo!.toJson(),
        "toplu_odeme_info": topluOdemeInfo == null ? null: topluOdemeInfo!.toJson(),
        "license_packages": licensePackages.toJson(),
    };
}

class SInfo {
    SInfo({
        required this.id,
        required this.packageId,
        required this.packageTitle,
        required this.packagePrice,
        required this.discountRate,
        required this.discountAmount,
        required this.araToplamIndirimOrani,
        required this.araToplamIndirimTutari,
        required this.vopa,
        required this.kdvAmount,
        required this.generalTotal,
        required this.startAt,
        required this.endAt,
        required this.createdAt,
        required this.addedCompanies,
    });

    int? id;
    int? packageId;
    String? packageTitle;
    String? packagePrice;
    String? discountRate;
    String? discountAmount;
    String? araToplamIndirimOrani;
    String? araToplamIndirimTutari;
    int? vopa;
    String? kdvAmount;
    String? generalTotal;
    DateTime startAt;
    DateTime endAt;
    DateTime createdAt;
    List<AddedCompany> addedCompanies;

    factory SInfo.fromJson(Map<String, dynamic> json) => SInfo(
        id: json["id"],
        packageId: json["package_id"],
        packageTitle: json["package_title"],
        packagePrice: json["package_price"],
        discountRate: json["discount_rate"],
        discountAmount: json["discount_amount"],
        araToplamIndirimOrani: json["ara_toplam_indirim_orani"],
        araToplamIndirimTutari: json["ara_toplam_indirim_tutari"],
        vopa: json["vopa"],
        kdvAmount: json["kdv_amount"],
        generalTotal: json["general_total"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        addedCompanies: List<AddedCompany>.from(json["added_companies"].map((x) => AddedCompany.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "package_id": packageId,
        "package_title": packageTitle,
        "package_price": packagePrice,
        "discount_rate": discountRate,
        "discount_amount": discountAmount,
        "ara_toplam_indirim_orani": araToplamIndirimOrani,
        "ara_toplam_indirim_tutari": araToplamIndirimTutari,
        "vopa": vopa,
        "kdv_amount": kdvAmount,
        "general_total": generalTotal,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "added_companies": List<dynamic>.from(addedCompanies.map((x) => x.toJson())),
    };
}


class VirtualPosInfo {
    VirtualPosInfo({
        required this.id,
        required this.packageId,
        required this.packageTitle,
        required this.packagePrice,
        required this.discountRate,
        required this.discountAmount,
        required this.araToplamIndirimOrani,
        required this.araToplamIndirimTutari,
        required this.vopa,
        required this.kdvAmount,
        required this.generalTotal,
        required this.startAt,
        required this.endAt,
        required this.createdAt,
        required this.addedCompanies,
    });

    int? id;
    int? packageId;
    String? packageTitle;
    String? packagePrice;
    String? discountRate;
    String? discountAmount;
    String? araToplamIndirimOrani;
    String? araToplamIndirimTutari;
    int? vopa;
    String? kdvAmount;
    String? generalTotal;
    DateTime startAt;
    DateTime endAt;
    DateTime createdAt;
    List<AddedCompany> addedCompanies;

    factory VirtualPosInfo.fromJson(Map<String, dynamic> json) => VirtualPosInfo(
        id: json["id"],
        packageId: json["package_id"],
        packageTitle: json["package_title"],
        packagePrice: json["package_price"],
        discountRate: json["discount_rate"],
        discountAmount: json["discount_amount"],
        araToplamIndirimOrani: json["ara_toplam_indirim_orani"],
        araToplamIndirimTutari: json["ara_toplam_indirim_tutari"],
        vopa: json["vopa"],
        kdvAmount: json["kdv_amount"],
        generalTotal: json["general_total"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        addedCompanies: List<AddedCompany>.from(json["added_companies"].map((x) => AddedCompany.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "package_id": packageId,
        "package_title": packageTitle,
        "package_price": packagePrice,
        "discount_rate": discountRate,
        "discount_amount": discountAmount,
        "ara_toplam_indirim_orani": araToplamIndirimOrani,
        "ara_toplam_indirim_tutari": araToplamIndirimTutari,
        "vopa": vopa,
        "kdv_amount": kdvAmount,
        "general_total": generalTotal,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "added_companies": List<dynamic>.from(addedCompanies.map((x) => x.toJson())),
    };
}

class AddedCompany {
    AddedCompany({
        required this.licenseId,
        required this.companyTitle,
    });

    int? licenseId;
    String? companyTitle;

    factory AddedCompany.fromJson(Map<String, dynamic> json) => AddedCompany(
        licenseId: json["license_id"],
        companyTitle: json["company_title"],
    );

    Map<String, dynamic> toJson() => {
        "license_id": licenseId,
        "company_title": companyTitle,
    };
}

class Package {
    Package({
        required this.packageId,
        required this.value,
        required this.text,
        required this.title,
        required this.price,
    });

    int? packageId;
    int? value;
    String? text;
    String? title;
    String? price;

    factory Package.fromJson(Map<String, dynamic> json) => Package(
        packageId: json["package_id"],
        value: json["value"],
        text: json["text"],
        title: json["title"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "package_id": packageId,
        "value": value,
        "text": text,
        "title": title,
        "price": price,
    };
}

class LicensePackages {
    LicensePackages({
        required this.accountTransactions,
        required this.virtualPos,
        required this.physicalPos,
        required this.vomsisPos,
        required this.erpEntegrasyon,
        required this.topluOdeme,
    });

    List<AccountTransaction> accountTransactions;
    List<dynamic> virtualPos;
    List<dynamic> physicalPos;
    List<dynamic> vomsisPos;
    List<dynamic> erpEntegrasyon;
    List<dynamic> topluOdeme;

    factory LicensePackages.fromJson(Map<String, dynamic> json) => LicensePackages(
        accountTransactions: List<AccountTransaction>.from(json["account_transactions"].map((x) => AccountTransaction.fromJson(x))),
        virtualPos: List<dynamic>.from(json["virtual_pos"].map((x) => x)),
        physicalPos: List<dynamic>.from(json["physical_pos"].map((x) => x)),
        vomsisPos: List<dynamic>.from(json["vomsis_pos"].map((x) => x)),
        erpEntegrasyon: List<dynamic>.from(json["erp_entegrasyon"].map((x) => x)),
        topluOdeme: List<dynamic>.from(json["toplu_odeme"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "account_transactions": List<dynamic>.from(accountTransactions.map((x) => x.toJson())),
        "virtual_pos": List<dynamic>.from(virtualPos.map((x) => x)),
        "physical_pos": List<dynamic>.from(physicalPos.map((x) => x)),
        "vomsis_pos": List<dynamic>.from(vomsisPos.map((x) => x)),
        "erp_entegrasyon": List<dynamic>.from(erpEntegrasyon.map((x) => x)),
        "toplu_odeme": List<dynamic>.from(topluOdeme.map((x) => x)),
    };
}

class AccountTransaction {
    AccountTransaction({
        required this.mainLicensePackageId,
        required this.licenseId,
        required this.packageTitle,
        required this.packagePrice,
        required this.packageId,
        required this.discountRate,
        required this.discountAmount,
        required this.araToplamDiscountRate,
        required this.araToplamDiscountAmount,
        required this.vopa,
        required this.discountTotal,
        required this.discountedPrice,
        required this.araToplamDiscountTotal,
        required this.araToplamDiscountedPrice,
        required this.kdvOrani,
        required this.indirimTipi,
        required this.araToplamIndirimTipi,
        required this.kdvAmount,
        required this.generalTotal,
        required this.maxBanks,
        required this.maxHareket,
        required this.maxUsers,
        required this.maxFirma,
        required this.currentFirmaCount,
        required this.kalanGun,
        required this.startAt,
        required this.endAt,
        required this.createdAt,
        required this.startAtDateFormat,
        required this.endAtDateFormat,
        required this.createdAtDateFormat,
        required this.addedCompanies,
    });

    int? mainLicensePackageId;
    int? licenseId;
    String? packageTitle;
    String? packagePrice;
    int? packageId;
    String? discountRate;
    String? discountAmount;
    String? araToplamDiscountRate;
    String? araToplamDiscountAmount;
    int? vopa;
    int? discountTotal;
    int? discountedPrice;
    int? araToplamDiscountTotal;
    int? araToplamDiscountedPrice;
    int? kdvOrani;
    String? indirimTipi;
    String? araToplamIndirimTipi;
    String? kdvAmount;
    String? generalTotal;
    int? maxBanks;
    int? maxHareket;
    int? maxUsers;
    int? maxFirma;
    int? currentFirmaCount;
    int? kalanGun;
    DateTime startAt;
    DateTime endAt;
    DateTime createdAt;
    DateTime startAtDateFormat;
    DateTime endAtDateFormat;
    DateTime createdAtDateFormat;
    List<AddedCompany> addedCompanies;

    factory AccountTransaction.fromJson(Map<String, dynamic> json) => AccountTransaction(
        mainLicensePackageId: json["main_license_package_id"],
        licenseId: json["license_id"],
        packageTitle: json["package_title"],
        packagePrice: json["package_price"],
        packageId: json["package_id"],
        discountRate: json["discount_rate"],
        discountAmount: json["discount_amount"],
        araToplamDiscountRate: json["ara_toplam_discount_rate"],
        araToplamDiscountAmount: json["ara_toplam_discount_amount"],
        vopa: json["vopa"],
        discountTotal: json["discount_total"],
        discountedPrice: json["discounted_price"],
        araToplamDiscountTotal: json["ara_toplam_discount_total"],
        araToplamDiscountedPrice: json["ara_toplam_discounted_price"],
        kdvOrani: json["kdv_orani"],
        indirimTipi: json["indirim_tipi"],
        araToplamIndirimTipi: json["ara_toplam_indirim_tipi"],
        kdvAmount: json["kdv_amount"],
        generalTotal: json["general_total"],
        maxBanks: json["max_banks"],
        maxHareket: json["max_hareket"],
        maxUsers: json["max_users"],
        maxFirma: json["max_firma"],
        currentFirmaCount: json["current_firma_count"],
        kalanGun: json["kalan_gun"],
        startAt: DateTime.parse(json["start_at"]),
        endAt: DateTime.parse(json["end_at"]),
        createdAt: DateTime.parse(json["created_at"]),
        startAtDateFormat: DateTime.parse(json["start_at_date_format"]),
        endAtDateFormat: DateTime.parse(json["end_at_date_format"]),
        createdAtDateFormat: DateTime.parse(json["created_at_date_format"]),
        addedCompanies: List<AddedCompany>.from(json["added_companies"].map((x) => AddedCompany.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "main_license_package_id": mainLicensePackageId,
        "license_id": licenseId,
        "package_title": packageTitle,
        "package_price": packagePrice,
        "package_id": packageId,
        "discount_rate": discountRate,
        "discount_amount": discountAmount,
        "ara_toplam_discount_rate": araToplamDiscountRate,
        "ara_toplam_discount_amount": araToplamDiscountAmount,
        "vopa": vopa,
        "discount_total": discountTotal,
        "discounted_price": discountedPrice,
        "ara_toplam_discount_total": araToplamDiscountTotal,
        "ara_toplam_discounted_price": araToplamDiscountedPrice,
        "kdv_orani": kdvOrani,
        "indirim_tipi": indirimTipi,
        "ara_toplam_indirim_tipi": araToplamIndirimTipi,
        "kdv_amount": kdvAmount,
        "general_total": generalTotal,
        "max_banks": maxBanks,
        "max_hareket": maxHareket,
        "max_users": maxUsers,
        "max_firma": maxFirma,
        "current_firma_count": currentFirmaCount,
        "kalan_gun": kalanGun,
        "start_at": startAt.toIso8601String(),
        "end_at": endAt.toIso8601String(),
        "created_at": createdAt.toIso8601String(),
        "start_at_date_format": "${startAtDateFormat.year.toString().padLeft(4, '0')}-${startAtDateFormat.month.toString().padLeft(2, '0')}-${startAtDateFormat.day.toString().padLeft(2, '0')}",
        "end_at_date_format": "${endAtDateFormat.year.toString().padLeft(4, '0')}-${endAtDateFormat.month.toString().padLeft(2, '0')}-${endAtDateFormat.day.toString().padLeft(2, '0')}",
        "created_at_date_format": "${createdAtDateFormat.year.toString().padLeft(4, '0')}-${createdAtDateFormat.month.toString().padLeft(2, '0')}-${createdAtDateFormat.day.toString().padLeft(2, '0')}",
        "added_companies": List<dynamic>.from(addedCompanies.map((x) => x.toJson())),
    };
}
