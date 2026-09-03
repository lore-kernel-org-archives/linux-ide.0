Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010012.outbound.protection.outlook.com [52.101.193.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2938A353A69
	for <linux-ide@vger.kernel.org>; Thu,  3 Sep 2026 22:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788474975; cv=fail; b=Pe22xhMvhZzuD90SXxtEfNsYtVBOgebawt0MakwGKbXFjy6RNMcD1mKfvCN+FK+RA0jho0LSG7vfReOpGtAnz+bJ5jh27awQ5y4wyLiIfBSzHKyRn5RxVKEaLh4XME6KONDSVjBMe9ii2ZyrwXouN9/DFnhAigjwhktWf2r+mGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788474975; c=relaxed/simple;
	bh=CG4GvNNlcM1DLiLmTCpND0mbvhCBBw8teXymQp5darY=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hMZ6QtV6Uq7aXoFlxQYsXWOpy8qUCXAw1BD0SPXwpj13e/0+8S+Upu4nVSek5pwvZXfcionudQBWOQLR+3NknYVsI/o1dGjoq64MnGuZ0o5A4wLKrqmP/AoPnHv9pEj3TQk+PPsOXv7LZVQJ5M86ddcA2g4ZdmQ25WCloJfpAzc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=i4oOgiF3; arc=fail smtp.client-ip=52.101.193.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="i4oOgiF3"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OoC30VKGRO4F7XCQY7ecsYki1IoZVAJSiESKdYz4V96SS8zQ1tjaoeoMtijEfR5cjHM8DWW7xnyypde40ibjbejN9RtTeEL24F0K+SrB7KChvSkuc9v/46wBOcPRQaEDvF/FJ6phO6zwQNLtIA0AMyoLlfvNnS7TBXHcHpIcmurYDI0lYp41WToArN3kZwblV0ExieXhqCtJXDXu1Ys3ve6eft8yNDggRDRE9znKgMvqGzi2Jaxi1usNdQPHTfvSOhcc0quSjYL2UkoXe0jOPh7evRv8TlbgMkHn0Dsa26On90GysdAV4vM9I0ZV7j/PyvVYVGKPgSm0xo2gqs3O+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KgsFw4+NHLNA+5xnIFm6faFo4KYcfOW0DuJsBmWqyHQ=;
 b=Aw1dEHhbpkKsauBuur2hRIYkefd1mnhinA7qB0Bmvx6zZYpbH/1y+g3f0DKgHQvtbtZlsjTIbVB3YYE0E9OrQddzfFK9Pejq5VsMqrZqJTnGLfrh15ix+9pWIEY9okurNC7PVnoqKMy7dFzrYWcIxvm28Rgk6Xy/tP5/+x/nyR0BlVw4o8L7/tvNveh+cy82xwhGRQbAGjcCQKAm/TCWmIc3pTHDVj66SsHxd7YjwgkJ0U4S+ZzE30LYk4MX+c9JGNIU45ZZ63HZdV3Vw51BwEeQDDEXZfRWDAhjHj6aH6R5EyrTrq9SmUqyrKwrEs18getN6vMP/NJM46EjaQON+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KgsFw4+NHLNA+5xnIFm6faFo4KYcfOW0DuJsBmWqyHQ=;
 b=i4oOgiF3PjpDDxGfNg87vUD2vORQFTL8rKxQVjgCwxw62Mhd92TXX/Wnyf35E/9EfuqBN0nbM5VIA6tVuzSP5rwPLoJiQ9ey2BPyZ70cHpZtOhnVsZD0MxI9gB+61yo8SNshTr4R3PxBwyvj1lX+dRew+WkgEv7F/doouvUIFEg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from PH8PR12MB6914.namprd12.prod.outlook.com (2603:10b6:510:1cb::21)
 by CY3PR12MB9632.namprd12.prod.outlook.com (2603:10b6:930:100::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.382.10; Thu, 3 Sep
 2026 22:36:08 +0000
Received: from PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000]) by PH8PR12MB6914.namprd12.prod.outlook.com
 ([fe80::2893:177a:72b0:6000%7]) with mapi id 15.21.0360.008; Thu, 3 Sep 2026
 22:36:08 +0000
Message-ID: <78dae3f6-3b3d-43c8-b2a2-595fd6e6a00b@amd.com>
Date: Thu, 3 Sep 2026 17:36:06 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ahci: force 32-bit DMA for JMicron JMB582/JMB585
To: Niklas Cassel <cassel@kernel.org>,
 Roland Waltersson <roland.waltersson@netinsight.net>
Cc: "artmoty@gmail.com" <artmoty@gmail.com>,
 "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
 David Laight <david.laight.linux@gmail.com>
References: <IA0PR17MB668730A4ECCD65F7A1DC3EDC9EB62@IA0PR17MB6687.namprd17.prod.outlook.com>
 <apnpZ4d-utWZM_Ux@ryzen>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <apnpZ4d-utWZM_Ux@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: SA0PR11CA0001.namprd11.prod.outlook.com
 (2603:10b6:806:d3::6) To PH8PR12MB6914.namprd12.prod.outlook.com
 (2603:10b6:510:1cb::21)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB6914:EE_|CY3PR12MB9632:EE_
X-MS-Office365-Filtering-Correlation-Id: d0877f77-a6ee-426d-5ec5-08df0a0bbf91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|366016|23010399003|13003099007|6133799003|3023799007|10067099003|4143699003|5023799004|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	o7bOvAagtEqsnsy7IbtmrvxKO1/CPd4jjpXTDsAWvkgxbrhnbqeGQXtWY57gOAY5+mHOO6lECPq9NCcWOupkHZIQLHyCEU+vckyMiwkffwcZYpk0PHU7zJTSHAFjC3WJuLdAqMdu8qXW0ZY/iaGf5ve46MWdgjh5kAyiMC3Cbekl1FaFJ+DLThI5GHNkSZS2C5YHK6aMqAWpY2RnRyaShvVlJXUv6H3qhF8QFzo3VloYq2s0zPPReYW88OH8vmhKVA2nekYTxo6TNok4cn379LgPSTavOpVn90xh7LojbqtrYEWMxnbbGL/heSP7nikfzDOUIKBQQXylG/KJKOMIcSfP5pcFVetHJmIF/eNUy23VTIzEKGaD5tXQkEG8G6IF2weZPwEWhBQelg/MTpOcSFUJd3GjysbFsGTz/ckJmraxHjjpmjsbpb/9a2hUbqrhPu/NMvUzhF3be9bPWNvPD96fy2Z1mgVtD+dFdFU049BP/MejmUZfMxwtwNQ7jSs/jAMxBi+/wGHBfoqnQExnGtGl8JRYal0vfzfsFyjAt9RAabPHkC3sRo70BbKkFV8krFBdX0MjMfrCQhksswbnU15/hf7hQV5eL5cxXvnjhPF2/zaerlFrrNM/b62GlDO6
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB6914.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(23010399003)(13003099007)(6133799003)(3023799007)(10067099003)(4143699003)(5023799004)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OEpxNXFDbm9XSktZYW9paTBQdC9GYTBKNUVUNjlSNnIwMDNzNVFabHpsYW5J?=
 =?utf-8?B?N0hrRjlvNHg5YWhzRGw4Mjh4aDRCd0k0aDIrT2ZiY2YvWjROWFd2Mjd5U3ZR?=
 =?utf-8?B?ZlhyVkF0YXNZYXl0VWtoTzI5bk9Kb1Nac1lrWmdjY05xVmlUMTZUUXdDQ3VP?=
 =?utf-8?B?V3lhR3Jhc3B0emlFOGdTZkFsclBTMlRJZTNQQnY1YlNqMjBZV3pEZGNtTUx6?=
 =?utf-8?B?QzQyOGl1U3ZpcER2eHdza05JaXI4cWVtZm9BNW5mZ2NKTm5SbTcvREcvbWFO?=
 =?utf-8?B?QW1RU3ZYTXM3bUtEZm1hNitoV2JTOExoaGZSVUhVOHhJVWtiSEk5SXAwNkE0?=
 =?utf-8?B?MTJSMFJpU0VzRldRTnpDY1h1dWk3QUhlWXhLekZxWklUNzBYenRsT3RMTUZV?=
 =?utf-8?B?WTRUdUF0Q0RlQ0djVExxZDRrNVBLT1Avd2Zobm16dmppSHY0NWZEVVJ4L3N0?=
 =?utf-8?B?dWpJc2tkSmtUNWFVZkRFK3dGWFFjb3ZidGpGYjVoN1NqV3N4U1p5U0FVOFFV?=
 =?utf-8?B?UXZFM25GcXdURVBRSThOd3VNSS81dE5KWnBqSWxLeGdEYTJNODdscS96SmJ1?=
 =?utf-8?B?ZUpxWmxCME9VQUtSMktEdFlWUEpBL1VXKzFFdHN0clFSLzFHTElwSUJKRFRB?=
 =?utf-8?B?WjBHdG1HUnMydTBzVDlOUFhwM05JdDVETFhHajVQaE5EUXpYZmkva0xEWER5?=
 =?utf-8?B?aVU1MWJMODN6MVloSUMrZ3lOVWY5ME52a2NWVTVXTnlZK1o5R3hXM3l6TE5k?=
 =?utf-8?B?VnVDb3kvaHJmazdhYWFaZERKd1I0ZTlmN3BMdUtiTnYrazdidnNMUTZHS0c2?=
 =?utf-8?B?bUJtdTV1cFVmMDFkVFIzUkEyNm1JdzhCd3lUTS83OEcxUkgvaWYvbTdvaCtp?=
 =?utf-8?B?MFNSaWwxcEcvRkhUOFRrUjdkSytJbU93SHZralpPQkUzMWthTnlTUWZvTDVq?=
 =?utf-8?B?Y295dWs5aTZoUm9Ob2JlQ1NramNHOUp3N25wMGcxWHR4L3F3YkVMUGFsc0Ex?=
 =?utf-8?B?Y2tpc1dQSjFJVk9JVmVqa2FHTHpISk1FTkRDZ2w1VTY4UElocnBVeDIzVE9y?=
 =?utf-8?B?N214NVYwWjVjM0NCQ3BRekxuRWU3VFJ1bkVPeW8zMjFJOFJuMzJyMFFaYWgw?=
 =?utf-8?B?amhQNXJzYUZTaEtiMlBpS0p6Ynp1ZGsyZ1V3QjJuMUdYbWt2VmRSd2hvd3VY?=
 =?utf-8?B?dGlRR1hwbTdFUUQ5YkFQS2ZEd29lSW1JOUZmVmVpNS9UbGVhS0dxbTJ1aTNR?=
 =?utf-8?B?UVBUbitMa205SUxTdFlVdlFpRDh1cStDMG1RcFdxMzZPTm44bW5LS3RWL0k5?=
 =?utf-8?B?VGEvRnh2Q1MxSW83a1JmQ3pqUCs2b1A1RVE4Sjhkd2VWSXl6R0R6R0p2Wk5y?=
 =?utf-8?B?Tkh6b0VRbUdJYXdsWGxXYmlOaHVZTGRLUHZwcit2cS9iV0d0Y05WZHBpbnMw?=
 =?utf-8?B?Sjl3a3pPQ1NZM1lnMkdMc2htOXJtamJLMTRaSWNUd2VpMENlUWZwNVpIK3gz?=
 =?utf-8?B?SnBzanVlZm5YOHJMVEZDNnVkekpsZlJra0NSbUkzeXE5WlNlTC93UDZucHAr?=
 =?utf-8?B?aHRyTmliZXBNenZTUWhUNEk4R1djNzBWSnJDdHNVR0RVT0s5WEUrSnAwdWw2?=
 =?utf-8?B?bENqdjFRRWJRQmYxL2haU2Izbk1qV05YdjVyWkUvU0dDclJGRlVQaW1qeSth?=
 =?utf-8?B?blB6b1EvVkQveVBHS3o2MEh2c1o5Y2N5Z0VHTnVCYjB2V0xFNjcwSk1tUlIw?=
 =?utf-8?B?alBSTFVUbEtTa1Y5OC9kblYvS0VFRWFlR2ViL0hzcEZjeG92RWtNeWYzZlJj?=
 =?utf-8?B?TlhpRFpmQTFsR3JVN3FLYUl1THpONlE5ZXVIbGswMEMrMHJoelhHbk5PTzMr?=
 =?utf-8?B?eXJZK09uOEVGUWliQjQ3VjFvUzBSMi9UcC92eUlEMW5jeHViZmtHTS9VNElP?=
 =?utf-8?B?SzRWRVFwaW54UklIVERHNGd5Rkk5RTRuWHlJaXN1eWRMOGsxWThZcCtTV1g5?=
 =?utf-8?B?TTVqckROTEkxSWx0Z1VyVGo3WU5FeEpkUmxyRzFoaHlkRktvdDFjMFZha0Rv?=
 =?utf-8?B?dXhzOUFybDZJQWUwNTJySldzRzFQdE9PWXdFRHlPc1U1Z3NBOFFtd2pETXBZ?=
 =?utf-8?B?eThCcHBIcHdtSnppby9IUDZGSjZIWXQ2RlM2Rldxb2dvTHF0bExTMENBcnRh?=
 =?utf-8?B?bHEzdXlYR0tad0Fiek9pZ2dTOVgzVXlDcFFYQnRidmN0THk0YWZ6WVQwUmFU?=
 =?utf-8?B?WEw2eUU4SDF4UkFYVzZZUnROZVl4eE14bjAwVlU3YUFPSitPUnN0RmEwdGtY?=
 =?utf-8?B?cjVteVMrZlBTVGEzWERoWVBSa1RXK1JmdnVOWWZIMGx2Ly8weGVkQT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0877f77-a6ee-426d-5ec5-08df0a0bbf91
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB6914.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2026 22:36:08.6447
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: znenoFJlSjnjaKdW3ufvmN+vD9AmLOcyHNhTH5ny1h2dE7zDWN5a0uucljhlCOQktHf3GUIWZDQc34wVyt1TFA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY3PR12MB9632



On 9/3/26 16:40, Niklas Cassel wrote:
> Hallå Roland,
> 
> On Thu, Sep 03, 2026 at 01:35:40PM +0000, Roland Waltersson wrote:
>>
>> (analysis provided by Claude)
>> Hello,
>>
>> Commit 105c42566a55 ("ata: ahci: force 32-bit DMA for JMicron
>> JMB582/JMB585") makes a JMicron JMB585 unusable on our board.  I
>> believe the cause is not the quirk itself but a pre-existing gap in
>> ahci_start_fis_rx(), which the quirk newly exposes for this
>> controller.
>>
>> Hardware
>> --------
>>
>>    - congatec conga-TCR8 COM Express Type 6 module
>>      (AMD Ryzen Embedded 8000, Zen 4), BIOS TCR8R904 dated 2025-11-11
>>    - JMicron JMB585 SATA controller on our own carrier board,
>>      at PCI 0000:02:00.0
>>    - AMD-Vi IOMMU enabled, default (lazy DMA) domain type
>>
>> Symptom
>> -------
>>
>> The controller's link never comes up and the boot dies:
>>
>>    ahci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0001 address=0x80fffc0440 flags=0x0030]
>>    ahci 0000:02:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0001 address=0x80fffc0000 flags=0x0010]
>>    ata2: softreset failed (1st FIS failed)
>>    ata2: reset failed, giving up
>>
>> The disk never appears, so our initramfs cannot mount the rootfs and
>> switch_root panics with "Attempted to kill init!".
>>
>> Analysis
>> --------
>>
>> AHCI_HFLAG_32BIT_ONLY causes ahci_save_initial_config() to clear
>> HOST_CAP_64.  In ahci_start_fis_rx(), the upper halves of the command
>> list and FIS receive base addresses are written only when HOST_CAP_64
>> is set:
>>
>>       if (hpriv->cap & HOST_CAP_64)
>>             writel((pp->cmd_slot_dma >> 16) >> 16,
>>                    port_mmio + PORT_LST_ADDR_HI);
>>       writel(pp->cmd_slot_dma & 0xffffffff, port_mmio + PORT_LST_ADDR);
>>
>>       if (hpriv->cap & HOST_CAP_64)
>>             writel((pp->rx_fis_dma >> 16) >> 16,
>>                    port_mmio + PORT_FIS_ADDR_HI);
>>       writel(pp->rx_fis_dma & 0xffffffff, port_mmio + PORT_FIS_ADDR);
>>
>> There is no else branch, so with the quirk active PxCLBU and PxFBU are
>> never written and retain whatever firmware left in them.
>>
>> The fault addresses decompose accordingly:
>>
>>    0x80fffc0000  ->  low 0xfffc0000, high 0x00000080
>>    0x80fffc0440  ->  low 0xfffc0440, high 0x00000080
>>
>> The low halves are exactly the IOVAs dma-iommu hands out for a
>> 32-bit-masked PCI device (the allocator works downward from the top of
>> the range, so the command list and FIS receive area land just under
>> 4 GB).  The constant 0x80 in the high half is a value the kernel never
>> wrote; on this platform it places the DMA target at 512 GB, inside the
>> above-4G PCIe MMIO window.
>>
>> This also explains why booting with iommu=off does not help: without
>> the IOMMU the transfer simply goes to that MMIO address silently
>> instead of faulting, and the FIS still never arrives.
>>
>> Confirmation
>> ------------
>>
>> Reverting 105c42566a55 restores normal operation.  That is obviously
>> not a fix, since it reinstates the broken 64-bit DMA the commit exists
>> to prevent.
>>
>>
>> I have only reproduced this on 5.15.215 (the quirk reached us as
>> 4fc637dcad14 in v5.15.209); I have not tested mainline.  The
>> ahci_start_fis_rx() code above is however unchanged in current
>> mainline, so I expect any AHCI_HFLAG_32BIT_ONLY controller sitting
>> behind an IOMMU whose firmware leaves PxCLBU/PxFBU non-zero to hit the
>> same problem.
>>
>> I can test patches on this hardware.
> 
> Thank you for the detailed analysis.
> 
> I have sent a patch here:
> https://lore.kernel.org/linux-ide/20260903200349.1316460-2-cassel@kernel.org/
> 
> Which I hope will solve your problem.
> 
> 
> 
> Side note:
> While it seems like you have found a real problem for devices that actually
> need AHCI_HFLAG_32BIT_ONLY. It appears that most devices that have either
> AHCI_HFLAG_32BIT_ONLY or AHCI_HFLAG_43BIT_ONLY does not need it at all,
> which AFAICT, includes all ASMedia and JMicron SATA controllers.
> (So ideally, we should drop these for the ASMedia and JMicron SATA controllers.)
> 
> The only controller that actually seems to need it is ATA SB600.
> 
> If you look at:
> https://github.com/artmoty-dev/n5pro-jmb585-fix
> 
> It seems like adding amd_iommu=pgtbl_v2 to the kernel command line
> works around the problem (without the need for any quirk).
> 
> If this was an actual problem with JMB585, changing the AMD IOMMU
> page table format would not solve the problem.
> 
> AMD themselves have even confirmed that their IOMMU is buggy,
> and will misbehave once the 32-bit IOVA space is exhausted:
> https://lore.kernel.org/linux-ide/d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com/
> 
> And that the workaround is to use amd_iommu=pgtbl_v2.
> 
> It also explains the weirdness that the problem could not be reproduced when
> disabling the AMD IOMMU:
> https://lore.kernel.org/linux-ide/20260621100844.1224301-1-alvinwylim@gmail.com/T/#u
> 
> So, since you have already shared that you have an AMD IOMMU enabled,
> I strongly suggest that you enable amd_iommu=pgtbl_v2 to workaround issues
> with this IOMMU. Yes, the AHCI_HFLAG_32BIT_ONLY will workaround the problem
> for your SATA controller, but you probably have other devices behind your
> IOMMU as well.
> 
> Ideally, AMD would send a patch that forces the driver to use pgtbl_v2 for
> all IOMMU versions that supports pgtbl_v2 (amd_iommu_v2_pgtbl_supported()).
> 
> 
> Kind regards,
> Niklas

So regarding

https://lore.kernel.org/linux-ide/d49add14-c8de-4b6b-9049-4a07e5692ee9@amd.com/ 
yes it should be a BIOS issue.

But I'm /trying/ to come up with a patch that could help to change some 
registers that would help without a BIOS update.

Can you please confirm a few things?

1. PCI topology of the system (I specifically want lspci -ttvvnn)
2. F/M/R from /proc/cpuinfo
3. Turn on  amd_smn_debugfs_enable=1 on kernel command line.
Then use debugfs to get me the outputs from the SMN reads of these 
registers:


        0x111401d0,
        0x111411d0,
        0x111421d0,
        0x111431d0,
        0x111441d0,
        0x112401d0,
        0x112411d0,
        0x112421d0,
        0x112431d0,
        0x112441d0,
        0x112451d0,
        0x113401d0,
        0x114401d0,

Something like this might work.

sudo bash <<'EOF'
set -euo pipefail

if ! mountpoint -q /sys/kernel/debug; then
     mount -t debugfs debugfs /sys/kernel/debug
fi

dir=/sys/kernel/debug/x86/amd_smn
test -d "$dir" || {
     echo "Missing $dir; verify CONFIG_DEBUG_FS and 
amd_smn_debugfs_enable=1"
     exit 1
}

addresses=(
     0x111401d0
     0x111411d0
     0x111421d0
     0x111431d0
     0x111441d0
     0x112401d0
     0x112411d0
     0x112421d0
     0x112431d0
     0x112441d0
     0x112451d0
     0x113401d0
     0x114401d0
)

printf '0\n' > "$dir/node"

for address in "${addresses[@]}"; do
     printf '%s\n' "$address" > "$dir/address"

     old=$(cat "$dir/value")
     [[ $old =~ ^0x[[:xdigit:]]{8}$ ]] || {
         echo "$address: invalid read: $old"
         exit 1
     }

     printf '%s: %s -> %s\n' "$address" "$old" "$readback"
done
EOF
