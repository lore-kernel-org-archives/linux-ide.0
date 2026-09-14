Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012056.outbound.protection.outlook.com [52.101.53.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59CF4406270
	for <linux-ide@vger.kernel.org>; Mon, 14 Sep 2026 16:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789403627; cv=fail; b=BGcZBihvR5kQApz+IfrzAfEo7Mpvf/bPtlO7orVEL4gPBtwv5sYrBPfoHJVR6Ld+xa+RrXfbTmtvhGFxTyarwLJZV5hd1z4sFK2ZvB0XaHkvpb6fmVCq3zLo8U4Ge30F/DQiTsVuBLrLRzkCieVlNuqXpj9e0J7vp1FHPR8txj8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789403627; c=relaxed/simple;
	bh=4L5EUdPNnP1p4db10rY7tJJ/oOT8iraPc8pwVDVkdwM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=PiXapDr9gIbZRZaP4eop9chKcfItpqQOp0tcEOLNdMqrFuKkH9Yv6tiNWA+fkpMTvk641P79v2L3mFJ+8LAINW7FcQuCOoo50tVzBZm2MyPFMjYMSXkf7cinknaRAXe+kVpo6b4b96yMKbmyqbmJ2y1C6jDb7IjuburllrxkuLY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FPElFzsH; arc=fail smtp.client-ip=52.101.53.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FPElFzsH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f0+1R27u5xHxRysdmVHm3/DkAeJZG/CFLMfo5Nb4KtKLI4jawMjlZmVSAecEom/G03OMfWvvqhKw93qGTZ1hVoM4mN57OywPQcrp5nvC2JsQGkiKj0Mo0xtHAVeuaVcCOeqqX9oHODcb1qA2pVXYeu2D0k2DvWj9f5xGyGtr360AAFQIlOdleS5EWu1vskGBMT2N1Hs85lEWlr1AgOLLm1C15Mtk+MjzVr4+R8fW3ruOw76AMbk4Y4DcYXNoqUsAT5KMJ8enA3LMnhokQRNO+ucLX5Aen2ytUrX9zY4xWhozTOZOA5uaA8R2qHZIQSJOzK8OSmBrxoq3tGDVyQFArg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iTDWS29h5i2UPCEljUdSoAZhrWY9GzqqQkGoEpfYYHU=;
 b=alypIHD19fpVkbk38KKaEoN4GhoMlla2sRJfuXACuXIR/hyS46wrbVTSPXQ0OVIlD+Ed7mJnpbmdTcElX1XzDK2bl1cpyKsyKM2XjXEg6HZvJHH3eg6uLtgLnPGxuGXcyjLhGJ6QewUn2JMF4S7YDzNgbYdk5axnnmmzXPuiwVOmOrRxT4HJ2FBh4esXn49AH4bOXIhVTivJgGtZ1GqSKz7IBG3/8pj/VNwmgSuuC5U9Ab0/aTJvjWmPuf1SI/2ESJXRONTtPaf9cBL2dhn/nVlp5Ox0yoC1N4X8/7X0Sj0lGK5AhYoKHP1bfKvnSagSBzpjsIxt9fzubFt7/d8a9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iTDWS29h5i2UPCEljUdSoAZhrWY9GzqqQkGoEpfYYHU=;
 b=FPElFzsHAqM/oXK0SvmzeCUO6h3O6EWii+4ECjvDuNqbN5yvXpPCzfoxIu3pWTNxrxEfazuHrgvU7t82jgNeP8GInkLnmxqRtsr4DQSZI3Wn4HyK7i9xKFggP4N1C/eDDU8nCJqAZEH9vowpp0BnxP/r30TtVm7xnfzSR9mG8XU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CH3PR12MB8877.namprd12.prod.outlook.com (2603:10b6:610:170::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.12; Mon, 14 Sep
 2026 16:33:41 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0406.007; Mon, 14 Sep 2026
 16:33:41 +0000
Message-ID: <e9cf59a4-5bdc-4aba-a6c2-cfd8a51684db@amd.com>
Date: Mon, 14 Sep 2026 11:33:38 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: AMD AHCI + Samsung 870 QVO STANDBY IMMEDIATE time out
Content-Language: en-US
To: Niklas Cassel <cassel@kernel.org>,
 "Natikar, Basavaraj" <basavaraj.natikar@amd.com>,
 Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
Cc: grandmastertriplej@gmail.com, Damien Le Moal <dlemoal@kernel.org>,
 linux-ide@vger.kernel.org
References: <aqgeXSdsH_QVgKqg@ryzen>
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <aqgeXSdsH_QVgKqg@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: PH7PR17CA0065.namprd17.prod.outlook.com
 (2603:10b6:510:325::9) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CH3PR12MB8877:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c1320f-ce5e-4ba7-a32a-08df127defeb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|56012099006|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info:
	6Gib9bALAtKePcmaptPQINiZ6Z9gLEDg8wpf+gJVcV6t5918ys7PCIp2WCrCnfKqlg/q5TbuI+4LvjAIGmGblcPBfm4Kq9fYThTy1/TWv/UcwnHBMIERYm8zK2RjYA6M5r7RvzxO69x0mYI9HTCjb0ZgRHMF7iw8T4hmHvNaI8WwZrUN3O7ZseBbfJ8BiHNX5OQOg3F23UJG41oP+Np29+0uwknz5YfVCbJVYrczNHc+hehanTBVhaCcq9sMN+nEt7BWsgOUEZT52yO6zS9x8GOUsfbF2ygYA0sukdS1TK786gSyFZ5A2cYFUTs1xNe2fDCBFj0U61PH7naJ3vmGm07LAhKtTz/lDMsUX5GiG7cuyiNBIFqbm1W7u7jHky6XkECRzuNwOeDCOclea4eYHlzcAjT8+SrMTdeagZFGnpkRnj4ZOiMm2qyTuRGIUVdwOs0ZGJI3s4TWNFDObUXTUgLOiFGliAdQdQgbQpw7YKINYUI+ClKRlUjGEpapz/rpBzJZ6f/y0EaKjjWht0YIml2w6HlIDCPgsKB8WU+2OavvZItaCQ01uU6ctK6fdKsOhp/ICpRYPXMcoRtEqXb6lthH4IPKJtL/H3tIx6mzNj0Ck6/UM9nC60QnuJbZhdXnbu24xkNDLhIh5OGAzX930Qg7dL9HRb9fQAYsHM+BM2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(56012099006)(11063799006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aEVTZ0RJUUFIeXN6T0hqNHNmd1VZVjNzYzJRRHdyVXZickVuZ0kra0FwaUZw?=
 =?utf-8?B?L2Vsbm9mZko2eU00S0taWmtNSUJQaCs2NE5iZVZWTjlObUNKQ3FEeEttWGdr?=
 =?utf-8?B?d0NjQnZBb0RObHlvbjNCcTVOcHJKZmJUcmtOQW5lMDlCaTZoSGozS1N6bFoy?=
 =?utf-8?B?bzY4YjZEZ1Jvd3dLRE1sRnFxT292b2I3ZHRjYmM2VkVTdHI3bnp5ckJKeFZz?=
 =?utf-8?B?dGpMNnFkeEwxNmQ5cU9uS1g0bVJubnJsM1VJZm5WeTVDK2Z1YkgzNjFKTndl?=
 =?utf-8?B?cTQ0WjcvbTQyOG9oSFg1ZVN4T1FLeHcyQ3AyNXNYbU12SFZTZlpNQzlzbGdJ?=
 =?utf-8?B?UXpjdEhOUDBLeUkza21VMzQ3V1o5djZvSmszOFhHazZ4RDF2NlJra3ZIS0x0?=
 =?utf-8?B?bDZheENjcDI1czFnUElyOUVCNGszK1B0UDhvSEdSMmNwUzNGUlU4ZFpPb2FQ?=
 =?utf-8?B?RUFOaXZka29qcmN4VGEwVUZaU1FnNWQ0WDUwTTNXaWdMSVM2VnB2MEY5MW1C?=
 =?utf-8?B?UFk1Vm5NYnRkZ3NLWVQxWmpsR1FlR3l3TENYQVVVMG1Rb2QzUTNNdVVrQlZU?=
 =?utf-8?B?c09jOUR3Vi8xMWJQSUNNalVQOGZUWWJ1Q25ONkFlbmdPL2pMdDZmVmE3TkxH?=
 =?utf-8?B?dmVsampyRWFWb0I2RWVXM3hNL0xzNE5yczM3TUhsbGxiSm9NRm13UDhhM1Iy?=
 =?utf-8?B?bmsxb2lkOFdnczQyVnZOcGw5bFdtbUhpQzYrQ1RkUTRHd0tlODhGcm9lRDdZ?=
 =?utf-8?B?cktGVTBla0RBOXVRNzNFUy9tWGlmL24vOEFGOHd0akluODN3WDg0R2tNa3lP?=
 =?utf-8?B?TFVFL212UW54RXNPN05HT3hzVVdWN0paZ2ZjQ3J1bTB4NTFJc0EzM1lnRi9y?=
 =?utf-8?B?akRFOXpmSzNORnJBYVBUdWdsWmtEQ0FLSGpzWkxlV2RlbGQxaHNDTVBQcGFK?=
 =?utf-8?B?K1ltNWErZEYrbnBWRk1VclpQV25FTEhnbUZtM3MxR0h3T0FWd3JzcUFYU001?=
 =?utf-8?B?Nm1vYm9RenAvNU9nN0x6U1p4alFlSVpYenFtT3Q1TTFRK2o3b2RmZFlqcDJN?=
 =?utf-8?B?VEt6cTlOb0RTYUt3STk3R0pLaUo0MEFHRW9CK0xGMk15MUJMWk9ncXZPNjdL?=
 =?utf-8?B?eTJ1b1ZraUJzTThkekFVNVByZDYzMFN2QThiNXNUdW91WDU0emlDbGVWMVdo?=
 =?utf-8?B?UzFUTmdKTnRUVlFtWmZJSjhQWmg4YVh0cWJORUczREJMaW4vNS9jOGZsTzRG?=
 =?utf-8?B?NEk3anAzSytHZjRYTmRadTF2bWhicmswQm1BTDBZa1RpZmxCR2V6YnFqd1ls?=
 =?utf-8?B?eGhNV2cyaXQ3NVBWTDNiUHdyeWxzYjJCTTlvSUFYSzdVbjRuek04WWZic3V5?=
 =?utf-8?B?YVZudC9uNnpSYXhRaWlCY0VWQVA5WnkyQ2JSZzZ2eE1HUUd3cHJWV0pkR1hu?=
 =?utf-8?B?UDNFa1p4dXFWYnhwWXVGUExKbFFCVzNLTTBhZGlBYkpRUUNiemFOU3UwSE1G?=
 =?utf-8?B?SFdrbGF2Z2NTdkJYOG54MWV6dUZQcGVJdzF1R2xKbkxQYzJWdEsxNDQ4VnBQ?=
 =?utf-8?B?Nk1URDhycGgrK0JRSThnMVdNTEVLNnR3MUdDMTFPOStjY0pCN2VyeWxCbnpx?=
 =?utf-8?B?UTdXN2VxVi9WbU41cDhmZUJiTUVvS2FkN3YycFRCQ2ltMUtiVkZvWHVOT2dX?=
 =?utf-8?B?WE1DcVFuMzN5blhaRFJ5Qkx2N0JwMFhzRVZYM0lpbWFRbjA1ZVh0bW9idVph?=
 =?utf-8?B?SjJhRGYzcURLS1k1YWZ1cDQxRFZKN3kvV0JRNUtudWVoWGk5alhhcWNtLzdI?=
 =?utf-8?B?d1JZV2E4a1Y3REcwOUJvTVhyUkZocFJZQVc2RExiYW1Kc3I2MjVKVFFxZ1Ez?=
 =?utf-8?B?aXZLY2pFUFRiK2p2UVFYbFV5OHFEMFpkdnN2c2VTMUEvQ05Nc2JIRXB4M2NF?=
 =?utf-8?B?WTVpQWlQaVo4bjhlYjVrWmFjb3FreEt6dFFXaDlJOWxUM2htY2xIdGVTL3I1?=
 =?utf-8?B?eUNYWkx5elNVR2Z0T2Q3cmh6UXhvQlhDUWQydndXQVlBMkpKc1Rkek1WbkRO?=
 =?utf-8?B?OGF5NDRQc0owOEV3OGVHM1l1eWtqTGtKYmNCUHQxcTVwam8vUllySFVmeWdu?=
 =?utf-8?B?UkRTTUU0Q3FqQWNBUDBmRlJWdFMya1NlM2c5L1RDd0RTNTJFTXVPVmR6TS9Y?=
 =?utf-8?B?UUd0MnpvazVhM0tZU2pISkFxMC9uTWtNY0ZBRFpkNDFhZUgyY0VUcHdId0RV?=
 =?utf-8?B?NXpCWkxHdlE0QU45UjlWUHUrSksvbEgxejdKVFFiZkR1YUxSeHVzMDdXWGt3?=
 =?utf-8?B?SGNoamUrNlJkczlWWTlIVDhRK0E0WjhTWTdlODdjelJLOFVCUU03UT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c1320f-ce5e-4ba7-a32a-08df127defeb
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Sep 2026 16:33:41.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: DkAbGG874SpGVY6ig2XbtbbG0vHtjEAI2oQymMV+c/ks6dqzyJLHI0vn68LQSF4DIpUF0Zh+RMZo38XDdPNvOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8877

++ AMD guys

On 9/14/26 11:18, Niklas Cassel wrote:
> Hello Mario,
> 
> 
> Perhaps you, or someone at AMD could help us with this:
> https://bugzilla.kernel.org/show_bug.cgi?id=221986
> 
> 
> Is seems that a user is having issues with:
> 
> 12:00.0 SATA controller [0106]: Advanced Micro Devices, Inc.
> 	[AMD] 600 Series Chipset SATA Controller [1022:43f6] (rev 01)
> 
> together with:
> 
> Samsung SSD 870 QVO 8TB
> 
> 
> when being issued command STANDBY IMMEDIATE (E0h) during system suspend.
> 
> The command never receives a completion.
> 
> 
> It seems that this is only a problem when "med_power_with_dipm" is enabled.
> 
> Apparently, when using "max_performance" the drives do complete the
> STANDBY IMMEDIATE (E0h) command successfully.
> 
>  From looking at the AHCI specification, the HBA should automatically wake
> the drive when a new command is issued via PxCI.
> 
> 
> 
> The user did point out that these Samsung drives are quirked with:
> ATA_QUIRK_NO_LPM_ON_ATI.
> 
> See commit:
> f2aac4c73c99 ("ata: libata-core: Add ATA_QUIRK_NO_LPM_ON_ATI for certain
> Samsung SSDs").
> 
>  From earlier reports, these Samsung drives appear to handle LPM perfectly
> fine on Intel-based AHCI controllers.
> 
> 
> This LPM quirk is only for the old ATI AHCI controllers, because it was
> assumed that, just like the ATI specific quirk that disables NCQ:
> ATA_QUIRK_NO_NCQ_ON_ATI, that the AMD AHCI controllers were unaffected,
> see e.g. 7a8526a5cd51 ("libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung
> 860 and 870 SSD."):
> 
>      After verifying the chipset from the user reports, the issue appears
>      on AMD/ATI SB7x0/SB8x0/SB9x0 SATA Controllers and does not appear on
>      recent AMD SATA adapters.
> 
> 
> I guess it is possible that while the AMD AHCI controllers have fixed the
> NCQ problem with Samsung SSDs (that was troubling ATI AHCI), perhaps the
> AMD AHCI controllers still have the LPM issues with Samsung SSDS that was
> troubling ATI AHCI controllers.
> 
> 
> It this anything anyone at AMD is aware of?
> 
>  From the users report, he is using the latest available firmware from Samsung.
> 
> Considering that Samsung SSD work fine with LPM on Intel, I'm considering
> the users suggestion, to simply rename the ATA_QUIRK_NO_LPM_ON_ATI to
> ATA_QUIRK_NO_LPM_ON_ATI_AND_AMD and modify the quirk to extend to AMD AHCI
> controllers as well.
> 
I'm not aware of anything like this. Let's see if Shyam or Basavaraj have.

I think that sounds like a pragmatic approach.  We can always back it 
out later if this ends up being root caused down to a different conclusion.

