Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2072.outbound.protection.outlook.com [40.107.93.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF4BF149C74
	for <linux-ide@vger.kernel.org>; Thu, 13 Jun 2024 17:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718300164; cv=fail; b=g4dzscMx384Ew0NRSqZPx3ur3bzT7FIZ/6eU5iK/1u474wiiQsqwEwkJFLBictyeTpYDrJf64v4HxfPY04WIt/0rhmE8I94H6LTgZUaC0MKYz+E2pev9zpiuJ4kY/fcExavmqVGlgKQX7Rx088/2O81QCM3EBRMjPTUotrZpeK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718300164; c=relaxed/simple;
	bh=gawKh8jxwV3FyDJyKqHTV8XCbzcOsg8jcAFCRuMBiGQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=UeFrtHDY8KSnLyISa7Cf7lgLCRrqNoHAUZM8FFSY3rh6bWNQI8VH7JCMM4KMVx6za9RQKQQQp1hVjOf0NkKJnKDbk6EN+K5vCtpAJpcCUPgUXfeknpJHNlA4nGUjv+RMRxzp0UQqgfIPE6W5FbOxI7WQaY45Kc4jeQEfzZ3MeGE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=3T9ynj1J; arc=fail smtp.client-ip=40.107.93.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="3T9ynj1J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fnz7xqPHPIEgxbpTMoUtKYSdGNLt0Am4NhuZoddHspOLBWUkyhEgZWEtGlI2akJxlBBxgVxjK8wVBl1wule7TTh1xpu8okiDZaauPLZVEZ8UIIlrO7b30nSDI93ViXQsBuGpZKeELBt4tTqUCwdWT/7GEBDnkSGO0R4kbDLkN8/7GKRLOtohzRUbKqY3XQ5y9pl4JTpbzjt/p9+eVI9aNURjpRM3JiKlm5659gPsYaM3TXaKFZFvRx7gx7Au6mseoXXdjnKIisfwAeW8XtS5PHfqLGnFPPl1XkOKwBnQG7i0DRWjhKF3QCQPPaSXPnZ0XRUjbcgw/ty0gsytGRxr3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ne3Fg6IxMHALpinbMRUWnigY1aqiuxJP84gPP+hGki8=;
 b=UXdx5qMp4i5A17ZpOKr23AK0mNcoOcOsWzYGLqh1bh5D9zRyMjkw6GcgdELennofXkPmUxjby7Fn1Q/2g219vZvdvkpMQVB7fpUbh014mUEIcOJJ/Ml8qPrnmKK+d9l/QquPJdgaPJw0+2HFoK1EePX8Q3M3OGREKVafqbhzRe5LxgcEWiPf0Fn5peXuLyPAf3WYiTOBYdOEcygHiAUZXwQZJiA0mvo3TiZA9nzBRjAwMwF/qZIKD+BL7wf+jLTdyK0Ml5R7/JsGwUYJYGzFrCNqFHG0tA6Hoex1X0dSLRez8TOvs4tNMYSwIQzZK7fz8KVoOw2SfcZ2Vb7NBjnKsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ne3Fg6IxMHALpinbMRUWnigY1aqiuxJP84gPP+hGki8=;
 b=3T9ynj1JX01xKh9oNh9EKdunvkWRUCft8bj9o7XNmafBSLR3N86i3s6R2Yz85BGWvIBSF9HnN3pin7nYP1ewHg45ukP5zXkTpH+1a7Mv9u2UEeusFTjrhCx2gYEInpH3lfn4elxTUA7dF387ejPX7BDkZrz7e75FyfrIF+yPiI0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MN0PR12MB6101.namprd12.prod.outlook.com (2603:10b6:208:3cb::10)
 by CH3PR12MB7593.namprd12.prod.outlook.com (2603:10b6:610:141::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.25; Thu, 13 Jun
 2024 17:35:56 +0000
Received: from MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca]) by MN0PR12MB6101.namprd12.prod.outlook.com
 ([fe80::37ee:a763:6d04:81ca%4]) with mapi id 15.20.7677.024; Thu, 13 Jun 2024
 17:35:56 +0000
Message-ID: <d3a495f6-b7d3-4a5c-b326-f594dbca936e@amd.com>
Date: Thu, 13 Jun 2024 12:35:54 -0500
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-scsi: Set the RMB bit only for removable
 media devices
To: Niklas Cassel <cassel@kernel.org>, Damien Le Moal <dlemoal@kernel.org>,
 Mika Westerberg <mika.westerberg@linux.intel.com>
Cc: Manuel Lauss <manuel.lauss@gmail.com>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-ide@vger.kernel.org
References: <20240613173352.1557847-2-cassel@kernel.org>
Content-Language: en-US
From: Mario Limonciello <mario.limonciello@amd.com>
In-Reply-To: <20240613173352.1557847-2-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: DS7PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:5:3b5::23) To MN0PR12MB6101.namprd12.prod.outlook.com
 (2603:10b6:208:3cb::10)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN0PR12MB6101:EE_|CH3PR12MB7593:EE_
X-MS-Office365-Filtering-Correlation-Id: 3bb0ed91-dae3-4c7a-4cf5-08dc8bcf4825
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230035|376009|1800799019|366011;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Wk1zMURMNm5kQTJHVHF1ZG9iRGp1aGlnNGpUYnlEaGJ0M3VBaHVSODNvTzFW?=
 =?utf-8?B?cjJJS3BtNEpDak5RWCtPZGZIQldIb3dwV1ZOZ1BNNjFsWGZsSzk1Y1VsL1VV?=
 =?utf-8?B?MjNYcURHcllMQVExZ3QzYWhGUVVLR0t2UFl3WFE5VGk3MXVFL29yd21JOVpa?=
 =?utf-8?B?b3lDdTBGdDZDY3d5cC81YnF4N3RMeWk5YzFScnFBUVF3NGpDSUFSdWt0UGp1?=
 =?utf-8?B?MWNtZnd6bWZpalhHcm02TFQ4MldER3MrdGdLSmxMN2lQRGptY09yY2dQakR6?=
 =?utf-8?B?bHZ2UXNzcnNBZFRWSFFhSEhubWo2dnJpV09vampLU29UNmdKRG0xTW5jaUMx?=
 =?utf-8?B?UlQwdHhITkx1ZzdWL2ttU0RqWHJ5NFZqREpranpQdW9lcVhSVCttb2lWeFlQ?=
 =?utf-8?B?OERQNk9BS0dwM2FWMTBnMVo1Zzd5WUgrY244N0ZGcGg1KzAvOEZWeTZOM0Fu?=
 =?utf-8?B?THlBRE9zMjQzMTRyY0RkamhIU0NaWm5TbFZSZDQ2RHREOWVmK0x3c0JBZnhx?=
 =?utf-8?B?VExUenJXdFNsaE5xTXVpL2U3SGcwREgvNktIRTVaQXdrVSszb3NrWm93dDhi?=
 =?utf-8?B?Mjdsa0REN1JCeitLdFVWT1RLb0ZCSlZHRG9CMVUrdHA2SWc1Q09WR2RuUUxu?=
 =?utf-8?B?dDFvRGxHMi9SNFM5dG91RWVoSmFSYmJoNUdDTkhrdUhpOFlGcWhINGRLVU43?=
 =?utf-8?B?MXh6ZXlHVmhnV281VmRWd0NQS0hQUTQ5MWpxaURia2lmSm5rdm1QV1poOC9v?=
 =?utf-8?B?emRNanNBVzNZNDNwbGlZNjhhdFViN0JMNldYT2ZEQWVURW85QTZET0N3Y2RZ?=
 =?utf-8?B?SGNCcE56d0ZNNncyN29waTJYL3dQMjcrZGZRSVZQL0RTQUhKNE1sWGhPTTk3?=
 =?utf-8?B?emt4N3ZYWnVzdE5pVVdIREw1NnRXOXJsWWUvTE82QmdzdldGSE9VRDFTQUlr?=
 =?utf-8?B?SFFseGFZNk9BbEp0eWlSTE03clp4WEZ5OVpaSUhQSGU2M0x2NGk3WC9waWxE?=
 =?utf-8?B?bldEdlllQnRrVDZzNGVNMnNtelBheEp6d0NXOHdGSm1aQU04dmlYTUtmMTBZ?=
 =?utf-8?B?TDVpNHNWSVF2OTNJamY0eDJ5QmVZb2QzUU9wWFVzb0F0MzJQNkxaOUZmS0Rx?=
 =?utf-8?B?Zk81RGZQT1IvL21nTWp2Q0VrcmRwcng1dTJGN1kxVi9SNHNqWjlRTUIzL3NC?=
 =?utf-8?B?WEdhRWRtTG9PU09Hd2JtTWJwdGVSTStoQ25Yb21BRVF6SzZNVk1OMzJCeHA4?=
 =?utf-8?B?UmZ6dlV3cDk3SWpMNTVPZVdyNHNoSW1Sd0E1dVdWTnpnMlE3a1dYUk5Ha3Z2?=
 =?utf-8?B?ZTNVSzJsU1RRQTFNZ1g0VVhKdldpNFdsTU5YSTEwZ0cwUUY2WHZUOThEZy81?=
 =?utf-8?B?WXdUQWlOTVBML0FZSVJWdkZpWFQ1WnlnbkNWK3c1NTNxcC9Nam1YT0VzUGUw?=
 =?utf-8?B?M3JselppRGUzTFJtenVVTFV1MWw2cUZtazNuM0M2LzhwTjJ1Y2JKeklrcmY5?=
 =?utf-8?B?bTN4SEhaUDlKazZkK3lpcml2NlFRUWFpY2t2ZldmVWRBNkF3Z3dudmhLUGtV?=
 =?utf-8?B?dHBHYTR0ZXlVQmoraGdHaUcxMC9DcHZYZlYzMHJaMVRxaWtUYnh2eUNSWW1y?=
 =?utf-8?B?SFdrbVFIRWFScEFwdHRSZGZ1QmRaSkpPRGJBZ1hWZUcrNVJDYjBLeFJvL0Y4?=
 =?utf-8?B?aEcrMkM4TmFTSlJKT1ZMZkdBRXJrSmdGT2IxRFBHdlcwYnJjQ2dMU0NvK1VN?=
 =?utf-8?Q?JtE/Z+VBW/fAJFUaNh46MYA5F6cZFyXeZ19Eq6Y?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB6101.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230035)(376009)(1800799019)(366011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?dGdWZ2IxK3hrZVhJNXVXNzVRWmNRMW11d014S1RiVWRLZmVndVVnL09NODh6?=
 =?utf-8?B?Yld4MWV4aEdoR3Z4TUllcEhZWTdtL09wOEF4KzZZdTB2UTNvTUR3MDRsM2NQ?=
 =?utf-8?B?cVRsOXhPRWphdHRIWWIydnVPcVlDcDgvYldtQXJsaWZMTDNWNlUyOHdBRlg5?=
 =?utf-8?B?Z2JoRHhFeDRiOWYwWDB1cU1tNUFuNk83ZGxmZmNJaXkvQWRxMk9KTHp1T1dy?=
 =?utf-8?B?b3loZzlnUU95U0w1VFVmd1hBVmJXMWNQQ21DVDkxSGM4RXUxa211MzBiaU1C?=
 =?utf-8?B?ZzNJLzloN0YxRVFrZ0ZWUzdFNy9FLzNTT2FWNWtBcmw5WnNsc1JKaTEwR0tm?=
 =?utf-8?B?VFQ3a2pzMDdTcDJJVDdRbzJ2dFVTMjYxQ2hyUHRnbkExaWozcmlOVzJVM2ZF?=
 =?utf-8?B?NHZ0RlVFdHIzeVl5ckpBQ1RFWVFmaDZySEw3aW4zam5oSzhMOWRGR2MxNFV0?=
 =?utf-8?B?YmVZSDNxaTMzaTE5VUh3SGRWRXZCYmp4QjdlZ1VoeTUwdTFJa2tZWXp5cHNW?=
 =?utf-8?B?ekkvaGtIYUdwbWFXN3hKbWorM05wUUlSdkwxM3Z5UUViYXVzYkp3UUdGU1VQ?=
 =?utf-8?B?dGdXamtxUG9pZENuSkVra3FPd3Q4cE5iMlF0Y2hpM3d5K3N2UHBCTmRiQUsv?=
 =?utf-8?B?TXMwdnNmdlpoQjBRb1YxWUR3OW1nTlRLeTJSdEdYbVJza09LWjdrM1BOQm9C?=
 =?utf-8?B?YXV4MzRQeGVJL3o0eFVPalA3TVVyQU8yd0pDYmQ3UU9iVVJTWXE1Y250NzZB?=
 =?utf-8?B?UUk0R1pma1pYUW9WR3VxOVJ6YVNDU0JrWlJJWXN0Mm9vTTJidk5FVFRVS1Ra?=
 =?utf-8?B?dCtpSnFlMGxtTnRBVW1CaHRMaG8vTkN5bDBxTnMwVnVkaURZeXdoMW4vUlJt?=
 =?utf-8?B?QjBuRW5nV1Z0QXc2UFBBSDZPU05jSXRLdFF2dEdJeXdsNDFNOUI1NnhoNFRw?=
 =?utf-8?B?RGcyMFJXRnBtRS9udnVWWEpXdDcxNlhNbFh5bVJjekM3MUZ4Sml1bjdXRHMx?=
 =?utf-8?B?dWVSUXpJSW5DYU1NaXM5ZWJqT3VGZHF0YVBzcmluQnlNc1E1eUFJaTBFUFBa?=
 =?utf-8?B?aHM5QVhWS2RJVnVmZjZ5QWplcVpUNDNXNnlnVzhTSjRrd3k1M3RwTis2b3Nz?=
 =?utf-8?B?V3Z5Tm5ZVnBwMWNzWUpIQS9QalpsWGs3aGx1bGhIMmZQVUR1alp2N1NTYzV0?=
 =?utf-8?B?R0RLeEF0eVBpckVXVmZucCtNY3dwS0hCZnRpYW5YVjZmQTBSWFFGMm11bUZ4?=
 =?utf-8?B?SzNyMFFFcnFQZGxBV3d1LzhqWk5Lam1kMmxoQkF2WW9WYmNLUHhmakM0alEz?=
 =?utf-8?B?UU9tYXh1ekhjbEt4REdITVMxa3dQR1BtUjVsSE9aSnZieHROZFhRUSsyNHhG?=
 =?utf-8?B?RjJmV2pZUFErMGxJemVaNW5UbVZVRSt4ejhuc01sZmV6Y0hNbXhLZktCVlpD?=
 =?utf-8?B?bU5uUkwrMTA3MnJSRURGbWNGY3cvMStBck9sSGcyUEFkbWNrOVcyRk5iTGli?=
 =?utf-8?B?NngzK2tKUi9kY2Y1QmRPRFdOTEJ3UnhxeW1lZFBpVkd5bmpoOW1iajg4b2Ur?=
 =?utf-8?B?REVqMkdQQkxhdHpWQjFNZ1oycTh1Z0YzODZWZFdhZlBuR2VKNUtEVm1DLzF0?=
 =?utf-8?B?dXhUSC9vc0czbGhaZm9vRW1LbDIwNFBJcmpwcS9KcXhtZzFWQUR2NSt0YUp3?=
 =?utf-8?B?QzhSeU1DL3QxR1IzKzdhSDQzd0MvSUFyNU8zbHg0U2g2eFNRUXp3V2ZhV0Fn?=
 =?utf-8?B?OXVwWmd3eDVPRGYraVBUYzdGNGNWdlZMamlwcStNUUtpb292YW5DRjE5dVZj?=
 =?utf-8?B?YnJmWmZnNzlMa1hwK3ZabXN3UFpMS0FlNHR2clozUnA3cS83a3dvWHd4QUZx?=
 =?utf-8?B?OStHZHdFS2hqcXAzb1d1WUkxRmlRTmcxZ1dsbENlV0RVeHp4UkNTbXBYSEYr?=
 =?utf-8?B?V1VDZ2czN0ozNGcxZkJITmdLS3FIbnZtekNPWTFDUEVLZ2U2eHhvQnRFOXVK?=
 =?utf-8?B?UkNGRWZoMWFmZkduVGx2VkZhdEdhU29HVEVLeXpSMGNUVUlpZ0J4NFpJN3Iv?=
 =?utf-8?B?aXVMK3R0L3B1ODhIdGNUckZzZmdjWnVxcUpPMnZIWnZyU1lBdldwY09WMEdv?=
 =?utf-8?Q?zfMzgJrSPXo8FEsG/EB4/Sq4o?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3bb0ed91-dae3-4c7a-4cf5-08dc8bcf4825
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB6101.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 17:35:56.6077
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAEL/ujgxQ8z7Btm4JevS9Q3n5eH5vd9jJDJzJqrH/b3iVafOsSXe9vYsGIdbCIvpPjPL7PhDT+y+TjiYGyr5Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7593

On 6/13/2024 12:33, Niklas Cassel wrote:
> From: Damien Le Moal <dlemoal@kernel.org>
> 
> The SCSI Removable Media Bit (RMB) should only be set for removable media,
> where the device stays and the media changes, e.g. CD-ROM or floppy.
> 
> The ATA removable media device bit is currently only defined in the CFA
> (CFast) specification, to indicate that the device can have its media
> removed (while the device stays).
> 
> Commit 8a3e33cf92c7 ("ata: ahci: find eSATA ports and flag them as
> removable") introduced a change to set the RMB bit if the port has either
> the eSATA bit or the hot-plug capable bit set. The reasoning was that the
> author wanted his eSATA ports to get treated like a USB stick.
> 
> This is however wrong. See "20-082r23SPC-6: Removable Medium Bit
> Expectations" which has since been integrated to SPC, which states that:
> 
> """
> Reports have been received that some USB Memory Stick device servers set
> the removable medium (RMB) bit to one. The rub comes when the medium is
> actually removed, because... The device server is removed concurrently
> with the medium removal. If there is no device server, then there is no
> device server that is waiting to have removable medium inserted.
> 
> Sufficient numbers of SCSI analysts see such a device:
> - not as a device that supports removable medium;
> but
> - as a removable, hot pluggable device.
> """
> 
> The definition of the RMB bit in the SPC specification has since been
> clarified to match this.
> 
> Thus, a USB stick should not have the RMB bit set (and neither shall an
> eSATA nor a hot-plug capable port).
> 
> Commit dc8b4afc4a04 ("ata: ahci: don't mark HotPlugCapable Ports as
> external/removable") then changed so that the RMB bit is only set for the
> eSATA bit (and not for the hot-plug capable bit), because of a lot of bug
> reports of SATA devices were being automounted by udisks. However,
> treating eSATA and hot-plug capable ports differently is not correct.
> 
>  From the AHCI 1.3.1 spec:
> Hot Plug Capable Port (HPCP): When set to '1', indicates that this port's
> signal and power connectors are externally accessible via a joint signal
> and power connector for blindmate device hot plug.
> 
> So a hot-plug capable port is an external port, just like commit
> 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> claims.
> 
> In order to not violate the SPC specification, modify the SCSI INQUIRY
> data to only set the RMB bit if the ATA device can have its media removed.
> 
> This fixes a reported problem where GNOME/udisks was automounting devices
> connected to hot-plug capable ports.
> 
> Fixes: 45b96d65ec68 ("ata: ahci: a hotplug capable port is an external port")
> Tested-by: Thomas Weißschuh <linux@weissschuh.net>
> Reported-by: Thomas Weißschuh <linux@weissschuh.net>
> Closes: https://lore.kernel.org/linux-ide/c0de8262-dc4b-4c22-9fac-33432e5bddd3@t-8ch.de/
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> [cassel: wrote commit message]
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Mario Limonciello <mario.limonciello@amd.com>

> ---
>   drivers/ata/libata-scsi.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index cdf29b178ddc..e231ad22f88a 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1831,11 +1831,11 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
>   		2
>   	};
>   
> -	/* set scsi removable (RMB) bit per ata bit, or if the
> -	 * AHCI port says it's external (Hotplug-capable, eSATA).
> +	/*
> +	 * Set the SCSI Removable Media Bit (RMB) if the ATA removable media
> +	 * device bit (which is only defined in the CFA specification) is set.
>   	 */
> -	if (ata_id_removable(args->id) ||
> -	    (args->dev->link->ap->pflags & ATA_PFLAG_EXTERNAL))
> +	if (ata_id_removable(args->id))
>   		hdr[1] |= (1 << 7);
>   
>   	if (args->dev->class == ATA_DEV_ZAC) {

