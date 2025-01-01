Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2107.outbound.protection.outlook.com [40.107.22.107])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726C33A1CD;
	Wed,  1 Jan 2025 12:13:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.107
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735733631; cv=fail; b=Nb6H4/hmUX4XAC5h7okns7NtIk1dJ8lZy+ugDWcqCPZ/cKDj3YzPXXv1Tw9YOHz2aVwTxFVAbvJUjNZXLX6wHHIntFS8OeLVW5MxjZyB3S4TsehMtxAXRZ/KKq1QYSm8v/NrTnSzZb2hbaeNEjd+jehrWaQ76elUMnNYKKpPK40=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735733631; c=relaxed/simple;
	bh=BCnCtfV+EB7QTf6A4vInB1Xx9cjDaw0lu4psv2Oh+/c=;
	h=From:Date:Subject:Content-Type:Message-Id:To:Cc:MIME-Version; b=iknDG2eTKyAlahwaUtLBMxTEveC3mrhEDdaRQzOaZPjMoSu/VKD7VAxP8GJh3Le9TUfNcmIJck+3YYqxqrb6yZT07OanMgiAMU80Vl0tG+nykX6XsMWektOZlav+UZWhM7Nj+fKjIRGcmRecy7JrhxxZd6MDyiorfPYhCh+DpDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=YMlGdQq9; arc=fail smtp.client-ip=40.107.22.107
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="YMlGdQq9"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GpGmWCR+PYR+/vAHBdAzvpdogBQeg2KGeXaBfpYmN+I5yVSLHuPh9nFeZCJgrw+cwFSNu+avzkg/PJkg7utVjKpK5OGKUr89HgaYtzcSMU8H8WCKegEqyeJ+yMHbzHmmG3yNfWinY3kDorEErL9yCY+PuTHspVsWs4erb1SCMF8NfVM+dfwWWDW5RFpuc71cQD/OQ2LNLGxJDxBeuKugGssITXET0ELw0F/iL3iwW/LK9qAB0RP2i4IjWFp7FEXrDcbBXIDW/gurE/XXpmbaFPwRzfJIVKmRVQ6zWlEk8UFXuhpRzE0y9UutfJG97eEe51CMUa8FU4MR9CRbl+oZJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlB/Exk8GuACgoMPUo20+hp841LTsWb1wS7VzBkhPHQ=;
 b=bjlfFCys6Tp9EPSyh0PHv1gx6pTamCVNGH5R3UKkZzNxSPbGAxzwePQiM5Rc+1NL1vurmWU7pfF++KuXX8PFe2YLgW4lqy4yrJEMI+eZO3nDQYNboGd+Iv8syJuAd64I+ZszKHrMuA7vaaXXengSwdmEtZv/5yyjdlc0ejFrCVpTE7yxTaFb4wYX8pfw3N7v7F20ND/3O83TeeYrVrjy5R/PoZRP0iD3wn7R+VFYJzHxLGttNK6AvsutVmeIY1WDcf+uH+OKdcaFagTwDQkMSpI/A34uqhG8kAxUs35FoMf6T2tp366gRdODRcFUmrSllPcct+e8i/jXTynM80lTcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlB/Exk8GuACgoMPUo20+hp841LTsWb1wS7VzBkhPHQ=;
 b=YMlGdQq913wFWq5rG8aHsI5q243uGhKbXusePSD0gh7vS8T55Dgxz+Oc0lrLbP3XStf5ItkEaUk28qqK4NByu7AwRpam3XcV5iz7+90sRLmcndcVpnhkWWGeINYkAbTtztXxDjjYI3OKmSgqlzMaybiXAppACE/Hdl5HRNyf7vA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by AM8PR04MB7809.eurprd04.prod.outlook.com (2603:10a6:20b:242::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Wed, 1 Jan
 2025 12:13:42 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%4]) with mapi id 15.20.8314.011; Wed, 1 Jan 2025
 12:13:42 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Wed, 01 Jan 2025 13:13:33 +0100
Subject: [PATCH v2] ata: libahci_platform: support non-consecutive port
 numbers
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250101-ahci-nonconsecutive-ports-v2-1-38a48f357321@solid-run.com>
X-B4-Tracking: v=1; b=H4sIAGwxdWcC/42NQQ6CMBBFr0JmbQ1TRdGV9zAsShlkEu2QDjQaw
 t2tnMD81fvJf38BpcikcC0WiJRYWUIGuyvADy48yHCXGWxpj4gWjRs8myDBS1Dy88SJzChxUuP
 qC2J7sFXlzpD3Y6Se35v73mQeWCeJn+0q4a/9x5rQ5Dhb9pWt8dS3N5UndybOYe/lBc26rl+DL
 2BdxgAAAA==
X-Change-ID: 20241121-ahci-nonconsecutive-ports-a8911b3255a7
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>, 
 Hans de Goede <hdegoede@redhat.com>
Cc: Jon Nettleton <jon@solid-run.com>, 
 Mikhail Anikin <mikhail.anikin@solid-run.com>, 
 Yazan Shhady <yazan.shhady@solid-run.com>, 
 Rabeeh Khoury <rabeeh@solid-run.com>, linux-ide@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>
X-Mailer: b4 0.14.2
X-ClientProxiedBy: FR0P281CA0080.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1e::14) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|AM8PR04MB7809:EE_
X-MS-Office365-Filtering-Correlation-Id: 2be0526e-07e9-40c6-5e19-08dd2a5dbb58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|1800799024|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dlA5aUdpT2tHajZwMVVDRTBuU1IvbXhUTkswZ2RpTXpNajVocWtuTVFDeEh5?=
 =?utf-8?B?RGVRNFp4aE5xWlRxWnM3U05lQWU1Z2Jvb3BBQnUrR2xCcmRSZ0ZHTlNYamIz?=
 =?utf-8?B?cHFMeTFSVGY1bjBKSEVoOS9DTThSNHlTU3h0ZDk5MFJyblFKTll6dGpBUEhl?=
 =?utf-8?B?SWV0SGErUUNWZkhsTWl5cmFPTzFBcDE1ajlGalpsc3pGdmNSaElXU0xXNGRz?=
 =?utf-8?B?MVYvWkJFL2xhd09wZTBGWmdlam56UmxiNnpWaWk1WUNQU2RUbko4c0pTZ2Nj?=
 =?utf-8?B?MFlySEltODNWMVVaN0Npdlo5UnhhZ0tNQi9TV2l2R1RvOHVkYXdzdDJDZjU3?=
 =?utf-8?B?WSs2dlAzN2JPTlUyazkrbFhCNi9CSzdSdVd5cWYzVmZ0UENOTkw2MnBCZ0to?=
 =?utf-8?B?M2c3QTRFaHloUlV4VHZmUldmY3BNS0YzNzJSbFc4YThNMTFaSzJSb3h0Zitm?=
 =?utf-8?B?NXA3bW1Hd01rRmFHcVFqYTl2V2tzVXBqUVJGUUFDSUNJN3ZaaXdLK1RWRHR5?=
 =?utf-8?B?eGxaM3FRNmNveG9pNS9BU1RvVXFDWmc1WkNLVWJPTVRZdWMxeGVTNzJxOEpt?=
 =?utf-8?B?WkZ1OTJNNndPZ3oxckxKb0xJc3JXcXpTYlMvREt2WUZ4S3djOStVd3ZMUkt0?=
 =?utf-8?B?SDBkZkZxNExWUGNmQ29sclJXTk1pTmcxaEFRTDY4ZHpzVU5vT0diYlFVamhq?=
 =?utf-8?B?emltc3c0UjF2RVdtRTFqVkhrK2lLamZSVlJTcG1kOXArMWhzbThUMHZYdTdR?=
 =?utf-8?B?KytaUjZHdXV2cm1tdHBFVTIvN2tMVjE1dkxwTEpHYzNZSVBBdXdZSWFVRnJE?=
 =?utf-8?B?MVpuLzh0RWQxS1ZRUUFuYVlXTEhDSkVsOGM4RUc2YVB5NGgyNUViMlROVGFT?=
 =?utf-8?B?b2Fodm84Y3g2NVZZZjkwalh2S3E0emMrSGEwVHdLKzcwWm5BZFlEbnZlQVNu?=
 =?utf-8?B?NVY1Y1cybDVoYlhGRG9TcVlsQ3RpeVhOUzVnK29vbTJKMGVHV0h4L3hSb04x?=
 =?utf-8?B?aWhjZmE2aTk3M2UrdENTdjNaQ3J6NUlNSE52b25pdHl4eGd4RUNhSmF1TUQ5?=
 =?utf-8?B?MXZBWU01RzVVcmdVSjQ3bVpxVm5aMFJzNDJjRHp6SVBUODA0ck5FWU5RbGNx?=
 =?utf-8?B?TUN1SC9JQWNZNkhYYXloZ212V1RSU0MyV2NnV05peDQ3TU9CcG1KbUxhNVJs?=
 =?utf-8?B?N2dydWo3SkdDZk5HSURNMU9pNWFOcDFzRFY3UzU0R2YxaTVjWGRqakNweHZW?=
 =?utf-8?B?YVFta3ZtazJvVE1NVjllemcwM2ZuQlpLMjRkK1IwRkFHK2toZ01pYk5mVTV6?=
 =?utf-8?B?ZmI0a2g2RjFmdmprRjFjSmVjckFGRUtqNGpYa3FVc1pGbGp5ekd6ZUZGOFlC?=
 =?utf-8?B?TUdWQ3Q3bncrV2Jva0gvVDNLQjhCWnpTODZrZSs2ZlhkcmR0SXgxT2RwdVlB?=
 =?utf-8?B?WEFWZVFmbHh3eGlyTk5aRkFDODFTQ2djL0k4TFl2T2tidEdMdVJJYWJUUUlK?=
 =?utf-8?B?Z1ZnMGdQeTR1cG9ZQXNFRFBrMlQ3Wmt6dE0wNW9TT0RQZTlmUnhrV3JKd0lx?=
 =?utf-8?B?K3JuTzcvRkhiRzdsVFY3SUVZc0JwYjlTMTU0Qnd3TlVzck5UanZTNmV1K3Z2?=
 =?utf-8?B?N0c1ZmpOdnlaNXFzNkdGcXFTcDFwcTNhNDg0TGNBMGViY3Z5aGNHbHpobDVM?=
 =?utf-8?B?VitXbkZ3ZXZoUHhiQiswNzE0L0lXUDd0Zk9NaENBS0RVKzJLZHc4aFZvam1n?=
 =?utf-8?B?SHlEeWhwaXBBb1NmNHRCS3Fib2V3TjU5RTlEbUo5aCsxK0Y4ajNac2pnVWNO?=
 =?utf-8?B?dUZKdDV2OWxoN3lqUC9wQVdybkgyUURWbGZYYTJFd05YaVF3WWJQSkNVUWNE?=
 =?utf-8?B?REZzNzFudEFVSUhqNEw0VDVyVmdOWWJJN2VWbkp5dzNONG9WeHgzbzgvM3lT?=
 =?utf-8?Q?pKMa1zJh/xE0eoJWpf/97mQe3Gz9X11w?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cmd3N3NCMCtBNlJzRWJnMFBQQ3VQaGlYN0NxL01QdzVLeSt3cjNkSFFqREU3?=
 =?utf-8?B?Lyt4RWNZSXIyUWtWcWt6RjZmOUNUTVdES1c1blVPNWZ2Q0ZYSHllTWt6VWdq?=
 =?utf-8?B?VHRXSkVpczVMTjUzZVRQVU1QelZEam1GUlRjd1VMYVN0Q21hMTV5cHZobklF?=
 =?utf-8?B?YkRGOE03Yjg1V2ZGcUMvQzRQUTR6dWd3WkFFNEtIWSs1UzNRbnE3MC95ek9P?=
 =?utf-8?B?UXhRdHpSd3UrYXM4MVN5bExEQjNFaTl1NElNejErQ3NhTU5SMDd1TVZjMFlw?=
 =?utf-8?B?WWU4aytKUVJsVklaaUh2V3RGQWdsYjJheiszaS9NWTlHaldpMVlYTDFQV2Zv?=
 =?utf-8?B?eGVjb1BvUWxSaFBQRi9EaFdobXZRSzVIdU03Q0JNWGc0eWRSRmNTU1BxVm5R?=
 =?utf-8?B?SzRoSUowbVhESWdCeUI0Q0QzcmhJM2dGc1M3OTI0ZE9teGd0MnJlOFFBTWtE?=
 =?utf-8?B?VWgwcVpyRW0rOUhEbEsvYUVuZlZvQmdCd2F5b1B5MGdsc1UxM2RRbzB3TzBa?=
 =?utf-8?B?ajVGNnl3QmI3MXovTTY2SDhqZEFnNUtvWEpJS0I3Z3hWOXRpL2RQeFR0RzJK?=
 =?utf-8?B?aGxrMlR5alNNbnBwNE12MzdRQzVHb3JKZ2kzR0daOENHZXljQ0Z5YklQL2cw?=
 =?utf-8?B?ZXBCc3dOWEd2clFRUjlkOW5scWtlODQweFFPYWtYS0NxekFjZzVXVXRwbVpp?=
 =?utf-8?B?aGlKUzRPbENYVWVmV0hxZVRuMDZZQXNBNkp2SU5nM1phSW5ibVJ2U2VMdkdu?=
 =?utf-8?B?Sm5veEJiU2djQW9VUFFLUGoybzRyWW5RKzJhbE5HK2lxQWlDenJMcEhnRkNP?=
 =?utf-8?B?cjNKWkh2Z1JSNXRrUms5RkRTTTNMSVd4V2Zpb2J0MUhzVGJ5NjlpWXpHcHZR?=
 =?utf-8?B?M09La0dmUFJrdWM1Z2VSaHU5MC9LYUFhWStyR082R1p5a216S0daZXhmUlIz?=
 =?utf-8?B?NTBBdFhkYzl4U1UxRWRqRGVhTGI0SlRSTnM4djhTY29YVUpQdExoSlo5c2d4?=
 =?utf-8?B?MDZkRmlCVTMvd2tOWm9ZdEMyM3NWbkplUjZPUlV6cy8xNXo5ZFBPZ04xa3VV?=
 =?utf-8?B?NUxUdDlRcGQrWVk3cU0zKzM4dVIyL09KaVVGTmtzVjhKazhZMExWcWVweW9M?=
 =?utf-8?B?ZGJHZTB2UkRJeUFTUE85bHpkQTJhdGs2NkZaL2ZPalRnelRiWHRPY1dKaVVI?=
 =?utf-8?B?RDFEa2FPbHVXU042ZGtWQTdGYXdJa0tPYlRyYXZsNnFlSysrclpwQzVCdHNV?=
 =?utf-8?B?SmR2ME9GNVlpY05mOWVRRTRIYVA5VDR6ZXE3NThZYWwwT2JMczUzZnVTbXdX?=
 =?utf-8?B?SDAwS25mM2RqOVRLYVJrdjhqMTh1TW9LVnhBL3JxUTdiUCtQMmtJN0JVcFRV?=
 =?utf-8?B?cXlScEZ4eTZtN2JPVkRMOWRGZXgvRWc2c2Q4Ky9xUjQ2VmNScStJTEhSYWtN?=
 =?utf-8?B?blV2TldDQUcyYmpZdkYreDV5d3dRdDZNTmFsRXRRMFhka2J5WlNRWnA3c0Jt?=
 =?utf-8?B?RERMaTBnYmhGOUVEUmtkZTh5TlVoSGJHaUMyb3lPeEVCQnlmTzZGbFgyR2M4?=
 =?utf-8?B?c3VEODUvcVRadTVnQ05OWXlxTURDYXMwdXVmTUhZSHpYRFAyZGtTWTFYL1FP?=
 =?utf-8?B?UnY0YldIbFVBUnBHUUVWUWRFaE9BeVVNN0RNQ0dETGhJaVZGVmVoWklwN2Nv?=
 =?utf-8?B?ZHRlTVh4bDRuL0ZIV29weG5JY2NCc2ZDNXhZT0RCcWhhcVVqcUJSN2d4TXpW?=
 =?utf-8?B?NEY5blZlRGsyT084VUFta0VPOUhGT3ZQcVUyL2JLV2Zoc0RFeXFRYmFXMUVH?=
 =?utf-8?B?QVZweG5QTmprQzRtRWNLUGF1T3dybGNTVzloaFFrZHBlZWFkdHRxK3IwZlpp?=
 =?utf-8?B?VGxoN1lqcUlOZGh0RVNYWmV2ZzZYWmVqRHFkZkhlMXhvelV4b2VjalliK282?=
 =?utf-8?B?bHB4NGNCUENnTmtJN3I4NXdSZ0VIeXdLSEFqMlpVY0R0TDlvYWcwaEYrV2NY?=
 =?utf-8?B?WWhwRGU2bElBMG1UZWZwYnFBa2pyc2RtM0NZS0gxUjN0WStCNDNUeGxSbEVT?=
 =?utf-8?B?WVRsY2FRQ29QUzBuTTFkeHBLSnJkVEs1bk5yMFVMWVpENkdFaEl2MHNTUnl1?=
 =?utf-8?Q?HqYgFXhu4E6UUg/nI7Km0Cl4n?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2be0526e-07e9-40c6-5e19-08dd2a5dbb58
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jan 2025 12:13:42.1477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e78DGeVUEMNsoVnJvz/OFrVQxmKpIK0ilAroByHMpx+UaK7qLhp77RUcBwJoHS83BbvOgzSXLjs2Bc1ISnk0Sg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7809

So far ahci_platform relied on number of child nodes in firmware to
allocate arrays and expected port numbers to start from 0 without holes.
This number of ports is then set in private structure for use when
configuring phys and regulators.

Some platforms may not use every port of an ahci controller.
E.g. SolidRUN CN9130 Clearfog uses only port 1 but not port 0, leading
to the following errors during boot:
[    1.719476] ahci f2540000.sata: invalid port number 1
[    1.724562] ahci f2540000.sata: No port enabled

Update all accessesors of ahci_host_priv phys and target_pwrs arrays to
support holes. Access is gated by hpriv->mask_port_map which has a bit
set for each enabled port.

Update ahci_platform_get_resources to ignore holes in the port numbers
and enable ports defined in firmware by their reg property only.

When firmware does not define children it is assumed that there is
exactly one port, using index 0.

Signed-off-by: Josua Mayer <josua@solid-run.com>
---
Changes in v2:
- reverted back to dynamically allocated arrays
  (Reported-by: Damien Le Moal <dlemoal@kernel.org>)
- added helper function to find maximum port id
  (Reported-by: Damien Le Moal <dlemoal@kernel.org>)
- reduced size of changes
- rebased on 6.13-rc1
- tested on 6.13-rc1 with CN9130 Clearfog Pro
- Link to v1: https://lore.kernel.org/r/20241121-ahci-nonconsecutive-ports-v1-1-1a20f52816fb@solid-run.com
---
 drivers/ata/ahci_brcm.c        |  3 +++
 drivers/ata/ahci_ceva.c        |  6 ++++++
 drivers/ata/libahci_platform.c | 40 ++++++++++++++++++++++++++++++++++------
 3 files changed, 43 insertions(+), 6 deletions(-)

diff --git a/drivers/ata/ahci_brcm.c b/drivers/ata/ahci_brcm.c
index ef569eae4ce4625e92c24c7dd54e8704b9aff2c4..24c471b485ab8b43eca21909ea16cb47a2a95ee1 100644
--- a/drivers/ata/ahci_brcm.c
+++ b/drivers/ata/ahci_brcm.c
@@ -288,6 +288,9 @@ static unsigned int brcm_ahci_read_id(struct ata_device *dev,
 
 	/* Re-initialize and calibrate the PHY */
 	for (i = 0; i < hpriv->nports; i++) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		rc = phy_init(hpriv->phys[i]);
 		if (rc)
 			goto disable_phys;
diff --git a/drivers/ata/ahci_ceva.c b/drivers/ata/ahci_ceva.c
index 1ec35778903ddc28aebdab7d72676a31e757e56f..f2e20ed11ec70f48cb5f2c12812996bb99872aa5 100644
--- a/drivers/ata/ahci_ceva.c
+++ b/drivers/ata/ahci_ceva.c
@@ -206,6 +206,9 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 		goto disable_clks;
 
 	for (i = 0; i < hpriv->nports; i++) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		rc = phy_init(hpriv->phys[i]);
 		if (rc)
 			goto disable_rsts;
@@ -215,6 +218,9 @@ static int ceva_ahci_platform_enable_resources(struct ahci_host_priv *hpriv)
 	ahci_platform_deassert_rsts(hpriv);
 
 	for (i = 0; i < hpriv->nports; i++) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		rc = phy_power_on(hpriv->phys[i]);
 		if (rc) {
 			phy_exit(hpriv->phys[i]);
diff --git a/drivers/ata/libahci_platform.c b/drivers/ata/libahci_platform.c
index 7a8064520a35bd86a1fa82d05c1ecaa8a81b7010..b68777841f7a544b755a16a633b1a2a47b90da08 100644
--- a/drivers/ata/libahci_platform.c
+++ b/drivers/ata/libahci_platform.c
@@ -49,6 +49,9 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 	int rc, i;
 
 	for (i = 0; i < hpriv->nports; i++) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		rc = phy_init(hpriv->phys[i]);
 		if (rc)
 			goto disable_phys;
@@ -70,6 +73,9 @@ int ahci_platform_enable_phys(struct ahci_host_priv *hpriv)
 
 disable_phys:
 	while (--i >= 0) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		phy_power_off(hpriv->phys[i]);
 		phy_exit(hpriv->phys[i]);
 	}
@@ -88,6 +94,9 @@ void ahci_platform_disable_phys(struct ahci_host_priv *hpriv)
 	int i;
 
 	for (i = 0; i < hpriv->nports; i++) {
+		if (!(hpriv->mask_port_map & (1 << i)))
+			continue;
+
 		phy_power_off(hpriv->phys[i]);
 		phy_exit(hpriv->phys[i]);
 	}
@@ -432,6 +441,20 @@ static int ahci_platform_get_firmware(struct ahci_host_priv *hpriv,
 	return 0;
 }
 
+static u32 ahci_platform_find_max_port_id(struct device *dev)
+{
+	u32 max_port = 0;
+
+	for_each_child_of_node_scoped(dev->of_node, child) {
+		u32 port;
+
+		if (!of_property_read_u32(child, "reg", &port))
+			max_port = max(max_port, port);
+	}
+
+	return max_port;
+}
+
 /**
  * ahci_platform_get_resources - Get platform resources
  * @pdev: platform device to get resources for
@@ -458,6 +481,7 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 	struct device *dev = &pdev->dev;
 	struct ahci_host_priv *hpriv;
 	u32 mask_port_map = 0;
+	u32 max_port;
 
 	if (!devres_open_group(dev, NULL, GFP_KERNEL))
 		return ERR_PTR(-ENOMEM);
@@ -549,15 +573,17 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		goto err_out;
 	}
 
+	/* find maximum port id for allocating structures */
+	max_port = ahci_platform_find_max_port_id(dev);
 	/*
-	 * If no sub-node was found, we still need to set nports to
-	 * one in order to be able to use the
+	 * Set nports according to maximum port id. Clamp at
+	 * AHCI_MAX_PORTS, warning message for invalid port id
+	 * is generated later.
+	 * When DT has no sub-nodes max_port is 0, nports is 1,
+	 * in order to be able to use the
 	 * ahci_platform_[en|dis]able_[phys|regulators] functions.
 	 */
-	if (child_nodes)
-		hpriv->nports = child_nodes;
-	else
-		hpriv->nports = 1;
+	hpriv->nports = min(AHCI_MAX_PORTS, max_port + 1);
 
 	hpriv->phys = devm_kcalloc(dev, hpriv->nports, sizeof(*hpriv->phys), GFP_KERNEL);
 	if (!hpriv->phys) {
@@ -625,6 +651,8 @@ struct ahci_host_priv *ahci_platform_get_resources(struct platform_device *pdev,
 		 * If no sub-node was found, keep this for device tree
 		 * compatibility
 		 */
+		hpriv->mask_port_map |= BIT(0);
+
 		rc = ahci_platform_get_phy(hpriv, 0, dev, dev->of_node);
 		if (rc)
 			goto err_out;

---
base-commit: 40384c840ea1944d7c5a392e8975ed088ecf0b37
change-id: 20241121-ahci-nonconsecutive-ports-a8911b3255a7

Best regards,
-- 
Josua Mayer <josua@solid-run.com>

