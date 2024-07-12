Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011049.outbound.protection.outlook.com [52.101.65.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C8110A3E;
	Fri, 12 Jul 2024 03:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720754572; cv=fail; b=X4wpj6TZkZI+hQBCziKEJhP9jAQ6ldXGUNpBPloGFh3sjxMFuG8/pshA0JQQj6pW9Z/em4t9gnAmsDNSRinuRMZCUSTF0dCZaJ34QhEfrfvxfhmaAiVF99Ls1npxWNPL/f52JJICGnJw1GT4KxCNAhWA+VtoJ+MFlJdbxrSraWE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720754572; c=relaxed/simple;
	bh=IfnnqdgHsJVpAGFM9wcX6wC9PpW1tMe5AcY+HIY1Hfo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sTDWeKIZr+uufH1lIq6z4+JOM5lgwOaGS0wjUBZ6ea06vTV965v9/nQ2mi83/qyC1YWZc8fAxrl54Uw/jDGnCrMFL55KxPTMkeFNpQ2QYl0Ov1s2g0cURO2nFOKEVi5ShCt2azlnDtURkVkMYg31PQuxjU/559A0/3dEqHzQxgc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=J1h2LluU; arc=fail smtp.client-ip=52.101.65.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="J1h2LluU"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nosXnoZznQv/kM/2+JNKhooPcMjrlO/Y15Kw7LXsDfSnphuFR9y7+ph1L7SpfVdgaIL5THUv3CQs12fdtuLbA0GKAjT29+wXG7tP8A6mr2RvIOQLbgOd/nBcRoKsGAj/Gmbcg0NLfgk/yPDxAV91N9corSulzwJabD7t+E9TmD8060wOmse7xV6CepMmmeLfHxky7JeowlrRvNOcwzQ7wOfU+2ky6JFeAlc7J6VpBNAU0IwGikn1TI2hggMlHn5Smb4feydWmuZnLlO8vVFmhCm/4d/bgviPzJgGW+oGKvk5/wvFdooRMeP/XP3rCQ1sN8upjkiPRHMOy0xanNmXOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IfnnqdgHsJVpAGFM9wcX6wC9PpW1tMe5AcY+HIY1Hfo=;
 b=ZeFGIz++QEc7w0XM02DCG5exHJB+uXLaQ+IQP4LtpIsR6kMz6nYO2hbSi2gphiu3fvU3ExnWnvP4zClrWKNNgZJDufLLB9iy3HhaZbV1vxjOzHfpUyjyGvWYi5lqvC/ymko2fKrmX61UC9qKD0A15mUzKAoiPvQdVkJ2gHq3oJ2SwcoECmNJ+OKLPZhYV7tqG+27Cq/Wkccd8hfzm7IoSjNNwV6KBRYUes+dO8RikIdDeI1szO25AfCH7sMBVgBChtV5yGdqqezcOf4IxK/4R0xz5NSCSpBFrkObpAH19RSBemZ3Hbpj8xLqx7zFAhOkRYgtBGBkLTTtC0eTiCazxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IfnnqdgHsJVpAGFM9wcX6wC9PpW1tMe5AcY+HIY1Hfo=;
 b=J1h2LluULF/1gWKamL9GBhdgec9lRNn6Zd4hPiA27J+SuMqx1ESEY2plXJerUZ/T73mL0xUaFqqJyTU1kAKygt9JJqHMWIQsvlkTGJ1/9O7j+AI2Cvww1rYz3yh2oEtaLeBEl0ibkBTWKU14uiMr+vlhi+V9RfkopMmL6pLcq9o=
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com (2603:10a6:20b:42b::10)
 by AM0PR04MB7106.eurprd04.prod.outlook.com (2603:10a6:208:191::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 03:22:47 +0000
Received: from AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93]) by AS8PR04MB8676.eurprd04.prod.outlook.com
 ([fe80::28b2:de72:ad25:5d93%5]) with mapi id 15.20.7762.020; Fri, 12 Jul 2024
 03:22:46 +0000
From: Hongxing Zhu <hongxing.zhu@nxp.com>
To: Damien Le Moal <dlemoal@kernel.org>, "tj@kernel.org" <tj@kernel.org>,
	"cassel@kernel.org" <cassel@kernel.org>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>
CC: "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v1 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Thread-Topic: [PATCH v1 3/4] ata: ahci_imx: Enlarge RX water mark for i.MX8QM
 SATA
Thread-Index: AQHa02yNAd/vsi+KME+OfisUa4jQlrHxTZsAgAEHTXA=
Date: Fri, 12 Jul 2024 03:22:46 +0000
Message-ID:
 <AS8PR04MB8676A7431FB43CE643DA1E8C8CA62@AS8PR04MB8676.eurprd04.prod.outlook.com>
References: <1720685518-20190-1-git-send-email-hongxing.zhu@nxp.com>
 <1720685518-20190-4-git-send-email-hongxing.zhu@nxp.com>
 <52cefeb5-49c4-4446-813f-df9c1b99ca55@kernel.org>
In-Reply-To: <52cefeb5-49c4-4446-813f-df9c1b99ca55@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8676:EE_|AM0PR04MB7106:EE_
x-ms-office365-filtering-correlation-id: 3ec7609e-548c-4394-ae3b-08dca221e6c4
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?amxrb3FPMFdUdWFkaFEzSlB2NUlubkc3ZDdsSTJzM3o2MlNRYzRlbmFsN3Zk?=
 =?utf-8?B?VXRIV0E0TmRpMWpGQ2gwNEl3N3NFWXppZWNtSnFQVENWam1mbkxSWkE1MzJ6?=
 =?utf-8?B?VVZhVEhNRUVvdnJ6a0x6QzhZZGFhRVNIV3NVb1pCdzM5eldQemFVQll4cTZ5?=
 =?utf-8?B?UzYzVUplcVFUb3VubDB5N0JPMlkrVy84WXZHRWUxYU5USUllNFBVUDFiZUE5?=
 =?utf-8?B?NW0rNVpNTTlYdlVzWVJzZDZpVVpROU5uUUhES2pwWU4rVjQwQ3NHTHhNSm5G?=
 =?utf-8?B?aGl1RFNJbW5tQkJlTms1bTcrcm5XRU0rdnBnNnlkVTFjVGc3Ym9IcS84L08x?=
 =?utf-8?B?elE5Uk1SQlRseDVlYnBTZE9FSGRyMUc2SGFaQ0d1V2QyVXZKQkFCVVpOZ0tN?=
 =?utf-8?B?Rk9qTTdXWENhZkk5alZRNjk4aWh0dlZnSXQ2SndrUXo0cmxIdm82WUk2UFJK?=
 =?utf-8?B?VEJ5QW5NK09xSzFKK1BXSUJZRTRmc0ViT0lNTGUybG9NSGxIcmljR0x4cDk1?=
 =?utf-8?B?TWZrNWdjNmNpNVhJcUpYbDlDRHhwZXY4U241RDl5ejBNcHJtdVFrZXh3V0hY?=
 =?utf-8?B?RmE3Vjh5TTdoVVhUVnJoNWhQN1dNREhmR0wyU3MzTXk1YUE5bHNSM3Rvak1u?=
 =?utf-8?B?dnZldDFxNnBCcmRNL1ptSmp0ZlJLcEo4dko0UVgzYXlWVE5tZFkvSzc0YXdn?=
 =?utf-8?B?dDJJcSt2Z0JNMUdWK2dNTFNvRFVlZjY2b25RSTk2UVMwR3NiY3M4WHBaVU15?=
 =?utf-8?B?YlZIby9PaWtpb0p6Z0JBRXNObmVaODNpUDZOb20wMXBCcWwxdFlzcVdub0tZ?=
 =?utf-8?B?UmU0aWJvSWl0aWtWWi9hdi83ZnpPbDZxTXl6RU05VFZoZFVOdGlEKzI0aUYw?=
 =?utf-8?B?bEtZNXRJUXJXalN1VUJLUlZxdnJkOWhwUmVRbXAxd1hLS0E3enJZdFZCRk9r?=
 =?utf-8?B?clhkTThUMGdFaFZqQjFISEFMd2tibit0TnhqUTJKSkZSWm1rSDh2eE1TajhJ?=
 =?utf-8?B?a0xnclBJdDJuZS9RcGZ6OTltL28zdEpwaG15UzMxM1dSRm8vRHpOUXdNRVRn?=
 =?utf-8?B?aFN2ZHoyVElnMHRkR2lYNi9DenZGWml4VzA0UnBpbEVqcnpLdTcxZWRReUs5?=
 =?utf-8?B?aHdQV2NycS9LaXp1aGNQRHhUdjFIVDdsZmlmcndaTDV6cXJoQ3NUSU1GNE5U?=
 =?utf-8?B?U0ZxS0pHdTZOTVorZWlTZ2lsR2ZTQkFRR0dVRU82WVJBbnRLYXBkelhHQUd0?=
 =?utf-8?B?S3BURHRIZ21JRjQyZGxCUmpiTFhpN2VRTjhUMVlpeHpKeTZLVVpjRTNKd0hi?=
 =?utf-8?B?WDBibEkwTnl6by9rR0U3NGkzU3k5emRLRVZwbEhzd3ZOV25DUlJhM0J6Q0F4?=
 =?utf-8?B?ZzhtRzBkcmlxQUlFcWVSZHkvTjZucVFDRlNnRmRycUVGQWtNSUdndnl4TlB6?=
 =?utf-8?B?QjUwczhTTGRzYjhPL09HQmdQRGs4OVJFWmZTdzhoNHA4cFpTcVZmNHk3MW83?=
 =?utf-8?B?a2E1QVR1ZkNnRVJNcithVnZ4ekNXWlpvYTB0WXVxWDB5cVd0T3Q3NWZSVjNY?=
 =?utf-8?B?UkJVNHVETzFkUis2d2M3MEdmeGFPNkJieWZVWjRWQ0c4aDV1M1gvMEZqZzYr?=
 =?utf-8?B?c3NYcDlGaGFQZEg2NlhPWVg2dmQ5NTQ2Q3lhNG15eVN2dVY3ZFpVYmZTRWMy?=
 =?utf-8?B?WGxPNDJFUVRJZ2ZPa0w4NitKemQ4QUJLQW1TQk9LbytWakx5NWxWOEovcDNn?=
 =?utf-8?B?bS84a2FaVHhlSFlLMWJHTHFablBWY1B6OFRsbDZkbjk2NjIxZXBnSEI5RENZ?=
 =?utf-8?B?Qno4REhkWWxQZUpKb2NGSTBsNXVaQmlFOEg0OTBNY3JVL2tKU3pPMWNSRGZN?=
 =?utf-8?B?THZFazRNUnlFeG5vbVNlVlBnOHhnRTNpaWRBdjdHNHVybkE9PQ==?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8676.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?M28xZkVLL3l5b0VxOUZUZi9yRjBDY1V3WXM0blAwQ1JHUndFL3FNWHZwNisr?=
 =?utf-8?B?WEM0YVR6QWNrWExzVnlhMXIrRjM1cFFsdW9HVW5mZmdDZisrc2lrTWswUmVy?=
 =?utf-8?B?RWV6QkhMZFBrUVZlSFdteGRQYytPRndJbDBSUmxvSHkxNE5WSmY3K2toSFM3?=
 =?utf-8?B?eDh3eXpmdDNjWmZ3a0hnTHFMWXJEWWNQMHdtaTc5TmZtQTBiY1VVaXB4NUxB?=
 =?utf-8?B?VjdCSEFpUU9XT2RHVlVLL0w0NkJNVk1wb1R1clNlSW5sTlFsY2YzOExQRnRZ?=
 =?utf-8?B?RVdITlpUY04vdzBzaXdzU3U3L0NJbldaSnRTa3VOVmQ4cmVjRGNQR25MbHdj?=
 =?utf-8?B?QnpJZW1DNlhyUGdQQmVKK0h5Q2FCbmc4OTVsWWdWN2owdkpwMFZtUnZTbnoy?=
 =?utf-8?B?OUlQTnI1eFd0cXlOU25pOEpWNVJ4bUhGcGRjMG1QTmc0M2VSN0pIQm5kZXZB?=
 =?utf-8?B?SFhqZjkvS3VDRXRHMWxxWUpJNDMxNFpibHkwajk0VEVxa3hRUWo1dk9jTzJE?=
 =?utf-8?B?amZuZ0UzL2N6OWNMWkNMeGVrUm5KaUU4LzRKdDZ2eWhZc1Q2NXdkM3hES2ln?=
 =?utf-8?B?TXB2QmZxd2dzVTE3Q2lUSHBEZ3ZCeHA3ZkRxZmdPVm5tRVVMczVzWC8zU05i?=
 =?utf-8?B?U0xubEFBYXR5QU5NTm9xSnZ1SDZMQkVoWmQ4Mm1vRS9teHdmU2wwSkgyRFdn?=
 =?utf-8?B?Qko1TzdyMmlnZ1ArazVzRVAvdXB6MGxoNUV3a3kwRGs1blRHNzBFcG54Rmcv?=
 =?utf-8?B?UWJBbm4rRmpaU3lSK1AzcmFzVm4zU1VmNDdHQjhQRE5UcmhHT3R1Tys3L3E5?=
 =?utf-8?B?dG9ZVU1jbmU4bnFYN3A0bEhXYXN2RG5ndHZyMThhaHpLd3JQTjdvVEIyQkFo?=
 =?utf-8?B?L01OSTYvVWdjZy83MnJnanpPWWFxWVhtdkJOMyt3dDlnR2FOS1FjNFZzcVdW?=
 =?utf-8?B?emRvbXpUN2FaR2NTbTYzM3lOdUpiQWx5ZnVVd2lGcUU0NnNpdXlrTXVzWmVh?=
 =?utf-8?B?QW1HRzNMeEJuQmg0R2pOK285b3FwVnMyK2N2M1hQWXdQMzE3RW45ODhZN2do?=
 =?utf-8?B?NVFaMmxPZ2x0anA0NUNEalg4MXVRSUNaMnFiOGNUbGx4Wk8rSjRnS3RBUXZx?=
 =?utf-8?B?T1VvRUZDN2hRVVQyTEdJeHg2TVZnSmwvQnZ0TXNUdHBZaDdlN0hkRG84M3Jl?=
 =?utf-8?B?QW1sY2N5dEIzV3BpbUlETlB6UzN6QzJaNnJtMTBUbUdZbzVmQVFGOUxXWUpj?=
 =?utf-8?B?Mi9FWXM4OG1leWdUV0JEYUNBVktyejgzQ21nMTZodWF4ZzlCU1dDUDVEMXZ6?=
 =?utf-8?B?d3BVWm11QW9VUUMyR1pzVG9FNnBIZkdQM0FXOFBNa3hCS3FmaEdqMzFodnNa?=
 =?utf-8?B?MlNXckd3RWg1R1JKTld4dytMbFY2SllvV0l0R3BWZTZ5VU5zNlBCcVNrMmdK?=
 =?utf-8?B?MlNyV1lEMzV4emt5YXY1RnlHR3JnUDh5SHJtdVBRYkVuR2JvRWFIMncrVEEw?=
 =?utf-8?B?cVdlekY2Qy9lYlZ2Mit2elZWSUttTDVHNVRPcUVUVnNyWGsvRHdIbTA5eG5B?=
 =?utf-8?B?WmhqejdSOE1UamxjNVRFR25PNkF0VlpDVnFwTHQ5dTZwWHBhZWtUSWNkVVZK?=
 =?utf-8?B?K3lnKzFERHNZYmlDYjVBVk5HdjVFQTBMY0Vqc0FtSzNXRnl2M0xmQms2ektt?=
 =?utf-8?B?SFZVVEhSdjNtQWxOTTU2NDN5eWZDVzk5UFF6V0JNWmNWV2NvYzdtZDhNL1ZQ?=
 =?utf-8?B?YU9qNThpWVgyKzRtWGxqOXZtS1dNRGdxR3I0anlxRlkwUjU1dEZ2N3dpVE9m?=
 =?utf-8?B?L3pxRmtoZ0JQT2JRa0ZmM1RPc0o4Z0w5WXp5Q1NiM3hJTmhKWE94MmFJUVVZ?=
 =?utf-8?B?cUc2dTBXSTFOMnRMM2NwNlhYOEZ0UzYzRGZBNTRSMkhnNXBPUTNpRUlpaGJM?=
 =?utf-8?B?RTd4VWRubW5HM2VQYnJNb0FmbzR0cldSKzBTVHNQQ0JrWkRiWXRUYUovOTlP?=
 =?utf-8?B?MEJMbS9LaXl3ZDdhM1E3S0d0Y2pWOW5mUm96KytsQmVXRzFpa01JRFRWWlhr?=
 =?utf-8?B?aFM1Uk9FZWVxMmZua2tzZ2t4SkNsWWJDZUdSdjRRRHFPUWROeWNpYk9nMWJo?=
 =?utf-8?Q?USUBLZO8CAnSTLjxKhod7SywN?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8676.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ec7609e-548c-4394-ae3b-08dca221e6c4
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Jul 2024 03:22:46.9024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: btI8uR+QUNrFvCLa4xa6S5aq3m9v4M7Ox/JAGTWpTFqKngLBFklIF9a3oiJqsZG+p97hKB1LZSY7xszRKr2beg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB7106

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYW1pZW4gTGUgTW9hbCA8ZGxl
bW9hbEBrZXJuZWwub3JnPg0KPiBTZW50OiAyMDI05bm0N+aciDEx5pelIDE4OjA4DQo+IFRvOiBI
b25neGluZyBaaHUgPGhvbmd4aW5nLnpodUBueHAuY29tPjsgdGpAa2VybmVsLm9yZzsgY2Fzc2Vs
QGtlcm5lbC5vcmc7DQo+IHJvYmhAa2VybmVsLm9yZzsga3J6aytkdEBrZXJuZWwub3JnOyBjb25v
citkdEBrZXJuZWwub3JnOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBzLmhhdWVyQHBlbmd1dHJv
bml4LmRlOyBmZXN0ZXZhbUBnbWFpbC5jb20NCj4gQ2M6IGxpbnV4LWlkZUB2Z2VyLmtlcm5lbC5v
cmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGlteEBsaXN0
cy5saW51eC5kZXY7IGtlcm5lbEBwZW5ndXRyb25peC5kZQ0KPiBTdWJqZWN0OiBSZTogW1BBVENI
IHYxIDMvNF0gYXRhOiBhaGNpX2lteDogRW5sYXJnZSBSWCB3YXRlciBtYXJrIGZvciBpLk1YOFFN
DQo+IFNBVEENCj4gDQo+IE9uIDcvMTEvMjQgMTc6MTEsIFJpY2hhcmQgWmh1IHdyb3RlOg0KPiA+
IFRoZSBSWFdNKFJ4V2F0ZXJNYXJrKSBzZXRzIHRoZSBtaW5pbXVtIG51bWJlciBvZiBmcmVlIGxv
Y2F0aW9uIHdpdGhpbg0KPiA+IHRoZSBSWCBGSUZPIGJlZm9yZSB0aGUgd2F0ZXJtYXJrIGlzIGV4
Y2VlZGVkIHdoaWNoIGluIHR1cm4gd2lsbCBjYXVzZQ0KPiA+IHRoZSBUcmFuc3BvcnQgTGF5ZXIg
dG8gaW5zdHJ1Y3QgdGhlIExpbmsgTGF5ZXIgdG8gdHJhbnNtaXQgSE9MRFMgdG8NCj4gPiB0aGUg
dHJhbnNtaXR0aW5nIGVuZC4NCj4gPg0KPiA+IEJhc2VkIG9uIHRoZSBkZWZhdWx0IFJYV00gdmF1
bHVlIDB4MjAsIFJYIEZJRk8gb3ZlcmZsb3cgbWlnaHQgYmUNCj4gPiBvYnNlcnZlZCBvbiBpLk1Y
OFFNIE1FSyBib2FyZCwgd2hlbiBzb21lIEdlbjMgU0FUQSBkaXNrcyBhcmUgdXNlZC4NCj4gPg0K
PiA+IFRoZSBGSUZPIG92ZXJmbG93IHdpbGwgcmVzdWx0IGluIENSQyBlcnJvciwgaW50ZXJuYWwg
ZXJyb3IgYW5kDQo+ID4gcHJvdG9jb2wgZXJyb3IsIHRoZW4gdGhlIFNBVEEgbGluayBpcyBub3Qg
c3RhYmxlIGFueW1vcmUuDQo+ID4NCj4gPiBUbyBmaXggdGhpcyBpc3N1ZSwgZW5sYXJnZSBSWCB3
YXRlciBtYXJrIHNldHRpbmcgZnJvbSAweDIwIHRvIDB4MjkuDQo+IA0KPiAyIHJlbWFya3M6DQo+
IA0KPiAxKSB0aGlzIHNlZW1zIHRvIGJlIGEgYnVnL3Byb2JsZW0gZml4LCBzbyB0aGlzIGxpa2Vs
eSBuZWVkcyBhIGJhY2twb3J0IHRvIHN0YWJsZQ0KPiAoQ2M6IHN0YWJsZSB0YWcpIGFuZCBhIEZp
eGVzIHRhZy4NCj4gDQpPa2F5LCBJIHNlZS4gV291bGQgQ0Mgc3RhYmxlIGtlcm5lbCBsYXRlci4g
VGhhbmtzLg0KDQo+IDIpIFdoYXQgYXJlIHRoZXNlIG1hZ2ljIHZhbHVlcyAweDIwIGFuZCAweDI5
ID8gV2hlcmUgYXJlIHRoZXkgZGVmaW5lZCAoU29DDQo+IHNwZWNzKSA/IENhbiB5b3UgZGVmaW5l
IHRoZSBuZXcgdmFsdWUgdXNpbmcgYSBtYWNybyB3aXRoIGEgc2VsZi1kZXNjcmlwdGl2ZQ0KPiBu
YW1lID8NClRoaXMgcmVnaXN0ZXIgaXMgb25lIHZlbmRlciBzcGVjaWZpYyByZWdpc3RlciwgYW5k
IGRlZmluZWQgaW4gdGhlIFNvQw0KIFJNIGRvY3VtZW50LiBUaGUgZGVmYXVsdCB2YWx1ZSBvZiBS
WFdNIHNldHRpbmcgaXMgMHgyMC4NCkVubGFyZ2UgaXQgdG8gMHgyOSByZWNvbW1lbmRlZCBieSB0
aGUgSVAgZGVzaWduZXIgdG8gZml4IHRoZSBpc3N1ZS4NClNvLCB0aGUgUlhXTSBpcyByZWNvbmZp
Z3VyZWQgZnJvbSBkZWZhdWx0IHZhbHVlIDB4MjAgdG8gMHgyOSBoZXJlLg0KDQpIb3cgYWJvdXQg
dXNpbmcgIiBJTVg4UU1fU0FUQV9BSENJX1ZFTkRfUFRDX05FV1JYV00gIiANCnRvIHJlcGxhY2Ug
IiBJTVg4UU1fU0FUQV9BSENJX1ZFTkRfUFRDX1JYV00gIj8NCkknbSBub3Qgc3VyZSB0aGUgbmV3
IG5hbWUgaXMgbW9yZSBzZWxmLWRlc2NyaXB0aXZlIG9yIG5vdC4NCkNhbiB5b3UgaGVscCB0byBy
ZWNvbW1lbmQgb25lPw0KDQpBbnkgcmVjb21tZW5kcyBhcmUgYXBwcmVjaWF0ZWQuDQoNCkJlc3Qg
UmVnYXJkcw0KUmljaGFyZCBaaHUNCj4gDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNoYXJk
IFpodSA8aG9uZ3hpbmcuemh1QG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvYXRhL2Fo
Y2lfaW14LmMgfCAxMCArKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRp
b25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9hdGEvYWhjaV9pbXguYyBiL2Ry
aXZlcnMvYXRhL2FoY2lfaW14LmMgaW5kZXgNCj4gPiAwZTlmZGRkMDJlZTVmLi45MTQ3Y2QxNGY1
ODdlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvYXRhL2FoY2lfaW14LmMNCj4gPiArKysgYi9k
cml2ZXJzL2F0YS9haGNpX2lteC5jDQo+ID4gQEAgLTQ1LDYgKzQ1LDEwIEBAIGVudW0gew0KPiA+
ICAJLyogQ2xvY2sgUmVzZXQgUmVnaXN0ZXIgKi8NCj4gPiAgCUlNWF9DTE9DS19SRVNFVAkJCQk9
IDB4N2YzZiwNCj4gPiAgCUlNWF9DTE9DS19SRVNFVF9SRVNFVAkJCT0gMSA8PCAwLA0KPiA+ICsJ
LyogSU1YOFFNIFNBVEEgc3BlY2lmaWMgY29udHJvbCByZWdpc3RlcnMgKi8NCj4gPiArCUlNWDhR
TV9TQVRBX0FIQ0lfVkVORF9QVEMJCQk9IDB4YzgsDQo+ID4gKwlJTVg4UU1fU0FUQV9BSENJX1ZF
TkRfUFRDX1JYV01fTUFTSwkJPSAweDdmLA0KPiA+ICsJSU1YOFFNX1NBVEFfQUhDSV9WRU5EX1BU
Q19SWFdNCQkJPSAweDI5LA0KPiA+ICB9Ow0KPiA+DQo+ID4gIGVudW0gYWhjaV9pbXhfdHlwZSB7
DQo+ID4gQEAgLTQ2Niw2ICs0NzAsMTIgQEAgc3RhdGljIGludCBpbXg4X3NhdGFfZW5hYmxlKHN0
cnVjdCBhaGNpX2hvc3RfcHJpdg0KPiAqaHByaXYpDQo+ID4gIAlwaHlfcG93ZXJfb2ZmKGlteHBy
aXYtPmNhbGlfcGh5MCk7DQo+ID4gIAlwaHlfZXhpdChpbXhwcml2LT5jYWxpX3BoeTApOw0KPiA+
DQo+ID4gKwkvKiBSeFdhdGVyTWFyayBzZXR0aW5nICovDQo+ID4gKwl2YWwgPSByZWFkbChocHJp
di0+bW1pbyArIElNWDhRTV9TQVRBX0FIQ0lfVkVORF9QVEMpOw0KPiA+ICsJdmFsICY9IH5JTVg4
UU1fU0FUQV9BSENJX1ZFTkRfUFRDX1JYV01fTUFTSzsNCj4gPiArCXZhbCB8PSBJTVg4UU1fU0FU
QV9BSENJX1ZFTkRfUFRDX1JYV007DQo+ID4gKwl3cml0ZWwodmFsLCBocHJpdi0+bW1pbyArIElN
WDhRTV9TQVRBX0FIQ0lfVkVORF9QVEMpOw0KPiA+ICsNCj4gPiAgCXJldHVybiAwOw0KPiA+DQo+
ID4gIGVycl9zYXRhX3BoeV9wb3dlcl9vbjoNCj4gDQo+IC0tDQo+IERhbWllbiBMZSBNb2FsDQo+
IFdlc3Rlcm4gRGlnaXRhbCBSZXNlYXJjaA0KDQo=
