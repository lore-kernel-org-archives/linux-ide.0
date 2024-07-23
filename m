Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC57D208A0
	for <linux-ide@vger.kernel.org>; Tue, 23 Jul 2024 13:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721741706; cv=fail; b=cFstMpPOXShKQLlp8y+JdF09DgRgPBXYsfHQQA4ZSO3hcJWEYmYiY3FfOar5redhKDl0SzVkNaK9tdgAUN168tn1Yh7pUSvNDHZ7+lBcF245/txHpYGX0f9iW+XDZcf+pgEEnpVEBH2vIwc4BqtJRs8vdifFXtAUKZM2FY2tHuA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721741706; c=relaxed/simple;
	bh=MvjIF0rFz+DmAPbnPj2gbuxUOu0tStuEds/DK1NJiU8=;
	h=Message-ID:Date:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gerGaIiMO3oJps0mi2Sx9+n0vLSML523Z5nwqVaEm0db0e8ZcVkve5Of8bLUxOpgnsMlvAdEZoCryxmhfa/4gmhzP2BL0R52gCTr8tWI8E6o2oPYzGTFVR7FH+nrOJq+Yeq0X48TnP073+mVtiwqKjTz2Fu3HAVmcNfjoVO0R00=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=o1Ob5YAV; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=sB+T6IU7; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="o1Ob5YAV";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="sB+T6IU7"
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NCGSxT026740;
	Tue, 23 Jul 2024 13:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=
	message-id:date:subject:to:references:from:in-reply-to
	:content-type:content-transfer-encoding:mime-version; s=
	corp-2023-11-20; bh=DwaZzUR8B0WRagu5QlYsHQmmz0dWZvDOQnrPUfg2sCk=; b=
	o1Ob5YAVhK69Cxkb+bQWxuam2KeiIq+8iIUjlFWR6VdfbVT6x+wpUHSnkl8xM5f6
	xsGT/8CukC4j+ckDfRBadF6c2OptW4FNQuhUiugkh7u88FjnqUldkLqJ68tY7asx
	IOHmG7KBrTAYAUqLqpk5AeDcgjVPIrwaOk0cFRhkACs5+jbTjERTU4/1I3nra0hQ
	voUnHkg/qEW7OJYg2kRl2PiowT/HuC4S+LrBXXqGDT83u9Xd2yWLmt86qMYkQrs+
	1Yjs/14qp2V4lR49vO1qQZlt5qKy7MF2SKz7uSQ9HQJUnVvGVJ3fXHbCQFQ1y5rg
	k4Mrlie+HhfaKQ2BfBApyQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 40hg10xcsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:34:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 46NBqc21040130;
	Tue, 23 Jul 2024 13:34:47 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2040.outbound.protection.outlook.com [104.47.66.40])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 40h26meud4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jul 2024 13:34:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BcDwXnjcHJxvbGIuP3C5L/E7VXvOHdzs+gKCjSnfll7ok9Os+ysy/YcxDIIEQ4GeGYYD8HI4RJ0GCCrR0x0gA6zJglEBott2U+Y248iC3nGqgQAgqZ7YFtcj960q/HAeRfZiLz4n98wNDRx+yWleJGRzf1AdFkx666M8awwi4xBZ0OfEkKYkeIc2o8Jb6b2q2TaMq7o3irp1rtfr7J9FDqljMQzNExjvWsZTZaHQxfN3/DfPmUHzuWeri/3INTO8uriD3pfBBXrDRt2EX2Ta6geEKVkjQTZLP4MZYLiwpc4Osx1tsRC86WWmVuN67cb/4AtJBk3i6qZ+YOXEhufXow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DwaZzUR8B0WRagu5QlYsHQmmz0dWZvDOQnrPUfg2sCk=;
 b=j9ySwJe3iuk/qQq07IyU6Fdp28INzhta22E8ifCUANh/W/P212Njtl61CPQ+9ymHgLutOca0vZyP2LGtMzmspizMZ8hfk48v78opsCl0VRpuRQKAKjBYkKmCb9JqBs5yCJoKJ5S/AYIVhYsvlY0oO+dz1fwmMv/LSizUGMWs7RBCytvYmznMyiM6zCbjgiJE1fAQd+20V7WvkGFcnQJR5wbpGvvcPEofD/mgLvUIhWBnjbz/xPps6iy3EOA/E2/xXluXfPZfflVzIR4FSLNGHGXg099ObmLMEPhL7On72q0dqBnTsl4NMOUMptaL1hy4SGfAUOtvgiZ7gYJt36bd5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DwaZzUR8B0WRagu5QlYsHQmmz0dWZvDOQnrPUfg2sCk=;
 b=sB+T6IU7jUCPTaBIA568gVBoUGQwwm7/9bBfGGI6XC3uTubO6sWlk+jqMEOhNrV8cFi8O2CDyh+x6Vs7peicVOd5MXaQNwJBO9aUWpVWcWhOjsEBxno9+6WZXZSl2+I0nU3r7P8AipSHarzlyYUojNSotz8UFde1NNxagmCcPEs=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by DM4PR10MB6253.namprd10.prod.outlook.com (2603:10b6:8:b7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Tue, 23 Jul
 2024 13:34:44 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::4f45:f4ab:121:e088%6]) with mapi id 15.20.7762.027; Tue, 23 Jul 2024
 13:34:44 +0000
Message-ID: <81741377-79f1-4a55-b09e-3e5d496c2a68@oracle.com>
Date: Tue, 23 Jul 2024 14:34:41 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] ata: libata: Rename ata_dma_blacklisted()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>
References: <20240723103406.294462-1-dlemoal@kernel.org>
 <20240723103406.294462-2-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20240723103406.294462-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0028.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:61::16) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|DM4PR10MB6253:EE_
X-MS-Office365-Filtering-Correlation-Id: 99164496-1690-4b71-cfbf-08dcab1c3696
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?czh2a0gxWE5QWE9aTnFKZHpuc2VJQUFUbEZaNWV6Q3lXWldHUnNYR1ZKenFy?=
 =?utf-8?B?OXdEaFlORkFuNno3Q2JOQ2gyZW9sV2FsUnZkcmVxeE94aVA5azd2QVk3SjV3?=
 =?utf-8?B?cm9VZjNDMG1FUVlQQXJuNzFNNTlvcm1pUFF0QUErYTdFWjBLb2VKOHZSVDBx?=
 =?utf-8?B?K1BEbER6ZFNKd2VZclpjTkdaN2FScWtqVmdMSXhpNE1SRzNuVW0xczdYSERE?=
 =?utf-8?B?YWVOWFpaY0JLV3hFbUN4V3U1RGUvRW4xWjlXek1pZHhsS3dKTE9sR3IyeEdU?=
 =?utf-8?B?UWNMUXkza2k4dG40dnhLWVZmaUROc1Urb09xdXpZNHFPNUFWcklhcVM1eS92?=
 =?utf-8?B?OGZ4dGVQODJ4UVBjU3lWVUxBMEtpeUpFcVNOaGFHdHVJVWdseDdCMnlQK1Zq?=
 =?utf-8?B?Z3VOaXpISHd5cXFaZlRDbURyU2lRQ1VBR3VZd0VVZDY3Q3FMQjJZeXNaWEgz?=
 =?utf-8?B?SHhzOGtZaitJbzBPL01FenllY09rOFA2U2svK0xMOGxaV3lBTkIzc1lUUXp5?=
 =?utf-8?B?RU8zbU5hMkc4KzV2bGZGSkhxNkpwNHM5SU1Cc0Uydi9odG5uQmlwc2Nldlhi?=
 =?utf-8?B?UGo4TU9rMjhoeFY3dzVMaXJSaVdtbGRNVDRTNGg5a2RzS3c1M0VPb1lWcFhD?=
 =?utf-8?B?QWRvMDZGRnJXcU5US0xtVFhIZlJSU25LR1BZK1k3ekE4cXd3ZGVKdlRhZkVY?=
 =?utf-8?B?UjdndWJ2dWRaMUpHRHNCYk1mN2JLSG9kamxIVTFKL2FCeUhFU2xxTU16ZjF5?=
 =?utf-8?B?Z2hORlRCMTVmTndDY3JEbUw0Z0Fwa2YyREVyUmV3NTVJRC8wUXZqTnBLdzB3?=
 =?utf-8?B?MVNNV2lHUzJOd0tYeE1zNjlhaFZpZ0hXMExPY21oaVdQcWNnQnJmYTY3eGxt?=
 =?utf-8?B?QWk2Q2t5NUR6aGlLNGFmQW5oR2FrdVNrbEJYTzdmdFFEaXhTRlJ4MmFXOTJj?=
 =?utf-8?B?ZGtXdXJkaFlieHlTTE5XRExsMHRVSjd4aG1CcUNUODV6WDNnQ1dIODRGODZL?=
 =?utf-8?B?YWhYSVZaNnJVVERNTlRmc1MvRFo2emdUU2dFNkhoUFVhdDRXNHUvaERjS3dI?=
 =?utf-8?B?VElmK0s3bU52eXZpVDg3bFhyVk1ObkY3ZERxZXBCaHhLbnVDT0RuNkIxRWF4?=
 =?utf-8?B?WXp0MzBJaUZtZ2l3eFJjNWt3eFFBcXFwZEVtWnZEL1ljYlhDN3BnSG44bUdT?=
 =?utf-8?B?UjlMMys0RXAyL2x3VXcrYllUdW9nTG1jVUtnUlhocXhFaUJRbTJvZHMvajNu?=
 =?utf-8?B?cTNnak9FMnFXQSsvZml4MThUbUJ2OERWTjJTK2o5MHFYdGJMSENUMHdYc0Yz?=
 =?utf-8?B?SE05WGUrSXR6aWZzOERFci9SeU5BTVVIUEJHakpmbXdMaWxvbkJua3l6ZkUx?=
 =?utf-8?B?c0VieEc4dmdubkxPQUpGYXd4NkdoSmN3V1YzSFM5R2UzZVJBYmhkZUJBQWF1?=
 =?utf-8?B?RU94NlhEOWRYcjFjdXNYdFJSUUJUa1UzbHMrMGRqdklYdjZPaFEvbGhtMTh2?=
 =?utf-8?B?MlIwbVpoTWlHRlVKQndMWXF1M2MzTHhrNlhCeHZXRDd0a3F5S25aenh3NStz?=
 =?utf-8?B?RE9wS0Q1dlpudjNnbnZncFRMZUZXbHdXZDY0VXVYcFd0TUZRWmVSRE5XVjFk?=
 =?utf-8?B?bHhkWkdodHNBcVA2Z2JsRWM1cGVaRnN0d3BhNlBZZEI0bythUGw4dlFWa212?=
 =?utf-8?B?b3R1aGg2ZC9WUENBV3ZoQmZCblBTd0VUeEJibUwrMVBKQmlwT2Z1b1ZyVEdU?=
 =?utf-8?B?SzNCQ1o4UkorQTVEcWtvcktUR0hsWS9HRnNSNm9JUWdpckhSdmJPNWRGZVB2?=
 =?utf-8?B?WEpUZDBaTERQOXBXZng3dz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SkVHdTVTekRlRjFCSDBKN2VjeGNwMnlOYy9oQ3UxY2xGa3dSZXNmd21FRHRX?=
 =?utf-8?B?QVEyMjFVV0MraUNxODlvaHdHQkRlc0tiQmZqQlZrRGg4MWRnYjJObDhiS0xF?=
 =?utf-8?B?bjl4aUczOWFWZjdtYTh5RjJCZ24rTHhlSjZQQStmeVdQVUZtM1REaEZRSzMw?=
 =?utf-8?B?VWdNZitEZm43aWRtdkVmRXFTbS9Ub3F1SUl3ZjBHclBJTzBKL2pINlFMOVR1?=
 =?utf-8?B?aUEwdHc0b2NZUXZhVC80M3hqSmRKQks5Rkh0dTZTQWlJTmVraUxXcTdsdURl?=
 =?utf-8?B?TW5uaUIvREpQOUttNlU1OUp4UktSU3RicUFEdkFqYUVxUWhka0dPc3BsYzgx?=
 =?utf-8?B?S2VVTU1GUXE4UkQzS3kxNE1rbUtqZGMweDJNSTQ3MXg0K0pKMklieHRyd1Yx?=
 =?utf-8?B?azF4Y3lJcmRDdDF6Tm4vb0I3YS81cUV1V24ra240K29ibVV4M3ZSQzBoNTdQ?=
 =?utf-8?B?UlBVREpFRGt5d0g5M245UUFaZ1k2a0xtZ1R2emI2Yll3REZHM1JOY0tBN1JO?=
 =?utf-8?B?YTJDeXZBMEMwY2NxTDY2VVZSZFpLMjJXdTluUGtvVnlSTmtDaUVUc3ROVVRG?=
 =?utf-8?B?Sm9XM3Zxd1FUQkYxYXEzRVZIb0QvczcrN1BBcVJ4Qm5Ud0h2amJyK0dHMHZJ?=
 =?utf-8?B?c1dXb2t6WEo2WmFURmJ3VE5ybXNpSjdka0NldFozVlZOeExtSERhbk1NM0Nw?=
 =?utf-8?B?LytYaG9jUnVqcE45YmcrSHdxZERoVmdFYjN4eVlVU0F3ekZBUWdDVGVQNzRa?=
 =?utf-8?B?OXBMeGVUa1dGSVBwVzVCVFUrK3JPUEt0U21XRTd5clpUZG5PUTBoTUM1NGtX?=
 =?utf-8?B?T2ZqVjlpRGRWVUZhOCt5eFFQMGx6UTJzNUQyd1kvT0ZJamxzbEpvZEhIVFBr?=
 =?utf-8?B?K2xsOHJrWWRReDRlcncyQ0xJNUdNRTZobnNhbGh3ay80eHFabzNGdXhYOXgv?=
 =?utf-8?B?OXVyQ1V6NllRRGFCVkRlekxRWlAwUFJqR0NVRHZnM3ZkYjZGU3pnYmN6Y2ZT?=
 =?utf-8?B?RmJZNFhWYWZNUjBMdDN5ZXZDaVFTSXJaUmo2YzJpakVGRDNnSzlCVDkreGFC?=
 =?utf-8?B?anRQbUw3Y0sySFA2cEpzTXpNZFhvWkg3bHJDSlI3Sy9wdXB3NGNLTXFuU1hJ?=
 =?utf-8?B?TTgzNFNOZW9mR052enpncC9SOVZ4clVTWVprdTlLa3UyZWJMemZMZnJoTy9S?=
 =?utf-8?B?TDFudWNjNy9IZnVoWHpmdmU4WTFkTERwRTcvSFFiTWhpRk5hZWVuUWtteFE1?=
 =?utf-8?B?NWlYZmlta2dzNTlxdWVPWHNqUnI0UnlCeXNBQ1IrTm5pckNLZXRMOEVMd2Nr?=
 =?utf-8?B?bWE0V3I4SWJmWU53eWRPaFQ4SlJJWHorYjBzS3hISTR6ZFpuZjJKT3BWVXFG?=
 =?utf-8?B?VmI4K2FUY3VRWllXZGp2ZG9uaWU4TmRkN3RwbEVFVHB3NE5Yb3lGNEF1dXBS?=
 =?utf-8?B?V1ZmTnBxTW4vanV5dkJFNWxVR0dscGc5cWlBTUdrVXFkdXU0K0pZbVZTeTVO?=
 =?utf-8?B?ZlJpNFBSVXJKNXdhWjZDSFdsWU1OT3ptYnlZejlmMVdqS2ZGYjc5Y281WEY0?=
 =?utf-8?B?TFZBbnJCTHhpY240VnltaEFydytMbGhtWkFFV2RUdGNSaUlPMDdsR2FZbkw3?=
 =?utf-8?B?dFhQRGRqYU9NdzZkc212WXdlMENiYkVNZzYrM2plcGZGaysvaVhZRUx5ZjVy?=
 =?utf-8?B?NTlxR3JRSllOZW1acE45eGFvTTBKd1Z3dkdIMzhjTm1VNnFSclUzQzNNRTM5?=
 =?utf-8?B?ckI5ak1JbWdVWmY3bmZwbXR6cWxLazhpZTRYemdXRzJSMWNBZkZwaGp4MUVF?=
 =?utf-8?B?Y2xEdEN3Ly9ITVBCOHRuUndMNGxyWS8rSHp2MU0yN1NRdXZsenhtN2M4Yk1s?=
 =?utf-8?B?SkZ6SVdVZTF1N1B2TEhIeUIxOEQ5MzRwVVVHTlhLUVJaQTZJNkJQTGM2bXRn?=
 =?utf-8?B?a2xsN3JXbUZnRVZleko2bUpqdGlnaFRrZ3FsLyswWlhBZU15K3grcm9sVW13?=
 =?utf-8?B?bUhMSWZuMlNyaUx1UWhzalVBSXlxYjh6ZzlCbURKSEFRc2pCUHZseTMrTnJV?=
 =?utf-8?B?WkdHZ2ltQXkyZEVzS2RjRitaaW5yaXdlalUxbDNWMGd1S09zUWRpMkNKMUdx?=
 =?utf-8?Q?cuHhGpsU32iqprXQ5j2FlnFA1?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6YD0VskBPkCLIjGKT0Ys5IZSmOCUO5+svVDts6eh2oVUi9AmqVjEjFVOXF/HXChB985UuaaPI0fFDsiTUWQoFCcgMUOKkJWrzmtrrX2h9GudfH4mFCeZcl0RrTmZwYfbQi/Hgt4qEbhbhZ041pFQR8V9+/0j+i3KtVzhzjJKwx6h+XpX+pVJ52qACjlnBQ8T3CFiROxmYeYmDx4pcPvETj+EnvNkRgESKffxeeYnKvg7USFMKxZwzjpUV/r6sKtJhAD8o4fG2PBLGPuNnmCmiB7N2dWBceodTvwXS7nvuDbltuYnlxJpgngdC1k6zJjGeU9xAM/SNoG5KD4OCOEuHvwMvLoEF6Lo4IIP81jWE+jB6aYzUP1HxWM3/RHXc8RixLbKdj24bCN1f+LHObjHwjgKj0d57X0JGf6cdSjnDznBvAb/glcvx3C0KKR4DhrU9mnv6Phh/OWSHIMy8l9n0+jjmAr/kxV4KRDh35ESQVmhMf0KbLNA5Yz2Qs3yHXhrgwvCVDlB6/izmCDLMXOcOlkj/3ejsM8Sa1MHgxZLAa7uwQkM+SDFWVvxXKPnyvMlYLJuZUDyhvrdNplP46zVTI228RYeiMdoZA3uy1tBG+w=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99164496-1690-4b71-cfbf-08dcab1c3696
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2024 13:34:44.5252
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vDfsM5XDop2K7c03kz+/Bdkrg87cl/MUi56Q1OmuuBVx1E2EaM24LIykJVi8BTJiuAKXeoagLNS664L6jhAMEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR10MB6253
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-23_02,2024-07-23_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2407110000
 definitions=main-2407230097
X-Proofpoint-ORIG-GUID: GZyHaX79116epDBDw5GDkbWykkiw0ECB
X-Proofpoint-GUID: GZyHaX79116epDBDw5GDkbWykkiw0ECB

On 23/07/2024 11:34, Damien Le Moal wrote:
> Rename the function ata_dma_blacklisted() to ata_dev_nodma() as this new
> name is more neutral. The function signature is also changed to return a
> boolean instead of an int.
> 
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-core.c | 15 ++++++++-------
>   1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
> index c7752dc80028..286e1bc02540 100644
> --- a/drivers/ata/libata-core.c
> +++ b/drivers/ata/libata-core.c
> @@ -4287,16 +4287,17 @@ static unsigned long ata_dev_blacklisted(const struct ata_device *dev)
>   	return 0;
>   }
>   
> -static int ata_dma_blacklisted(const struct ata_device *dev)
> +static bool ata_dev_nodma(const struct ata_device *dev)
>   {
> -	/* We don't support polling DMA.
> -	 * DMA blacklist those ATAPI devices with CDB-intr (and use PIO)
> -	 * if the LLDD handles only interrupts in the HSM_ST_LAST state.
> +	/*
> +	 * We do not support polling DMA. Deny DMA for those ATAPI devices
> +	 * with CDB-intr (and use PIO) if the LLDD handles only interrupts in
> +	 * the HSM_ST_LAST state.
>   	 */
>   	if ((dev->link->ap->flags & ATA_FLAG_PIO_POLLING) &&
>   	    (dev->flags & ATA_DFLAG_CDB_INTR))
> -		return 1;
> -	return (dev->horkage & ATA_HORKAGE_NODMA) ? 1 : 0;
> +		return true;
> +	return !!(dev->horkage & ATA_HORKAGE_NODMA);

nit: no need from !! operator, since the function now returns a bool

>   }
>   
>   /**
> @@ -4404,7 +4405,7 @@ static void ata_dev_xfermask(struct ata_device *dev)
>   		xfer_mask &= ~(0x03 << (ATA_SHIFT_MWDMA + 3));
>   	}
>   
> -	if (ata_dma_blacklisted(dev)) {
> +	if (ata_dev_nodma(dev)) {
>   		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
>   		ata_dev_warn(dev,
>   			     "device is on DMA blacklist, disabling DMA\n");

