Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97C3BECAAD2
	for <linux-ide@archiver.kernel.org>; Mon, 29 Aug 2022 23:26:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiH2X0p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 29 Aug 2022 19:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbiH2X0o (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 29 Aug 2022 19:26:44 -0400
Received: from esa4.hgst.iphmx.com (esa4.hgst.iphmx.com [216.71.154.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F6E782D3F
        for <linux-ide@vger.kernel.org>; Mon, 29 Aug 2022 16:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1661815602; x=1693351602;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=1Bsvi/36M3haUmkBdjSBGh0LLhas1HWYbAD/7LBuvkc=;
  b=Hf1OrJAXovaQthxevKOQ8aSL0L6X2FRNISMcApdGYxsS6efNKhDWVtwt
   YiJu6K9BUlzhAx81L8O7BNL75mSgQnJpFQm9CAcKpO7SmNhgm92R3PJn0
   ozzVRG4xOlvgQ3dHjLqNvVJYLHSlWxbiG47/LBrsMWZD4voXxinpChCEf
   06RnarQ1jzmWGSXdRZW+6xAlcjknMd7waQDsPg28RVinsSNlec6U84P3Y
   zO60VOJPHj3l42UIdIvZjNO9BpjnAPtwbk+4LzjQJ11lGEAUlRBd9gQzf
   8n/vIMfnGyfMQj++/sFDZ1vS3Vr++XlpbRmlH/W3WF6SzloZjA7KIvliX
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,273,1654531200"; 
   d="scan'208";a="208411001"
Received: from mail-dm6nam11lp2177.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.177])
  by ob1.hgst.iphmx.com with ESMTP; 30 Aug 2022 07:26:40 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j+Uxr3p/rtxSzO8cXYF02cKifWNkJkPX+MzlVs2gaQq3GGcjcMFEg8TaysqRfhBRDINAVqxOWQr2fvMHw6is0DUKTFcFTaLA/qG0F71lA/ASqC6zJ0og8Jo7Peskt8wEbdxCUHRqlNrRllxNVX2nPhI3iZE93bii0+JIvZFBKHp8lFzWV4ZijG18Bo+jiCrfWtF09XgIcGYVf3O9+kFBzkpE9lMoPnn51GbEuLnhWpJ4MEpgWFpXTX3VCQk/rErJ7dJILhXDoFFTZOac8WJFBFVt7XU04YTMJ5F0bgJF9MbnKPjIavLEpgbYckcm5HWtM9jz6nrIjH8V2k8zM6Ly3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1Bsvi/36M3haUmkBdjSBGh0LLhas1HWYbAD/7LBuvkc=;
 b=OpTBQECEKLvORBQJgXuMyH0dTFtPWP8oIBZ9gFjcZuE8MNbz36JLnhzFeJhc28wRayj5QcJDbyRNz6U4WrCUp7qsNs5slyCU82FGIse8BgFc96j838H9OD1LDkzxaXWnOvyln9x4Cn89GNzWE9DJaPfSdzrVEryPYkMalFTXNu9X9j5fj1aeYeMjS1FAqRopJeWsWbHxeeW5MT34EpIjBgldfCOzuuda+FN24eUghuTvVB7TdcetjgrKrZVW/eR2Crz/eiRzzaM5SrUoJ5kQmll9M50osuT26JrrbgpxzTXc07IMgUul0mOWfNq6YkANFXrabDw5DuZCrS2u5vy/Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1Bsvi/36M3haUmkBdjSBGh0LLhas1HWYbAD/7LBuvkc=;
 b=GBrCu5QMLwoBiFi8LxQxiL1UGPNfU6aEnJeQaOdH/jVgcSvnLMYPyXFxfD6vffS+7gqiGydyvBUqbRB72pWb6THei0hSijgb+NQ/vDHu3Kay9YFxKOi6sqWi59o+mx8L6tG2vkRjBvPBp1SRR5rpeI2UB5Td7QmZbOmPKZho0+Q=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by BYAPR04MB6101.namprd04.prod.outlook.com (2603:10b6:a03:f1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5566.14; Mon, 29 Aug
 2022 23:26:38 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::74bc:2d28:7316:8da9]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::74bc:2d28:7316:8da9%3]) with mapi id 15.20.5566.021; Mon, 29 Aug 2022
 23:26:38 +0000
From:   Damien Le Moal <Damien.LeMoal@wdc.com>
To:     "peter.hans.froehlich@gmail.com" <peter.hans.froehlich@gmail.com>
CC:     "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: libata-scsi: ata_to_sense_error handling status 0x40
Thread-Topic: libata-scsi: ata_to_sense_error handling status 0x40
Thread-Index: AQHYuUOOkkgayVOeb0aLTVTcyhLacK3E9v8AgABw54CAASL6AA==
Date:   Mon, 29 Aug 2022 23:26:38 +0000
Message-ID: <424c35de52b7ade5eaec620b308cc0345fb3731f.camel@wdc.com>
References: <CAHXXO6Eio2LecHS3i7C7yeWOrGFdMA4HTDB=d7azS_67zw5cyg@mail.gmail.com>
         <48bb6122-626d-aae1-fb96-2c40455f0303@opensource.wdc.com>
         <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
In-Reply-To: <CAHXXO6GdTPMgBt_sjh_4QaZgYdOwNaikMzWNrMiBepiX=_aKTg@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.44.4 (3.44.4-1.fc36) 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6af6839e-7f54-40f8-b941-08da8a15ec23
x-ms-traffictypediagnostic: BYAPR04MB6101:EE_
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: pzNlouxRBS1CqT8rCVH0YltfmqmKSuzC8nKED55+TmDiiynA1nojozwYIWKojLWIwUwM09HPj2OG3/EI6ExwOByrJMIerifHQPPCkcDbN67VO1q7dQJSgblbzwfA7idpxhxdGyHy6QT61T6PJaogoJvvirIVG/VBvk6zogJJu0QIjdateqYyV1XlPu3xFNBJwHXWCyqERIewlyV1LdSLnEhoIO2oEMPf11m4RtnoX+ScjwV+Bo1t+sMZLugNvPgQ6e37GRgXNdOFNUvlSucvL+MRMQgL3SbnkJm3HIjsQtMDo5UJf8Bm3qXYf+75ZQTY0Zp7YRxj+O7bCINx6AAu2hK7NuHBt+Qgywog1u1wVHSONXRdZA2uMRQllu3rsDrC5yDw0XZHgZmw+BmeeM8gLVugSfi5W7+meGerTdf/nRx1kN5+4IMvuR9pGzE6TYu0mJB/NsOg13Xey9U+N0UKxzOjL5o6QEotmfHE6i3qLa6JPPDSQagtlnequUdprkvHEFJukX4g0/wJSYOcH4zuepYZvnytZ3cVp6z18MJdS+wTVDloNKaZhRePr672bXuyt+kGzQD3gKy9DpDEavHY30QW9U8nPjiJuG1CICtqnir3z4MsMNTOauhdzp/etR32FWLQiKsmprPLiFyNBz3HYEEXs8wzjzah7vhUE0rmXjn81iV3lbNqaygsyNh8mYrI5q6jgUIOTGtO0D+JQ50gYSyFw6huY+9gX7K/E309RxDVxUeZ9cqx6RoNfhyzTAdMH+ELM8ukGk7s0mKDjdmfkA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(346002)(366004)(376002)(39860400002)(396003)(136003)(83380400001)(38100700002)(38070700005)(82960400001)(8676002)(66476007)(66556008)(66946007)(76116006)(122000001)(66446008)(64756008)(91956017)(4326008)(316002)(6916009)(5660300002)(2906002)(8936002)(53546011)(66574015)(186003)(6512007)(6506007)(26005)(6486002)(478600001)(71200400001)(41300700001)(36756003)(2616005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?KzRHWHdGallBdTBwYVB4VGEvOVhqbEVQSk5QNi9Oa2xtSGFKajNPQzhjdVQx?=
 =?utf-8?B?Z1RCeWk1K2dvRitZeFYzVFkyeXphOE1TZzQ2QUR5WWluNHlSeHpwcUYrOEFW?=
 =?utf-8?B?TGVIMlFUYmk1WGRCR3VFSGhpRVU0eEVqRVo0YnpXeW14ZDZaWmNrMGU1d0d6?=
 =?utf-8?B?bHFyREVXZ3dBYlFxVW9vK1kyRGNqVnFGbWNLczExREM1QXRLYTR3OTZGenpV?=
 =?utf-8?B?bVNCbmtud2JvZWN4dmk2T0c1UHFCbi9kV1gyWDhudXQ3NU1jZFZWM3RCd1RS?=
 =?utf-8?B?RS8xMW5JNFh0VGNiL0ZTdU1ja3orcVlJSW9xZ0hZYVVxZCtwcy9FWXlwVzA0?=
 =?utf-8?B?UFhPcm9BaWRzR2dmR3BZa2pJWi9kN2dGTCt6dnBLUzNjMWM3Wjg2MG5KSWxR?=
 =?utf-8?B?eGFmQURERytSbVY2d1AxTWxacEZsc0cyN2lrZVdMOWg2QVh5RHdoazg2Tmps?=
 =?utf-8?B?UnI0Ylo0b2tZQVluVFBQT3VXdGRqczRiN0U0bUQxRHUySUdEclB5dG14anVM?=
 =?utf-8?B?b1dLWTU1Q1k2T3NnUVJueCs1WFZDQmgxb2FpeWRhZnA0WHNXNlhGK2pSdUhP?=
 =?utf-8?B?eFl4RjB6Q0JQWUs5a2F6WTgxdXRkQnExVlA2bHc5NGRQT04wY3daWWwvWVo5?=
 =?utf-8?B?SE9Pd0ZVd1ExYUxiaVo5TlVIK29sMWptSGVnR0hRb09DdjdvV2pyUWNQY0tW?=
 =?utf-8?B?b1ZLL2YwUXVFbHFORFpza3VZRlY3ZHE1cE1KekJrMDVSaHhzek5hUDNxckt0?=
 =?utf-8?B?Q1VUV0JaMzhyVzloeFFwRDZwb291NEhpTCtveFlsa1BuT0cwemRKTFR1MHV4?=
 =?utf-8?B?MXlWd1VYaHZXRFkwQTcyU1hkS1U5ai9CQkhseE8xS291QUN5Vkw3RzQ5QWdi?=
 =?utf-8?B?TFJXaml5ZUV4dW1LMElMZGNZTUdQWDA3OE44dS9ycmdDT0ZuN2s1eERLaVl4?=
 =?utf-8?B?aTNNRDlyOTRwUTJBc3B1Tlh0S2MvdHJIQi9GL1BRQzJpRjBoU1ZaazdEKzdq?=
 =?utf-8?B?bGxZcVcydWtsenlGVjNnNTI2T3VETkxqcVlqTndJcFJSRVdyTEo3VHBBbFY3?=
 =?utf-8?B?L3lhbk5TOVhhMDczelEwYXdiSStwdXZFUVBBNHR3a3J2clNuRkFqa2paaWtY?=
 =?utf-8?B?WkpkNkt1YmlNR2Y4dC9iK2VudjBMTDVnMW1nc3ZGVGN5WkowVTdGMnJ5OUU1?=
 =?utf-8?B?d3J0OS9ObkNNVjM3MWNvcjZVR3ptNWp0ZGhMcmRqYlFXTmpHNGRXUDVjWlVi?=
 =?utf-8?B?SU5HRXdGbXhQMktFWmRJV01DeDNrOGREa1NnLzcxZmZ5dUQyZU8yZE5KUTND?=
 =?utf-8?B?aEMzaG8wbFE2OFN2d01YbEFPbllLTjFHc0lWQ2FJVmpoMGJ6Q3RLOVJPUlha?=
 =?utf-8?B?UUxqQ1RzZlZpU1lKOTluMk1SMnRpRDN4VitjSzl3MlVQK0Q5R0JIaGdGYlc5?=
 =?utf-8?B?Z1B5MDF6b25FRVNhRk14YW93eXhGQ3A2NkltRmxTOWlLWHdTZUd5OHpoK0V1?=
 =?utf-8?B?eW9zMUlFVHVUaDdQZlNJM0VzMVlHZW5vQVoranFyZHVhRlhidHR5UXNFcFNY?=
 =?utf-8?B?MlRKdVY0TEh0REgxcjFrWW5uU3hVdklodFNGc3NNYlFXSHlDUHgxbDZQZXNv?=
 =?utf-8?B?TzBBQXFOVmUxQ0MvL0dCdFBQN3diVlRyYW12WllSWFNkbkJWVmtTZUM0UHVu?=
 =?utf-8?B?OGFFdGVjb2o0UG55MzY3NjZiMHVaWFN4SnBodTB5ZmIwbHIzcWVCRG1YSlBz?=
 =?utf-8?B?Q3pvOHZ2TFJzTUY0Z2JGMG5FbzJ2K3FhanpTb0hjNTFDQ0dZb1NPcFdDQVBv?=
 =?utf-8?B?VXBHcHVtcFRSUFA2RTExVlcxOVN3Y0dsVndWMm5ITFM4cFliai9YMVBvTFA1?=
 =?utf-8?B?U25YMUxOelU5eC9rYVhqQXdqTWRlNnJUbTBCbTJ2d0s5cnB0ZnZKd1E1Rnha?=
 =?utf-8?B?MXpEeWVYNUM5MlBwN1pSZ1YrZmUzb1JUSEhHVXRGd1NWaDAzaVFaclFxM21H?=
 =?utf-8?B?ZmxYdVZ4ekMySHZXZ01qVGRtQzNVWTg0b0J1VUhnaGpYNGUwWGZQaTZxRVB5?=
 =?utf-8?B?WXNEZFY3WElpaVFXYlZQc3FiUGFRb2daSE9VQUxaUU9tenBzbnQybkRYZWJt?=
 =?utf-8?B?c0Q5eVpOSVNXMW5sUDE4MTYzdGZjS1g1UFNueTBEODlTb1RoTHdkQUpkTTZ6?=
 =?utf-8?B?TXc9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <A4A8034686AB8B43BBA4E787D55A2C2F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af6839e-7f54-40f8-b941-08da8a15ec23
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Aug 2022 23:26:38.6900
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MGqzVb9me8h+4QnmuIZ7P3jndElTt5uuW4bLyxVpDtBdLZZCCScIlez+rfJ8b/KvZY7LTilGzf6k2PC70qumyQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR04MB6101
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

T24gTW9uLCAyMDIyLTA4LTI5IGF0IDA4OjA0ICswMjAwLCBQZXRlciBGcsO2aGxpY2ggd3JvdGU6
DQo+IE9uIE1vbiwgQXVnIDI5LCAyMDIyIGF0IDE6MjAgQU0gRGFtaWVuIExlIE1vYWwNCj4gPGRh
bWllbi5sZW1vYWxAb3BlbnNvdXJjZS53ZGMuY29tPiB3cm90ZToNCj4gPiBPbiAyMDIyLzA4LzI2
IDIxOjAwLCBQZXRlciBGcsO2aGxpY2ggd3JvdGU6DQo+ID4gPiBJbiBjb21taXQgOGFlNzIwNDQ5
ZmNhNGIxZDAyOTRjMGEwMjA0YzBjNDU1NTZhM2U2MSAibGliYXRhOg0KPiA+ID4gd2hpdGVzcGFj
ZQ0KPiA+ID4gZml4ZXMgaW4gYXRhX3RvX3NlbnNlX2Vycm9yKCkiIHdlIGZpbmQsIGFtb25nIG1h
bnkgYWN0dWFsDQo+ID4gPiB3aGl0ZXNwYWNlDQo+ID4gPiBjaGFuZ2VzLCBhbm90aGVyIGNoYW5n
ZSB0aGF0IGFkZHMgYW4gZW50cnkgZm9yIDB4NDAgdG8gdGhlDQo+ID4gPiBzdGF0X3RhYmxlLg0K
PiA+ID4gLi4uDQo+ID4gDQo+ID4gU2VlIHRoZSBjb2RlIGJlbG93IHRoYXQgdGFibGUgZGVmaW5p
dGlvbi4gWW91IGNhbiBzZWUgdGhpcyBodW5rOg0KPiA+IA0KPiA+IMKgwqDCoMKgwqDCoMKgIGlm
IChkcnZfZXJyKSB7DQo+ID4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIC8qIExvb2sg
Zm9yIGRydl9lcnIgKi8NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZm9yIChp
ID0gMDsgc2Vuc2VfdGFibGVbaV1bMF0gIT0gMHhGRjsgaSsrKSB7DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAvKiBMb29rIGZvciBiZXN0IG1hdGNo
ZXMgZmlyc3QgKi8NCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIGlmICgoc2Vuc2VfdGFibGVbaV1bMF0gJiBkcnZfZXJyKSA9PQ0KPiA+IMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBzZW5zZV90YWJs
ZVtpXVswXSkgew0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgICpzayA9IHNlbnNlX3RhYmxlW2ldWzFdOw0KPiA+IMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
ICphc2MgPSBzZW5zZV90YWJsZVtpXVsyXTsNCj4gPiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCAqYXNjcSA9IHNlbnNlX3RhYmxl
W2ldWzNdOw0KPiA+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIGdvdG8gdHJhbnNsYXRlX2RvbmU7DQo+ID4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9DQo+ID4gwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgIH0NCj4gPiDCoMKgwqDCoMKgwqDCoCB9DQo+IA0KPiBUaGF0J3MgdGhl
IHNlbnNlX3RhYmxlLCBJIHdhcyByZWZlcnJpbmcgdG8gdGhlIHN0YXRfdGFibGUuIFRoYXQgdGFi
bGUNCj4gaXMgY29uc3VsdGVkIHdoZW4gd2UgZmFpbCB0byBjb252ZXJ0IHZpYSB0aGUgc2Vuc2Vf
dGFibGUuDQoNClJpZ2h0Li4uIFJlYWRpbmcgZW1haWxzIG9uIE1vbmRheSBtb3JuaW5nIHdpdGhv
dXQgZW5vdWdoIGNvZmZlZSB3YXMgYQ0KYmFkIGlkZWEgOikNCg0KU28gbG9va2luZyBhdCB0aGUg
cmlnaHQgY29kZSBhZ2FpbiwgdGhpcyBpcyBhbGwgdmVyeSBzdHJhbmdlLiBFLmcuIHRoZQ0KQUNT
IHNwZWNzIGRlZmluZSBiaXQgNSBvZiB0aGUgc3RhdHVzIGZpZWxkIGFzIHRoZSAiZGV2aWNlIGZh
dWx0IiBiaXQsDQpidXQgdGhlIGNvZGUgbG9va3MgYXQgMHgwOCwgc28gYml0IDMuIEZvciB3cml0
ZSBjb21tYW5kLCB0aGUgZGVmaW5pdGlvbg0KaXM6DQoNClNUQVRVUw0KQml0IERlc2NyaXB0aW9u
DQo3OjYgVHJhbnNwb3J0IERlcGVuZGVudCDigJMgU2VlIDYuMi4xMQ0KNSBERVZJQ0UgRkFVTFQg
Yml0IOKAkyBTZWUgNi4yLjYNCjQgTi9BDQozIFRyYW5zcG9ydCBEZXBlbmRlbnQg4oCTIFNlZSA2
LjIuMTENCjIgTi9BDQoxIFNFTlNFIERBVEEgQVZBSUxBQkxFIGJpdCDigJMgU2VlIDYuMi45DQow
IEVSUk9SIGJpdCDigJMgU2VlIDYuMi44DQoNCkFuZCB0aGUgY29kZSBpczoNCg0KICAgICAgICBz
dGF0aWMgY29uc3QgdW5zaWduZWQgY2hhciBzdGF0X3RhYmxlW11bNF0gPSB7ICAgICAgICAgICAg
ICAgIA0KICAgICAgICAgICAgICAgIC8qIE11c3QgYmUgZmlyc3QgYmVjYXVzZSBCVVNZIG1lYW5z
IG5vIG90aGVyIGJpdHMgdmFsaWQNCiovICAgICAgDQogICAgICAgICAgICAgICAgezB4ODAsICAg
ICAgICAgIEFCT1JURURfQ09NTUFORCwgMHg0NywgMHgwMH0sICAgICAgICAgDQogICAgICAgICAg
ICAgICAgLy8gQnVzeSwgZmFrZSBwYXJpdHkgZm9yIG5vdyAgICAgICAgICAgICAgICAgICAgICAg
ICAgDQogICAgICAgICAgICAgICAgezB4NDAsICAgICAgICAgIElMTEVHQUxfUkVRVUVTVCwgMHgy
MSwgMHgwNH0sICAgICAgICAgDQogICAgICAgICAgICAgICAgLy8gRGV2aWNlIHJlYWR5LCB1bmFs
aWduZWQgd3JpdGUgY29tbWFuZCAgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgezB4MjAs
ICAgICAgICAgIEhBUkRXQVJFX0VSUk9SLCAgMHg0NCwgMHgwMH0sICAgICAgICAgDQogICAgICAg
ICAgICAgICAgLy8gRGV2aWNlIGZhdWx0LCBpbnRlcm5hbCB0YXJnZXQgZmFpbHVyZSAgICAgICAg
ICAgICAgDQogICAgICAgICAgICAgICAgezB4MDgsICAgICAgICAgIEFCT1JURURfQ09NTUFORCwg
MHg0NywgMHgwMH0sICAgICAgICAgDQogICAgICAgICAgICAgICAgLy8gVGltZWQgb3V0IGluIHhm
ZXIsIGZha2UgcGFyaXR5IGZvciBub3cgICAgICAgICAgICAgDQogICAgICAgICAgICAgICAgezB4
MDQsICAgICAgICAgIFJFQ09WRVJFRF9FUlJPUiwgMHgxMSwgMHgwMH0sICAgICAgICAgDQogICAg
ICAgICAgICAgICAgLy8gUmVjb3ZlcmVkIEVDQyBlcnJvciAgICBNZWRpdW0gZXJyb3IsIHJlY292
ZXJlZCAgICAgDQogICAgICAgICAgICAgICAgezB4RkYsIDB4RkYsIDB4RkYsIDB4RkZ9LCAvLyBF
TkQgbWFyayAgICAgICAgICAgICAgICAgDQogICAgICAgIH07DQoNClNvIHRoaXMgZG9lcyBub3Qg
bWF0Y2ggYXQgYWxsLiBTb21ldGhpbmcgd3JvbmcgaGVyZSwgb3IsIHRoZSAic3RhdHVzIg0KZmll
bGQgYmVpbmcgb2JzZXJ2ZWQgaGVyZSBpcyBub3QgdGhlIG9uZSBJIGFtIHRoaW5raW5nIG9mLiBD
aGVja2luZw0KQUhDSSAmIFNBVEEtSU8gc3BlY3MsIEkgZG8gbm90IHNlZSBhbnl0aGluZyBtYXRj
aGluZyB0aGVyZSBlaXRoZXIuDQoNCkh1Li4uIE5lZWQgdG8gZGlnIGludG8gdGhpcyBmdXJ0aGVy
LiBNaXNzaW5nIHNvbWV0aGluZyBoZXJlLg0KDQo+IA0KPiA+IEFyZSB5b3UgdXNpbmcgYW4gU01S
IGRyaXZlID8gR2V0dGluZyBhbiBhbGlnbmVkIHdyaXRlIHNob3VsZCBub3QNCj4gPiBoYXBwZW4g
Zm9yIGENCj4gPiByZWd1bGFyIGRpc2sgYXMgdGhlIGtlcm5lbCBlbnN1cmUgYWxpZ25tZW50cyBv
ZiBJTyB0byBMQkFzLiBCdXQgZm9yDQo+ID4gU01SLCBpdCBpcw0KPiA+IHBvc3NpYmxlIHRvIHNl
bmQgYSB3cml0ZSBjb21tYW5kIHRoYXQgaXMgbm90IGFsaWduZWQgdG8gYSB6b25lDQo+ID4gd3Jp
dGUgcG9pbnRlcg0KPiA+IHBvc2l0aW9uLCByZXN1bHRpbmcgaW4gYW4gdW5hbGlnbmVkIHdyaXRl
IGVycm9yLg0KPiANCj4gV2hpY2ggaXMgd2h5IEkgYW0gcHJldHR5IHN1cmUgdGhhdCB0aGUgInVu
YWxpZ25lZCB3cml0ZSIgbWVzc2FnZSBpcw0KPiBzcHVyaW91cyBzaW5jZSBJIGFtIHdyaXRpbmcg
dG8gYSBwbGFpbiBvbGQgU1NELiBJdCdzIGdvaW5nIHRvIGJlIGhhcmQNCj4gZm9yIGEgdXNlcnNw
YWNlIHByb2dyYW0gdG8gZ2VuZXJhdGUgYSB3cml0ZSB0aGF0IGlzIG5vIHByb3Blcmx5DQo+IGFs
aWduZWQgZm9yIHRoZSBTU0QuDQoNClVubGVzcyB5b3VyIFNTRCBpcyByZWFsbHkgYnVnZ3kgYW5k
IHRocm93cyBzdHJhbmdlIGVycm9ycywgd2hpY2ggaXMNCmFsd2F5cyBhIHBvc3NpYmlsaXR5LiBE
byB5b3UgaGF2ZSBhIGdvb2QgcmVwcm9kdWNlciBvZiB0aGUgcHJvYmxlbSA/DQoNCj4gDQo+IENo
ZWVycywNCj4gUGV0ZXINCg0K
