Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11023109.outbound.protection.outlook.com [52.101.67.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DE7A63D;
	Fri,  7 Feb 2025 11:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738927360; cv=fail; b=uHGGbUhmgRD4QKqBUlkKrXFG9an5l4WShWJpU68ziO4LdlRztV3PVbQcgC2FDdFsyaIl68DT2WyWwNellLWK4rLCyh+JjweccQrhmEm4bbAtUKwIlAZ/uY9aZlg1mAJFOe0ikod6wam/ROL7X3DBinm0LNV4bgDvUs6huxMMZAc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738927360; c=relaxed/simple;
	bh=Samk3wx15HUZQtsaJw7Sl6XOhk4MHRoIfPWqXJwk85Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4voJ5EHLWYpfMyXEPGIE9YJKT+lk5EYXFvCCKZ6WTTp0BTEk9v3hZcw/1dGkINq9P0G4KXnX+JsEo3sGVNy/zm9uctUDJNUB6yGaqdrMF6gqguqF6ViSVnBvQEJ9b9ZXWEirHxWOGnZFxi8FEcxhmjyJy5p/4KjRNJ4sGBYPk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=EXUizxex; arc=fail smtp.client-ip=52.101.67.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="EXUizxex"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hLnnCgNkvoU2GqqB9KhSGEjM9+JAuFxfkACEncbEu1V0nkJHhZujFtZA5BqUnhKG7EP1qyw/m3ygdbSnEvTMlS7VDPuoDO52SalF4iZoV2OrQ8fE6rcS/dC86z4zn8j2PKdIMzzXml/FpCS14SMjBJqHWKO7DInQ0CTaTUJFyZLL74LkBGW/Kz/qIqU5ASY0RBwq70TVeas9LDKA9XPyEs4Y0qymGA18KN8JiA4Y7JP4d5+TKOKIJRo7Q2zx5u37IL7S3iHjul8mHb/XQTrB/LdMUNnvlMQbyYInanJ6ogeGtZ2qjN+uE8RlhREBylRuw7iNvs86OX+zGyVsLTjK5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Samk3wx15HUZQtsaJw7Sl6XOhk4MHRoIfPWqXJwk85Q=;
 b=QnXLnS+PCMp6fVuou1VO08rWOx/+gGQEyqHT35xycMPp0Dfh3PeWQnWsP9lbW4kvtCKdO92BpmNMyl5gHD8XjqvLur8SEEhjyWWnxFQYMAnW16+Ys89nzibFtGun2lJkh/ufQZ00IqwsPcOjRWLtRXVi8ccCwvt0OIu/EdxUz+GIYMgyuMSGhIBz/w0g338q/lyUoyj29yAu/mnFNB43Zyg0lkeMnIYTZ2h6Lx1a9cHgvefIkoif/YZ1zdGXlgF4CB46Bhmu519ODrq0KzlbLbPVmIp0Q9CsbW/M8B2edgOfRmo6ECK3IJd9dLOedSvtfxLLKEnnuBhSF7lsYx5SzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Samk3wx15HUZQtsaJw7Sl6XOhk4MHRoIfPWqXJwk85Q=;
 b=EXUizxexM/5AePSOssufzB4JiGVD2csh62QOLTHbe5Y1h97lJ9L2h6nJ7KuHoSq6SYwSbMnV9riNeoPYdXKRR6PG/FCAPBwsk4T3MqAg3XOBd3SxSCwLYmQzybgHgu66m7bcYTV8O53yuHLpCRPFIZvdeHwz0AYecaGnY9UkkkY=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU0PR04MB9394.eurprd04.prod.outlook.com (2603:10a6:10:359::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.11; Fri, 7 Feb
 2025 11:22:34 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.012; Fri, 7 Feb 2025
 11:22:34 +0000
From: Josua Mayer <josua@solid-run.com>
To: Klaus Kudielka <klaus.kudielka@gmail.com>, Damien Le Moal
	<dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, Hans de Goede
	<hdegoede@redhat.com>
CC: Jon Nettleton <jon@solid-run.com>, Mikhail Anikin
	<mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>,
	Rabeeh Khoury <rabeeh@solid-run.com>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
Thread-Topic: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
Thread-Index: AQHbXEaYxc+CL4CCMEqQqo4+duelkLM5OA2AgAB+CYCAAR8SgIABF3SA
Date: Fri, 7 Feb 2025 11:22:33 +0000
Message-ID: <08981396-59d9-4be6-91c7-83421706931a@solid-run.com>
References:
 <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
 <bcfa145c3227b13e7b9d8bb3b0f92c678464cfdc.camel@gmail.com>
 <fa54a148-6016-429b-b494-490041564e51@kernel.org>
 <016bbf83fec9a0a7c7697462ce0970b94572f50c.camel@gmail.com>
In-Reply-To: <016bbf83fec9a0a7c7697462ce0970b94572f50c.camel@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|DU0PR04MB9394:EE_
x-ms-office365-filtering-correlation-id: c7fad20c-9ad7-4a23-f5ae-08dd4769b7fe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?SUlycnNRaEtFVnVyL0J2dlJ0ZCtwN2tNWWg2SDkzazdHL1hnZTN5RG5DdXJ1?=
 =?utf-8?B?bXRxL3dEWDdzSmR0RDlBM1Y3cytBTmt2cy96ejlPSThpWFlicy9abWFDcFFW?=
 =?utf-8?B?YlJ1Ri9IeHBmOFF3dGF6RXA5QUZ0dXJWakxKZFhoWU1HQXBlaU1zSnE2ZVJH?=
 =?utf-8?B?aS9SSmFPYWFkVURyc3VHd2FJdjdoVnNtVE9kb1JrZjVuZ3lKV1Y3M1o2Yzdt?=
 =?utf-8?B?bnZ0UlM3RVBNV0xGWXNiYjBEdGlwci9ENTljTDh0V1h6NmQyTWZnRkFKZFpP?=
 =?utf-8?B?SDNCOWtmaWN2WWU3U1lRTjNuYlI3a0J5VWFMMXREdTNIakRmQ0U2OEdOUGkz?=
 =?utf-8?B?VFJtZmR5aldtWUhzVmtVbHBOYTRhSzBsTG5YTngwVFFqRVBtWG1RNFVrc1Bi?=
 =?utf-8?B?azFEcHpxMkdra3lIRmRsSmNDdmZ2U2FMVjVrVUpSbmFYcGtXYnJXdW9kYkFK?=
 =?utf-8?B?M2tYV1hjTEV6RGVYdEZkVEVVRVpmLzY0aFVCd3lnUll2QlRKQUVXblJTTGlE?=
 =?utf-8?B?WU92N3lZdzQ1R21sSmRQZTBnengrME9GdnFzc0xwbFZnV242b21Qa0JWYkto?=
 =?utf-8?B?N1Z2OWlxSXV0RWxRTS85SjdIM01Ya04zZDlVa0R4SFVFYlFQT2tndHk2bHJn?=
 =?utf-8?B?RmZEeDN4bVN3aHNMVFp2Z3RqUkhXaVR5ckFWYUVGQXVtK2RRcndJKzdiK3BG?=
 =?utf-8?B?Mk9TMnB0VFcxZUtZa2NVRDZidXF0RDh5Z2VPSUdZcTVoOWtOcjRRc3g4aGF0?=
 =?utf-8?B?Rm1Ta0Q2Y0xFcnR2d1pycTZkMGxuNTUxQ29xSXd1Zyt4TVU3c3NiMkI2UEtz?=
 =?utf-8?B?KzRzVzNiZWtzT0JaU1lXUVYxN0dOdzhQRUhXdDhLYlVLcWE5WDFqNk8vZzk2?=
 =?utf-8?B?dnpkalowU01xa1dORE1KRjgyQU9sVWhmcy9KYW1hb1pWa3BwR0oydWRMSjhF?=
 =?utf-8?B?SWFMb0Z0eWczMGx4TDBETUpSWmllQlNJSUEvUUpIQUFVL2RDanZpK2JtREIr?=
 =?utf-8?B?cVpZRlhnc1pnSGQxVlVWSDNsM1Mrb2N3ZDVyVFdTRjNFUitDR1dIcXdhYlZt?=
 =?utf-8?B?NWFPVk9WVHpGWW5DaXFMd0M0Q0o0QkU1NUV1OW1zV3lvUmtacE8zYzNIVHF1?=
 =?utf-8?B?WUhSZUxWNHhRVUdqb2dMWDcxRWxPVXVpWHpwMG9iOFRreFc2a25KQkswb1lM?=
 =?utf-8?B?eUYvVkZFRVlLenh2Z3E5UlIyMkw4K21zV0pmMGZleG9kK3FheXFiWDhoc2d4?=
 =?utf-8?B?VzNuMU9sZ0FVd2JBV3RNc2xQQThwNGNGRzBtSm53anNzVE9EM3dwbjBOWXYx?=
 =?utf-8?B?UFdWTWpiWTJ1anQrVkNPcGlhV2R1UG1pM3VZRVA5eGZuY0JzMzhlM08yeThj?=
 =?utf-8?B?MDBYVklLZ003ZnVranE2SzNvS1k4RVpUY2xleXdvbGcyQ1B2SFIyekhDL0dz?=
 =?utf-8?B?bFgrWG1kVjJQeWhOL2UrZ09heEpZQ3hQcWJneHZDdjl0VUtaUi9rK29sS1g3?=
 =?utf-8?B?SkQxVWl1ZE5tYWtidHBrV2NzdU1LZG9rMU9LSW5IL1U4Tk5SSkNwNnNTVmpV?=
 =?utf-8?B?Q1d6RHJQdkhRQVZYTnVUU3RRZU5pcmVIbjFQRkpMSHI5WnZkVklVUmI4ZS9Y?=
 =?utf-8?B?ZFlEd25hQjI3RC92ckhrcHFnSkNSUVZZYnZJK1JOZ2NydkowZjNoMEpsU1lC?=
 =?utf-8?B?R2VVYWp6azh1cDNXcC82bkUwT2NhSFFRMTA4eTZnTVNvMDUyQ0dSU1MzeUlX?=
 =?utf-8?B?QUFOc1hxOWtUTThla2s4RUJhQ2p5RzQ0a3pvR2hjVFErbWs5VER2TENIS2VN?=
 =?utf-8?B?MFBteWhId1FEMWdDaDJER0poTVRTMm83YjNoT0RHNDdlWGNTSkd4WG5icy91?=
 =?utf-8?Q?UcriRdarYf6Ns?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?T3JoV3EycFNBK3FINnVMMS9mOWFFMjlOSFBNbHVYYVBNaWNOZ3dHb0ZudnpU?=
 =?utf-8?B?RElwNjNWRWovTFU2L1ZCMnhJQnQ0bFBkblpDam9nWndiMG5HS3ZGdDBRVjVR?=
 =?utf-8?B?dmNKSkluSytybERvKzVsZ3M5ay9VTTNiR0UvdUZSSU5ZZ25CS2d6QTNFMkYr?=
 =?utf-8?B?eXkvRXVLeElqUmd4NFNRQk05YXFFTk5FWkE3WE8rZTVtbitiL2ZLdjBkUjFn?=
 =?utf-8?B?Nkh0MHk0M1ZPcU9BVG5JUHF6N2ZJZjNCOEhub2NpS0I1QmZjZUFIeEtFK01x?=
 =?utf-8?B?RERnUFdSdGNWSzVSUTVUTnh0d2E3K3pIdnE1d1VWbDZsTHRhclE0cFJ3UGt1?=
 =?utf-8?B?SGl1alpMRGJoamllL29jTkhiRThSQ3k2T2RENHJYVGwxOWhNT2dlK1luaWRU?=
 =?utf-8?B?d3BIeWFYRFFvcEpkTnhmVjFFbnpCNWdNenVONGp6SENUM2t6R0ZjU3FmOW1E?=
 =?utf-8?B?SUVmUHBPWU5nSDZERDAxSTFCQkZLai9BY3NtUWl0NTJlcVdFdnEzS3dpbUFx?=
 =?utf-8?B?Q29OdzVMbjdNeVhCazVQYjBqSHVZNk9DOWtzU0QvYzRPb3oyWG9kNlJmQ1Zs?=
 =?utf-8?B?YzNaMzlaeHVqelArSzBWbVl6YkZ0clgwS0h2WDV5ZmlUd0NMY3FtSEVJZE0z?=
 =?utf-8?B?R2F5NVZIcUlZQ0lxY2xEL0U0MmhzTW94Yk5uemFyZXloV05jZVpoRjFBeVYv?=
 =?utf-8?B?WTA0N0FRcGswekRvV0ZiQk5mYUVRTWRQemJneitKcUVQbDZ1QzlPbGI0WVFn?=
 =?utf-8?B?QjR0TzBZWDBxaFR2TDJwSTQ5ZnlNelVBUUJQZnRlVU5GT2tid1BpTmQ2MzBr?=
 =?utf-8?B?eHh5Mi91OERXak1vU2loRFpVRmFQU0MyR1NuZVBIN3A4ZmNLL3hwNWsrd05r?=
 =?utf-8?B?RzN6aE9hTm93M2F3OVI4MDZ2SWhCblpwSTJKU2sveFBLdlljekNVQ1llMnVX?=
 =?utf-8?B?WEFvbVN5TC9iYm9uVGFVVXYxaVFybis1UVRsVU40bTlhYXl6SlN2ekxSUVNr?=
 =?utf-8?B?LzdnYTlhK3BKTk9xcW83cjNXMkgxZHNWSGFuZldEMGh0UEFjS3RCekMwTnRq?=
 =?utf-8?B?bmU1Q0lKOUZYZ0xZN3ExdmU4U3AwdkdBbnZkYVQ2aWZWMXVyR2dvM1I4WXJP?=
 =?utf-8?B?K3UrMTJJSXMvbG1lcldpKzMxM2M5UVREb2ovSVRTTmxqUFJtTENOVjY5MFN6?=
 =?utf-8?B?ODYzQVp4U1JlRFQ5czBzcndpdzNaakN5UHVOMGJyUEtSR3A5SlNnMHpYbkp3?=
 =?utf-8?B?NWFwODY1Rkc1eU84TkJLK1d5ZDlMYjlZTUVBaEVFYUdYdnF2d3dkZEpYK0xl?=
 =?utf-8?B?WnBRVTZtVXZDL0RyMzRUUG1GMmtJcUJUOHR6dDJIc3pOVWY2YkRpK1drT2Qr?=
 =?utf-8?B?VXFNNDBDZFdGYTcvVmowaGNwZ1loTWY0alpVMjRvSjZRWVM0bVlDZEw3ME5L?=
 =?utf-8?B?Zmo4WE41RDU5U2JoNEtoeFp2MXRBcUszZEw3elVTSkdVU1VOb2ZCejJ0OUVs?=
 =?utf-8?B?eG9sdXlnRjJUSVRiSkZwQ2Y0L3pHQkpaM2tnOFBmeDdLeE1JSnlJVVhrVVRn?=
 =?utf-8?B?TXo1cXdWbFlUam1ac0VSbXJ6TktOTDNhbW4ybXV1QTFPdDVKc29CSzVjdEJ5?=
 =?utf-8?B?emtMK2ZoU1dDcnk1Vkk2MDZFZjNjT2s1cXUwbHhTeFpSUURzOFdnbHJ1cWVt?=
 =?utf-8?B?NmpHNXRIcWNYUms0UVgvaG5hVkJxbU0vMHVnRSs2aXlJT3M4NjhUaXRmVHJH?=
 =?utf-8?B?MDZyODVRUnN3WXFnZjJqK3N0UjNHcC9ENURLZU5rLzlQalNwdHhjSkQzZ2Zv?=
 =?utf-8?B?N1lhcWNOSFN2UENURDBTWi82QkdPYUtxSmRieDlKSkZrUEw4cTBNZDUxdnVL?=
 =?utf-8?B?b2ZHVjNxM0NJMW5FODR6ZHRCRC9SN0crTDMyaDFEeWRtOUFDN0dqOVJxUkM3?=
 =?utf-8?B?VTJTaS9mTXg3VTNhTkxOU2UyNUlSeHFacUNRbHlVS0RGa2pya2RKRW9EM21W?=
 =?utf-8?B?VjJzNE9iU2RYNXNQYk4zQlQ5Mm11RTBiRVE5b2dKYTZ6UFZnZmVReXplcWd2?=
 =?utf-8?B?WWROdURiWUpXTm1rS2xSR0JiY0NtWWNYcGY4K3o5cHlPa1NWK2g4T1o2UEVj?=
 =?utf-8?Q?0dnbdryCVAMvQc4voU3yokTQz?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D0BBFA0C7E74F4EB905209D141F3DA1@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c7fad20c-9ad7-4a23-f5ae-08dd4769b7fe
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Feb 2025 11:22:34.0040
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: drKCK7cJj1epJ0Zx+o1NqLZUCvTlgjdbA2pLUiVlC9JxOAqH1a/dj2CsLx0P5NC9MEZ8Al0L5H1NxOI/RTD67g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR04MB9394

DQpBbSAwNi4wMi4yNSB1bSAxOTo0MiBzY2hyaWViIEtsYXVzIEt1ZGllbGthOg0KPiBPbiBUaHUs
IDIwMjUtMDItMDYgYXQgMTA6MzQgKzA5MDAsIERhbWllbiBMZSBNb2FsIHdyb3RlOg0KPj4gQ2Fu
IHlvdSB0cnkgdGhpcyB0byBzZWUgaWYgaXQgcmVzdG9yZXMgdGhlIHByb2JlIGZvciB0aGUgc2Vj
b25kIHBvcnQ6DQo+Pg0KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZv
cm0uYyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPj4gaW5kZXggNTNiMmM3NzE5
ZGM1Li45MWQ0NDMwMmVhYzkgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL2F0YS9saWJhaGNpX3Bs
YXRmb3JtLmMNCj4+ICsrKyBiL2RyaXZlcnMvYXRhL2xpYmFoY2lfcGxhdGZvcm0uYw0KPj4gQEAg
LTY1MSw4ICs2NTEsNiBAQCBzdHJ1Y3QgYWhjaV9ob3N0X3ByaXYgKmFoY2lfcGxhdGZvcm1fZ2V0
X3Jlc291cmNlcyhzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2LA0KPj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqAgKiBJZiBubyBzdWItbm9kZSB3YXMgZm91bmQsIGtlZXAgdGhp
cyBmb3IgZGV2aWNlIHRyZWUNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICog
Y29tcGF0aWJpbGl0eQ0KPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgKi8NCj4+
IC3CoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGhwcml2LT5tYXNrX3BvcnRfbWFwIHw9IEJJ
VCgwKTsNCj4+IC0NCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCByYyA9IGFoY2lf
cGxhdGZvcm1fZ2V0X3BoeShocHJpdiwgMCwgZGV2LCBkZXYtPm9mX25vZGUpOw0KPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGlmIChyYykNCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgZ290byBlcnJfb3V0Ow0KPj4NCj4+DQo+IFllcywg
aXQgZG9lcy4NCj4NCj4gNi4xNC4wLXJjMSAocGx1cyBwYXRjaCBhYm92ZSkgYm9vdGxvZw0KPiA9
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09DQo+DQo+IEZlYiAwNiAxOTozMTo1
MSBzcGFyZSBrZXJuZWw6IGFoY2ktbXZlYnUgZjEwYTgwMDAuc2F0YTogQUhDSSB2ZXJzIDAwMDEu
MDAwMCwgMzIgY29tbWFuZCBzbG90cywgNiBHYnBzLCBwbGF0Zm9ybSBtb2RlDQo+IEZlYiAwNiAx
OTozMTo1MSBzcGFyZSBrZXJuZWw6IGFoY2ktbXZlYnUgZjEwYTgwMDAuc2F0YTogMi8yIHBvcnRz
IGltcGxlbWVudGVkIChwb3J0IG1hc2sgMHgzKQ0KPiBGZWIgMDYgMTk6MzE6NTEgc3BhcmUga2Vy
bmVsOiBhaGNpLW12ZWJ1IGYxMGE4MDAwLnNhdGE6IGZsYWdzOiA2NGJpdCBuY3Egc250ZiBsZWQg
b25seSBwbXAgZmJzIHBpbyBzbHVtIHBhcnQgc3hzIA0KPiBGZWIgMDYgMTk6MzE6NTEgc3BhcmUg
a2VybmVsOiBzY3NpIGhvc3QwOiBhaGNpLW12ZWJ1DQo+IEZlYiAwNiAxOTozMTo1MSBzcGFyZSBr
ZXJuZWw6IHNjc2kgaG9zdDE6IGFoY2ktbXZlYnUNCj4gRmViIDA2IDE5OjMxOjUxIHNwYXJlIGtl
cm5lbDogYXRhMTogU0FUQSBtYXggVURNQS8xMzMgbW1pbyBbbWVtIDB4ZjEwYTgwMDAtMHhmMTBh
OWZmZl0gcG9ydCAweDEwMCBpcnEgNDAgbHBtLXBvbCAwDQo+IEZlYiAwNiAxOTozMTo1MSBzcGFy
ZSBrZXJuZWw6IGF0YTI6IFNBVEEgbWF4IFVETUEvMTMzIG1taW8gW21lbSAweGYxMGE4MDAwLTB4
ZjEwYTlmZmZdIHBvcnQgMHgxODAgaXJxIDQwIGxwbS1wb2wgMA0KDQpDYW4geW91IGNvbmZpcm0g
dGhlIHBoeXNpY2FsIG51bWJlciBvZiBzYXRhIHBvcnRzIG9uIHlvdXIgYm9hcmQ/DQoNClF1aWNr
IHJldmlldyBvZiB1LWJvb3Qgc291cmNlcyBzdWdnZXN0cyBpdCBpcyBvbmx5IGEgc2luZ2xlIHBv
cnQsDQptdXhlZCBvbiBzZXJkZXMgIzAsIHdoaWxlIHRoZSBjb250cm9sbGVyIGhhcyB0d286DQoN
Cmh0dHBzOi8vc291cmNlLmRlbnguZGUvdS1ib290L3UtYm9vdC8tL2Jsb2IvdjIwMjUuMDEvYm9h
cmQvQ1ouTklDL3R1cnJpc19vbW5pYS90dXJyaXNfb21uaWEuYyNMNDE4DQoNCj4gRmViIDA1IDE4
OjM2OjQwIHh4eHgga2VybmVsOiBhaGNpLW12ZWJ1IGYxMGE4MDAwLnNhdGE6IDEvMiBwb3J0cyBp
bXBsZW1lbnRlZCAocG9ydCBtYXNrIDB4MSkNCj4gLi4uDQo+IEZlYiAwNSAxODozNjo0MCB4eHh4
IGtlcm5lbDogYXRhMjogRFVNTVkNCg0KVGhpcyBpcyBjbGVhcmx5IHJlc3VsdCBvZiBteSBwYXRj
aCBtYXNraW5nIG9ubHkgcG9ydCAxLg0KDQpJIHdvdWxkIGJlIGN1cmlvdXMgd2hldGhlciBpbiBh
bm90aGVyIGJvYXJkIHRoYXQgaGFzIHR3byBwb3J0cyBwaHlzaWNhbGx5LA0Kd2hldGhlciBib3Ro
IG9mIHRoZW0gd2VyZSBmdW5jdGlvbmFsIGJlZm9yZSBteSBwYXRjaC4NCg0KU2VlIGUuZy4gSGVs
aW9zLTQgRFRTIGJhc2VkIG9uIEFybWFkYSAzODggKHNpbWlsYXIgVHVycmlzIE9tbmlhKQ0KZXhw
bGljaXRseSBzcGVjaWZpZXMgdHdvIHBvcnRzIGJlbG93IHRoZSBzYXRhIG5vZGU6DQoNCsKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2F0YUBhODAwMCB7DQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgc3RhdHVzID0gIm9rYXkiOw0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNh
ZGRyZXNzLWNlbGxzID0gPDE+Ow0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICNzaXpl
LWNlbGxzID0gPDA+Ow0KDQrCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc2F0YTA6IHNh
dGEtcG9ydEAwIHsNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9
IDwwPjsNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KDQrCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqAgc2F0YTE6IHNhdGEtcG9ydEAxIHsNCsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJlZyA9IDwxPjsNCsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB9Ow0KwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB9Ow0KDQpJIHByb3Bvc2UgdGhhdCBw
ZXJoYXBzIGZvciB0aGUgc2Vjb25kIHBvcnQgZXhwbGljaXQgbm9kZSB3YXMgcmVxdWlyZWQuDQoN
Cg==
