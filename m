Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD99C3B38B2;
	Wed, 25 Mar 2026 10:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433855; cv=fail; b=XwhtZPFBegkWr5bascihWu1WfkY5RYamBMsqikVX+L4NiasovoueockOhH5yH6CSJQrTPzO/ZFnxQj9jWJ4jfZHmmF632mi68/OSarTMX0XZUyTf0TmqZStzxFOL5/2QsMOTG4oaqRGwNBtxfT0bhtoJ5fVtFQkMSuFdFBVSvQI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433855; c=relaxed/simple;
	bh=IbbaP7l4xdnMnlmPocIDYKv90S9eBdjokkLQ7kgefr0=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=HQhmVbEV5054wTn1n1Hwr23dFsdTbp7pwUdJ/wzxSk08onzEqoWOP/iUCsJGjQHmMVU6CMvtoCR7DhYegedWDkuW1KyWBfvM3spdus+9bHVKxTRCcBrawYSQNZY8qiYTCm0VDrzjJ/Vi8UbeFtqB7wA1z7FxE4BdE7b0QR0WbN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l6hz2mOA; arc=fail smtp.client-ip=52.101.61.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l6hz2mOA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLVzmX0p7QdLa8PWgpvm6Uf+Za77Wy5GNFg+FLa0/BzWZdC5Y7zPginL3i3rGMXC9eMVVdFMf2r5A9xeXuCPv2XEdg5GPeY0a8N2ioy4XTPugrZvjTtZ4Mv1rNb7tLaiY0iwAe12OhG5apwCkqB4r/bQymTnVUEk1CK0IcDOXV0ulJAGr/PGMIno60GOSv1jGiRZn/kOVrUJ5Y9j2Yc+pBveF+gcp6CxzqL/V0VclsLFcG6G7xtflP0daOqqeG07i7rs6wJ0FJrEAUDWyh2t6rZPHWSnUK7mFDw9dUnmowVkbK7jmQVVIz16wOv/2StgbaIdODqDPUuCNJE7cB7NTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+iknQAC1cW3rclfCh+9O/9zL9JQt+1JHvsmRULzOKMo=;
 b=JVCZRyt5fLrA3ADbdL7tVMSkU2j0Edpri2Ks11O+Osst8fmB4JOJtxqlnuUybuldZ45axDllCmEvuoxC8ZetkWSnIMPwWH6zM5Rv9Q7YPIMny0YkclCmgN83SI4VALmuLXOaKrQJh6C98otPOtdAQJfDcZUvY8GHbrgspNXtnA3yUdz3HaPNirnTov2+W59Le46WTfZNIj5V3nGW1VhJibmwoDaBbW7AAwVpVM+nEmqznRUwa38yKxP4aRD01qjYqGa3jMP7zi4zlb1BPTF503w0j6IC4wux0wPtamf9wRIwq3VaRR189QmgC9Ry9n/kDiwZjJyEP2unoyc5VgLFKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iknQAC1cW3rclfCh+9O/9zL9JQt+1JHvsmRULzOKMo=;
 b=l6hz2mOA06DqpUpzEygkwdo3SV1q8DGOnoiYA0t15DInMgq7wDq/woBOrLTbA6lM7lZwmSPVoeeJNLNCFXqPhRgEX1kEzTKzgYZ33OtBGEMEuvqnRZpGGBmZiUxqM+rvV3ue/FKIJ16hfDyvNo/QI5Z6NO2UCyOewPcF8TDGTf9PwDXZhF8k0ypbKvxDsB/HCjLU0tjxijQ/E5NP0x9a2nLjnwrA9Cgd5x3I2uLZW1t6vKJEnfyUzqIngsSrsrThDWgiRpm2Uny2Ha4mR84A42Sgy/5/n+dJuZ24gzXlU1ycu7NhAO1LGaSnWr85QXqxHbFtZ65c1TDEITBi2vd/uA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS2PR12MB9750.namprd12.prod.outlook.com (2603:10b6:8:2b0::12)
 by CY5PR12MB6573.namprd12.prod.outlook.com (2603:10b6:930:43::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 10:17:30 +0000
Received: from DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391]) by DS2PR12MB9750.namprd12.prod.outlook.com
 ([fe80::56a8:d6bf:e24c:b391%6]) with mapi id 15.20.9769.004; Wed, 25 Mar 2026
 10:17:30 +0000
Message-ID: <63d71f4c-97c0-4c2f-ac92-0a643fcdf75f@nvidia.com>
Date: Wed, 25 Mar 2026 10:17:27 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_tegra: remove kcalloc
To: Niklas Cassel <cassel@kernel.org>, Rosen Penev <rosenp@gmail.com>
Cc: linux-ide@vger.kernel.org, Damien Le Moal <dlemoal@kernel.org>,
 Thierry Reding <thierry.reding@gmail.com>,
 "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>
References: <20260324211629.26924-1-rosenp@gmail.com> <acOPMJVsxpBltqGX@ryzen>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <acOPMJVsxpBltqGX@ryzen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P302CA0001.GBRP302.PROD.OUTLOOK.COM
 (2603:10a6:600:2c2::6) To DS2PR12MB9750.namprd12.prod.outlook.com
 (2603:10b6:8:2b0::12)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PR12MB9750:EE_|CY5PR12MB6573:EE_
X-MS-Office365-Filtering-Correlation-Id: 83e0e1bf-10ae-4a37-838b-08de8a57b929
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|10070799003|366016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	jy7T9GUTiGKi7HHLYeE11iPAd0CYLLD5fu4ziG1pF8NO2q8KrB9JYGt9oXcup9H1991e8tCkEU+Qf7beMJ02O8pwgcVvncWXksmw2p4yhBxJBNddF5C1iCfOiIbMCo1PvfDtxMePRjYSo1kNHJPvUE2FOJbWquvGb49kiIZe32ftZu+fEAEYUtH+19XbZMeGXR+Okcn8DDk7FjsMYP0Xjv9FtH1Yz5QhKrfEzd6EDQoxpfyNNoHiv1CsK5iP/ggtCB4ePtXXf1E5gVfbGWRyyICAOC4wk6kdPbGIlEAgFhSU2Nkarid+x01LwVR4ff2m4SiPjl+/K2BdoLCEVtMbkj0naJPxIdJsOcKv6MkPvUiFELNuQwjPEP3amh+I4SVrUwkRG5BqEyNjOEfUv3VZB0SqVDbVdVLCziWUgMB+tWQX8ArOEGpXzvSke4oTUQNNRea18FoWkJz0CZE1a4mTPfelc3xjoCHzQn6AaReBoPPNyoC0xD2qa0Wb/UsgMDxDWKLAIRtDvFJeoReo0MefgDiCUcQJKG/yo1XFdszAYtSWSewVyYoHlXcMUPjgE106i/2BcR8bxdIiOsgPscNGdrSjDAzpkJFpHo+1x8JxfpQhD95BDHXAjuaVSsX42UQX1PEFqK6gebAvhIOxCHZz7X0hvyPbrBXLxbykLzRKSv1D6lQnVBPvM6D82vGa3yaIjd7d2Q0fG6o0SuSp5rbTwHg49K/sY2OnnnkKMaJ05U8=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS2PR12MB9750.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(10070799003)(366016)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 2
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?aWo0T1l4dEVmWjFPa1p3TnVmVVFrZjJiYXZZTng0cmxkaDAyNzNIdGxRaGU5?=
 =?utf-8?B?elliclFEY2s3YXEwZk1xU2VTclNVUkpmV0pWTGdJMnhQVVZ4cTZBVnpyR0hK?=
 =?utf-8?B?Z1dieS9Ja2U4T1hXYlpnaElaaWNhNnBadHg1OHA2SHB0dXdISFM3ZWlkby9r?=
 =?utf-8?B?ckNwbVlTSno2VHIvQ2dpNW0zNGdwUWtGMlVKVTdUK29ZR1QzQncyYndEZnNF?=
 =?utf-8?B?elpmYVl2eE1aemtSL2ttK1c0WC9jY1hxaUJVTUJ0VzRReWxtanhQeklEbkw1?=
 =?utf-8?B?MTc2T0VkZlRWOUFyaFdxVXVRQWt0Z2VxRDU3NWkyYnFYUnk3NFVPUmJrb2t5?=
 =?utf-8?B?VlZxamdpYnphSC81VDNWZ05ydXZ4bjZlbTVxbFlPOUFBYUd6L3lKZnEzOVE2?=
 =?utf-8?B?WUFhQzlXbm9vdVFKdVRtTVJlMURZUGtCRUZlZmY5b0lCWUpDWEtqUnVsSmxq?=
 =?utf-8?B?ZU4vbWt3d2t1R1JIS042YkN4cDBxWEN6QzhSZkNSaUFWZTNoMEk2UUVLQTk4?=
 =?utf-8?B?YzZPdmRudm16VjRiSElMT3VZUVpWYWN4T29BQ0pyRlhSWTNkYVBad2VOVHcy?=
 =?utf-8?B?NXVpYVdJbm1NNHluakVLMXgrVlpNYzJ3RHBtRTVXMitFdzdTZVVmbFVXNlFa?=
 =?utf-8?B?cksrakZocnBvS3BRbDFndGpSK01PVzU4MHI4WkFPVE56a1JGV2JtLzlLaWI4?=
 =?utf-8?B?R1pDbVRhMk0vQlN5OVh6bWFQMDgyTFV0VW5EVGpXOTd4V0ZLRTh2RVpJRWNt?=
 =?utf-8?B?NjBZWHhKSnN5K2dGckhmQUVBUm9hTFZCaCt6alFweGM1WG1YOU5yVEJMSzds?=
 =?utf-8?B?azU5UDVIUlZMLzVxN0V2bU1BMmNwa3JkRGVlb3BSOW1LMU5TaUN0QjEyUmc0?=
 =?utf-8?B?QUhXR2E2STVBZmk1MFJVcVUxKzY3Q202MXNUWDlVR2o5aFJxRlhQUnlVTmxy?=
 =?utf-8?B?ZXhML3lpak1tWjltM1FvSjZ2YnFmb3NVZ0lJS3E0dm55dHJwb3RaZU9xV1ZB?=
 =?utf-8?B?czFXS2pwWFRsODc1VGVIMnd4UERVbHN5TmVVai9GL0dENS82RmRnRzZpdkxM?=
 =?utf-8?B?U0JsM1VMaEhyTGxUcUNuNHVLVjMwTU5qSWNZYm5vRHdHUjV2aW9kMjBPS0NS?=
 =?utf-8?B?TWlFYWlBOU9DSjRsNnB1SklrZU5DTXhWOHVTSTVHOVh1czdTd2htRVcySnBm?=
 =?utf-8?B?RzRVUzU4RktWdEFCaGpnYzgwNzVSTm5mT3l5a01HdTlOa2ZjQ1pzRHJOcVJi?=
 =?utf-8?B?OFJvem82VUlwK3J2UXFMRGZvMHgzMlcyRUE3VWNJdFV2czhoVWZqdi9qWmxP?=
 =?utf-8?B?WUg2cStlTURaWFpOam16ZTV3bmlhWG9yV1I2cTJ5WG9DNXNwQzh0Z3NMekc2?=
 =?utf-8?B?QVkyY1piZDJ6dUtUVURzaEZzY0h3akNVTnVzN2IrbXBrKzhvdG1OOUFiQ0Yz?=
 =?utf-8?B?dkJpRDVsalRDTlJheFlKQW1GbmRNaWN4TExrM2lxV1lpbkpYTFl5WUIwcDhI?=
 =?utf-8?B?eENVazFPWmZCTXFoemFQL3dwNXNmZHJWNnZ0M0VSN2NZUmhLOEhISFBvTzBn?=
 =?utf-8?B?b29aaVlsU3A5SUxUc0lYOGlWeHd0K25sNmdzSGplQ3lFMXM3YjFIOWROdTZM?=
 =?utf-8?B?Y1FkeG9MR1BZYU1TczFHMGZXT0wwUEw2YzJJUlczVkJPQ3hwVjhjY0Y0U2FW?=
 =?utf-8?B?bWdpdFVMZTEyd1hEVkJ4cWxPRjk5eWtFU0V3V0VnRU41K1JXS0NOcHJSMWMz?=
 =?utf-8?B?MENIWGxrcHpQcG9WY05scGlTRnNVOUVoYmVNdnBGQTJkVDhiSVkxMm1DbGFm?=
 =?utf-8?B?bi8yQitGUldUUjN3clV4RlZOaE5oeFhHRHhEakx5RkpYQWVUVUJVWU1SWlBM?=
 =?utf-8?B?RHh1Z1ZLajRqcis3dHpBdDdlTS9JZTFTY3J4ZVF6dHBBZmJuKzhnSGw3UU9v?=
 =?utf-8?B?ZTNZNnUvYXBBZ2l3Y0pHT3YzTmZtc3ZPeDRLUDZDcEZUU3dvNFF4NEsrejBZ?=
 =?utf-8?B?eTNqd2xuRUJkQmYyWmNSTXEvRXRqODZCQ1Jqck5uM0gvQ0JsTGdmYy8yMTU4?=
 =?utf-8?B?dzhwRHVYYUhHYzFJaEtVS0sxM3BraTY0K1c3Y2pCZXhJMFMyRFhBSjF1cmNQ?=
 =?utf-8?B?Y3kvSEdaSTU0SitqNXlCQ295WXdqRWVQdWdMdVcvUkRMMUpPZEJSVkZQTm9r?=
 =?utf-8?B?eWxWVmdBcHplS3g1aThoSDhDUkh6OWZtSXFGYTFZQ0xvNVdTbWQ4Q2ZYbjFj?=
 =?utf-8?B?Unl4cWlrUkpNUWNWK2JwV3JXRzM5MzR1UDdaWjZTSnNncWFvZ3ZzcTdPV2Ux?=
 =?utf-8?B?OFJ0TUFjVFZzaXQrTHl1WU4raVNyQ29jU3NyNzVROHRlSFhrSHlxUE0wcG9i?=
 =?utf-8?Q?jbMuSdywdnYX/xAnER85guwHpEQF4miaOOAVXQK1hI2eK?=
X-MS-Exchange-AntiSpam-MessageData-1: dwm2dIs+ZFFnIQ==
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83e0e1bf-10ae-4a37-838b-08de8a57b929
X-MS-Exchange-CrossTenant-AuthSource: DS2PR12MB9750.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 10:17:30.7374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uw6UqPJxoIBnxFLzZ4O2sfe7qnwlUR1vn19nCQehN/tN7MjkTtRC1Ml5JmLpL1jo9KBAMew92yGVr9wyFm3hdQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6573


On 25/03/2026 07:30, Niklas Cassel wrote:
> Hello Rosen,
> 
> subject is a bit misleading:
> "remove kcalloc"
> you are removing devm_kcalloc(), so device managed.
> 
> 
> On Tue, Mar 24, 2026 at 02:16:29PM -0700, Rosen Penev wrote:
>> Combine allocations into one by using a flexible array member.
>>
>> Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> ---
>>   drivers/ata/ahci_tegra.c | 15 ++++++---------
>>   1 file changed, 6 insertions(+), 9 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_tegra.c b/drivers/ata/ahci_tegra.c
>> index 44584eed6374..5972fe04ff3f 100644
>> --- a/drivers/ata/ahci_tegra.c
>> +++ b/drivers/ata/ahci_tegra.c
>> @@ -175,8 +175,9 @@ struct tegra_ahci_priv {
>>   	struct reset_control	   *sata_cold_rst;
>>   	/* Needs special handling, cannot use ahci_platform */
>>   	struct clk		   *sata_clk;
>> -	struct regulator_bulk_data *supplies;
>>   	const struct tegra_ahci_soc *soc;
>> +
>> +	struct regulator_bulk_data supplies[];
> 
> Personally I'm not a big fan of flexible array members, as there can be
> only one. And if you use it you want to use counted_by().
> 
> Yes, there are two device managed allocations. But is that so bad?
> 
> Since it is device managed, it will get freed on device removal anyway.

FWIW I am not a big fan of this either. It is not an obvious bang for 
the buck for me. The one downside I see is that it does leave the door 
open for someone accidentally putting another variable after the 
flexible array member. Yes we should catch this in review, but there 
really should be at least a comment saying this must be the final member 
of the struct.

Jon

-- 
nvpublic

