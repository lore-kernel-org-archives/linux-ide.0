Received: from EUR02-VI1-obe.outbound.protection.outlook.com (mail-vi1eur02on2106.outbound.protection.outlook.com [40.107.241.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0A81C728F;
	Thu, 21 Nov 2024 15:05:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.241.106
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732201527; cv=fail; b=oMssPidTqo0+DeyzQsoKC5S2wm/6vKtNby0g9eVa9fWqH0QMr+GWTxW9zt79FnZbJYIhfBv8GaBFI2jWHsisub5go+qRG9VFpLvBaoPtwvFj48LizGPsma90Kr/l7F7VAPuniEUJJ0PKf2O6i0SUhkdTcOT/zi8HAsFjLGrfbJg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732201527; c=relaxed/simple;
	bh=XyLLAkypoE2rLWAGBDVvH7BjuBloldAxyoBXFcaZ9e0=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=PiDcnhtZ1Zec29fWgMIXLQqA28RuLRGhEvYXMnH2Rzg0E2DvgabJKsswwE6BA3jBqqelNLY0NZtkH7f7SAsORL9nazHOOnjam3V3AOV+uVjJJqg7RLQ0cnD2xv0GX4CasgkfyqQL1nC6Ve3bjIaqt7/LwfJ61rDpfIvsyK+rYTA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=SXeaZrev; arc=fail smtp.client-ip=40.107.241.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="SXeaZrev"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kdvgDQjA+YKQL2BWv232TTPySA4/1uQ1k6IhAX6/0eYrpwrIJuR+j3pBAvPHAq9AuBxBm2mWXdWM2lR1b7Iz724tyrkv+rllG870Ff5KaU7TZFERAeJZEYOwP529etrHUIbFQtmnLs6o8kdxMMOlUGxmrCFtJ6pldOMVZbbA6WOZqHhd0ahlQ+JBymsR5a4R69FcBO+Ui84joTh4iJl5sKjocCl36/a3KPmxjFoNn9xhl0aBNLQwo3jccPTPyQegmo3xkr/IINwwdZ/g4u56YEb6IqFsrbJ9/B33p3n+2VhDJcsOVR7sNKASfUz2JqclGGvTN3gUXbnd5dbxVkykRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8b9qVRMfyicpoZOGaabdgyEQ1OZG48ftHBo7JcUxFmc=;
 b=Wlasvgaed/Ver9zwTw0s9zFzu53oVH4Rtkl+BCognr9zZmUv3EQa29Gr/DbjmI5O9nlu5B1KCPfPYVAvuUoVXjp6i4HJJUI9zaITPZqPabMA98si5ejauASfNjmQEYFac0oJn2EieSOIoNTeHoNmMZitPIURtOHL5edHEb8/pOPn+YA+kIxrjCvGYk2asOr0HHfQ/TvSTCASMLhEWqSzI5jKWNphqBAmTgU1tpdE4p/WK5syxeQJJMOXKXlQI0ChTwDrNtT2qI8CCt8Jwm5A+nlUKBVUxyZkgw/seh7OHjratqAU/QfLC3d3vWHOAdRtpBsyHYoICfDvCEhRYW4fNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8b9qVRMfyicpoZOGaabdgyEQ1OZG48ftHBo7JcUxFmc=;
 b=SXeaZrev4J28MxTIuTNDBWvro6/WLmJlZDnathTYJZPlJIqvDH53dVSzg5aGPm3802V+SUvJ3MVdt/sQ2yrIPa50znJA0yWP06kJSxImNVkajMzfj1w4SbldDEzj5KyTWOYcjso+eToAL2l4p61PC3LlNks9hXZIpKJMjDxXtvI=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DB9PR04MB8479.eurprd04.prod.outlook.com (2603:10a6:10:2c5::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8182.17; Thu, 21 Nov
 2024 15:05:20 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8158.023; Thu, 21 Nov 2024
 15:05:20 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Thu, 21 Nov 2024 16:05:11 +0100
Subject: [PATCH RFC] ata: libahci_platform: support non-consecutive port
 numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241121-ahci-nonconsecutive-ports-v1-1-1a20f52816fb@solid-run.com>
X-B4-Tracking: v=1; b=H4sIACZMP2cC/x3MsQqDQAyA4VeRzAaaU2l1FXwA19LhvKY1S04uK
 oL47j06fsP/n2CchA264oTEu5hEzaCygDB7/TLKOxvczdVEjtDPQVCjhqjGYVtlZ1xiWg39oyW
 aKtc0/g65XxJ/5Pi/nzAOPbyu6wdwYwVOcAAAAA==
X-Change-ID: 20241121-ahci-nonconsecutive-ports-a8911b3255a7
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR5P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::17) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DB9PR04MB8479:EE_
X-MS-Office365-Filtering-Correlation-Id: 831d8a95-b1bb-463f-e3ae-08dd0a3deaca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|52116014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QXFaWENJWmoyZmdpRFNpcEpqTlN1NFFMbUNhdUx3WUlna1pEdlZUQklremJE?=
 =?utf-8?B?djhORVJMR3BlOFd1WFY5SzluQXFOWXl5OXpnMXBXRkhOZERIQzluazNzUzFE?=
 =?utf-8?B?MlRqQXRTZVlMeWI0NXVRU1A5bUNTU09hQ3NBc3FPNk5BTjhkeTNwU0lZTDlq?=
 =?utf-8?B?S3Bsb1V4TjE4Y0xtV3pNL3k5aGhYc1NpWGt4SXlHQlRPUlVRcWtZRThCaVVX?=
 =?utf-8?B?REUrcFNxbTJnQzFOT1RPaFBTRUZMbE4weklNRmVwWlI4eWY0bEFnYkhFUHpm?=
 =?utf-8?B?amp3TFM1c3NCR0YyTlQrZTlUckRIbHhFV1RaaTFRTmdzYThXbGtzTmRXUXRv?=
 =?utf-8?B?Q0JRYzViajM2QVhlZ0hDcWNDNytpRkdLMkZEVzlDNUxmdkFuWVRqVTM3cXk1?=
 =?utf-8?B?OExBTWFpbHpRTUxJWWNqazVkTEFpMGc1YkkreUpMdHdLN3RiYVNRQk1IVzJP?=
 =?utf-8?B?eisrR3BKZ1FSYVovMmk5YUM5SmlXM3ViSkp4RXZQaXRwRHMxZXR5bzRGNG9m?=
 =?utf-8?B?ZW1iTnhsclBLaWVtK3hCb1hsU2g5dER4SmhjMFlEZGhTZlZtb0liUi9NWnZF?=
 =?utf-8?B?eDdveHU4OVJqQjBLckxUc0pub1M2YzdkRkxpaEZONCthTVlkSjAvRlpJVysx?=
 =?utf-8?B?WnIzSDNwV25lSEpDTjZEV1dTbkY4czEvNC8vV3RlMkQ1VVNoem9kSllIUnpM?=
 =?utf-8?B?THdVbjRFWjgzWkxTa2x6V0QvT3B4c0FhZGQyeDlMN1FjYUlWNk45U0VtNENw?=
 =?utf-8?B?UmNOWWhmbmJvZXlTRm15UTJBUVl2WEpOSkh6QlVBeWpVNmc2TkE0TzBVKzZU?=
 =?utf-8?B?cGZjbFh5bkg5TldFakRiRlRZR0ZIbXp5dEJOVWp5czZLTlBKd2wxcEJWM1RP?=
 =?utf-8?B?WjdSSEJraWJsQjZGRlV3UUNSQTBIZWJrSTRlQ24yU09KeG9scWVGYlpDcWtZ?=
 =?utf-8?B?V1JSRCtFN05HbWJJQ0ZLSGJhdDJhR1ZLaGwzSzltUzlnRzdSMEc5clRSMzlp?=
 =?utf-8?B?b2NNUlNOek5NSGVUeVRyaUZ3UHRyZUk2NWduU1JoVUVlQmxuZzIrMGtzMUo1?=
 =?utf-8?B?SW9hOGFDU0orYVgyalhBS0NzTFFXRldYNFQvajlFbUtmMHpPQjcrL2JTOWE3?=
 =?utf-8?B?MWtsU0NhdytIYW1IZVBONzd5eU1hYkZsdE0vamVkbndrbllUSGZkSzJVUXpr?=
 =?utf-8?B?c3ZvWFNQSjdveHZuY0p2NXVQZHpNaXJZV0paZzgxUnVGYUdHREFOM2MyUVRa?=
 =?utf-8?B?K1RqZHNIRk1pR1MzVFhjOUx5dHFvZWhnNVYwTWlWNUtKNUFsVnhwT01ZcW5D?=
 =?utf-8?B?NVVnRkxHNU5QbExoMEdZc0ZnUkRXRS9YUUFaSXRtNEpkZDh3a0NKNVJUR1VL?=
 =?utf-8?B?UTZta0RnQUlmS3RtdlBKUFZTc0d6ZmNwdi9JeU40bUl5WGNvWjZxcnVVU3Ux?=
 =?utf-8?B?THd3RlVVV1VXaDBYWTFObkY2WEM1UExHaVBwK1BWZ2VTSHZ2dDRKcG4yWHF4?=
 =?utf-8?B?Q1Q5eC94Yy94OSt5ekF4aHFlZmRIY2tkTExSZHlKYVl5ZlR1OVFNMTRRM0xE?=
 =?utf-8?B?NFVhM0dBTEc5T0RXenVFekIwTXdXV3JBaVhVVUExVGZtNCtJNGJpODdkektI?=
 =?utf-8?B?Q3BtbFBkUmFiWHMzRkJpVjNGVFRmWVVDcURFSGhMS0VMcTZTRllQcXljU2F6?=
 =?utf-8?B?R1FuMzdKYXd0cTI4Z0VOeUxxdE5NSFZIV2F0UHVtZ1BhcUhuVTQrVmNsUW8v?=
 =?utf-8?B?bUlTcysxNXh0RUZzZDRpdWxFODRobkhPR0RCUlVqMGJOSFMwV3p6bWVvcmlt?=
 =?utf-8?Q?Yt//3K36fo2KU5DFU+ffdspN6wtlyVhQ3GVTY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?TURNaGVvWnQ4YTIxbEdKMW5KSk5oZ1Y3TkZxOGZhR1ovSkJoYjZNOWFrTEs2?=
 =?utf-8?B?RDhWM21SVE9Mb3p4TmR3TCtKUUV4eVVyZy9aTk1iS1B3YjBQcFdUbFIvekMx?=
 =?utf-8?B?RXRuTzlSWW5xM2tPMm5OMEd6RnRlbDJadXRwSFpUY2RkaUdNcUNMYjB3TXZH?=
 =?utf-8?B?L0Z1Z3Iyd2x6cFFZRk1xRzMxK3pqY0VrZi9lVzM5ZXdweE5SZk1jaGRaOU8y?=
 =?utf-8?B?aW5kL1VlSWF3N3NXY0Q1Ujk0eTZ6MStoV3F5V0V4WGFEQjhZRmFoOVByZVZr?=
 =?utf-8?B?aWU2aVZzYjhoT01RUG5hUXBwQXdWbnFNNHcrTGJGekxYbkdYbWVVWGt3bTRN?=
 =?utf-8?B?ZlMvM0h0MGJRQ1c5UjNIbHVRTHBvcWRCM3R2d01JbjZVVnFnVDVaTHBIQ2xK?=
 =?utf-8?B?Mng1K0J1UGhocGZJdkplNTEzdjRnSk9OVTB0QVBTYW5MbUVBdi95SnFKN3NG?=
 =?utf-8?B?N28yaFFZR2JHMTNIT0xPOFdHdkRIT0dKd1cxMlZzdWVwZGdJYjFGWkNucFJ5?=
 =?utf-8?B?cWVmZFBzUmZkZElGajF6MDNnVDc1ZXBUZkQ2V2FMSW9kaDBZdWV6ODVmMGt2?=
 =?utf-8?B?b2RGZXNsUlZSdm4vQkgreUJmYm9rTndDaU1uRW92QlN2ZzBSMk10Kyt1UUJk?=
 =?utf-8?B?cmhBb1JYTzZKRG54RUk3cE8rbzNKbkVnV0xkTFJMZUczOFBOTHdPakxIWFBu?=
 =?utf-8?B?Y09ZY3NiUjdVazBVZGxmdDdjeCtPZmhibU4xTUxOOUJ5QURFMkhleG5sUksz?=
 =?utf-8?B?KzA1YjZqZXFNL3dpVmxKNjU3OEZ0NEtQT1VKdVlJNWpFZDhxV1FxSFdINnkw?=
 =?utf-8?B?bUFTV0NPa0FGaDlGekxvRG1BdnVoVjc0ZUNZY1dNalBUTFcra25rOVJjd1lK?=
 =?utf-8?B?bGZCTElWQTFQZVc0WnJYZUxYcjdiei9zRW5RaHNzOUJLY05VNjMvSEVzb1ZX?=
 =?utf-8?B?NHlWTVZYRGUvY3dIM3dOVGpzalpMTlRjVjgybDdOQnZESEVmYTl3TGJPeElW?=
 =?utf-8?B?MUF2SFIyR2x1bGxFaW9ZTFF0elRzYTF3L2pncHhtSmJzNUdPWHQvbVJ2NDlI?=
 =?utf-8?B?aW4xOUJlWEtrc1owanNsbGVzVU5ad3Q0alFteWprZmEwRnYwUnFtcUdCTnNR?=
 =?utf-8?B?SVZxOSs1MHRwYlNHcUJzQjQyU1dZR2lwSFFuN3dsUjdia3M0bXBUc1I0REFa?=
 =?utf-8?B?cnBkRkFrcVF6NmRjQk1UWHhINENmVzl3ODJ0SzN3dEE5L2dPeDkwKzJDT3lS?=
 =?utf-8?B?SXJTVzYzN1QxSDYxcnE5Y3FXU21JbmhscFVmWGdpdmpIZU5JVE1tVy9CUDdP?=
 =?utf-8?B?Z29lbUhUZVU3SFNheGZNRndLUnRmZ2VidXdtR0N3RE94L1RsS05tdnBOMnNY?=
 =?utf-8?B?cjE1V0RKVDE4WHR2RDMwdXFxSTVtMjdXakc0M2MzRDVCNFl1YlcvUTUwUWFP?=
 =?utf-8?B?YmlTM2JXZ05OYVNScmFiWE81OGtQMFJ3ZVVFR2FYaGdxNlZmNy9NOUZ1bWYz?=
 =?utf-8?B?UFhSNGM2UjZuSG1tenEyYnQ3MG8rRlBVbmVyT09ubW8yMGdNOWxhVEFTQjZT?=
 =?utf-8?B?YjNqbXVXQU9YT29idW5PcFVpOVRnMlpxQWxMajlwOUg0b3RVWFNkREdtWStI?=
 =?utf-8?B?N1I4NkxLeXBFY1E0b3UwL1B5amhGQnZGclhhSklCekZPVDN2VWhYcjRPMlFH?=
 =?utf-8?B?dkZjM2NNYjhHNzhhWWVHaEp1N3hmbHRjQkxZbzFxQmw3MStaNXlKMXljMm9U?=
 =?utf-8?B?NkpNODhxZW1MK21xTDZObUYvKy9ka0dmSU1jb1ZKZ1ZHbVFiMHhHYWhjN3J5?=
 =?utf-8?B?TW8vRGEveno5eitxUk9Dcm5rZHp2Z2tlWU9vSGh1TktnSjZqQk85NkxORDQz?=
 =?utf-8?B?MXhiZDJ0SFllSVIzRlZReHdER1dUdnEzekhBd091NmE0RnNNT2NwTzYrZkJh?=
 =?utf-8?B?dE1aWU41T1IzcGpSMUhQQVZKcS9KVi9oOXhxTGh1YW5QSmxjaUY3Q3VIN0Y0?=
 =?utf-8?B?dXNuQXdwaXpCOS9XdVZYNXVWYm9FUUhDVHNqQnc2dml0S2FGOUgwZDZwYllh?=
 =?utf-8?B?ZTYvYi90UEJtTVFmY0RXR3pZMGFsd1MxZzNERlNqODMwdi9XRnRxWFgwUkxl?=
 =?utf-8?Q?zo3206lTv3TdQolI8afOocJ/Q?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 831d8a95-b1bb-463f-e3ae-08dd0a3deaca
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Nov 2024 15:05:20.6473
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pDTkGsCnvHsmU/tP2uGZBy3G3PGEKyB9g4ULx5K6xvQHLibKLu/yagfLXVoC57q/VpcboQQAFnmAKY9O1oFFGw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8479

So far ahci_platform relied on number of child nodes in firmware to
allocate arrays and expected port numbers to start from 0 without holes.
This number of ports is then set in private structure for use when
configuring phys and regulators.

Some platforms may not use every port of an ahci controller.
E.g. SolidRUN CN9130 Clearfog uses only port 1 but not port 0, leading
to the following errors during boot:
[    1.719476] ahci f2540000.sata: invalid port number 1
[    1.724562] ahci f2540000.sata: No port enabled

Remove from ahci_host_priv the property nports which only makes sense
when enabled ports are consecutive. It is replaced with AHCI_MAX_PORTS
and checks for hpriv->mask_port_map, which indicates each port that is
enabled.

Update ahci_host_priv properties target_pwrs and phys from dynamically
allocated arrays to statically allocated to size AHCI_MAX_PORTS.

Update ahci_platform_get_resources to ignore holes in the port numbers
and enable ports defined in firmware by their reg property only.

When firmware does not define children it is assumed that there is
exactly one port, using index 0.

I marked this RFC because it was only tested with Linux v6.1, Marvell
fork, CN9130 Clearfog Pro which has only port number 1 in device-tree.
Further I am not completely sure if it has severe side-effects on
other platforms.
I plan to submit it again after testing on v6.13-rc1, but do welcome
feedback in the meantime, particularly whether this idea of supporting
non-consecutive ports is acceptable.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
 drivers/ata/ahci.h             |  5 ++-
 drivers/ata/ahci_brcm.c        |  5 ++-
 drivers/ata/ahci_ceva.c        | 22 +++++++-----
 drivers/ata/libahci_platform.c | 81 ++++++++++++++----------------------------
 4 files changed, 46 insertions(+), 67 deletions(-)

diff --git a/drivers/ata/ahci.h b/drivers/ata/ahci.h
index 8f40f75ba08cff4deca261b1162ee9a0fb91fed6..544b6242c11131f75c724d15244a74588410ee05 100644
--- a/drivers/ata/ahci.h
+++ b/drivers/ata/ahci.h
@@ -348,15 +348,14 @@ struct ahci_host_priv {
 	struct clk_bulk_data	*clks;		/* Optional */
 	unsigned int		f_rsts;
 	struct reset_control	*rsts;		/* Optional */
-	struct regulator	**target_pwrs;	/* Optional */
+	struct regulator	*target_pwrs[AHCI_MAX_PORTS];	/* Optional */
 	struct regulator	*ahci_regulator;/* Optional */
 	struct regulator	*phy_regulator;/* Optional */
 	/*
 	 * If platform uses PHYs. There is a 1:1 relation between the port number and
 	 * the PHY position in this array.
 	 */
-	struct phy		**phys;
-	unsigned		nports;		/* Number of ports */
+	struct phy		*phys[AHCI_MAX_PORTS];
 	void			*plat_data;	/* Other platform data */
 	unsigned int		irq;		/* interrupt line */
 	/*
diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index 2f16524c252629cf89014144b33fec85d6bca137..169519c4cde37fe8aea6a48fbef16fd10d4d402c 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -287,7 +287,10 @@ static unsigned int brcm_ahci_read_id(struct ata_device *dev,
 	brcm_sata_phy_enable(priv, ap->port_no);
 
 	/* Re-initialize and calibrate the PHY */
-	for (i = 0; i < hpriv->nports; i++) {
+	for (i = 0; i < AHCI_MAX_PORTS; i++) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		rc = phy_init(hpriv->phys[i]);
 		if (rc)
 			goto disable_phys;
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 11a2c199a7c24628e858f2fc8e88e69a60c8b94b..4f0b5674f68e62d6871207e82de16c8422232285 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -205,20 +205,24 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_clks;
 
-	for (i = 0; i < hpriv->nports; i++) {
-		rc = phy_init(hpriv->phys[i]);
-		if (rc)
-			goto disable_rsts;
+	for (i = 0; i < AHCI_MAX_PORTS; i++) {
+		if (hpriv->mask_port_map & (1 << i)) {
+			rc = phy_init(hpriv->phys[i]);
+			if (rc)
+				goto disable_rsts;
+		}
 	}
 
 	/* De-assert the controller reset */
 	ahci_platform_deassert_rsts(hpriv);
 
-	for (i = 0; i < hpriv->nports; i++) {
-		rc = phy_power_on(hpriv->phys[i]);
-		if (rc) {
-			phy_exit(hpriv->phys[i]);
-			goto disable_phys;
+	for (i = 0; i < AHCI_MAX_PORTS; i++) {
+		if (hpriv->mask_port_map & (1 << i)) {
+			rc = phy_power_on(hpriv->phys[i]);
+			if (rc) {
+				phy_exit(hpriv->phys[i]);
+				goto disable_phys;
+			}
 		}
 	}
 
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 7a8064520a35bd86a1fa82d05c1ecaa8a81b7010..e73dbdaa17604999561646f8d0b04f3e7314305c 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -48,7 +48,10 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 {
 	int rc, i;
 
-	for (i = 0; i < hpriv->nports; i++) {
+	for (i = 0; i < AHCI_MAX_PORTS; i++) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		rc = phy_init(hpriv->phys[i]);
 		if (rc)
 			goto disable_phys;
@@ -70,8 +73,10 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 
 disable_phys:
 	while (--i >= 0) {
-		phy_power_off(hpriv->phys[i]);
-		phy_exit(hpriv->phys[i]);
+		if (hpriv->mask_port_map & (1 << i)) {
+			phy_power_off(hpriv->phys[i]);
+			phy_exit(hpriv->phys[i]);
+		}
 	}
 	return rc;
 }
@@ -87,9 +92,11 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 {
 	int i;
 
-	for (i = 0; i < hpriv->nports; i++) {
-		phy_power_off(hpriv->phys[i]);
-		phy_exit(hpriv->phys[i]);
+	for (i = 0; i < AHCI_MAX_PORTS; i++) {
+		if (hpriv->mask_port_map & (1 << i)) {
+			phy_power_off(hpriv->phys[i]);
+			phy_exit(hpriv->phys[i]);
+		}
 	}
 }
 EXPORT_SYMBOL_GPL(ahci_platform_disable_phys);
@@ -209,13 +216,12 @@ int ahci_platform_enable_regulators(struct ahci_host_priv *hpriv)
 	if (rc)
 		goto disable_ahci_pwrs;
 
-	for (i = 0; i < hpriv->nports; i++) {
-		if (!hpriv->target_pwrs[i])
-			continue;
-
-		rc = regulator_enable(hpriv->target_pwrs[i]);
-		if (rc)
-			goto disable_target_pwrs;
+	for (i = 0; i < AHCI_MAX_PORTS; i++) {
+		if (hpriv->mask_port_map & (1 << i)) {
+			rc = regulator_enable(hpriv->target_pwrs[i]);
+			if (rc)
+				goto disable_target_pwrs;
+		}
 	}
 
 	return 0;
@@ -243,10 +249,9 @@ void ahci_platform_disable_regulators(struct ahci_host_priv *hpriv)
 {
 	int i;
 
-	for (i = 0; i < hpriv->nports; i++) {
-		if (!hpriv->target_pwrs[i])
-			continue;
-		regulator_disable(hpriv->target_pwrs[i]);
+	for (i = 0; i < AHCI_MAX_PORTS; i++) {
+		if (hpriv->mask_port_map & (1 << i))
+			regulator_disable(hpriv->target_pwrs[i]);
 	}
 
 	regulator_disable(hpriv->ahci_regulator);
@@ -343,8 +348,8 @@ static void ahci_platform_put_resources(struct device *dev, void *res)
 	 * SATA device itself. So we can't use devm for automatically
 	 * releasing them. We have to do it manually here.
 	 */
-	for (c = 0; c < hpriv->nports; c++)
-		if (hpriv->target_pwrs && hpriv->target_pwrs[c])
+	for (c = 0; c < AHCI_MAX_PORTS; c++)
+		if ((hpriv->mask_port_map & (1 << c)) && hpriv->target_pwrs[c])
 			regulator_put(hpriv->target_pwrs[c]);
 
 	kfree(hpriv->target_pwrs);
@@ -539,41 +544,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		hpriv->f_rsts = flags & AHCI_PLATFORM_RST_TRIGGER;
 	}
 
-	/*
-	 * Too many sub-nodes most likely means having something wrong with
-	 * the firmware.
-	 */
 	child_nodes = of_get_child_count(dev->of_node);
-	if (child_nodes > AHCI_MAX_PORTS) {
-		rc = -EINVAL;
-		goto err_out;
-	}
-
-	/*
-	 * If no sub-node was found, we still need to set nports to
-	 * one in order to be able to use the
-	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
-	 */
-	if (child_nodes)
-		hpriv->nports = child_nodes;
-	else
-		hpriv->nports = 1;
-
-	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
-	if (!hpriv->phys) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-	/*
-	 * We cannot use devm_ here, since ahci_platform_put_resources() uses
-	 * target_pwrs after devm_ have freed memory
-	 */
-	hpriv->target_pwrs = kcalloc(hpriv->nports, sizeof(*hpriv->target_pwrs), GFP_KERNEL);
-	if (!hpriv->target_pwrs) {
-		rc = -ENOMEM;
-		goto err_out;
-	}
-
 	if (child_nodes) {
 		for_each_child_of_node_scoped(dev->of_node, child) {
 			u32 port;
@@ -587,7 +558,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 				goto err_out;
 			}
 
-			if (port >= hpriv->nports) {
+			if (port >= AHCI_MAX_PORTS) {
 				dev_warn(dev, "invalid port number %d\n", port);
 				continue;
 			}
@@ -625,6 +596,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		 * If no sub-node was found, keep this for device tree
 		 * compatibility
 		 */
+		hpriv->mask_port_map |= BIT(0);
+
 		rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
 		if (rc)
 			goto err_out;

---
base-commit: adc218676eef25575469234709c2d87185ca223a
change-id: 20241121-ahci-nonconsecutive-ports-a8911b3255a7

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

