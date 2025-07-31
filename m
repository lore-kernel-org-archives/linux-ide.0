Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A344B219ED
	for <linux-ide@vger.kernel.org>; Thu, 31 Jul 2025 03:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753930972; cv=fail; b=YBy49TODpTjREavWuNbdRcf/AOTrxm8LNoSRAOAXZmaPh9+fWgKVwnwBWCbk2d76KJfFM7jLiBPPJ1SAWxc5FHr6uq6ZKtme8jS/6uxQz5tfJBl3pPLwLKWJ1xGPR40j1e5wf7/IXW+NbRo6ilWDFS6cHuPGWZoTgo33m5tpfpk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753930972; c=relaxed/simple;
	bh=HDuSR9EOtfiJgyaPeFf2VavDiSWGWmV35xRMyYe/tIw=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=qHt+oS13DhasZQMa/ky5pxQGZzaM3QclZYN/+vJMP6S8uLD5TjvhENsiW3KHU9ItU3mJlscl7wjy/wQJKDCJJ8XNoImitlVozK2JWXjlOMmmbGGmpLoP39oEU1tb1Oi+lRLOx0Npjhn9tHARjP6ljAu4yNFtc5B1d+l67H5KsHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=qirVN/4p; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=gCAgcw9y; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="qirVN/4p";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="gCAgcw9y"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56V2gZ3g022567;
	Thu, 31 Jul 2025 03:02:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=OJMlbYaK7uhUNopzhw
	E11IEP6kCejv12O6U/SO7mwto=; b=qirVN/4pRLfCdb7X1N+dlyfpqV1axrX3f/
	ZCjO6Ygr+b7Ly0TziXdjr1x6lg2O9pLzC1hHwiY5yiJdK5AoYYV84ksYPfeiTVx6
	D4y8tInELannzctcAooEVraWXD19eq/frTRrclng1nQQN2Xv4gkNTzm2BXwfDP/v
	vZy4qghi9YkTLukNS6usD5gndNu6eHhVC3YJ4iarlcxhI6KHdWeKf3GmMLERXLtU
	8tWsIRPHrBTQQwAb1QbrIfiY1ITJBY99UHtvKhnTgp/yRmOEE8k1rOR9hF0nLgJA
	LG8iQwqqM/2r/Wc6phHmREAaQC6zYvywvY0xSI5oBd8jd+hIX2qg==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 484q73374p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 03:02:43 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 56V0Jqc4020392;
	Thu, 31 Jul 2025 03:02:42 GMT
Received: from nam02-bn1-obe.outbound.protection.outlook.com (mail-bn1nam02on2089.outbound.protection.outlook.com [40.107.212.89])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 484nfj8pt4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 31 Jul 2025 03:02:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hp9S5ZCKbpdL201FpdsVqMH0Tu4QRkqfy0zDMie/gCrCb8psD4ZdE0yAGs4uAii0OStf63AbZRZ+D4DrT/HO1AttzXzPMMnjyksVc56H/4FC6/YXnyf9VTVDLcjK3l/btJD+FvveUk+lLxZhW9RCzBhpZfMB6ohhGZKlBfA0rD0SH2uQ5iTtR4ZzXEH7l2HQYTCe7bp7Xpc0YddDBpQ1lNrs/T7ZfVDiAglkoq9EOIzKlWLnkrWPk4+hwPnWbPVWmUXK/8i5Ch20ba60zMnZKoiXOo0hXeIkZyxOrQwVs0Q/k1CJLKrjZe9kbTF44MQQladriD2/yYRsJjCa9FvZHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJMlbYaK7uhUNopzhwE11IEP6kCejv12O6U/SO7mwto=;
 b=rhnuRwvCW20xrE8i9lkns5SeVVH16i95UUdDTpz7/hS+uAlZ9+wOTBOZKGzxmaU8SXV6gb3jmj7LTMINKWIMu+HfbwEDpQ/ldfaCOdyhWquwTSv+4fhTMra3b3gVg8WRYymxq1mIUVYsP3L5RjhDzGwhgSRg9s+lCRfV54OLeHiTR5Ddjz+5y0pDS9reDbo0MTxmKK7vAGgkueUmmcqWDPCT1BSmHJOLEG7jNL+CZmvkMVkZf5q8mf5+X4u2aQQrY+Q524F+larF4ws06PNvJJb7WbFspuTK49Iy1ELKhPJGMvzBdTiR7vD++9ezs2DYkvFe2QIiLq+T1V0y9+o/aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJMlbYaK7uhUNopzhwE11IEP6kCejv12O6U/SO7mwto=;
 b=gCAgcw9yQiGIm3Itv8abhi+uQ54guk5Ki2Pqbk4mCLpWuYqfiXa+PGJtBOyWa3gD4787VkKd27/80IBszy18ibcFxYBe4fBVornS7o3Xns7jAjr8H3RtEufP41bhPUAY9J/OJZm02kYiDKP0KQ87r6lS+M0G4BCW7Fep9CMst0Q=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA0PR10MB7642.namprd10.prod.outlook.com (2603:10b6:208:481::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.22; Thu, 31 Jul
 2025 03:02:41 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.8989.011; Thu, 31 Jul 2025
 03:02:40 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
        Borah@web.codeaurora.org,
        Chaitanya Kumar
 <chaitanya.kumar.borah@intel.com>
Subject: Re: [PATCH] ata: libata-sata: Add link_power_management_supported
 sysfs attribute
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20250730001947.332661-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Wed, 30 Jul 2025 09:19:47 +0900")
Organization: Oracle Corporation
Message-ID: <yq1a54lhxl3.fsf@ca-mkp.ca.oracle.com>
References: <20250730001947.332661-1-dlemoal@kernel.org>
Date: Wed, 30 Jul 2025 23:02:38 -0400
Content-Type: text/plain
X-ClientProxiedBy: PH8PR22CA0007.namprd22.prod.outlook.com
 (2603:10b6:510:2d1::12) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA0PR10MB7642:EE_
X-MS-Office365-Filtering-Correlation-Id: 546857e9-ce15-4294-81d0-08ddcfdeb655
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?H7JNpDONfkU2BS1gtSZJjec+U+iNlvMhGmMxhjTLE6QV4aLA+jw0ItGlaePc?=
 =?us-ascii?Q?V9jdjPImBRLDIXGDOLvICQOV/33qXzmMMchuXaoVrEZI3KFA+SAG/kUPA44y?=
 =?us-ascii?Q?+1zuuu9ecjvlhrGsf71EniDupGqJTl/Rr7gzwKVMGLDhk7zp9Yb+jrbQPMBS?=
 =?us-ascii?Q?8y2GouLScJl/K2kiEofD4/Z0jqYKgKpNcTkC62x58dPtv7O+bMNb1xGvBuY6?=
 =?us-ascii?Q?NXDuRq+se1UONG7KMftqx1qZ7ZN4Uc7+RxK1Mni3HWlknhk3fdo+EFb/IODr?=
 =?us-ascii?Q?1esAGgWajlXJ291U1LE9+wex8SOBp16w3bpmFYZcdeQk2b+1K4MlV4y3Cvdx?=
 =?us-ascii?Q?tapVrOI/GP3imIXX9uRbsEUQjdl6jHrTBk6XfuoJiWwqotr7udIz+gO+uPz/?=
 =?us-ascii?Q?ZZfX9FqDZcC93sxBwJrZNwqTZIKh0oCsol1cRP/aKn+oFEcO30NUDu7mPY6U?=
 =?us-ascii?Q?T/aPOEmsX/LcUOtkKVzJiAK6LLFNJPark08e/TadDYXv2XHYS9F90/56fWIm?=
 =?us-ascii?Q?B5pI/z0ElM1NTzjQk2T8TgfcHnIqOPeOYopM8pI4PN/mHnsdqrLVdglNkKwu?=
 =?us-ascii?Q?6DpjdlTHMud6gCTnDeQkgLuZdK6dbdnOFwql2n/Jf1P/7MS6ZOVs1G1z2E/o?=
 =?us-ascii?Q?zzVmJlA3VJFqSps/cFeyh9yY80Fsb2OyM6N5VShxk0nlNRonPA6FTT+6DgvE?=
 =?us-ascii?Q?Spv+obIs8Ad1WNPsqJcVWzVxf+dpExe+5ybQvBAz18l42vpkaMOlv+YDmqw6?=
 =?us-ascii?Q?mbOGv3drNONQiwCduSFFBsuk5LYFgaHSBcD54KHd6lleQCWJ38fW86Duubfn?=
 =?us-ascii?Q?Uk0zLsNSGfUT0H1hfpR2pXIzZxafEglyFh0VVPl8Df/wVrdcGIExds6BzI9V?=
 =?us-ascii?Q?wLMQ+RiSh5kWRpNwCZS0SPSId6lQn/yiRyxfKEm56NWFzz1W4osJkFXnEt/V?=
 =?us-ascii?Q?hQL2aBcrLzzup0MUtpfHRwf6QrbRu/4iRNoh4wfQ6BYzi+PWmDJ4Dnl6ee3e?=
 =?us-ascii?Q?WNK/MFuTbu46lNJH8KmP2VWrcz5ZYULhDo5B6fsRnCmc9bPRZOwo/B7kBoXw?=
 =?us-ascii?Q?Ah1aIuq6xLvL/EEzg9mNQekkqHDVtqDo5mOVDyacDPRGTOMOy1OyAMip7R6z?=
 =?us-ascii?Q?Rmm8C3Zz2YYRBAuO7m86oT0AZ+7xUlod48E9PaleBIoQrTkFYXEftSSE3j7H?=
 =?us-ascii?Q?D5qzTrZp68ntRAjs8/XBFpMYnVVlfrY0Auwrie8IAQ/VYCehksKTE8ee+FBN?=
 =?us-ascii?Q?4UwF2zI4hLq4FlTTcNl3zBY9vuBczXC5YYVMSsy5ZzUd6FBQjJgtlCtUsDK8?=
 =?us-ascii?Q?Ij7Qcr6Q4W76/CWZXvNTLoCeSkloArXG1eL84Lv6Xqc86o0zsM+HCzXwuXP7?=
 =?us-ascii?Q?SsXRNgZ/FCs7ypLp8fUQPUG1wTN3M4rA3jA9TSY2M+O7xF/oAAX6DYX2DNYz?=
 =?us-ascii?Q?ob0sBShRLW0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bGFjy6Cdg5YPIRYs63US5XgkaNR7czoxz/834HLmJoUZKS25BOxgqukq6Be7?=
 =?us-ascii?Q?kHEchommDDpw8wsR/vRdF6GtBeQnR6VT4Vr+LFmhDa8AaCIzls60iTsm37Of?=
 =?us-ascii?Q?P6PIIeyUOVKmA0ChSG/CnBuajYnnEI4aFWhwl3qqwB+U3KEXflOwVubpluFL?=
 =?us-ascii?Q?9EjoNBO8Wrbe90Il6xxn9Qbuxj7RayMer4yqaRMoh5JQnniHwVp7jnpInoYo?=
 =?us-ascii?Q?o+bGI2BmAfe9kPcwrq9lN9K+Sk0645Qi7Y85vtqgFv6q3w+rHdlVlRCXmWRg?=
 =?us-ascii?Q?qsO832inVt7U5XuxX9q/4pGaaQ0GULYyegl4iAsoUfB6BeNDS9RPws/4gG5k?=
 =?us-ascii?Q?MRfVLKMJ7JcjnxKbrIKgsK5gguBWSoufdfHXtbjvUDfn0NkuxvO1fa4KKUek?=
 =?us-ascii?Q?Ou+koRi4KAJxj+pvW0gKSDN4MYgsbMwXXeUOGiWa+hOhprEWvr8Trvmq/Ees?=
 =?us-ascii?Q?XVJV0NCADIx2B3YjpnZqxs+5N16kfv6zLkHYuPrV2REDzgHGp010xO8+JE3K?=
 =?us-ascii?Q?nh05H3f+HJmiRSJDYdIamOrgGSomAL/3XIjKc/a5/Bd2kbOG5CdCquwmEnYo?=
 =?us-ascii?Q?AVOgQeIvT3gA5wm04HdQSWMKmxkkMPavLBBkESI4+q8yuKd+U3HlFB37vuqM?=
 =?us-ascii?Q?7Ipi40+jNQ45v76wsxOBA6c//kCEAD/1MQca6F8sbwm1ai5JEjkihUOVWi7w?=
 =?us-ascii?Q?0NTCYJ96L1naO2KykzMCE60ea2+g7yiN1vGGI8AT3+UEYPt+c7wQUx9GvxNd?=
 =?us-ascii?Q?LZu8sq1sH1nQU0cTf4F4bD1IsT3+ICHfJVnP6sVL/TG7np4i2GSSQr72Svkl?=
 =?us-ascii?Q?N5hSiiAYJ0sEhI1xg00HbO6fMVzfJuFAHSwOKZWaW4eNzbtPxYq1rAPZJxst?=
 =?us-ascii?Q?1IGgsvhf1rdWeGw3YAFHaWa/2HofFTV0ODmcg0NJeKczWT0gjPK6MAUpc6Kl?=
 =?us-ascii?Q?eGdWKgpa8wclzMTXaPIcEPw74gs/pLapBJm1mcLdp+tJn6XeU7d6jim7x7gE?=
 =?us-ascii?Q?omb7/g75eOb9Xol8HMi9VRKDtnzvKz/DRuU/0MhLRjQXi8UREl4TDyPHoEL5?=
 =?us-ascii?Q?wYpT1Q9sTUXk4HBVMHyknevhiLGk4wuzTrpeRKhSxkhyRy2BXO691WUOxKyY?=
 =?us-ascii?Q?1Xq527LjOfo/TWS58aZd2dbaOLfQhiq2qE81eRcx0tP/ZVskgBW41II/D99w?=
 =?us-ascii?Q?0i+Tr7tIy6+HmDor+k/W5uV5G/Gifr3wikIGtPm0sD1Et89HKW5aAPaML/RX?=
 =?us-ascii?Q?HVkTbUB8ZGKvXv2cQq7SJuF47EPeWIh9WkQIY6pr9onpJKG745dECEgYMY2L?=
 =?us-ascii?Q?+ZorP+BEooYRqH5so32BuMhydkTAVPHOCc248EIdN45+magyO6eBSXUO8Ol0?=
 =?us-ascii?Q?BxtDrg8voGfF/ZJUOkvr0HXyqfHzd2nYx7tunRTjDFV7jNc0mbrKHQOfy8+9?=
 =?us-ascii?Q?cytd1FmKLdEpaeVSACPQc+W8G3rxtUcrtK74zUzko7SmLmTI/fcTuiwVO4zg?=
 =?us-ascii?Q?99qngdtbTgEkmdwVXv1jonQlyRY2BPo3GMBDyxxnakDrDePLXCQaYKbeMvaZ?=
 =?us-ascii?Q?T6uK3zGGVn3dbZv8lmNVPjKu1exP69zvBADig/so19R/Ip5SdstriuKJWEqL?=
 =?us-ascii?Q?JQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ocIan35h3YLRINaZkVas53fPvTqKQp6JrLFRPZBTymdcqdPKpOp3YCRbtplsKkzj88cYEi1sTzyAMvqo1fzz1SjrHJXi/KfZ+fUIrV3yJG5bSKSW2vz3n5oqPRqmEm4DXDCsAidC6Sudw7r72qVxgCQqtAow5yLW5fAlTc9Wg/x3XwwtWOnOkss/L/ORCPF/OLk1EfdUnUMm4NecEea5MioPvj96wCFgikaM6ZP9WHIrMXzlRKkEyheqAV4JmQ738BxJqEi8acbtTuJgKWn7V/HHEu5YJsPZ7KRgnK3pkS4ASYPVIGyh6ddokyVOfidEKtjkS7cIGN1fHZRvnp0Ix9BtCOHPCM5Sfp/iuo/P6DE0apXewzA73KSx1NFcjKDY76DpBwwy7iBMNALrqzbuXdN/Nws6jhBa3d5drEDbGjyfCasDYDdvcLmwiPTbhwFsGLSZrBhE/+u42d1G92sHGth1XT5wX8ng3ZOpP2lynyjXpWu5hbJOYfvKKiN2EUx5dTJO9lSkePRbwODqZxfuJXVm/8kqa2VXpmtnxBuL0kSlceSGnoRQ/E/WuhMzaGAcBwe8WedHv+ka2cZi8As2Mv7tRrjqwBAGQXbcrLxQ+ck=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 546857e9-ce15-4294-81d0-08ddcfdeb655
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2025 03:02:40.6412
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QfPSg5pia++pCdIEkS8JdAGyz7vXPKSgJZ4O1bhv4la7oACS59FE+NvAIC72vftFPc0Ouob3ilXvoYBxFYjtWxz6Sstvdzp+HocfZrp6Nnk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR10MB7642
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-31_01,2025-07-30_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 bulkscore=0
 malwarescore=0 mlxscore=0 adultscore=0 mlxlogscore=999 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2507310020
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzMxMDAyMCBTYWx0ZWRfX2dTKHfOO/bsd
 3LDdC3svIVYYEus0TBc2+1u2ynG2rEzEHWlwGATfqo5JPifirLphsjSnkDS25vIp1JlTEZ5AP5r
 AZeo4ElG3XQqR0g6Kqb/jVjlTIxLDh+mVcqwu2FUwAxX1yAcgu1d6TpDqpVzNpCqaRPvSsb2DxO
 VLh3t8tY490Rf7S30nNiU378+KRap4dYLXVSojHy4GGePwittZafqLaHmyuj3O1QO8WcpW0Odjq
 K3xhWYRQ+JWvionW7xYJA3B52VIKbR/1+tnJU4KAnlhEY/1cc3toOJEVx/EdcYzH5U8MoXSzqHL
 l/XCXH1m9av+z9fiCKDPfZg4y1cq+/0ZvDuq2xctUZE2/oxNUepDITTRGtBlu+S7GYLJpdtHDYQ
 E+7hxMAbtb4VSDEc8mL85fGkUQrcz4G/xqXwIi/agkPoorl5XJU1NVNbm04PFrlDDujjM9kx
X-Authority-Analysis: v=2.4 cv=ZO3XmW7b c=1 sm=1 tr=0 ts=688adcd3 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=wKuvFiaSGQ0qltdbU6+NXLB8nM8=:19
 a=Ol13hO9ccFRV9qXi2t6ftBPywas=:19 a=xqWC_Br6kY4A:10 a=Wb1JkmetP80A:10
 a=GoEa3M9JfhUA:10 a=yPCof4ZbAAAA:8 a=u-1vxgP3obdpwykNmhkA:9 cc=ntf
 awl=host:12071
X-Proofpoint-GUID: fXCAgNMwqOJvEFbxi9OCoJYDQgl6CNpK
X-Proofpoint-ORIG-GUID: fXCAgNMwqOJvEFbxi9OCoJYDQgl6CNpK


Damien,

> A port link power management (LPM) policy can be controlled using the
> link_power_management_policy sysfs host attribute. However, this
> attribute exists also for hosts that do not support LPM and in such
> case, attempting to change the LPM policy for the host (port) will
> fail with -EOPNOTSUPP.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
