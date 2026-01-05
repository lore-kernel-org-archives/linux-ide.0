Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3948322655B
	for <linux-ide@vger.kernel.org>; Mon,  5 Jan 2026 10:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767610351; cv=fail; b=Q5rVHFpk8mrSzQo7YN8QQgg4bpXsgzXp7MLpVfQo8Okf8T5ugf61YgdT+Dq/rDG1m6Q3sTfh6EDSFHWrOq5ywYBkUrYyY2/EgeAlHv6ViVMrMbGalt8BftsC4ZzykxF6PPnQTPUZxrqjJ+eOmJgI0zqst/e8domoUp51Ct/ccaY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767610351; c=relaxed/simple;
	bh=9K1YbKN5rii5FsrgWmcYjXDB//xVHht0pUeRy+KQyt8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=jhoQeI5EpdRowEQS6Ahd9HJ7LBjAeCOipxYdIrTIgNr26eS3lMpK3K/a0rjIhnEghLlk5PhkQduxIe4I+mnhnQWdX4DvR4Njfww+uPi6EVJsJjXhr684QC8xcqh+zQwHMbUoe/Fmw6ITkA+RN5UZXlEEODRYnuBUGlDlyocj4gE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=po8ZnGRJ; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=kVftevBx; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="po8ZnGRJ";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="kVftevBx"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6050hW8f369846;
	Mon, 5 Jan 2026 10:51:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=Q1fwbKMjsz+x4/kjl1W5bAEbc518mXIfiyhQVHT8OxM=; b=
	po8ZnGRJ7AKGKIT2qxTVef+uQkuMwUuS+jReZ8CBCTodF4jFAn7J6nOsz/O+vJax
	WatDF/8MulEonmyGfCMt8wsUsKNr4uSmisVUyyw3hJgjcdMj+3FgwtuVDiZlpTmI
	aSFEkL5OC61OtgLifHs3Rx9R9PZ1VazAUMJ648ayT35t4xS07hTpa5go7fn6oGEd
	3sE1QBL3sH6yzuDCSH0b8AqQrUKbrOd7OmQ4Kbpx0e8T483wf8LYYXyrHs6MA+/L
	5v7h21jcNnr367BkNdMPJ8QtjG378fsNoYu8CC8y6amDdiR7KYg6TkoFCC6TwSl3
	2fP5kZCGlJyKp7ch+hcjxg==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev4y9gsa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:51:44 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6059onU1034072;
	Mon, 5 Jan 2026 10:51:44 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010064.outbound.protection.outlook.com [52.101.46.64])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4besj788h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:51:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oCZa9EVZlUdvkZp07I1S8LNFKT9gEpLHI7Fc5ph/5R2EuyFREOuSMqk+hm7sI8qINnjzGyeCac89YojWQSTjdMPtVKf7Gs8iUIUiHkptbpEzJMWGZLcHpDAqLA81zmf4Ht2/TAeIArzbvP+PZ58w+5zv9udPHbhaM/Oi2YgtXOmf8waKC1ctvwJAZzVOkbnZobcphQhCpxhW+mCYFbQBSKrQeKsNubeCVjzTc5i5PDikHB0+HJasq2NKcbQEXWfoY87ihP9TYKjlAknNbSEV6iuUwcQIFlbTOEQZKSgnnfL9EZzynJZt0SrzET22cjq4UXv2/5w4FICeEB9Pn2VKVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q1fwbKMjsz+x4/kjl1W5bAEbc518mXIfiyhQVHT8OxM=;
 b=zJGRFsrj6unETB2mUEG94fmVzZwk+rx73UgMti7XJGa/wWhEBw9RIFeV2yw2+SSDvZl0KNgQNfHLuXcFa575twOh2+mJe1yjkj6nkuvKhbUbNU1scsJ3Kcvw02Fhlbokxrt+qM4IQSxeLJKUYnTevbaNFtbEcDWOVYLz1GVIvm9pNYDDABL4sQsynOu7V2B+o8EVKqqsmtwRBiWwm+zz6Im1KX8tLszA+zSC/HX4KdrtOP176Il2i55zr/tVWtye0PvjHO2cISr7iILKQyRcYfZV7fcx3PV6Mqh99mSt384ekT6VcKjMFluSNcI0kOfx5zgcXxfvvC7AvsQbdFVQ9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q1fwbKMjsz+x4/kjl1W5bAEbc518mXIfiyhQVHT8OxM=;
 b=kVftevBxVMHicFpyT4zGMAiD80rqwSvfL2fKprQ4YUEvTjcq8iPvTLmP0AnwOXl2sSitFm6oPibD6eG2WtEB9U7Vp8O5ARGqAUABlLEyiZRvwHjFPy7IPkbJZG84XY2+mGUEZwKbDsHZHr7f9Rx0beyEm3u+pOWxAYqFD9SCQhg=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH0PR10MB5003.namprd10.prod.outlook.com
 (2603:10b6:610:ca::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:51:39 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:51:39 +0000
Message-ID: <5e93f9bc-e70a-4a72-96ea-84c781216cf7@oracle.com>
Date: Mon, 5 Jan 2026 10:51:36 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/2] ata: libata-scsi: avoid Non-NCQ command starvation
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Xingui Yang <yangxingui@huawei.com>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
 <20260104082203.1212962-3-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260104082203.1212962-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0428.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d1::11) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH0PR10MB5003:EE_
X-MS-Office365-Filtering-Correlation-Id: 8020ba4d-d89d-4fb1-02fa-08de4c486791
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhRREFEZlBBZks2dmRZMGRBeFdiUEdORExCZEJKQlM4UWZodm1wL3ZJMkRG?=
 =?utf-8?B?ekVjV1NsRlA2b2cwMmcveFZUY2k4U21HWFQvdGx3Z2lqRXFYU2ZwN0JSK1Nx?=
 =?utf-8?B?UnZ0RTYyOElPcEJVMGR1d3FMc1FRMlBLNnhlTUY4US9hVkhURHErMkJydFZH?=
 =?utf-8?B?cHliSzd6SmZGTHY2UXZ6NHhZUmtrTWovQ29KKzk3S0FVNW5VYlBuZUFrMHFw?=
 =?utf-8?B?ZkFDclVLQnZUSDI4dmNxWUFIYnpZdFBvQms2NytxM1VUOEFKTVZJeXlyaE9t?=
 =?utf-8?B?SUYvZGJuSnRTNCtXMkNzT3c5VTc4UnIwMUM5a3hJTzUxdk80S3B5NmJoN3c1?=
 =?utf-8?B?YVRacWJwRDUrNTE0RGNHaGZLUEliU3p0TzNsUElVRFUxdGczYzEyVUg0cTh6?=
 =?utf-8?B?RXk4OStkQVlldlpqeDVCcEJmVjA5Q1hPWStNYk5vMkNoZy9nV0g0NURwMVlp?=
 =?utf-8?B?VlArRS84ejRobG9NRFlySTV6bmt3TFJVeGJFc1pNM0VEM1dJK0pxUDZiK1Jl?=
 =?utf-8?B?TnFic25GQkwyMW5HTi8zd1lZb3JUS3JmOHpxY2Y4Rm92UTUxamVyRE1WTFNX?=
 =?utf-8?B?NWFsU29uTC9Dd3VUMVN0eXJWTlJ2eWZEOFZVcjRNRWhmT2xKR1BFZnhpSzBq?=
 =?utf-8?B?REhyWk84aG02dTdNd2RQQkJ0RlFiUVl1S01pdWtFVUZ4bFJpeHdtNWZkRVpm?=
 =?utf-8?B?RFhkR3lycTFEVGxreUZ0c0VESVk2R1BQZ0FnbWJwVFF4aW5FWS9mRU1ERzZ4?=
 =?utf-8?B?L2tMM2tpU29jVi96R3JQWUR4VTdkeU5VZlo1TlAxVzAzdFlWWUpPZXRjd2wr?=
 =?utf-8?B?dzlkcjk1OHM4SktrQm1KYkovbUdlVDMvYkpHSTlDVFJXQXdCcGEzNE9GZk53?=
 =?utf-8?B?TXBHZFJwWmVNcnJnUVpwVlYvSmN5SjA1UTJpMk5uaU9PeFN5VkNUVHFHS2hm?=
 =?utf-8?B?d3pwZ3FTNW1oZE5Sb0NuMEFOSGY5NG96L0dmZTRpKzh6ZENHKzNDWkgrR0tq?=
 =?utf-8?B?ZE9vdFY3aDNuNzB2UVNDeGs2UkhaTVhiT2IyazZrNmJXbmg1UmFubVRpNmo1?=
 =?utf-8?B?YVRnbFVaaGFkN1lJWW81VEtqaEJVTmVYNDdNQ1YyeEsxek8wTWpyQlY5YlpY?=
 =?utf-8?B?SmRPbDAvdnlLYmxRU0NFS2FRWWllSmlKNTluUjZxZ24wc0xSQThxU0x6bzhO?=
 =?utf-8?B?dmYzYmgxRWkxdVdVaFJMVkRvUkhtTVhDTWZVLy94Ym1sVmlkWi9FaWFKaWk5?=
 =?utf-8?B?blIzMkhHU1BCWERRSnA5anJMdGt5d0VmZ2ZWS0FLZVN4bU1WMVBkdWJhRzFI?=
 =?utf-8?B?RHpQYy95bVh5dDNLTWRsYWxGVWNJS2JwTXE3ZnBFc2tmRnZwTDlJZGdCdUh3?=
 =?utf-8?B?Vkx4RU9EUzcwajdzai9rU0lrQUFRdC9jaSt5OE0xa1dIbHFmbTR4OGEvQlRG?=
 =?utf-8?B?MEhEQU5LR0NGMzd6MjhMOWRvQW05WU5GeHBQOHl6N1hhVnhoM2ZTb25zS1Zn?=
 =?utf-8?B?a2JQbmRLQ0hIL3JiYlYrdEluQkExc1h6Z2dTc0EwV1B0V3VHbmxJRWRrdjZE?=
 =?utf-8?B?bEFnQ3UvS3FBVExzWEUxcGlvanZua1dGNEd0RlNwaTlNSjlFZTFPck5JeUtw?=
 =?utf-8?B?MEU3MEloaXVZSlYzeUlKSTB5ZUh4TlhFQ3dFbmJJUWRTSEgyanV4NzZWNHE3?=
 =?utf-8?B?dTIvUjlPK1k2aFlsSEJISUhvSmJiVDg1UU94WHBQM2dCSkJjZ1RncVlVcnhr?=
 =?utf-8?B?VGhidzl4NHo4aEk2c3REVmp5QkU5cHVPWldOalp0RHUxcDJOd2ZsaWFDd3U4?=
 =?utf-8?B?MVA3SEUrSFRtWFBKWEFDa09YdmhIUWhwNzJ4QU1WMmdIRE5senRVbjZBRC9p?=
 =?utf-8?B?dllsOXFmTC9HR0VOT05BeWw1a0c1Z0ptc2tQVy92RDBVYVlnYXhJbkVSMzRk?=
 =?utf-8?Q?/2GCDfRpxtJ3aaxBSDxux6unoCyfhg9m?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U0ZUdmFNVXRxbXN5SmU5b0xzUnpTUmx6amZHVjFsMGlHQzg5dnMwbDc5d2xI?=
 =?utf-8?B?VnliaGhvUnQwYVdkRFJCS2MyRTFHUFFIbjFXTkYxS0RDRUhTK0JNOTcwR1l2?=
 =?utf-8?B?V1lYVVhPZDBEVEw4Y0Y1djZma3pSQXRsbmNqaUlzd21nMFNoUWZyeXFJTjJn?=
 =?utf-8?B?bGE0blVVM2ZIS05pUDNmQ2VRL3BIcVZaYWdJcTNieEwyRmdZOVo4ZU1ZaE93?=
 =?utf-8?B?OG03TEJiem5hVnV6RVljL3h6Sy9rdm96YU14anFzcWFmMHNMTEVyVzFMcVRQ?=
 =?utf-8?B?ay9iMm0yUGFORHFLS1NsMjNMWEhGZG5DT2x2eDB2OUNrdEErSnRUYkJYUFNQ?=
 =?utf-8?B?c0FhZ2hQdHo1anpsUUNOa1pXWTN1eGxqMmZHWXdNalBSRjZPd2xNYjdMK2JR?=
 =?utf-8?B?OHIwYmp1VFFaei85VVN6RndHMk9QdVFTdktPSEhiQ3FHTTYxaXM0TUs4d2oz?=
 =?utf-8?B?TGJXWng1dU1ERlBOT00yTVQvSDlCZlBKRXVUM09JMXptSThRVDZod0xDSnJ4?=
 =?utf-8?B?SDY0cnFQM2JFcXpsYlE2eVk3Vko5N1lTYk5NYXBLY3RvUldjcTZaM1VhWnFD?=
 =?utf-8?B?eTBrZWc5WnkxVDZzb3dDMkFqVG1INzdRZ2NiS2VWdmdxS2ltNGwrTnFxTGpk?=
 =?utf-8?B?c2Irek9iK2NjK3ArRUgyVTdDWnZBYnZUK2wzVnlEejJMZnNmRU50OXJNZEhY?=
 =?utf-8?B?NUYraGRsMURUOHNZYkRJaVdvSzRKbEl1ZmppMjBkejg3R2VXSkJVNkR3aWI1?=
 =?utf-8?B?VWdVTFZudExMMXphRnFiekIxcytHZ1hmcnh6VHk2YUI4REo5Q2hwWk9DeXBv?=
 =?utf-8?B?Y3dBaElDTUp4cW9XeTR6TnRqcGRxTGJWUjY0UFRmdk52SWExN0oyNVRMNXhC?=
 =?utf-8?B?LzlsRVg2azlTMm15eTAyMzdVMzhkYmJwekhTcnBXSzU4UlRrZ2xHT0NEb01t?=
 =?utf-8?B?SWxkTXlOL2ZucE9yMFBJZ2IwTVRoYVJsRnV0UXBPZzV1TktPWE9NMkhEWDdU?=
 =?utf-8?B?cXMwTVNUTmdYMGYvK1g1M1h4ekY0THN0Y0hJejFEbGRVNkRmT1dtL1AvczJm?=
 =?utf-8?B?L2V3M0g0Sk1rS0VKOU9ndld3N0ZRV2paaFFQajh6aEhlMUxxbWhTd1B3TzlV?=
 =?utf-8?B?Y2Q2eFF4eFREclE0OWQybUlzbDdKRUY3MkVuMVYxNFN2T2YvbkJMakNJbFc2?=
 =?utf-8?B?L3Nmd3JmdFliQlhiWlcyUGEvbVB5dHJ1amtSc1FLR3pyUktlUkcvZnZuUyt1?=
 =?utf-8?B?Y0tkZFFNcGdYdEV6NEc4MkQ3NzBMb2szSGFrYkVJaEhiNHUxc2NaNzJPaTNz?=
 =?utf-8?B?K0xNZHprQ1BEZnBYdlpyT0xzRlBxcUxHQkNqbStOVkwzcXlDK1FVeGJibVdR?=
 =?utf-8?B?VERZMmp5QTIraWhYanB6eFhZdmdoYUVPa0xELzF4bjRoUm5ROHhEdzRaUTlt?=
 =?utf-8?B?dmYrZ2pOM3VCMUdDb3dNRHZYYURQNXJuaUY1Y3FycG43Rmk3d25pSVJkYjlw?=
 =?utf-8?B?RU0rcDhMT0l0a2hHZ3JyQ0x6VGJOUThITWZqdmRXNnJCblk5S0NaaXlKcGxq?=
 =?utf-8?B?Wk5lKy83b0NaLzdNSXpLOGhudTM1NllkTmRnd25FYnBuRmpBc1ArbWNSVk14?=
 =?utf-8?B?LzdVQkY0M0xPVXgvcTJWYkl4Q2t5UTJsMkY4WUVOQVNKSTFoakdkOFZZelYv?=
 =?utf-8?B?RWZDWkMrQVlzWmY4WGtqVmZrU203a2ZqS2NncWZsYmpNcWVNZ0VzanFwQ3Z2?=
 =?utf-8?B?MDRQcnA4dWhkRStFQWw4d2FpV01EQlNXVU05anFHTTA1VVRYQUdCbUZHa1Ni?=
 =?utf-8?B?bFptNWNxTFVUYytoR1pkdkRoenkvOG52NGFWL2lwT1ZTUWlpdmlVVjFtejRu?=
 =?utf-8?B?S2E2Yk1CYjJLYUNzUjg4SVZSUldNbjdjT1dqejhPcDdPTTVYVDZtc0VEaWhu?=
 =?utf-8?B?SEhISEcwUlRPNTY4RzVqZEdXZlJvMmZETnVqK0FpcFJSZ3YyMHdDMStUR2NB?=
 =?utf-8?B?Q0JqNzd4SzhFd1JJUkxSWTBrQ2wyZUwrejhsYXZoWWRMWjluZXhtTjMrRkhy?=
 =?utf-8?B?VDRkSngwM0dLMmc5TzBKa1M0ellyWlQxSDBVUmlPSEFvTURqRUI4aUgyRWlp?=
 =?utf-8?B?dmJJUldFQ3NtZFJyQzgwcDNUemg1eU1vQWs2dmlvbnZ4ZzlEcStYQkRpSFFv?=
 =?utf-8?B?R2dPbWJHZlRJSnRkOHpBZmh0R2JmZ2pKRUNOWGppQXFIRDV5MzZFdlN4bmV6?=
 =?utf-8?B?MFk2RjhjY0oxK3BMdCtsaCtxQjBhQVh1M3pKMHZ1dlo2UWJzOUFua0d0bFJS?=
 =?utf-8?B?Tlk5UGl6Z3BlbEZsajNPN2Vwa1RwVlJGY3VkWDd3SjFhQzdZbVVkT3ZlUjB5?=
 =?utf-8?Q?y9NhwetHSRj9ZL3w=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	90sqrCk4zZVzc59TZPQw3Xy/n+NwN8YNgnKaP0yXdZKFoKTSieW1MK66i2QruTBEj0Dr6IbSXfQnE7U/rb/Bcs6w0ulLhsKMzE/wQ0kbdNW/0xudwCa9dS/xYoye1Ea6HnHVk/OgXZ5MtTkTik2PTAK0yd57QJHf3egGB0gEnhzN9iGTxjVA/uMee83Jo/dRmM6FZQXuM/jMkcpWYeZkxIiZHC3rtxX8kV+a3DECdkz8PzKrfmaKq7t/wcsUWFlFOSd1a53i9QZ7nRGLpSw/4c+CeHozhTxRMMDYN3gXOA11weHaA0PG7uDR3WoPWl9cK31LIHGqlYjZTEMhBINGW3neyZPR0cd3RKVsuXz3kb2CAJ+IOK2/KdVfM5/I4NSv5ujqrSb23Jca3U2QFzFqimFPGkvgZX1ft4x1gxQN9g/B94KzzQXDF6bMD5bKXFnMuSJDKOFmYkF6f73Louymr7eXT4amOAQ/xN5ibcJnSzexF+3Xs2OKQ394wkyWuyzpIWbIMAWqYbzli3x24Nhsu3ynwAJkPxP+NXf2Xks+TFW4GdfgNQ7kY8075AghK8BrFVnQQ2YNV1DWnLqnDGN0U8FYYhkb5wZNuNJ/BqfXHG0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8020ba4d-d89d-4fb1-02fa-08de4c486791
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:51:39.4358
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrZ8UQ1pb3fZgfLMX2O3pOjOhLAbN5cdkfUOnfpiO7IFQ5K5VhTWzgvWTE2Iy07ArlWoXYbuNTeWL/6/h1LtEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5003
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2601050095
X-Proofpoint-GUID: AzN2sG2k4ssHbUxgz59_shTNLUmQBt2o
X-Authority-Analysis: v=2.4 cv=dLyrWeZb c=1 sm=1 tr=0 ts=695b97c0 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=i0EeH86SAAAA:8 a=1XWaLZrsAAAA:8 a=iox4zFpeAAAA:8 a=VwQbUJbxAAAA:8
 a=yPCof4ZbAAAA:8 a=_jtCWfmc6m_A6z_MF28A:9 a=QEXdDO2ut3YA:10
 a=WzC6qhA0u3u7Ye7llzcV:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5NSBTYWx0ZWRfX5EehXvLo+QNj
 hU0dVcSwni8eZvMxpYNmojPWzu2aYfMeD19cY3Vk5VdkZBqu77lRK2Xlrk0lixzyJDKzjN89mAm
 ujSN9mgTXptKnbqZR9+MJHuExhUQo5mcqzmRcAPLFMZ5Pw0pPB29kh25hrB5QVOhwuzR7Lfimqn
 8/v9DBQFN22DOKBM3KzS1G9a1YQA8A8Fk1Qe+as6OhilsJA25VYxuiEUX4AHfsk3nebNCd9QWVM
 qwO9GoUXLVgB0+xLxved9O0/f7TujHAnteUUpttn83j9QgvAyE5hR4WEU7pZbn+uh5Qpk9cqDfz
 96XNNPv656U8L9FPSVcRGP4g8OBS8W5V85pjDcfZcwUHjJD8ocbB3BJdO/UtcKbIYKYmv+X82yW
 ZAwhCXYyhi3pYq8tmkfZqPlmTVfHTg==
X-Proofpoint-ORIG-GUID: AzN2sG2k4ssHbUxgz59_shTNLUmQBt2o

On 04/01/2026 08:22, Damien Le Moal wrote:
> When a non-NCQ command is issued while NCQ commands are being executed,
> ata_scsi_qc_issue() indicates to the SCSI layer that the command issuing
> should be deferred by returning SCSI_MLQUEUE_XXX_BUSY.  This command
> deferring is correct and as mandated by the ACS specifications since
> NCQ and non-NCQ commands cannot be mixed.
> 
> However, in the case of a host adapter using multiple submission queues,
> when the target device is under a constant load of NCQ commands, there
> are no guarantees that requeueing the non-NCQ command will be executed
> later and it may be deferred again repeatedly as other submission queues
> can constantly issue NCQ commands from different CPUs ahead of the
> non-NCQ command. This can lead to very long delays for the execution of
> non-NCQ commands, and even complete starvation for these commands in the
> worst case scenario.
> 
> Since the block layer and the SCSI layer do not distinguish between
> queueable (NCQ) and non queueable (non-NCQ) commands, libata-scsi SAT
> implementation must ensure forward progress for non-NCQ commands in the
> presence of NCQ command traffic. This is similar to what SAS HBAs with a
> hardware/firmware based SAT implementation do.
> 
> Implement such forward progress guarantee by limiting requeueing of
> non-NCQ commands from ata_scsi_qc_issue(): when a non-NCQ command is
> received and NCQ commands are in-flight, do not force a requeue of the
> non-NCQ command by returning SCSI_MLQUEUE_XXX_BUSY and instead return 0
> to indicate that the command was accepted but hold on to the qc using
> the new deferred_qc field of struct ata_port.
> 
> This deferred qc will be issued using the work item deferred_qc_work
> running the function ata_scsi_deferred_qc_work() once all in-flight
> commands complete, which is checked with the port qc_defer() callback
> return value indicating that no further delay is necessary. This check
> is done using the helper function ata_scsi_schedule_deferred_qc() which
> is called from ata_scsi_qc_complete(). This thus excludes this mechanism
> from all internal non-NCQ commands issued by ATA EH.
> 
> When a port deferred_qc is non NULL, that is, the port has a command
> waiting for the device queue to drain, the issuing of all incoming
> commands (both NCQ and non-NCQ) is deferred using the regular busy
> mechanism. This simplifies the code and also avoids potential denial of
> service problems if a user issues too many non-NCQ commands.
> 
> Finally, whenever ata EH is scheduled, regardless of the reason, a
> deferred qc is always requeued so that it can be retried once EH
> completes. 
> This is done by calling the function
> ata_scsi_requeue_deferred_qc() from ata_eh_set_pending(). This avoids
> the need for any special processing for the deferred qc in case of NCQ
> error, link or device reset, or device timeout.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Reported-by: Igor Pylypiv <ipylypiv@google.com>
> Fixes: 42f22fe36d51 ("scsi: pm8001: Expose hardware queues for pm80xx")

I'd say that this is more related to the following:

commit bdb01301f3ea51a59eff252b06643fc1fe843e57
Author: Hannes Reinecke <hare@suse.com>
Date:   Wed Aug 19 23:20:30 2020 +0800

     scsi: Add host and host template flag 'host_tagset'

That is when we could expose multiple queues.

> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---

Generally looks ok, but a couple of comments remain for me, so:

Reviewed-by: John Garry <john.g.garry@oracle.com>

>   drivers/ata/libata-core.c |  5 +++
>   drivers/ata/libata-eh.c   |  6 +++
>   drivers/ata/libata-scsi.c | 89 +++++++++++++++++++++++++++++++++++++++
>   drivers/ata/libata.h      |  2 +
>   include/linux/libata.h    |  3 ++
>   5 files changed, 105 insertions(+)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index 09d8c035fcdf..447d8dc666a4 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -5561,6 +5561,7 @@ struct ata_port *ata_port_alloc(struct ata_host *host)
>   	mutex_init(&ap->scsi_scan_mutex);
>   	INIT_DELAYED_WORK(&ap->hotplug_task, ata_scsi_hotplug);
>   	INIT_DELAYED_WORK(&ap->scsi_rescan_task, ata_scsi_dev_rescan);
> +	INIT_WORK(&ap->deferred_qc_work, ata_scsi_deferred_qc_work);
>   	INIT_LIST_HEAD(&ap->eh_done_q);
>   	init_waitqueue_head(&ap->eh_wait_q);
>   	init_completion(&ap->park_req_pending);
> @@ -6173,6 +6174,10 @@ static void ata_port_detach(struct ata_port *ap)
>   		}
>   	}
>   
> +	/* Make sure the deferred qc work finished. */
> +	cancel_work_sync(&ap->deferred_qc_work);
> +	WARN_ON(ap->deferred_qc);
> +
>   	/* Tell EH to disable all devices */
>   	ap->pflags |= ATA_PFLAG_UNLOADING;
>   	ata_port_schedule_eh(ap);
> diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
> index 2586e77ebf45..b90b17f680f8 100644
> --- a/drivers/ata/libata-eh.c
> +++ b/drivers/ata/libata-eh.c
> @@ -917,6 +917,12 @@ static void ata_eh_set_pending(struct ata_port *ap, bool fastdrain)
>   
>   	ap->pflags |= ATA_PFLAG_EH_PENDING;
>   
> +	/*
> +	 * If we have a deferred qc, requeue it so that it is retried once EH
> +	 * completes.
> +	 */
> +	ata_scsi_requeue_deferred_qc(ap);
> +
>   	if (!fastdrain)
>   		return;
>   
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 5b6b5f1ff3c7..4aeffd6a5640 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1658,8 +1658,73 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
>   	done(cmd);
>   }
>   
> +void ata_scsi_deferred_qc_work(struct work_struct *work)
> +{
> +	struct ata_port *ap =
> +		container_of(work, struct ata_port, deferred_qc_work);
> +	struct ata_queued_cmd *qc;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(ap->lock, flags);
> +
> +	/*
> +	 * If we still have a deferred qc and we are not in EH, issue it. In
> +	 * such case, we should not need any more deferring the qc, so warn if
> +	 * qc_defer() says otherwise.
> +	 */
> +	qc = ap->deferred_qc;
> +	if (qc && !ata_port_eh_scheduled(ap)) {
> +		WARN_ON_ONCE(ap->ops->qc_defer(qc));
> +		ap->deferred_qc = NULL;
> +		ata_qc_issue(qc);
> +	}
> +
> +	spin_unlock_irqrestore(ap->lock, flags);
> +}
> +
> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc = ap->deferred_qc;
> +	struct scsi_cmnd *scmd;
> +
> +	/*
> +	 * If we have a deferred qc when a reset occurs or NCQ commands fail,
> +	 * do not try to be smart about what to do with this deferred command
> +	 * and simply retry it by completing it with DID_SOFT_ERROR.
> +	 */
> +	if (!qc)
> +		return;
> +
> +	scmd = qc->scsicmd;
> +	ap->deferred_qc = NULL;
> +	ata_qc_free(qc);
> +	scmd->result = (DID_SOFT_ERROR << 16);
> +	scsi_done(scmd);
> +}
> +
> +static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
> +{
> +	struct ata_queued_cmd *qc = ap->deferred_qc;

Can we assert that the host lock is held here?

It seems that the flags which we set in ata_port_eh_scheduled() are only 
set with the lock held, so we should ensure that it is held when we check.

