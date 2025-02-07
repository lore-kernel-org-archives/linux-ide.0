Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2092.outbound.protection.outlook.com [40.107.21.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C9D2417ED
	for <linux-ide@vger.kernel.org>; Fri,  7 Feb 2025 11:35:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.92
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738928136; cv=fail; b=Vk6onzUCcCHRUS4is5MlZEi4gD6uyus7+WQ5i1UvaISjQ3UkUUsSFt9vdMpxjmvG0sR37on/VhXbWqVgrgA0vTBFRtTmeI9EF/TnhtNZd64TFR0ec04xVA+NdY0JxxY+aNTRuHeAXMEeYX4ICW7WmNWc8spwg04XUsRfaUxTZlM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738928136; c=relaxed/simple;
	bh=IePsCInw3v+UIqRl3c2Efvxmhck3/Owje0yARtddRaI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ANf0Sx+gFW6NjR8xJ9+cLBlQwcJZ0Zz2PdtW/qG6YGdOjRZje7ZWNJEeOGD4LoOPSCClv9KEUVvtbRyEfoQ6F7f46A5oPVkJbUTdDuf2/v732bqon/WkkuiNz80bRcrzM9st6rJQK0Lh5f4DzSdhODPQfNI5YcVoNBckuMQ1xVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=ri9/OyvU; arc=fail smtp.client-ip=40.107.21.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="ri9/OyvU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9WXL2Wp0V8MDBw/vy5QPiEE4pjj9KBjHUrgpKFOWZJUuh9uEafiphjaU818G0ljphKW1eYJYFYkfzSGH33dEdP+eoYG9zk4EOysp9Ek6/KKwtZpjXDcLyvXJnfH0Mi4kuofEQeEU1wcivDH8Jb5hGBKyRL6JeLJZboJ173rwS0grvRa5yd/mjMA65XmFr0d+H2SO0ZWacgtVIiwUkuutKH4NWWr1+B9zSLd0VLunfpXiDjaZiA+F0aaIN6f94lwzDO/C9Vj0YrMORfAUk1dXvlzCZm4ZKzWd0WwGI7zEYvGXDIo9JQxzK1WcgCnSjhW71R5jWmwoK4QpkJ1YKUofQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IePsCInw3v+UIqRl3c2Efvxmhck3/Owje0yARtddRaI=;
 b=PC2LMwDFsaFovnOidkCc4Gq/3ALehYvLdbwuCVuXLEu8PkFqLpQr04CxeOOdCppYbyXE5LvRrhhvHCFoBWdMpx/+rcyjHI6fggftJweK0aFGnDe9gpXaWz8lU4JqcqDGycesR/L6r7m6D7U9CwplfGtlh0r5TqVn3A739mIIU/Z6a+6aq4HIQEf55pX/6cYr8rbfoC8q5pB+WDDFExRLp15C0JJ6CSygIERlZ/hYMlzwqiQ6mIL7acxObIweVS3mpUMHBeZenJHahm0x2+pjT3QMjYk+5plZZBUs5jhAx3j0I3rP8HkqHkvpYqxfROCZepqy0ruxMD61PVhcrOXRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IePsCInw3v+UIqRl3c2Efvxmhck3/Owje0yARtddRaI=;
 b=ri9/OyvUI1wBSVjl34QSF4APSlLNhjX/QCuhWbKBi7R3yyk+YBcfvuLEEMQzXoH/qlhUdc16tF59WnIjCbAbR+v6p+fUssEkd91TXcehxnB0p6uItB9ji7RLKmUE7pNYWZXpeA+9zEjmzzAQCsH79BEITMv67Ydn0++fPe79EQI=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by PA2PR04MB10513.eurprd04.prod.outlook.com (2603:10a6:102:416::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 11:35:30 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 11:35:30 +0000
From: Josua Mayer <josua@solid-run.com>
To: Damien Le Moal <dlemoal@kernel.org>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, Niklas Cassel <cassel@kernel.org>
CC: Klaus Kudielka <klaus.kudielka@gmail.com>
Subject: Re: [PATCH] ata: libahci_platform: Do not set mask_port_map when not
 needed
Thread-Topic: [PATCH] ata: libahci_platform: Do not set mask_port_map when not
 needed
Thread-Index: AQHbeTTR8njr9c79OUCDPzwXLUO+fbM7tl4A
Date: Fri, 7 Feb 2025 11:35:30 +0000
Message-ID: <b0636252-6d42-49bd-816e-6785e30fc1fc@solid-run.com>
References: <20250207074810.1433154-1-dlemoal@kernel.org>
In-Reply-To: <20250207074810.1433154-1-dlemoal@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|PA2PR04MB10513:EE_
x-ms-office365-filtering-correlation-id: 65b60445-e08d-4667-daf6-08dd476b86fd
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?UVY1U1JNQ0hOWFMvOVpFVndua04zMnlvVXJCRjZXaDlOaU5jR1J3Wk1aOXdx?=
 =?utf-8?B?SjRVMWJ3VkdWWjMxd2xlaER4Nk85eWxmWURmd1FLUWZLU0djVmJneFBMaDZw?=
 =?utf-8?B?MW9LL2tpREhmUitXc1ROZDZCM0lsYXdybyt0bmRxdVlMZHBnMTFZeFdXUjQ1?=
 =?utf-8?B?MTZqd3RnVHZKbHo0bXRkT1g2S0RiT2tqSXB6aXQ1ODhXQVpmVW9hckpYREV3?=
 =?utf-8?B?bm9rZlpHMExVTkpZYlE3TjJ5TEVjTG1KYjZ1NHRjOWIya3o0OWVKcGJsY1Q3?=
 =?utf-8?B?MzhPZGRVaUhzTSthVEw5K01mK2RIUDZoVm9yNFRBSHJQNXovZHErS1U3cnRY?=
 =?utf-8?B?V2MvRkw3YXVZYkNydjRWUHdSOXZjT1F4K0NCOHpHMDF2RVM5L0RkOWY2OXZ5?=
 =?utf-8?B?TXlMOWpoS1VFRE91ZDl2Z01wRVFzQS9YSzh5b3pCYmlrYUtSN1NGaStWSzZQ?=
 =?utf-8?B?MjVUVUZ4b05xVXdnaFVIRGN2dGl0M3EvZERLR2dBREVSZElDVTliT1BIZ201?=
 =?utf-8?B?OVJaUlJVT0ROaGVKSk5Lb1NjUUxJbytwWUhTeW1INVF2VlRKTFpzK1MxNTdY?=
 =?utf-8?B?a1NVZk9TdEczQ2RmY25hT1krbFF5RkRiS1l0bUFDcmlrVlVCeFloSWozUms2?=
 =?utf-8?B?cDZRRTl6M2xDKzE0ME1ubmMwVUxNUXBtaFBURCtiOWowRjBGT1BJLzl1L24r?=
 =?utf-8?B?Z0pLYWQwY1NNNFo1MWtKUDVvSnlobDZMQXYrS2tGSDRlS2RUbWJ6YlN0Wjls?=
 =?utf-8?B?K0lTODBpNXBhYUd5SHJFT2RrMW5KK1M4YUVLZkJuSjdISTRQdEZKNmZBNkdY?=
 =?utf-8?B?S1I3aE04SjFiSVpxTUJrbEJjUE4xVUh3cDVZcXlWbmVHb2tmaGNiRlYrc29O?=
 =?utf-8?B?L0IwbmxzajRqTUZUUExhZXAyVVh1Zmw2Qi95WkNUY09LUzBTVCtFdnIyaW5z?=
 =?utf-8?B?YXB3bXcyN0ZaTlJwbXJuSjZLbVhhTFJQcjdLNllTem5zRUVHRURJWTVmTm9O?=
 =?utf-8?B?Mjl3d2hYcUVEQ09iTElSelRNVmVZRkkvZjBKMnJYb2gwMGdEbCs4R2RoUFVS?=
 =?utf-8?B?aTlVbHJOL1NuVU5oMDBiUi9JQWdJVGZoalIrQlU3N0E2VlY0cEpTdENKYjBh?=
 =?utf-8?B?M2YrRzZrS3ByR2pacUNHc0dhb2NralNQZFlDTEpYVEZKbDB3OXBJVDFnTDRN?=
 =?utf-8?B?WmkyaUVkZmVuQWZlZmdzYTdBYjdkS2lLQTg5SEpSRS90dEdoOWVONExhWTRR?=
 =?utf-8?B?c0ZOVFZPKzRheGYzU0lJNzg0U3RzYVkrVGFNM3RxZGExYmxyTlcyRmNEK1Vq?=
 =?utf-8?B?bU9vZCsxYWhOVWZvM2hscGd1dFZJUTVtc0ZVcE5Bcy9HcU5FQnRhTmZuRDd3?=
 =?utf-8?B?akhwWGkvM3hHS1ZyY0pWUGIvcXVWbVk1V0tHQTlWY2xFMFJuOExJcTJtSEY2?=
 =?utf-8?B?d3BSWTk1SUdjYWRTK2NURzlWeXFidGthQjJUa3NQOGpwT0NkcDQrc1gvYkN3?=
 =?utf-8?B?aW1KTkNvNWRIQ0k3L01uMzZ6dG9RS3FKYnlFclltTXZCTjZOSlNMQTdEZWNK?=
 =?utf-8?B?L0JGK3FBK3FQU3gvc1V3UkwxM0JSdTZwTDE3NHJ3N2RvL1BnNFFwOFJtRHUr?=
 =?utf-8?B?eFR5QnVudWlxV2JHUUdObXNMRlliQ2Q3R01aZEtGbWQyQ3ErdytBM1FMWTQy?=
 =?utf-8?B?elhYSE84d0NPQWdwZnJWRjV6bEJEWWpydm1YL01mUHM2b2tRTy80WXBscmY0?=
 =?utf-8?B?Rlo4WWhTTTVRcDIybm1KZU93UGRVSFJaZHovSVhUNUhnVVl0ci9VcExjaTRs?=
 =?utf-8?B?RFRiVnp3Q0Zzdy9WREtHdVhtWXJQOFRHbkNtT2VrdHZXaStUdmg3MHFQUTd5?=
 =?utf-8?B?ejNqY2d2S2JaZ1NXQm52UnRTZE45MzYvL0RsWFI1Z1ZNZDB2aDg2Q05UcFJw?=
 =?utf-8?Q?l1w8hjMji5Wy83LHNyLUw73DmHdWSzbi?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?am5ITkhObElSSDJDSVJpMFo5L3VJVE4ycHNILzVXcW5JbVFSKy8xVGRyNm1h?=
 =?utf-8?B?L1FOU0h1UUkxekM3bWZ3QWtkRHltS0VPOWNyQi9sTG52ZXQydEN3dDkwSTgz?=
 =?utf-8?B?RnlTSFVqU1h4RlpDcW5MUmM4K3llQjNRSkgzb01LUmdjbDBzUytEZHJqazlU?=
 =?utf-8?B?R0xWREowRXFCV2JKTmk5czZlODFISVpIOEJ1Z0VIaDgxU0NyZmY2UllMRStB?=
 =?utf-8?B?aWlGVTNENzB3NTVqTE9RdmRTUEgvdWNhbFVCL2JaWkpVelROZ1lRVGM4dGtl?=
 =?utf-8?B?YnlRdlovTzNZNFJHM0JJVWN6MTcrM2JUd0JnODFQUzdpNGwvdDFxOWF0ZWNo?=
 =?utf-8?B?VGFVVXpUbCthSUhXdzI4WFNWdWxTLzFaSWxKVnJ3SEpxamNHby9YWkh6Vzkw?=
 =?utf-8?B?R1o2TnRaVFhyWTllRHRJVHZpT0JwTWx6UDBNUHdUNnUwR1c3NkovTTdvSDVE?=
 =?utf-8?B?ZWhxZ1JwVnRjb1J6dmpxanV5Rml3WVN3UWJsNkFhc0h0NTBKZ2tsQUJrcWRS?=
 =?utf-8?B?OTFnaUtSeC9sSzVOUit1OTJua2JYZFVtbGdSNDAvMHJrT1N0c1dmb1R4OXB3?=
 =?utf-8?B?aDI3eHNMb0k1elBNTEx6bHM4T2h3dzdla1R5YXcyV1lPUmVsS1ZaUFpoMkZm?=
 =?utf-8?B?ZjhBUk1GekZGUjR4RzZyYmc0MzFvVDdJYTY0MytZY1BuQjN0R2EwOWVWZ3hM?=
 =?utf-8?B?cFNwYnVsSW95OUc1QloyT3JEbHdPQm5lM2htNjRNVnlaeDZ5SHI0eXlDTXN6?=
 =?utf-8?B?SjBJeFYxQ3BSNDhkaEkyOW93ekVOMTArZGloQStMRmMrNlJNRzlHdUZrUFpX?=
 =?utf-8?B?Q05LNTVnV0RtVUNUMFRHbUVuYjk1dmJ4YVZkZDYzeWR4WEdiTUJ3SUJpU2l4?=
 =?utf-8?B?ajFjcDlGVWtwWmwyRDl5U2pzWmVjWHpFcUFQQ1RYQXBqMjJpM2lxRTNMWnk5?=
 =?utf-8?B?NThCTUhWNGdJS3BaTW5lekR5dkRIcmVZQ0hhaHczZDExQmUwOWpSVmsyQTI1?=
 =?utf-8?B?RSs1bFlublF6SlJ3M0RvNFJuTi9QWHV4K01WeWNZVldRdkRCbjRtNFZWS29L?=
 =?utf-8?B?VVBkeFUya3BEWElPQUJRemZySTBCVER0UUhwU1IxVi9HQW9qdndTRXM4MTZH?=
 =?utf-8?B?WXE1dktsOVBYbEVvODQwUjEwOWIvUmZQdnNLbEtDWG4xTjYvSTVMMG9BQSts?=
 =?utf-8?B?bFQvR2lEOXdoY0RJSFN3VmU5S0d1S1p4Z3B5Q09Sa1dQRUNUc1BnT0hVSUEz?=
 =?utf-8?B?ZWo5bVRxcTVvb2x4Q0ZSVWNadGdoU1k1c0NQdjY3NFgwL1BLK1NkSVVQNWR3?=
 =?utf-8?B?VFJ2b0dzZHRYSzQ0Q2FVQVYyRi9GNVh3T0E2RXorb01SQzZJUEh5ekhrMEh1?=
 =?utf-8?B?MS9LaENkMkd4VFI0Wm5ncEhiRXNkSG8xV09WbytnbmdBU0RTK0NYaXdheUhw?=
 =?utf-8?B?RkdFYTZ4Z2ZoRkJnZ1c3MFVmQ2tWLzI2U0pacmJKR1QvMWFVWnNuM2pubjgw?=
 =?utf-8?B?czgwaEhzWWdRN0RVRjh0dWoxaUdXV2Z1OFk2T1MwQWdGS1JwbSt5RkNrckgz?=
 =?utf-8?B?VG1OZHVCQm9ZRVRRdWkxM1ZIM2xVZDd1clBqMGVsNWJ5SjJOWkV5cG0yb3NQ?=
 =?utf-8?B?NXlvVWxJM1ZxWVpkaUVibXdYb0lKNFRGQ3JLa1YxMUdxRjRCY3BOT2tHaXpC?=
 =?utf-8?B?ZzJXdHRyTnUxUHBGQUQveTNHRXY4bHpoemlNaUEyTXgxZFRCNVJiM2VtSDlQ?=
 =?utf-8?B?dloyZSsrQ3Jzamk1Q1BGNTZ5OElkYWVyU3ExSlVCdXVId080ODNkbjN3ZVhw?=
 =?utf-8?B?UXpwK0lJcUo1OHM5VGEveUJsTTBRcmZFRFg2Y2JMZTQyNjRxNFlnaUpxSUpZ?=
 =?utf-8?B?dkxWVkdERnIvTFNJV051SFlLaHZ2dVM2aFBmSStkUWZhOGEvQ2ZKUW9abmZl?=
 =?utf-8?B?UHhXMTllYjk0Wi9hYlJiaXNvb3ZTWFhOb0ozYTBXL09nc09ZYkRWK2dTMFRn?=
 =?utf-8?B?aEVGWWE5SXIvenR6MGQvb2N1N3dQeU1DUThLL2tLTWF2WU5WZ3pZdU0wVUNR?=
 =?utf-8?B?ZGhZTEhrYm0rY3Z2bkZrUWY2d1N4MFZtMklwb3ppby9KdG5NSlZDbGk1Z0Zx?=
 =?utf-8?Q?lZPDLyhxkwbFpFm7QSnkBtQkH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <3B577074CC09E74FAFF1F5D973FF37BB@eurprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65b60445-e08d-4667-daf6-08dd476b86fd
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 11:35:30.7763
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oSNv34/IOd8UDFdubFrp3otZKTp8aY+9uupmDrcrm6ziSVoBTjWViTzu1QZkppeT/eoogsvJBat2H/LisbGDkA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10513

SGkgRGFtaWVuLA0KDQpBbSAwNy4wMi4yNSB1bSAwODo0OCBzY2hyaWViIERhbWllbiBMZSBNb2Fs
Og0KPiBDb21taXQgOGM4NzIxNWRkM2EyICgiYXRhOiBsaWJhaGNpX3BsYXRmb3JtOiBzdXBwb3J0
IG5vbi1jb25zZWN1dGl2ZQ0KPiBwb3J0IG51bWJlcnMiKSBtb2RpZmllZCBhaGNpX3BsYXRmb3Jt
X2dldF9yZXNvdXJjZXMoKSB0byBhbGxvdw0KPiBpZGVudGlmeWluZyB0aGUgcG9ydHMgb2YgYSBj
b250cm9sbGVyIHRoYXQgYXJlIGRlZmluZWQgYXMgY2hpbGQgbm9kZXMgb2YNCj4gdGhlIGNvbnRy
b2xsZXIgbm9kZSBpbiBvcmRlciB0byBzdXBwb3J0IG5vbi1jb25zZWN1dGl2ZSBwb3J0IG51bWJl
cnMgKGFzDQo+IGRlZmluZWQgYnkgdGhlIHBsYXRmb3JtIGRldmljZSB0cmVlKS4NCj4NCj4gSG93
ZXZlciwgdGhpcyBjb21taXQgYWxzbyBlcnJvbmVvdXNseSBzZXRzIGJpdHMgMCBvZg0KPiBocHJp
di0+bWFza19wb3J0X21hcCB3aGVuIHRoZSBwbGF0Zm9ybSBkZXZpY2VzIHRyZWUgZG9lcyBub3Qg
ZGVmaW5lIHBvcnQNCj4gY2hpbGQgbm9kZXMsIHRvIG1hdGNoIHRoZSBmYWN0IHRoYXQgdGhlIHRl
bXBvcmFyeSBkZWZhdWx0IG51bWJlciBvZg0KPiBwb3J0cyB1c2VkIGluIHRoYXQgY2FzZSBpcyAx
Lg0KQW5kIHRvIG1hdGNoIHRoZSBmYWN0IHRoYXQgb25seSBpbmRleCAwIG9mIGhwcml2LT5waHlz
WzBdIHdhcyBpbml0aWFsaXplZA0KZnJvbSBjYWxsaW5nIGludG8gYWhjaV9wbGF0Zm9ybV9nZXRf
cGh5Lg0KPiBEb2luZyBzbyBjYXVzZXMgYWhjaV9wbGF0Zm9ybV9pbml0X2hvc3QoKQ0KPiB0byBp
bml0aWFsaXplIGFuZCBwcm9iZSBvbmx5IHRoZSBmaXJzdCBwb3J0LCBldmVuIGlmIHRoZSBjb250
cm9sbGVyIGhhcw0KPiBtdWx0aXBsZSBwb3J0cyAodGhhdCBhcmUgbm90IGRlZmluZWQgdGhyb3Vn
aCB0aGUgcGxhdGZvcm0gRFQpLg0KPg0KPiBGaXggdGhpcyBieSByZW1vdmluZyBzZXR0aW5nIGJp
dCAwIG9mIGhwcml2LT5tYXNrX3BvcnRfbWFwIHdoZW4gdGhlDQo+IHBsYXRmb3JtIGRldmljZXMg
dHJlZSBkb2VzIG5vdCBkZWZpbmUgcG9ydCBjaGlsZCBub2Rlcy4NCj4NCj4gUmVwb3J0ZWQtYnk6
IEtsYXVzIEt1ZGllbGthIDxrbGF1cy5rdWRpZWxrYUBnbWFpbC5jb20+DQo+IEZpeGVzOiA4Yzg3
MjE1ZGQzYTIgKCJhdGE6IGxpYmFoY2lfcGxhdGZvcm06IHN1cHBvcnQgbm9uLWNvbnNlY3V0aXZl
IHBvcnQgbnVtYmVycyIpDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+IFRlc3RlZC1i
eTogS2xhdXMgS3VkaWVsa2EgPGtsYXVzLmt1ZGllbGthQGdtYWlsLmNvbT4NCj4gU2lnbmVkLW9m
Zi1ieTogRGFtaWVuIExlIE1vYWwgPGRsZW1vYWxAa2VybmVsLm9yZz4NCj4gLS0tDQo+ICBkcml2
ZXJzL2F0YS9saWJhaGNpX3BsYXRmb3JtLmMgfCAyIC0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBk
ZWxldGlvbnMoLSkNCj4NCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZv
cm0uYyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPiBpbmRleCA1M2IyYzc3MTlk
YzUuLjkxZDQ0MzAyZWFjOSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9hdGEvbGliYWhjaV9wbGF0
Zm9ybS5jDQo+ICsrKyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPiBAQCAtNjUx
LDggKzY1MSw2IEBAIHN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqYWhjaV9wbGF0Zm9ybV9nZXRfcmVz
b3VyY2VzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+ICAJCSAqIElmIG5vIHN1Yi1u
b2RlIHdhcyBmb3VuZCwga2VlcCB0aGlzIGZvciBkZXZpY2UgdHJlZQ0KPiAgCQkgKiBjb21wYXRp
YmlsaXR5DQo+ICAJCSAqLw0KPiAtCQlocHJpdi0+bWFza19wb3J0X21hcCB8PSBCSVQoMCk7DQo+
IC0NCj4gIAkJcmMgPSBhaGNpX3BsYXRmb3JtX2dldF9waHkoaHByaXYsIDAsIGRldiwgZGV2LT5v
Zl9ub2RlKTsNCg0KVGhpcyBmdW5jdGlvbiBpbml0aWFsaXplcyBocHJpdi0+cGh5c1swXSwgYW5k
IG9ubHkgYXQgaW5kZXggMC4NCg0KSSBhbSBub3QgYXdhcmUgd2hldGhlciBvciBub3QgdGhpcyBj
YXVzZXMgYW55IGlzc3VlLA0KdGhlcmVmb3JlIG5vIHN0cm9uZyBvYmplY3Rpb24gdG8gcmVzdG9y
aW5nIG9yaWdpbmFsIGJlaGF2aW91ci4NCg0KPiAgCQlpZiAocmMpDQo+ICAJCQlnb3RvIGVycl9v
dXQ7DQpzaW5jZXJlbHkNCkpvc3VhIE1heWVyDQo=
