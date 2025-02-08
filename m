Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2138.outbound.protection.outlook.com [40.107.247.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A23246336;
	Sat,  8 Feb 2025 13:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.138
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739021993; cv=fail; b=jfYeSbcn0mZWyYPIvKCFDi/1vM8z6caTB48YeXE92jM3w/BDhopmKodvm+D6fZ1kKJeV6Yn+vCgKJ8ky0ooPa3KSiddEyg+nqwHYhTX5HPzWLhmaSZ23mM07VWN2nzJcDkoMjV9IdJf7AwAeCMWqTelW6nWfrIqGIlz2NuIDyAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739021993; c=relaxed/simple;
	bh=vuD3jmiuA+F3txdQ+BvVtYKZ53f+pNh1MIbGLNlKbAo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=KQIQvufNLc4RZBauzpzs6rtgWrkJ/qvr/6cEEQ5HwgYzalIIGtgkZBD90OFUUq5GFURbHRa10LHUL8B31xtfCjOfra8pechpVpUEvUBoCbYl62ueIzfEcdSMqqiULXnGMsvQh/XndCmxyq4RuWJt7io66B+Rzzm9DORBIBcogr0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=TMWCz2Y2; arc=fail smtp.client-ip=40.107.247.138
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="TMWCz2Y2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U6fi+1r45FS2v50xVvysanGFd58JmIJZDN1Hm34D3+fkGN4eobpawIrCkOB3NLSUMVu6NinnO1wGpaQYjSlPVLPpmSijn1KoPxrolpOXtLLuYuui/xD3rns0MFlLf+i8nHobrI2RJ99fzxZlTxRMqLkP5sBsribsYmQELckcQoMOA3rhYGKFyU5bP7n7G0CF6QBuuArRu3AldhKv24gNdaC8ZmvskubAlr+A2iwl0D6iWI9R9dRNhBgO7sScnspB9M+Axuj01zp7q4JAJ/du7wNWl3efVoAXyFQMkyhE/oG70tTXrN43M+cN1DlmqGhhwh4IK4HF17EJSzKOhfAqRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vuD3jmiuA+F3txdQ+BvVtYKZ53f+pNh1MIbGLNlKbAo=;
 b=uGsPKO+Lt6qVAajZt9lSEBBTZT7Psat0zH/AhH4jDCd95Gyh+yfBG7Iuq09sXOR2Rv4UpAKlJ9bCjOwsPe/VnH7oRvp+VoQhKyBGdL7xLI4d5Kn2y/xFJ+KCMp/in/hUUMEOtbK5WqA9Y1+9WZPClaNFvaGYxP7FW5fF07rq1tjRnJjnoMNWcxdGc92Ne63o87V4TepvuPCAvb8cm1QJYmdr96getcHl/Kug2CvR0r2AVwcbLt8cizP9gfMRcqMsw+V+F3QPQIMydZ0LNlstpQgpC6DXBBru4V57OtqBWmltUaeX7i0EIMuLlkgwnptmopPM22cSUUFGEo7zj1DUtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vuD3jmiuA+F3txdQ+BvVtYKZ53f+pNh1MIbGLNlKbAo=;
 b=TMWCz2Y2Whx/55zfaB0bGZi7lPZf0UEIaksjGYitbgQvkmSlEEco7K51MQfHi35ZhaqY5u9NF1yVLxGecKX7d8Y2027Xk593o5CNDlFgFkxR6fIOu0cm87MnIbW/7ASYF1vFjDGd4RCkXkMFo+U0u+oUeSJ+0R+UR6wCkqyMf2U=
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM9PR04MB7555.eurprd04.prod.outlook.com (2603:10a6:20b:2d6::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.16; Sat, 8 Feb
 2025 13:39:48 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%6]) with mapi id 15.20.8422.012; Sat, 8 Feb 2025
 13:39:47 +0000
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
Thread-Index:
 AQHbXEaYxc+CL4CCMEqQqo4+duelkLM5OA2AgAB+CYCAAR8SgIABF3SAgACMdICAASw5gA==
Date: Sat, 8 Feb 2025 13:39:47 +0000
Message-ID: <26f6bc4b-265f-4576-9d34-22d6752c17d6@solid-run.com>
References:
 <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
 <bcfa145c3227b13e7b9d8bb3b0f92c678464cfdc.camel@gmail.com>
 <fa54a148-6016-429b-b494-490041564e51@kernel.org>
 <016bbf83fec9a0a7c7697462ce0970b94572f50c.camel@gmail.com>
 <08981396-59d9-4be6-91c7-83421706931a@solid-run.com>
 <cb8175c2755557dd6532ee71d1064241a1412ce2.camel@gmail.com>
In-Reply-To: <cb8175c2755557dd6532ee71d1064241a1412ce2.camel@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: de-DE
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB7586:EE_|AM9PR04MB7555:EE_
x-ms-office365-filtering-correlation-id: 34905c7c-8ef0-4294-82ea-08dd48460e26
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?utf-8?B?VGNHbHFCMTR2bER3UjY3b0ZvMkI0SE5ucmluU2hhL0pBNEFLc3ZuSGVYVnlJ?=
 =?utf-8?B?QitvVnR2WE0rVDZ3dlRNeHA2OGxSN2h1T2VjOEk5cHk5akpBZk5PQWU3U0tw?=
 =?utf-8?B?UiszR0VpNkhVU2RJUjZyeWRTemx4L2pXNU1YQXRYZ25ROHNwSkFiTjFpeGVU?=
 =?utf-8?B?dWtQSTFrUlU3UVM2RDcxZ2hPL25pQnd6dHJZTk51TDFLWnkzbE9HM1QraVA0?=
 =?utf-8?B?clMwcnBBUStaSzZZWDZOUGFLaTRmbm1md2kzamI0NUVTYll0YXdBb1hzVDlj?=
 =?utf-8?B?R0Y4N3VRZmJ5Y1BIZW0wNGZRSDhPWUJBT240djJHUGFwQlh1MUROQ0t5YW94?=
 =?utf-8?B?UWRuSlNiQlFFWTIwQUMyU3oyOHNSL0p5aVN3VlFqdnQycktLZll0cVFyL01R?=
 =?utf-8?B?SmQyUkRvZGJIYWVVdnh5VnU3dlpiSVZ4SW9LTjlxYW5WUHZuUkZ1MkJtN1J2?=
 =?utf-8?B?QldwSUZmdTRvVGZtcFo4cHo1Zi8vSE56Rmpaa2s2bVhXWXEyWjIwK0loSXJq?=
 =?utf-8?B?OEhkNHVuTmRuUmxHOEpkejV0SzJHR2cvM1ZNeklpandjWkJYWVpTZDlOVkgy?=
 =?utf-8?B?VFpLOEFVTzAveWtRTUtzcmIrUXN0QWV5VUdNOTV5eko5MS9ZYVZiSHliUjUr?=
 =?utf-8?B?NTBiK2w1dUJ1bG9scndxSGFESVBOZmkvM2pIRDRrTmlEbDVvT2IyZWl4Vkdq?=
 =?utf-8?B?VG5hcE9hWmVWRGxKUk1FaGlCZDJqWnZrZExFUUs4WTFwR0dVQ2JlRjFrUlNB?=
 =?utf-8?B?eGVsQi9GSkZtVzFkTXpFdmZ3UlIrWDBFaXFiK0hYZEwxV2MxNDlsVk5NekN4?=
 =?utf-8?B?eS82TG5Pb2k2RE9IVWtOaUQ5RDN1ZzQyOFc0UHRIWWFlTTM1ZWVmdGFpMHY4?=
 =?utf-8?B?Y1lGN0pFLy9rV1p5eG5aU1FmSFY3SUhhbDJXb3ZhcTJKK3UvWHc4Y1FBMUty?=
 =?utf-8?B?cmliQldSVEU2bTFjNWdUYzV5UHBMVDJHN1JpK2JMM2lGajYzNFFWZUhDdUcw?=
 =?utf-8?B?TVlidUN3Q1phNUZjcDdRaUIrRHBMdUxvQnlnN2tMaGwzMEJOTEliWk10RUhS?=
 =?utf-8?B?ZHZvM255RzViZ1FNT3NzU0owZXN5bjNQL3A1UkZjU3ZDRlpyNG9xejNTcFdO?=
 =?utf-8?B?QU1zMmdXVEJkUVE1RHhiY3NXM0RmdHRiWll0NXI5Y21kRFQ1YjlRMGN6Yndo?=
 =?utf-8?B?bTR6WTFSMk5jbTBjeWdqTm8yUS9tazkxSzBVRXZaSFlqbHZDaFB6SEU1Nzgw?=
 =?utf-8?B?YkFrMnpvc1BZaHRpZnhYb2R1SThLbDU0MUZiSFJSNXdvb2I0U2xxVFlmYVl0?=
 =?utf-8?B?WHNodTJZakNBOTc4MVRMeEJkODVaVFB6QW53R0pxSG9HUlZ4K3ZSWlA2ZDY5?=
 =?utf-8?B?YXIvWURtWFVYbWsvcUorMFVqV1BzYlJjc3hHRVp6RXdUWWExeU94WE1XbHVL?=
 =?utf-8?B?T3dHZmNTdUNWaDgyMERCYVBGMXNDZWV5UEFnTE52cVgvSjltZ2NJdEptaDdB?=
 =?utf-8?B?UkJsV2sxelhicklQZmtQalpEYnlrNkhNTy85TklpM2h0QzFLMFN3UDc3MUY0?=
 =?utf-8?B?aXIzOTJ2eHpiL1IyR0p0U01TTXJzUFI5cHViSjdBc2p6amw3MDAzYnM3WExW?=
 =?utf-8?B?M3RmSG1oem4yWE84aFBXVnQ5QUlHMzE4SklpandibEpXVXV2ekxJZjRjRjY2?=
 =?utf-8?B?YjBpbGVmY0xiN1J1SUlUanRMVGRUVmN0UWx4USthMVYvbUhSbFc3cy9OQlVn?=
 =?utf-8?B?T0pzcndHRklpS0RvOC9YY0V6Y1FqVkdwVkdNNHhSU3Q0c1E0RFpmQVV4Z1hG?=
 =?utf-8?B?RWRHYk9lQlZ3MHhQa1hEQkNtQTl1WWVYRzJpYzVSRS9EZGZMUHozMlF4dW84?=
 =?utf-8?B?T0dYRUhEWk1zYTdwbGp6RHFMbStxNnQrWjdkVWNLbE8zckh6UWg0a05QNnNV?=
 =?utf-8?Q?z0JF41LnL59ORVOFLsejrBIsrOT+Jmxm?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?utf-8?B?djByZTdTQ1hhK1NSTGphbHB0RHNnbFlEN3YvWmFkbHo3V2dMMklLTzllL0Fo?=
 =?utf-8?B?aVlFcTNDNDVtVHVuTEtWTmZxMjFTaWlnSmgraktHd0s2U0J3c1NVNGtjTjUx?=
 =?utf-8?B?NnMvcG9hcTJUSmxxOGdTT0xMTkhJWHg5eWFpc0E4c1Q1RVZLc3NEZmRVQ2VB?=
 =?utf-8?B?dnhoVUo4ZVBPTWV1WXRtM2dxL3FpM08wU25RcFhNSmZSbmw2TUgzdlRDWnhK?=
 =?utf-8?B?Y1F6b2lKZGdFeklXbzA1SkZMSkl4OTBvRlczbGh0Um0yeUJBUkxaQzJlYUF2?=
 =?utf-8?B?c3dMQzJqY1Q1Tm85UXlNSmNiRGhlTWxhckdSR2pubEZkTmZ0NW1ndVp6Ymc5?=
 =?utf-8?B?Wk9NNlZjc1hWZnlYZ3M3VitlR3lMQmhvVkZlaTRkQ0YyY1ZhanpFT3VHdjBD?=
 =?utf-8?B?RFMvaGZFTmxJYnpWejRXWDlZUHNHMC80bTFIRWpIQlQzcHB6Rk9wbnZpbkxO?=
 =?utf-8?B?OVdldWVDOXMwdXNkK2l1aE1yYW9OODRUbWYzRGU5RklCWjVrejdaSmlPU0xM?=
 =?utf-8?B?UE50VEJsOHRuVU1vZlFKMVVEcVBneDFma1laa3ZxamJjeDE4aDlWOVlZM3pS?=
 =?utf-8?B?Ty8wYVZpTkNlNXlpdERKZzJqdktobk11aE1zVlpHTGJpVGk3ZzkzVk5xZktS?=
 =?utf-8?B?dk1sU05naXlwYy9IWllaTnIrWlZqc2J3ckYwUzBlM1JySVN0eWEzckNabm1l?=
 =?utf-8?B?SlYrMHp0VjhXeU9lSUVySjlhRXlheFNpTHpHOEdNZkpDL29xYWhHNlg2RzVv?=
 =?utf-8?B?Y2Jtd1Z1bHNubDdsWTBGUXFQUXo4NnhOVWRkZERpS0JLWDBETEhYOHBZRjht?=
 =?utf-8?B?TG9kTHJtazRWUktISWtFdmJWZXc1V0ZsazRMOVp3R0o2ckZoWTBFdHhoQVkw?=
 =?utf-8?B?ZVJSazJUS1NYajczeHlMaGNVZGdXcFJobjdKb0lsUmhqVFVDY1RKOFRoeEdF?=
 =?utf-8?B?TXRaTDRTL21FbkJBVk9QaTNEM3dqZnhUQmdndTdtYWdvWFA0UzdiSlZXYzJh?=
 =?utf-8?B?S3hEbThRTTQ4VmZIQ0MveDM3ZWswT3BQZVVjUGE1OXpqUEJjTGhHOHJlYzR1?=
 =?utf-8?B?d1NOYzY1V1FzN1ZyQSthMnhZcjRxaEhFVkFkT0tncjZKRjZJVG81Vk5DelZH?=
 =?utf-8?B?U25BY25yUE5yUThSbGR4ekpYYklpL0tjS2JFRzVwSjZuVVFiTUszdjlMcE55?=
 =?utf-8?B?bU9sOC9ZUGdSU1RvVFErZm5RU3dzcmlIMlZReGV2SDdvNUZOcXNmejErbTlY?=
 =?utf-8?B?QW5tdmdXdFFSMjE3R3k0V0NGWXJLQWlKNW9HeVc3VFJTcXcwS2dSMlFtZGln?=
 =?utf-8?B?L1kzb2RaVDN6V1ZrMlJ6Y3FtQ1pkc0MweTNyN01HcmR1aXhQT09BV0RrRkky?=
 =?utf-8?B?MWRSbk1lRTdsTG5oeHhGU3liNW1ZeXBUdkFUa2hXdzNLWmRDMHRvcEdBSW8w?=
 =?utf-8?B?VGRucTM0OGphYUJzWnhMWkZ3R1liV3Q0Rk1OK2xRNC9OZHlPbkpiUm53NmpY?=
 =?utf-8?B?LzdSVUw5bnNoa1dJSWpHR0x1U3dzaGxUdC9SVFFRUXNKNTRFWmRaWm1pTGIx?=
 =?utf-8?B?bjYzMnlXTWplbWc1Ni9wWHlZM0lQdVd2L0dPcUxJc2EvRmNnTkFDcyszVk5Q?=
 =?utf-8?B?ZFQ4Nm9EWHdVNGE5MTE2SlR4dm5ZM043QjZHRUdacXcwWlAzZ1VmSHJ1MUxC?=
 =?utf-8?B?WXFKUkdZc0FxQmZCeXNVOFArS1l6NFdkbGp3d3NKaGNvR2E1ODh1YkpjZkps?=
 =?utf-8?B?bmkzRzN0NGowclhVN0MyM0tDZjZSRXVTdThCUTEwSXdHdEduWVJzNjR0aU90?=
 =?utf-8?B?T3VENUNubDlTWk83QmMzaXpsQjZPbmdubUhoWkZNdTdiTW9qSTNTYk9qaXVt?=
 =?utf-8?B?cW5jZERmclcrWndvVEtLSG1KeHNTNTlrOVgycHU3YUFoVGtXQ3RlZU0vNVND?=
 =?utf-8?B?RG45U1k1MHhLRzJFME5EWkUrVmxVTDYvai9CYk5NUXRlUWVoRUs5MDZ1bzB2?=
 =?utf-8?B?S01Jek1tdTB3d01qSklKNSttRU1qaXhCeFVQazErcTZiMkJkVUdmaDFTUThi?=
 =?utf-8?B?b25xOWlhYXVYTTNJUmpjQXcwZFhhUGppL0RTeTlZaEtsNzMrWmQycSsyVmp2?=
 =?utf-8?Q?1knk=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CE145F0ED2853C4DABD6DAB54D6F004E@eurprd04.prod.outlook.com>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 34905c7c-8ef0-4294-82ea-08dd48460e26
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Feb 2025 13:39:47.8537
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BJPSdNIWLXRr1BVeC0VwWfVRaUtlBZcc2yrSFvbzPqx6LmySXP5kRIXgIGgElXu1zCUF68c60rLPBUEURbehoQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7555

QW0gMDcuMDIuMjUgdW0gMjA6NDUgc2NocmllYiBLbGF1cyBLdWRpZWxrYToNCj4gT24gRnJpLCAy
MDI1LTAyLTA3IGF0IDExOjIyICswMDAwLCBKb3N1YSBNYXllciB3cm90ZToNCj4+IENhbiB5b3Ug
Y29uZmlybSB0aGUgcGh5c2ljYWwgbnVtYmVyIG9mIHNhdGEgcG9ydHMgb24geW91ciBib2FyZD8N
Cj4+DQo+IFRoZSBzZWNvbmQgcG9ydCBpbmRlZWQgc2VlbXMgbm90IHdpcmVkIG9uIFR1cnJpcyBP
bW5pYS4NCj4gSWYgdGhlICJtYXNraW5nIHBvcnRfbWFwIDB4MyAtPiAweDEiIGtlcm5lbCB3YXJu
aW5nIGhhZCBub3Qgc3VkZGVubHkgYXBwZWFyZWQsIEkgd291bGQgbm90IGhhdmUgbm90aWNlZCB0
aGlzIGF0IGFsbC4NCj4NCj4+IEkgd291bGQgYmUgY3VyaW91cyB3aGV0aGVyIGluIGFub3RoZXIg
Ym9hcmQgdGhhdCBoYXMgdHdvIHBvcnRzIHBoeXNpY2FsbHksDQo+PiB3aGV0aGVyIGJvdGggb2Yg
dGhlbSB3ZXJlIGZ1bmN0aW9uYWwgYmVmb3JlIG15IHBhdGNoLg0KPiBJIGRvbid0IGhhdmUgc3Vj
aCBhIGJvYXJkLCBidXQgdG8gbWUgaXQgc2VlbXMgdGhlIGV4aXN0aW5nIGNvZGUgd2FzIG1hZGUg
ZXhhY3RseSBmb3IgdGhhdCBjYXNlLg0KDQpJIGhhdmUgc3VjaCBhIGJvYXJkIGFuZCB0ZXN0ZWQg
aG93IGl0IGJlaGF2ZXMgd2l0aCBMaW51eCA2LjEuMTI0IGZyb20gRGViaWFuLg0KDQpJIG1vZGlm
aWVkIHRoZSBkdGIgcmVtb3ZpbmcgdGhlIHBvcnQgc3Vibm9kZXMgZnJvbSBzYXRhIG5vZGVzIGFu
ZCBmb3VuZA0KanVzdCBvbmUgZGlmZmVyZW5jZToNCg0KLSBbwqDCoMKgIDMuMjI1ODQ4XSBhaGNp
LW12ZWJ1IGYxMGE4MDAwLnNhdGE6IG1hc2tpbmcgcG9ydF9tYXAgMHgzIC0+IDB4Mw0KwqAgW8Kg
wqDCoCAzLjIyNTg4Ml0gYWhjaS1tdmVidSBmMTBhODAwMC5zYXRhOiBBSENJIDAwMDEuMDAwMCAz
MiBzbG90cyAyIHBvcnRzIDYgR2JwcyAweDMgaW1wbCBwbGF0Zm9ybSBtb2RlDQrCoCBbwqDCoMKg
IDMuMjI1ODkxXSBhaGNpLW12ZWJ1IGYxMGE4MDAwLnNhdGE6IGZsYWdzOiA2NGJpdCBuY3Egc250
ZiBsZWQgb25seSBwbXAgZmJzIHBpbyBzbHVtIHBhcnQgc3hzDQouLi4NCi0gW8KgwqDCoCAzLjI0
ODY3OF0gYWhjaS1tdmVidSBmMTBlMDAwMC5zYXRhOiBtYXNraW5nIHBvcnRfbWFwIDB4MyAtPiAw
eDMNCsKgIFvCoMKgwqAgMy4yNDg3MTRdIGFoY2ktbXZlYnUgZjEwZTAwMDAuc2F0YTogQUhDSSAw
MDAxLjAwMDAgMzIgc2xvdHMgMiBwb3J0cyA2IEdicHMgMHgzIGltcGwgcGxhdGZvcm0gbW9kZQ0K
wqAgW8KgwqDCoCAzLjI0ODcyM10gYWhjaS1tdmVidSBmMTBlMDAwMC5zYXRhOiBmbGFnczogNjRi
aXQgbmNxIHNudGYgbGVkIG9ubHkgcG1wIGZicyBwaW8gc2x1bSBwYXJ0IHN4cw0KDQpTbywgb25s
eSB0aGUgbWFza2luZyBtZXNzYWdlIGdvZXMgYXdheS4NCg0KV2hlbiBjb25uZWN0aW5nIGRyaXZl
cyB0byBlYWNoIHBvcnQsIGJvdGggcG9ydHMgcGVyIGNvbnRyb2xsZXIgd2VyZSBmdW5jdGlvbmFs
DQpjb250cmFyeSB0byBteSBpbnR1aXRpb24uDQoNCj4NCj4gRm9yIHJlZmVyZW5jZSwgbXkgYm9h
cmQgbGF0ZXIgcmVwb3J0cw0KPiAgIGF0YTI6IFNBVEEgbGluayBkb3duIChTU3RhdHVzIDAgU0Nv
bnRyb2wgMzAwKQ0KPiAgIGF0YTE6IFNBVEEgbGluayB1cCA2LjAgR2JwcyAoU1N0YXR1cyAxMzMg
U0NvbnRyb2wgMzAwKQ0KVGhhbmtzIQ0K
