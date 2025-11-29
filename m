Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A7184E
	for <linux-ide@vger.kernel.org>; Sat, 29 Nov 2025 21:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764453047; cv=fail; b=RNVNyS0oPtr+n2EjgqH34dbstlECnK7AwP01WtbIO7zKrLddPdoyOeECjEdZpFI7pdeqiAfhRLi65wS62psa2O76Na8P0+yFsUB40U5doNQsPPG78W4qLsQEN4bfEfWFOo1f5CwejJmRnp2Qi1HDhcRZyjDqSwtMra1gCLDOiO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764453047; c=relaxed/simple;
	bh=3Cn80bjFGGUKPvV9CwdVU0N1iL1PAKrBZKXRla5kr8c=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=HAJWRAc8NEIk4zELuvAZbGkGfGr0ZzgL2CnBosAU5DZWIeJ6XMlCuBD10CyWO/rcaGSEDsh+Nao8HIYTRb+JGraunlpxjInz+3KS9kzz2G7fq+Aqug1CEv8anEgLUzKPSB/wuL7zsfr2hkPD5VLr5ZJ9ThdbmFmchbpziKhQbOw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=el4i70sd; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=IVs2XH4+; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="el4i70sd";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="IVs2XH4+"
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 5ATKx5T02418727;
	Sat, 29 Nov 2025 21:50:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LD8vMwkkKabQYY3iKp
	cQLknrD6UnARgWoa31PknarMc=; b=el4i70sdwGX84V5RJAIdVShgmQ6gjG4m1f
	ov+bKzeTMMHzl5VLOJu4WXDfL8kzrML0e0wVh/E8ev2WZ7xQNPNXZjNFqpGC9ctO
	wofkPiyTH0rT80uUn9mkmsRYUX+Z351tUn97IG2c45vg2VKXX+itNVergqN6Yo3k
	p4Mv5IBWVJAeeeu8Yvx4oX8HlouqW8F8xKkYc4izHrzrQVY2dhFZCKF2QSXYqc5q
	1GGD8PE4sig6uOM7d2WdfurRnV7CuWV667/5j9B23Wkkf7uvPv8niZkordVQhfHX
	qZcqeU123T8y+BfKq8c0IBtndQh3Lt2NOR3k1T2d2SZJieVIFY4g==
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aqqrb8mpr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 21:50:37 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5ATKF95b023047;
	Sat, 29 Nov 2025 21:50:36 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011042.outbound.protection.outlook.com [40.93.194.42])
	by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4aqq9a8hmn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 29 Nov 2025 21:50:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UxGwb1vapQ6p3Fnp3vFrBlDSCsvlAxpzDkXCUpfuIaVB9A4Hsjx5lMqBlaJWiwzwmd2ME6q4I3Mc7gggDeugdmBqzdia1u8v1RrjHIsM43ILjAv9j+pC4R5bTmw0uUkK/tOuCiDSaSpQzoyynYuBt31gm5nM/ldoxXb380Ytuozm2UShpwiyql4rcmItiCKb7SPz7+1OoUcEcPO7DV1zNQLGgRcsiTvPXYx35bbBWuwRrKNeRVYZLGsCFtgbt+wpcl+qxu8DeyLOcGHGT5+/7vhc0oOMGm1qYHE1KR3He7CPjoHF+LdgTCKfx6qSnDmHwQFWRDQ4WNJXKIwChQFPBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LD8vMwkkKabQYY3iKpcQLknrD6UnARgWoa31PknarMc=;
 b=lzpmeWTtRytBKrXaymiVgUpCZreh7pqKfwtZEJlqq1TPa63KH89tyg4gvhbdwtVYxLh+eSTtL3kCvA6bGmVZEe8A+W2n4jMYKvMV4IJy8aRE5YACF1XKRzmXBoyOkCE/CUB37ViAY3wEZs9mpmpVa7VnW4RBe38/UlLU1fJTgBnrc+e/ohdIEov1OIfcBdGHl5VRI9OCHN5mWSndYmTeY3RIlieyMj8i/Izsn+iQupsSywjKDT27BTvShCPfODCNe63W3K9AHxVN8HBtXgyyp0zlu53PYABnK2rv+CtX8Cmve5hF8xf8gQc+v3EPNElrenmLiIc42+XX/OLInFRcXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LD8vMwkkKabQYY3iKpcQLknrD6UnARgWoa31PknarMc=;
 b=IVs2XH4+62e5FSTG4hxI2boQlBoPH0B5JydZ4va2+VijF5C0UmXkkYJdSSaFcALJsLHZVN5tJm2oDKI/tnCo83BXvXNQboFsACWbyw+LYrXEXMAYwXVELIIku9YnS1FDLYPO7b8Ca8VWGGwXQ0Ju17SgYyGGXBzlHYwiYwMywUY=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by SN7PR10MB6288.namprd10.prod.outlook.com (2603:10b6:806:26c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 21:50:34 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9366.012; Sat, 29 Nov 2025
 21:50:34 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        xxjack12xx@gmail.com
Subject: Re: [PATCH v2 0/8] ata: libata: Quirk DELLBOSS VD max_sectors
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251128084814.3798425-10-cassel@kernel.org> (Niklas Cassel's
	message of "Fri, 28 Nov 2025 09:48:15 +0100")
Organization: Oracle Corporation
Message-ID: <yq1sedwwltf.fsf@ca-mkp.ca.oracle.com>
References: <20251128084814.3798425-10-cassel@kernel.org>
Date: Sat, 29 Nov 2025 16:50:32 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQBP288CA0040.CANP288.PROD.OUTLOOK.COM
 (2603:10b6:c01:9d::24) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|SN7PR10MB6288:EE_
X-MS-Office365-Filtering-Correlation-Id: b72418a4-3f4c-4be0-6f49-08de2f9152c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?S8nlG1jdiVfGK5sxOiGr+FczWtXDdhpiAIMkmET3FgZl93jXktGSLovcdoad?=
 =?us-ascii?Q?HxhDyeWD6GZAcuJfp4/7uWkxXlJS2PGELY9D8R7KiYtcpYNrCaN/HMOxBzln?=
 =?us-ascii?Q?7OdODWcIvGXRvsm9fs3W1VHWDtZQYimNLLdMDNIKOlSDS9eKa8wf8AG6fqFo?=
 =?us-ascii?Q?vs9woJuy56MHTo5jgL+4F17PXs+xN/JoG1ssvlAEN8c3Ac69/vtw0HDamlj1?=
 =?us-ascii?Q?IvQO1fMbGN1zGf8E+dXbTXN+IVU53W4YdWsJALZR9LYZhDtMxy33S9PxxYvC?=
 =?us-ascii?Q?Vd9M23JDnZev73J1p/bodRs88QeL8vmOWc/6Tv94qR86FMnpImebOvmglAX6?=
 =?us-ascii?Q?+aDKxrVV4VK61JSDiHFJf77Fdf48NQ5wfW5wimASr+9coYYa+v1Mywhr4fsu?=
 =?us-ascii?Q?jbF1CRbrEeyWx1HNgrbuNXQAkxv0NSqtpUGUllYdWRmwpmmUgEQqsn/LZq7R?=
 =?us-ascii?Q?qUExgY2nd1ONu1oDDn4XJVH+9fY2MtiVxhPfUiBbwdJQh4W2ZruPEAABRMfs?=
 =?us-ascii?Q?hHFt52pE5201k+r7WTzmiRq4iGa4WrA/EvCgfPDlr282rahQlGYghQ3iw2jI?=
 =?us-ascii?Q?uRfAKjbUijOuyxjYHeEpGMxvwvGfl6BBjlmHmlQmxXHOZCxNk9Eg459kkhNL?=
 =?us-ascii?Q?ECaHJW/t5zjPhHinzHVGv6TsjgRdz4xSagmG0oB0wPm7OXPcW2lQmPzr+n4q?=
 =?us-ascii?Q?Zy5BKAHNR2RJpHsr1xcxTe+CeawCwC8g1F6iHJ5J2p549jzIjxPkUYKG6Chl?=
 =?us-ascii?Q?CLGX8yEQ5Vg9ldZzx79lJ823EpXuKXfQbqcAuQZvNk4n41h1bQjiBuc4lPJA?=
 =?us-ascii?Q?2GxED9XZxzu5ZMYba+Dtc7FHaBbCnveNuKuQGUERM2GVJcsdbMakbMKsneY0?=
 =?us-ascii?Q?MNOh8tiCYD7FasXt2/h986QPl9ZOblIEmRijIuDvi7AfKe1lQ6upm9hYx6R4?=
 =?us-ascii?Q?Gfgq8928lohGKH6KGkSE2cP5MozCQSZ1oVPRb/Oxw2kq5L8WhScS76qsJZIL?=
 =?us-ascii?Q?QsgQ17hrr139O6RXrapdJFt6GmzHEOMpJxW5EsVarWVUg5q5EIBX57F0l84F?=
 =?us-ascii?Q?bvOclVrRJhyCbv3woHSeXRsUC7Xl0j09gdzxTbkEA4tpyi8ASP33/DME7uW6?=
 =?us-ascii?Q?aluZ2QgVb9F5NUs3+k2B5YbIAc5UVuNu1dNzVxApA2+uvfVBL6zMozrWGnzZ?=
 =?us-ascii?Q?/H0bpNqdM5t4f27w/+ZAs5Z57/8pGK2ovqv5ptO6pIDWVoNMOrzVqdJo6efw?=
 =?us-ascii?Q?+Zx3KIKjk9Z0wgTaJWh2d5rvzEwohhdmM+bG1dwC9xbjyhfTdrEX6mx9WmvB?=
 =?us-ascii?Q?VNKOItGjV/J5tcydTtVgJiSfCtymOPGfo58NpMydRTyP2GlP7ENYYsHVuOc1?=
 =?us-ascii?Q?hpWLOehAKMGH7yoCbngJoI7WH5c6jhLKuiayt+kFSAs/RiHtWQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?r+FIuxst1Vz64W4kJpPMNeO5PxQESlyOcA5V0c2fwKe8/Mm7gOHN7cWUdpxG?=
 =?us-ascii?Q?nAiiipM9CA91ZShOB18hT8LsmLal9/aHqskKMVR/mk3hRmIPQQ4ANwx0HNxU?=
 =?us-ascii?Q?+W2krWWtW9X7xKBrIdDg27W8QKKQD4H1/GnhK86FdFVQu44Z2wGK1FzVhOxh?=
 =?us-ascii?Q?OxkgeIgnuV7xF5bamO8Nzz6S6fP9qZuXQBEwqiWJIolapho3eimF8/OxGLyu?=
 =?us-ascii?Q?91MJQjauLSBaJ7sq9XoaA7aIoUJCuhFjm5umQPq21T5nz0fCTRSMilS8a//X?=
 =?us-ascii?Q?IvCByaCFCfMwSmQDsLCotqWPTm9FiKOXri3zUzehJtTIYcqJYYm95Jz30pvH?=
 =?us-ascii?Q?A0JAr9gfqbgUQe0OZWbetqlCpQeQOv/u+swBVK7cHd9O7zNQ7Ofqsp6atEvz?=
 =?us-ascii?Q?AcQxP7ST9yWuY9ufsbdsY6/UP2q8Uli6rQ+8CKadzMksndifS8m7zbASJ6/P?=
 =?us-ascii?Q?aE69M927FkRcgvEGLXhkGhivxwBbZPzAK48u8bxGHtU85sFujZ3MQ5XST3/J?=
 =?us-ascii?Q?gVsKfTPJaCVnoOcUJ7gtrC/d9fLBiz9s6y6RGILxwG/Kcxx9Y12Wt5WTwLSH?=
 =?us-ascii?Q?jJvTR/oqtl/6baFWFF1E2xhVUEhWa2NCsmJtcUpFoN/999QL+1HqbYz81aM4?=
 =?us-ascii?Q?KkT8UVaQfI1htQv/Z5QuHjSTc+VEJHwWo+DQF9VjurkpAfGcYhcN02WbxobB?=
 =?us-ascii?Q?VCOUhnI/o+s0/fTc8Erdj1kzeAjdY6Cl64oXhnWVYm94iUpID61di+0FhRMc?=
 =?us-ascii?Q?5/4QbRQPwYjfd5VV/Y5oRVnVDpzJK89Z+3Y+pwidHMzcVYY6q78YzWbRRdK0?=
 =?us-ascii?Q?EKz+54BSDno6XeTGzlVPYpuW9euzoGqb0cotCeOmkNkbSFwBl8q9DxW9jkYC?=
 =?us-ascii?Q?nczHnHxOuJo34ypOoWD1O1ZegrnjwaRgsV/hllFt+qQlUj4ce64XGu2g+CT/?=
 =?us-ascii?Q?XziOP+QmE+U4aqAVSYOSBTdUVyexbA1DKYo7sBG/X8q77X5wDQ0n3POn14c7?=
 =?us-ascii?Q?FsP8PPYax2yq/rIpeaC7UyKM0nYXwBxoKi4MzunIbtwrV1uwWk9+AbTmaHHY?=
 =?us-ascii?Q?5ZzDt4D5iOzX5u92T2zsecEXYZfEtoMJ7MTviqdIupLCw+O6/xJ1DJQigcIb?=
 =?us-ascii?Q?oOuGIVaUN510/XWn8kjBcE9QtHImePDDUDk3DwilVXbMTIMJv0FbBPuzupEJ?=
 =?us-ascii?Q?poN58scpukFH6jU2ZER3l1DoLzxbnYd1Hi7Bk1EQewE+p4sw1NVQMZG4z6uq?=
 =?us-ascii?Q?/WctkDXHlQzxvvOooQVPD3coIAXD5SqY7HlKFQz0/zZCr54O7D4uHZi7KsHs?=
 =?us-ascii?Q?58PucvnTbR3AdYOgVv9q/vcDxF2hTzQ34UUCK79kRatjQWJ5hqkp4UcTO0lo?=
 =?us-ascii?Q?EgoK1TRBkWtVPHjQb3H1AC75ERzcM/8Sj9+h8SX8hqi4InmFOAgpe0N6Bxsb?=
 =?us-ascii?Q?ereMAEQIaYi8B0/s5YpnDjyQ/MM6apE9ncnKtIxnIIJKQxzZlr1BA6rAW3gw?=
 =?us-ascii?Q?juJm7qtRnha86iBo1IfPVwqFkM0Uc0SqTR36GOevBoWkdc577VY7hw0yYpQr?=
 =?us-ascii?Q?44SDyjHGZySGT769YEiWH+uY0duiTnBXmJtoVWg+qUqpLA3Uhym3+OYnMyRu?=
 =?us-ascii?Q?8Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	ITIbwYJdi6fa+fIeqzZR3suFP/nHLz7iAfg+csnkLstHX7SHtnba5ogIZv/wwvFwDqhCukn66dgMes1ZjCNwr3xkbj+G8ps8S5QjyenH64xme4IEs+snGXhpBx+q8fpWa2bzzhC5f94F0+m2jtDbvJ1dJWYVAUsuJylUQT6or/chpHm0p9hVsrJXm/icYExaHitPAW5YPqdh7rZSxqGa/HX0jJ3EW12CikgcUQUSS/riKaEBL73q74Q6/nE367xjALjZijAgH01ViqWQBdYrJ1R8WbQ5er+ccDcMoQ8Lg3TeTADi5y8lvQ8uwBAEeqbEqkGRnXYRH2aBhEJMr9AKU/e2lFOY9R8UYxRqpao9CWR5Et4/WxhvK0n46psiAn+qacFW+L+r5gC5cal8M/dPIVI+eYUxyCYtRqiEDuHyKmgfkIlyEGWQgheNciC3jbht9917LbdVvGN0o/XbtJaFvSY06/W1LZjwwAjg+rJnvTJ2KPzAsB9pm2XFb5GZuV9idNmo0ZgCK75GMWynDYgmWhN3KRMPDVQCev643CU0OjgZDf7+p76Se6ctbyP7BarUuuhz47SIpLNQPbvHWszoczCo5U2F8O3Y3qye4jeSJQU=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b72418a4-3f4c-4be0-6f49-08de2f9152c1
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 21:50:33.9837
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kiT9A6VpfVia0nDU2lRs4uvOrk+T+lOF8djMxBLZkB2lAl7ytKq/1n2Lwq7Bl0HHc0UemqAuIHiabvgBwuWZUIU/cGQ3lxEnMrp4wAmwCmc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR10MB6288
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-28_08,2025-11-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 adultscore=0
 mlxlogscore=999 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511290180
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTI5MDE4MCBTYWx0ZWRfX/cIp4ZgCtMvb
 chAUhfyDmIQ3hA9BUh6VxQNrp6TZiW1ge3WcavJZIB37wBSFOqbde+YZrZTNwkVeNbRyuyWjtRV
 AjTyPkL18aIF85t4cKRZMyFr4FbHAG2zfK5t6dlerc65eEeX/47JcCods2w+SGlD0D5wV/Bt33Y
 l/PjGn3K+O0dcboXKBK0H+kQxNASpfOP9tc6sqYDUQHpv1m8SmhgNK+PCva17vkvYsoWrM8R2Rb
 bDsHXmaGqUW2Y1CjGP1JcQDlPiJ46/S8DAVwxdkoCzcrAlFdvm/QZ10fPxPeFP21N1Q9RIvp1uB
 J7w2WjFHftVZFXGbZx39JsD1NcefnMpZk5srI5mNIkHfqnNGmf8pJ15NNLXGJYWR9qHNdzAJ48Q
 mtsUl6hUR5xYPkSuEr75fryMNGTpnuMxhuFjcRCbWAp6QeCa/qo=
X-Authority-Analysis: v=2.4 cv=O5M0fR9W c=1 sm=1 tr=0 ts=692b6aae b=1 cx=c_pps
 a=zPCbziy225d3KhSqZt3L1A==:117 a=zPCbziy225d3KhSqZt3L1A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8
 a=oDfxCKJXiCdCc2ej05sA:9 cc=ntf awl=host:12098
X-Proofpoint-ORIG-GUID: 4quOB6pyzwbpBErkkwxwRWsjGwR9scE7
X-Proofpoint-GUID: 4quOB6pyzwbpBErkkwxwRWsjGwR9scE7


Niklas,

> It seems like a lot for SATA controllers are buggy and don't really
> like this, see: https://bugzilla.kernel.org/show_bug.cgi?id=220693
>
> For now, we only add a DELLBOSS VD max_sectors quirk, but surely we
> will need to quirk additional controllers.

Looks OK to me.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
