Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA77A14659E
	for <linux-ide@vger.kernel.org>; Thu, 11 Apr 2024 09:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712829436; cv=fail; b=H05F22FqIqcGo9MC5ldSzSaargFnyOxH85lSSOd6txnFmwHRZK9fhxkqKsiy2hKgHy27K3lgWr58kek4Qp9j78nvODq4pE8cDq8LH0SvpE9QXgR2MUogSgj6BxDCPMbkD8kqX08BgAnqQY1d3bEH3aYsaKonpcFF9+P3GgVRjr0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712829436; c=relaxed/simple;
	bh=9FuAxbzjcg1+Owrbw6pEzxn90fxVzi/VjyIvQwoUrQ0=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H2DwvW5nlaXYYbnMClkiBdVSqqMdgxLSOhL08A/56dFidpbisIObSP6n7vSn0HqNNWsdzF2CiHct/M0K4QhDurjEVwCX3d1esRo+3cGYqSy9p0ffsQZO8/GzbaJ8+ON9O4YUU9RgCvFQZRQrcgmQi5PF14WoPsgGK4PhnotBlt8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=HIOathYc; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=UJWz7WZK; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="HIOathYc";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="UJWz7WZK"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 43B91Pid031444;
	Thu, 11 Apr 2024 09:57:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-11-20;
 bh=Fb0cBxUxuN4Sxhl+Om35G6cFjC7Xc15xLSONZQOjmsE=;
 b=HIOathYcH/GcF/HlrqU4x6OL/9PVrMfy1UljhMoJg8KsEwM4bj8KnmbC9GcXfvywDEbx
 6Tke6GCg44tOTtYngNtTRmEPuTJjzZxHg0TfCxDD+sWEMkdbdqC//JtkHWnKLU2ZqxPj
 6nHjvtC8x0WMWkOD1ybSaXIWcMaRhdgRR6m6Znq5xM5KlvgrROudCSAMWO0W5ygFgj5w
 597ebTmXNJJ2dK6yPge9FHLXi4Il0S3bJ7BPhrhtvU1fhHhk9y+bM4Xf7+lJ8zir4LL5
 /BSwets3xW/pXFeix1hkUIWA+RH7OV7bIgwMdBm/JNFfBTcaEQVpnvdvjB5KV2JMPYf4 Ag== 
Received: from phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta02.appoci.oracle.com [147.154.114.232])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3xax9b94f1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 09:57:11 +0000
Received: from pps.filterd (phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 43B8MOWY010535;
	Thu, 11 Apr 2024 09:57:10 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2040.outbound.protection.outlook.com [104.47.51.40])
	by phxpaimrmta02.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 3xavu9agg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 11 Apr 2024 09:57:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mqaTx5FFzSEtzQEvicl9Vwjj2FuSF58Hw7ZGkh2skWFp449SVc4870DfKJRLTRlRypY0JY2Qyz1H5k9bqyPz/2jQog/Ztp3xXwrfF0JF4FVh/eBN9QCqOhH+FUhmrlmCwSAYzwdaHOxkPz2tu4atEEA447z+8c+Zjv7NQyUkIfpe3WCrsrLIRR84lh24Ieh7kk6LwgKBPH3WFRzsCoNn+A4QG32C1zdh9sHordRFPMcrIglVorwnv8izKkXSgSJzgEmrIFw5xGUyQu0ziVh+RDjLfEReW/zRwYSQqeVuiKs1C66lKSTowy/bXyKgrU1Syt/p1GZDSazjBpewt5HiIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Fb0cBxUxuN4Sxhl+Om35G6cFjC7Xc15xLSONZQOjmsE=;
 b=BUH2l5N2AupUXpabukOk/Xdp920YIwGb5WirWZUUKK7ucehBG3iGQqDqg2D0O65GgBgsFAC3Ovq4leiblxVuqWbkpZIXgqx4eOquokJPdrO3MNlVP/XfuRor0BjN+pBVNbIElIZ/b+thjb4iSCVuRhUF1VfgTFbi9+mURK3rGEOdkfQjlHVKiwgzkW/edORzh3eJG2MuS8un/R55H497MBpchEuQBDQ5jRQZMKnL26KACxDszD4+hgfAxI3XG1G9DqpFiB/2HaIxCdE3pd/NCcnZPvbCigFW1NmUptRpZC5P1L7eVma3ph87+OrCc3MwDgKbUQKii87hmJ2Tq0ZUBg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Fb0cBxUxuN4Sxhl+Om35G6cFjC7Xc15xLSONZQOjmsE=;
 b=UJWz7WZK33VQKsMzmgymogYUCuskVGNp+6sQkwu1uKBRNB/9GuZ2qYzNBZ2EGLjxeb/KhQhx7mir3o1BXQhRHAMfXTGe1qjeniCCQ8la+r4eutQ8pD9guTPbsU1/nNDiY6gZYj4AjGTkq6va+8pjYOrBT9f0TW/Oe9wHIYt8q9Y=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CH3PR10MB7985.namprd10.prod.outlook.com (2603:10b6:610:1bf::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Thu, 11 Apr
 2024 09:57:08 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::ae68:7d51:133f:324%4]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 09:57:08 +0000
Message-ID: <4b744c8b-c4b7-47a5-b015-2546ae9df293@oracle.com>
Date: Thu, 11 Apr 2024 10:57:00 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ata: libata-core: Remove ata_exec_internal_sg()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>
References: <20240411083158.723212-1-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240411083158.723212-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SI2PR02CA0021.apcprd02.prod.outlook.com
 (2603:1096:4:195::10) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CH3PR10MB7985:EE_
X-MS-Office365-Filtering-Correlation-Id: 21d5a5e6-4bff-409e-4126-08dc5a0dbfc0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 
	ebJHFf2jbs00I7lCehMwQ2ByAk5vU8/rhcMofU1S81JWDAtsSRjFPUIPsLEo3bNvLLXzznNd5eQR+S6fjPmtfk4xgTIm3qeE7ANoV+yH3ipVmOvbzcrWA5Xet0TTjRmeXYO0d9AHGG+/DuPAoCFw5mwsL5yWJeFhobY389jS+asqjcC7AMLtTUtI712yOwJWPknTL72kjkXwzkRdULM95guTtBbPRUpOe8sXebSknsRTQPY41W6KkA8aJ01N2WPBD5rRS41UMrkrHp9fsh+9v+9dk6CWYr7wQoYw9u73YVHFvmWN8ZmqTrlnvicxkWQRHuZUzYsuivvyb9fCWrUfTeNs1Uyz7J5sG7BAww9Nx7dw/1RMU+OIRjFgZgPcrQHY2nQdxZXRWL16Wn6vqq61li4lC27QZ9IfJ1I9D/6n75CLgnnSDm5R851VjP5RPLiRVOeMSnfQ49SmedilG1P85CddO6pztzqV2SmQF/XkHnCjk8CYDK36vgFAMGuYt2nLlbM3uqNiJelMGbPPN0AGLRvqkHSgSbpOJVnNOJKbdYXEEv7q3Vd11q6oYm2fhsGK8TDeptp17U7YmsUIG6bdU4/Ue8v0x2Hv5+bJM3ys+7BLYkRKWkQXVj3umWfphBCHydIcOHGXqY5uh4Qo5tQFbtuqDq5FydHtFcUuxRyECx0=
X-Forefront-Antispam-Report: 
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 
	=?utf-8?B?VUtrR1Y1YUZYZlArc3A2UzVNYnYwSnJxUWFOS1dKS1d2eWE0bjl1Y0c5VWpo?=
 =?utf-8?B?NkMwWERieFA4ZTcrcFZVaWFUOGFhVjkwNkdzdWlnWUxUTlJEbk93NDJiQ2Ri?=
 =?utf-8?B?ZmVPSUlReWxiRjA4ZlRPR2g2ZXJGUDBIeXJXM0svMlVIWGE1TFBXSW5ORzFW?=
 =?utf-8?B?bU5yZzY1OWFoeUdVVTgvcXQ4eVhWeFFOWUJodTRPWFRud2I4NVFDWHZaWHU1?=
 =?utf-8?B?ZkN1eDNRSDIwN3FmS2tVNjRHelpWQVhxZ0FCTW1YSFJKQVFZZHE1NjBOdldr?=
 =?utf-8?B?NzZ0cDduZGNyNmdqZjlra3N6ZDkzaFpMVTRKcEtKeDdSeGVDQzFuWDAwbHVC?=
 =?utf-8?B?Uk5TcUtkYUlydDhIQTZDSFBqRUs5OFFzWnBUWWJBYzZ1ZXJBL1d0TnZzVCtw?=
 =?utf-8?B?TXc2elBOa0dQN1U4Mmw0KzZaay9xaWZJQjVGZVRnYUR1bHA5cURMNWo4bCtP?=
 =?utf-8?B?bTNCa3JJSFF6aXBPWkxrQ282VHpENmd1NDljc1B2WGJaZytYbmJxYU5aekV0?=
 =?utf-8?B?U21rdDhLVUVPK3F4YWJPZStWbE9CNFZEVXllMEp1ZXMwYlhoL3dCS2FTcFpI?=
 =?utf-8?B?Z2hXSEowVnZsdDRLRnhVM1hnM3hpRmE0R2NGa3RPZXdQeHpnM0VBdk9ZYWpm?=
 =?utf-8?B?amt2VGd4OVhXMGZPMU1naU9GeG95Q2Nvd2JoWWUvT1pOc0ZBMHNLU1BJUWNm?=
 =?utf-8?B?Sjd5OWZicmlDOFFtRlRtRHRXREwxaGJReWZvUURQbUJCYVNpZUE0bXYrcXl3?=
 =?utf-8?B?MEJDL2twdlBCQ3EyNm01bDMyTmJ1K0FiN0ppSkJUYlVnNlBsdHc5WXdPeHhj?=
 =?utf-8?B?dTVpS3BKSUUvSjQwNGt3RTluUnhhY3BnbWw2cTNPN1RtVEVqRUJVV2dTSXpk?=
 =?utf-8?B?b2pnaDJFaTU0bkgzNFhNcHYyd0dTUytiV2tGZXZHbU5yNFZUZHlhRGNIL2sr?=
 =?utf-8?B?eWRXdkpOR3Mva2JSN2xlNkxLcVN3ckdjdEFaSE0zYndxd3NjVi94TXFucUxE?=
 =?utf-8?B?SXZEckRVMndIaXJ3aU10dUxZaHJaMkQ0bEF4QUtLN3RDZUs0MG9SNjdkNkRm?=
 =?utf-8?B?R3E3eGs0bC8yQW5OdlpheWFqUFgreHRQUGtlQ0dXODZLVk0xd05Cdk1KOFRU?=
 =?utf-8?B?aVViUGhGMjFCVUxobTNKMVYzVFJHTDFPaFNqazRiVDlJNGw3dGVhaU1BejFJ?=
 =?utf-8?B?SU9FeU10cjBKT0dhMTE3VG45TEVSdTllcVdYTWNJT1pQVGRMTkpIUWJNL3lt?=
 =?utf-8?B?RVVYYXNTYlpvamJTbGxsUjdRQmF0MWpjTFJwR2lIc2llMkN0bm1NMjhmRVNO?=
 =?utf-8?B?ZXdKOEwvZlJMSlU5RFNSVllQeTNPQkMrOE0rMm5LR3pvNUk4Rk5SQUZMMWQ3?=
 =?utf-8?B?OUk5YXVnOGtEOXJkRTlzWGtXdE9UYnU4eldsYWxncDltY1Fua2RJdE1FdW9C?=
 =?utf-8?B?aHZZOExHdjZOaWRNQm1xRjRTaFdidVhCYXpDUjVVZkx2bzhxcUxLbkJycmFS?=
 =?utf-8?B?WUYxOE9hblZiMjBVZDBlL2NuNFFpaVJ6bHV2YmRZMk1BVFQ0di8yeEhOMUVD?=
 =?utf-8?B?RVVVTEFueVNma0ZTYTdOR1ZWL05GV3NlK3pXNUtrYW0xMGJ6UVdRdE9DUmVQ?=
 =?utf-8?B?WktyZUpLSDV4ZnBZTXZ2SGprSkhhSTUwOTNCOGNkM0N1S2hTMnFMZGsyL21t?=
 =?utf-8?B?MHFYTnFtQmp6UlEwV1BoYTNreVhJMitEZUtpclhnZVIzUTh5T0NlQzZQaE4y?=
 =?utf-8?B?c252RGdwOTJyVUdNdmMweVppVnVsZk0rUEhOd3RGNThCRENXZU1SZ3J5ZmRO?=
 =?utf-8?B?c0Z6Vk0xdnVpYUZFeFhZbnB0SWpCcncxZDA5cUg2bkJrVWdnV0l2S2tuejR0?=
 =?utf-8?B?SjVPQ3p2eXpNaWs0RGJXMCsxZ0tyRlN5UE9JMEZvVSs3dkVXNHo0dkJOemJJ?=
 =?utf-8?B?RUNFUTNIMHlHS0NiVWFRNHQrd25ZTVB4a3llQ1lXaFdwdHB2d1FzczFvV0VH?=
 =?utf-8?B?bEQreG9aN2tNM2krWG1oOGY5SytDSW9NQi9JcmJqMDRYSTl0QmZQZ3lZNlQw?=
 =?utf-8?B?R0lMQ0UzOFdRNGVVbUtyUkxPQ3lDczFZUDRBOWZSdWx0OEtocDc1cERHUnJ4?=
 =?utf-8?Q?c2pnM8c3cFH4LY7wamC2SNU66?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 
	jsv2s6fp62q7+TtRXdRjZnYhPJyaekuHfFwVDWazhCAcv5EqY+mgtuXKhceA8J+/l4p2CspnH2fl8l5Nbx2hT+pLMsv3bw4aARpoAlnCsKKk1NVTKCTOz3LjDLoDv/qvBVEmRr+54JuyGbN8oNlsKcrFF+vlJrBJSqHOONOubIy+I5g5pRPL/4fJpzpDYB2AVH7EhXT4+MrvGxljOVI3TUqX0U75wb70ojac4GNoS7dBE6VvtYWqmxPe6P7B/LFCCAppoO/sdpjhkLn2ZEKPjcuzpGRGUtlohBmhFWPheseon8NzF+vTh8dHPHBUcxD1ANHZBlKqYD1W26CEzVPOpWhCa4K5+mhZ8rkU9uQfnudTUc3vKA5zkcC4spPWNuewffqEWs6SbjbJfvMero1KowjB2dDrF5zW2lT3oNUm+XOf67ZSfgARCb0nhCS/WZKeX2JspHSV6o0gOZKA1AC/7lB1t6iF77WM3Q3jfH5b8SfhsHHhJUTfRvOEpcPjQMCaSg/iOKIwdAi0WWizJdIiFPIfU/BH8Cf22b+ieJk71LGTg+ve6Vjd+RTeWgMoBdKMLGrO1A32eqVY6nQwVKVtT++Wpiloxg5p25rn3IegLxg=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21d5a5e6-4bff-409e-4126-08dc5a0dbfc0
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 09:57:08.0715
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1b4Ql41Bz1AywjM7gOaZ2tUHVB4BOMZsPkevnlYKt0Uc++3pQ1wq1kjQ9ocV5YgLc3SDCHyZuS6BMUgyKPYCXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7985
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-11_04,2024-04-09_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 spamscore=0 mlxscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404110071
X-Proofpoint-GUID: tDCpCHydxHF8oK3pU0O-soApe4RpC2A8
X-Proofpoint-ORIG-GUID: tDCpCHydxHF8oK3pU0O-soApe4RpC2A8

On 11/04/2024 09:31, Damien Le Moal wrote:
> ata_exec_internal() is the only caller of ata_exec_internal_sg() and
> always calls this function with a single element scattergather list.
> Remove ata_exec_internal_sg() and code it directly in
> ata_exec_internal(), simplifying a little the sgl handling for the
> command.
> 
> While at it, cleanup comments (capitalization) and change the variable
> auto_timeout type to a boolean.
> 
> No functional change.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>

Regardless of some minor comments, below:

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/ata/libata-core.c | 105 ++++++++++++--------------------------
>   1 file changed, 34 insertions(+), 71 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index be3412cdb22e..ec7e57a0f684 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -1480,19 +1480,19 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>   }
>   
>   /**
> - *	ata_exec_internal_sg - execute libata internal command
> + *	ata_exec_internal - execute libata internal command
>    *	@dev: Device to which the command is sent
>    *	@tf: Taskfile registers for the command and the result
>    *	@cdb: CDB for packet command
>    *	@dma_dir: Data transfer direction of the command
> - *	@sgl: sg list for the data buffer of the command
> - *	@n_elem: Number of sg entries
> + *	@buf: Data buffer of the command
> + *	@buflen: Length of data buffer
>    *	@timeout: Timeout in msecs (0 for default)
>    *
> - *	Executes libata internal command with timeout.  @tf contains
> - *	command on entry and result on return.  Timeout and error
> - *	conditions are reported via return value.  No recovery action
> - *	is taken after a command times out.  It's caller's duty to
> + *	Executes libata internal command with timeout. @tf contains
> + *	the command on entry and the result on return. Timeout and error
> + *	conditions are reported via the return value. No recovery action
> + *	is taken after a command times out. It is the caller's duty to
>    *	clean up after timeout.
>    *
>    *	LOCKING:
> @@ -1501,34 +1501,37 @@ static void ata_qc_complete_internal(struct ata_queued_cmd *qc)
>    *	RETURNS:
>    *	Zero on success, AC_ERR_* mask on failure
>    */
> -static unsigned ata_exec_internal_sg(struct ata_device *dev,
> -				     struct ata_taskfile *tf, const u8 *cdb,
> -				     int dma_dir, struct scatterlist *sgl,

strictly speaking, dma_dir type can be enum dma_data_direction

> -				     unsigned int n_elem, unsigned int timeout)
> +unsigned int ata_exec_internal(struct ata_device *dev,
> +			       struct ata_taskfile *tf, const u8 *cdb,
> +			       int dma_dir, void *buf, unsigned int buflen,
> +			       unsigned int timeout)
>   {
>   	struct ata_link *link = dev->link;
>   	struct ata_port *ap = link->ap;
>   	u8 command = tf->command;
> -	int auto_timeout = 0;
>   	struct ata_queued_cmd *qc;
>   	unsigned int preempted_tag;
>   	u32 preempted_sactive;
>   	u64 preempted_qc_active;
>   	int preempted_nr_active_links;
> +	bool auto_timeout = false;
>   	DECLARE_COMPLETION_ONSTACK(wait);
>   	unsigned long flags;
>   	unsigned int err_mask;
>   	int rc;
>   
> +	if (WARN_ON(dma_dir != DMA_NONE && !buf))
> +		return AC_ERR_INVALID;
> +
>   	spin_lock_irqsave(ap->lock, flags);
>   
> -	/* no internal command while frozen */
> +	/* No internal command while frozen */
>   	if (ata_port_is_frozen(ap)) {
>   		spin_unlock_irqrestore(ap->lock, flags);
>   		return AC_ERR_SYSTEM;
>   	}
>   
> -	/* initialize internal qc */
> +	/* Initialize internal qc */
>   	qc = __ata_qc_from_tag(ap, ATA_TAG_INTERNAL);
>   
>   	qc->tag = ATA_TAG_INTERNAL;
> @@ -1547,12 +1550,12 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>   	ap->qc_active = 0;
>   	ap->nr_active_links = 0;
>   
> -	/* prepare & issue qc */
> +	/* Prepare and issue qc */
>   	qc->tf = *tf;
>   	if (cdb)
>   		memcpy(qc->cdb, cdb, ATAPI_CDB_LEN);
>   
> -	/* some SATA bridges need us to indicate data xfer direction */
> +	/* Some SATA bridges need us to indicate data xfer direction */
>   	if (tf->protocol == ATAPI_PROT_DMA && (dev->flags & ATA_DFLAG_DMADIR) &&
>   	    dma_dir == DMA_FROM_DEVICE)
>   		qc->tf.feature |= ATAPI_DMADIR;
> @@ -1560,13 +1563,10 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>   	qc->flags |= ATA_QCFLAG_RESULT_TF;
>   	qc->dma_dir = dma_dir;
>   	if (dma_dir != DMA_NONE) {
> -		unsigned int i, buflen = 0;
> -		struct scatterlist *sg;
> +		struct scatterlist sgl;
>   
> -		for_each_sg(sgl, sg, n_elem, i)
> -			buflen += sg->length;
> -
> -		ata_sg_init(qc, sgl, n_elem);
> +		sg_init_one(&sgl, buf, buflen);
> +		ata_sg_init(qc, &sgl, 1);
>   		qc->nbytes = buflen;
>   	}
>   
> @@ -1578,11 +1578,11 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>   	spin_unlock_irqrestore(ap->lock, flags);
>   
>   	if (!timeout) {
> -		if (ata_probe_timeout)
> +		if (ata_probe_timeout) {
>   			timeout = ata_probe_timeout * 1000;
> -		else {
> +		} else {
>   			timeout = ata_internal_cmd_timeout(dev, command);
> -			auto_timeout = 1;
> +			auto_timeout = true;
>   		}
>   	}
>   
> @@ -1597,28 +1597,29 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>   	if (!rc) {
>   		spin_lock_irqsave(ap->lock, flags);
>   
> -		/* We're racing with irq here.  If we lose, the
> -		 * following test prevents us from completing the qc
> -		 * twice.  If we win, the port is frozen and will be
> -		 * cleaned up by ->post_internal_cmd().
> +		/*
> +		 * We are racing with irq here. If we lose, the following test
> +		 * prevents us from completing the qc twice. If we win, the port
> +		 * is frozen and will be cleaned up by ->post_internal_cmd().
>   		 */

Personally I would put the spin_lock_irqsave() call here, below the 
comment, but really not important.

>   		if (qc->flags & ATA_QCFLAG_ACTIVE) {
>   			qc->err_mask |= AC_ERR_TIMEOUT;
>   
>   			ata_port_freeze(ap);
>   
> -			ata_dev_warn(dev, "qc timeout after %u msecs (cmd 0x%x)\n",
> +			ata_dev_warn(dev,
> +				     "qc timeout after %u msecs (cmd 0x%x)\n",

is spanning an extra line really any more readable?

>   				     timeout, command);
>   		}
>   
>   		spin_unlock_irqrestore(ap->lock, flags);
>   	}
>   
> -	/* do post_internal_cmd */
> +	/* Do post_internal_cmd */

is that comment useful? I suppose we have many other verbose comments 
already..

>   	if (ap->ops->post_internal_cmd)
>   		ap->ops->post_internal_cmd(qc);
>   
> -	/* perform minimal error analysis */
> +	/* Perform minimal error analysis */
>   	if (qc->flags & ATA_QCFLAG_EH) {
>   		if (qc->result_tf.status & (ATA_ERR | ATA_DF))
>   			qc->err_mask |= AC_ERR_DEV;
> @@ -1632,7 +1633,7 @@ static unsigned ata_exec_internal_sg(struct ata_device *dev,
>   		qc->result_tf.status |= ATA_SENSE;
>   	}
>   
> -	/* finish up */
> +	/* Finish up */

