class DomainName {
    List<Domain>? domains;
    int ?total;
    String? time;
    dynamic nextPage;

    DomainName({
        this.domains,
        this.total,
        this.time,
        this.nextPage,
    });

    factory DomainName.fromJson(Map<String, dynamic> json) => DomainName(
        domains: List<Domain>.from(json["domains"].map((x) => Domain.fromJson(x))),
        total: json["total"],
        time: json["time"],
        nextPage: json["next_page"],
    );

    Map<String, dynamic> toJson() => {
        "domains": List<dynamic>.from(domains!.map((x) => x.toJson())),
        "total": total,
        "time": time,
        "next_page": nextPage,
    };
}

class Domain {
    String? domain;
    DateTime? createDate;
    DateTime ?updateDate;
    dynamic country;
    String? isDead;
    dynamic a;
    dynamic ns;
    dynamic cname;
    dynamic mx;
    dynamic txt;

    Domain({
        this.domain,
        this.createDate,
        this.updateDate,
        this.country,
        this.isDead,
        this.a,
        this.ns,
        this.cname,
        this.mx,
        this.txt,
    });

    factory Domain.fromJson(Map<String, dynamic> json) => Domain(
        domain: json["domain"],
        createDate: DateTime.parse(json["create_date"]),
        updateDate: DateTime.parse(json["update_date"]),
        country: json["country"],
        isDead: json["isDead"],
        a: json["A"],
        ns: json["NS"],
        cname: json["CNAME"],
        mx: json["MX"],
        txt: json["TXT"],
    );

    Map<String, dynamic> toJson() => {
        "domain": domain,
        "create_date": createDate?.toIso8601String(),
        "update_date": updateDate?.toIso8601String(),
        "country": country,
        "isDead": isDead,
        "A": a,
        "NS": ns,
        "CNAME": cname,
        "MX": mx,
        "TXT": txt,
    };
}
