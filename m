Return-Path: <SRS0=9WFx=CL=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC8F3C433E2
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:38:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9065A207EA
	for <linux-ide@archiver.kernel.org>; Wed,  2 Sep 2020 07:38:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="BwSBLBRw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726446AbgIBHiQ (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:38:16 -0400
Received: from mail-eopbgr150082.outbound.protection.outlook.com ([40.107.15.82]:30150
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726144AbgIBHiN (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 2 Sep 2020 03:38:13 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZJxq38cm1Eu9GCmGM0+eBmJ0oEUyR27NL1H0PIWVosx/yrsWIGn3OqQLzklBU/5fgd21IvPORzgJ6OV1LxY1f5WtDqMm8c4DPK6l7ZA6k6AgvJBh37wNjHN70dxzfbgV1RJ5yKYRy5P25VbEPGg/hT1NU17yff7z+GXgQMluYm/llQzkOTa59i6b1RXdcIefpKUvhY9fS/YKBJH3Bmo+k0/2tOazQYyCi+7fR/BVyXTb0ywbFqlvfWJXt+o/6g1FI/8VrvWQIE5aWgg3RH1RTLLRTIrlElLAQ7NKWUcKJMueWyoGEsJ9YD5WL83Tx1ehPoHMS4+3BEtNpWMyS3bUsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWMswocfRyzIHpknS4KEEU/9D5ELXptk/bt5N7Sw/eE=;
 b=Db5is+bEOnOTDKCOg3Qfb5AqCAMKWutRJJ0knc1gmF1SCQD6XjZvFWamMpfuraMQtcI5BChtHkTkeIv7Mx8z9S81hdcDYEyV/ybw5fxtlwf7GkFLeMehj0/jZujj7t7T4SW3cwooHXChdFBppxPrG6n9RbkTEz6iboA5PUQw2n/zQ83H3nR2b9dC6D0o3LENxHw+KM1SNog5cqBNsQeGwyAV6knamJr/10CAd5T2+yddhBvTPbylcbivkej7lVcbEoa2r7BtLHOT+kp72u6SloLeHeLg38Q9oLA6wH+vlb1xoEyMaS9c9rRKjNN5GAV4022HADZleazdakqpkEQEiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SWMswocfRyzIHpknS4KEEU/9D5ELXptk/bt5N7Sw/eE=;
 b=BwSBLBRwEEarfcVg13biIINzwBp7ej/69DgCLF+Txh1gEZ6nB0qIXjNvR8YEF4pPnMAR2aUGYAXKfxeDH0quPs2maeyYW/DIwKxZzKmsyNN5yOpifXWqqRheLhqmazqI2GWxDZJuc02ltxUOVtRjPH6hEhKrdPiHygZjJ6LmxGg=
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com (2603:10a6:10:c4::22)
 by DBBPR04MB6090.eurprd04.prod.outlook.com (2603:10a6:10:c4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3326.23; Wed, 2 Sep
 2020 07:38:08 +0000
Received: from DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::84ae:b125:a2d9:a302]) by DBBPR04MB6090.eurprd04.prod.outlook.com
 ([fe80::84ae:b125:a2d9:a302%6]) with mapi id 15.20.3326.025; Wed, 2 Sep 2020
 07:38:08 +0000
From:   Andy Tang <andy.tang@nxp.com>
To:     "axboe@kernel.dk" <axboe@kernel.dk>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Udit Kumar <udit.kumar@nxp.com>
Subject: RE: [PATCH] ahci: qoriq: enable acpi support in qoriq ahci driver
Thread-Topic: [PATCH] ahci: qoriq: enable acpi support in qoriq ahci driver
Thread-Index: AQHWdHCC26gfJwrS7UWFZen0Rx+fYqlVDtnw
Date:   Wed, 2 Sep 2020 07:38:08 +0000
Message-ID: <DBBPR04MB60900C1FC4AF99E7C86E17BFF32F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
References: <20200817082204.13523-1-andy.tang@nxp.com>
In-Reply-To: <20200817082204.13523-1-andy.tang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: kernel.dk; dkim=none (message not signed)
 header.d=none;kernel.dk; dmarc=none action=none header.from=nxp.com;
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 826f9c9d-795c-40ff-2456-08d84f13235a
x-ms-traffictypediagnostic: DBBPR04MB6090:
x-microsoft-antispam-prvs: <DBBPR04MB60904C2B359F3F676AD933E4F32F0@DBBPR04MB6090.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PNxnHYTTdwGWAJ9U3vqSTIFY21krzAFqL7U2Nv8IPTH7q9UtId/iEsioZM9cyOVJYprGmaAdVMV0+2F32gpcw7dJyL+K3QZ1tqF26WgW6GhwuB3uUdSNQmMdQBnkLybfhO0ejmNc7U8tdJ5QAAle3XOd5SEDXwMgpUk/AlwshVOIL78DYyW113VEDU24JiiGISF3EgLb0YpV1uCRvC7pSjuUfpOlOWMrG2G0nRUV/+k+QY5Qv3wLAwjOecjw/hwOPNYxfnRAJm02F92+1dTtmqkhDQfvwMqpR3yllDI+eMJFTmvvxxOmX101iliQbqufG9CdLwnL1NW1v5oO22qf0g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB6090.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(39860400002)(346002)(396003)(136003)(376002)(366004)(55016002)(66946007)(52536014)(4326008)(186003)(6506007)(8936002)(66446008)(26005)(71200400001)(53546011)(44832011)(2906002)(5660300002)(64756008)(6916009)(478600001)(83380400001)(66556008)(66476007)(54906003)(9686003)(316002)(8676002)(33656002)(76116006)(7696005)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: rDxgLYOSQ8fJohfLn7t1RFoLQffhgXE0umAJkuZ7JIiTmW61CbBsabJ+JSytdy74r1CbduiCNVWTIYxTEf7W7Hv+NRXal00xPvQX1q9GED3f6Mn9bL0x0BtzwQOafRkYe7RlhySUHTkujBBmk1dBZTiPSSUW4zX8ciKpds9Qvla4tqlJmItOP4Yrz/gzz4t5KNLn+Ff/5M3EoY25gvPNHZOpuL87qxARPGk69CBsGneynCzcCznLfgbxE+uuqspMNkdJczwZC5dgc5TjIXLVX7hp4FR0Pl32tr8woqOdOhogbLmLoNDeWFEj0yucKwXj3brVV84jP4ICU4rt1WWnOKuev7VaETvDJa+EbwlHD7MQU0DI8Ijn2WvdSD3K+NkjdQkFwyRnEHN0Hla79C2dbf3c4nurIwF2X6NT4GDH7EFkMH7+nbuLwlP4eMvqUmyzMaEm4fth80X168BmvhoaxebLOuX4ElMCHe2nFlqnNuPLXiAIwU0Cvzmb1GQOnhDNCgtAAr42T3QgS9QeFhf6TpniAdA7Pfo6dFUHcpXHPnIi5Z5iDCZZAT12bBPTRGMO0fKYsG53r5wdSrtE1Iau76e0J2z1zuYGkoxXGIWUB2RhiGclH1vqF1bQUnPtKzHTUoZXkSy8hSpDmDjKRIIlcQ==
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB6090.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 826f9c9d-795c-40ff-2456-08d84f13235a
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2020 07:38:08.7079
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vK2lF81SKGG3LKeVYD8vMSqbDThpFrhFVqJP8KZtb/v6sZTsTQbjdsj07KygPfRdK5+RfK5mlJuMShSJNZ38xQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB6090
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

SGkgQXhib2UsDQoNClBsZWFzZSB0YWtlIHNvbWUgdGltZXMgcmV2aWV3aW5nIHRoaXMgcGF0Y2gu
DQoNClRoYW5rcywNCkFuZHkNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9t
OiBhbmR5LnRhbmdAbnhwLmNvbSA8YW5keS50YW5nQG54cC5jb20+DQo+IFNlbnQ6IDIwMjDE6jjU
wjE3yNUgMTY6MjINCj4gVG86IGF4Ym9lQGtlcm5lbC5kaw0KPiBDYzogbGludXgtaWRlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgQW5keSBUYW5nDQo+IDxh
bmR5LnRhbmdAbnhwLmNvbT47IFVkaXQgS3VtYXIgPHVkaXQua3VtYXJAbnhwLmNvbT4NCj4gU3Vi
amVjdDogW1BBVENIXSBhaGNpOiBxb3JpcTogZW5hYmxlIGFjcGkgc3VwcG9ydCBpbiBxb3JpcSBh
aGNpIGRyaXZlcg0KPiANCj4gRnJvbTogWXVhbnRpYW4gVGFuZyA8YW5keS50YW5nQG54cC5jb20+
DQo+IA0KPiBUaGlzIHBhdGNoIGVuYWJsZXMgQUNQSSBzdXBwb3J0IGluIHFvcmlxIGFoY2kgZHJp
dmVyLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogVWRpdCBLdW1hciA8dWRpdC5rdW1hckBueHAuY29t
Pg0KPiBTaWduZWQtb2ZmLWJ5OiBZdWFudGlhbiBUYW5nIDxhbmR5LnRhbmdAbnhwLmNvbT4NCj4g
LS0tDQo+ICBkcml2ZXJzL2F0YS9haGNpX3FvcmlxLmMgfCAyMCArKysrKysrKysrKysrKysrKy0t
LQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDE3IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvYWhjaV9xb3JpcS5jIGIvZHJpdmVycy9hdGEv
YWhjaV9xb3JpcS5jIGluZGV4DQo+IGEzMzAzMDdkMzIwMS4uNWI0NmZjOWFlYjRhIDEwMDY0NA0K
PiAtLS0gYS9kcml2ZXJzL2F0YS9haGNpX3FvcmlxLmMNCj4gKysrIGIvZHJpdmVycy9hdGEvYWhj
aV9xb3JpcS5jDQo+IEBAIC02LDYgKzYsNyBAQA0KPiAgICogICBUYW5nIFl1YW50aWFuIDxZdWFu
dGlhbi5UYW5nQGZyZWVzY2FsZS5jb20+DQo+ICAgKi8NCj4gDQo+ICsjaW5jbHVkZSA8bGludXgv
YWNwaS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L21vZHVsZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtLmg+DQo+IEBAIC04MCw2ICs4MSwxMiBA
QCBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBhaGNpX3FvcmlxX29mX21hdGNoW10g
PQ0KPiB7ICB9OyAgTU9EVUxFX0RFVklDRV9UQUJMRShvZiwgYWhjaV9xb3JpcV9vZl9tYXRjaCk7
DQo+IA0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCBhaGNpX3FvcmlxX2Fj
cGlfbWF0Y2hbXSA9IHsNCj4gKwl7Ik5YUDAwMDQiLCAuZHJpdmVyX2RhdGEgPSAoa2VybmVsX3Vs
b25nX3QpQUhDSV9MWDIxNjBBfSwNCj4gKwl7IH0NCj4gK307DQo+ICtNT0RVTEVfREVWSUNFX1RB
QkxFKGFjcGksIGFoY2lfcW9yaXFfYWNwaV9tYXRjaCk7DQo+ICsNCj4gIHN0YXRpYyBpbnQgYWhj
aV9xb3JpcV9oYXJkcmVzZXQoc3RydWN0IGF0YV9saW5rICpsaW5rLCB1bnNpZ25lZCBpbnQgKmNs
YXNzLA0KPiAgCQkJICB1bnNpZ25lZCBsb25nIGRlYWRsaW5lKQ0KPiAgew0KPiBAQCAtMjU1LDYg
KzI2Miw3IEBAIHN0YXRpYyBpbnQgYWhjaV9xb3JpcV9waHlfaW5pdChzdHJ1Y3QgYWhjaV9ob3N0
X3ByaXYNCj4gKmhwcml2KSAgc3RhdGljIGludCBhaGNpX3FvcmlxX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UgKnBkZXYpICB7DQo+ICAJc3RydWN0IGRldmljZV9ub2RlICpucCA9IHBkZXYt
PmRldi5vZl9ub2RlOw0KPiArCWNvbnN0IHN0cnVjdCBhY3BpX2RldmljZV9pZCAqYWNwaV9pZDsN
Cj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiAgCXN0cnVjdCBhaGNpX2hv
c3RfcHJpdiAqaHByaXY7DQo+ICAJc3RydWN0IGFoY2lfcW9yaXFfcHJpdiAqcW9yaXFfcHJpdjsN
Cj4gQEAgLTI2NywxNCArMjc1LDE4IEBAIHN0YXRpYyBpbnQgYWhjaV9xb3JpcV9wcm9iZShzdHJ1
Y3QgcGxhdGZvcm1fZGV2aWNlDQo+ICpwZGV2KQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihocHJpdik7
DQo+IA0KPiAgCW9mX2lkID0gb2ZfbWF0Y2hfbm9kZShhaGNpX3FvcmlxX29mX21hdGNoLCBucCk7
DQo+IC0JaWYgKCFvZl9pZCkNCj4gKwlhY3BpX2lkID0gYWNwaV9tYXRjaF9kZXZpY2UoYWhjaV9x
b3JpcV9hY3BpX21hdGNoLCAmcGRldi0+ZGV2KTsNCj4gKwlpZiAoIShvZl9pZCB8fCBhY3BpX2lk
KSkNCj4gIAkJcmV0dXJuIC1FTk9ERVY7DQo+IA0KPiAgCXFvcmlxX3ByaXYgPSBkZXZtX2t6YWxs
b2MoZGV2LCBzaXplb2YoKnFvcmlxX3ByaXYpLCBHRlBfS0VSTkVMKTsNCj4gIAlpZiAoIXFvcmlx
X3ByaXYpDQo+ICAJCXJldHVybiAtRU5PTUVNOw0KPiANCj4gLQlxb3JpcV9wcml2LT50eXBlID0g
KGVudW0gYWhjaV9xb3JpcV90eXBlKW9mX2lkLT5kYXRhOw0KPiArCWlmIChvZl9pZCkNCj4gKwkJ
cW9yaXFfcHJpdi0+dHlwZSA9IChlbnVtIGFoY2lfcW9yaXFfdHlwZSlvZl9pZC0+ZGF0YTsNCj4g
KwllbHNlDQo+ICsJCXFvcmlxX3ByaXYtPnR5cGUgPSAoZW51bSBhaGNpX3FvcmlxX3R5cGUpYWNw
aV9pZC0+ZHJpdmVyX2RhdGE7DQo+IA0KPiAgCWlmICh1bmxpa2VseSghZWNjX2luaXRpYWxpemVk
KSkgew0KPiAgCQlyZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYsDQo+IEBA
IC0yODgsNyArMzAwLDggQEAgc3RhdGljIGludCBhaGNpX3FvcmlxX3Byb2JlKHN0cnVjdCBwbGF0
Zm9ybV9kZXZpY2UNCj4gKnBkZXYpDQo+ICAJCX0NCj4gIAl9DQo+IA0KPiAtCXFvcmlxX3ByaXYt
PmlzX2RtYWNvaGVyZW50ID0gb2ZfZG1hX2lzX2NvaGVyZW50KG5wKTsNCj4gKwlpZiAoZGV2aWNl
X2dldF9kbWFfYXR0cigmcGRldi0+ZGV2KSA9PSBERVZfRE1BX0NPSEVSRU5UKQ0KPiArCQlxb3Jp
cV9wcml2LT5pc19kbWFjb2hlcmVudCA9IHRydWU7DQo+IA0KPiAgCXJjID0gYWhjaV9wbGF0Zm9y
bV9lbmFibGVfcmVzb3VyY2VzKGhwcml2KTsNCj4gIAlpZiAocmMpDQo+IEBAIC0zNTQsNiArMzY3
LDcgQEAgc3RhdGljIHN0cnVjdCBwbGF0Zm9ybV9kcml2ZXIgYWhjaV9xb3JpcV9kcml2ZXIgPSB7
DQo+ICAJLmRyaXZlciA9IHsNCj4gIAkJLm5hbWUgPSBEUlZfTkFNRSwNCj4gIAkJLm9mX21hdGNo
X3RhYmxlID0gYWhjaV9xb3JpcV9vZl9tYXRjaCwNCj4gKwkJLmFjcGlfbWF0Y2hfdGFibGUgPSBh
aGNpX3FvcmlxX2FjcGlfbWF0Y2gsDQo+ICAJCS5wbSA9ICZhaGNpX3FvcmlxX3BtX29wcywNCj4g
IAl9LA0KPiAgfTsNCj4gLS0NCj4gMi4xNy4xDQoNCg==
