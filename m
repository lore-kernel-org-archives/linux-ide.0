Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11012025.outbound.protection.outlook.com [40.107.75.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEDEE199FAB;
	Tue, 26 Aug 2025 06:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756191510; cv=fail; b=AiMErdSkektq1flxOFhAwC3UCd6GE6DIzXXMsdfUq9MuljWj7NX3Ksm1YYltmJMcyJG3gmq+pnNpiL3Q6sY+8Il6n27R2VQ5O58aCiOfM//slKdDofdtGokYUxwwu11D/9cWzf0mmmYbbWTkE7h5Uv9uYyr9pYVb1kZk9IoLe4E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756191510; c=relaxed/simple;
	bh=pbVUAvVLGjirMPSnYoxBY1NsYb2tGTZ7hwGvNrgrVzA=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K2Dq3IlJaZSA3NqwARD9E28cKA+9EK0rEQflwLXb4GONgZ3NHG40xVl7PXETHXeMTBGFAtp0czC/WTh6Bk7ZOg7LWmmChU5u9P7ZMGO3qkVYGIzax+ORbRRNWMDC6U+E70hXgrMBRtzS3d7Gok/jbQjJx44EOivhonNKeWNQ4Lg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com; spf=pass smtp.mailfrom=vivo.com; dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b=TYg4CGPD; arc=fail smtp.client-ip=40.107.75.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=vivo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=vivo.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=vivo.com header.i=@vivo.com header.b="TYg4CGPD"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KZJABzd6gKgOrtvUOr1HqAc7HgQYAWtyEzYJ86IYKghjQ+884rpm9HyWLYE7XzHbA1/7FrXQ7lYBOwRu1C90oV1pRqPnEG4jv/zdFnYuOQS+s31nMeYBw2dvCv9zaC1S6ZR4x7qewrwtB24HA8WMz/bxfKuTKB3ejAlZkR+khgsSqQtt2cdsU3+WsMK8UNXf/sIUkBgMNThZGxjjIx5OKS7uyc13YE7aZpKEutZuRC60oZeSWmdKsTr/ktuz+BZjgTNasRvdVgrMQh4tRjDv7xJCW7MZDzlED8vGD3ZJXiU04uhHu5EGIlT6Fy3eUgcKWoK7kObLA+7hScWbGsQG8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BfWLBeoqiS5ZVvMaPGMLphuaSEtdztzqMpZNbcGZbno=;
 b=mUFQjV7p0og4m0yCkxELUR/iGWZSkNdGOZHnuXA/7kLMx4JyKv1hTO47FytGuyCrFGCh+eIBNQO3NURAG0LnRm/FbkCHLMyUJEstczq4CGuEnsadBHXGVcOoy2uayhxqCPSn8mFL2b2K8aBS8NlZNNfsjIRPWxn5E4GnpvlIBZBhiekz/ovZbtZjxFas+ELKqn6d7B4r/pzeXHaFYaVZu1He1LUAHMznJEx73c3xLNOHACULidZunqC4nGwZ3M7Lph4B3CTGOrz/w2yS0YHQCZMzFEwNK6yB1G72u48c8O9ZIwXuSvd6wtnWcRCzhYHXMJ+RTDTEmllccpInTKjoQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=vivo.com; dmarc=pass action=none header.from=vivo.com;
 dkim=pass header.d=vivo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivo.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BfWLBeoqiS5ZVvMaPGMLphuaSEtdztzqMpZNbcGZbno=;
 b=TYg4CGPDxTwz0rBejdUYbuy/2dvBcoFTq4bWqlAqDwBau+FFWysFLNsufQiiMchizZYO4p8e3fsunL2R6Vj0xK1+tTA797EJPN0rK7pzVe62ZaWgrMkBGQFA0RRrmeqQgty6k2AlrSid18REZ6K8zeZt40ICft5Jjuf1fb9sCWoDWNEf9UxzXf4T8yR8B/4vpu8QsklSmR/Cx3rZGIs1L2HM+k3nViNWwBo3chmbNDOdET/+csk/k8R1Ihe+EkBbAKqlrc/KIj4BLom0E50IVPSxdmr86HDp+ksq5iRzI1zQojcIElWs5Pkft7JHlVcdn+QgVKODVakfy5v72hd15A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=vivo.com;
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com (2603:1096:4:1af::9) by
 SG2PR06MB5264.apcprd06.prod.outlook.com (2603:1096:4:1dc::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9052.20; Tue, 26 Aug 2025 06:58:24 +0000
Received: from SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666]) by SI2PR06MB5140.apcprd06.prod.outlook.com
 ([fe80::468a:88be:bec:666%5]) with mapi id 15.20.9052.019; Tue, 26 Aug 2025
 06:58:23 +0000
Message-ID: <4779c117-c5b5-4344-848b-3e9d35028b67@vivo.com>
Date: Tue, 26 Aug 2025 14:58:20 +0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: ahci_xgene: Use int type for 'rc' to store error
 codes
Content-Language: en-US
To: Damien Le Moal <dlemoal@kernel.org>, Niklas Cassel <cassel@kernel.org>,
 linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250826040219.133959-1-rongqianfeng@vivo.com>
 <138dde32-e528-4731-b766-4f26dd9366d1@kernel.org>
From: Qianfeng Rong <rongqianfeng@vivo.com>
In-Reply-To: <138dde32-e528-4731-b766-4f26dd9366d1@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TYCP286CA0040.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:400:29d::15) To SI2PR06MB5140.apcprd06.prod.outlook.com
 (2603:1096:4:1af::9)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB5140:EE_|SG2PR06MB5264:EE_
X-MS-Office365-Filtering-Correlation-Id: ba1528a1-d5bf-4332-95d3-08dde46df2cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?anZEbmVWQXVQdXZqcHdick9PQUVlZVVKRDJ0Zi9qZVdkZDVtS1NoREVxdWpu?=
 =?utf-8?B?RmtFTFovZ0d1RktNR0wzK3Voa0trczA1aEs0aW1NTUthSE03K1JuVGR0S3F0?=
 =?utf-8?B?WlNLaGxlMlRVUW9LYzVMN1BpNXBHZEU5K1pDNTlPTU5NeHA4YldZbmVCVC9R?=
 =?utf-8?B?R3BzWXU5SzA5OXo0REdmQUZNYWpsZTNJMmFtanBvT2ZiaDR5UVRUMW42bE0y?=
 =?utf-8?B?NHVDNFYydXF1WG5hZzBFNnJRdEV6TUZGYjV3cEtQWWFyT0ZtYXlMVmN1MGUr?=
 =?utf-8?B?ZnpwOU9zYmtpdGlBZ3BLRHo0K0ZJUHlTTk9VNEVhNmdDT2NlM1B1S3JzYWRI?=
 =?utf-8?B?WDZ6YTlBcDNQOEtxRzhBVlExUVoyL0llVytrcHVZNExwMkd3S1Q0RFFxU2hE?=
 =?utf-8?B?NGtUMVVmRXFWT2h4eWkyUGhJMmltOGZRa3NiU2cvdExJZjBmS2lqMGxGR0pr?=
 =?utf-8?B?Sjdkc20zWVFYSWh4dVlFczkzYU5aQ05YYU0xTVh5NklEaVAyZ2FTeGorN2xz?=
 =?utf-8?B?K0tycnBVWWZ1UzM2aTBYcnNMODNsdnpJTWtocjFIUG1WRnN4cUtFRlUyV25W?=
 =?utf-8?B?ZEtsSjVWWW8reEhkOWZtZGpZQS9PSlpsbWc1NGU3RVNBTnJkYnhweEVYNjJQ?=
 =?utf-8?B?dXVuNzIrN3NONGUvZ1gzcllSRUd3VURpSi9OdThQeXVQNUhUdXlyOXY3VERL?=
 =?utf-8?B?dndVaFN3ODRkS2VPL01XcGpPcS9EUlJpUnVUUDlXamNQa2JVZGxoNTVIczVT?=
 =?utf-8?B?ZGlOcDBJM1huV204dHVyK1RvWG5FTzhBbDZmMHdSU2hmM1pwMUl6VDZ1NTA0?=
 =?utf-8?B?Z1JIbmcrcFRCMFBhS2VOdUt6SCtLVGlXeHQzL1o3UXdRVGRHOFptYlJUNHdJ?=
 =?utf-8?B?eklvWGprRmpVUGl5d08vb3J4eHVFeENkMllEZ1FCSjFIVmt3QXJNYW1tYnhn?=
 =?utf-8?B?ZDFzYzY3ZVZBWDJtdE9MTzZLckRLOFBKWklzRHB4Zzd0NStnKzQ2YWc0YXVC?=
 =?utf-8?B?ZDNJKzZmZFh0elFQRDJTU1hScGFCZUd0YUJweGIrL2tjVkRuWkxYenIzQktn?=
 =?utf-8?B?cWpxTWhZRXo0d0lBQTNScGRYWlFxWG9aMFFKMFpwY1loOWlMdEdodUxIdC91?=
 =?utf-8?B?bklwRGV6QlQ4QzFKeFE4SjRiQjF6eDNVN2dVZmRLdEhVbE1jSkFTNXZhNEp2?=
 =?utf-8?B?VXMyckliV1FBN1kzRDVFT1l4eWhJNkJDOE5FYW96R0lydEVYOXNLYWlKazM1?=
 =?utf-8?B?QXdreEJ1Mnh6dWdDdVM1L0tiQ2pLRHJLWW9JcDFaWnk1b2JTT0xQcTU0eHRP?=
 =?utf-8?B?aDljcGZUUnU2ZEk3Z212bDE0MUllQmxwRjVhSnhib1I1ZHFmeTlEN2E3RWNN?=
 =?utf-8?B?KzZRZmZEckxoUktlMktKTWtvZnYvZmZDYituWDFONzFVaWlTa2puV2xtTURH?=
 =?utf-8?B?Q2ZUV01wZldCejNGdUt5aVJnd2ZLYm12eW1NRVR1cVk1SUFTSFkzOHY4bkYw?=
 =?utf-8?B?WE9tR2IwUEY5MUFuREx5eTh4YzZQZDd3V1dKdTlGcVgwZTEzcUpSbmNtNnpo?=
 =?utf-8?B?ZktjclNTYzFhSUJVb3E5emc4K3VmMzdtamdZZ2NCZGpLOUZ4S3RBUkxQUEVV?=
 =?utf-8?B?MXBUUTlaTVBUZy9IajJyZVNBVThzbnhLTUNYOFljZXM3VGlQQzNaUHhBbFBC?=
 =?utf-8?B?dnlRMmFXM2JWM1lwaWNlcWg2UTZlTEZwNDQ3cGpXTEU0SjFlSXVOR2QyQWtu?=
 =?utf-8?B?cUt1QWkyYnNNcVF4blRvL3d0c1I2S2FjKzNGSEJpa1E0ZGV2Q09rc3NlQUVV?=
 =?utf-8?B?aFc5OEpWWmZRVVNhQ0thc1FxV0NKdWI3WUVPUFBuZDZQZHdOaG5LY001dS9Z?=
 =?utf-8?B?L0ZOMWp2WFdjVndQREZRaHhPWXNiUGprejAzSkcrZG5WcHc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SI2PR06MB5140.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cWQ1THlFUFhNWmIwYTlURkJjRlRYMUJVa0FxaC9IOVA1REZjazQwRTg3MFNn?=
 =?utf-8?B?NUgwaEtsTnQ5R1B6MGJUa201ZVFCL1BBbWFxSWdPU0hlY2FLREtJa1g4RCtN?=
 =?utf-8?B?cjJIQ050VWh1NnhndWUyNlRXUkthMzBSdFJ1RVlwM2V2aTBCU2hwTnMyUjV1?=
 =?utf-8?B?RUQ4UnUyazFTNlg3bmVIc0h1eDkvOEdOOGcwWStWVGRmQmRka21kT1FwVWZ3?=
 =?utf-8?B?aVQ4Y2x5enhaL2pjSGZ1Z3grNm5pZ0R0RnNLUUJrUmVQMXlBY1JHcy9LVkta?=
 =?utf-8?B?U1VTRnNVdUFLbDFCMjE2enduQVpKN2w3WjlCWDBWRkJMKzFlcys2K1VjaW9u?=
 =?utf-8?B?K21Rd1lmcWlSL0RvKzNYTlJyTEp5MUxmcjJxSU9WdEhadllSdVlMaW11Njho?=
 =?utf-8?B?d2MzR1FBbCtYRDQvUUZCenNwSUlabVBuaWpRSm93OUtmdXFNY1VoR2wwVEVn?=
 =?utf-8?B?TnpRd3NEUTE1MmtBNU5QZlB1cFByK2Y2VWdBNUVHc296VENuNHpCRzYvblFr?=
 =?utf-8?B?WVY3OHZLOEl0alZwZ25uS3dtcXkzcXBwTDMwMDBQQ1lDaldwV3Q3bHpsYm9K?=
 =?utf-8?B?OXBYWU52Wk1VK3VtMDFCdjQ0eVhqaWJOUUFpalk2WVJ2YXEzT2RvZ3VFOWVL?=
 =?utf-8?B?NWgyOWRUTEVPMWhodVpkZUpvTzZ5eTVRYlJXeUc0YVVCV1NlZ0dCUHQ5Q3VT?=
 =?utf-8?B?Z1FldmVFYllleUhudUlIMitiNEFpaHNyM0hiUWtkdlFobnFxbkFZZDVGd0hJ?=
 =?utf-8?B?eGl2aUk4T09qNlhQb3IvNU5pMFFhTXBobS9tNkgrWU85S3doa3hYTHVXMUZ2?=
 =?utf-8?B?WnMxVS9RZWk5MVAwRlJVaHd1aG5NMWZaN1RlamZwNFRiRTJ5cW42Nk9hVlZI?=
 =?utf-8?B?ek9yUWFkTUl2bXZFd1R1RjIwWjRudHQySDJyR3dKQ0VOYWFBaWJKZGFQY2NP?=
 =?utf-8?B?bWdSeXVUY0tveSs5clpoUjFGZWZCaHNSU3hxZnlwY3lXZ0s5WHZkSDVwWWRx?=
 =?utf-8?B?STYwM0V0V2h1VXRUYlAydGdLVXhmZTJwYkJsQzgyNitRbmptRXNKZW5GS096?=
 =?utf-8?B?R1hia3lRT29RZVhNdVdHdWFOSkVaNHh6RXVOUnlQV1BzNE0xdEo4OXhDeHk1?=
 =?utf-8?B?NmYvVnVMeW55ZFN0d2VDTThsQkIzdTlUZERMN0NNTzlWbmpOYmJwZ3d6ZzAx?=
 =?utf-8?B?Vlp3bUF0b25RUGdmMjlab2NKOC9Sa2YzVENpWUdmRDlJNFZlQU8xWUg0SEVl?=
 =?utf-8?B?aENvRnZBOE9RVzB2a0MySXB1bXRGdVdRK3p4V0EwelZhTDc3cWZ5V2pybG9Q?=
 =?utf-8?B?TE1zUjZXUG5uajVWZFpqR1p0eWt0aUVDVDBBcHltWmdHcWVKbEttbFd5Wlk5?=
 =?utf-8?B?ejFyTXVocHZjZlBMNmtiRkdmVGo1eHpIcEcxVkpZdUlWYUt1Y0F6bmlQd2w3?=
 =?utf-8?B?UEYrQll0QlFrQ0gvYlRZMGpwTFArSWxvY3VJV1RiYVlPY29jOGtSRDlZVXY1?=
 =?utf-8?B?Y3BEYmhSTGZ0N2JZNWcrM1lXQ3BpTVFMb3B3aFlGZW1GUWZLZG84WnBzRTdy?=
 =?utf-8?B?clZtaEJZSXVZR1ljdEkrM1hxcXZRZmJZdjJxMHdOajNKeXRPUENrMTJZdWFn?=
 =?utf-8?B?TS9wM0grdnFZSklFekFtTlB3VkhSUzlrMDJLR0xxNm5CTHl4SGhBb2VaSEg4?=
 =?utf-8?B?VFR0S0JrL0tDQm44T1pnRS9YbjE2SmtVeXovR0YrRmpyZDI1Q2NHWTdoOHhI?=
 =?utf-8?B?cmFrL3dHNTlKSG9PVGgxNmdYQTlqdzRIWUtrRUVrdkM5MjQ0dFloN1dqeFZi?=
 =?utf-8?B?azlrcFJyRjIzVzFqMWZFZlN4MkIza0poakJqQ1JVZ0lpTGY3TGRUMm5wNmxE?=
 =?utf-8?B?MnNOMTZFV3dIMEtYZHlIcG1pVExtL3dnZHRTUDJWVGt1ZEM3ZUdtcHVyZFNu?=
 =?utf-8?B?TG9yUjhLYTU1QVZkR2NlMUVnMkFJaUFCVmVvNlA5YWxIck5vNm05QXV5bW9j?=
 =?utf-8?B?ZDFOMHR0WWRWVnpxWmZFUU9uSkFuZUt4Z3lTbGZkNGFMSDlnUnh3Mmp6b1Nw?=
 =?utf-8?B?anQyOEtSY0NDOUFQUTZhK2srQ0tYRURjVEFLWW5nR00rOExjK0ZXRTEyQlI0?=
 =?utf-8?Q?r1o+MYmu8Adshg25J59j0wsjY?=
X-OriginatorOrg: vivo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba1528a1-d5bf-4332-95d3-08dde46df2cf
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB5140.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 06:58:23.6747
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 923e42dc-48d5-4cbe-b582-1a797a6412ed
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3x9wVc+/sZU7iDIYGwrXxV8V6CT8nYlw6IcE7CkxYFJGyPKl0am/PnXZ0BbhoQ2wfO+1lOnm9gKqjgRgvILelA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5264


在 2025/8/26 13:09, Damien Le Moal 写道:
> On 8/26/25 13:02, Qianfeng Rong wrote:
>> Use int instead of u32 for 'rc' variable to store negative error codes
>> returned by ahci_do_softreset().
>>
>> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>
>> ---
>>   drivers/ata/ahci_xgene.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
>> index 5d5a51a77f5d..8d01c105fd44 100644
>> --- a/drivers/ata/ahci_xgene.c
>> +++ b/drivers/ata/ahci_xgene.c
>> @@ -450,7 +450,7 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link, unsigned int *class,
>>   {
>>   	int pmp = sata_srst_pmp(link);
>>   	struct ata_port *ap = link->ap;
>> -	u32 rc;
>> +	int rc;
>>   	void __iomem *port_mmio = ahci_port_base(ap);
>>   	u32 port_fbs;
> If you fix this, please fix it properly: the rc variable is not needed at all in
> that function. You can just do:
>
> diff --git a/drivers/ata/ahci_xgene.c b/drivers/ata/ahci_xgene.c
> index 5d5a51a77f5d..a6d964f7184c 100644
> --- a/drivers/ata/ahci_xgene.c
> +++ b/drivers/ata/ahci_xgene.c
> @@ -450,7 +450,6 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link,
> unsigned int *class,
>   {
>          int pmp = sata_srst_pmp(link);
>          struct ata_port *ap = link->ap;
> -       u32 rc;
>          void __iomem *port_mmio = ahci_port_base(ap);
>          u32 port_fbs;
>
> @@ -463,9 +462,7 @@ static int xgene_ahci_pmp_softreset(struct ata_link *link,
> unsigned int *class,
>          port_fbs |= pmp << PORT_FBS_DEV_OFFSET;
>          writel(port_fbs, port_mmio + PORT_FBS);
>
> -       rc = ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
> -
> -       return rc;
> +       return ahci_do_softreset(link, class, pmp, deadline, ahci_check_ready);
>   }
The 'rc' variable in the first instance can indeed be removed, and I will
send the second version. Thanks.

Best regards,
Qianfeng
>
