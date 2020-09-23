Return-Path: <SRS0=PpZ6=DA=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ED89C2D0A8
	for <linux-ide@archiver.kernel.org>; Wed, 23 Sep 2020 05:45:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0613F21D91
	for <linux-ide@archiver.kernel.org>; Wed, 23 Sep 2020 05:45:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=xilinx.onmicrosoft.com header.i=@xilinx.onmicrosoft.com header.b="ftoxnAVU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727075AbgIWFpI (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Wed, 23 Sep 2020 01:45:08 -0400
Received: from mail-dm6nam10on2049.outbound.protection.outlook.com ([40.107.93.49]:56130
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726883AbgIWFpI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
        Wed, 23 Sep 2020 01:45:08 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MAZ4DvxM+nkQ2VH1HGUQQ7Rt44ZoBiMOtE5f5/va6rty0G+Za8ah7Wph1tBJv5qUr1vd6P1Y05DbKYv7m7CG2YKXJrdiywiyT+rTDmIbvwFuyzlqZ1KpHWhTtBBPwlz+wg4MLjB7mqRmcEpajC5X7CNGdyDWRI+zqf8a46QJxiKNSS7jpbs8wQUOjbXNWsK8eKjdK3nfg90DNCh6chx0e69rtSS42lu4Yfn9CpKREmrmh0Jt9T5VT0ku+abPbRJrFVMnQNQcYwzvnvLv9D2WJZPrNzydO0/f6hf1eIAjt6WaFBmfoaef9oPW3EOSZyGRUnVh5cnCLW0t3p3JnOuPVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBCKli/vm0cU5GRifaXTltvuN+2fBk4wOcDVHEncIxI=;
 b=WetHtGfBwYyGrww0ITIhTxocC48ct/ssUQGdR4sqIQimb97Jp0dpKVXzjXfj/aumnE8dvECayJ9JcQA8t0qaOEDciWTADCvFj+uasuouD7rQCl/82/h85sFw1Rxx+sPdtuE+l0YDLD4O1P76OGlWWAvRFOCPAmID8dkVyz/Eu9ZbfP0Bi6uEyyx4NB2XIIh6BWZQD7sbaCAPEU2Dnft+fcDtMsRCYuCiKqah3jgRpIJbJ2IBuHT4hC1XLcR/PD82tbyEgPp3Km6qzqp/cBDGTjFtlSp0OoeVd/WiF25pKlKqeZCIEmn55/R+3heW19STgpuubIP5ncEQ7EQhXmLD9Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=xilinx.com; dmarc=pass action=none header.from=xilinx.com;
 dkim=pass header.d=xilinx.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=xilinx.onmicrosoft.com; s=selector2-xilinx-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBCKli/vm0cU5GRifaXTltvuN+2fBk4wOcDVHEncIxI=;
 b=ftoxnAVUeSKsR0/VQJwiuz12wYPc8BRqaLj8coaXUPz0uhhr6QH2UtDmKABvhnlrCgB1mc3QNJiJS8U8iGVqrWJdk8IC5Qo3zVjiNd61iW1tdqKj+h0ADO2iVDOE4Lcg0Ioyv9eX3xqitk7t/UZLvuk7gk8E1HpMYQZfp6Ua0Ng=
Received: from BYAPR02MB3975.namprd02.prod.outlook.com (2603:10b6:a02:f8::31)
 by BYAPR02MB5256.namprd02.prod.outlook.com (2603:10b6:a03:65::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3391.19; Wed, 23 Sep
 2020 05:45:00 +0000
Received: from BYAPR02MB3975.namprd02.prod.outlook.com
 ([fe80::c421:9f2b:6239:7d17]) by BYAPR02MB3975.namprd02.prod.outlook.com
 ([fe80::c421:9f2b:6239:7d17%6]) with mapi id 15.20.3412.020; Wed, 23 Sep 2020
 05:45:00 +0000
From:   Piyush Mehta <piyushm@xilinx.com>
To:     Philipp Zabel <p.zabel@pengutronix.de>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        git <git@xilinx.com>, Srinivas Goud <sgoud@xilinx.com>,
        Michal Simek <michals@xilinx.com>
Subject: RE: [PATCH V2 2/2] ata: ahci: ceva: Update the driver to support
 xilinx GT phy
Thread-Topic: [PATCH V2 2/2] ata: ahci: ceva: Update the driver to support
 xilinx GT phy
Thread-Index: AQHWkMl0JTK/9GlqykCOtybTZwKdD6l0j9cAgAEntFA=
Date:   Wed, 23 Sep 2020 05:45:00 +0000
Message-ID: <BYAPR02MB3975991D20515D8F0D3898BAD4380@BYAPR02MB3975.namprd02.prod.outlook.com>
References: <1600769713-944-1-git-send-email-piyush.mehta@xilinx.com>
         <1600769713-944-3-git-send-email-piyush.mehta@xilinx.com>
 <cf79a03117f4886dd91a624fd0081222ae87fea0.camel@pengutronix.de>
In-Reply-To: <cf79a03117f4886dd91a624fd0081222ae87fea0.camel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-Auto-Response-Suppress: DR, RN, NRN, OOF, AutoReply
X-MS-TNEF-Correlator: 
authentication-results: pengutronix.de; dkim=none (message not signed)
 header.d=none;pengutronix.de; dmarc=none action=none header.from=xilinx.com;
x-originating-ip: [116.74.241.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: dc146124-5e1b-461e-6b12-08d85f83cfe8
x-ms-traffictypediagnostic: BYAPR02MB5256:
x-ld-processed: 657af505-d5df-48d0-8300-c31994686c5c,ExtAddr
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <BYAPR02MB525657673E5042C9936DBBF0D4380@BYAPR02MB5256.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8273;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: a9INKtBdl/jvXE3DHImkIsBdSgnnhiljuqW/8j3q7OQQb+y0GSXn7b2606h4C6D5Ir+EUubwtjAXo708CE8FtM6Uz41psefE84UimKwVBd6OgyK41DYIdJ7cm80RGIINTVKU2aCf7bD7aOvNDSL8C3MQEOBMBumMelIQhLtzU8aVw+R+KEOXy5JhdXw7dCBnvD4e1YGwoCozgQwxSgbP/FQpjW9BaMzil98erdTwY1zaXhJWaeyBFb8jAwOraKBHjhqs0zCrvu7w8b3vOeOeUsfpENOoMaDBFfDKF/yRfP8GOeVqu7PLMTNQ3zKcViNYYPDvqlwYIw6/2DNw1g7O0+VfsoYkkrOv8GtdHF8hiHqr2RrwJFF1126UQ0ulM/Hk
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR02MB3975.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(396003)(39850400004)(376002)(136003)(346002)(366004)(186003)(5660300002)(71200400001)(83380400001)(110136005)(26005)(4326008)(107886003)(6506007)(9686003)(55016002)(7696005)(86362001)(316002)(2906002)(64756008)(66556008)(66476007)(66946007)(8936002)(33656002)(76116006)(53546011)(66446008)(52536014)(55236004)(54906003)(478600001)(15650500001)(8676002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata: LHzNxIqQWrqh907a1pshh776FTg/INQ/U8yQylWK0AEHtm00Q+uMG0ZhzO+8YCanjTNF65+/u1xN+9TTFQrF3LuAXtOB/fF0ohFJJCcDip8m4gcyj/34cp6jwhx8f5SYkafU0S25dP75ex7bTMI1lXDONMJUGqaVigY2TelR6vjfxO6rsANbIY5lW7ryc70Ak6T56wleiGUTeWOtKw6gWyUCwyoMx7eMa+sq3kc0l+HhyhWMLoqQP7F7pzqX2mwPGzbVYC+bSbtF8EoSmZLhOZzbmOgGzzHjEAdCSP7Nl7asOJp4exKjcL/wFqfrT08mFlGqlgHCx0G6NYWvkbDCL6taZXCItOLnEnKWZhxsTOsMJzuHUECQn9JXeUzdScBzvdJVs0Z/1RIHpV+CWHojw9zjNtQL11bkxP0aTCC2rmsfjHvFNokIfSKaQ/5KvwiNqn+OTqF5u+kvNEZxkEg2Xt/IPIWl1+6fOCCSCbyUWiGspR5RtVVfmqcJx0cAIsNwhfwbma12g27Kj6M6iNaki5wdbC/fF2EkZpuCZAqqBk2/RJT+yNDgv6H4yX5fMAaG9SBWmtJXQ4T8VEc5Tw0Ug9oOMPvGbbHqbFkRo2TStRRxn4AP8arnJPqx3TjgvgMcyM8JvpObJcnu6eodMa/hEQ==
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: xilinx.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR02MB3975.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dc146124-5e1b-461e-6b12-08d85f83cfe8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Sep 2020 05:45:00.4546
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 657af505-d5df-48d0-8300-c31994686c5c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l7YfhEq/p/MTIbJ9rZRhH+jqFaKPe7lTMK+sGJmfbIepmWYBjQrisG1QvsFmPuMl5GxM4mskHQSKAc1NRkYr+Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR02MB5256
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

SGVsbG8gUGhpbGlwcCwNCg0KVGhhbmtzIGZvciByZXZpZXcuDQoNClJlZ2FyZHMsDQpQaXl1c2gg
TWVodGENCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFBoaWxpcHAgWmFiZWwg
PHAuemFiZWxAcGVuZ3V0cm9uaXguZGU+IA0KU2VudDogVHVlc2RheSwgU2VwdGVtYmVyIDIyLCAy
MDIwIDU6MzYgUE0NClRvOiBQaXl1c2ggTWVodGEgPHBpeXVzaG1AeGlsaW54LmNvbT47IGF4Ym9l
QGtlcm5lbC5kazsgcm9iaCtkdEBrZXJuZWwub3JnDQpDYzogbGludXgtaWRlQHZnZXIua2VybmVs
Lm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5l
bC5vcmc7IGdpdCA8Z2l0QHhpbGlueC5jb20+OyBTcmluaXZhcyBHb3VkIDxzZ291ZEB4aWxpbngu
Y29tPjsgTWljaGFsIFNpbWVrIDxtaWNoYWxzQHhpbGlueC5jb20+DQpTdWJqZWN0OiBSZTogW1BB
VENIIFYyIDIvMl0gYXRhOiBhaGNpOiBjZXZhOiBVcGRhdGUgdGhlIGRyaXZlciB0byBzdXBwb3J0
IHhpbGlueCBHVCBwaHkNCg0KT24gVHVlLCAyMDIwLTA5LTIyIGF0IDE1OjQ1ICswNTMwLCBQaXl1
c2ggTWVodGEgd3JvdGU6DQo+IFNBVEEgY29udHJvbGxlciB1c2VkIGluIFhpbGlueCBaeW5xTVAg
cGxhdGZvcm0gdXNlcyB4aWxpbnggR1QgcGh5IA0KPiB3aGljaCBoYXMgNCBHVCBsYW5lcyBhbmQg
Y2FuIHVzZWQgYnkgNCBwZXJpcGhlcmFscyBhdCBhIHRpbWUuDQo+IFNBVEEgY29udHJvbGxlciB1
c2VzIDEgR1QgcGh5IGxhbmUgYW1vbmcgdGhlIDQgR1QgbGFuZXMuIFRvIGNvbmZpZ3VyZSANCj4g
dGhlIEdUIGxhbmUgZm9yIFNBVEEgY29udHJvbGxlciwgdGhlIGJlbG93IHNlcXVlbmNlIGlzIGV4
cGVjdGVkLg0KPiANCj4gMS4gQXNzZXJ0IHRoZSBTQVRBIGNvbnRyb2xsZXIgcmVzZXQuDQo+IDIu
IENvbmZpZ3VyZSB0aGUgeGlsaW54IEdUIHBoeSBsYW5lIGZvciBTQVRBIGNvbnRyb2xsZXIgKHBo
eV9pbml0KS4NCj4gMy4gRGUtYXNzZXJ0IHRoZSBTQVRBIGNvbnRyb2xsZXIgcmVzZXQuDQo+IDQu
IFdhaXQgZm9yIFBMTCBvZiB0aGUgR1QgbGFuZSB1c2VkIGJ5IFNBVEEgdG8gYmUgbG9ja2VkIChw
aHlfcG93ZXJfb24pLg0KPiANCj4gVGhlIGFoY2lfcGxhdGZvcm1fZW5hYmxlX3Jlc291cmNlcygp
IGJ5IGRlZmF1bHQgZG9lcyB0aGUgcGh5X2luaXQoKSANCj4gYW5kIHBoeV9wb3dlcl9vbigpIGJ1
dCB0aGUgZGVmYXVsdCBzZXF1ZW5jZSBkb2Vzbid0IHdvcmsgd2l0aCBYaWxpbnggDQo+IHBsYXRm
b3Jtcy4gQmVjYXVzZSBvZiB0aGlzIHJlYXNvbiwgdXBkYXRlZCB0aGUgZHJpdmVyIHRvIHN1cHBv
cnQgdGhlIA0KPiBuZXcgc2VxdWVuY2UuDQo+IA0KPiBBZGRlZCBpc19yc3RfY3RybCBmbGFnLCBm
b3IgYmFja3dhcmQgY29tcGF0aWJpbGl0eSB3aXRoIHRoZSBvbGRlciANCj4gc2VxdWVuY2UuIElm
IHRoZSByZXNldCBjb250cm9sbGVyIGlzIG5vdCBhdmFpbGFibGUsIHRoZW4gdGhlIFNBVEEgDQo+
IGNvbnRyb2xsZXIgd2lsbCBjb25maWd1cmUgd2l0aCB0aGUgb2xkZXIgc2VxdWVuY2VzLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogUGl5dXNoIE1laHRhIDxwaXl1c2gubWVodGFAeGlsaW54LmNvbT4N
Cj4gLS0tDQo+ICBkcml2ZXJzL2F0YS9haGNpX2NldmEuYyB8IDM5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKystLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDM3IGluc2VydGlvbnMo
KyksIDIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvYWhjaV9j
ZXZhLmMgYi9kcml2ZXJzL2F0YS9haGNpX2NldmEuYyBpbmRleCANCj4gYjEwZmQ0Yy4uYzcwNDkw
NiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hdGEvYWhjaV9jZXZhLmMNCj4gKysrIGIvZHJpdmVy
cy9hdGEvYWhjaV9jZXZhLmMNCj4gQEAgLTEyLDYgKzEyLDcgQEANCj4gICNpbmNsdWRlIDxsaW51
eC9tb2R1bGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9kZXZpY2UuaD4NCj4gICNpbmNsdWRl
IDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0K
PiAgI2luY2x1ZGUgImFoY2kuaCINCj4gIA0KPiAgLyogVmVuZG9yIFNwZWNpZmljIFJlZ2lzdGVy
IE9mZnNldHMgKi8gQEAgLTg3LDYgKzg4LDcgQEAgc3RydWN0IA0KPiBjZXZhX2FoY2lfcHJpdiB7
DQo+ICAJdTMyIGF4aWNjOw0KPiAgCWJvb2wgaXNfY2NpX2VuYWJsZWQ7DQo+ICAJaW50IGZsYWdz
Ow0KPiArCXN0cnVjdCByZXNldF9jb250cm9sICpyc3Q7DQo+ICB9Ow0KPiAgDQo+ICBzdGF0aWMg
dW5zaWduZWQgaW50IGNldmFfYWhjaV9yZWFkX2lkKHN0cnVjdCBhdGFfZGV2aWNlICpkZXYsIEBA
IA0KPiAtMTk0LDcgKzE5Niw3IEBAIHN0YXRpYyBpbnQgY2V2YV9haGNpX3Byb2JlKHN0cnVjdCBw
bGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJc3RydWN0IGFoY2lfaG9zdF9wcml2ICpocHJpdjsN
Cj4gIAlzdHJ1Y3QgY2V2YV9haGNpX3ByaXYgKmNldmFwcml2Ow0KPiAgCWVudW0gZGV2X2RtYV9h
dHRyIGF0dHI7DQo+IC0JaW50IHJjOw0KPiArCWludCByYywgaSwgaXNfcnN0X2N0cmwgPSAxOw0K
PiAgDQo+ICAJY2V2YXByaXYgPSBkZXZtX2t6YWxsb2MoZGV2LCBzaXplb2YoKmNldmFwcml2KSwg
R0ZQX0tFUk5FTCk7DQo+ICAJaWYgKCFjZXZhcHJpdikNCj4gQEAgLTIwMiwxNCArMjA0LDQ3IEBA
IHN0YXRpYyBpbnQgY2V2YV9haGNpX3Byb2JlKHN0cnVjdCANCj4gcGxhdGZvcm1fZGV2aWNlICpw
ZGV2KQ0KPiAgDQo+ICAJY2V2YXByaXYtPmFoY2lfcGRldiA9IHBkZXY7DQo+ICANCj4gKwljZXZh
cHJpdi0+cnN0ID0gZGV2bV9yZXNldF9jb250cm9sX2dldCgmcGRldi0+ZGV2LCBOVUxMKTsNCg0K
UGxlYXNlIHVzZSBkZXZtX3Jlc2V0X2NvbnRyb2xfZ2V0X29wdGlvbmFsX2V4Y2x1c2l2ZSgpDQoN
Cj4gKwlpZiAoSVNfRVJSKGNldmFwcml2LT5yc3QpKSB7DQo+ICsJCWlmIChQVFJfRVJSKGNldmFw
cml2LT5yc3QpICE9IC1FUFJPQkVfREVGRVIpDQo+ICsJCQlkZXZfZXJyKCZwZGV2LT5kZXYsICJm
YWlsZWQgdG8gZ2V0IHJlc2V0OiAlbGRcbiIsDQo+ICsJCQkJUFRSX0VSUihjZXZhcHJpdi0+cnN0
KSk7DQo+ICsJCWlzX3JzdF9jdHJsID0gMDsNCg0KaXNfcnN0X2N0cmwgd2lsbCBub3QgYmUgcmVx
dWlyZWQgdGhlbi4NCg0KPiArCX0NCj4gKw0KPiAgCWhwcml2ID0gYWhjaV9wbGF0Zm9ybV9nZXRf
cmVzb3VyY2VzKHBkZXYsIDApOw0KPiAgCWlmIChJU19FUlIoaHByaXYpKQ0KPiAgCQlyZXR1cm4g
UFRSX0VSUihocHJpdik7DQo+ICsJaWYgKGlzX3JzdF9jdHJsKQ0KPiArCQlyYyA9IGFoY2lfcGxh
dGZvcm1fZW5hYmxlX2Nsa3MoaHByaXYpOw0KPiArCWVsc2UNCj4gKwkJcmMgPSBhaGNpX3BsYXRm
b3JtX2VuYWJsZV9yZXNvdXJjZXMoaHByaXYpOw0KPiAgDQo+IC0JcmMgPSBhaGNpX3BsYXRmb3Jt
X2VuYWJsZV9yZXNvdXJjZXMoaHByaXYpOw0KPiAgCWlmIChyYykNCj4gIAkJcmV0dXJuIHJjOw0K
PiAgDQo+ICsJaWYgKGlzX3JzdF9jdHJsKSB7DQoNClRoaXMgY2FuIGp1c3QgYmUgImlmIChjZXZh
cHJpdi0+cnN0KSINCg0KPiArCQkvKiBBc3NlcnQgdGhlIGNvbnRyb2xsZXIgcmVzZXQgKi8NCj4g
KwkJcmVzZXRfY29udHJvbF9hc3NlcnQoY2V2YXByaXYtPnJzdCk7DQo+ICsNCj4gKwkJZm9yIChp
ID0gMDsgaSA8IGhwcml2LT5ucG9ydHM7IGkrKykgew0KPiArCQkJcmMgPSBwaHlfaW5pdChocHJp
di0+cGh5c1tpXSk7DQo+ICsJCQlpZiAocmMpDQo+ICsJCQkJcmV0dXJuIHJjOw0KPiArCQl9DQo+
ICsNCj4gKwkJLyogRGUtYXNzZXJ0IHRoZSBjb250cm9sbGVyIHJlc2V0ICovDQo+ICsJCXJlc2V0
X2NvbnRyb2xfZGVhc3NlcnQoY2V2YXByaXYtPnJzdCk7DQo+ICsNCj4gKwkJZm9yIChpID0gMDsg
aSA8IGhwcml2LT5ucG9ydHM7IGkrKykgew0KPiArCQkJcmMgPSBwaHlfcG93ZXJfb24oaHByaXYt
PnBoeXNbaV0pOw0KPiArCQkJaWYgKHJjKSB7DQo+ICsJCQkJcGh5X2V4aXQoaHByaXYtPnBoeXNb
aV0pOw0KPiArCQkJCXJldHVybiByYzsNCj4gKwkJCX0NCj4gKwkJfQ0KPiArCX0NCj4gKw0KPiAg
CWlmIChvZl9wcm9wZXJ0eV9yZWFkX2Jvb2wobnAsICJjZXZhLGJyb2tlbi1nZW4yIikpDQo+ICAJ
CWNldmFwcml2LT5mbGFncyA9IENFVkFfRkxBR19CUk9LRU5fR0VOMjsNCj4gIA0KDQpyZWdhcmRz
DQpQaGlsaXBwDQo=
