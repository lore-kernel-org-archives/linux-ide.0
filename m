Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FFF1F936
	for <linux-ide@vger.kernel.org>; Tue,  2 Dec 2025 13:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764681017; cv=fail; b=a8IKlbijM8b/L4/5nMDP8OCG5K4/nf5dwC5JBpcRVnOIk0mLBoND3QkZ8eRQ32UmskBqHysV6CQOx2JLXBaQT8tQq/3Y1JB99cl1TktX+bmvpkQGJYaGdl13E7UamBrbbxM/xFvAoznR66dDm6Gi8lem3dPhVMYUeaO7GCjQw+Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764681017; c=relaxed/simple;
	bh=+jUiOBrb790uPli6cZWVYMNFJIaAho3+qxluc3zY9Fc=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=cfjhHOpg7P4+9zSX/B7jLCAweZBv9W3ltJTb/LmZ832M8c463g7LC/N2XwAP1HCWYnAE/31HVyUTCeZg5VW3bpugcnJIlleAutXinx8VjdIedgPaDvNxYi5zJRFqUHzpdRQO+0dSN0c8xFDz4KD0emMaM0ZAAzwcjNiZlxVng44=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=JT+Kdp+v; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=DQQIeb2q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="JT+Kdp+v";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="DQQIeb2q"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5B2BvJub161132;
	Tue, 2 Dec 2025 13:10:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=N9uopTmRoQNi7vP2vo
	uEf2ZJO0ghx3jjQr2gbXZ9d3M=; b=JT+Kdp+vl5TLSAZ+zqcOJsIw/YeQParFdG
	05wPCCF0cRR34lC++huSEep5/zydUfSNGy7FmKic56eYCKn+sIE5H8NJaKxE+MKI
	P6696iB/NzqfVD7Y3l3/4nwG+abLiqx0Yc0dnHquIRIdfjE/B5nKRyLKAa81d/Ll
	eFUSAEGUxF60eMPuoGhq5LtGpiesduDJBfFjdYxQv6oDYdtjtMEeY86wWYbA9OKN
	qTZsiS3oB/QMxMLtkqcrf6qSLhOo4JFx3M1Cd+vCA31xGzPVuNW89yLMFSvVP0pS
	+jCbOO2wMEl0sFFXDY9bg0g3x4cKaiQ6Tsnt1PCwmdSb/XNQe7Iw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4as7f22xpa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 13:10:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5B2D0JOe023447;
	Tue, 2 Dec 2025 13:10:07 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010030.outbound.protection.outlook.com [52.101.61.30])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9cumgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 02 Dec 2025 13:10:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTdpNy3bRW7vRdUeB5Di+2Xno8U02l1VXREeDAdRp2NTao9UNBjydbUBWuIsvaLJPsguche81zBmya+wvRwXOYNwHwch4xOZ6RyFOMw1ovV+dgqj+wIFsTZX8Zr1Fqwcrm+freew+ump/m6gLiHP0LyysjyzHma409flWNrJ+ZSLFv/Y37P7S5pfIsXIRE8myKIESl0N+ketTuZuLsHEcPLdiL3RKb+Y7CNdTWHKexhHUPkJs2YTjiXs8qrkaK/PWBMlPgmW90VVFCqgYRYF3OD6eOIEuHlvmm4fqXLwxeDr/V1XDJQWYCz3KtW+Dyjq6Kmiylfdg6jgNPi849Cj0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N9uopTmRoQNi7vP2vouEf2ZJO0ghx3jjQr2gbXZ9d3M=;
 b=rZJI/veBxp/XgoPwUPOu8l+oPEiX/Yvb0gYeY39f1e6/jomdFL/GOswZohy5RfdZMxV2nbRPDSRPlcIezTP6vUGFuZpXR3ps6Nic89PPLf4jB2FzXku7YX5iv4aiVZxDXoprwTt46j/UvvQVsHrwcZQsBz4s9OvAIPDsN49elL2tAAvQ7bIR3pKWWAbGKwP9IFe4aRZuJB955rstK76eJzqW3+f/X/67TIs+eJddaqigm9QVKtKh0y3CioZTyBbHronVp01GrCP5uWtu8wuvnhGmtrihb0kqesr5ksbq2mLx2qv98ZxiusHzFNR/H9vQCoFTwY0pVQu7fvDrpUGwAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N9uopTmRoQNi7vP2vouEf2ZJO0ghx3jjQr2gbXZ9d3M=;
 b=DQQIeb2qAAVK3xIHdkrv4+yYMTxu7hmWhtnpLXvqDIlTKT8PBl34HExN6dA2RKA6zd7elpZAIZxMgywpHHJJ013kUJVL9RBF6DaU78TihrX9aKxlcJyZvV11ZKrOdp9FIrkkPxlrjGSDei9g6DyIPeKxPyzeDpjDBRh4N91Bqus=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH3PR10MB7741.namprd10.prod.outlook.com (2603:10b6:610:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9388.9; Tue, 2 Dec
 2025 13:10:03 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9366.012; Tue, 2 Dec 2025
 13:10:03 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v4 1/6] ata: libata: Add ATA_QUIRK_MAX_SEC and convert
 all device quirks
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251202122129.421783-9-cassel@kernel.org> (Niklas Cassel's
	message of "Tue, 2 Dec 2025 13:21:31 +0100")
Organization: Oracle Corporation
Message-ID: <yq1tsy9t4h6.fsf@ca-mkp.ca.oracle.com>
References: <20251202122129.421783-8-cassel@kernel.org>
	<20251202122129.421783-9-cassel@kernel.org>
Date: Tue, 02 Dec 2025 08:10:01 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBPR0101CA0142.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:e::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH3PR10MB7741:EE_
X-MS-Office365-Filtering-Correlation-Id: 8826eab4-3adf-4ae7-ab1f-08de31a41b4b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?w4zDasljiLJ5CEYT6TUjQhztPNsjlJfTeJRpbgi+shXW/ocItITulqa/OXWp?=
 =?us-ascii?Q?erBJL3NQwJu0C9Pv9/pR0t1Z2F5F/yjRfJBW0CJ92y0nWySDRrmQtVeSwjNB?=
 =?us-ascii?Q?YCaGRUOZ7+Xk+OrL3he2eTokYc3sWP7kqmdbqSlhmgdCpFKvOG3dX12vTL6N?=
 =?us-ascii?Q?bpNRKqsETcfFp/czzUe8OYmWz5I9qPDwpmN4RrDJTYZ7XtRc73a92PlTfIC+?=
 =?us-ascii?Q?UcHP5FwvDw9D5c03fOSiViPcsahslJ3SCQbfAf0INIYfAXA4R0wFPk0cGGX1?=
 =?us-ascii?Q?xX547W7NqVlNQfROYw1tEwlck9nB5ablDuje+PVw6pikK2tgeSl2rRqLoM5q?=
 =?us-ascii?Q?oQYlx2kGHnO3HYBwTGIWaqwh/tMs+utkHYTRDcOpoEd3ZU1O9gtksNTdvADZ?=
 =?us-ascii?Q?wafECKLq7SpArrbHLJtI0duvBcNaCFXM42lzAGHuBlwpeWsfYXZ0XBfQo7Re?=
 =?us-ascii?Q?wrlmxT5oe8/UMCfWuYTS//7Qju3DmPQ2nnNIxKRKOTbfFXxuZqjLhthcqvJI?=
 =?us-ascii?Q?E8DvTU6C3g/rSfwWLSunsS0VewCDgoejDG4nMasiih0yzJW4GfT7i6pFgZwG?=
 =?us-ascii?Q?IPZ/k3UIhRpr3UQqzI8M6upIyiEpaty4of283b2nLmWgYbJXJdo/u5S5c15U?=
 =?us-ascii?Q?R9d8k70oEoO07hCfYch+9ndVjzLZn3x8m0592pTYi4GIdvlU9E2Krxs1ZPGx?=
 =?us-ascii?Q?kFDMI0bXEa6bweyamwbtzD/S2zSk1GwP/INQ9ZXJm2LG7MHqNJz1avYbLy8U?=
 =?us-ascii?Q?qiO+5mVWAlLCw1c035D3j7s+ywVwVijCaltD+sRdmxRSrylVrudAleG1VK5I?=
 =?us-ascii?Q?Q5cx1t1JaHsMSkRy3uyeU9sX39JNZVA9AwgRS/ZgYrQxs7jCg5AoQBYI3iBR?=
 =?us-ascii?Q?OSL/t4CVp0HhV7Ud+VDaEF4jqvTUHJhKUGKp3m47awlf8/Nk81mPJ/2coNa3?=
 =?us-ascii?Q?232Wwvey5RxGuXnJD7TDogiV2wC0mIaT20S40f40AHkHnXCs3okI7t7UmLc/?=
 =?us-ascii?Q?gzbzbnOJ32EhBm+MNidSD9RUY04eaXIs9R1YFTsAxzxfZnfxN6SjWVz+Y2s+?=
 =?us-ascii?Q?1Vak06oevGv55dU4yqNuBnCQa9OYIQhoNhEg+ofBPP4hwIJL+2JGbmOD/Nxu?=
 =?us-ascii?Q?9O3ypt/W5BAyBJrhR8fowKQUU26xcg2MpD8x4Q5co1r671k4l0LGN7D/laC3?=
 =?us-ascii?Q?/dkdDClgcfcSu4HbvoUv7W+O6B6bNT2jV0XuTHvdgIxlxp2eV+uAcK4eG5Fm?=
 =?us-ascii?Q?1pztFmN4Q1ZjEc3qBiW8d5CezHNhx8J2yP76GoT7zACcHpMOFodML+1H+PU4?=
 =?us-ascii?Q?peBTFiY05xpMFznq3YTTg8iTq9UAwr2uP88/7151AE0qIMorCfnSkvNaq7EG?=
 =?us-ascii?Q?9V20/LgsnZ22wueFvFORjyDu10kHjvJC/6O3I8A10gCSzfZOjiM0N3I/FGrR?=
 =?us-ascii?Q?JzfAwbhGcDf9PLHpeM9kOIxsRLULNR5L?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1mEw3a2ooyvDYjvGY0F2+t8kFaiWmDkOtv/hNUljtBWltBD1mO0itMTsY2Jh?=
 =?us-ascii?Q?KAy1R84dC7Kg/SNY6qes2isAF6Yvh9TX88AJENNNdH2SEumB5e7d3/UKpwBE?=
 =?us-ascii?Q?gG8hNzHXJ/DI2x+55+T4c6d5WW5P4qMJiz9tJPQe/JDWyiq/UlnalcOYGimf?=
 =?us-ascii?Q?0gQcESWhpA+RHAzhOoFaTULoBfdQ37GptrhH2lEVwxyYe+32iCw1eBN7dtd8?=
 =?us-ascii?Q?TmrsbimqZk12sJK99FXpWnuZzePMY0n/K7JhBXrCV89ceRvsASw1kBPEDewH?=
 =?us-ascii?Q?2Z5dJJiPxgDsDJr+mOTIQp22vuz0w1ctdmCJAbK7enhVJwHXrl77mPh0frOK?=
 =?us-ascii?Q?So3FnXozVXJPtGNPQujbZQh4rp2CuoFcUwEoSkFdSccNlwdG3f1BV+ST3M5x?=
 =?us-ascii?Q?FGihRYctW1ZrG6cVNqhK5J57XGXfRFrc0tu0AoTx3INBMUsg+DBpMDnWqWyL?=
 =?us-ascii?Q?e9HYhHV62ed/vEBp7AI2VUCOUTGH55bq2LdLAD9pK4w0+XOwPqq8hMCMJCFS?=
 =?us-ascii?Q?oDztt6jBud30Qp/o0+ry+5pJ7NaUR+/2CqBZ5GnMPnwgNRYJDvMS4O6bV095?=
 =?us-ascii?Q?apYLsCFHjgkwLsHuCBGJP4K3ddBe7PoQJrk/CKoofpvkE/iEyn4jcotlVm9j?=
 =?us-ascii?Q?5LqTWW52z1rtT6QmbJSgomVh4QIQIrfge9XGrJbYybckh1TApzag2snrcLa9?=
 =?us-ascii?Q?gQs4C5yVEYgJI6Mi9Xg+/G/k0qI/9FRlPEd3n3UVNmM05DiA2WnTfRa4lvi4?=
 =?us-ascii?Q?tvBJVcw/SnqER1Xr1m1Wxl9fTcug38UhMZaoaHd6Q6yF6jFkK+PrQFcSms9v?=
 =?us-ascii?Q?ZlssLadNgnoDj3/jfwDEjq7z8I2iMANG3WiRxbMk4THLxJK2kLGV9khzRneb?=
 =?us-ascii?Q?zfiqJU0JlTAWMCPNfWglkrPpfcsJdNSkrKOCDegbLjUpBgafdWzqKrKwT3KG?=
 =?us-ascii?Q?tp/6/bikpoGi3C34bvnCEf7KHSWELxv3J7W4YFnzgJWfTyCi/eOoCAXLhfIu?=
 =?us-ascii?Q?NfGUkdd3MtCuTx7tqQrp+5CevoqfoKkUY+4EtagowSP0z0AyweFGi2yQZ8Yo?=
 =?us-ascii?Q?x+TcLuTX5jGU9oAqvUgofKuy3nUvKFTL4tmm2KA0kNNFUF1ZAExGma2gJLme?=
 =?us-ascii?Q?7Iq9sQ/BvbkeQznC1AMJNq6KvnSUf1q1+hd9XMNoTAJCIndwGueVk0Q5dgVD?=
 =?us-ascii?Q?vy0ANFn/EeoMs/u60nuzV9Rne/4ZavhEVuoYllMloID3zDqKBqgUDuMDR66z?=
 =?us-ascii?Q?9VriPKrSt2vcL5+ghSBv5aFObCpVWbOrMYXG9Qi5RvJA03kdz+Ue6e/Wx33a?=
 =?us-ascii?Q?Kc9GwufeiCOHv2cr/j0ntSEwLTXVpVCLhHamWD+OaUM5Mg+uZd1f5i320LJh?=
 =?us-ascii?Q?QtL8PN9Zqaa2DhuRjxIBogQ/YkAxJNzTcuxRbDzJm2TryfSE6LALobG9951S?=
 =?us-ascii?Q?BNMKV4YICyBQpmvYDPKlu0TLV6t4Pxzm229z1+JFgg7GN7+aFqRjMaXBluEN?=
 =?us-ascii?Q?5pF/JFEXHbg++MQU0f99aAVuUfWjKyECPEzAoxIoMu38CdGxZ65h76GY1olf?=
 =?us-ascii?Q?cuvXvx8BGxnyGA73SBHVauQx3b/9zZRpKz57VsdjRO31RnL7kTcpv4t/KrGb?=
 =?us-ascii?Q?kg=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ubMbbasrWErmgnq17JMOPFXtFTrLYqeDF3FwDOSh+NenIXt065pWrnDWBC0KJYILtyx+5SFG3/x6HYNie98KcF390/QwWecL58KuqFcSipxXcgMq0jGfoavOzFTGDAJ+sQna72I51/tRCC0Rixps8U2XUORvGf/sYjKakHLFjMy+NqMd0V0epmcDGNqk9YLRtG4BpHBPoqT7jXHO+qQGOo5MXiuhrXNJw8JmjDRV8npZeltGdeFCotrMVHN/d5I6beQCOwUkxmbuXp285vK1VO9Kqhxf8A64Rue8/Qg+gqRip/oxMNckmZnxpjVg43VUItgISyBZ9ZV1Us63eqtSTzaDhJL9cJ8cNeo5VlVC11gGllHtlw6jj48pT7NlUgomvPaYnFZtQDq8kVVsYoJ/mSSkzTKZrhMkRGPZySybqtH3MMeGhJLy2EOCirPPCbjOpe1e4DphjFnbS0wUzegnRdFwjME/m8pyvoPihESFWs5B3ASmN8ubxk9fTXdmE9o+WKBBLbrAXD5/G6pNBE0xwMlVa/fkx+HWD/8yUwyI4VxWryr4PB/I5jq0gnCfwEIfW5AIpkUnaMSE57yUc/gVw2lE9nG28nH2usBQ7CkFkwU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8826eab4-3adf-4ae7-ab1f-08de31a41b4b
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2025 13:10:03.6667
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NWpz4dU267kOhJ+GEY0JcIdm3+JawV5/k+PV5RxTLSzHI1ZsT5daH/jGodvQThXqW0ZsGV0CoHWPOe6qdoLMknIUapluKxS/WC3cuy7qWBo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB7741
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-01_01,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2512020106
X-Authority-Analysis: v=2.4 cv=QMplhwLL c=1 sm=1 tr=0 ts=692ee530 b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=wP3pNCr1ah4A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=VTvLC1XZNYD7R9iNdtAA:9 a=MTAcVbZMd_8A:10 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: 2XuIMA8RhEPv_H9UyX6rwo_Qu_Rpozsh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAyMDEwNSBTYWx0ZWRfX/zgYvS2NybsN
 aBYMzOf3vY1/TeXPAYefcfJgtMpoLyL/j0IH14ufjJ6kxcSHjpE2ziLKfZ5a1O/5XSHzia3ddL6
 Cuj66Oc/dPcCaE+KYfmv+2Lnx12jVxICpO/30K0rVmrjaaqgSpeg6jH6JUGKCR4Z52GJMRD+Oge
 Kprjpy7yrXG7Es49E09tbKSY+Fw94BEgFzrW9TqazlzjN+Ac0DGRXU4w7DGf4Oy8IXnd/WhVOTH
 7XKSJMgZv5Eoj7oOlAjHU2YW+bYQNReWmiE2o4b9amGC95L97daB9IRio1BpQfA81sdCslx6yKR
 q9hS7c6wU3ne78nNCSU38KKvHUuNlLDJqE05p0opYFEoa8U2gkpxmtfb8vFTVgVQ1RaKOsM4aXu
 g6xF9+trLy0qkbxIWRnROsMoFNfMx2OQxSi7RhZ2xLqXHQ5cXBs=
X-Proofpoint-GUID: 2XuIMA8RhEPv_H9UyX6rwo_Qu_Rpozsh


Niklas,

> Add a new quirk ATA_QUIRK_MAX_SEC, which has a separate table with
> device specific values.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
