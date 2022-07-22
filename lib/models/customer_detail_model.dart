import 'dart:convert';

FirmaDetay customerDetayFromJson(String str) =>
    FirmaDetay.fromJson(json.decode(str));

String customerDetayToJson(FirmaDetay data) => json.encode(data.toJson());

class FirmaDetay {
  FirmaDetay({
    required this.success,
    required this.customer,
  });

  bool success;
  Customer customer;

  factory FirmaDetay.fromJson(Map<String, dynamic> json) => FirmaDetay(
        success: json["success"],
        customer: Customer.fromJson(json["customer"]),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "customer": customer.toJson(),
      };
}

class Customer {
  Customer({
    required this.licenseId,
    required this.code,
    required this.status,
    required this.maxBanks,
    required this.referanceCode,
    required this.topCompany,
    required this.bankaEkle,
    required this.formDoldur,
    required this.version,
    required this.dbHost,
    required this.adiOrtaklik,
    required this.gibOnay,
    required this.companyTitle,
    required this.address,
    required this.erp,
    required this.taxOffice,
    required this.taxNo,
    required this.tckn,
    required this.city,
    required this.district,
    required this.fizikselPos,
    required this.reklamUrl,
    required this.referer,
    required this.isArchive,
    required this.virtualPos,
    required this.demoVeriSanalPos,
    required this.faturaUnvan,
    required this.faturaAdres,
    required this.faturaIlce,
    required this.faturaIl,
    required this.faturaVergiDairesi,
    required this.faturaVergiNo,
    required this.firmaStatus,
    required this.maxFirma,
    required this.maxUsers,
    required this.demoStatus,
    required this.refCount,
    required this.vomsisApiLogsCount,
    required this.advisorCompanyTitle,
    required this.advisorLicenseId,
    required this.licenseType,
    required this.name,
    required this.phone,
    required this.email,
    required this.emailVerified,
    required this.showRemainingTime,
    required this.registerType,
    required this.lastLoginType,
    required this.referans,
    required this.customerLicenseType,
    required this.registerLicense,
    required this.startLicense,
    required this.endLicense,
    required this.licenseTerm,
    required this.maxHareket,
    required this.packageName,
    required this.packagePrice,
    required this.indirim,
    required this.kullanilanPuan,
    required this.currentVopa,
    required this.not,
    required this.lastLoginName,
    required this.lastLoginDate,
    required this.taxpayerCount,
    required this.smmKullaniciGrupIzni,
    required this.selectedBankCount,
    required this.addedBankCount,
    required this.activeUserId,
    required this.dbStatus,
    required this.mevcutHareket,
    required this.toplamMevcutHareket,
    required this.banks,
    required this.notes,
    required this.users,
    required this.companyActivity,
    required this.topCompanies,
    required this.bottomCompanies,
    required this.logNames,
    required this.logs,
    required this.onboardingSteps,
    required this.completedSteps,
    required this.lastTransaction,
    required this.bankStatus,
    required this.virtualPosBankOptions,
    required this.virtualPosBanks,
    required this.pyhsicalPosBanks,
    required this.virtualPosInfo,
    required this.sanalPosIslemLoglari,
    required this.vomsisposBelgeler,
    required this.entegrasyonBilgileri,
    required this.entegrasyonIslemLoglari,
    required this.fizikselPosBankList,
    required this.entegrasyonProgramlar,
    required this.entegrasyonProgramList,
    required this.fizikselPosBilgileri,
    required this.fizikselPosGirisLogBankOptions,
    required this.fizikselPosGirisLogs,
    required this.kycPoint,
  });

  int? licenseId;
  String? code;
  int? status;
  dynamic maxBanks;
  dynamic referanceCode;
  int? topCompany;
  int? bankaEkle;
  int? formDoldur;
  int? version;
  String? dbHost;
  int? adiOrtaklik;
  int? gibOnay;
  String? companyTitle;
  String? address;
  int? erp;
  String? taxOffice;
  String? taxNo;
  String? tckn;
  String? city;
  String? district;
  int? fizikselPos;
  dynamic reklamUrl;
  dynamic referer;
  int? isArchive;
  int? virtualPos;
  int? demoVeriSanalPos;
  String? faturaUnvan;
  String? faturaAdres;
  String? faturaIlce;
  String? faturaIl;
  String? faturaVergiDairesi;
  String? faturaVergiNo;
  String? firmaStatus;
  dynamic maxFirma;
  dynamic maxUsers;
  int? demoStatus;
  int? refCount;
  int? vomsisApiLogsCount;
  dynamic advisorCompanyTitle;
  dynamic advisorLicenseId;
  String? licenseType;
  String? name;
  String? phone;
  String? email;
  int? emailVerified;
  int? showRemainingTime;
  String? registerType;
  dynamic lastLoginType;
  String? referans;
  String? customerLicenseType;
  DateTime? registerLicense;
  dynamic startLicense;
  dynamic endLicense;
  dynamic licenseTerm;
  dynamic maxHareket;
  String? packageName;
  dynamic packagePrice;
  dynamic indirim;
  dynamic kullanilanPuan;
  dynamic currentVopa;
  dynamic not;
  String? lastLoginName;
  dynamic lastLoginDate;
  int? taxpayerCount;
  int? smmKullaniciGrupIzni;
  int? selectedBankCount;
  int? addedBankCount;
  int? activeUserId;
  bool? dbStatus;
  int? mevcutHareket;
  int? toplamMevcutHareket;
  List<Bank> banks;
  List<dynamic> notes;
  List<User> users;
  List<dynamic> companyActivity;
  List<TopCompany> topCompanies;
  List<dynamic> bottomCompanies;
  List<dynamic> logNames;
  List<dynamic> logs;
  List<dynamic> onboardingSteps;
  List<dynamic> completedSteps;
  dynamic lastTransaction;
  List<dynamic> bankStatus;
  List<VirtualPosBankOption> virtualPosBankOptions;
  List<dynamic> virtualPosBanks;
  List<dynamic> pyhsicalPosBanks;
  List<dynamic> virtualPosInfo;
  List<dynamic> sanalPosIslemLoglari;
  List<dynamic> vomsisposBelgeler;
  List<dynamic> entegrasyonBilgileri;
  List<dynamic> entegrasyonIslemLoglari;
  List<FizikselPosBankList> fizikselPosBankList;
  List<EntegrasyonProgramlar> entegrasyonProgramlar;
  List<dynamic> entegrasyonProgramList;
  List<dynamic> fizikselPosBilgileri;
  List<FizikselPosGirisLogBankOption> fizikselPosGirisLogBankOptions;
  List<dynamic> fizikselPosGirisLogs;
  dynamic kycPoint;

  factory Customer.fromJson(Map<String, dynamic> json) => Customer(
        licenseId: json["license_id"],
        code: json["code"],
        status: json["status"],
        maxBanks: json["max_banks"],
        referanceCode: json["referance_code"] ?? '-',
        topCompany: json["top_company"],
        bankaEkle: json["banka_ekle"],
        formDoldur: json["form_doldur"],
        version: json["version"],
        dbHost: json["db_host"],
        adiOrtaklik: json["adi_ortaklik"],
        gibOnay: json["gib_onay"],
        companyTitle: json["company_title"] ?? '-',
        address: json["address"] ?? '-',
        erp: json["erp"],
        taxOffice: json["tax_office"],
        taxNo: json["tax_no"],
        tckn: json["tckn"],
        city: json["city"],
        district: json["district"],
        fizikselPos: json["fiziksel_pos"],
        reklamUrl: json["reklam_url"],
        referer: json["referer"],
        isArchive: json["is_archive"],
        virtualPos: json["virtual_pos"],
        demoVeriSanalPos: json["demo_veri_sanal_pos"],
        faturaUnvan: json["fatura_unvan"],
        faturaAdres: json["fatura_adres"],
        faturaIlce: json["fatura_ilce"],
        faturaIl: json["fatura_il"],
        faturaVergiDairesi: json["fatura_vergi_dairesi"],
        faturaVergiNo: json["fatura_vergi_no"],
        firmaStatus: json["firma_status"],
        maxFirma: json["max_firma"],
        maxUsers: json["max_users"],
        demoStatus: json["demo_status"],
        refCount: json["refCount"],
        vomsisApiLogsCount: json["vomsisApiLogsCount"],
        advisorCompanyTitle: json["advisor_company_title"],
        advisorLicenseId: json["advisor_license_id"],
        licenseType: json["license_type"],
        name: json["name"] ?? '-',
        phone: json["phone"],
        email: json["email"],
        emailVerified: json["email_verified"],
        showRemainingTime: json["show_remaining_time"],
        registerType: json["register_type"],
        lastLoginType: json["last_login_type"],
        referans: json["referans"],
        customerLicenseType: json["customer_license_type"],
        registerLicense: DateTime.parse(json["register_license"]),
        startLicense: json["start_license"],
        endLicense: json["end_license"],
        licenseTerm: json["license_term"],
        maxHareket: json["max_hareket"],
        packageName: json["package_name"],
        packagePrice: json["package_price"],
        indirim: json["indirim"],
        kullanilanPuan: json["kullanilan_puan"],
        currentVopa: json["current_vopa"],
        not: json["not"],
        lastLoginName: json["last_login_name"],
        lastLoginDate: json["last_login_date"],
        taxpayerCount: json["taxpayer_count"],
        smmKullaniciGrupIzni: json["smm_kullanici_grup_izni"],
        selectedBankCount: json["selected_bank_count"],
        addedBankCount: json["added_bank_count"],
        activeUserId: json["active_user_id"],
        dbStatus: json["db_status"],
        mevcutHareket: json["mevcut_hareket"],
        toplamMevcutHareket: json["toplam_mevcut_hareket"],
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
        notes: List<dynamic>.from(json["notes"].map((x) => x)),
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
        companyActivity:
            List<dynamic>.from(json["company_activity"].map((x) => x)),
        topCompanies: List<TopCompany>.from(
            json["top_companies"].map((x) => TopCompany.fromJson(x))),
        bottomCompanies:
            List<dynamic>.from(json["bottom_companies"].map((x) => x)),
        logNames: List<dynamic>.from(json["log_names"].map((x) => x)),
        logs: List<dynamic>.from(json["logs"].map((x) => x)),
        onboardingSteps:
            List<dynamic>.from(json["onboarding_steps"].map((x) => x)),
        completedSteps:
            List<dynamic>.from(json["completed_steps"].map((x) => x)),
        lastTransaction: json["last_transaction"],
        bankStatus: List<dynamic>.from(json["bank_status"].map((x) => x)),
        virtualPosBankOptions: List<VirtualPosBankOption>.from(
            json["virtual_pos_bank_options"]
                .map((x) => VirtualPosBankOption.fromJson(x))),
        virtualPosBanks:
            List<dynamic>.from(json["virtual_pos_banks"].map((x) => x)),
        pyhsicalPosBanks:
            List<dynamic>.from(json["pyhsical_pos_banks"].map((x) => x)),
        virtualPosInfo:
            List<dynamic>.from(json["virtual_pos_info"].map((x) => x)),
        sanalPosIslemLoglari:
            List<dynamic>.from(json["sanal_pos_islem_loglari"].map((x) => x)),
        vomsisposBelgeler:
            List<dynamic>.from(json["vomsispos_belgeler"].map((x) => x)),
        entegrasyonBilgileri:
            List<dynamic>.from(json["entegrasyon_bilgileri"].map((x) => x)),
        entegrasyonIslemLoglari:
            List<dynamic>.from(json["entegrasyon_islem_loglari"].map((x) => x)),
        fizikselPosBankList: List<FizikselPosBankList>.from(
            json["fiziksel_pos_bank_list"]
                .map((x) => FizikselPosBankList.fromJson(x))),
        entegrasyonProgramlar: List<EntegrasyonProgramlar>.from(
            json["entegrasyon_programlar"]
                .map((x) => EntegrasyonProgramlar.fromJson(x))),
        entegrasyonProgramList:
            List<dynamic>.from(json["entegrasyon_program_list"].map((x) => x)),
        fizikselPosBilgileri:
            List<dynamic>.from(json["fiziksel_pos_bilgileri"].map((x) => x)),
        fizikselPosGirisLogBankOptions:
            List<FizikselPosGirisLogBankOption>.from(
                json["fiziksel_pos_giris_log_bank_options"]
                    .map((x) => FizikselPosGirisLogBankOption.fromJson(x))),
        fizikselPosGirisLogs:
            List<dynamic>.from(json["fiziksel_pos_giris_logs"].map((x) => x)),
        kycPoint: json["kyc_point"],
      );

  Map<String, dynamic> toJson() => {
        "license_id": licenseId,
        "code": code,
        "status": status,
        "max_banks": maxBanks,
        "referance_code": referanceCode,
        "top_company": topCompany,
        "banka_ekle": bankaEkle,
        "form_doldur": formDoldur,
        "version": version,
        "db_host": dbHost,
        "adi_ortaklik": adiOrtaklik,
        "gib_onay": gibOnay,
        "company_title": companyTitle,
        "address": address,
        "erp": erp,
        "tax_office": taxOffice,
        "tax_no": taxNo,
        "tckn": tckn,
        "city": city,
        "district": district,
        "fiziksel_pos": fizikselPos,
        "reklam_url": reklamUrl,
        "referer": referer,
        "is_archive": isArchive,
        "virtual_pos": virtualPos,
        "demo_veri_sanal_pos": demoVeriSanalPos,
        "fatura_unvan": faturaUnvan,
        "fatura_adres": faturaAdres,
        "fatura_ilce": faturaIlce,
        "fatura_il": faturaIl,
        "fatura_vergi_dairesi": faturaVergiDairesi,
        "fatura_vergi_no": faturaVergiNo,
        "firma_status": firmaStatus,
        "max_firma": maxFirma,
        "max_users": maxUsers,
        "demo_status": demoStatus,
        "refCount": refCount,
        "vomsisApiLogsCount": vomsisApiLogsCount,
        "advisor_company_title": advisorCompanyTitle,
        "advisor_license_id": advisorLicenseId,
        "license_type": licenseType,
        "name": name,
        "phone": phone,
        "email": email,
        "email_verified": emailVerified,
        "show_remaining_time": showRemainingTime,
        "register_type": registerType,
        "last_login_type": lastLoginType,
        "referans": referans,
        "customer_license_type": customerLicenseType,
        "register_license": registerLicense?.toIso8601String(),
        "start_license": startLicense,
        "end_license": endLicense,
        "license_term": licenseTerm,
        "max_hareket": maxHareket,
        "package_name": packageName,
        "package_price": packagePrice,
        "indirim": indirim,
        "kullanilan_puan": kullanilanPuan,
        "current_vopa": currentVopa,
        "not": not,
        "last_login_name": lastLoginName,
        "last_login_date": lastLoginDate,
        "taxpayer_count": taxpayerCount,
        "smm_kullanici_grup_izni": smmKullaniciGrupIzni,
        "selected_bank_count": selectedBankCount,
        "added_bank_count": addedBankCount,
        "active_user_id": activeUserId,
        "db_status": dbStatus,
        "mevcut_hareket": mevcutHareket,
        "toplam_mevcut_hareket": toplamMevcutHareket,
        "banks": List<dynamic>.from(banks.map((x) => x.toJson())),
        "notes": List<dynamic>.from(notes.map((x) => x)),
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
        "company_activity": List<dynamic>.from(companyActivity.map((x) => x)),
        "top_companies":
            List<dynamic>.from(topCompanies.map((x) => x.toJson())),
        "bottom_companies": List<dynamic>.from(bottomCompanies.map((x) => x)),
        "log_names": List<dynamic>.from(logNames.map((x) => x)),
        "logs": List<dynamic>.from(logs.map((x) => x)),
        "onboarding_steps": List<dynamic>.from(onboardingSteps.map((x) => x)),
        "completed_steps": List<dynamic>.from(completedSteps.map((x) => x)),
        "last_transaction": lastTransaction,
        "bank_status": List<dynamic>.from(bankStatus.map((x) => x)),
        "virtual_pos_bank_options":
            List<dynamic>.from(virtualPosBankOptions.map((x) => x.toJson())),
        "virtual_pos_banks": List<dynamic>.from(virtualPosBanks.map((x) => x)),
        "pyhsical_pos_banks":
            List<dynamic>.from(pyhsicalPosBanks.map((x) => x)),
        "virtual_pos_info": List<dynamic>.from(virtualPosInfo.map((x) => x)),
        "sanal_pos_islem_loglari":
            List<dynamic>.from(sanalPosIslemLoglari.map((x) => x)),
        "vomsispos_belgeler":
            List<dynamic>.from(vomsisposBelgeler.map((x) => x)),
        "entegrasyon_bilgileri":
            List<dynamic>.from(entegrasyonBilgileri.map((x) => x)),
        "entegrasyon_islem_loglari":
            List<dynamic>.from(entegrasyonIslemLoglari.map((x) => x)),
        "fiziksel_pos_bank_list":
            List<dynamic>.from(fizikselPosBankList.map((x) => x.toJson())),
        "entegrasyon_programlar":
            List<dynamic>.from(entegrasyonProgramlar.map((x) => x.toJson())),
        "entegrasyon_program_list":
            List<dynamic>.from(entegrasyonProgramList.map((x) => x)),
        "fiziksel_pos_bilgileri":
            List<dynamic>.from(fizikselPosBilgileri.map((x) => x)),
        "fiziksel_pos_giris_log_bank_options": List<dynamic>.from(
            fizikselPosGirisLogBankOptions.map((x) => x.toJson())),
        "fiziksel_pos_giris_logs":
            List<dynamic>.from(fizikselPosGirisLogs.map((x) => x)),
        "kyc_point": kycPoint,
      };
}

class Bank {
  Bank({
    required this.licenseId,
    required this.bankName,
    required this.status,
    required this.hasConnection,
  });

  int licenseId;
  String bankName;
  int status;
  bool hasConnection;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
        licenseId: json["license_id"],
        bankName: json["bank_name"],
        status: json["status"],
        hasConnection: json["has_connection"],
      );

  Map<String, dynamic> toJson() => {
        "license_id": licenseId,
        "bank_name": bankName,
        "status": status,
        "has_connection": hasConnection,
      };
}

class EntegrasyonProgramlar {
  EntegrasyonProgramlar({
    required this.name,
    required this.title,
    required this.value,
    required this.text,
  });

  int name;
  String title;
  String value;
  String text;

  factory EntegrasyonProgramlar.fromJson(Map<String, dynamic> json) =>
      EntegrasyonProgramlar(
        name: json["name"],
        title: json["title"],
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "title": title,
        "value": value,
        "text": text,
      };
}

class FizikselPosBankList {
  FizikselPosBankList({
    required this.bankId,
    required this.bankName,
    required this.bankTitle,
    required this.value,
    required this.text,
  });

  int bankId;
  String bankName;
  String bankTitle;
  String value;
  String text;

  factory FizikselPosBankList.fromJson(Map<String, dynamic> json) =>
      FizikselPosBankList(
        bankId: json["bank_id"],
        bankName: json["bank_name"],
        bankTitle: json["bank_title"],
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "bank_id": bankId,
        "bank_name": bankName,
        "bank_title": bankTitle,
        "value": value,
        "text": text,
      };
}

class FizikselPosGirisLogBankOption {
  FizikselPosGirisLogBankOption({
    required this.bankName,
  });

  String bankName;

  factory FizikselPosGirisLogBankOption.fromJson(Map<String, dynamic> json) =>
      FizikselPosGirisLogBankOption(
        bankName: json["bank_name"],
      );

  Map<String, dynamic> toJson() => {
        "bank_name": bankName,
      };
}

class TopCompany {
  TopCompany({
    required this.id,
    required this.companyTitle,
    required this.code,
    required this.topCompany,
    required this.addedBankCount,
    required this.selectedBankCount,
  });

  int id;
  String companyTitle;
  String code;
  dynamic topCompany;
  int addedBankCount;
  int selectedBankCount;

  factory TopCompany.fromJson(Map<String, dynamic> json) => TopCompany(
        id: json["id"],
        companyTitle: json["company_title"],
        code: json["code"],
        topCompany: json["top_company"],
        addedBankCount: json["added_bank_count"],
        selectedBankCount: json["selected_bank_count"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "company_title": companyTitle,
        "code": code,
        "top_company": topCompany,
        "added_bank_count": addedBankCount,
        "selected_bank_count": selectedBankCount,
      };
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.online,
    required this.lastActivity,
    required this.isAdmin,
    required this.hasLocked,
    required this.verificationType,
    required this.verificationDate,
    required this.verificationCode,
    required this.emailVerified,
  });

  int? id;
  String? name;
  String? email;
  String? phone;
  String? online;
  dynamic lastActivity;
  int? isAdmin;
  int? hasLocked;
  dynamic verificationType;
  dynamic verificationDate;
  dynamic verificationCode;
  int? emailVerified;

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        online: json["online"],
        lastActivity: json["last_activity"] ?? '-',
        isAdmin: json["is_admin"],
        hasLocked: json["hasLocked"],
        verificationType: json["verification_type"],
        verificationDate: json["verification_date"],
        verificationCode: json["verification_code"],
        emailVerified: json["email_verified"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "online": online,
        "last_activity": lastActivity,
        "is_admin": isAdmin,
        "hasLocked": hasLocked,
        "verification_type": verificationType,
        "verification_date": verificationDate,
        "verification_code": verificationCode,
        "email_verified": emailVerified,
      };
}

class VirtualPosBankOption {
  VirtualPosBankOption({
    required this.id,
    required this.bankName,
    required this.value,
    required this.text,
  });

  int id;
  String bankName;
  String value;
  String text;

  factory VirtualPosBankOption.fromJson(Map<String, dynamic> json) =>
      VirtualPosBankOption(
        id: json["id"],
        bankName: json["bank_name"],
        value: json["value"],
        text: json["text"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "bank_name": bankName,
        "value": value,
        "text": text,
      };
}
