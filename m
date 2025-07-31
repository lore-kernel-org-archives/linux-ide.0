Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8C219ED
	for <linux-ide@vger.kernel.org>; Thu, 31 Jul 2025 03:04:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753931093; cv=fail; b=LptSbLgiDrpVK0fHlCAN+MGobgRddjr1vze8+YK8BxpuLnpXcnR5lwVrqU+iS/Hdtu6+Vz4EivpIVdqATDceg1p/7w3Ou54FXzGB4EXDwzYnrKd1Yj22st/hA9UblVBFTo2jPPUqAZRosBFnMqKCNrwU2IDLRtJJy5ndA3mAy0s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753931093; c=relaxed/simple;
	bh=cpoT5dKmqUd75xSNoKdItLennZ96VebbrfOm3i6cKuY=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=lyDp0sJxwuzThLU35+SAH+2bKxWSnLO+2YCPPLxE6MOYIZ8zuRTaIimyxnj4LSqNzDwIb/arQy73TCLxJ2cGZUBvRJ3jRL4pfsCYmA92XphgRpVULXafg5W0BocErdGYwfJeTF4dEaNgxqOeUIlJotglv7YUmTxn17SNHRymdLc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=VbsO2lbq; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=fo+ZuRPL; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="VbsO2lbq";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="fo+ZuRPL"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V2hT65027169;
	Thu, 31 Jul 2025 03:04:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=WANnbk5qMkUQmTAXP9
	6cYqzVMRBRRSsRguo0ncilXo4=; b=VbsO2lbqafnMyqV0yXA777gV+G2DweKoTx
	o9LKuZACLXHcWFW6Y8DdFtkDyg6uJtFFohcGgRPaP0ZW2uYwh22qNgKKV4LABKBQ
	EW2HbBC3vW3vw/9KPLpXUnl2XDvINwLIKYSWX2jSM3Meph4EoP8OFOfqtcjP2GUO
	uOFbrBd7Ou74IzMco1Ds4YJvedR0AhSplr8jfNofrePEDgDVwSIV7GUfEOboNilK
	X9YizXhAsgSxti/E41G5eGzNDcVf/Udg2QYlsdAZxxBzZwmNWZ2eMlH36p6609ev
	N3nIbjS2oCwfCkTPNaKb0oinneqIAfYhrprAf3tJ5k6pc9oFmg5Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q4eb9j4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 03:04:38 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V1S7hb011303;
	Thu, 31 Jul 2025 03:04:37 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2062.outbound.protection.outlook.com [40.107.212.62])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfbsea9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 03:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AxHoTLWOzkkDmVlbC6iU2sswSX7gL5A2WEVkVaFq8GzecVLMozTdh3/rOmyYaDvHHsVoT7iouLVBkkOKhPlpgbkhQr1NoibOehKqtxW+UIcPh61sU2XqC6LEkg/UZIU0Km4KZCnylOmTiZw4IUQEgkbe9Vx4XR6OoN4/1ovNjYk2XJkwhLa1GpN99ws3zHLLn6dni5p80rtcsCuOfyH1A6MP1jklw7hSOH0+GO9z4+0Ze6kkGeHXHPvzxr55q7LlwFz+4ZI9iFWTNxpX3Y9kcRC9mv8RAIjlDK/iTN5nzClfPyKJTuwirOT3Mb1L+OYMa5Y/p5C+mbix9sOF6kkn6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WANnbk5qMkUQmTAXP96cYqzVMRBRRSsRguo0ncilXo4=;
 b=Mk5fa7I/1J1Z+WPJDHpzf0MPrRjv5XWQk+XuJPKNTE9rjBeFBm4xOQOGSUyqY/Ucfo2MoQ4teRbXk4lkLlZ/aAME7NDCpBznGOdlK1YQDTH00nYzmtOfEILK4zV6oKMSeyaSZCYlZyfs2FkShK061bjJB/GqLHeCKIl9FIyrY686vydielvwPRhwJq9xBuMLmdGpy4XPargqzCvve0ICM/Np2iibpiBEOX2ntkYGk2Mr9CE7wjlUlMEgwOTBRCS2VCN72VsYlHU+Ct0ish9wu7TNRByh+3Ci6VQRPQJY4AsxiofSZe2BQO0P6ucQ8TTV58KkCR+Z4I6AQs+12FsQaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WANnbk5qMkUQmTAXP96cYqzVMRBRRSsRguo0ncilXo4=;
 b=fo+ZuRPL70FroUzFR3Mz6vr015XcKv10zp1Rm3dYtTXmSD0Ir9LoJjUn9LuFkVTxeIkOXC1gu5sZFXaTKpVBuuOBlPmNMtSQ0blMPKm9VR9ZGP8y214XMrRCE1jU2mA1b+KRfLUCA0Fy0gpaG8H+Usi/Sn/adpZ1WvSpM1lh6R8=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA0PR10MB7642.namprd10.prod.outlook.com (2603:10b6:208:481::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 31 Jul
 2025 03:04:35 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 03:04:34 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
        Hannes
 Reinecke <hare@suse.de>, Lorenz Brun <lorenz@brun.one>,
        Brandon Schwartz
 <Brandon.Schwartz@wdc.com>
Subject: Re: [PATCH 0/2] Fixedup status+error translation to sense key/code
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250730002441.332816-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Wed, 30 Jul 2025 09:24:39 +0900")
Organization: Oracle Corporation
Message-ID: <yq14iuthxhx.fsf@ca-mkp.ca.oracle.com>
References: <20250730002441.332816-1-dlemoal@kernel.org>
Date: Wed, 30 Jul 2025 23:04:32 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH5P220CA0004.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:34a::16) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA0PR10MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: b590d0b1-0397-4cce-11ee-08ddcfdefa5f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Ti0fpl04J/0PuDuONEcpJQNqF4Y2CZIvKMW4867iaERZBTxpel5wxLkXTBx2?=
 =?us-ascii?Q?B0u1ppFo+nIQmujHoZ5kv8JUCCrX8SXn9WsDyffUruiWyqTJsGQ7uOmr+2Qs?=
 =?us-ascii?Q?hJ/ENnOSEHZBiqlO7pDJR1YJrqw08a3Yt4U7NZtBvZtvuKrHANYkV3imnaN/?=
 =?us-ascii?Q?g3fquZTCEeW4BHv/QA11QIPX9K11jPz7m3DUVUvoQ067b7eAoF4CL4dQMc06?=
 =?us-ascii?Q?P7IHBmUm7+RgyUpv3v2J5aupwj0uiq0l2Rq5ixoISuK1//v5baFnGDSjpNIo?=
 =?us-ascii?Q?G738Qnq7jN/dL0tpnzYdrjSngLTmT/L9WcpR2pgPWld1oNeDKXodpIjjnzjX?=
 =?us-ascii?Q?c3N1Wt1SZoknCi5INwUCC56YFyHSoxL7t3G0nehkvKKBX6cxgvfaBeRHsIRq?=
 =?us-ascii?Q?A8mO8u5rkBzsBa9aSqB4qCnRXsdx/XurKI1x+AgUYmN/NkORNMI05QkG/K7L?=
 =?us-ascii?Q?X7acBA7X2tHLtGDnMo5/r3owmXhyThmx7ilzMUWK6QfwFqZoBLWMCtLgJ/FR?=
 =?us-ascii?Q?XRnFhSrmG101uDFpgreC1q00jbFKIrTz1itbnOpGnr+WVDCA7fjp4HekvNeK?=
 =?us-ascii?Q?BbkMsM8IHeMPXd0sHfsD7rTBUpyg6vrzUYlLxSNfqN1fV8v2p1gHuAcjDy7w?=
 =?us-ascii?Q?4EcrHiiQ0hPynFKSbjEPlF5l0N7E+4msCT4CYE4SUR6L31zhhcy53HgGO4uN?=
 =?us-ascii?Q?o/L9qRaBBXYKjHCc/NXZE7+DtnXhf07clVeKzFuQBkcxpr7UsNV1PBpzMhTH?=
 =?us-ascii?Q?HEVPVONU6LUNnVUL9fBbw0vVa39l2MhL9GiS22ZW4Z4naRAYSP20SitxYc1X?=
 =?us-ascii?Q?fPICvDQ/sVFlyG2s+BVdS1fTs/N6tk422ZRbyLLzqVHf5dM5i95thLixGibR?=
 =?us-ascii?Q?/HA4bomwpx2IAlF9MtExqv5nZvoCHHMJ+K26j0Xtpi9ZzRuV9BRkmloiCu5J?=
 =?us-ascii?Q?I3TV6FSr9m5ZnQRqqkY3TX0xjq4o1PQE3ZQqgs73oYmcyKSenepftPxmwCZO?=
 =?us-ascii?Q?2GL+poZISYDHkSUzRwy2ZSPfGiDr2yDpfX8xbM3USBBm/VRYw1vhv5qDAZqm?=
 =?us-ascii?Q?YzhmohZhoaAPn1Boh+vI2n6h2sWw2QmekHHXM7+VU424UZAI3X/8ooZJtqSV?=
 =?us-ascii?Q?wTih/0GaNQeHq8PTfXZ6YlUlzO8PXnjpozFBQAdvGAqaQf+KQKsyhRl8z99y?=
 =?us-ascii?Q?Ai9A+vr9X1WyLcDwjW6MJelZnnCopZl+0IeubuiSgVqSHcnIN1st8gJti3Uy?=
 =?us-ascii?Q?edPcebkgDA/xm02kdsc/SxhW8SSjaZzN1qWg/PttlPfTv2jbtHvjtG4aG2pf?=
 =?us-ascii?Q?EvT7l5WVC5ZKXRyt+Dck0nCYbEb3hZfugmvirmgaecFqcweSb2uQcIWI+h0x?=
 =?us-ascii?Q?UWy4FCVPsIy0IpfpsoSkv2hwnYE2bgGPm8Dvll+XPviyuSA2XBIgHKn3Kv40?=
 =?us-ascii?Q?8+aUP4sX0oI=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3+f1mS77G4D/UvHYsJyV61nXl5hv6AXm3Yd4Yu8hVe28fXg2ol59cnNctTO+?=
 =?us-ascii?Q?Lih1VgysWwZbGm5nYwtIa5dIZqg9fuvH8Ac6/gdIblFjaYY5yX8wkVf5ApzI?=
 =?us-ascii?Q?hudpUnfRr6UPwU/BjKWENq6RY/W27klcBQ4GfywGtDvy5kKR5ymKy7fb83I1?=
 =?us-ascii?Q?+B11cwxgivux3K3GEPLuHjVswNsFR+2qgVx9gx/i0MqzDocNo0NrjqhEfq3I?=
 =?us-ascii?Q?XQw9QbgNCAeb9mY3OhTA5HCqqQaTPxn2mpRuetT2wt07JNVhUZkvnVnBk2nt?=
 =?us-ascii?Q?ZeXMna/QWTBtVu0+T1Ow2Ojs2ejE7cVt2CvImNSRdqC1xQ+Qfql3x2Od4gAq?=
 =?us-ascii?Q?OgnR6BdMt5nFekCRYEEju/thgytzuIR/b+W8tu6nXAKR5wHsX2JDH+1p8qi/?=
 =?us-ascii?Q?9ciJ3Q6cW9RnosjsuQpZmhmmC4jXXGUTzfUugsZa0iP2u3dSnjC142XPdz8Z?=
 =?us-ascii?Q?n1IbnWACxQzAU27m8cDCxypdcBamCSoHuPtVOej1iywwtWMe9pYxnNaROEjp?=
 =?us-ascii?Q?Wh6LfD8Dm4tssHptLZNtXtXUei2WMQAcnOVKYXGSUVS1nocpn6/KQ/7GOFOj?=
 =?us-ascii?Q?EPHJyxG8QlflwH86oJKcYvOys5CLe4flheF7PGWP4WHzUXGf/PGADPUp0Pnu?=
 =?us-ascii?Q?94UY7e8MOA74aGKkQTwwr4vvvSlph/+b3Jv2rabnZZD0QcYjQ7ALocwgMhlx?=
 =?us-ascii?Q?a129IbvU1LD+g2zDgFRJzybcsWeq6yUWyiZBDHLG4HM0grQ3LU91X8ogO1Bv?=
 =?us-ascii?Q?FDvLrOtv4v7KEOPFFjxpv/2KNZonCaqnJwFa0lOdCC11FShYrMw8RuER+Qcd?=
 =?us-ascii?Q?6yh6b7dqsGQHRHtkLZdAIhWYOOwwYJteMayGwPdMtge5ZFGU63xoeHumhhVA?=
 =?us-ascii?Q?XlcwRJa8CTa/hORFXXnAbAT5VptLjrpa9o+/kYx8xW8J5p8Oz+olQVO8Xu0S?=
 =?us-ascii?Q?X6hLXf9AJ1cZmGfsjGkzphb/mJIAHly7Dg2PCECCj6dHGXQwMbPbgGjwvOT5?=
 =?us-ascii?Q?jpJl48oCGTQgPAaALJM/MrLYCzmk7Im7BtKUbFpHl+hxg23uGzwPb7lG9yoq?=
 =?us-ascii?Q?LkhV87mO0Ki1naEo7MDK3HKf93flRLXY5cfr7tNkC1mDg4KwRaaubmlMnoG1?=
 =?us-ascii?Q?9Bzh3z15SINfzMN2du+sd0R+D2mHJmX6Z8MzhZjX4Wvi8yiBFWDi3Ei3jL4g?=
 =?us-ascii?Q?sLPYbpqUPviKm8lz4E9WK3I8PViRVJYynEy3gkZ+y43d3SKYpjfGFanGQwrF?=
 =?us-ascii?Q?n0yVlF1u4KIVr4VpLJKrPPrTN/CuWzCLE5EHnFXFEB3/0mOXG6NPB6ydOEQc?=
 =?us-ascii?Q?FJM9j+o1jBF0JHjdfh7ufzI0cXTlCB/KXDxYXdsGCrIy7ufp28kPgTvba6g5?=
 =?us-ascii?Q?/MZNR5FFzyizA6Z1G322Uiyv/odhof8VGd8zHnw6Vx0z96847jWLpcN6AWTK?=
 =?us-ascii?Q?lUKkjoIJeQKtb4O9NRQ31fBmBdMuXnGeWr5B0939Hyh2//g8qzqN6DDijVzx?=
 =?us-ascii?Q?6oTxKrGn8aN0a0epLPVD5LXRYK6KpeQl5ZdrBcoegMDB/75z8oA50HGS7Cyo?=
 =?us-ascii?Q?5FmpUmMueg0VlWOmtyzI3O6h0bOfvHmFFSBCPKr41oNYhDNsOXxx6PVpKVQu?=
 =?us-ascii?Q?jw=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	D+fcZSnxWMFUVV0wnApMhgnp1VMWsBFWwmAN/Pq5BxLDMqqeEkrXbKYuE1QsDzdpsvK0E6j9PG0VxPWV/wNMZgBSsu7DUj+m6PS0FC3Kxx3I/RnW3As/Q3yOzUCme9MSaQYu47Sj1p3mu2s53cT0zDo8fvIT+AtQudFDK7tt69MjhKOf93a6yzpjYT6lwlovGrtUmabTGZF7bF3AH/qYw8MtxJGqpjuJhAOCj06Nh57J5zmLvyA/nyea3H+uLWSN9pMuImqOW92FGWsIx60w1z5ftDoE51wS4j67uLh9BYHJPxMK2xz9c83pQWYTpKAXjXI1sNvS/00d2Km5OU4D/QAczRIfv4Cp4d+yKkQmS/SaTcn+8vFJxz2tCCJrK4YIvkc1taRsCIlT3+3ftoYZTfvamEQG7UdahAeeG5mscDeZ25NwAut8blb56CaNpmiaB9P39N9Q2MC3r1sRjznypkxMWDd5u5NE/RJKmoOOXi7RFBPa1vzS63DAWvMvF89nqYRNJ8VZCHDmZnFDLh0NF8398/xSFsjpmzjOVcwD6VMVcQSGU36vd9FNYKLaCx8msU6bqKR/kmPhDWLFXzj3HKOtUWHJUha1Pcp9SywiGDw=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b590d0b1-0397-4cce-11ee-08ddcfdefa5f
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 03:04:34.7896
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mU69JKnid+G3oXDV0+LMKB8Cp7waDxsEb2VRHyVi1j714CqPkuqru8wIKQLzU4UfJx4FAkcsedbi9zVVMIvi9Gfjgho3UlIxayggf4dssng=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 mlxscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2507310020
X-Proofpoint-ORIG-GUID: 56QC3v1tWWeF90iYvLo_C_lecJqHqngK
X-Proofpoint-GUID: 56QC3v1tWWeF90iYvLo_C_lecJqHqngK
X-Authority-Analysis: v=2.4 cv=QZtmvtbv c=1 sm=1 tr=0 ts=688add46 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=hGHsbcgFVn3qn4SNk3cA:9 cc=ntf
 awl=host:13604
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAyMCBTYWx0ZWRfX2ZJdgyh+rfA2
 o5EPL8IB+GwPNykmMsVfoqWm2JVO9VQmk3suiVFSkCr+W9z+9WlVmnJK9KfCHSg8NP/EG5sVh5U
 9A8Z8LD5cgu5cMK4j3k+9BNSV0fHKyUnxdBbzSWOx5eAnaq62meFi8LY7ZdNKfY22J0Y+pp11PB
 i+SDavef3fHU0m1p9mg2zItgib/X483CsGIzND8R7KSnK4EOmVgneN9TKAvh3VSICAOBuFfD4sH
 SlEw8rYJYlyzfVixAgajQw4wtUSYiU74LI0tj++RzPHkimrdaQ9dKnLP+E85JOgO0syRc2rlpXz
 Idf3fia0HEndH5/Z0ylcznm4DFpbkfYoXbdwk8khE1jrkOQG+aVaYQHVkW5b5IdlqavmV4bU9uh
 /HL4Cvc5KOjlu6OJmwKdFleC3QAjQK1fzgLaduapFfvtCQ918VmoyEbyIc7zcUJWUXyWbKj9


Damien,

> A couple of patches to fix issues with the translation of a failed qc
> status and error into a sense key and sense code. The first patch fixes
> a long standing problem leading to nonsensical sense reports for failed
> commands.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
