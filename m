Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B58D328600
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 14:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766153275; cv=fail; b=S5TshXUiA4wCEHQxr/hHalnHWBt3HvyaGpaFSvmtU4YjwlZepF8L+Kl1MrVMw7o4ibc/7cRfLowJnvmF6b1i0xek0TFanVQ3d88SBs0ryI16yWQbZ2MlKr6QGhBIwKZBRSxrP6vRZXViOnFtKSJ4oysTPCvakxYlzZG/LosLq2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766153275; c=relaxed/simple;
	bh=BCVmTg/F0Au1ZVjWhUksBVgXqV4XKxaQSoCugmiJWnQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ZSO2n1Hj9FMzehJdl2kPh2tHnA/oOaqLcZ7a7psA/CnZyceItED0d/LfuPp92PJawyG0CIfM16NdfwtPduV+lmdqylomJco/JDdTh/DrqOUO1uXyMHQIXVEIza3m0WOzsQU+DKDbL31ivUWC6Cjwspo3zOErgzStikpYkyAoRNU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jpeKXtkq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=FGvg7R0o; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jpeKXtkq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="FGvg7R0o"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3EYJd2740146;
	Fri, 19 Dec 2025 14:07:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=+vC6eN7Kh8DGSyAAAnWZdMKBS/2yMl1O9JoBJ/xwsTw=; b=
	jpeKXtkqb8k75ZVLkl4Ki3HPXDVbvT1PLLU65LG9aUgYB2Rf0J5st+bxT5IKFhzu
	HUXPUL1UY3M7e8JY5pFQbVqIWc6B9VlOcxAX5Gj+D+DNQ3/gt7krluMlguBqC+Yj
	nGAyujVPp8417vC6Dm8Jp1gpsIaHBrpzJoibac1MKnw8VZopzgo4RGtZQg8oD4B0
	PkdtZYki7CbuEUzJS7qHs/VBG1C5LGH3AkETApiyY0qPzt/KzqoqSBR0t8tLRymM
	1LxWfwjbIMEH5+x0595hz/Wf8UHR3jGUAnX0oyE4T3tKMFdzbOSpo5fWLPefsgOg
	mL1nDI4+XXNua91tE5aoXw==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2bh4ta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 14:07:40 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJCSNxB023671;
	Fri, 19 Dec 2025 14:07:39 GMT
Received: from ch1pr05cu001.outbound.protection.outlook.com (mail-northcentralusazon11010013.outbound.protection.outlook.com [52.101.193.13])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtayhgf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 14:07:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I5GQAwePMcu7FDG0Mg5SxXplAbjXJrJz3gJg6XDE3g7ae7jn659oLnKa1PYXY0Bwv+bm9HEUa2VrNUJC03odIXYs9BVOVkvgKLJCiOqt+zFhXZa+OUaGKvgQJ+MWilVgTnbZd+SVLii86RjNSI0eZn4duyr8ArTiw0twyaCj9Sc5EbDB/BCesrVji8VLo3s/aACHSnBhqeM/MYp9uZsKBaecdrxS6UJym1NNr9mSXL7GYmCSpowl8RyVfEDTQ7zE9PZThLxHtNs5ofP/Cfve8ozNNBSpSkXjOnrKG5kHHQ71d5wIv0/Z+xN1WwKEx9k6W5kZv91+2XO/+h2ZpZcPiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+vC6eN7Kh8DGSyAAAnWZdMKBS/2yMl1O9JoBJ/xwsTw=;
 b=S6mbb/deV0BYluw6b3Prplry3odmoDtz6v2dXcMozOSt6WV5TiLs/hTx7Pif1SLqfcWLkC3QiputejTvwzWTkzcDxAGJp4uJG5IsPR0mNZclC/DuhMwCTVH+BxsDnHXp84itizYsDKlIi4acSqEAgz+nDSf5nNYSkXkXpofvpDpVId0RncmGQ6WYRlvek9cJ4sazjWvmCX3fv4X/68BawnE/kQEuUomIpRI2s+9/WzB2Hu4aTM7J3CNtFhUSGabb85W439Ay+qXJNHvQvbqQo8SaMAIcWajTSd361T25jmcKaV1qhp+JJZpfDJxQ23iVq+7ITg3vyhof8y2eD/wnQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+vC6eN7Kh8DGSyAAAnWZdMKBS/2yMl1O9JoBJ/xwsTw=;
 b=FGvg7R0oLgmwFW/oKJvntLYewM3xoC+W6havMKMsK6W98lxWmOJj1QebplLhHPniy7tE2prmcd1OfjYEVeOoryjM1tJ9Y4cf/5vUITwuf8ZqSdKrQOSuSfOGA1ZRBLMiUuzPdy7X06vMKc2Unx3hW6cbVtI+sErQwnFrZqhfsHA=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SA1PR10MB6494.namprd10.prod.outlook.com
 (2603:10b6:806:2b4::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9412.9; Fri, 19 Dec
 2025 14:07:36 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 14:07:36 +0000
Message-ID: <e67adee8-281b-4a57-ab08-3b02acec7298@oracle.com>
Date: Fri, 19 Dec 2025 14:07:33 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] ata: libata-scsi: avoid passthrough command
 starvation
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Xingui Yang <yangxingui@huawei.com>
References: <20251219075134.501727-1-dlemoal@kernel.org>
 <20251219075134.501727-3-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251219075134.501727-3-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0184.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:1a4::9) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SA1PR10MB6494:EE_
X-MS-Office365-Filtering-Correlation-Id: 793fee20-10a1-4281-2f68-08de3f07f65d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MGtFRXJraG5TV1NrNVJrSjNGTEJ2Q1lDRWkzbG8vM0lTbzBjSkFTWlpPaDlL?=
 =?utf-8?B?OS9Xd0R2R3QzNy81Vk9BVGdUb09rN1hpeE5FZHVRS3NMQ0FNV3ZlUXlxQmxp?=
 =?utf-8?B?UjB3YUM3TDRSSWl0TEpzSDBuVUFHNDV1Tk4xd0VZSDJmc1hTekZ6dW53R0dQ?=
 =?utf-8?B?MG1ua3A0TGZrdWpVeE92TmxBL2JsSGZHRXlYVFdiNlRUNFRlbi9pRVQ4R1pX?=
 =?utf-8?B?VloxNFhqTVhsVjZsN2hUVVVucWtITGlRYy9SWDEwR3VCenkrTU5rVXlJeVBR?=
 =?utf-8?B?SnArelY4QnhaRlVhTkdaMmlqQWc5ZEF1U21sWDBvcUgzcDJqVnVMQXEvVVpk?=
 =?utf-8?B?ZGwrRSs0U3lWMTg2dEtLamxzUmk5Z1EvOFVUQkwwSFFUS2dKYXBONFNKZlQ0?=
 =?utf-8?B?Z3IxdmZXOU9zcFNTbGpXSWEyNnJnNlprNUVPK2l4UGlrSjNhdjlNSndHR3k1?=
 =?utf-8?B?OFlSV05CejYvQ0NEZWFBeFRZaWlPMWZxdnpDUmNINzJVbE12SkNneTJVelNy?=
 =?utf-8?B?dzZEY3NtWGk3VXFzUDgycUU5VlpxbGpBekNzbWZ4d0NSRlZNWmdkNXVpRXc4?=
 =?utf-8?B?T2dyNXJ3YlZHb0ZZSEUrSmxVVmt0SklhbWF0eGNINEFubnFMdXBva1l5K0lm?=
 =?utf-8?B?UURDMk1OdVRTcEFYaC9YdUN3RGs1c0JpVGNkZ0t1eVJQdlh6Skp5aE5rRklE?=
 =?utf-8?B?WnVoZ1lHREoveDZLRkRjYytKRGR4cHc5V0NlVUhINHVOQi9oK2ZGVVFYQlFK?=
 =?utf-8?B?ZG8vdkxGaWNxTW1DY1ZlQXVPTWEyeFU3bXFSeW9xYzdCMGdmVnQwUUFRS0xQ?=
 =?utf-8?B?Tjh1ckw1U2pYdldnZ1RxSmR0c1Z6bStMNVNhZ2twUUVJMXNMTC9aL3FwaGhR?=
 =?utf-8?B?S1RDWnBXT2Qxc2JHQXpDRkZacmIzUVhHejRTT20wNlFFblZlbjBERVArUUN1?=
 =?utf-8?B?czFha1BVSGxxRTNlRk1ac2JiL0F4eWFRRjRCcHEvK0o3TVNSWnRHdUFyT1hB?=
 =?utf-8?B?RDliVlN6ay9meW5GSHY3K1Ntb3l5cEJzcTMxSXFhYmtla0hzWThESnQ4RnZ2?=
 =?utf-8?B?dmNvZjRhSnhHN2FCT2NHby8vWkhwanE1QmJXYlUySjk4N3Y0Q2hJNVdFMEhO?=
 =?utf-8?B?eFNxZFY3U0wxRUdXRTBTRFBrYTdHcE8ydnBzRlZwZ0VvRU1nTHpoVlNwVTZP?=
 =?utf-8?B?cGlXSktGZkZ1a3dkakFiVVJ4enh6YUJVdVhCazFCL3RORkhCbDRZN1V2T2l3?=
 =?utf-8?B?YndoVkI0bHRYQUpKcEUwdE5rY0RJdDNuMVFrVkFrZnl0SVFqZHhSRUt5N1M4?=
 =?utf-8?B?cGg2T0p6bXpvZDY0K1ZZT3E3MDVjdENLYXVyYkZYSVhMd2pKZDNOY3hZRHVu?=
 =?utf-8?B?Qk5TdXFMcjhCY3JIVHp5ZGhVOUE0WjczQ1dhaUhYbFRYNFAxQjd3MlhHbGhS?=
 =?utf-8?B?cmhUUzRJMTBNSUEwVVNNUWh2L0tEZ1Q5ZWJqeUtkRE1BUm5DN3BtKzVpK1Bi?=
 =?utf-8?B?OHd6R3FSanFIaU9UZ1NmbHllN0w5NFVLZ01QMDlHRFplVFdxWWJhcnpscGlG?=
 =?utf-8?B?cy9KT0Z6NDl5Zk1oTHozQXIwWS9PeWdpL0Zndm5BNGdBSU5jSEk4WTc4MnRx?=
 =?utf-8?B?SjEzU1dONlRRSzVLdEpJczN1alRocHB6ZlIvVElmeklXSTluMnZwREdFRVFR?=
 =?utf-8?B?YyswaTRkQWo0Zkh6TXc4K2JoYWJlWHZ2eTd0TnBSY2xwd3IwR2FsdEx0UWRm?=
 =?utf-8?B?UVBDZDRGNU1oM3dURTh2VnpBeWJjUmRmekJSb3ZWbzdOQ0wrQXB6RDVjbjI5?=
 =?utf-8?B?cWZ4L04ySGo4VGNqSUtkdWtZRThYbHpBM0VzS3NLc2ordURjeWRVT01QMkZI?=
 =?utf-8?B?SnRSNTRPTmhObmxDU3VWNzZmVldNWERlSHFicmlzLytseERFYWc2cEZsRXdS?=
 =?utf-8?Q?eUrOGoISSd6BvfqnQUL6ToCK7SOXUmFi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?REdmbGtmUTZqakpmcC9kYnQyY0FvNU84dTU2M0IvMjllcWF4WUFhRFVyb0Nt?=
 =?utf-8?B?SThnTnNuRW90b1BuUWIwc2FtNG5yK3pubk9QRFVYSW40RC9SUDkvNlV2Zkgv?=
 =?utf-8?B?bTVkMCsxbHVVYmc4MEt0REwwaWZRRXhkSkJ0VzZDRFBaZmVPOG9qTXJwR01h?=
 =?utf-8?B?c2hOMDNreXB0ZkVGWkJoWWo5SFlITkpBQS92bXppMTlQaFRQRThHQjNWUjc3?=
 =?utf-8?B?dFF5LytlVWZ2MnFWNm5uRGYzZk9mdXR5VklacDQ4dVc3TDJ6UWxOS2ZOYmNS?=
 =?utf-8?B?NXJIUUFFQlhSR2hkYXBNMTltbXEwY3hRamZwbVh1M2NHbWtBNk15em9IN25P?=
 =?utf-8?B?Y2xGdzhpSHhENHcwSUNsbXB1di9MOFAvQVByMjlncWhGWDN4QWxLbytZVTdX?=
 =?utf-8?B?T3VXc1ZUalVlTThVQTh5SWNERnowTHd4WUx1NzlnRmtWUE9wYlYxd2tmNGEw?=
 =?utf-8?B?UStsc1YyMmZKU1NwUVowV0gyZVZ0MVN1NWwyNWRqeG0rRDRsdGxiNUJQR0l6?=
 =?utf-8?B?N1BjVyt5aUVpd1RqNFRQU2d2dU5FZjFOY0c1MzNyVmhVVkVyRmFFZ1IrK0xp?=
 =?utf-8?B?QXdTSURHN0lOOEZBWC8zb04xUExtbTJpaEdTVTZyU2dPV3BCOUQyQk1UNUpm?=
 =?utf-8?B?dHFNeXZheTdibWZ3MW5TNFdZY3pvenRqaFlmWThBcllBWTR4K3ZMbmw5UFRh?=
 =?utf-8?B?TGZiYmhKdDdEMmJBaXV4YlU5aTJTWDIxaHptMjlnWHdiMEJScjl2RG1EVTdX?=
 =?utf-8?B?SEJpUG16NW1LVHRVam5DRVRabmlIeDI1Q1FTVUpLeVN6VnNJMHByOVc5UVJi?=
 =?utf-8?B?VUVqYVFDb1pIOFVnRURId01kQWJCTkdnNVdVN0YrTTZwQUxkWENFdGs2VWVD?=
 =?utf-8?B?SmQ1bmxUT1d0N0JsKzRzekFqQlBvbktETWdZekw4bDU0QTUwSUFYTUI4QVg5?=
 =?utf-8?B?azZ5TUtIWXFpTUNCUElZK1BCNlhxbmd0bTluTWFNMzRsWVczUkpYMVVkODgr?=
 =?utf-8?B?QVhGRGs5aDRrOXd2Z3B4c1R2YW1PNi9FNGRGRzlRQlBZUHlKai8yRjZPMkZU?=
 =?utf-8?B?cVNtWWx5emNsbmJ5WGFnVUlNd3JCbCtVdTRCZlpmSUdtaUlpQ1VWL1g0cEVt?=
 =?utf-8?B?RFg5YlFSMElkdW5tRUthc2hUQkpDYUlkbVMzaDkrM0xtVnNIRitqOGorZ2Iy?=
 =?utf-8?B?bDMzYU9GWFFzTDMybVZzSi8wbkZIVWswejlIVWlJTW81VmgxUEZSR1ZCdmFU?=
 =?utf-8?B?YkVXVjk3bzlWTUVNOUZLdGlVV29EbDV1ZnZHeUFQQ0hlTEJ4M0x5cE1INkhD?=
 =?utf-8?B?QitrUnNiZHdHUVd6U2NDanhXSS9lYWg2cldGNXQrSWh3a2ttQmZ5ZkJNVmMv?=
 =?utf-8?B?b1hnN0o2MTBZTTJwT0dMdnhhcUhwaXY0VXR6dkR1dThFWHpzQjBUSFlGejMx?=
 =?utf-8?B?Q3FCMTlISnk0ODFNWWlzVzVMYmJQbEZOMk00TDZ6cVY3anZEdDZqZE9aQlBu?=
 =?utf-8?B?aU9aZVdzMzRmOHMzT1MvNEU0QkV2QjRwZTgySW4vTTNFNEszcEk0MFJyVjJ0?=
 =?utf-8?B?SUhwbnhscFAwYTZaaDd3dW1WT2U5VEZodnpBMm50Ylh1UFVydDg2OWtiSXNs?=
 =?utf-8?B?cm5ZN2ZQQ256bjArZXhkQlVheEdqSURaRkxWWWJvSjgvbVo2dFphZnQ2MFZn?=
 =?utf-8?B?RmZ4RUdQeXE5V2V2czVrd2krVGJGKzQ3TXpSRWVGMmtyYXVVOXBOcFlQR2pW?=
 =?utf-8?B?K1l1MFE3UlhudWhOeVFxTXU3TDhFcm1kVm1BUytpaXVmaFBZZlhNZzNqVHA3?=
 =?utf-8?B?Q2VIdStjSTRIOGViL0pkWmtjUlNvNFVlaG9wbzRpb3Q1Um4rMlJaRERqVVV6?=
 =?utf-8?B?cDBXZGY1VENGWW5YTkM0VWVqbU1oNGhYbUU4Z3RNOHNaay9IV2M0YWhNK3NW?=
 =?utf-8?B?Wk1TRzFNRC8yVnBENFd4QTh3alBQRTZGVzl4Ynh6UGNpMHBHYmtRTk9vcDF1?=
 =?utf-8?B?VHkvcyt4dmRUM3lkL2NKekhsWk10RGJGdXNFaTZ2R1VzZ0tReG9MQ0JoYUM2?=
 =?utf-8?B?TGQ5dGErQUlKdHJqbUQ2ejhNWGpDRkxhdWRBK1AyMHRxM2J3Ym5tRDZJbUVk?=
 =?utf-8?B?ZzFUeEdaY0U4c0ZrYkoxUUd4WTQrZDRhU0NWWEhGYTEyUCtvOE1Rck52N0p3?=
 =?utf-8?B?TlE9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	mYEN9lmmKXHO4/4Eaq6VnYMH2e1d/+78F2R1OFaSDVMWssVZ05wqNTRL9omPa1j/pKU0WzC9zHt/605G+Utw1doMHINWeRHBdT43vaOYhDNCfKWei1tP07K9LiNey3EEHTyfhybU/zVWuF88NPpQfS9bQdcxZe2H79SxnmaWrVYlw6hid1fydcfettyMu7BbWOO0LxBejR+zXVCP8BDZ6bTDBddAdS1H1Gcm0ISNxmB2Hipe8vsd7fYEn5ivFRryMUN6hqnuhAX6UcqgjcZTKLOxgHafS0oBXooxwY+xiQ4JmBfzhBLMHU1p34EH846dZtRGBrKs++6uNv4V+Ed59l48ROmTTACBSw5C1AkZfAg1MSyt5QaadYl2hlT3eVSX/cVMYUsScFaId/0PCxm96lus1iMyrKYyY8UbQbXHI5oiwbXMH1kyw0n3Laz9jEziOKuWacMwI/CvGOfibTO1BtryDyqbM5iWBCVX0sayO0dGbsPwKE99tz6wSo9fI2+eR/nIgWbwii5gs/xddfDHWHcgNIoJKnV4aYsrfOVjRdUVDz6kuhaYwIiIoalxlK2gM46mCx8W7oN8hGxPhLovoSV1YvMv1QJ6CvI/Wvg1fws=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 793fee20-10a1-4281-2f68-08de3f07f65d
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 14:07:36.6603
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YpvZAqRRIsSS0T6vyxkz9wMfNxmbfcj+TBm0IOTRzQdIhJ8B+BjHZZceZsjNJZARFSGoCeiOw6BBAmDQYXhPcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6494
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2512190117
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExOCBTYWx0ZWRfX0RuUGaZOrW9z
 Wbnpq5GsTwiI0PSD2T5VQ/Ji3ncHGJq8lfk4ZMDPEdpF6sX8tM1bEPvZYkzQiwRCgNU8ahA4ho+
 /NXjsjFhxjTaOOHZb2NXxfUfozjoq2JvgkC2rmr2nSCKTJ1OpXD1F4+AwSQyr46zNBx66sfG9bv
 jqVMVgExypJqS2owxuIyep7YI3Fzfi1IMxYHNQNBSnmqAS4mDF5uZKpAwvNVh0nvZ8zJSIpOrpl
 pTj/V5Tc4giGcgf2EjOttPPeqRCZeCniwAgGdxxzdjet6kWVVIq8iYV9sYaNtbqHLaqD+muBgG7
 i8KfMBhHqUPp64UtDAfR8gJTsJ3q2Ucj3/0+nk6QgHSR5t3FACDlX7AkrtPoGhC8pEzFA/AOljF
 kaRog4h1LTwHw32fQ3UMoH16EvfqGNsFi+aJ+mhlGCp81MdLhP+HS4IAIhEjrvKcZ0OyZdX5o+2
 WpBPgw9Y2dviPVKo7jg==
X-Proofpoint-ORIG-GUID: TwEJOdiwvCgvxVymMPVYJfAactq20ltF
X-Proofpoint-GUID: TwEJOdiwvCgvxVymMPVYJfAactq20ltF
X-Authority-Analysis: v=2.4 cv=ObyVzxTY c=1 sm=1 tr=0 ts=69455c2c cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=-_XixaNWoQpcXXqQsjwA:9 a=QEXdDO2ut3YA:10

 >   	init_waitqueue_head(&ap->eh_wait_q);
>   	init_completion(&ap->park_req_pending);
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

big nitpick: qc or QC? It seems quite inconsistent.

> +	 * completes.
> +	 */
> +	ata_scsi_requeue_deferred_qc(ap);
> +
>   	if (!fastdrain)
>   		return;
>   
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 42d103542525..1f8c103a7808 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1658,8 +1658,75 @@ static void ata_qc_done(struct ata_queued_cmd *qc)
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
> +	 * If we still have a deferred QC and we are not in EH, issue it. In
> +	 * such case, we should not need any more deferring the QC, so warn if
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

I think that you can just return early for !qc, no need to always be 
doing the lockdep_assert_held check. However, lockdep is slow anyway and 
I don't think that lockdep_assert_held does anything when lockdep is 
disabled (so returning early does not nothing, apart from reduce 
indentation).

> +
> +	lockdep_assert_held(ap->lock);
> +
> +	/*
> +	 * If we have a differed QC when a reset occurs or NCQ commands fail, do

deferred

> +	 * not try to be smart about what to do with this deferred command and
> +	 * simply retry it by completing it with DID_SOFT_ERROR.
> +	 */
> +	if (qc) {
> +		struct scsi_cmnd *scmd = qc->scsicmd;
> +
> +		ap->deferred_qc = NULL;
> +		ata_qc_free(qc);
> +		scmd->result = (DID_SOFT_ERROR << 16);
> +		scsi_done(scmd);
> +	}
> +}
> +
> +static void ata_scsi_schedule_deferred_qc(struct ata_port *ap)
> +{

Same comment as for ata_scsi_requeue_deferred_qc (which may have not value)

> +	struct ata_queued_cmd *qc = ap->deferred_qc;
> +
> +	lockdep_assert_held(ap->lock);
> +
> +	/*
> +	 * If we have a differed QC, then qc_defer() is defined and we can use
> +	 * this callback to determine if this QC is good to go, unless EH has
> +	 * been scheduled.
> +	 */
> +	if (qc) {
> +		if (ata_port_eh_scheduled(ap)) {
> +			ata_scsi_requeue_deferred_qc(ap);
> +			return;
> +		}
> +		if (!ap->ops->qc_defer(qc))
> +			queue_work(system_highpri_wq, &ap->deferred_qc_work);
> +	}
> +}
> +
>   static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>   {
> +	struct ata_port *ap = qc->ap;
>   	struct scsi_cmnd *cmd = qc->scsicmd;
>   	u8 *cdb = cmd->cmnd;
>   	bool have_sense = qc->flags & ATA_QCFLAG_SENSE_VALID;
> @@ -1689,12 +1756,24 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>   	}
>   
>   	ata_qc_done(qc);
> +
> +	ata_scsi_schedule_deferred_qc(ap);
>   }
>   
>   static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>   {
>   	int ret;
>   
> +	/*
> +	 * If we already have a deferred QC, then rely on the SCSI layer to
> +	 * defer and requeue all incoming commands until the deferred QC is
> +	 * processed, once all on-going commands are completed.
> +	 */
> +	if (ap->deferred_qc) {
> +		ata_qc_free(qc);

Would adding WARN_ON_ONCE(ap->deferred_qc == qc) be totally unnecessary?

> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> +	}
> +
>   	if (!ap->ops->qc_defer)
>   		return 0;
>   
> @@ -1702,6 +1781,17 @@ static int ata_scsi_defer(struct ata_port *ap, struct ata_queued_cmd *qc)
>   	if (!ret)
>   		return 0;
>   
> +	/*
> +	 * We must defer this QC: if this is not an NCQ command, keep this QC
> +	 * as a deferred one and wait for all on-going NCQ commands to complete
> +	 * before issuing it with the deferred QC work.
> +	 */
> +	if (!ata_is_ncq(qc->tf.protocol)) {
> +		ap->deferred_qc = qc;
> +		return SCSI_MLQUEUE_DEVICE_BUSY;
> +	}
> +
> +	/* Use the SCSI layer to defer and requeue the command. */
>   	ata_qc_free(qc);
>   
>   	switch (ret) {
> @@ -1777,8 +1867,11 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>   		goto done;
>   
>   	rc = ata_scsi_defer(ap, qc);
> -	if (rc)
> +	if (rc) {
> +		if (qc == ap->deferred_qc)
> +			return 0;
>   		return rc;
> +	}
>   
>   	ata_qc_issue(qc);
>   
> diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
> index 0e7ecac73680..60a675df61dc 100644
> --- a/drivers/ata/libata.h
> +++ b/drivers/ata/libata.h
> @@ -165,6 +165,8 @@ void ata_scsi_sdev_config(struct scsi_device *sdev);
>   int ata_scsi_dev_config(struct scsi_device *sdev, struct queue_limits *lim,
>   		struct ata_device *dev);
>   int __ata_scsi_queuecmd(struct scsi_cmnd *scmd, struct ata_device *dev);
> +void ata_scsi_deferred_qc_work(struct work_struct *work);
> +void ata_scsi_requeue_deferred_qc(struct ata_port *ap);
>   
>   /* libata-eh.c */
>   extern unsigned int ata_internal_cmd_timeout(struct ata_device *dev, u8 cmd);
> diff --git a/include/linux/libata.h b/include/linux/libata.h
> index 39534fafa36a..c5b27d97dfaf 100644
> --- a/include/linux/libata.h
> +++ b/include/linux/libata.h
> @@ -903,6 +903,9 @@ struct ata_port {
>   	u64			qc_active;
>   	int			nr_active_links; /* #links with active qcs */
>   
> +	struct work_struct	deferred_qc_work;
> +	struct ata_queued_cmd	*deferred_qc;
> +
>   	struct ata_link		link;		/* host default link */
>   	struct ata_link		*slave_link;	/* see ata_slave_link_init() */
>   

