Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2094.outbound.protection.outlook.com [40.107.20.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6CF1F9EA2;
	Wed, 27 Nov 2024 11:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732708335; cv=fail; b=Dt2hYzY6jnyUpx2ERO6A1a4ifx7rNIdeW68jQajx7qqMGEZGweWC/66KEisDmwzREtn/SLGEshYnInVtezCjyvMjT30Hhw4Y27TB8IMgpa1rmJioVIRNe/gBxfJ5s0XPaQ0LLT7gq1rqHvN9S8zo1QKZwDJHZFvgFCEIN5QlHwc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732708335; c=relaxed/simple;
	bh=byAe/VE/3TXC/HoSIf2FoDC+851HOkgTBVaITZ+OKGM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pmRLwRdgS5fWDgbAJFtNdXU1aRsqrW+3O+b6ICYUs70VuhyphzsXbLtYPm/ZoqEYHzcyAe7yok7BW6WduQ8Gh/zbdk4uuWNloQ5Yl0+fgbmOigTIR67DtTsptd6zU7Txu0P1VFWs+FXaSbsLjozgSn2p9WaOX6onpmPfFhtgKko=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=HCVjnbNV; arc=fail smtp.client-ip=40.107.20.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="HCVjnbNV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sws3ODKxE6S5IU7fyuCLl8+bKN9mcCPOqXAOhcrSFf1bF4YHnj4/oNoG/TKPeA16om6+duWfvSXihb8io18okbn6Hmkbp4cpjDIKspgcBNb1Hv3WPhc2XdI7KvtOddtB/40ErRd140XAoV63U1cgpxFzhrAPsaGQ54KIFdKfd4lvbNUK3wa0bKKZc+x9ointdPxcjlQjIfbJ8lY1QekzDqB2Fav7L4avOadAsnntXLPURlIozNncDlyojXrIwyH9gBoErCZVvKoZlOZe2uNgEROsvfd4ImzOm1SKEhnHDG5sKI/kcAayL8lV5WlkPAF8dZ8skW2vkJ6rGEF6lFdXIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=byAe/VE/3TXC/HoSIf2FoDC+851HOkgTBVaITZ+OKGM=;
 b=XmuLUW73KtXYnp952yd8Z3X7bnts5cPL56z1YPYcczqWEZCzCA0qtkGSTv76+KC77E4SYDtSxKtKldwVsVxI0NgAQoavEtuJF7Xli2AZYSZVauJRLk7IwDXWIDn230raZ2IjL2BLZVGf8jSuGx4qN/5yND7AGfS4wu69P6DgPyoaA1qG9PPKBSkDdX541ej8crYuMfwxt92itllEfdxP0/flF2l2hvbeh2RJf50aAJWoP/MYLY3WkNeNjCeSVnzI9FRdpuDbdf2k/np8iJSJmpJB6LUUmYrvkHXCi1qkMGgSEYF4wQJws4ozfzz05ktft6hHeaBde/AQW9/1qwAh/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=byAe/VE/3TXC/HoSIf2FoDC+851HOkgTBVaITZ+OKGM=;
 b=HCVjnbNVOJ2AfWaDr6gEfSQIE7ARZIIgpw06FJcbXHyU3Kxs1R9nXSvBiht0+7Nus+FyZbUB+TFFEieFjN3DM1a2pu0uQ7XfYFl6PPRZsIBAHmWCDNrkXZ7qiniheVhpIkf/hl1ojoRlLQVB2FHKGRLAIuyv+Ck9JFR57ieDA/8=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB7570.eurprd04.prod.outlook.com (2603:10a6:20b:281::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.13; Wed, 27 Nov
 2024 11:52:10 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8207.010; Wed, 27 Nov 2024
 11:52:10 +0000
From: Josua Mayer <josua@solid-run.com>
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
	Hans de Goede <hdegoede@redhat.com>
CC: Jon Nettleton <jon@solid-run.com>, Mikhail Anikin
	<mikhail.anikin@solid-run.com>, Yazan Shhady <yazan.shhady@solid-run.com>,
	Rabeeh Khoury <rabeeh@solid-run.com>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH RFC] ata: libahci_platform: support non-consecutive port
 numbers
Thread-Topic: [PATCH RFC] ata: libahci_platform: support non-consecutive port
 numbers
Thread-Index: AQHbPCbIgTmm40bZjEicK4EBR1uFNLLHNceAgAPXfoA=
Date: Wed, 27 Nov 2024 11:52:10 +0000
Message-ID: <8682b057-fc62-4491-90f9-204736fb88b4@solid-run.com>
References:
 <20241121-ahci-nonconsecutive-ports-v1-1-1a20f52816fb@solid-run.com>
 <e767272d-1cc4-4945-82d1-efd88c724e06@kernel.org>
In-Reply-To: <e767272d-1cc4-4945-82d1-efd88c724e06@kernel.org>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM9PR04MB7570:EE_
x-ms-office365-filtering-correlation-id: bdb0377e-0522-4520-b22e-08dd0ed9ed0d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?Y1M1aUMrTE9HazA4QVltd2J3QWwrNTAyNXA3VnYyeDl3UkFUUjhqUFNERlUy?=
 =?utf-8?B?MmFsWW1ZYXE0U2llcVpnYlZGNWRHazVEQ3A2SUpSVjJSS0pBNDlmbG9pWEFE?=
 =?utf-8?B?L0lYNy9SNkIxbmZYb1dhZTFibzlVdDBBR0FCdDVWMVV2d1l0WURpVm8rUDNH?=
 =?utf-8?B?aHBnMDV2bEY3S01jc3FTaWsrV09DbnNtV2VzQ0VKdXBtcUl4NGdTR29oZVNC?=
 =?utf-8?B?aVoyQkZwalFyUEZrSEVLWXAzd1N1MU9hTkVaV0sxbGszVUtXOHV3TGI2VThh?=
 =?utf-8?B?SHdFZGZ1UHRyYUlYWWYycnMyVlMxcEtMYjJ0U01hUlB5REFtOExvcmwxWWJH?=
 =?utf-8?B?Y0pwM3BITlpleXhpVG56aFp2aGFUeW1FcG1uMU4xSUZUMnJOamE3U2tVRnEx?=
 =?utf-8?B?bEdsSU5Lb2I0ZXB3VVU0Ym5wL1kzeHhic2Y4eVlEV1RJMGlDRlphL2IraXpB?=
 =?utf-8?B?azJXdXFTQUxMVnBweG9tNWo4VlNEVEtFVzkyMllwcVRtN2hpQitoUkVaR2Ry?=
 =?utf-8?B?OUJjeVU5Y0lOdjEyZVFKdUNVdjhNd25lTkNpMnhwRUlTbGVNN1lXNmRSL2FZ?=
 =?utf-8?B?cVZUMVhaelRvZlU2TGRtNnBJS0d1UWZka0dCRks3a1JDV0hRUFJ5UVE2VnBD?=
 =?utf-8?B?ZUlCVzFUNGd2SGttYWxGUm5IUFExNUZjaTV2WWlVMnJlbG1pWk5JSVhkSWx0?=
 =?utf-8?B?OWNUSnBia00yV2JIT2NmYnUxelZVNGhuTG9IWSthMm1UNGlvRkZXdm0wamMz?=
 =?utf-8?B?K2RXWEJGTUd5dEZWQVpVT24rcHVnNDM5c0Z4TDJLNmIzUndlSUdlZDkweGF5?=
 =?utf-8?B?UlRjbDhoM3I1NXhuNlpONFphRENJTWNwSlBBS3FEQnA5c0h5TzVlYnhxaGRN?=
 =?utf-8?B?SDNoYTFHVHozYUJyZUdPSkNJdUlOb1E2bG8zV2NwQmtNMTQvM05XWlJReFpk?=
 =?utf-8?B?eGJETG8vSWRRU3c4TjRuSmhFTUJpQjJ5c3FIRnZtMms3Qkh6UzYvUXplaG55?=
 =?utf-8?B?WUJYUEszT1VJdDNHTmtqV1dCQlZ6Vzg5b1VTUmJzOElESUJVQWhRSmRtdFZa?=
 =?utf-8?B?UGZ1a0FNTndXSklRbFFkUmNTT2pRNmFBSkgxSzJINitRblk1SG90N0tVMnIw?=
 =?utf-8?B?NWFWaHZVcml0Nll3ak41TEIwTU0wOVYxVEk2YWRGRjYyalJTTnJsNjZRZFhq?=
 =?utf-8?B?Ykt3U2d0MmNhc3pyN3FBczhVczZ0OUNZVzQrY0lLRXNyT3paWGtqZWhmTlBY?=
 =?utf-8?B?T2l1Q2tlbHZZZDNzUUU4d2hsKzZWR3JpVHhaMTczbHltZm9DRzBoNDk0SVVj?=
 =?utf-8?B?c3RNSWM4clQ3S0VNZUpBRlhpRGdKTHoyTHllWDVXa004c1BkUmFMcEdBL3N6?=
 =?utf-8?B?WHVEUktlakJDSit6ZTBMUGhMOExHV1FlNDRkdEpzdU8zc1JqclVHNjdHZDRv?=
 =?utf-8?B?aFlkUWpjREQ3eDNNRkttRUN3SGFUWGVNekpSMjRYUHludi9JME1ob2MzQWZ1?=
 =?utf-8?B?aFZqai8rc0xrd0huUnRqVXNVeWJXZ1Z6YkRraVc4V284ZDZnWnNLL0ZUTk02?=
 =?utf-8?B?Z0hUaDFDbDJ3VVdkREJ1QnljSzlqWHNCd2pQT0w2eE1EYVVGOCt5RG9qd2JR?=
 =?utf-8?B?LzlVR2N0VXlsOG1pVk1mT3hwMmZKUDJCVEQ5dmdkUk9oSkdjSUw4cHZ0TDY5?=
 =?utf-8?B?SE5LTldJcUhNTUFpZjh5YkwyUmZXY04zRDB4MXBERldZRmNqQkt4dldVeUp0?=
 =?utf-8?B?UjJHY1hFWHVLaWhlVWk3QkpQRGU1RkFqdHJxMVNuRWNzVGNZNEV0K2MzTHBD?=
 =?utf-8?B?cFhkb0xBblhvYWdqdVBQVlZwcXF0NXNiMk5NcVpUK2lQbkZyWHliazVMU25w?=
 =?utf-8?B?azV3S0FQM3gwNEpRdlFqZU1DTmhHaW1zMnpXVEttZkdVTFE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?YUpVOUo1eTRFQnNFLzREUTNiTEQ0cXY5aStnNEFpR1pDN1Y3ZmNJVCtub1U2?=
 =?utf-8?B?anphaTN6eGZNaFJzVktrTlVkSHVyY2pvQU54cHBvYkdZb1pnTGg5WURBM2NP?=
 =?utf-8?B?QXlYNXNHZW5pNGJwQ0JST1pqSmxTQmtZYVBzRitVVmtNaVQ1N056Z1NraFd6?=
 =?utf-8?B?UDZGdmswRmNKeVBXaytmRWY0S1lzMktHUVJJdnc4cjVsZ1p6eFJDWEM3N01k?=
 =?utf-8?B?eUZxWDRvQmxTMzhSUXppZ01rdjk5K2NtZDNmQXgvUUFtWEIvVGlUUllUOGJG?=
 =?utf-8?B?Vk9hUDlUa2J0bGhVZm5ocHdVQ1NrRUFMYkF4YVMyc1RVQ0FPL1I4RVlRUHNJ?=
 =?utf-8?B?STJ4RTdFSHhkVzYwb3YrNDNob1Z0ZzFzQ1hYcjhYamRCVmp1SC9BcXBndVdo?=
 =?utf-8?B?NTFFTU1ZQUd2Y0ZpOWlPdjhCaStGK01WRUdBSDllRWc3STFOOWt3OWZubkJo?=
 =?utf-8?B?dDBmVjBkeHBrYmhiV0ZnUSt6NDh6VjkrcGJVL1BYREloTUJ1d3MzRzNQL2dU?=
 =?utf-8?B?dllIZXY2K1VreGlhcis2Vi9Hc3ZnTGl5NWVBd1A3cHVweHR6L1FhRU1Za2JQ?=
 =?utf-8?B?QmJZaTRwTWJSZGR1ankxT2E5R2x2U3gvdEQ5Zk5FandIZXh0WUx6T1pydU5T?=
 =?utf-8?B?MTlyb2RRRi9sbmhNdWFZempsbG90TUgxU0lKeCtERUQ2eFl0TVZGcGJPWU1w?=
 =?utf-8?B?eVdXSEczckVaZUNoTndpUkVvUnhWR1dPeUQyK2QxeUFXRDVVVHAyTEpueGt0?=
 =?utf-8?B?cXZZZTZtYW4wVGRac1VMN0Y1a29tWDZta1VCSVlzbFdkcU11NXZrS1B1UGNM?=
 =?utf-8?B?Uk5hZXNzeDNmYUpRcU9FNTRWM0xEM0N4MzNhV1lwcUxBZVNvSC9jZ0I5bVY1?=
 =?utf-8?B?Mk80TmRaQTdZUGdYeUh6V2ppSDN4UWp6MmxndHFWTU8zc3h4ZUJzV29hNS9H?=
 =?utf-8?B?dnpLVEI0WllWTmd4OFdhN1pRTjN2TDJHL3U5RnM2aFRjRWRtQ2JSZ2hkMGc0?=
 =?utf-8?B?NS9hMjFhakJQRXJTRVNLTVFoSENSRytLS09TZmZwaFlML2w0NDVQYmdqM3d0?=
 =?utf-8?B?Z0I5dHVyR1FJMjNML0pEOXdlNHlqWFpwODVLTmdPZ0xvbmc4WmhwOCs5MGdW?=
 =?utf-8?B?U2RZSE5vZjI2NXVqQVZLdHEyU0I0N3Ewd0xtaEJQVTF5SC9TVXkycDd5ZWlY?=
 =?utf-8?B?SDFwZEhWTkZ2Rm9kWDlhVDE2VEJsQ0RvalFRa0dCajMrN0tTTGs0c3hGTzA1?=
 =?utf-8?B?YzVoWjloeVdScXdvMDN2N3BCZEJKSTB1WEFjalFkNW43RzNKbDZwUHNHNTZP?=
 =?utf-8?B?S3NLNzk1Q2RTbm43L3RWaDBtVGpSSlQzb2pyemN2Y012MlpzVks2MzY3QTBL?=
 =?utf-8?B?cTRvZmVOTGxtL0VsOHRvNzQ0dUdFeEc0bVAwbHR3K1JIWGFMSW5JNzZCRWdD?=
 =?utf-8?B?L0FqZmptVzNPMDNYSDA0WVF6TWgwMjA3aWY5NmhkbEpUQkJKbGpWUWhNWVNJ?=
 =?utf-8?B?VXFEREdVem1tYzBTaThLV293Z2d4cS95NnhvOFhYcDNucWFOaSt4VkMyZE1J?=
 =?utf-8?B?MWJEMXQyRzZ6WHl1OVEvYkhJZFQ1VkVpcG10b2YwdHdkdEp1TldXVGp3eUhx?=
 =?utf-8?B?V2pxaGlxYXhPVEl5WkpLVU9HQTVwVDRBWExGK2JIU0JFYXVLd0xkZEhlbGhU?=
 =?utf-8?B?V2I4bGhGNHlaaWVNQTlCcGdLVHphcTljd3czYTdEMDYrZXhMdXN5ajFYMjl1?=
 =?utf-8?B?eU5XaTVsNG5DRmJ1NnhCNkhjSDlnRmdDQm9rS2lrNFN4Tk1YbE51VmNkbHNz?=
 =?utf-8?B?VXgvTUpHS3VWdkJaTTNRWE1aZ3dHeFRHL00rTm1YaHdQejcwVWttaGI1ZDFl?=
 =?utf-8?B?eU1FNkdWaFY1WlBycStFYkU4VWYxRHZKdFhYcEtubE05dFBDUUk2VkVzd3FU?=
 =?utf-8?B?bE0zbHFlMit5RjZxSVowaUJ2Zy9mS1pRaldlRGNLZitvbjgyRXRqV2FEU2V4?=
 =?utf-8?B?US9xNkQvK1c5b2dEazh3djJta2dHL3czTWVTVGhZWGRvSTV1UXpTeUVjNDZI?=
 =?utf-8?B?M0trVDZvaEFBT1ovb2NYUE9kYlV5OG8xSGtzNTBDMStoVHlrUTMrN0xZMWpV?=
 =?utf-8?Q?wxIk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DAA4F4C70670D24C90076BC1E56B3C5E@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: bdb0377e-0522-4520-b22e-08dd0ed9ed0d
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Nov 2024 11:52:10.3855
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: bVHEMwnxvKSLrJnbSmg0pfX4T1JULSUreI7sZtJOYvX5TfXyXHOMzVO0GY3vdbZ5EgdxpgOQ3nqRYf26fy1kTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7570

QW0gMjUuMTEuMjQgdW0gMDI6MTIgc2NocmllYiBEYW1pZW4gTGUgTW9hbDoNCg0KPiBPbiAxMS8y
Mi8yNCAxMjowNSBBTSwgSm9zdWEgTWF5ZXIgd3JvdGU6DQo+PiBTbyBmYXIgYWhjaV9wbGF0Zm9y
bSByZWxpZWQgb24gbnVtYmVyIG9mIGNoaWxkIG5vZGVzIGluIGZpcm13YXJlIHRvDQo+PiBhbGxv
Y2F0ZSBhcnJheXMgYW5kIGV4cGVjdGVkIHBvcnQgbnVtYmVycyB0byBzdGFydCBmcm9tIDAgd2l0
aG91dCBob2xlcy4NCj4+IFRoaXMgbnVtYmVyIG9mIHBvcnRzIGlzIHRoZW4gc2V0IGluIHByaXZh
dGUgc3RydWN0dXJlIGZvciB1c2Ugd2hlbg0KPj4gY29uZmlndXJpbmcgcGh5cyBhbmQgcmVndWxh
dG9ycy4NCj4+DQo+PiBTb21lIHBsYXRmb3JtcyBtYXkgbm90IHVzZSBldmVyeSBwb3J0IG9mIGFu
IGFoY2kgY29udHJvbGxlci4NCj4+IEUuZy4gU29saWRSVU4gQ045MTMwIENsZWFyZm9nIHVzZXMg
b25seSBwb3J0IDEgYnV0IG5vdCBwb3J0IDAsIGxlYWRpbmcNCj4+IHRvIHRoZSBmb2xsb3dpbmcg
ZXJyb3JzIGR1cmluZyBib290Og0KPj4gWyAgICAxLjcxOTQ3Nl0gYWhjaSBmMjU0MDAwMC5zYXRh
OiBpbnZhbGlkIHBvcnQgbnVtYmVyIDENCj4+IFsgICAgMS43MjQ1NjJdIGFoY2kgZjI1NDAwMDAu
c2F0YTogTm8gcG9ydCBlbmFibGVkDQo+Pg0KPj4gUmVtb3ZlIGZyb20gYWhjaV9ob3N0X3ByaXYg
dGhlIHByb3BlcnR5IG5wb3J0cyB3aGljaCBvbmx5IG1ha2VzIHNlbnNlDQo+PiB3aGVuIGVuYWJs
ZWQgcG9ydHMgYXJlIGNvbnNlY3V0aXZlLiBJdCBpcyByZXBsYWNlZCB3aXRoIEFIQ0lfTUFYX1BP
UlRTDQo+PiBhbmQgY2hlY2tzIGZvciBocHJpdi0+bWFza19wb3J0X21hcCwgd2hpY2ggaW5kaWNh
dGVzIGVhY2ggcG9ydCB0aGF0IGlzDQo+PiBlbmFibGVkLg0KPj4NCj4+IFVwZGF0ZSBhaGNpX2hv
c3RfcHJpdiBwcm9wZXJ0aWVzIHRhcmdldF9wd3JzIGFuZCBwaHlzIGZyb20gZHluYW1pY2FsbHkN
Cj4+IGFsbG9jYXRlZCBhcnJheXMgdG8gc3RhdGljYWxseSBhbGxvY2F0ZWQgdG8gc2l6ZSBBSENJ
X01BWF9QT1JUUy4NCj4+DQo+PiBVcGRhdGUgYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2VzIHRv
IGlnbm9yZSBob2xlcyBpbiB0aGUgcG9ydCBudW1iZXJzDQo+PiBhbmQgZW5hYmxlIHBvcnRzIGRl
ZmluZWQgaW4gZmlybXdhcmUgYnkgdGhlaXIgcmVnIHByb3BlcnR5IG9ubHkuDQo+Pg0KPj4gV2hl
biBmaXJtd2FyZSBkb2VzIG5vdCBkZWZpbmUgY2hpbGRyZW4gaXQgaXMgYXNzdW1lZCB0aGF0IHRo
ZXJlIGlzDQo+PiBleGFjdGx5IG9uZSBwb3J0LCB1c2luZyBpbmRleCAwLg0KPj4NCj4+IEkgbWFy
a2VkIHRoaXMgUkZDIGJlY2F1c2UgaXQgd2FzIG9ubHkgdGVzdGVkIHdpdGggTGludXggdjYuMSwg
TWFydmVsbA0KPj4gZm9yaywgQ045MTMwIENsZWFyZm9nIFBybyB3aGljaCBoYXMgb25seSBwb3J0
IG51bWJlciAxIGluIGRldmljZS10cmVlLg0KPj4gRnVydGhlciBJIGFtIG5vdCBjb21wbGV0ZWx5
IHN1cmUgaWYgaXQgaGFzIHNldmVyZSBzaWRlLWVmZmVjdHMgb24NCj4+IG90aGVyIHBsYXRmb3Jt
cy4NCj4+IEkgcGxhbiB0byBzdWJtaXQgaXQgYWdhaW4gYWZ0ZXIgdGVzdGluZyBvbiB2Ni4xMy1y
YzEsIGJ1dCBkbyB3ZWxjb21lDQo+PiBmZWVkYmFjayBpbiB0aGUgbWVhbnRpbWUsIHBhcnRpY3Vs
YXJseSB3aGV0aGVyIHRoaXMgaWRlYSBvZiBzdXBwb3J0aW5nDQo+PiBub24tY29uc2VjdXRpdmUg
cG9ydHMgaXMgYWNjZXB0YWJsZS4NCj4+DQo+PiBTaWduZWQtb2ZmLWJ5OiBKb3N1YSBNYXllciA8
am9zdWFAc29saWQtcnVuLmNvbT4NCj4gWy4uLl0NCj4NCj4NCj4+IEBAIC01MzksNDEgKzU0NCw3
IEBAIHN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2VzKHN0
cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+PiAgCQlocHJpdi0+Zl9yc3RzID0gZmxhZ3Mg
JiBBSENJX1BMQVRGT1JNX1JTVF9UUklHR0VSOw0KPj4gIAl9DQo+PiAgDQo+PiAtCS8qDQo+PiAt
CSAqIFRvbyBtYW55IHN1Yi1ub2RlcyBtb3N0IGxpa2VseSBtZWFucyBoYXZpbmcgc29tZXRoaW5n
IHdyb25nIHdpdGgNCj4+IC0JICogdGhlIGZpcm13YXJlLg0KPj4gLQkgKi8NCj4+ICAJY2hpbGRf
bm9kZXMgPSBvZl9nZXRfY2hpbGRfY291bnQoZGV2LT5vZl9ub2RlKTsNCj4+IC0JaWYgKGNoaWxk
X25vZGVzID4gQUhDSV9NQVhfUE9SVFMpIHsNCj4+IC0JCXJjID0gLUVJTlZBTDsNCj4+IC0JCWdv
dG8gZXJyX291dDsNCj4+IC0JfQ0KPiBXaHkgcmVtb3ZlIHRoaXMgY2hlY2sgPyBZb3VyIHBsYXRm
b3JtIG1heSBub3QgbmVlZCB0aSwgYnV0IGl0IGlzIHN0aWxsIHZhbGlkDQo+IGZvciBvdGhlcnMu
DQpUaGUgY2hlY2sgaXMgc3VwZXJmbHVvdXMsIHNpbmNlIHRoZSBmb2xsb3dpbmcgbG9vcCB3aWxs
IHByaW50IGEgd2FybmluZw0KYW5kIGlnbm9yZSBhbnkgY2hpbGQgd2l0aCBwb3J0IG51bWJlciBn
cmVhdGVyIHRoYW4gQUhDSV9NQVhfUE9SVFMuDQpUaGUgY2hlY2sgbWVyZWx5IHByb3RlY3RlZCBh
Z2FpbnN0IGR5bmFtaWNhbGx5IGFsbG9jYXRpbmcgZ3JlYXRlciB0aGFuDQpBSENJX01BWF9QT1JU
Uy4NCj4NCj4+IC0NCj4+IC0JLyoNCj4+IC0JICogSWYgbm8gc3ViLW5vZGUgd2FzIGZvdW5kLCB3
ZSBzdGlsbCBuZWVkIHRvIHNldCBucG9ydHMgdG8NCj4+IC0JICogb25lIGluIG9yZGVyIHRvIGJl
IGFibGUgdG8gdXNlIHRoZQ0KPj4gLQkgKiBhaGNpX3BsYXRmb3JtX1tlbnxkaXNdYWJsZV9bcGh5
c3xyZWd1bGF0b3JzXSBmdW5jdGlvbnMuDQo+PiAtCSAqLw0KPj4gLQlpZiAoY2hpbGRfbm9kZXMp
DQo+PiAtCQlocHJpdi0+bnBvcnRzID0gY2hpbGRfbm9kZXM7DQo+PiAtCWVsc2UNCj4+IC0JCWhw
cml2LT5ucG9ydHMgPSAxOw0KPiBTYW1lIGhlcmUuDQpUaGlzIGlzIGFscmVhZHkgaGFuZGxlZCBp
biBlbHNlIGNhc2Ugb2YgaWYgKGNoaWxkX25vZGVzKQ0KPg0KPj4gLQ0KPj4gLQlocHJpdi0+cGh5
cyA9IGRldm1fa2NhbGxvYyhkZXYsIGhwcml2LT5ucG9ydHMsIHNpemVvZigqaHByaXYtPnBoeXMp
LCBHRlBfS0VSTkVMKTsNCj4+IC0JaWYgKCFocHJpdi0+cGh5cykgew0KPj4gLQkJcmMgPSAtRU5P
TUVNOw0KPj4gLQkJZ290byBlcnJfb3V0Ow0KPj4gLQl9DQo+PiAtCS8qDQo+PiAtCSAqIFdlIGNh
bm5vdCB1c2UgZGV2bV8gaGVyZSwgc2luY2UgYWhjaV9wbGF0Zm9ybV9wdXRfcmVzb3VyY2VzKCkg
dXNlcw0KPj4gLQkgKiB0YXJnZXRfcHdycyBhZnRlciBkZXZtXyBoYXZlIGZyZWVkIG1lbW9yeQ0K
Pj4gLQkgKi8NCj4+IC0JaHByaXYtPnRhcmdldF9wd3JzID0ga2NhbGxvYyhocHJpdi0+bnBvcnRz
LCBzaXplb2YoKmhwcml2LT50YXJnZXRfcHdycyksIEdGUF9LRVJORUwpOw0KPj4gLQlpZiAoIWhw
cml2LT50YXJnZXRfcHdycykgew0KPj4gLQkJcmMgPSAtRU5PTUVNOw0KPj4gLQkJZ290byBlcnJf
b3V0Ow0KPj4gLQl9DQo+IEFuZCBmb3IgcGxhdGZvcm1zIHRoYXQgYWN0dWFsbHkgaGF2ZSBhIHZh
bGlkIG5wb3J0cyB3aXRoIG5vIElEIGhvbGVzLCB0aGUgYWJvdmUNCj4gaXMgT0sgYW5kIHVzZXMg
bGVzcyBtZW1vcnkuLi4NClRoZSBwb3J0IG51bWJlciBpcyBiZWluZyB1c2VkIGFzIGluZGV4IGlu
dG8gdGhlIHRhcmdldF9wd3JzIGFuZCBwaHlzIGFycmF5cywNCndoaWNoIGlzIHdoeSB0aG9zZSBh
cnJheXMgbXVzdCBhbGxvY2F0ZSBhdCBsZWFzdCB0byB0aGUgaGlnaGVzdCBwb3J0IGlkLg0KQSBi
ZXR0ZXIgd2F5IHRvIHNhdmUgbWVtb3J5IGlzIGJ5IGNsZWFuaW5nIG91dCB0aGlzIHNlbWFudGlj
LA0KZS5nLiBieSBkeW5hbWljYWxseSBhbGxvY2F0aW5nIGEgc3RydWN0dXJlIG9mIGlkLCBwaHkg
YW5kIHN1cHBseSBmb3IgZWFjaCBwb3J0Lg0KPg0KPiBXaHkgbm90IHNpbXBseSBhZGRpbmcgY29k
ZSB0aGF0IGNoZWNrcyB0aGUgSUQgb2YgdGhlIGNoaWxkIG5vZGVzID8gSWYgdGhlcmUgYXJlDQo+
IG5vIElEIGhvbGVzLCB0aGVuIG5vdGhpbmcgbmVlZCB0byBjaGFuZ2UuIElmIHRoZXJlIGFyZSBo
b2xlcywgdGhlbg0KPiBocHJpdi0+bnBvcnRzIGNhbiBiZSBzZXQgdG8gdGhlIGhpZ2hlc3QgSUQg
KyAxIGFuZCB5b3UgY2FuIHNldA0KPiBocHJpdi0+bWFza19wb3J0X21hcCBhcyB5b3UgZ28uDQpU
aGlzIHdvdWxkIG1ha2UgdGhlIGFscmVhZHkgY29tcGxleCBmdW5jdGlvbiBtb3JlIGNvbXBsZXgg
YW5kIGxlc3MgcmVhZGFibGUuDQpJIHByZWZlciB0byByZWR1Y2UgY29ybmVyIGNhc2VzIHJhdGhl
ciB0aGFuIGFkZGluZyBleHRyYXMuDQo+IFdpdGgganVzdCB0aGF0LCB5b3Ugc2hvdWxkIGdldCBl
dmVyeXRoaW5nDQo+IHdvcmtpbmcgd2l0aCBmYXIgbGVzcyBjaGFuZ2VzIHRoYW4geW91IGhhdmUg
aGVyZS4NCj4NCj4+ICAJaWYgKGNoaWxkX25vZGVzKSB7DQo+PiAgCQlmb3JfZWFjaF9jaGlsZF9v
Zl9ub2RlX3Njb3BlZChkZXYtPm9mX25vZGUsIGNoaWxkKSB7DQo+PiAgCQkJdTMyIHBvcnQ7DQo+
PiBAQCAtNTg3LDcgKzU1OCw3IEBAIHN0cnVjdCBhaGNpX2hvc3RfcHJpdiAqYWhjaV9wbGF0Zm9y
bV9nZXRfcmVzb3VyY2VzKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYsDQo+PiAgCQkJCWdv
dG8gZXJyX291dDsNCj4+ICAJCQl9DQo+PiAgDQo+PiAtCQkJaWYgKHBvcnQgPj0gaHByaXYtPm5w
b3J0cykgew0KPj4gKwkJCWlmIChwb3J0ID49IEFIQ0lfTUFYX1BPUlRTKSB7DQo+PiAgCQkJCWRl
dl93YXJuKGRldiwgImludmFsaWQgcG9ydCBudW1iZXIgJWRcbiIsIHBvcnQpOw0KPj4gIAkJCQlj
b250aW51ZTsNCj4+ICAJCQl9DQo+PiBAQCAtNjI1LDYgKzU5Niw4IEBAIHN0cnVjdCBhaGNpX2hv
c3RfcHJpdiAqYWhjaV9wbGF0Zm9ybV9nZXRfcmVzb3VyY2VzKHN0cnVjdCBwbGF0Zm9ybV9kZXZp
Y2UgKnBkZXYsDQo+PiAgCQkgKiBJZiBubyBzdWItbm9kZSB3YXMgZm91bmQsIGtlZXAgdGhpcyBm
b3IgZGV2aWNlIHRyZWUNCj4+ICAJCSAqIGNvbXBhdGliaWxpdHkNCj4+ICAJCSAqLw0KPj4gKwkJ
aHByaXYtPm1hc2tfcG9ydF9tYXAgfD0gQklUKDApOw0KPj4gKw0KPj4gIAkJcmMgPSBhaGNpX3Bs
YXRmb3JtX2dldF9waHkoaHByaXYsIDAsIGRldiwgZGV2LT5vZl9ub2RlKTsNCj4+ICAJCWlmIChy
YykNCj4+ICAJCQlnb3RvIGVycl9vdXQ7DQo+Pg0KPj4gLS0tDQo+PiBiYXNlLWNvbW1pdDogYWRj
MjE4Njc2ZWVmMjU1NzU0NjkyMzQ3MDljMmQ4NzE4NWNhMjIzYQ0KPj4gY2hhbmdlLWlkOiAyMDI0
MTEyMS1haGNpLW5vbmNvbnNlY3V0aXZlLXBvcnRzLWE4OTExYjMyNTVhNw0KPj4NCj4+IEJlc3Qg
cmVnYXJkcywNCj4NCg==
