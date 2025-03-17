Received: from esa3.hgst.iphmx.com (esa3.hgst.iphmx.com [216.71.153.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B6641A5BB8
	for <linux-ide@vger.kernel.org>; Mon, 17 Mar 2025 14:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=216.71.153.141
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742221709; cv=fail; b=gLfrxr4iz4NhYqyJF4URUIzP2GAEyKXKeKlNkrqbzHs5FbWdY9qNAGPELMPWMxDpFFyf6VNRO0nHL8GnvtRtO/k9tfQVaHNBAxSG0B3I5OQoKaFhFYT2Yfo/h1caU6Rj9uTYa1cgIf6ekQ/iqN0o9W//VuhhIS9zUD4ix9UzQOY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742221709; c=relaxed/simple;
	bh=J7Kp5oYdo3MT8xkvSqk0Sz56foeaHcWNy+HD5Np2dfc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SYa4zADFx8ornj71zabokpaW0LdL/WiJe+zH8fFvMln/+EcDq5R41D67tgzqBIiE8r8X7VxlGoikTGGNCaJ7NXHQMDFwfEJmS2fXmOZi9qxuqw9DYc20EfDWuSahkdTlWah1+ihX08kYYL6PChpIv/xpBSUJFnfdf+iSZopVTPs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com; spf=pass smtp.mailfrom=wdc.com; dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b=deT7v+AG; dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b=WwN7oH7G; arc=fail smtp.client-ip=216.71.153.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wdc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wdc.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="deT7v+AG";
	dkim=pass (1024-bit key) header.d=sharedspace.onmicrosoft.com header.i=@sharedspace.onmicrosoft.com header.b="WwN7oH7G"
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1742221707; x=1773757707;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J7Kp5oYdo3MT8xkvSqk0Sz56foeaHcWNy+HD5Np2dfc=;
  b=deT7v+AG5iQMLcRm+25qw/9XFwo9NsPnKPOPaC5sVJG74Sf5Ialnx64F
   rC0lw92/JJS3cC48IWFfqyg+y0Kn32+WCX8D+ZE/x0cFlQBDYXRlkNWMN
   1o5S1IBj2q8JrOMts4TD6ToTqWkiYpNkvJ2H5fZHcLW6628aexcKAEXal
   elRDwISrHF9DkvtE+6o68lhiz+9ST0YWUv/0Zq5EF6ugOhvtEg/x66x/3
   yvTkC+gAEZ+PkuidpyLsL/nOq3yNj4Hbeh1uUeZUbuTZsHTreOqpCVQHo
   nh3S8R8+0T5mOr+01SDu8Jdzbt0wv23JtWuvtqKaaqFVU+Vhlk1yCrZXn
   w==;
X-CSE-ConnectionGUID: g2IMtZXITT6TJCVcl637wA==
X-CSE-MsgGUID: 1KMYMBiDT4mc2ti5EIL1vg==
X-IronPort-AV: E=Sophos;i="6.14,254,1736784000"; 
   d="scan'208";a="51702454"
Received: from mail-centralusazlp17010007.outbound.protection.outlook.com (HELO DM1PR04CU001.outbound.protection.outlook.com) ([40.93.13.7])
  by ob1.hgst.iphmx.com with ESMTP; 17 Mar 2025 22:28:26 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XYrTgyol1JNyoEMbDYnRtFJQzQslKNFDQqwCiEPHwMJpYDp9IiQpirG0a9lhHCdoDSLsrLupj5V+7qn29OKBWKMiRQKDgQJLPGC2HZKrLuG3xZ6CRHmfIPQHwmAKj7pkbCOz1Ysip3tOE83dpX3hMrAj4iLF1AADADMkBvZlOe3S8OA4DA87mP+ynjZrU4+5+Vn+V16WdfTlBP3+XW+MVJ6Ss/h4Y/6KN1NBxfMygrOO6qAYwST+lEuM7GgwqyRwhfmkCnvCUSwrw7qwB3GmVczDGI+6F7RGPe0tWkTdSEB81A8JwIoSBtz7Z1ajcg0z8zEsI06WaIodihV4v2XUkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/xZUtXKtjcwu6sOyqRmAF5MGOZc0CoDwU3XfpJxUSxc=;
 b=TqlsdB62YJU78N2T9xWCw2H+qJ8wKEfMfHQ8l4nKajVTx8jSgKi0F0grsFoHnNZ8YasoumHqe9DnwJ5b6AYB/tEV9DdXLp0byEgVFnb8xye0DPZXcIe7hr8dUVZ3grPcVpbmd4xfTg0/ClLb1a+6Htd6jNYL56HtLFuaFQjnKUlNc8BhgNuNvSysm2SqN1ow+5KT85z6+3Rkg2iafQ7Db222B8V0V0nVFg6xlH8RVfvOYgxvzQQw7UHdrOyfBfxXN87FsZ88txWomrQPt5xjPFMJa/nVU+TTWt63TJg5IRF2LIRKEpmSGkBH6HKS2h2qY8SBv2qFAaXFlnSi6um4SQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/xZUtXKtjcwu6sOyqRmAF5MGOZc0CoDwU3XfpJxUSxc=;
 b=WwN7oH7GqVO0g8XRY5TmAxKe+/71Efhj9DK/g3XOimJ+Ysu852p6hWt5q8rBUrvppETmp7CigjvFihwuzK5pOBdNnmv2DG5B3R5ubGf/bBciSGhH2N8/r0FbZalX0DTh1eXcUgrm2TpxeszI1fVqtZsXX5YO2va3A+pIwnF41Ok=
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com (2603:10b6:a03:3db::16)
 by PH0PR04MB7431.namprd04.prod.outlook.com (2603:10b6:510:16::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.33; Mon, 17 Mar
 2025 14:28:25 +0000
Received: from SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::5088:5f08:45a0:9a8]) by SJ0PR04MB8326.namprd04.prod.outlook.com
 ([fe80::5088:5f08:45a0:9a8%7]) with mapi id 15.20.8534.031; Mon, 17 Mar 2025
 14:28:25 +0000
From: Niklas Cassel <Niklas.Cassel@wdc.com>
To: Tomas Henzl <thenzl@redhat.com>
CC: Damien Le Moal <dlemoal@kernel.org>, "linux-ide@vger.kernel.org"
	<linux-ide@vger.kernel.org>
Subject: Re: [PATCH V3] ata: ahci: simplify init function
Thread-Topic: [PATCH V3] ata: ahci: simplify init function
Thread-Index: AQHbl0UEVMTO95nde0CK1EaQA7rNfbN3YyQA
Date: Mon, 17 Mar 2025 14:28:25 +0000
Message-ID: <Z9gxiFiKsfXXyOkp@ryzen>
References: <20250114182956.40923-1-thenzl@redhat.com>
 <0e2a0f69-7b98-4b48-8a68-6a554cbbec09@kernel.org>
 <be4fb93d-ab73-47d1-bbd9-1ac098b23ca3@redhat.com>
 <abef767e-9479-4109-8057-d549ac999107@redhat.com>
In-Reply-To: <abef767e-9479-4109-8057-d549ac999107@redhat.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SJ0PR04MB8326:EE_|PH0PR04MB7431:EE_
x-ms-office365-filtering-correlation-id: 9461dea8-a0a6-43e0-5621-08dd655ffa52
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ZrX7Ou12ogfVpn4zil3kh1Ly8YrzmV1l1hPn73fUiWyzh8ZNfIS95B222FoH?=
 =?us-ascii?Q?tV76cd3HKdU8dN77MenrAZXCI8n7mjn57Wxa9va5ovlIMebhjkwy0b60yNEY?=
 =?us-ascii?Q?ya+4b53r//9B2OW3xMNae9KnwCmhmxgoI1EzCOOQD353qEtAcZBFrDwu1ZdR?=
 =?us-ascii?Q?W/kMBHs58uqOBxE0c6TT0K+g9EWUmSiH1d7JEANrFrMEfnKuVvloWqZ3UgJI?=
 =?us-ascii?Q?Iq+aot4JJ0VZKpoQbXW4Ht5HQw3T83XV2eoGl5sIqu/tGdr8kPbC2246n3LI?=
 =?us-ascii?Q?B5Zzlt20D69aOEFPRpXLYXCaD/cIcrk5dTYy5tjX8M3aaQ/nyBhxcoEcePDe?=
 =?us-ascii?Q?94EVbCd/B1dE0KK0xcrIgIsjkd91OjwKrHYB6ggNBbDqchTtSn/8TAg/L8iQ?=
 =?us-ascii?Q?tweFvPAFKfufRUywmrGoNdaYnqCQhJD8vP8pxk6vROgN/WNeHJ6xiPBDH/yS?=
 =?us-ascii?Q?FuA1xGmi48/ELOS12lLoDnkdy11s+NcIIYB0bkc1taPegmwfHBIzdBfnvs2b?=
 =?us-ascii?Q?V6EXAvePCtmFOdY6IBZOOgg6aOxKYQXHnPn8+kdnBgRDY1kN0DH0pDIKxZhu?=
 =?us-ascii?Q?DijYWFbER9ZfhxhSghnfSgGZmrVAJTsWYKC2g9fy/f6rT9bi3Ji19+cIM/cQ?=
 =?us-ascii?Q?1EKXPwnHToKOkwEENqUDWyviQdJ3fUzpQqi4043dHjC+iGsWnl9QjtVUeXvl?=
 =?us-ascii?Q?df5/Kg2WgkDlXuIMvm3dF4NxnrbcBBB2QUywjcTZB3Mp6PWOZW17huZv9Xht?=
 =?us-ascii?Q?kfDNPTjrywbbHSEu9cONMB11AuiXIhzgnYkJHIzqJSON0CFB+KobtuyC88QL?=
 =?us-ascii?Q?Ts3SdY1xo//i5AWSTF1dT/M/YnLV9nEkBJYvNpDKCajIa1OkDkz9Uv/3+7Jr?=
 =?us-ascii?Q?RWVjWCCbtLaFdVtm3uI6LBYqpjHifRbEZEZnN4VT+a4gURWmhIK2EwwGQiRU?=
 =?us-ascii?Q?7+4dTxZaDUG71wa1MfoPqied6o2hyZQN77Wu8X4icKv4TlDIqI65FYBQ3aku?=
 =?us-ascii?Q?Xb13x7E6bhQDOrTQ2gUgdH7WYBz3DxX9kAhNetziw98rMH17QBWU1V88/Gmq?=
 =?us-ascii?Q?kKwHPCD2wPyH1tDDzGfmUl1rpqG0pHxjruBFGgidDbjI+JAfwngBx5gx012Z?=
 =?us-ascii?Q?yho2TqXJl84Pg9RqzTPS+S5Mywy6GJcFiw2cyT6nmIHpTVRzeeV+8hznN4W0?=
 =?us-ascii?Q?IG1ZiV++SQgqUnD0wf+gRGTtDGlz3snLzBROsaJKhgc4VRxun7hFJnIBlGyt?=
 =?us-ascii?Q?OLK3U/kb3iZx6nV4EYLXpOAN9YX631qCMg0H6DWguVBdx2yHzNIc22z8B23d?=
 =?us-ascii?Q?LLY9pmGdDvSdzQAErR6u8+STyP7VUPHQHjFeeZOv59a21drBeXIlgBjjo1gQ?=
 =?us-ascii?Q?L/NFhOZsWxqW6zHRunhlQ9Ft4R/q0g0d7XY3gwI/YBWHBpxhKrhWnsrisCii?=
 =?us-ascii?Q?D2bimfX1bfWuFn3/GlUFaMq6rdiNpcZK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR04MB8326.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?wVmGRgU9PpmPbqRpdRePerDse2Wfzw3GrjJ9MtJh1CuDC1j9gbH5x9kqmY4I?=
 =?us-ascii?Q?opoRDj7wevfUqzp1ZJm4yEW9R5sW/jNpsnuOCwHOsu/wLz8NEUPjt54RsQsK?=
 =?us-ascii?Q?nlRfDxiBkzsCfqI8ZY1oBzx561L835Z1HxD2Gb7k33BNs36zdnKSGSZMCjiE?=
 =?us-ascii?Q?iB7WwlUUzm9PB2bIKuj2F4KoOFfBKWNQvScQkLAwVM0MtHXfBPSLk0SDmwGA?=
 =?us-ascii?Q?py2Zu6U2V7//MxNakr046Vwr9RVilecbqjDZnS+s++nqr29+rqSu3K7lumTc?=
 =?us-ascii?Q?tpbvH/B5gSWB5WuygVC7neMkWsGfaUZ+ERc0lZov6MSmAZgz5s06TRnmkQwQ?=
 =?us-ascii?Q?QPGMtFgI9pKMjSsERYSQFakVMIi6Wltb0IhemgmiF89f8OKIXTiMfumA9b4m?=
 =?us-ascii?Q?hwk3DY2yMwipqvuaLq/Ilo42kLYXoObDZSTJw/17TcH9X75Z3YTBBQhKswo9?=
 =?us-ascii?Q?OfIZ50WyqebCgyI7CgrueIWQKAhK3wS3NDKbDfacsM+jsFb3KlhqhGoJxl6c?=
 =?us-ascii?Q?lMLm1f1XEd8aE+fcpnH4oRAj1o7iNgwZ4ViY3xABwpfiZ47H2bYLmmc2IqWJ?=
 =?us-ascii?Q?oW/OvYBNJSuIIhfiaNdtbMpJz6iz2CMm+Vm8Vq6QickNMYP97nf7lA+sJVuc?=
 =?us-ascii?Q?No5Z+yvyXTK0+iosX5wWZOQfzvRE7aO4n4UZuNxJAHHcTlIoVE9LAEGyUvHK?=
 =?us-ascii?Q?dcYl2GFf/vGb2U9nMEP47rwqXlDHJmXEyvGlivYMew2f8WYU5UJj4OmNL/AB?=
 =?us-ascii?Q?3xm4+iSevZkD6MgkWeedH9lI/iGkDvan8cKGuctJjPvkC6Yhwj9NpgfOn8CE?=
 =?us-ascii?Q?e4ye/EtTVOPr888cOVz3gUbT6cygaeaD7yhyFoXJsVStmjVRNzzqSuZepYAI?=
 =?us-ascii?Q?osWEtAg2cjFcAYgQyJIb3RR41oZAqVS4Svt8MdmE002DKrqHGC1MMAbQO/qA?=
 =?us-ascii?Q?ug9MzXMhrKhYrPdeFS9LZ1C4h1GsKUZI94vUeyqHKR13eX27EQ9XKFuMXkFq?=
 =?us-ascii?Q?lpQFZHiTOLa3SqsN7in/aqRoZBC6OXAorOLmwSo3gmv/WG+jz/G3FP792PJA?=
 =?us-ascii?Q?MWbkDe7fO3W7dHK9Aa9xtnCMx+CQ5nt7wg865QtRtwhXqnOSj2bsuvvNBSJY?=
 =?us-ascii?Q?44Tchz3zvtrFtNIBP0AfukcSBYEJJj91ABnhCra04MGYTxSU9Qe3E7nfnWIf?=
 =?us-ascii?Q?aX768R9Wrj5TZMALwqDq36xjdfGGbKmrL8UpM96TYQvx9kErUaF5+TRk5QGc?=
 =?us-ascii?Q?x9mdpp3LrVQ2zTfjINRJPAkcygwmUZz10HvTSN8MI8k/phoL2R3p85rUCxTm?=
 =?us-ascii?Q?57mdGPTaRy8C5HtQKlRJZg8JSRn5ZxhqmuTAKKFzV29ZJVZmaiNKqzCmNSnu?=
 =?us-ascii?Q?Fe07pVWhIOwBbfGlUJ/nvH05J7kXI94Mx2iAXL6XZhyu6ybVUaxXg4Ot/MME?=
 =?us-ascii?Q?iV0XGbx7UmhbTcNEluIBJiEZi6gfucXEp1mo74mW8drVTxQFx85v9UKG0K6/?=
 =?us-ascii?Q?1cunm+pRpoyPI4Kyu2Kdf0OgbhdNV95AbBehA7pVg6pj+vEhLOFiDisAYJMa?=
 =?us-ascii?Q?wTs+Ij0YeTpN5m4i73NT8HdDF8a8BTnHQlJ5dI6rkVOIiQrThekxp4DVuz4c?=
 =?us-ascii?Q?7w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <EE1816BC977BC94F942CBBBF22210434@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	XDKvgJdmTiJCCYNpjhbO6TpG+zpZU8IOgcjnTc46slyl16ss0BnquLJxSRSWu7w9VYVwDR2TuIlwUkKlmj+BwMYtFeJGFFMCmKKUKFJdhV6rCPJtU+Hm7ax0iIrbYZ45SGSGhMN4uzipNn/BnPXjg2Bqnx59htPAq/SJozUx2WwCabfayUVnO12eHWRvLH8DaUpmt8jKSt8LN6bqpDB7g1JqOFIOrelcbBBgE144P7DJraWRZcPA7t80yPGDKfiBd9oCp6erNy5G4ECpLKDjMOkSCEaPXvryaIWNCp1A82ppgPEkvnhlp8Vn66DuNT20ynA/r0EnVcZul9WLm68+a/qoKNSBjEG3v16gg2GM2rhqj5c88+rMY8JuZ5M5jHdZvflO+f3FWdkflbkxDR0o8V2DWd/R5kiU2bdYzwmtewprFn/BFpfgWkCq2P9NGoOrdIvvsCPAYRR+tpP/M1sJufZFOnzm1jEiK1GLSPVijR+66bEEc8Oq9JfdtFrATuax5Xw05tss7OD6X0PksIZJm1Tsq4KDJ3QpYqxejUzxps36WazuiAO0+U3jhb0QtuPwXST/tSJPKtSGxXdBHv3M3v3hSb6WekQIKtSfGJwRN+fXmgPwdDVXbeAYMDSvVKGm
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR04MB8326.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9461dea8-a0a6-43e0-5621-08dd655ffa52
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Mar 2025 14:28:25.2264
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: esbH1DRSR3vZpn25Md6sqlA4nQtStisPngbftRv95nR1nhXiG1O/n0JVc7gcCDV1FM8k2zZet/R2rOpQJ2Bmcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR04MB7431

On Mon, Mar 17, 2025 at 03:00:46PM +0100, Tomas Henzl wrote:
> Hi Damien,
>=20
> the V3  patch applies to the for-6.15 branch with just an offset.
> Can you take it as it is or do you want me to resend?
>=20
> Regards,
> Tomas

Please rebase and send a v4 with an improved commit log.

-Remove the double newlines.

-Use paragraphs (with an empty line between paragraphs).
 (There can be multiple sentences in one paragraph.)

-Improve the motivation. I.e. "removing a few lines" doesn't make sense,
 you are actually adding lines:
 1 file changed, 12 insertions(+), 11 deletions(-)

 You are however moving all the IRQ vector allocations into a single
 place/function, instead of having the allocations spread out over
 two separate call sites, so your refactoring does make sense, since
 it improves code readability.


Kind regards,
Niklas=
