Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14A93282F04
	for <linux-ide@vger.kernel.org>; Mon,  4 May 2026 07:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879662; cv=fail; b=DKoihv0/JHRXvzZRZ7z5K9LirF96cdm8B3J15/IuLxPF5VfgAW9EmexHBdiy4l3uRFBQNSfSMny8z3FMVrCCPx6KaFoYaMFa5xnyEqtQqrMHtFlHxZeWjXQ0fS2//hC3Yznl6nYgt3G3Vr8RD4M+avLY/BXeivLs3s53mVAj3Ew=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879662; c=relaxed/simple;
	bh=fGcw03tkLfHuB/Mn7xzfoD84cbSxo/o0fPXvlwYse1Y=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Fmk3hJaKyHVepoLqFY5cc3OqtISFcA75Af9/a7EOwzPTSA6NL8oRkJn1O24YbCYhKnD11xhDlxd4SZy9gU4QCmMiUxdBiccYCpYw499pVa6CNvTYYdehQN2P3Rn6zp56PEzE2oP8gZyUGmsk3+Z4YCxGQe8NrHFkMyiHWJD6QjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=aT2yBMys; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=F5l8qhe4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="aT2yBMys";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="F5l8qhe4"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 643N250F3695739;
	Mon, 4 May 2026 07:27:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=ZpM82MNErKPyV2jDyEMyxMTxQDPLqqEjLxvt/77KCeU=; b=
	aT2yBMyspqw0cISHvRZid/sxqC8qHT7v+uwyEzxSrT6gN6NXnLMnEfQ1cgXIFVgT
	hIn2yZdkq5aiPPs7KradSo+gh5+msBrekxlHAu8hD7E38Drr+UCgYYLWa9htvcwc
	T5w3FSDTn0HbbHqVOeHlo/VGD8pJoLPp0qoe/1K0mlh0I4yN5dU8nnJfI+YFKsTr
	B2V4eyGOeJKKcga3VfrdDRBQWQ2xBsdA+RzsK2iaggs37MrYCVUtXHfyXTRNNXmE
	Q0CerSZdwbZWIERqV7kf+m/K30+PL5gx66WG3mVwGB1fYAFgEpIgYeg0lMPnXREA
	FFlXrO9U/dV5YvvQGg6eqQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4dw9e4a66q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 May 2026 07:27:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 6447LHhH024024;
	Mon, 4 May 2026 07:27:14 GMT
Received: from bn8pr05cu002.outbound.protection.outlook.com (mail-eastus2azon11011032.outbound.protection.outlook.com [52.101.57.32])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4dx58ynsjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 04 May 2026 07:27:14 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RF0suMLfSiwQ/dEpUrXT7rfjN2t0kLEg0a0q8e9maXjgKX7t+jgXGk+AZF8gjt7WIx3dITjMj9TFeiiaPwZNxemb1NHL2re9qolzv8DpwtjiDQndLIRKrHhvhL+o4/k3pKgMft+ovYHEOnY/liNymYNeFIkYZ2qfdYu/ybOyz+/njYV+jLnxwb9NtJPfnpVuzFdJSmrNbkvOqRcKh0Nz1Dt5LkSPKUQO3O8z6Nida6mF6OgIEmpWi2OkZHUkoNCq0uuvRqswQovY26kEM0yCigwXgme93LZuQeUku6OUKC47AkvO2eF2Bd4FuzilFSixw3qXh2f62GRUOUgvq5CjAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZpM82MNErKPyV2jDyEMyxMTxQDPLqqEjLxvt/77KCeU=;
 b=WEnd/ByFVz1R2uiQtO7izxZGHDbgOCNonqcDQtwOYKtRDI0dVUoq8aaPYLAmvNxv+T0uZdlFoFOLGvbYSHpHsE4mDnxUn3pcFzfgin/1VngmIHCDVLZ+1Ku3yH/QchREU718WDXIul5av7khhYtHWu2WjBzB0l/OjsIelNwbBVYCj1q+1a/z0r/EzzmPXBiz20wQYNDSoITt/NH7L0uBm58W9T1irD80EyvL080y7tEL0ggyr3dRBGRoTUJxv4BddcRsrsRshrNxFHNTmOR2iZbPLYZViTl5k0/BsLTIi74AwRzd0q234cGsJ+x8A59R+8qBxhfBmroELaBhqnt7+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZpM82MNErKPyV2jDyEMyxMTxQDPLqqEjLxvt/77KCeU=;
 b=F5l8qhe4VVf2tGPumWwoA0hIGqc1B8tSD36t51cfDaTsMWWw9H3GOfWrm+PGWTLorGNI0V+mPagJXPfKd2nTaKXQWSkNxAurSuvrrU8q57YAKGGgL55hkLM4hvfrQjGzHOdhsly9qcaGrzC6nu+UuDsSHvgEe9/wwxejEyLdh14=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by SA1PR10MB5709.namprd10.prod.outlook.com
 (2603:10b6:806:22b::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 07:27:11 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9870.023; Mon, 4 May 2026
 07:27:11 +0000
Message-ID: <0f4458e2-cdb3-463b-a25c-5b2147e4e442@oracle.com>
Date: Mon, 4 May 2026 08:27:06 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>
Cc: Tommy Kelly <linux@tkel.ly>, Damien Le Moal <dlemoal@kernel.org>,
        Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org, hare@suse.de
References: <20260501125410.1204490-5-cassel@kernel.org>
 <4be77745-2b7d-416c-b01a-88669d9bbeb8@oracle.com> <afT0INMUg7scssxk@fedora>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <afT0INMUg7scssxk@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0201.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a5::13) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|SA1PR10MB5709:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e38d70b-8d4e-4357-aeaf-08dea9ae8e72
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	jVW+/pN5mwvJ8Gg90ZNA83bsaPz1nVOgrZSuqcVSfx/KMNcRD4Ah0a+qWkqy7CIcTRK0qrIwRWye1/bzUNU/KRuyjfWoZsXjTRjc4Ou20Fc7Q5C/M/zHLxPcIrwr5Zb19xiJ6CEhKbztavB7szrJcJb2mCyG7peAdGftWsBRcKil5yCtxdwyan7hyK+BT2dOAj3KY17Yc+DFNzt+Jl6BW9bJynhzJALVM9JRNi39JXs5QIEN2fULeXBldhiLsKYA7UxS6/furVc5ioLF7/LEfurk8t3lt+XLWfNdiotQBSCk5kkr+6Pg74xuVLhacwKm69riPgsxxaviYx5+qqjQ3R15YOvpXwEw5VaoEWucGYx/XuWM89Dpv/8G9ZRajoi6Xwf33r/sldXzTMiO5/AWG7CgC1tH8XdUP1WZhbLGSq7j40Bi1JxWoaCahdZ9xjZHpd/a9bE5F1mvQd0vcmbxME4NBiDujuu6pMIOPoHveKDVx5EqWqxFUI/5nAeJCBXxARkYP+fgcgqIiTvLkLAYtvOfYF/uGechbpPwPm+tufALfRDCBbYcLsO/NNOJ8IJiEx7WXRPXNoMbmFTTt0uGo3T7LDw/E634V8wfiKDA6oYHiwEOC/IYi6HdqiijhCfjOJaWLJ/wOq99SNdurYvtfLJ3eVMGOJmLN0anIJ+UX6NwGMTG7v32EOU89cyieepK92SA8dP7HjYrlSExgfPz0Q==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?UUYyVjYwY3o2NVhLVUJ3TFNNOU14c25aQitUSEQ1dDE1ajZPMzlpcW9RMGdX?=
 =?utf-8?B?SGhWSjEvek9mU3VsTVZKVjI1L3oweWRIR0xPaDcyZ3dJQzd0aytlZVFVbEVG?=
 =?utf-8?B?QmMvNVJKQjdvOWtTK2pQKzcyNExya1VsZXpwc3FTaUpoY2dReHFNZjZLTXY2?=
 =?utf-8?B?c2RvZ2hsQnhOc3g1YnptZEtld25GR0xHUFo4eUl5K3pEckw2WEpmMFVMTWxo?=
 =?utf-8?B?TTRSam9XSHBpOVFLTW9XdGtjZ2dNVVY1NWRUOGkxRk9VbTF1Y0Q3OERmZUd1?=
 =?utf-8?B?SWRDZ0wxMUdpTiswZ0hwK1lRemRDQnRudVZLUmZhRU5WYkYzblAwdXJ2VnBG?=
 =?utf-8?B?UjF2UzZMU1BvYVExTWwrdTM4dmNtNlg4U2Y5ZmVrekM4SDVJSEVVdUR3YXlK?=
 =?utf-8?B?VmtGanFQREhIMmtMV1VQeGNPaEdJYTNtT3BqbjJJSTFRdVFET1lQSzRabFI5?=
 =?utf-8?B?WGRCRDRrOStJbU0vTXNyZkRSKzZBVTNvTEs2WjU2U1FLcmQ0anhXTFBHM0FQ?=
 =?utf-8?B?M1ppbkVyT1kwL2Nub1czaGNiVVo3NzdYN0QvWnVLaFdFTC9Da1B3YWZyUWlC?=
 =?utf-8?B?RDV6OXREWXQ4czc2VXhTaTI1VTZBU2NWeTdLSStTYzJ2cjd5bEdZdDI4QnJD?=
 =?utf-8?B?VFdWVEREaWR4bHUxaFJPS0g1Qlh4aWo4R3RTRkc2KzFIcXhicVhXaUx4K2hw?=
 =?utf-8?B?ODhFN2pzU2lxcGF6MHdtdDNuaXJwUE1yRXFOQ1ZMY0tHSmo4MWNoTlRRbnU2?=
 =?utf-8?B?emdIeEJFTCtZWVFMQVZ2dW92VzdhVUdMWXE2c3NOVUlBT1kxeGhma3k0M3Rz?=
 =?utf-8?B?UGVUbTg2bmlVVDkxMlV6dG5UMnVLTjJoQlNJbTVmK3pFQXZEZDc5bUtEWnU5?=
 =?utf-8?B?bWJTcW9SQlE0UkxkRnVNV1VRSlJZMTcrc2s4a29ockNuT2tWcndORllTc0dV?=
 =?utf-8?B?L253U2ZqQzFsOHZ0TVArUzhUN3lCQlVKYVNScE9UUzNvbGdMb0MvVDBmYUdq?=
 =?utf-8?B?TUs0Uk9xZW5iT1VDTUszZHVOWXl3ZVhWR0FJczlrWEpMVXhpdVEyazJyR1dP?=
 =?utf-8?B?QXZNR21BM05uVk9kQnk1RTluN2dEVjNIbU1wZ3VzWmZET2tSN2dWZEZKTFQw?=
 =?utf-8?B?ZEVzQi8zYUFhQ2d0WVYxSVJ3d28zR3Jpa3hyNitvZmhjZWZ0UjdYTHBPQkN6?=
 =?utf-8?B?bisxMzF5M0NFeEYxcVc3dVkwMDJiVWs0YmxPaXZGd2labm9QRFgzQWVPa1Q0?=
 =?utf-8?B?aFR5N01rNyt2MWxmcTA5d3BGNHFlWjNtUEtZbCtJK0p6RmRkLzJHRXJZV0ZQ?=
 =?utf-8?B?bk9YZ3ltUGZkUEgxcDc1RlN3UFBzSGQ0RFhBbTR6cGM2MWliNHVOT1JocUJP?=
 =?utf-8?B?WDh6d08zdWorUkVCVW1ycWs1ZktwV3V6VXVwUjJxZjV2YVN5endDQ2EwMldP?=
 =?utf-8?B?TUUxSmxxclMzYkpMQ29kekZVbjF6NXI2NWh0SVlDZVlNQSs5MnUwdEU3WGxM?=
 =?utf-8?B?YndNeXFkNUNjWnh3WGpEU00rbmhiK2FwK0FNaW5OUzdkR1F0MjQzNmg4Z2ZD?=
 =?utf-8?B?V2VleldscXc0ZzRrWXY5cmtOaFlEU2pjK2FRNzU3TDNTQlhBb3FmMG52UHNP?=
 =?utf-8?B?elJwT1VPWmhuVUxnVlV6M1BqQUFBRW1WczF5Rm42RXM0V3RiRFpTN0dTa0ZQ?=
 =?utf-8?B?MzlzSVFWMWpqNFFkSklTblJnV2FjbGsyR0FMTzZ2REIzTUR6b3pLNm1HUXZQ?=
 =?utf-8?B?bXE1QUVJM1IyOWFMc0poVWlkdkVndzM5dkRxNmE1L0dUU2ZkMVNnKzBWVmF4?=
 =?utf-8?B?WjZYYkN3SHRxTmpzc05HMWFtUk9HalltYzlBRW4wUVY0NHZHZEo3STMrRzNJ?=
 =?utf-8?B?SzEyTHk4M1E5UUQwemtVRjZKUnpEQWg4RW0yRXNsWGc4ak9leUdyL2p6NG9h?=
 =?utf-8?B?ZFVqSmVPNWRBY2FrSzMyWWhTZ3dLcElTa0pXT1ZNRzJKckxZRHM3MVhRM1V6?=
 =?utf-8?B?TmY2YXIxaFFSZWRjRzl5VlpFaDE4ZXVmMXB0V2RaZEtTTEt6VjVrZXFwY0tU?=
 =?utf-8?B?TXFlUzdOYW1Ud1lOQk1qdTV4Rkk0TEZ4bjhVMVZZY1ZxajVvMW9oOVhoZVBF?=
 =?utf-8?B?TzBPajd5dDk5czk0SGxoT1dOT2JWcUl1elBxMEhMeXl2Y05oWUlsMG1qY0sw?=
 =?utf-8?B?R0dtZzQvTS83UHYvc2N6cTk4UTdxamx3REROSXVSNkZFanBLL0oxUXRmUE90?=
 =?utf-8?B?SSsweXBQd3c1T0NIdXY1ZWxzM0JMWWVnMFUwKzJCQzgrMlk4bW5lZGRuQUQw?=
 =?utf-8?B?NWRkL1NGSXZvZHIramhyWFhXUWlxZDZWOFRDNjFQSnVYMlN0NjR1dz09?=
X-Exchange-RoutingPolicyChecked:
	D7WTc0o1XDsfamM0+jMza1yGRc/bPzXVD8+XCE3FdUa3JT/IOArGAmIsPfbezvAUDp22WvhMqb+InimTKGXWXzlGRE67BBbt7F+8hrG4O9USHyoiImRYgDAl0Q2fqLymGOK3ru0HXlLjgmfxwWg+N4XId84/FSjXtwJ/TXF+YrnEuO0NUDe6IUPk92vMEC+jZ7sfPUs6kJfob8HCxdan23RO9DREEunULggtGQEdnmKAqrcgTFnzcQkMkUZAGjpMEdqHozUOZbrdenNc0adBa5WJEhesGulmDshwIYWVCUYCq8o2xFMdxB+ZWb/u+AmbpbK6PLZQO59CfW18sTJPSQ==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	WPwpjBmO+CzSN+rNL1051NxTCXE5bVxNjnaM4Slf7nlsOPylm55pcE5/Q9T4X1dR8VS/2aG0m9WICblxP+sMgTTlo0pbdLXltVv68k9GGVl8Ar+J+5ZcplzkRm3bfaEP9nMT3AbBxB5YtG8tJIPamOLRzbDIsS1WeoxJb1seMSfTGCmdem7rlpIjax354HTwp2BJuXmtqspf07/QU5kK4kg5/k6rQj61m6H/ubXD5mzJ4D0KiwCyxYnXZvda6VdOf+EulkbJN9HdPeJBhOcHTVfW84qhvZvZpgKuYFsk4Oj9uD+cXZ/fey0I63yTi/DBrZChu7IC/BUv74l+rRFuGT0FYTaT/r4UVxpEpWBDSMpd3e3TZuCeqUIfI/i7BnwBEsI6JY/dmsM5GwQ0jxCp7XBHrnQhAZ9LKX9OujfApCroZNIQIa+XpYNtKkwTKWMJBphbZk+dBrmB7o+2RrbZk+r768RdPDVB9bNTsmJqybwo1gxZIUj5cGaOnnKBu4CKPpz5mvyVpNOAMqAV9tplijOClZIEJQMwN3+XhonZP2Ds22YhAQnfF/+dzxsA9RbigGNUCnb56Ib5i0YRFDzrvp34wV7HQ1YY7CEz10oU6Vk=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e38d70b-8d4e-4357-aeaf-08dea9ae8e72
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 07:27:11.5574
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8UcA/rCwrZBE+PZGr5pfOgTPMVuQmFF5+98gsZjSDsskL67SlKQPmVLgMvY13dkrX78hyI3gDsk6H/t/WgpUVA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5709
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-04_03,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0
 phishscore=0 mlxscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 mlxlogscore=999 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605040078
X-Proofpoint-ORIG-GUID: DN5QR-Gr7B9k-COQrFVviXgGkq_bGOjk
X-Authority-Analysis: v=2.4 cv=O+YJeh9W c=1 sm=1 tr=0 ts=69f84a53 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=RD47p0oAkeU5bO7t-o6f:22 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=iEmcBPjPBjxW4-rNg_kA:9 a=QEXdDO2ut3YA:10 cc=ntf
 awl=host:12307
X-Proofpoint-GUID: DN5QR-Gr7B9k-COQrFVviXgGkq_bGOjk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA0MDA3OCBTYWx0ZWRfX9nz6GvyUrqbK
 iuQg1vNPMkQIChFAVrFoELHXaSrZ6+dLeqiF6lY8w19V2nIbOPzOYWcnkn3PrkH7EK/nq6wp7O6
 TWqwRBvPeJUIQaBbNj+gn/SJzijg83yHe+AkdMb67zT7xCs9SNlf1EDKWj+MFwqfYBMbumG1Tb6
 DXhZy691XhL+imz/n5KvfJ63Wk+LzcqcElfYLNgUwGx3LwgZEFKwJNM+5xHYmOf+CHsMcYhnt6+
 E11FnpyDk0xGcYX3wcQAzlcJyG73vIexTyNXmgndv1+170yym7JZdwCEHN5GkomAqxVUvBok4bg
 yc66L8ezuAsyvebSm+BPfUbrWCYif55QgKWlGcMJZ4W+ylEwA2T2MybhdRE6Nb9k84pl1lTgnLd
 A65qCtV3pFi3AB8tVNnqt/VdP56dy1WAls1wGJP4CxqXPPT05nNH6zWKK5o0avo4kUPz7MxzjB0
 QlU2vX0EaFfE2Pu1xt4J9rAdDxjBVF3jwz9mgZEU=

On 01/05/2026 19:42, Niklas Cassel wrote:
> On Fri, May 01, 2026 at 03:19:03PM +0100, John Garry wrote:
>> On 01/05/2026 13:54, Niklas Cassel wrote:
>>
>> As I understand, this deferred QC scheme was intended to solve starvation
>> problems for multiqueue SAS HBAs (using libsas-based drivers). libsas has no
>> port multiplier support, so I wonder why we make deferred QC scheme work for
>> port multiplier, i.e. non-libsas scenario.
> 
> Are you certain that there are no libsas HBAs that support port
> multipliers?

No, I am just saying that libsas does not support port multipliers, see 
earlier effort @ 
https://lore.kernel.org/linux-scsi/1398346023-10225-1-git-send-email-yxlraid@gmail.com/

See this today:

int sas_discover_sata(struct domain_device *dev)
{
	if (dev->dev_type == SAS_SATA_PM)
		return -ENODEV;

> 
> 
> Basically, before commit:
> 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> 
> We always aborted a new command, if that would have caused NCQ and non-NCQ
> commands to be mixed on the same device.
> Regardless if libsas driver or any other SATA driver, e.g. AHCI.
> 
> 
> After commit:
> 0ea84089dbf6 ("ata: libata-scsi: avoid Non-NCQ command starvation")
> If sending a non-NCQ command while NCQ commands are in flight,
> we instead save the non-NCQ command and issue it as soon all NCQ
> commands are finished, from a workqueue.
> 
> This commit changed the behavior both for libsas based drivers and
> all other SATA drivers, including AHCI, which does support Port
> Multipliers.
> 
> As you might now, Port Multipliers are not that common, and I think
> simply no one tested the change on Port Multipliers before the change
> was included.
> 
> 
> As you can see in patch 2/3, we basically stop using this deferred QC
> issuing via workqueue for Port Multipliers with CBS - when sending
> commands to different devices.
> 
> For Port Multipliers with FBS support, or PMPs with CBS support where
> issuing commands within the same drive, we are still using it.
> 
> For PMPs with FBS, I don't see any problem of keep using the workqueue
> to issue a deferred QC. It should basically be the same as if directly
> connected on the port. (There is no extra logic to handle ap->excl_link.)
> 
> 
> For PMPs with CBS, we could keep the same behavior as before, and just
> abort the command, if NCQ and non-NCQ are mixed.
> 
> The advantage is that the workqueue issuing would not be able to somehow
> collide with the ap->excl_link handling for CBS PMPs. Looking at the code,
> it "should work", because we always will always have ATA_QCFLAG_CLEAR_EXCL
> set on the QC issued by the workqueue.
> 
> This would require that we know that PMPs (with CBS) can't be used on
> libsas based HBAs.

Please see above.

> Hell, we could probably do that if we wanted to, since
> I don't think that people using an expense SAS HBA with a cheap CBS PMP
> (does not not even support FBS) is very common in practice.,,

Yes, SAS has expanders for this purpose.

Thanks,
John

