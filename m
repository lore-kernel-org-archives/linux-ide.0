Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EABBB327C09
	for <linux-ide@vger.kernel.org>; Fri, 19 Dec 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766152840; cv=fail; b=kls16WmXwbSYycigOgbRkFfPzweCZKVSQUW1q61LU5pvQU9jqOAzM+AYSjvEtNBH6M7Y7otZFhWz/AlJMPwHIrKGegJI2jd2AIHZq5OrHJ/7L5rWIiI0PoS2znVRW6+xXy0QpGgjc5h5TnoGOxKOjjMSmDVs60d55Ip8kVBHhsc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766152840; c=relaxed/simple;
	bh=7oDe+qbk9TOfL193HaD8xV3TXKeR4PHlm/nTRr6fUgI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JOMD8sJ54CJLVvDXBR93pqR3itSVTWwFOkyd4r32XEmfT5YUnWJBWY7QMGdVr3cEdhvYpBzTfdwlSspHqw3Wd9gf+PIZaXoQZY+lC1HN3R7IQGhNJDxl9w4XAyUPXNlHyASj6SEB7BM0UP6brk3ACY551nxY4jU7nf4EnyGJubk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=YRgvAlGb; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=QlJmRguo; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="YRgvAlGb";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="QlJmRguo"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5BJ3EY192740118;
	Fri, 19 Dec 2025 14:00:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ORt9gmO4RE51UlkD+boNOP9k3QwxabGyIhE40nkNB38=; b=
	YRgvAlGbgBJs6pfdPcvQsZ+yXuzbSuv62tiAog3gj/ORd0PySdRzdT70YgcXiTp8
	2Ij+J4NjtHNcXzbQkmfgeFDPRJIfjX2PyveYkjzlsIucf/44YAWldCjgGQnTMHeP
	Zm90zZFjWqfadnnf+T1IuNdV5HnTxZlqDJKayGXs/hsjZrZ/YgZzqEHCxRHFTArS
	tgsQAorPlCZkPe5V58AEb4J19VBt6dDlVBHJRZAmnJbleMQqeEq4o0x9p+8aYw95
	oAcmWE8lxaWlG1PeKrytYa6LQah9r5xNO3XjrzSsfTUhgoQ2NnWJT1+9cTOqw0Zr
	FuFjFa4zrosxicArBzARVA==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4b4r2bh4dn-4
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 14:00:24 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5BJBeV2R036681;
	Fri, 19 Dec 2025 13:53:11 GMT
Received: from ph7pr06cu001.outbound.protection.outlook.com (mail-westus3azon11010067.outbound.protection.outlook.com [52.101.201.67])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4b4qtmf3ew-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Dec 2025 13:53:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pFSGupq9jrD5MlqCTSFvkvmiQvoBrDARV3Py7NguVbddAyjMUPTYRRn9ulqmI2NbvO5EXxqs9tgYCtvWgT4FN6vhiF/E1lrN2G8vk13kexeS4ZE2JxjmRsgBmjtUyH61P+ZxBvmSrmKUSTeLw/GAaBCbWckzAosMfcjGVDk8XW3cdQSDfKwQHwAk5tS56Lvof5X5za+T/ZRnoLmdcnuXbB6J+g0XwjBj9iXFMYtbPpxUVZBOXAD8C6pPfwf15nu/4XIzYosFFPy2YYh+ETAO+ZSIepHOp17Ol74baKiMRV/3fmWNmFkNhvIEBO4pTQGtArKI+q5Px/tPszZjKw4yrQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ORt9gmO4RE51UlkD+boNOP9k3QwxabGyIhE40nkNB38=;
 b=Wz+JPKFn9tdkCocg4NMJChjIDtZTtwdnUewuM2jAskblHI9yJO3hcco9ehc7SFMfDepCN4azHwFJzSOJtG/S5AN79MpRc7/C7PWpMsdYSfX76o6EIST1H97E2ut0yFLIm18jeW+/6sLkiNeNkzeuFtFYnN4mTZ55K8Hs2qgcLs/ispm01agirXAL8eQgE/MulBLN1t8JdyygDlhB0d3YRo9bdAEdfTvqj7+K11J3JWXMrhov2qhwcaLe752k6UdYVmdb34AGR2jQ/YHss0zzqB6aWy7OlQNq9gicIPmOXcvI6fnuWgWtsDfNA6zzQfgZiDD8YfvwBr+Gh27gyQmyaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ORt9gmO4RE51UlkD+boNOP9k3QwxabGyIhE40nkNB38=;
 b=QlJmRguo6S4SaqzkcOVLir06+36n7Ymxd/xtlcG36TS4lsaY0xY2oQfauJClqUp7YwKUrcQx9QKvE6S4sKWKgCpzmEtFyAaADhNQv97hOLXDmr7yhG1kuOm3BKtrcL7cb3cQkCf1rhR2yigzhGX/KZeJ4j6o7pxZgY68KCO7EPE=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH7PR10MB6281.namprd10.prod.outlook.com
 (2603:10b6:510:1a7::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9434.9; Fri, 19 Dec
 2025 13:53:03 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9434.009; Fri, 19 Dec 2025
 13:53:03 +0000
Message-ID: <7444d7f1-30a6-4e4e-b866-f9a54f9af7e9@oracle.com>
Date: Fri, 19 Dec 2025 13:53:01 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] ata: libata-scsi: refactor ata_scsi_translate()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Xingui Yang <yangxingui@huawei.com>
References: <20251219075134.501727-1-dlemoal@kernel.org>
 <20251219075134.501727-2-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20251219075134.501727-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0271.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:195::6) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH7PR10MB6281:EE_
X-MS-Office365-Filtering-Correlation-Id: 8d205fc9-0998-4e3d-d519-08de3f05ee01
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q3dqZytjeFNueHpVUmF6Y1NTbnVBUS9LbmdzQzdDZ2dmV1RxNmIrVDZaMHNo?=
 =?utf-8?B?VExuYkZWellSditnLzNyUVR3cW9ZNjdRR28xZkxGTjdxaCttQk9Uc3VEcWMw?=
 =?utf-8?B?QVRBWkNsN3ZkL2xXN2NWdUhjWTJZRWQvRlFzOUhObm82R3lQam56Ky9EUW9p?=
 =?utf-8?B?QXNQT1U1MDBRSjM2eTUwb3JUMGNuVFMySzZLSmRaNlFtclV0MVlta0dRUmly?=
 =?utf-8?B?UlVJYTRhWWJoYkRGa29KbE4vSkhUQUJDOVg2bFMvMUxoL1YvQm1ZYTBkOTdV?=
 =?utf-8?B?K1cxaFV3aEgxbGtURlRxOFBLQW02RFNDeVgrdTlaREdVcUNUWVRtSGFya2tu?=
 =?utf-8?B?ckd3ZEtCL3Q5UzR3enZzbmRpUEl6MWp6cHA3K1NxWjFxWnNST1drVHhNbVZN?=
 =?utf-8?B?Sk04UFJIaHZJak82THI3cExhS1pXZmNWK1MraVltWVIxa01LSjdxK3Y5c3pG?=
 =?utf-8?B?UXREUWUycGZlMWhCa2IzMFBsS3IwU3liTnZhMHNlSTdZWHRNdXM0RSt5dzVO?=
 =?utf-8?B?MlhYeDhrSlVUVER1ZENpVEtuaEJtU1E1SU4rMlBWWFhiaGtPNXFNVnRnbFVq?=
 =?utf-8?B?OW43SVZYQUkrU2N5bDF0S3pHTXVXVm1NcmgvWXp1MHVKTEY3MEFWZnpJeDJu?=
 =?utf-8?B?dkRkbWZ3UXRYdDlaUUk0N2NJemlKSVY5QUxoQUNXWjc4NHJlWnBUQjBvSzZi?=
 =?utf-8?B?RzVic1kvS0ZFeHErWFlSVERjU20xaXNsckNoZFplMHZmZ09oSEpvRHpJTkx4?=
 =?utf-8?B?dmZEOXpjQi95TXd2S1A1SnlOV09RUWZnTlJsajFNMkhHT0I5M0VnM0hFemxy?=
 =?utf-8?B?WUg4QU5SMUNWTXNYcjl1cGM0VXUxV2k1Z0h4WGQ5WXpsblFNdGlOUTFMZHFo?=
 =?utf-8?B?eXNDMHR2eTdlLzZkZkZsUUxYV1JzWUtjWGE1dDl1YUVwYVN3NVJVTmRJUEha?=
 =?utf-8?B?SnRadHlPWHlna2JjVk9FelkxRVJDNTRaWGVhUUd6d0tuc1B0QklUQ0QzaDJu?=
 =?utf-8?B?MGtXYzRrOFNkWDM1UHVaWElVZEdIcFd0ZTVtVFI2VDlKekFwMll4cVRsK0Q0?=
 =?utf-8?B?U1BTRXJiZFh3ZTcxaGVlZVRpb3BkKytjanc1RW9RYnFaV2I5YWRNVDJPMHdx?=
 =?utf-8?B?SWtReDI5aWk4Q3BWNUNwUitscUw3cUdYTFIzbUlvTDV3dGYwaFkrdmc5OFQ2?=
 =?utf-8?B?WFhaUW9PdnZoaUYxYW9FSXpnZnJzNXQrTWNrbnNNTlBja0lmY09helgyNENa?=
 =?utf-8?B?bVJlaXlOK1U3dm5rZFUraGp5MDg5ZkNDRWVXU0Fjb3JJaktNM00wSnd3aXdW?=
 =?utf-8?B?aThJVEdGeVlnQ1Y0VkJGUzdoWTExbWtrOFZqdklrSEFUNU03dWJka2ZxcWtZ?=
 =?utf-8?B?VFlyc2JYaVYzV0hYR3dmTi9MUngvWlNPZkVSdmpaK0xRK1ZkeDR0Z2V5MkQx?=
 =?utf-8?B?a0lwQ0JBcTdacUxQYjhmVHdxSm9XSXJMRUh1bzErQ3ZtSjEzU2hhcWJsWDBS?=
 =?utf-8?B?TXJheHQwc01RK0RGZFlMc2ZsYTZvcVlmYTdFODR6VEhIN1hpdjNCcS9oQlVY?=
 =?utf-8?B?UnBSVE9NQ0hvaDAyVStHVmJyTjhMOHFUdzlvakRmcmp1Y21XWVFrTk9uaXUw?=
 =?utf-8?B?WGNtV2VWTFA0d3dUU2RZNnhSYWxSaHJDbHFWcWRzWnBBSW5aQjVzZUJ4TVBS?=
 =?utf-8?B?ekVhTHhVNUxHK1NIcjZBTzN1cUUycmlxNUYxQlR4bUw4WGlxU1lJK2lUQm9y?=
 =?utf-8?B?bFRJUkFaQWRnT0Nlb292ekMwSEJ5RGErR0xWYWFDRG9LaWlkZVNnQ2VNMk5a?=
 =?utf-8?B?V25PM09KVUQ0TGg5WGE3SHIvbXZja0ZKbFQvYjMvV3NNNGw5V3kzcU5BR2dX?=
 =?utf-8?B?NHl4N3E3Vm5UME03N0dVc0JnVjYrOXcwU09qK0oyZlFSeXhzUERWaVpaR2RO?=
 =?utf-8?Q?cKtAH3pJDWYYfY7X1ykHF8wUOlnX8SQT?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Q3NwdHNRSUR2a0g4NWFBQnU4SzFtTGJ4VUhob0RsL0VuNC9MS0xvNEtIaHE5?=
 =?utf-8?B?VWdMUVBJSHZLdUY5bnFuVFVma3FSNUJxYUFza3h4RkM4Z3hPRE5GRkZXM3VZ?=
 =?utf-8?B?VWlqbnBFbWhWNTkrQmhnbDFVMTFwdWgxNU5PcVRBZytWbmFBTUNlQlEyazFa?=
 =?utf-8?B?U2hJVTJVMXlQVHJuRk5DaFRWMHJqcngwRmMydXdNNklrWU5RSXY4allCNHBw?=
 =?utf-8?B?eHhhWVFEWGlNSCtWNzNiVnU5VFBpVm9KWmc3eWV0cXpCQlVEd0FxdWhQUXdl?=
 =?utf-8?B?QjRjRjB3RGxYMEZXWVpXd09DNERSSFdFSys5Z0UrUVBuYTA5VS9GR3c1MUlB?=
 =?utf-8?B?R3JIYWZ2MFowVmg0aXE2YWZWN2pTRjRUODQ2bXRRL09JME1JcWVUeVhML2Z4?=
 =?utf-8?B?MDVJLzBraWRRZFo1L1FpVXdtTXNGSTg3VWFESlNLNWsva1crNUlaL3FkeFhO?=
 =?utf-8?B?R3VUejhwd0hKRkxhTjl2eGVFVmszdWQ2L09zN1FQSmJEM3JydWwyN2thV0pv?=
 =?utf-8?B?eTRiMmRGOWZYN2p1ci9VKzdjbndDNkg3VjBGdkNZc1hZZE44TUtPRjdETzFv?=
 =?utf-8?B?ZU14SUQ3aTBENVcyaDQ3WVVHMEcrZG5NTWwrQnVQZy9oL3dBOEk5cmtNc3Fu?=
 =?utf-8?B?Y05aMXo4dC8zaXkrbnUrNVByY3prYkI2K1VNK1dKbHFTa3BxNXhuV2FPOUFs?=
 =?utf-8?B?eWtORzh5NmtId2tyQkVQam1DaTBKVFhRL2xOMndSN1NXL0JydVM5OTdvNnc2?=
 =?utf-8?B?UFRsODZxdkpxeE44aEFXM3dyK056SGRKVDA4R0gxL1oyUTMzK0U3RVliVVVu?=
 =?utf-8?B?Y2xmbTV4T05xaWJKTGxYQ29nOU16SDBoUmQrY0dUWTkwWlJnRkwvK25wczN2?=
 =?utf-8?B?QTNwSGlHdXNuMGZBWUdUR0Z6SW85bzQwNml1TWNEeVM4a2JhKzBNN25DemUr?=
 =?utf-8?B?ZFl5bUFqcjUwUnpMeGJNdHlsbVFHb245amd3VURSSW92YUMwNCswUUc3c0RN?=
 =?utf-8?B?YThwYkExeE1WZG1YVmliUGdrdWFaMWtsMzlTa3NwbTlSa2MvM1JXY29NRjE0?=
 =?utf-8?B?WmorTGFIbTNSVlNMOERBRHRiM0FFSnl6Ulo0OWNqeTQ0dVlXQmZrL252TzRQ?=
 =?utf-8?B?Qkc4NXZadWtVUkxSNENzWjlzS0Jzb05GUVo3MEc0Nm1EWUtZOCtvUXlwOXZu?=
 =?utf-8?B?S0dMNjZWT3NPa3dzZ1V0aUNWNGd2TlpyQWhKSUgrQVZRcFJtRlZhbFQ5cFJx?=
 =?utf-8?B?Z3dNb29jdXJIdGovbVVFK0JYYzVUR3NNZnRIamYrem43Q0JaREUzaHpuaXh1?=
 =?utf-8?B?aVJpYWhtMkdSbWJpeFFjLzlGaVlEeVJZTVF3UlNMMFZoZmdGcTRsQ0Q2Y01N?=
 =?utf-8?B?TmxVbWIvNjdQK29OMnBwWGxKaThERFRtemtOLzdJd2p3L2htMWMvUDhCb0N3?=
 =?utf-8?B?YVpiU09GdWw4VmZ6dGpkOW1iTHVKNzNYYWdhdU1GckVSWUM0Q0loR2o3YTZm?=
 =?utf-8?B?eUFNZm5nalhEWkpkOHdSU1FFenRHSDc4SHJwVVZHYzRJanN2Z2twVEQvUG40?=
 =?utf-8?B?MnI3aGozQXpoZW01R3dacUVkcjhNTjBWb1Azb1dERXYvWkpIRi93bDVzb2dz?=
 =?utf-8?B?Q1dXYzV2VHVOQzRrQ2tDOWVLMVJ6MnNjTFVLZVlWSHdaeTVFcUhMcEVPbDhr?=
 =?utf-8?B?SlFISmpSblp4R0xwbFZFdFRsSVI1S1Z6Wm9qditOZG1kRHcxT1huZFdXOFJM?=
 =?utf-8?B?YXlWNXd2TzkrbW9yVDFFcXZFeDNtQU14NVY5Z2xGWlBCVnNDM3YzcHlTY2ti?=
 =?utf-8?B?WkxuNlk5cFFZcjYrT1B3WFZRdlBjZWtvM0ZBWGNoRWNETGxWMjhmN2ZNS1hl?=
 =?utf-8?B?alRYQ2NWa2NodFc1YklJZGJTMVZKNFpkWDBuVFZSQmN5cWVmVFBrRXBla0hW?=
 =?utf-8?B?RCtwRGg4YTU0aUpBR1pXbkplQ1FCQXVFb0ZJNlA2eHJHK200c1lHQTExN3ZL?=
 =?utf-8?B?WWU5S1pmMGdOamE3Sm4xcU51R2w5eXZUdVB3ekJLYkE3VTlSWStCSGdTZ01x?=
 =?utf-8?B?RUpGS20wd3dnbERHZW5xVkZZNHg2UFo2cVM0U1JmWTVoNjhoY0doS0hrYy9W?=
 =?utf-8?B?dWlFb2xvNDRSOUFiOU94OE9CM2VLR3BVb0tMbnhzVGdEYUM4dUdMWWtKYjVS?=
 =?utf-8?B?T2c9PQ==?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	9OycWW1tZKEZnItvT0ci2IAE15Mq+UGBIeE6oZhT/Mgg/dNIshZl1MV8wwCGsj8/qQlnsASV7TG/zmUqLfj1yNL6RmCZrwKsOIgBJ23IQyWrGkm+aVPVFmbk3OKR1WTX7PUlmaz/43iv6eq85mEZGjRGGriABJltpR1xQ9SLllgqXHrmWAeZguKHJsXOlbRJdddGZrLGBP51ppg0S9mguAuo96w9yEd6WcV4n9L6T+SxipV+IFtUKww0JOyEF00hGl3fLudnK2LAalQDtvcHEmrXn9tSdeKc8Ye6i0IuN4TWQxNI9qXGttDonWxNbfcb+2nwTL54QVQXvaQ2fdl3r6HKqb3IgpiiQJB4N2EQQ0ic9dLvVgIqyJ08nbHt4oJOHPt5aa++KjYCeBTc0wHtKeKprSuCt3NMJRyrHFIROMyGfYc2aNKJILPM6XOfovxczyDW/p6EfN5xppvrhSuD5sg5jvUqPulE7Gdi9zIDUM7N+wI5+KJUknCAOhjE1CoMX2OWChJ0VF0UzLOfcq/b+vHrZZK+u0vWCZ4+JkilJ9u+kO6mlOgPw5BbuwWL//VZ7lu5zq+g2p4CEeq0aCpd1Dxos6zF4yd5QtCLxPGSH7E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d205fc9-0998-4e3d-d519-08de3f05ee01
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Dec 2025 13:53:03.5776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MmQRN4qyVf1M0dVJq3crBN35qWs9zUKhailW0zgpZfyETIS8fCg7SjRxM/UihNaVy8hx+6lu4WBU0jMid5P4TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR10MB6281
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-19_05,2025-12-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 suspectscore=0
 spamscore=0 malwarescore=0 mlxscore=0 phishscore=0 bulkscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2512120000 definitions=main-2512190116
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjE5MDExNiBTYWx0ZWRfXwlNPRtoobt7N
 R7s28xjg9f+QVqeWcEQSwwESvAzEwl9dqwH0g3Tc4u1XdzSaDG64wlJn8hhXXSo1BxmluPBmMxU
 ShIQHyzDzUWHzyW0oTRwh2OktuAnL39U45qV5sQq/f+8McTAUkwlUZRm2OlaPQjC68vz8lDbPuD
 N4I7VYET4lIYwUG7LXuz3f+IgedRphrVlSBTVlnShPEQ3qo948xpaAq4HElQC1WS0BcLOsDJBW3
 oGgLIH2v3IgdLBH2RSBpz9k3MIpILYJ7xXJiD34W39Cco3zX8lnwqEbARA6zW8OPqD92LIuCCJ/
 WNeUo/X3ZApsiEWisoHLKTB60oYtCL+LXBacNhiTovsgJ2y/jP7wdEIEsvwba2bgHgfmWFzDIMl
 WrlHIETvSU0Z7GkNqwDTU05KnmmjIQIswpaG6xOV5kErgcC0gKiNp85p8cq28mj50Ipfa+CWmPA
 IPj81CPQ3GTxaE9rubhnbuZpnztT4+qVR3uwlxao=
X-Proofpoint-ORIG-GUID: skgTfJ1s2W0tOJsxdtHgx-aJUcov-LMp
X-Proofpoint-GUID: skgTfJ1s2W0tOJsxdtHgx-aJUcov-LMp
X-Authority-Analysis: v=2.4 cv=ObyVzxTY c=1 sm=1 tr=0 ts=69455a79 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=wP3pNCr1ah4A:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=ZGXszcIHFvZlrUND9owA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13654


> +}
> +
>   /**
>    *	ata_scsi_translate - Translate then issue SCSI command to ATA device
>    *	@dev: ATA device to which the command is addressed
> @@ -1714,8 +1738,8 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>    *	spin_lock_irqsave(host lock)
>    *
>    *	RETURNS:
> - *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY if the command
> - *	needs to be deferred.
> + *	0 on success, SCSI_ML_QUEUE_DEVICE_BUSY or SCSI_MLQUEUE_HOST_BUSY if the
> + *	command needs to be deferred.
>    */
>   static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>   			      ata_xlat_func_t xlat_func)
> @@ -1724,56 +1748,46 @@ static int ata_scsi_translate(struct ata_device *dev, struct scsi_cmnd *cmd,
>   	struct ata_queued_cmd *qc;
>   	int rc;
>   
> +	lockdep_assert_held(ap->lock);
> +
> +	/*
> +	 * If we fail to allocate a qc, simply return without reporting an error
> +	 * as scsi_done(cmd) is already called.

nit: I find the wording a bit vague here, specifically "scsi_done(cmd) 
is already called". Can we explicitly mention that ata_scsi_qc_new() 
would have called scsi_done() with an error (when we fail to allocate 
the qc)?



