Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010068.outbound.protection.outlook.com [40.93.198.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4570837E5FF
	for <linux-ide@vger.kernel.org>; Fri,  4 Sep 2026 12:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525501; cv=fail; b=PMitJTA3gnfFU9au2LhNK23UlJO6kvWXs8RRXR08Y0YO46rt0G6soq4IWi3sUYVGY/G1frG6P63/hC16H7kTCbbtw5JOiEWbh2oeidzCij5IzwGFurV6/9BOBJvJ2cdBKWZQiSqydslTgm+xGlva5ekGxUaBu4OfrRKrWEFO/28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525501; c=relaxed/simple;
	bh=+CsqJXNSdH7wfvBqEM+QCdLIKmjpQh7uNqFVAm4LmKw=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Ofof/w10OL6zS59Pq9RediHNsXwb/AYgcgKAmqJ0xbtNs4yAA4ZyIKSZyZAnxMsWsmJwBHAd8SlL1jl70K4ZFvRIh5SucCC14KLwzpDp7MDcnknsSehDB3No0MLYY8kRb6egUk005vq1IntlgiVX+ZIGw1W+eFhwO0tH6YdQOu4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=me11C3yW; arc=fail smtp.client-ip=40.93.198.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="me11C3yW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=q6Lkjbi4WnbrkvAP4MKtqUUaS3g5wl83gCJ1uPGAd7J78FX5Ehnm/V4S2HS9L5oYzAxJmOsl0WuxxdVjbxeTH3QTfZ4tfnGoSFUCd5+vwkLcQXI5/nSzcmIGuW921sknNOH1UfB9/Upv80IlkZ0/lVcDEhMTgSg853BUy7fdy+Er3fzWNAvLUaTKMKdGORJVLHp7YxnEKePellXU+KAikYzXL4kXvv69phGhjHyHd2Q6XqLiyWgRMTtjRKNfF+OHX+R0CcX9AIqiBGilylfIVbMvLL0UYGxcBhy/XcTd/JRIDw9fpvkWMv4cjanBQETgiVJzyiqL/f7gLqT4yK3Pvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vP/MojrBEH4ZOcIGz9vVDMt/0OrooYd78H66D+b4DTM=;
 b=Ka3Vz0XLN13ex/j4jz1kOEhY2lUfgoYZ6rWUjavJrb3A97v6u6oZ0mLsoTTQ+miMYUAdquhdtPW4yTKxErFYbudWeBhsAwdiyAiXuYMHZioR1dXUEw5sEMQaaxc3wqcakt17IrWSsO9BxjKCBc18uufko7PoQwaXJDL301eUdpbIN5w3oXxrtpx2H35/G9HSqQybbeygLDHD4CD6u+MnI3n6HxkNRkEV3E6ELlruKD4pG+Abydy7qi8iQbBNss+TP/W6pfw6vv+dF9SdBxpAtADHSUZh72VFXMEfkGYGGQPOFZJh+O6mnLzptrAvkv1nKz1rAafNwhRLPIh6QiTsoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vP/MojrBEH4ZOcIGz9vVDMt/0OrooYd78H66D+b4DTM=;
 b=me11C3yW0c/b0/j3UymhGduior2/7ziEjAeFygt0m1PSMQQuMs0EDYqbbulv+3VCuzp3F72DFrzZOEMOlIfM46WcAPHkbovaDWQY9zqpaIXAl4UMl/yJyixpZgFJaLDR0+qDqaRjs86nDYJ6yTNsbmrIQx6YY0bCARU+TUWrAOk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Fri, 4 Sep 2026
 12:38:09 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Fri, 4 Sep 2026
 12:38:09 +0000
Message-ID: <07efa8b1-c5ef-4a61-8b0c-45f68d02d9f5@amd.com>
Date: Fri, 4 Sep 2026 07:38:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
To: Niklas Cassel <cassel@kernel.org>,
 Roland Waltersson <roland.waltersson@netinsight.net>
Cc: "artmoty@gmail.com" <artmoty@gmail.com>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 David Laight <david.laight.linux@gmail.com>,
 Mikael Etienne <mikael1022bzh@gmail.com>, Alvin Lim <alvinwylim@gmail.com>,
 Lennert Buytenhek <kernel@wantstofly.org>
References: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apnpZ4d-utWZM_Ux@ryzen> <78dae3f6-3b3d-43c8-b2a2-595fd6e6a00b@amd.com>
 <IA0PR17MB66878CE05C135A2BA1F1DD079EB52@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apqn-bdMi4y4l1gE@ryzen>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <apqn-bdMi4y4l1gE@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0137.namprd11.prod.outlook.com
 (2603:10b6:806:131::22) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: fea95877-83c9-4883-8db8-08df0a816051
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|376014|366016|56012099006|10067099003|4143699003|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	0nDBwhraqktit9beCAbPL9931Y6KU6u6wBMaJl5+hKYOQTYwpBGs0ZLkPgF99VPJiN7r18apPolo/S+czGWyoTIQWdb39JPxsr3ZDG33Zn+1L1RAFepAi9s8oNwVTLqc3Q1yAIG1C4rYp1dEGYi/KnkjI0kSTPlExEO7qwjSON1/hhZDxdD8uEJ2ezWbRcthYHNZvJP8EGVBX326Utnngi03jJPlSzE+Mj6zjXyD/0dvo7Uulxse8rMmVbS9emMbSTN0hyXQr1uEDq2tM0o140ALebtZUmNU052W1j2Yz5eqplw73Z6+DYcAbePulN+1iJg2okH7i+A6wVsGZGHxlIuMgPkS4KXL/cDf/lX825Md1zMQKLyHZ4jmUJxfsKFgcngT12ovd9grx7pMVrF38D3YLBHtcB7zIyLzJdrBR+HnCZ/LksuSIjIB1uCCY8dBSe0rugBzy89S++bQq4qgKvY/y7ks/YAzPXB962uoIYKX3fQfbQuuD9BGi39jmtgqrCzuARltUwWypg1Hk9V+oERjc3iexx0drAcyTe0YILP+gZi9thQe+897o7ewIwRu/jAxIj8jAcrgUUssYkSk2lT0xBsCS4BLn1wRmVjconY0astEZSkwcTv2SpV3BKqz8p8fhuwNvPTkGNmg2N2gOkC8NYlbo1IWcfsux9m9pEA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(376014)(366016)(56012099006)(10067099003)(4143699003)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bTlvdHhmcnpOUzhpdGc5bjB5bnh2bXYzWlg3UVdBaGpmRUs3bXV4QUJRcXVs?=
 =?utf-8?B?NmhaNVFtWloxbFlTaVFjbHRURngvekpEOGVleEg5KzJrN0xUa1dYd2R3UnI0?=
 =?utf-8?B?eFhOWVc0YXo4VU9XQ2RhbEFwR1l1ZUhUWUExMVhoaDk1ckVOZml6Nk84SzRQ?=
 =?utf-8?B?S05zYjNqZjM4amlDSjJSTVVBVVNGNzRTMVg2cGlrdTRaWHA2WndYZ1p2KzZk?=
 =?utf-8?B?dThrRGs3eTFqcHFYWEF6MFh6Q1VTTmdFNUVuZTkrRDFxLzNjUjJNend2ZWRO?=
 =?utf-8?B?eUlqcWxlU01sTDNRdUw0YTArOHpvamlESVdSQldSM1RCVTZkZk00T0dGKzlh?=
 =?utf-8?B?VEY2R3Jtc2lMTllVZUkxMGxaWGgzYUVSYnlEYlFBaXNqWkFzU3dwNWV5bk1W?=
 =?utf-8?B?dHQxUjRMN0w5RVVIYW1lVFk1a3NUanB5d3ptaDJjUWYyMkNPWVJiN3k2VDRS?=
 =?utf-8?B?by9lZitEek5LdlZ0b0E2MEFrMEQ0WUpWMW9ocTlJU2QzZEVwSUx2elhhSU44?=
 =?utf-8?B?TVdaSG5maURQbUdsYWNTKzUvTVI1Yi85elpOaENKL0Y4enpuRG1lQnM2Vkc0?=
 =?utf-8?B?RlpyaU16dXdBRjc3NU5xRWlka3I5cnZKc2Jycjd5azhRY3ZJY2liZ3RZc0x1?=
 =?utf-8?B?NXFVNnlHSC9udVBsWC8ya1h2UmwvdFV4WUlwdE1BSFliYkVseGNzbUlLMjl4?=
 =?utf-8?B?cSttbnR5cUZsa1hFem1XV0VHK0FTZUpqNHlOM1dLa1RTRDJOcEY3T3hxZGNE?=
 =?utf-8?B?RG1aN0hTR2NGL2s5WmVwOTJUT1FvWWw0bXJyTkpPMW9pUjJRZEQ5Tk9YZHBZ?=
 =?utf-8?B?MUlWanl5TVZ4SENhczQ1RmhCcDhpUC85NWpWcmN6RzJscXIySm9GVWJqRUt0?=
 =?utf-8?B?d3JFRmQ4SGJybU5TQmc2MjRWZXdXYnZGUzE4YjJLbHNzbjJFdEVKSjBrS3Rz?=
 =?utf-8?B?eU45NHlSbDNKNThLY1I4UXFLb2RTdTZvNjNocTdvMTFvZXc2bDBzVmZFSXE4?=
 =?utf-8?B?VGVLbWRBRFU3akYvU0N0bEtVckdDRnJCK3Yrb1J4UXpYWjdBQjdLMTFTS2Q4?=
 =?utf-8?B?WFVGaXdCT0ZJSytRL3Z2OGU2Y1NKODZ2ZDJQWHY0NUlIYTllbzMwRU4xZC9r?=
 =?utf-8?B?Y1VXVFNvaXBBbTg3OWUxVDBqMHVyRkZ3TUM0L2l6RGc1UmdJU1JjNTdOZ2Rh?=
 =?utf-8?B?d2cwL0RmeWEzQ3Z5TUVpcEVsd053TWNJSmo5bStrd09kVkNISm9mRC9WTU04?=
 =?utf-8?B?UmR6UEpYdGxSeWs5dS9Uc2VyaXlteXVScWI0SFNOcVN5M1ZXRmhuR0w1UWI0?=
 =?utf-8?B?aTZvbTdQVGxHaURXUDdWMkY2bnNiVlYzbkpwMVZvVkhrYURBcW8vVzlVTGFZ?=
 =?utf-8?B?czZyWDgrSUMzNlZRMTZVTDJlNmJaYUU0b01PQXJHUUlFMjNjZTROSWFleVBN?=
 =?utf-8?B?SUhqZlc1N2RHMkhvalR0N0Fxb0VFazM3ZEpzdFYwTjgwS0tLNDVvNmhLUXY2?=
 =?utf-8?B?YWo4RjNIRVI5c090V1FZQi9ib0ozZFR1ZFo0TUd2OXdnWmZnelF2R1FZd1Rv?=
 =?utf-8?B?dmlrTFYyRHRKSC9OeHRKNzg5TWxWUFhFaHFIV3NOQ2lPSmNXM0hXM2JXMTFx?=
 =?utf-8?B?TDlIRlAyeFl6V0FMM3VIVEx5L3NHVWZybDR1U3g0SWRSR2p5c0xsQzlSZS8x?=
 =?utf-8?B?dkIwTUQ2OFA4UVNJZ0xCVGppSVdNaGJIUW9IMEFOZUY4RDJheXJZbXFuYzdW?=
 =?utf-8?B?ODhLQ01sdnhyWGZoTkMzL1AwNFFGWVI5WWNLcitnVStvamlmc2RvMnFOL3BJ?=
 =?utf-8?B?NGNyWEFOMDY5SFR5cnNQUmR3Y1FzOVRlWDQxSFl6VHRVYmxXMW55b0JIMC82?=
 =?utf-8?B?ejk3RkE4QjR4ZGw0T1NGamVKbUEzSXJ5YzhKeEk2TUExMS9zM0NTcGtMSy8x?=
 =?utf-8?B?bE1YUnp2b0xIakJZWTlOSEEwRVFuT3pLWXJ4dHJmUjdybWV5SXViMXdWbURt?=
 =?utf-8?B?N0RiREhHUHlFNWRQYVF1T1kwcklTNFQ5Y1VaZXBCMzlTTUZ5eDQwdjY0N1JF?=
 =?utf-8?B?QVdoTXNLMGpOeDVERDd2ZHVuWExEcmJubm1MQTJnSHloVFlBVWYrN0tqSXFH?=
 =?utf-8?B?UVIwT2RNOUt0cjN5dFVFUHE3RnZOTWdreDQrd3NTT1Z3cmtoWmtTK0x5THUz?=
 =?utf-8?B?eXFQTkpyOHI0Y3lCeHZHSzJPSWl0M2wxTWhTQWF3TjhVMzgwdTBCWlgrSFhR?=
 =?utf-8?B?UWJ0LzFLQ2ZQSjhCRGpqOU9aSS81YVhJZ2JyMzlVeWdHWEJrTTc1L2xwZEVT?=
 =?utf-8?B?eGRwVGxmZmF6UXp1Mk5ZVUdqTFVTZ3lQcXcyY3RFTDF5R2o0OUZjQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fea95877-83c9-4883-8db8-08df0a816051
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2026 12:38:09.5226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0b7/xvLo40CpmyO262akjlt9540hKjOOeKmZt2OU8d/24IzDF1zfU3AZ6DYOW8sIC9Fl9JPz6EhW+R8Y+8O0Eg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752



On 9/4/26 06:14, Niklas Cassel wrote:
> Hello Mario,
> 
> On Fri, Sep 04, 2026 at 05:20:06AM +0000, Roland Waltersson wrote:
>> Here are some debug printouts. Note that I am on 5.15 so amd_smn_debugfs_enable is not available - I printed the registers anyway:
>>
>> root@maglin25:NCA ~ # root=00:00.0
>> root@maglin25:NCA ~ # lspci -nn -s $root          # sanity-check: must be a 1022: AMD root complex
>>
>> 00:00.0 Host bridge [0600]: Advanced Micro Devices, Inc. [AMD] Device [1022:14e8]
>> root@maglin25:NCA ~ #
>> root@maglin25:NCA ~ # for a in 0x111401d0 0x111411d0 0x111421d0 0x111431d0 0x111441d0 \
>>>           0x112401d0 0x112411d0 0x112421d0 0x112431d0 0x112441d0 0x112451d0 \
>>>           0x113401d0 0x114401d0; do
>>>      setpci -s $root 60.l=$a
>>>      v1=$(setpci -s $root 64.l)
>>>      setpci -s $root 60.l=$a
>>>      v2=$(setpci -s $root 64.l)
>>>      printf '%s: 0x%s%s\n' "$a" "$v1" "$([ "$v1" = "$v2" ] || echo "  MISMATCH 0x$v2")"
>>> done
>> 0x111401d0: 0x00000100
>> 0x111411d0: 0x00000000
>> 0x111421d0: 0x00000100
>> 0x111431d0: 0x00000100
>> 0x111441d0: 0x00000000
>> 0x112401d0: 0x00000100
>> 0x112411d0: 0x00000100
>> 0x112421d0: 0x00000100
>> 0x112431d0: 0x00000100
>> 0x112441d0: 0x00000100
>> 0x112451d0: 0x00000100
>> 0x113401d0: 0x00000100
>> 0x114401d0: 0x00000100
> 
> Just to clarify, Roland is not one of the people who has been complaining
> about silent corruption after exhausting the 32-bit IOVA space.
> 

Got it.

> Roland complained that the AHCI_HFLAG_32BIT_ONLY quirk is making his JMB585
> SATA controller not even detect his drive when probing the driver, so he
> can't even mount his filesystem. So this is a separate issue.
> 
> 
> You should probably reach out to someone who has seen the 32-bit IOVA space
> exhaustion issue, i.e.:
> 
> Mikael Etienne - issue with addresses larger than 32-bit on AMD SATA controller
> https://lore.kernel.org/linux-ide/178789300872.392066.15963676631650361573@gmail.com/
> He claims that he cannot reproduce the corruption when using iommu=pt
> 
> or
> 
> Arthur Husband - issue with addresses larger than 32-bit on JMicron JMB585
> https://lore.kernel.org/linux-ide/20260406222335.379935-1-artmoty@gmail.com/
> His github claims that he cannot reproduce the corruption when using amd_iommu=pgtbl_v2
> https://github.com/artmoty-dev/n5pro-jmb585-fix
> 
> or
> 
> Alvin Lim - issue with addresses larger than 32-bit for ASMedia ASM1166
> https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/
> His github claims that he cannot reproduce it with amd_iommu=off
> https://github.com/Alvinwylim/asm1166-iommu-dma-corruption
> but it also claims that iommu=pt is insufficient.
> Note that we never merged this patch, because we never to any confirmation
> from ASMedia that the controller was at fault.
> 
> 
> I don't know why Alvin claimed that iommu=pt was insufficient, but for Mikael
> the problem was not reproducible with iommu=pt. Could there perhaps be
> different versions of the AMD IOMMU?
> 
> The only thing that I have seen in common so far, is that all bug reports,
> JMicron JMB582/585 / ASMedia ASM1166 / AMD SATA controller, have been using
> an AMD IOMMU.
> 
> 
> Note that there is one separate problem, Lennert Buytenhek actually got
> AMD IOMMU page faults, rather than silent corruption:
> https://lore.kernel.org/linux-ide/ZaZ2PIpEId-rl6jv@wantstofly.org/
> This was actually verified by ASMedia to be a controller issue that they
> only support 43-bit DMA, and they provided a list of affected controllers:
> https://lore.kernel.org/linux-ide/ZbopwKZJAKQRA4Xv@x1-carbon/
> Note that these controllers where quirked with 43-bit DMA, and that
> ASM1166 - which Alvin had issues with even for 32-bit addresses - was not
> in that list.
> 
> 
> Knowing what we know now, we would never have accepted the 32-bit only DMA
> quirk for the JMicron JMB582/585 controllers, without at least seeing a
> single bug report from a user with an Intel or ARM IOMMU.
> 

Thanks for sharing all of these.

> 
> We probably want to send a patch that drops the JMicron JMB582/585 32-bit DMA
> quirk. But first we want:
> 
> 1) Someone with an JMicron JMB582/585 + Intel IOMMU or ARM IOMMU
> running in enforcing mode, to run the reproducer written by Mikael:
> 
> ####
> fio, io_uring engine (libaio not tested yet).
> 
> Write the canary once:
> 
>    fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
>        --ioengine=io_uring --direct=1 --iodepth=32 \
>        --verify=crc32c --verify_interval=4096 --rw=write \
>        --do_verify=0 --fsync_on_close=1
> 
> Then loop the verification until it fails:
> 
>    while :; do
>        fio --name=canary --filename=/srv/12to/.sata-canary --size=256G --bs=128k \
>            --ioengine=io_uring --direct=1 --iodepth=32 \
>            --verify=crc32c --verify_interval=4096 --rw=write \
>            --verify_only=1 --verify_fatal=1 || break
>    done
> 
> The reboot-without-rewrite protocol: when it fails, reboot and re-run only the
> verification loop above. The canary file is never rewritten. It verifies clean.
> ####
> 
> With the 32-bit only quirk dropped:
> 
> diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
> index 58f512f8952a..1cee901f8e72 100644
> --- a/drivers/ata/ahci.c
> +++ b/drivers/ata/ahci.c
> @@ -215,8 +214,7 @@ static const struct ata_port_info ahci_port_info[] = {
>   	},
>   	/* JMicron JMB582/585: 64-bit DMA is broken, force 32-bit */
>   	[board_ahci_jmb585] = {
> -		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR |
> -				 AHCI_HFLAG_32BIT_ONLY),
> +		AHCI_HFLAGS	(AHCI_HFLAG_IGN_IRQ_IF_ERR),
>   		.flags		= AHCI_FLAG_COMMON,
>   		.pio_mask	= ATA_PIO4,
>   		.udma_mask	= ATA_UDMA6,
> 
> 
> To verify that this is actually not a SATA controller problem.
> 
> 
> 2) A fix for the AMD IOMMU driver to be merged, and backported to stable,
> such that us writing a fix that drops the 32-bit only DMA quirk for JMicron
> JMB582/585, which when backported to stable, will not cause users with an
> AMD IOMMU to silently get their filesystem corrupted.
> 
> 

Right now what I'm thinking of doing is a quirk in arch/x86/pci/fixup.c 
to set the registers that could influence this issue.

An alternative may be some quirks to the AMD IOMMU driver to avoid using 
the upper 5 bits for the IOVA allocations (making it 59 bit).
