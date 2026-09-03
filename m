Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11020121.outbound.protection.outlook.com [52.101.193.121])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4340494821
	for <linux-ide@vger.kernel.org>; Thu,  3 Sep 2026 13:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.121
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788442583; cv=fail; b=nWYh/GJKo+jcpK6g4I8J27kCEHRB5L8p60jlPOLwbvJqYRT4tnU///wvXRsaJcfAYT65Il8VPY87DB8r4u3F0xuU6fv6s1Hh2rZ26BUmgoXx5JLDtxpZFgxJqR7JARe2bgKN0BCPFHUmMO8hXYk23Fk7iRGHuaBjwU0ik+3v2Cg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788442583; c=relaxed/simple;
	bh=/SfO5drema/bJ4bYfDwutLKlirvl9NP/vLElRV+iOPA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=D08FnLDASR8tzHXZQPvxHsYcfqhGMLD41D3mtFpYx9SeBlwOmJQnm9Inu9Yre43mahMdavjA3kvGSbDMaugSDY0qk43f4TnjjBCxlXbv2C8ZRflaLdll0mGH3EaPpdhbFTKb9yKFJlaY+K/ykQJSenAJ6C2mD9LVAr/hmaPd6Ao=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=netinsight.net; spf=pass smtp.mailfrom=netinsight.net; dkim=pass (2048-bit key) header.d=netinsight.net header.i=@netinsight.net header.b=N73/CbTb; arc=fail smtp.client-ip=52.101.193.121
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=netinsight.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=netinsight.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=netinsight.net header.i=@netinsight.net header.b="N73/CbTb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UzoWaTlEcF4kGxoCadyD/jpGXeO90LumZH/hkM+CVcUg88IIijEZYuDz/Nylt3jLTBPNPkWRCdEOfEE7VKCH4cBzR9+/cinD4ZW15bvonQBdj9lbo2bG0/wfJLGo/b0n1poTsWZcJ1AjxxqXqTbExtDR97dCu1p4Pxq1kw9qiigpgEgIawNBKrmtZIZfa1cja8+Gfz4g+ytjjNJYoE+sHYmi52izCVe4GBrWnVH6TJaaxmlixsfHN5j1m9DxlPSSZTcBS0qQnROTcNM44D3JVHM726OACRSHSwpjflLcKAdFf7fdg7UnQ426wqyi1V8Z5rEG/YhRIxlIAwYKp7VCOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/SfO5drema/bJ4bYfDwutLKlirvl9NP/vLElRV+iOPA=;
 b=U7o19yaae7MCQRPrGNaz1UgD+EoOD660uhDu2VidxT8cc068On4cw+dc8sGM8zBv5szKQYupTOtpX5IxQVL3mzOT07xvgwS9c6rwTymm5UzgJ1C0KQgcGPbhwIZYoGB9zOHiEUS43LafE7iePEM6ig7xCLzPL82QYzz29HheAHV1Hjia2dTAC6CZ4ZZ/hztuGEVc6qr3vPMuC6R05DW8w/sQZeN3x/KP3ZrVA4wRAD2Zw3Mvex20QAK+gpzWWopMSMovSlDLuHiQP3fNNebnaHUpJC0hxLArea9cGtEk2uzYMrzd3uAX1lytvxSvXNOk0PDZ2crDDOb14RL6X6ZLIA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=netinsight.net; dmarc=pass action=none
 header.from=netinsight.net; dkim=pass header.d=netinsight.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=netinsight.net;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/SfO5drema/bJ4bYfDwutLKlirvl9NP/vLElRV+iOPA=;
 b=N73/CbTbhZquXpI5e6AwN58dyJhW36lyIIivJxRE+p+eT0l0AjNG6F2eLB4PhSmt0zt1gnqGqdb+0IuJ1N41ZcP55Wq6frAtTiFv5pm348WI1YP41bJcBr4zCLLSrIbqRxkGg2xtcdY+MG1pb3sEhTEojhyHGhvXAu3kf+UuOU1+MwdMGM5yITNzYSym7zs8j+v3TtvmXWShLBDiLQb7VdvUxwqDxq9i0P3J4e6hIEjv099FNB0YKezfD5zDMq5/tF5gdV6UkZWhX44yt0shniVUzQsd46W3g/wTaBU+R8njsKIYyU0U6y8r5zQ7kYAtl/+HoJkhha8mxcT8OqbR3Q==
Received: from IA0PR17MB6687.namprd17.prod.outlook.com (2603:10b6:208:40f::9)
 by MN2PR17MB3808.namprd17.prod.outlook.com (2603:10b6:208:20b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.13; Thu, 3 Sep
 2026 13:35:40 +0000
Received: from IA0PR17MB6687.namprd17.prod.outlook.com
 ([fe80::14fc:a86a:d2a9:4703]) by IA0PR17MB6687.namprd17.prod.outlook.com
 ([fe80::14fc:a86a:d2a9:4703%6]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 13:35:40 +0000
From: Roland Waltersson <roland.waltersson@netinsight.net>
To: "artmoty@gmail.com" <artmoty@gmail.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Thread-Topic: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
Thread-Index: AQHdO6j3n15Rzd/Y1EWrB9UpAY+b/g==
Date: Thu, 3 Sep 2026 13:35:40 +0000
Message-ID:
 <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=netinsight.net;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR17MB6687:EE_|MN2PR17MB3808:EE_
x-ms-office365-filtering-correlation-id: b44bd5af-59b8-4a5d-5fba-08df09c03f02
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|23010399003|366016|56012099006|10067099003|6133799003|18002099003|38070700021;
x-microsoft-antispam-message-info:
 OXS3P9dKWcqjUNuVxTjLAiCeTzq18q2565tGZkWDVXQkxeFBNoF5XteuV0GXry9FmPhVyNOGUpkIDzb0vgCWEwkywumbK3vXnzibJBqTDx+oVXiRh4jBYX/k2wfUbNliRLVtPhkz6SwgO5DXr07sNNnLHDGVqF1LGCLLh/x3U4BDCdp6jPn+QNIyI5KEMpbblLXiR6wDKFAGwjY58dS715FcclyhiDiibkbPdrGl5qXGqmoqENHvTHqJpKeL0QMERrKnldevnDeZHjhpO2pyBRzLg/+xPiHt9KSxE+reYMXY3J6uZtvvrjY4xrLFOGrlSa/57jNbnLtxwBDkNSA7n+qxVputgBTOs/zWptsMkHFStvseJ3KRkkXYMJInQ+5znDQkvV/nrvaPKvOYcjujAm00lDU5DmsOas2c63mUCxFg2QxYP0SyhRlXfjtgMYgbOn/sgL3YMeckocXEpY5+IZsZEwo/iqc3UgGJXAmfpaerdSg0rcMFeQqqv/KE5IrTAew4ojt4eowLs6OIgMOnzHM+UX7CYDQltjiOMGQizZk5vH+7JDqVL2C7JHm1cisjmSrPs+iec/CQC99LJfVBOeIIyjwVedY7C2dj2nCPuKn7HoTc8roE3VDI4Jca7uIE5ch+0F7HzdOn0+5zC/aXbLgKh+yGcLRNaaspaiCU+oCYMG3PADZkDxgNim82EMzRaz1Hw3qk/pGM3JFFlIMigvaGTLyMDKW2wqnwylh/yQU=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR17MB6687.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(366016)(56012099006)(10067099003)(6133799003)(18002099003)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?amZxcnlLaWp3R2hwWmk5anYzWEVFOUNuZWZjUzcvMVgvSTQwclVnOFVqeWtl?=
 =?utf-8?B?WHdFL1Z5VW00WWVpTGxsOHBEQWVrQk0zOHZOYmpBaGM3T05UUmZxd2o2dkZa?=
 =?utf-8?B?UmVjREY0dnhFTUVURVI4VzhkT0JBM1dmbDBKME01ZjQ3NkZIUjhPaFRIVkVU?=
 =?utf-8?B?cDBrZy9pZy9ya0oydi82aDhYb2N2OUpqZEYrVjIxSTUwRHZRMHNqYklCUVUv?=
 =?utf-8?B?bjlWYWlOc3lMUW82VGZXZEl0elVhWStSdkF4QjVqMGw1UWRKcTVCUUN2N1RV?=
 =?utf-8?B?YTE3VG9rb0tyL2ZkdE8yMml3SXUrcG5RODRocmwycG9xakpOL01sdEh5anBk?=
 =?utf-8?B?SENMdEhodDhmYUFHZ0VveTNNR3J6RlBtTHgrdWhObzFlT2ExdEs0ajRHZ2lh?=
 =?utf-8?B?ajRmTlo4dXBZT0JpRktuY3RnbFBjZUlpRC9MWjFSZk9JVnJxL0FWMGhaNkJU?=
 =?utf-8?B?Tmo3N082cVFFemJNRVc0SEtjSU96RENwYzA0RXc0MnEycUJ0K05KSXRYQWti?=
 =?utf-8?B?MEZBWWFPekhhbFBMU2FOcXZMbFRTZWhObHFPZmxSTUlKcmx5WkV5ZzN3UGRL?=
 =?utf-8?B?Y1MrNWh5bmdxb0xZRUVEVVVJYnRJcXkyZCtEeEJ2ZWF3RW5FMGw3dUxyN2Ny?=
 =?utf-8?B?RFkzclN2NENSSzlSV1hFdUI5YWN6dWlDM0p0VHprL0NHVFZEWHpPdmtDclVw?=
 =?utf-8?B?OGxIT1c0cmhoSUNMOThJRFlteldoc2lGTDZwWkFocEp0a2xEQW5vZG9GTUhS?=
 =?utf-8?B?RDZSeWY2U0tnZkQ2UXNtRkZJRE95VTZta1RteC8zemIrZWNncStMWVN0S2tZ?=
 =?utf-8?B?U3N5d0tEQkZ4Ky9mMm9pZ216QVVDS1dZU2pzQ1QxKy9xL21jNHVFR1BRaVdC?=
 =?utf-8?B?c3I1c2NWai9DRWQ5T0FKRG5XN0pqMmdoSEszQmoyQ2o1eHBjNUJ4OXFncGZv?=
 =?utf-8?B?TVJkVjE0QVhUdkVNb3RqZUdrQzI4U0FnOW0zS2dxcGhYc1dmVWNLaTVQSGhm?=
 =?utf-8?B?VDl5dENBYmNNUXpZc3JIQXpUUmhqb1FVaHNrbUhKWVpwNG91dW04amhtdDhV?=
 =?utf-8?B?R0hWM0d0eEVFN3hIaEF3K0oxMEZWVDVibzc0TVl2ZkVhV2NLZGJkeE5PZXEw?=
 =?utf-8?B?Q01GSDlOV3hBbUx0dkxHUWZYUFZFbmVwWWR6QmZlN1JOa0lRMldIWVhDQ25U?=
 =?utf-8?B?S1J3UzBvN2grZjZjNHZBakJ5blU3RDVyM0JyTWEzOGlZVW1rUTVCQlFJR3ZI?=
 =?utf-8?B?cnZody9ETUxQT1JMK0lDQkhIZDYvWC9FSkxxem1oQUZ1cGhTRFJ6b2x4Rm1q?=
 =?utf-8?B?K0ZubmwwSUlYSDluWGVkdTJqakFrWE5IY3MzY0RHUlBKWjNHK2pFQzRSMkpX?=
 =?utf-8?B?bzBxVUxKd01iZEdNRU5HZ21NNXBCbWFncHFlMjNRaVFzUVZHTkMyZC9SU0Mr?=
 =?utf-8?B?MDZpbG9neHltcE1XT1VlazBaU3ZBSzk3WGdHUU9xU3k5UEluaVRKTXh2NTFt?=
 =?utf-8?B?VTZkZTlBWk84UlpCQm1FcHZ1WDZaamRHSCtTMFNkYi9kR2srSnE1Q2N3OFdw?=
 =?utf-8?B?eXRranZjV1lDcXBuTnNTV2l1b3dleGNIbzkzNmdTRGRuV1NyWlNpTi9nWlJj?=
 =?utf-8?B?YTZxcmhLUGo4VG5QU2ZrWEFXWVdVQXJnZlJ2NDRDcTBkZ2JlbDVoY2JOU2xn?=
 =?utf-8?B?dzJ2eDVYU3ZrK2FvcEdMZWovalBLODJQSlJtTVJHMGlFMVpIeGl3NkJYdU40?=
 =?utf-8?B?R1NNWFNyZUJLR0crM1pJcHp3aEZZZW5FSTRFcWN0K21SVVQ5Z0tkN21CQVlK?=
 =?utf-8?B?V2xzZU1sOVNoeERwVkV3cUdub2xsNzcvTnMycWJ0MEk5cUltdFREMFg3ZWdO?=
 =?utf-8?B?V1pENkV5WlJPQmMxb1JiRGFUeUtQS2tlMG1aNXgvSHdmNUVvNUhLOVZZTjAw?=
 =?utf-8?B?dnBpcm40dDBycnJHdGlBNUFLOWZoaWNMTjdYUUsyMjc4WUZXcGF0K0NQcDJH?=
 =?utf-8?B?SkZXV3l6bnZBQU96d0tSNnMyME5wYlZnNjV2cmRXanptTFNxYXZIYXkyLy9z?=
 =?utf-8?B?ajN2aVYzTkJDeGplQ3ZmbWEyRUZJaXZWcUpGbHpJTURxR09PbDlQNkZqaGFp?=
 =?utf-8?B?QXJMOXBkZWNpYTJhKzlIR1pnNnNIZWNuNEZDaktDK1c0N3poUU5oR0l3QXB4?=
 =?utf-8?B?SVZaYnNEeU1pbGliWWpJYlNTVTFhVjgwTEduU3k2dmhGTDhVVWdwVjhrUkZT?=
 =?utf-8?B?eVhRU0Z5QnpSMmkydW85a2Q3WkRRY1puQjZ6S2tlK2NWcng3RU9WV1d3M0ZQ?=
 =?utf-8?Q?hU+jTgmLAEfFYHIfVy?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: netinsight.net
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR17MB6687.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b44bd5af-59b8-4a5d-5fba-08df09c03f02
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Sep 2026 13:35:40.4982
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: f391105a-ad19-4c18-8bce-b08c4b953855
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sxNW30J4IWT32yMkJvkAd9aAJCLg7SCSrklL6k3MviQeJ+QxTBVeqlbbVWe3TCmz9ZdDf08XD4VtrJT6FUsHuQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR17MB3808

CihhbmFseXNpcyBwcm92aWRlZCBieSBDbGF1ZGUpCkhlbGxvLAoKQ29tbWl0IDEwNWM0MjU2NmE1
NSAoImF0YTogYWhjaTogZm9yY2UgMzItYml0IERNQSBmb3IgSk1pY3JvbgpKTUI1ODIvSk1CNTg1
IikgbWFrZXMgYSBKTWljcm9uIEpNQjU4NSB1bnVzYWJsZSBvbiBvdXIgYm9hcmQuIMKgSQpiZWxp
ZXZlIHRoZSBjYXVzZSBpcyBub3QgdGhlIHF1aXJrIGl0c2VsZiBidXQgYSBwcmUtZXhpc3Rpbmcg
Z2FwIGluCmFoY2lfc3RhcnRfZmlzX3J4KCksIHdoaWNoIHRoZSBxdWlyayBuZXdseSBleHBvc2Vz
IGZvciB0aGlzCmNvbnRyb2xsZXIuCgpIYXJkd2FyZQotLS0tLS0tLQoKwqAgLSBjb25nYXRlYyBj
b25nYS1UQ1I4IENPTSBFeHByZXNzIFR5cGUgNiBtb2R1bGUKwqAgwqAgKEFNRCBSeXplbiBFbWJl
ZGRlZCA4MDAwLCBaZW4gNCksIEJJT1MgVENSOFI5MDQgZGF0ZWQgMjAyNS0xMS0xMQrCoCAtIEpN
aWNyb24gSk1CNTg1IFNBVEEgY29udHJvbGxlciBvbiBvdXIgb3duIGNhcnJpZXIgYm9hcmQsCsKg
IMKgIGF0IFBDSSAwMDAwOjAyOjAwLjAKwqAgLSBBTUQtVmkgSU9NTVUgZW5hYmxlZCwgZGVmYXVs
dCAobGF6eSBETUEpIGRvbWFpbiB0eXBlCgpTeW1wdG9tCi0tLS0tLS0KClRoZSBjb250cm9sbGVy
J3MgbGluayBuZXZlciBjb21lcyB1cCBhbmQgdGhlIGJvb3QgZGllczoKCsKgIGFoY2kgMDAwMDow
MjowMC4wOiBBTUQtVmk6IEV2ZW50IGxvZ2dlZCBbSU9fUEFHRV9GQVVMVCBkb21haW49MHgwMDAx
IGFkZHJlc3M9MHg4MGZmZmMwNDQwIGZsYWdzPTB4MDAzMF0KwqAgYWhjaSAwMDAwOjAyOjAwLjA6
IEFNRC1WaTogRXZlbnQgbG9nZ2VkIFtJT19QQUdFX0ZBVUxUIGRvbWFpbj0weDAwMDEgYWRkcmVz
cz0weDgwZmZmYzAwMDAgZmxhZ3M9MHgwMDEwXQrCoCBhdGEyOiBzb2Z0cmVzZXQgZmFpbGVkICgx
c3QgRklTIGZhaWxlZCkKwqAgYXRhMjogcmVzZXQgZmFpbGVkLCBnaXZpbmcgdXAKClRoZSBkaXNr
IG5ldmVyIGFwcGVhcnMsIHNvIG91ciBpbml0cmFtZnMgY2Fubm90IG1vdW50IHRoZSByb290ZnMg
YW5kCnN3aXRjaF9yb290IHBhbmljcyB3aXRoICJBdHRlbXB0ZWQgdG8ga2lsbCBpbml0ISIuCgpB
bmFseXNpcwotLS0tLS0tLQoKQUhDSV9IRkxBR18zMkJJVF9PTkxZIGNhdXNlcyBhaGNpX3NhdmVf
aW5pdGlhbF9jb25maWcoKSB0byBjbGVhcgpIT1NUX0NBUF82NC4gwqBJbiBhaGNpX3N0YXJ0X2Zp
c19yeCgpLCB0aGUgdXBwZXIgaGFsdmVzIG9mIHRoZSBjb21tYW5kCmxpc3QgYW5kIEZJUyByZWNl
aXZlIGJhc2UgYWRkcmVzc2VzIGFyZSB3cml0dGVuIG9ubHkgd2hlbiBIT1NUX0NBUF82NAppcyBz
ZXQ6CgrigILigILigILigILigILigIJpZiAoaHByaXYtPmNhcCAmIEhPU1RfQ0FQXzY0KQrigILi
gILigILigILigILigILigILigILigILigILigILigIJ3cml0ZWwoKHBwLT5jbWRfc2xvdF9kbWEg
Pj4gMTYpID4+IDE2LArigILigILigILigILigILigILigILigILigILigILigILigIIgwqAgwqAg
wqAgcG9ydF9tbWlvICsgUE9SVF9MU1RfQUREUl9ISSk7CuKAguKAguKAguKAguKAguKAgndyaXRl
bChwcC0+Y21kX3Nsb3RfZG1hICYgMHhmZmZmZmZmZiwgcG9ydF9tbWlvICsgUE9SVF9MU1RfQURE
Uik7CgrigILigILigILigILigILigIJpZiAoaHByaXYtPmNhcCAmIEhPU1RfQ0FQXzY0KQrigILi
gILigILigILigILigILigILigILigILigILigILigIJ3cml0ZWwoKHBwLT5yeF9maXNfZG1hID4+
IDE2KSA+PiAxNiwK4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCC4oCCIMKgIMKgIMKg
IHBvcnRfbW1pbyArIFBPUlRfRklTX0FERFJfSEkpOwrigILigILigILigILigILigIJ3cml0ZWwo
cHAtPnJ4X2Zpc19kbWEgJiAweGZmZmZmZmZmLCBwb3J0X21taW8gKyBQT1JUX0ZJU19BRERSKTsK
ClRoZXJlIGlzIG5vIGVsc2UgYnJhbmNoLCBzbyB3aXRoIHRoZSBxdWlyayBhY3RpdmUgUHhDTEJV
IGFuZCBQeEZCVSBhcmUKbmV2ZXIgd3JpdHRlbiBhbmQgcmV0YWluIHdoYXRldmVyIGZpcm13YXJl
IGxlZnQgaW4gdGhlbS4KClRoZSBmYXVsdCBhZGRyZXNzZXMgZGVjb21wb3NlIGFjY29yZGluZ2x5
OgoKwqAgMHg4MGZmZmMwMDAwIMKgLT4gwqBsb3cgMHhmZmZjMDAwMCwgaGlnaCAweDAwMDAwMDgw
CsKgIDB4ODBmZmZjMDQ0MCDCoC0+IMKgbG93IDB4ZmZmYzA0NDAsIGhpZ2ggMHgwMDAwMDA4MAoK
VGhlIGxvdyBoYWx2ZXMgYXJlIGV4YWN0bHkgdGhlIElPVkFzIGRtYS1pb21tdSBoYW5kcyBvdXQg
Zm9yIGEKMzItYml0LW1hc2tlZCBQQ0kgZGV2aWNlICh0aGUgYWxsb2NhdG9yIHdvcmtzIGRvd253
YXJkIGZyb20gdGhlIHRvcCBvZgp0aGUgcmFuZ2UsIHNvIHRoZSBjb21tYW5kIGxpc3QgYW5kIEZJ
UyByZWNlaXZlIGFyZWEgbGFuZCBqdXN0IHVuZGVyCjQgR0IpLiDCoFRoZSBjb25zdGFudCAweDgw
IGluIHRoZSBoaWdoIGhhbGYgaXMgYSB2YWx1ZSB0aGUga2VybmVsIG5ldmVyCndyb3RlOyBvbiB0
aGlzIHBsYXRmb3JtIGl0IHBsYWNlcyB0aGUgRE1BIHRhcmdldCBhdCA1MTIgR0IsIGluc2lkZSB0
aGUKYWJvdmUtNEcgUENJZSBNTUlPIHdpbmRvdy4KClRoaXMgYWxzbyBleHBsYWlucyB3aHkgYm9v
dGluZyB3aXRoIGlvbW11PW9mZiBkb2VzIG5vdCBoZWxwOiB3aXRob3V0CnRoZSBJT01NVSB0aGUg
dHJhbnNmZXIgc2ltcGx5IGdvZXMgdG8gdGhhdCBNTUlPIGFkZHJlc3Mgc2lsZW50bHkKaW5zdGVh
ZCBvZiBmYXVsdGluZywgYW5kIHRoZSBGSVMgc3RpbGwgbmV2ZXIgYXJyaXZlcy4KCkNvbmZpcm1h
dGlvbgotLS0tLS0tLS0tLS0KClJldmVydGluZyAxMDVjNDI1NjZhNTUgcmVzdG9yZXMgbm9ybWFs
IG9wZXJhdGlvbi4gwqBUaGF0IGlzIG9idmlvdXNseQpub3QgYSBmaXgsIHNpbmNlIGl0IHJlaW5z
dGF0ZXMgdGhlIGJyb2tlbiA2NC1iaXQgRE1BIHRoZSBjb21taXQgZXhpc3RzCnRvIHByZXZlbnQu
CgoKSSBoYXZlIG9ubHkgcmVwcm9kdWNlZCB0aGlzIG9uIDUuMTUuMjE1ICh0aGUgcXVpcmsgcmVh
Y2hlZCB1cyBhcwo0ZmM2MzdkY2FkMTQgaW4gdjUuMTUuMjA5KTsgSSBoYXZlIG5vdCB0ZXN0ZWQg
bWFpbmxpbmUuIMKgVGhlCmFoY2lfc3RhcnRfZmlzX3J4KCkgY29kZSBhYm92ZSBpcyBob3dldmVy
IHVuY2hhbmdlZCBpbiBjdXJyZW50Cm1haW5saW5lLCBzbyBJIGV4cGVjdCBhbnkgQUhDSV9IRkxB
R18zMkJJVF9PTkxZIGNvbnRyb2xsZXIgc2l0dGluZwpiZWhpbmQgYW4gSU9NTVUgd2hvc2UgZmly
bXdhcmUgbGVhdmVzIFB4Q0xCVS9QeEZCVSBub24temVybyB0byBoaXQgdGhlCnNhbWUgcHJvYmxl
bS4KCkkgY2FuIHRlc3QgcGF0Y2hlcyBvbiB0aGlzIGhhcmR3YXJlLgoKVGhhbmtzLApSb2xhbmQg
V2FsdGVyc3Nvbgo=
