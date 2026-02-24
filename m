Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB06F33D4EC
	for <linux-ide@vger.kernel.org>; Tue, 24 Feb 2026 21:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771968131; cv=fail; b=Z3doz17drIHXbhrvAw5vTp3eixucWUYdgB3szT0967QoTIWj08v3gw3+4k97nUXjxYXEFoGuN9FkRDY8EuPPED2MU+IqLQp84OFInXiSEMlox89DAkvbGVD3YdXO1ziZQsJdLFoaxKHAX0GVfZD/gFGywe1+mgEn7Ft0oX0PvHY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771968131; c=relaxed/simple;
	bh=Zk9gxa3zWiTouhqJv2ezSBXMKO/8ENrNUldJgSUGFA4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=q98ar/dBjsvRDmoGg1YSXsGE6G1YhH4VVkEhc3a3F/6QhaKortTNlkr8zovIM2YpfGDucdUuxBWl4AiiEcQdWnrqfLx6X5LktcRPYm/Ydbo5n7N+lm7+or/qkWmUb2dXZtFZi6LfbskGvtYou+Tn8fno+mrvULDmYz6nv0vjFMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=WMjtu9zp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=wCPFHUNl; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="WMjtu9zp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="wCPFHUNl"
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 61OIu1mm4019369;
	Tue, 24 Feb 2026 21:22:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7wyyEsyhzpFmTVGmeV
	htE/lUWP+F8UQ2yD85FBimoV0=; b=WMjtu9zpEpox2j3pMEobqklhTv9oISP8xs
	jcMj3BtNcjnWsFMsezODqELxYmqCD23Ypy6lVYpN3IGTqhGvRC/4Kf4FDuVcud8D
	cuB19zW130AAChamugckTntX5PATVR/P95CqZiGFnt/zKDwtHp1R9tZqlBd+LmJf
	8z/GJPOBRJlR1qczYStbunqRLW6ps7HYJ/PVCyVEak2wJC8Q4Qw7MjWXkF1TyZwF
	hBrD5dlnyWSTFuOqfNTzpLzdNhK1EHVpQAaNKUt6UbxDElELViC8RnvRhMK9WT8G
	ktRugKmm9v60QXIvY1lNW5ybqqkMhexcnsp7OF8grKInJq/MJsGw==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cf3a055ap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 21:22:07 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 61OL1BUE038441;
	Tue, 24 Feb 2026 21:22:06 GMT
Received: from sj2pr03cu001.outbound.protection.outlook.com (mail-westusazon11012065.outbound.protection.outlook.com [52.101.43.65])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cf35mg4vd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 24 Feb 2026 21:22:06 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zrm3XtETRyd6GuUrAEZ4DBGcmJtIzWMldUd9x6cJ4PRml21MEe/bgog1mSHYtHBKA12y4Ayf7L+vO/5GvF8P80H+98TslUOLS9xZeoZVQe/14kvD6s3RQvrkjGhIqV91YMTK0f4JPyU0JfRaWYcsXjsqtbDL6sT92NKjfkD762OYQe1cgcKfd45mxBwAMr+Y7dgoPT0aO1phoQTUs0cF5DbAkjO9/1SzZuRk5MMD10ldPBRYGA8GKyzUqnhLLJdxLE2dpxe6eR/dI6xQpz+v1Dwjmxzl8G5OpuXt1WJ5Y7kuKv+YNbiGOPt2z0m7zOvHtUOo3mJPNJPNKOrkviLGMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7wyyEsyhzpFmTVGmeVhtE/lUWP+F8UQ2yD85FBimoV0=;
 b=kKT/CzhEIRXrU5SWiqHaD+uByxZyd9TGYeLnUdh9RTw0XlGI37BhYBVx0fTNASLWgvknZiLn4+8WeMhCXkAhJGiyFVRAPv+EenwDeprtgMvZU9G11YrduDtvSa4eF0ls2vdFDNikp7Txt3XZL5pgpZzoeK+wD6oExiiDKG/+AqZojb7FMjXU2Dg+vcHSNEsekknzQmfKpfEng0H7P36b3r8TSu1dgP7VNdfLDhRLF+hMx1OPrcwyzdPwrLOqK1EPstps1bP9+j7ZAKbD7tZ75bguTjtvqlmP+hULlcHP2uO5qlzxma1fDD65Lf14IgKkou49xz4i55mBTjgJCWT7kQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7wyyEsyhzpFmTVGmeVhtE/lUWP+F8UQ2yD85FBimoV0=;
 b=wCPFHUNldyfLMpt6LbliOGtbcJVIVcHkCu6qWgMw9AoEC9OjoyalWIpzsZVRfKrZF7VrGi2jZCFQcvo3Ieh09sd4oJc3rVPdwSb0afWz3+EFQysjlPPw5slIvcZYyOXVrB1ZM5l1qXxpg9thZft+jVan06LAeLADiD55QRRDTJA=
Received: from DS7PR10MB5344.namprd10.prod.outlook.com (2603:10b6:5:3ab::6) by
 PH8PR10MB6340.namprd10.prod.outlook.com (2603:10b6:510:1cf::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.22; Tue, 24 Feb 2026 21:22:01 +0000
Received: from DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::21c0:ebf5:641:3dee]) by DS7PR10MB5344.namprd10.prod.outlook.com
 ([fe80::21c0:ebf5:641:3dee%6]) with mapi id 15.20.9632.017; Tue, 24 Feb 2026
 21:22:01 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>
Subject: Re: [PATCH] ata: libata-eh: avoid unnecessary calls to
 ata_scsi_port_error_handler()
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260224020638.1194842-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Tue, 24 Feb 2026 11:06:38 +0900")
Organization: Oracle Corporation
Message-ID: <yq1bjhd7s7w.fsf@ca-mkp.ca.oracle.com>
References: <20260224020638.1194842-1-dlemoal@kernel.org>
Date: Tue, 24 Feb 2026 16:21:59 -0500
Content-Type: text/plain
X-ClientProxiedBy: YT3PR01CA0118.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:85::32) To DS7PR10MB5344.namprd10.prod.outlook.com
 (2603:10b6:5:3ab::6)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS7PR10MB5344:EE_|PH8PR10MB6340:EE_
X-MS-Office365-Filtering-Correlation-Id: ba133e7e-19d1-431a-6dd0-08de73eabfba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?b4IxKFkscA5u+gABiElSVtUJlndsoW1wnN7+U8TynzCvf/8vb09U3M1YjB07?=
 =?us-ascii?Q?EizIfc4XVrJGLkeLWZmiyW8ZD8oq0xIdnMW6jgpAFIWEyxhWs2ghZZxeuz1h?=
 =?us-ascii?Q?80jgD1udlH76BC30/cCBnFQ+mXF8qi7D03nh0mNGt5Tvfw8U3Q7xt2W9Yb3F?=
 =?us-ascii?Q?7RtwePk2iMjaK+5DU8EBYenhtfl3hkamI+skh6VlH0JRrk3JwS+zpxgYuQsg?=
 =?us-ascii?Q?i8wWi3eoqxqduB1jcL+5WOo6ucB/nnA+VevkgSBWJUhoos2e7PPzcP/5rcN7?=
 =?us-ascii?Q?//eq56OhyaTNX1dtb2PYP5YbaV09LbUVqivHYFes2B+Nf3PZ4hun+HmEmMDf?=
 =?us-ascii?Q?L2863cLor53ZemJ2KjwBvhxJFVl+nYkbnRAuLc53hmOg70L0sawFh48Fmc7l?=
 =?us-ascii?Q?m0JEf+o5+1FznHmn2eyfzqO9tf3C3EyKvGXLQ7yCYEMXsUZnCZ7uU+eK8vR5?=
 =?us-ascii?Q?y1qJxt/i/TBoGYGYZp7cOW9aNSeYhsgjQLsHwNhbiQL/0/sdPmUy38r4YCKD?=
 =?us-ascii?Q?gCOve3EFfEyY2qUbsO9x0F+5UBxm83GI7521CEJD7AW9smEFntxR65XdFSyh?=
 =?us-ascii?Q?f9C2H+atoNNr7UdrD7Lbb4D1M9Wtl35NhqnJuhFAvIVjW1qj7ViFTdqZaK2j?=
 =?us-ascii?Q?aqbdir8wxzObCMZwKiEYstQkP89l3Ewrbj9nwOd9oFW6ldXfphjfwOVJPWhJ?=
 =?us-ascii?Q?hGC21tFsj/Tgycr5jGVVmcz4xhpauZtzE25Dk97KiehXHz7/ZZdkz0cAbX53?=
 =?us-ascii?Q?d2AVz4Fmox6f0ANcMLo6opzbPTSh0SSWXrR0+fzJzx7CyDpfJRjpfz1ULKjH?=
 =?us-ascii?Q?vpqw2/dy9zKoKoulg6iXyLBEnZlwN2CbijFwfzeV35hkdsQK5T8L+1XYoxa4?=
 =?us-ascii?Q?rN9y7JlhTsfd7WMW6tIUlCVW6xYtksUps3F3r5qFUeObTytrrxT7o0/JrxBU?=
 =?us-ascii?Q?XAR9/pw4/+qRckwyRM3UVo238KYvILxx5fBeaeoq9RpdzJOn51eB/+1rt58P?=
 =?us-ascii?Q?vslSX1Iie+74Q7PZ2w4fp9X+OSGzMlgW5gqCZbL03QeX95QMKVkrpV4nbAbx?=
 =?us-ascii?Q?XH3Kl1ho8ElyZTH1b/x4zbBILw6/Ewjm6zzl8c2G1sp1QbMFR0N9M3uTgjNZ?=
 =?us-ascii?Q?Qiuly/+Dw79TyrVw7fz6NsDLOUwp5l/R49JZln7UnB3dpGfRgCGBtNAbL5le?=
 =?us-ascii?Q?7VpPIE5fPNBlUVYoCAsmnaf4J+2ZMLZuxcDPFz0MMVj+VK2dPFgLxUflIqrO?=
 =?us-ascii?Q?5I51zL9bZoQbss/UGNOjg8XXbdnyIADMa3zPKGGyRFF8V4fdM9yc6F0fnulw?=
 =?us-ascii?Q?6RBZvB5NdS0lxDmIj1ZIzXjtLgkOYC+/qRfoQtT6o48vvOMSo5KZrCBQJSAW?=
 =?us-ascii?Q?xFfBnl3V+i2Rj85NAKm+RIBtq3E13zvAhtEaCAesSjNFly5kVo2VstkP7NHP?=
 =?us-ascii?Q?BEEcX+/LbSU/shkZ2VY5/nQ+lj/VrNuc5w8PDlQ4FLOmEqy5waaE3dciL1ER?=
 =?us-ascii?Q?0xGGYtdU/kLtcXCB0MC5Y+NYFoFDh4bwCs35WUqOccNIz9mAlsuvL0eD6xkZ?=
 =?us-ascii?Q?8qunwKC5+z6iPtkeSpk=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR10MB5344.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?LFDAYa+KrZoWdo3ZdrO31rfpdLzqTK8bQyoOg/ZSXW3xOO6Q+6yWv042xL6A?=
 =?us-ascii?Q?nQhT7f2IR4rKjeKxxNcAxG0TYrFV3cHUCor9iZUe6k5WUyDC7OGVp6aUMSQP?=
 =?us-ascii?Q?X/JnOVJl3+pg9WavAMQ1OwS7yLmBID0VES7NtwFPAdG5KMn8DrnFv0V/Vb3W?=
 =?us-ascii?Q?OKMrsd8mwVQye/ecMiuzFIeNYZ8sF2Tgy17XUpThrdetFKm1cSuxycZH/+gc?=
 =?us-ascii?Q?cRa+1YbzfvdDZb9mSVJjhCtohKfIwke5WSzp4x1/AQHmMDe+Sj6o9YSjftMT?=
 =?us-ascii?Q?pkZue4IXKULSmsBWpeEQPvVFWb8g88aLeJhuZlesjs2VQgvInCaMCdjHAsAX?=
 =?us-ascii?Q?JTdyu7amkWB6dXC6O76m7JTMP/4iAxpqCu0Jbwi5jSWfrk+WAEHSzZQOA4rD?=
 =?us-ascii?Q?no8OtZUCJ+spN+43q6a0zxircElX/pMBuq80jDuhI4axi/OlAYmIEnP0wVI1?=
 =?us-ascii?Q?tN/kajv8a+Ag4F5t7gkaqqiGpbKF6QEBIDrUmybicb/uCRd14cJrdwBO3cdI?=
 =?us-ascii?Q?OultIDLDdSJvfqtFm/KZHC5RZvl2ob77emMJTTKPgqH1YkeL8YmhHxVz1zLI?=
 =?us-ascii?Q?jKFeCTtmtUoeEpxrpjkXxY6hMCoPhTaiRdHZKRAEykgVaugCvOPOlofnssIX?=
 =?us-ascii?Q?3uNmH4EINGnAR/bnFItvzAUgAYSlz0R6e2iG4uo7cVf29yOvyBpnqO6Do/2n?=
 =?us-ascii?Q?blOXfzO6C1HB0HhCyQM8QY8Oaf4iO3aDba5p3/b2++nr33/saW/igu+pfTZI?=
 =?us-ascii?Q?LQdMsw2ksMalBnYZdrAMVOdz0+HU7rduK+EbfNtiv0U81nOUeZ5YKRg+OsrQ?=
 =?us-ascii?Q?wj0Ay/vysp56X3oKZ4fUoSomRQ2qpBXTWTYpw5VtmsWcj9D0HR8vAzcT5Mul?=
 =?us-ascii?Q?SuCJCjoePSC6BOOAm8moMPbAorOmVZgoiX2TcNfjEei3GRxXYYYjH4mwCeei?=
 =?us-ascii?Q?Rmd+16c1xWNGTtB9nSaPGvN4QwT9rCLaQCoW/yh1dTK1XlHcUV03g7iLfW2q?=
 =?us-ascii?Q?6bA9sdSN58B3XmEwzf+PcSGpW7JLw8bqaVGV0fFyYkRGID58XL4PP6RoHRbn?=
 =?us-ascii?Q?d5VBxU/88ICeyQbYdE2lteHuhUBbzT+n2+p6R1Df+ExU1WRHlmtvDHQwXqVp?=
 =?us-ascii?Q?IEFNILhtZdRSY27FZqhBGgBTucMFygAZPMf5Eu7GHnpvMDyAEukwhQPzv7jt?=
 =?us-ascii?Q?VimX32mIxDVkMcDYFkDhBOSCwnL3ZHXaXlW+7neA0J3W58EBRcUpn/vWJa6f?=
 =?us-ascii?Q?JtqNM4v+93VnF2YunDqmsp8rDV15Y2KqSBdda+bQAkEuYny/ceaQUZ8sDIlt?=
 =?us-ascii?Q?neXyeFr3O5s8WEztWpwPrKeODB0nayFId8fiBfrYIidTt3HSGId7KUgHcTyF?=
 =?us-ascii?Q?sElrI4oVFWCio1e+uO3b5j/HvwSvtrb7bpV2ae+30x39RWPsaH27oENQICNS?=
 =?us-ascii?Q?pyNHWrMOwe2yhMN+Oyi4kr70QgHHADal3WOQVTNQ7JIjVXRLcYWXaw0TMCOz?=
 =?us-ascii?Q?tKc3cbgdkm76eqA6TYojkbkjZoZAoKsfBlPKfZsqdoqqcRicZVvd2WVCdGTS?=
 =?us-ascii?Q?De489os0rlLjKrkZntTGSFVfPyDQ+/22VsCHjpmygYx4KFQD2WJ1DqZmgaOE?=
 =?us-ascii?Q?dNiMnRcahFmvfpZ+09T2PRhgIO30WXokmbe41tWV1zENe+Ea4oI92DhJybAn?=
 =?us-ascii?Q?fSnR4zAxiozI6yzntQ4cscRxk2Drfg/4kZtcm9GifZYSegWaIR5PfdeNBv6K?=
 =?us-ascii?Q?Rt3zzERLGaH4Kt2tb00NMnC82sodyPI=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	HYEpO/aWKWPw6H6C7XohHM4QE0rHtebObyVQmrn89href0v9XWMN8dCmiT74JJ5HvUrJiC7voPaRmma3Azr/vY5FG4qVC2LbT6YM8X6NPAQySXDMhmvrkksQF16GboUaKLucPIJGQnCGl8FXoJ2qpY49jY4L+QCQGPmEhB4BnWpU+Ai7Y0sHeBQTYnEijT6Iz1KxkfG6owdHzoP/w8/fwiSMwAQxedeQJDFJDuklMVkssbujtG2k9oEvzuur1GmBpRUIfiE/nKNjlt6Qf8CKwCELhTdGAYG49SSW/ndGvAgFI8v1C3LPkSmBUxIboFKFqaTAk/g8LPqjr0d4INXW//QxGbpVQ1TweASFIfWS3syuTEsntuqZyRL8TtX4DY/Fe8myK7BTWIoSUaELqmDZarP2t5rbHrydM7FWIXS7vN8O4ELEto5fUSYmiANRHsXAZu6CTgJDz3D/QNgtvQhZkdMARjzT/TvNTrAd9zFrVwU5Onr3QzXUD39Ziz1+bjHhfSYoc+t9zTdGt0+4JovS2gsbLw4BME/BGwBoEzWSMmaFRTLY2wTeVv9rrB4JIaJobZe1dkwsq5tzAYib1W/HFcvVtpkS+dgkcm/X0WrjFjA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ba133e7e-19d1-431a-6dd0-08de73eabfba
X-MS-Exchange-CrossTenant-AuthSource: DS7PR10MB5344.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2026 21:22:01.0449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sOq/xlqdn9eoSWRmAL4hFOLJLqMdaef3ie/siPMJBk3VsaisC+hTUJtFiPmJPFL/I1mLyccQr/soN4e/s/Le7fPHuJwzSFiK7XYBsWh/nKs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR10MB6340
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-24_03,2026-02-23_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 suspectscore=0
 spamscore=0 bulkscore=0 adultscore=0 malwarescore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2602130000
 definitions=main-2602240185
X-Authority-Analysis: v=2.4 cv=IskTsb/g c=1 sm=1 tr=0 ts=699e167f b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=HzLeVaNsDn8A:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=yPCof4ZbAAAA:8 a=_X5wfC7cYs73iy107gwA:9 cc=ntf
 awl=host:12261
X-Proofpoint-ORIG-GUID: _bqR8ZIP_5Dh4gyR76BNOfUQW3MNHWHe
X-Proofpoint-GUID: _bqR8ZIP_5Dh4gyR76BNOfUQW3MNHWHe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjI0MDE4NSBTYWx0ZWRfXwjENQfNDVimZ
 fi3rvo96XhXre2v4eJHz7qb2rhC+S/msfkR1G2VDFcS6r2HxbS9D6GoZMejRWuRJecjH004vo9T
 XcQ1xP3tBUM9HghnH6IBz5ECOoBnfDCqsbDzhdbzbNRe9flh7ycqFiV/M1MtnK1CH7lfWtR1jZU
 wdf+N5zIxx9H7Vpwrzi4fexX25SDcFk+y1yrvq025T56RFE9JDhItwtBmTCSo+nGYQJ7Cq1QxCN
 q+OeJEVmC2FNEssoVFNz7F/FFSJl99737+d+wa/GI/kMgAPzpQW8HMOrHO4WsDm/z1ESCDnT0LQ
 Mf+v4fLgrwo7oiI+hXL7MG3V6L6vD3CvxTzxGdGsenDanpaUs98jAmDHL5qZgcTqHi4xcjfBo/d
 c/kSEpBbZGiw89LuRB4rDlQCgWqL3ewMS9Qjd83C+S98CY8CZu7Ms/BNvY3nmFcwWpEbhHjHvom
 mh0VuKMKRwPFo9LvCOVC12QLHcliiyNipbC7jhPw=


Damien,

> Modify ata_scsi_cmd_error_handler() to return the number of commands
> that timed out and use this return value in ata_scsi_error() to call
> ata_scsi_port_error_handler() only if we had command timeouts, or if
> the port EH has already been scheduled due to failed commands.
> Otherwise, simply call scsi_eh_flush_done_q() to finish the completed
> commands without running the full port error handling.

Looks OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
