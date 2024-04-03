Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66077152DEF
	for <linux-ide@vger.kernel.org>; Wed,  3 Apr 2024 17:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=67.231.148.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165262; cv=fail; b=kL/6rIsOg4EFq4xGwANs4eOyu5vByZUfIbv6ahQ3gUDjiPLCyTStPYS3VOM8apXxVCmMc0zeXyHZfTWaIo/GJZsZKzfb+J4NeNyXit5feAJiVk2tP8fCBdU8dT0PtPvgjehYZK6FYRwcimmUUOVvAXDiqN/Yck/8920hKlM8inM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165262; c=relaxed/simple;
	bh=P8H37euIpp4vqOcuQRIRuXMrDNQpFs3bigQKI4nhQW8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXRpLqobcU3yN84WlLtEU0sEs6kaTERgY4ZNX9aY4/lSPlFMZ+AGjiHoF2vgQHq5Xh2bLuj253aYlfapGc8Sl12IqjGVo/q49GpOzPhCbD1+wR82YZZPrzsrun29GjWu0hvYbpYXuOI18zEmQ9PVPN9B/XS2OY+hJf6F6XSHUio=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b=IytYKOyt; arc=fail smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=marvell.com header.i=@marvell.com header.b="IytYKOyt"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 433GHkct021008;
	Wed, 3 Apr 2024 10:27:24 -0700
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2100.outbound.protection.outlook.com [104.47.55.100])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x9agsrnjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 10:27:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FAfO63/IiwurUZhwXahltF/4CO8OELNXXJD6Efa4/Ns3CqfKfkvR8Rg1WoDJZIzz7Kf1f6WPkA32OE+J/6aCU+59ieYXTOionNczhO4niDdeW9M5Id32Wwu/yvqYPzc5Bz19HslDNaOP4U/MWuDu5sQ9Nl4PlOnOp6c58CtEyC2g2/DRDuJcJzyy2/ycZtD3YoPUwZwqKNI6QiiGhjxAuAA1frhjRLpOAK4yk/JX6lGl3M/+pi9MPSlV7ridWagUmEWN5CDIK6uQfejzUtNiCv4BI/EAJsvbs++BcLzuu1InY3SmYfMmdciB+GmEB89kYo0A3WHH33nvff1G3J7Q0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8H37euIpp4vqOcuQRIRuXMrDNQpFs3bigQKI4nhQW8=;
 b=b23wuV904YuABi4Zw4kfOOc6p5ADbsbcciVsnF4rHJ0XsgMsYrGo54VWoUv21EcUJ8C4IkKAqRTYKhUQ8GrTRa5gpluj5hxOTm+lfv8xdea5+KQaM2p4x/kswAOZGhF8fhwR3l6tP3l2rdqxzq5GObOdJvd+xpOef1lqdIoHjjTpj2KzqlEtQ7NXZ8f9fmthj9uBKKYs9n878vXiDQVstpcFDG/qvs0aKGe36yJ9PIskdqyn/FGHvVobIxi3icrgydo4Vz0NqtGa4sitvu+ElsA8UA8SBhBSxsccZ759N4eUI8dgQpgOkXv51tq/8zWT0I4fobs5no0hmS44joEZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8H37euIpp4vqOcuQRIRuXMrDNQpFs3bigQKI4nhQW8=;
 b=IytYKOytbDcTET0AGuMMr3joP6pRQGhhbWCnvM+3WkO06lLt8KkI8KIX6J+ypn5bVAj1/KR4dXVjeMxbvbxMERge7xRp2xkFRx+bCaKUIfqM7Va3TrtMBYHOHWsz0eAheCLBoMvUrtvD7UDxdU00OW0JLenevRQEMbVcyGUh7aI=
Received: from DM4PR18MB5220.namprd18.prod.outlook.com (2603:10b6:8:53::16) by
 SN7PR18MB5341.namprd18.prod.outlook.com (2603:10b6:806:2dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Wed, 3 Apr
 2024 17:27:14 +0000
Received: from DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::669a:f0c4:59d0:3c5d]) by DM4PR18MB5220.namprd18.prod.outlook.com
 ([fe80::669a:f0c4:59d0:3c5d%5]) with mapi id 15.20.7409.042; Wed, 3 Apr 2024
 17:27:14 +0000
From: Saurav Kashyap <skashyap@marvell.com>
To: Damien Le Moal <dlemoal@kernel.org>,
        "cassel@kernel.org"
	<cassel@kernel.org>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "soochon@google.com" <soochon@google.com>,
        Manoj Phadtare
	<mphadtare@marvell.com>
Subject: RE: [EXTERNAL] Re: [PATCH v2] libata-sata: Check SDB_FIS for
 completion of DMA transfer before completing the commands.
Thread-Topic: [EXTERNAL] Re: [PATCH v2] libata-sata: Check SDB_FIS for
 completion of DMA transfer before completing the commands.
Thread-Index: AQHadpvbkbe7+eeq4kapfMap/BNReLE4cs4AgB53nLA=
Date: Wed, 3 Apr 2024 17:27:13 +0000
Message-ID: 
 <DM4PR18MB522080FA53B8C89A24361D2DD23D2@DM4PR18MB5220.namprd18.prod.outlook.com>
References: <20240315054414.27954-1-skashyap@marvell.com>
 <cf873588-4355-4052-b4c6-8f1d86f7bb77@kernel.org>
In-Reply-To: <cf873588-4355-4052-b4c6-8f1d86f7bb77@kernel.org>
Accept-Language: en-US, en-GB
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR18MB5220:EE_|SN7PR18MB5341:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 
 9hwsOeVlDuptHjSckSyALM6QTdDn18CASH+EVJDisSrt24lvCu9HAfnnQpDnfUYq9GyXirIcpFu8stfuMRIxsit3iyRE1Z3hJYOjNhJGULMt/xRAu3K+YkEg2y1MGT5CzSD5DEdhtvscLIBJwUihbvfhhYNz8rFeNN0NRcSne9aJ6/hIPmVW75QobnQGQyp4DB0iR+FrWSOiEjBvrKpmyL4bI9ZccIXsEcC+63xs8UKAX2K6FfsP56HXj7CQm86KNtL81SjJYU2YhyaFX5koBlvdlKqmwZAeamUVAz6u4m/+Faa1bt8EPTQiqMirttYOBxZU1Iuc63EE/Cogs5POztd8IR8/Qr4CVRy4m+4nMRoY64bnvzo/zP/wtoeHyPuvF6O0QaPud5biOIJ0tL0r893ZQEOca80skBBcksGjgJ1/mGfZvPWE6A9bkz8aL1J7edYXMywTmk6aqGUUmV6qYvdFoVn6IF8ODJAax8sPnaVnYEZQPT+ndLgsUkSQAP6tCcR7jJnzAP4qRt0374wH0/zF03VNx03ffefLn1+evjiUwO1B6CpJyIbQGL+zx6ajx/37mator6GNYHJ+lF9bnTgRdvTEP9kVWp78fzX6lYW0SQdqLOHkmD9eqSoSJUANstrRyPMfdw959a/y8P7zx1/uP95cLoy95FpDHQGu9hw=
x-forefront-antispam-report: 
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR18MB5220.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: 
 =?utf-8?B?NDhFMi8zS1RBa3ZJeWdXemgvcE5LUTYzcTJ6TWw2ejRvVXRpUk14TWt4ZzJP?=
 =?utf-8?B?VHA0VDQ1Y0xrODdPR1RFeUkrNFRscC9JQlcyekJFeUV1YzR1YjBIWm81UnZo?=
 =?utf-8?B?d3lCZGtQcFZVT1FxUWNQZ3dZeTBsMFJNbnlWUDlCMWhsSjY2dlg2Q0lKd3li?=
 =?utf-8?B?MkgwOWhKQjFuUVNlbUVSaVR5VUk2cEdrdEtMZTB3amc0M05ZbE00SVNXM0lV?=
 =?utf-8?B?bFFSOE1lWlcvWjVhNTYxTGFzNHpLYjJKWkpCekVpNG9CNnNvL24wSlZqZkI2?=
 =?utf-8?B?L2laZ1BHaTVKc3diZUhoWS9IT2t2S2wxSnF6ZzN3Z2pzVjJ4NFYrZWVsZ3lq?=
 =?utf-8?B?QWlKalErTUJ5aFQ2VFltanZETi9YK082a0JuaTN3bE1ya1RKdUV2RHB5eHdq?=
 =?utf-8?B?bjBKdGYwaWJxeHN1S0xxbDhnZjJWMm9VYUNCVDMxY0RkSDQ0aG1PVkhaRmht?=
 =?utf-8?B?VGwzclY4cmZITVNnUHczUmZFSzJMM3pWTmg3UEJVaTAxbFdDeHVYRUkxSlVv?=
 =?utf-8?B?bHRGZE02Tlk3R2dlUE51QU1hdXo2d0RuOFRCMHIvQ0dCaWRTZWhJR0pjYTc3?=
 =?utf-8?B?dkFkVUN6NXk4SDI2L1V1eFYzVzNBQmw3Y3Y1Rnc2b1UxVDdwRTBmUVNRLzBs?=
 =?utf-8?B?a3E1QzFHd0pjNEhPSVA5NERHQXNvUUVpSUYwejYyaVFhL08zTmNod1YvTzZW?=
 =?utf-8?B?bE5zK1ZTVzhob2JrZXJYeTlldHZlNWs1Rm9lQ1JiZzVpM05SV3Q3dkY3QUpX?=
 =?utf-8?B?SFRmenVRMVNreUduc3FxREdmVUZCNFhZQVZvRFFJRlNFTkVXTmRxOXlNTmtj?=
 =?utf-8?B?MlY0Q056TUYyelg0UUZrdmpGb0lieEJqY0NtWkllaUF6VUpTVk9lUEtiS0hJ?=
 =?utf-8?B?Q1I2eEhqOTVCTWpPd1AyQlh0SHZWT3k3emkwdi9tYS9KanpCanFkZnB6VXhF?=
 =?utf-8?B?WGs4SlVGK3lmcmY4eEtHUkdwelV5S1l0M2Z4NjVaa3JvUEE2aWRRdXhQQ2tZ?=
 =?utf-8?B?UlFCRWMwYWZMNG45NHJDTzhKcjNxckc3RXozczdNcmErNHkrd1Z1VVNWYndG?=
 =?utf-8?B?eTcwR3RZcmdkZ2krcE5NYlVnc0tlb05pWWRndndNcGhhdE91SGt3Tk9jL3ZI?=
 =?utf-8?B?TEdDUXA1VGFqYlpva0k5Sy8vcVlQSWlLSmFjY0hSODlXcnU1SjhVSCtoeVpx?=
 =?utf-8?B?U1hINmpHajljOGJxUEJ0M3orMGFRNVJpcG9yTURVNHF3azJpMUxLL29ZTjdZ?=
 =?utf-8?B?QVFPcEFTdzg1QjJ2UktWdG0zWjBibzJTR094dUJVSlFvMGo5dlprclVuNldB?=
 =?utf-8?B?V2lPbzlFTlV0RDR1Y3F4ZkRnbGNQa25hSWNTaXJFNG4ya0hTcDNtdmxrUnFK?=
 =?utf-8?B?SVR4cmR0d0Y1VHI0VUtnUnBUbG93cERiZkNMVll5SWxrRmZocmVsZFNaQU9z?=
 =?utf-8?B?MkJCdGlyUVlQTFNqMlZBZ1NVbHMvSWF2Q3dINHExL0xqU08vdTdEZjNSS2da?=
 =?utf-8?B?R2tFUnVEMmR3dzBmQzJRSTRIMkxrV2RWNVRGTndvcXZGSGVCSzMxU0VaZmVS?=
 =?utf-8?B?emJ4SW1VWGR2VUhIOFN2ZFdHWXEyR0krcGJNVmhObzJ0MFJVRDF3aXB6em8y?=
 =?utf-8?B?OVdsL0VnQXR3MkJJQVBGRXFRT25vbEJJbEd2SGVOWTJBR0UxMDdrR0F1dlVo?=
 =?utf-8?B?UzJnYVJHZlFvSlNTVGJGQUVoZmx5WlZQSFU1SUphUmRvcHdIcHgzbHUxdmxq?=
 =?utf-8?B?UFZuVE1QYWxlQ09YeklqS3luRFh0WW54cXYzNk5TSUd0OHRmT3VuZHVpeW40?=
 =?utf-8?B?NlZlS25ORjRVL2xhQ0NwNThYT3E3dGNSNHJxVi9GVkpyYmxyVnEySllEWnA5?=
 =?utf-8?B?K3hwVmlFaHFSejVmUmRWdmxNeXVkemo2djZsLzBXQWZadEdFdU8vZDFMTGdk?=
 =?utf-8?B?bCtRN0loRy92Mks3Nm55TlJSSGNoRmlDSmtWNTlDbzE2akFsL1hGckc0emVt?=
 =?utf-8?B?NmhIM3YrbmJOZUpzUFJ0UExzcm1JZDY5MGQ5clFsUzhuN0VtL2pVbDNSVW9I?=
 =?utf-8?B?QTMzVUxXN0dtOGF5WGYyYzBMb21OTW5hcUE0blhGLzBWY2p2d0pKdE5JZ3ZM?=
 =?utf-8?Q?onD6QGIT/OkznOEIhnH7GLNmL?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR18MB5220.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a033bd06-b62f-4291-8e41-08dc54034d6a
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Apr 2024 17:27:14.0134
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zlMqjGGJSliogFLXOZzX0W+5kFoZ87n5NQeg8CADbMePAEW2+utItZV7PY2cV7iolQ2xV5DWphgWKOzNtHgKnA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR18MB5341
X-Proofpoint-GUID: JokbGm4LbAzLmhXOWBP0QySiZBbFwrXp
X-Proofpoint-ORIG-GUID: JokbGm4LbAzLmhXOWBP0QySiZBbFwrXp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_18,2024-04-03_01,2023-05-22_02

SGkgRGFtaWVuLA0KVGhhbmtzIGZvciB0aGUgZmVlZGJhY2suIEl0IGEgaGFyZHdhcmUgaXNzdWUu
IEkgYWNrbm93bGVkZ2UgeW91ciBjb25jZXJucyBhbmQgYWdyZWVzIGZvciBub3QgYWRkaW5nIHRo
aXMgY2hhbmdlIHRvIHVwc3RyZWFtLg0KDQpUaGFua3MsDQp+U2F1cmF2DQoNCj4gLS0tLS1Pcmln
aW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVs
Lm9yZz4NCj4gU2VudDogRnJpZGF5LCBNYXJjaCAxNSwgMjAyNCAxOjM5IFBNDQo+IFRvOiBTYXVy
YXYgS2FzaHlhcCA8c2thc2h5YXBAbWFydmVsbC5jb20+OyBjYXNzZWxAa2VybmVsLm9yZw0KPiBD
YzogbGludXgtaWRlQHZnZXIua2VybmVsLm9yZzsgc29vY2hvbkBnb29nbGUuY29tOyBNYW5vaiBQ
aGFkdGFyZQ0KPiA8bXBoYWR0YXJlQG1hcnZlbGwuY29tPg0KPiBTdWJqZWN0OiBbRVhURVJOQUxd
IFJlOiBbUEFUQ0ggdjJdIGxpYmF0YS1zYXRhOiBDaGVjayBTREJfRklTIGZvciBjb21wbGV0aW9u
DQo+IG9mIERNQSB0cmFuc2ZlciBiZWZvcmUgY29tcGxldGluZyB0aGUgY29tbWFuZHMuDQo+IA0K
PiBQcmlvcml0aXplIHNlY3VyaXR5IGZvciBleHRlcm5hbCBlbWFpbHM6IENvbmZpcm0gc2VuZGVy
IGFuZCBjb250ZW50IHNhZmV0eSBiZWZvcmUNCj4gY2xpY2tpbmcgbGlua3Mgb3Igb3BlbmluZyBh
dHRhY2htZW50cw0KPiANCj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQ0KPiBPbiAzLzE1LzI0IDE0OjQ0LCBTYXVy
YXYgS2FzaHlhcCB3cm90ZToNCj4gPiBUaGlzIGlzc3VlIGlzIHNlZW4gb24gTWFydmVsbCBDb250
cm9sbGVyIHdpdGggZGV2aWNlIGlkcyAweDkyMTUgYW5kIDB4OTIzNS4NCj4gDQo+IEkgZG8gbm90
IHNlZSAweDkyMTUgbGlzdGVkLiBJcyB0aGlzIG9uZSBzdXBwb3NlZCB0byB3b3JrIE9LIHdpdGgg
Z2VuZXJpYyBBSENJID8NCj4gDQo+ID4gSXRzIHJlcHJvZHVjZWQgd2l0aGluIGEgbWludXRlIHdp
dGggYmxvY2sgc2l6ZSBvZiA2NEssIDEwMCB0aHJlYWRzLA0KPiA+IDEwMCBqb2JzIGFuZCAgNTEy
IGlvZGVwdGggb24gQU1EIHBsYXRmb3JtLiBXaXRoIGRlY3JlYXNlZCB3b3JrIGxvYWQgaXQNCj4g
PiB0YWtlcyA4LTkgaHJzLg0KPiA+DQo+ID4gU2VxdWVuY2UgbGVhZGluZyB0byBhbiBpc3N1ZSBh
cyBwZXIgUENJZSB0cmFjZQ0KPiA+IC0gUHhTYWN0IGlzIHJlYWQgd2l0aCBzbG90cyA3IGFuZCAy
NCBiZWluZyBjbGVhcmVkLg0KPiA+IC0gSG9zdCBzdGFydHMgcHJvY2Vzc2luZyB0aGVzZSBjb21t
YW5kcyB3aGlsZSBkYXRhIGlzIG5vdCBpbiBzeXN0ZW0NCj4gPiAgIG1lbW9yeSB5ZXQuDQo+IA0K
PiBUaGlzIGlzIGEgc2VyaW91cyBoYXJkd2FyZSBidWcsIGJ1dCBpcyB0aGlzIGlzc3VlIHRpZWQg
dG8gdGhlIGZhY3QgdGhhdCB0aGUgaG9zdA0KPiBpcyBBTUQgPyBEb2VzIHRoZSBzYW1lIGlzc3Vl
IGhhcHBlbiB3aXRoIGRpZmZlcmVudCBob3N0cyAoZS5nLiBJbnRlbCwgQVJNLCBldGMpDQo+ID8g
QW5kIHdoYXQgYWJvdXQgZGV2aWNlcyA/IERvIHlvdSBzZWUgdGhpcyBlcnJvciBpZiB5b3UgY2hh
bmdlIGRldmljZXMgdG9vID8gT3INCj4gZG9lcyB0aGlzIGhhcHBlbiBvbmx5IHdpdGggb25lIHBh
cnRpY3VsYXIgZGV2aWNlIG1vZGVsL3ZlbmRvciA/IChpbiB3aGljaCBjYXNlLA0KPiB0aGUgaXNz
dWUgY291bGQgYmUgd2l0aCB0aGUgZGV2aWNlIGFuZCBub3QgdGhlIGFkYXB0ZXIpLg0KPiANCj4g
PiAtIExhc3QgcGt0IG9mIDUxMkIgd2FzIHNlbnQgdG8gaG9zdC4NCj4gPiAtIFNEQi5GSVMgaXMg
Y29waWVkLCB0ZWxsaW5nIGhvc3QgY29tbWFuZCBzbG90IDI0IGlzIGRvbmUuDQo+ID4NCj4gPiBS
ZWFkaW5nIFNEQi5GSVMgY29uZmlybXMgdGhlIHRyYW5zZmVyIGlzIGNvbXBsZXRlLg0KPiA+DQo+
ID4gQ2M6IFNvb2Nob24gUmFkZWUgPHNvb2Nob25AZ29vZ2xlLmNvbT4NCj4gPiBUZXN0ZWQtYnk6
IE1hbm9qIFBoYWR0YXJlIDxtcGhhZHRhcmVAbWFydmVsbC5jb20+DQo+ID4gU2lnbmVkLW9mZi1i
eTogU2F1cmF2IEthc2h5YXAgPHNrYXNoeWFwQG1hcnZlbGwuY29tPg0KPiA+IC0tLQ0KPiA+IHYx
LT52MjoNCj4gPiBBZGRlZCB3b3JrbG9hZCBhbmQgcGxhdGZvcm0gcmVsYXRlZCBkZXRhaWxzIGlu
IHRoZSBkZXNjcmlwdGlvbi4NCj4gPg0KPiA+ICBkcml2ZXJzL2F0YS9saWJhdGEtc2F0YS5jIHwg
MjggKysrKysrKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvYXRhL2xpYmF0YS1zYXRhLmMgYi9kcml2ZXJzL2F0YS9saWJhdGEtc2F0YS5jDQo+ID4gaW5k
ZXggMGZiMTkzNDg3NWYyLi43Y2RlYjBhMzhjNWIgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9h
dGEvbGliYXRhLXNhdGEuYw0KPiA+ICsrKyBiL2RyaXZlcnMvYXRhL2xpYmF0YS1zYXRhLmMNCj4g
PiBAQCAtMTQsOSArMTQsMTEgQEANCj4gPiAgI2luY2x1ZGUgPHNjc2kvc2NzaV9laC5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvbGliYXRhLmg+DQo+ID4gICNpbmNsdWRlIDxhc20vdW5hbGlnbmVk
Lmg+DQo+ID4gKyNpbmNsdWRlIDxsaW51eC9wY2kuaD4NCj4gPg0KPiA+ICAjaW5jbHVkZSAibGli
YXRhLmgiDQo+ID4gICNpbmNsdWRlICJsaWJhdGEtdHJhbnNwb3J0LmgiDQo+ID4gKyNpbmNsdWRl
ICJhaGNpLmgiDQo+ID4NCj4gPiAgLyogZGVib3VuY2UgdGltaW5nIHBhcmFtZXRlcnMgaW4gbXNl
Y3MgeyBpbnRlcnZhbCwgZHVyYXRpb24sIHRpbWVvdXQgfSAqLw0KPiA+ICBjb25zdCB1bnNpZ25l
ZCBpbnQgc2F0YV9kZWJfdGltaW5nX25vcm1hbFtdCQk9IHsgICA1LCAgMTAwLCAyMDAwIH07DQo+
ID4gQEAgLTY0OSw2ICs2NTEsNyBAQCBFWFBPUlRfU1lNQk9MX0dQTChzYXRhX2xpbmtfaGFyZHJl
c2V0KTsNCj4gPiAgaW50IGF0YV9xY19jb21wbGV0ZV9tdWx0aXBsZShzdHJ1Y3QgYXRhX3BvcnQg
KmFwLCB1NjQgcWNfYWN0aXZlKQ0KPiA+ICB7DQo+ID4gIAl1NjQgZG9uZV9tYXNrLCBhcF9xY19h
Y3RpdmUgPSBhcC0+cWNfYWN0aXZlOw0KPiA+ICsJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19w
Y2lfZGV2KGFwLT5ob3N0LT5kZXYpOw0KPiA+ICAJaW50IG5yX2RvbmUgPSAwOw0KPiA+DQo+ID4g
IAkvKg0KPiA+IEBAIC02NzcsNyArNjgwLDMwIEBAIGludCBhdGFfcWNfY29tcGxldGVfbXVsdGlw
bGUoc3RydWN0IGF0YV9wb3J0ICphcCwNCj4gdTY0IHFjX2FjdGl2ZSkNCj4gPiAgCQl1bnNpZ25l
ZCBpbnQgdGFnID0gX19mZnM2NChkb25lX21hc2spOw0KPiA+DQo+ID4gIAkJcWMgPSBhdGFfcWNf
ZnJvbV90YWcoYXAsIHRhZyk7DQo+ID4gLQkJaWYgKHFjKSB7DQo+ID4gKwkJaWYgKHBkZXYtPnZl
bmRvciA9PSBQQ0lfVkVORE9SX0lEX01BUlZFTExfRVhUICYmDQo+ID4gKwkJICAgIChwZGV2LT5k
ZXZpY2UgPT0gMHg5MjE1IHx8IHBkZXYtPmRldmljZSA9PSAweDkyMzUpKSB7DQo+ID4gKwkJCXN0
cnVjdCBhaGNpX3BvcnRfcHJpdiAqcHAgPSBhcC0+cHJpdmF0ZV9kYXRhOw0KPiA+ICsJCQl1OCAq
cnhfZmlzID0gcHAtPnJ4X2ZpczsNCj4gPiArDQo+ID4gKwkJCWlmIChwcC0+ZmJzX2VuYWJsZWQp
DQo+ID4gKwkJCQlyeF9maXMgKz0gYXAtPmxpbmsucG1wICogQUhDSV9SWF9GSVNfU1o7DQo+ID4g
Kw0KPiA+ICsJCQlpZiAoIXFjKQ0KPiA+ICsJCQkJY29udGludWU7DQo+ID4gKw0KPiA+ICsJCQlp
ZiAoYXRhX2lzX25jcShxYy0+dGYucHJvdG9jb2wpKSB7DQo+ID4gKwkJCQl1MzIgKmZpcyA9ICh1
MzIgKikocnhfZmlzICsgUlhfRklTX1NEQik7DQo+ID4gKwkJCQl1MzIgZmlzX2FjdGl2ZSA9IGZp
c1sxXTsNCj4gDQo+IEl0IHJlYWxseSBsb29rcyBsaWtlIHRoaXMgc2hvdWxkIGJlIGRvbmUgaW4g
YWhjaV9xY19jb21wbGV0ZSgpIGluc3RlYWQgb2YgaGVyZQ0KPiBwZXIgcWMuIEFuZCB0aGUgZmFj
dCB0aGF0IHlvdSBuZWVkIHRvIGRvIHRoaXMgYWxzbyB0ZW5kIHRvIGluZGljYXRlIHRoYXQgdGhl
DQo+ICpkZXZpY2UqIGlzIHNlbmRpbmcgaW5jb3JyZWN0IFNEQiBGSVMuLi4gQXJlIHlvdSByZWFs
bHkgc3VyZSBpdCBpcyBhbiBhZGFwdGVyDQo+IGlzc3VlID8NCj4gDQo+ID4gKw0KPiA+ICsJCQkJ
aWYgKChmaXNfYWN0aXZlICYgKDEgPDwgdGFnKSkpIHsNCj4gPiArCQkJCQlhdGFfcWNfY29tcGxl
dGUocWMpOw0KPiA+ICsJCQkJCW5yX2RvbmUrKzsNCj4gPiArCQkJCX0NCj4gPiArCQkJfSBlbHNl
IHsNCj4gPiArCQkJCWF0YV9xY19jb21wbGV0ZShxYyk7DQo+ID4gKwkJCQlucl9kb25lKys7DQo+
ID4gKwkJCX0NCj4gPiArCQl9IGVsc2UgaWYgKHFjKSB7DQo+IA0KPiBUaGlzIGlzIG5vdCBhY2Nl
cHRhYmxlIGFzLWlzIGJlY2F1c2UgdGhpcyBhZGRzIG92ZXJoZWFkIGZvciBhbGwgd2VsbC1iZWhh
dmUNCj4gQUhDSS9TQVRBIGFkYXB0ZXJzIHRoYXQgZG8gbm90IGhhdmUgdGhpcyBidWcuIEdpdmVu
IHRoZSBwcm9ibGVtIGF0IGhhbmQsIEkgYW0NCj4gdGVtcHRlZCB0byBzdWdnZXN0IHRoYXQgYW55
IGRldmljZSBhdHRhY2hlZCB0byB0aGVzZSBhZGFwdGVycyBzaG91bGQgc2ltcGx5IGJlDQo+IG1h
cmtlZCB3aXRoIEFUQV9IT1JLQUdFX05PTkNRIHRvIGRpc2FibGUgTkNRLiBCdXQgZXZlbiB0aGVu
LCBpZiB0aGUNCj4gYWRhcHRlcg0KPiByYWlzZXMgYW4gaW50ZXJydXB0IGJlZm9yZSBhbGwgZGF0
YSBpcyB0cmFuc2ZlcnJlZCwgdGhpbmdzIHdpbGwgYnJlYWsuDQo+IA0KPiBJIGFtIHZlcnkgcmVs
dWN0YW50IHRvIGV2ZW4gdHJ5IHRvIGFkZCBhIHdvcmthcm91bmQgc3VjaCBicm9rZW4gYWRhcHRl
ciwgaWYgdGhpcw0KPiByZWFsbHkgdHVybnMgb3V0IHRvIGJlIGFuIGFkYXB0ZXIgaXNzdWUgKGFz
IG9wcG9zZWQgdG8gYSBkZXZpY2UgaXNzdWUpLg0KPiANCj4gSGF2ZSB5b3UgbG9va2VkIGF0IHNh
dGFfbXYuYyA/IEFueXRoaW5nIHJlbGV2YW50IHRvIHRoZXNlIGFkYXB0ZXJzIGluIHRoZXJlID8N
Cj4gDQo+ID4gIAkJCWF0YV9xY19jb21wbGV0ZShxYyk7DQo+ID4gIAkJCW5yX2RvbmUrKzsNCj4g
PiAgCQl9DQo+IA0KPiAtLQ0KPiBEYW1pZW4gTGUgTW9hbA0KPiBXZXN0ZXJuIERpZ2l0YWwgUmVz
ZWFyY2gNCg0K
