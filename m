Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E39F156236
	for <linux-ide@vger.kernel.org>; Thu, 20 Nov 2025 03:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763610557; cv=fail; b=G0yEudZM+3qHd2jl9lbHmW+W/4K96uhkwdjO//QyaWh2nJViXDCIQvGdUv0NcUDIcwYTsF5eMdVN7srpCoQ3MO21Po++3yzUv280djurEau9CctBBGxdoQnw4ctGWAseqEwAysL+D7yPoIO11bFXvipVZMVP+LPf50KcrAwOdJI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763610557; c=relaxed/simple;
	bh=nKOrNMGwi6byBqoEy/jig9CkkOU/gMvW0KQnIxTrpeo=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=mTfx1Rsq304lIx8jp2RQDz0Z03HXbh3R9ilqngXaTDcdL5/HKiA2LPFjy3fTUM/N6KcDi3Rg+aG1g9c5xTePffgsgLLS7BIj3mPk48fYh5n4TBo4OulpNph+2dDi0vuL6Qss2OusYyk4DicPGQgW3YFUj91DOSEgf099hOX7/Hc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Et50dIFp; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=uZY+zidW; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Et50dIFp";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="uZY+zidW"
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK1O4L0030642;
	Thu, 20 Nov 2025 03:49:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=f+TEuJerwgoxpKjPq1
	mKJlfEfyVd59JZ2Uizl+UuJqw=; b=Et50dIFpweBFR2Aa+Xc0ZiOmP7c+PpF4LD
	Jvz9qIpaTw5STEoCu24Xdm1t34IxOqdEyxoqx3bN97RjdEM7J/fVJKfZ/P+S7+Xq
	xFmg+TqU1ffxb2vysFFmkfI3EyiuHf91XOfnh3EV4R7PGHKnPj09l5earASn1Vwr
	raeFs0kKDRlTNZY0J421UrzhFIvof7+CcXs//xM2klNql2oWKgwQEpFkgd/PnHC1
	N+R26YsbtqSBFIHHRqPdD2mljxOHIjInlahqLnJacBlugYGuLxuKkaOEo2UUJzx4
	RGMilj1eOo3O19yXGoU6lkBCleXux7/laRcAhqPDalFVQtx4yoIA==
Received: from phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta03.appoci.oracle.com [138.1.37.129])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4aej968aw9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 03:49:11 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5AK1WS2o002590;
	Thu, 20 Nov 2025 03:49:10 GMT
Received: from bl2pr02cu003.outbound.protection.outlook.com (mail-eastusazon11011012.outbound.protection.outlook.com [52.101.52.12])
	by phxpaimrmta03.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4aefybg8e1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Nov 2025 03:49:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vVoAk8D7CIFifr6G2zb4hwgHMq+lKgPrybpj9npaloAhYoaXSTRxDANYz3DUdjhRMRrQNA7Ys+gPx4IGkzpGFebWzbhvd9wA9RMepUvtK4uGo6Z5DW+ZOchHtLrjmO/1euvsbSgPhEWorqoNOz/bm9RvuZw1Fg7CvhFgPJvOG7s5CszKf13auRUqPemXZ/Ror39kkG/FLLO1Kw49eyb0nyt99YKHHdyQBtaovwIAL2CAKQB5y3ZWl4oBL7qDDgukTrgifbQVKTnKt+eiguvfdPhelQL+EC+uswfNXj9n7jbgIYOK3iu71QHF72vBxBjQOKwES0zsVhlBCUaxm0TLpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f+TEuJerwgoxpKjPq1mKJlfEfyVd59JZ2Uizl+UuJqw=;
 b=cbl0NgnVUsPWNaSmwLFPwa21IYMvFznCNnUjPsV15ve3oXRKbkIpDnmIwwI7n51y3KKRBHsXbhB2qa6POSbkQVVklTTdgl5Z6RqpPvP1WsRf9j1INSLszBaW8SNK2uzfsf2cSrR22uE6H20mdQUxM5NcwwE7N87LnXO6GQB4FfhZmk2e/Lbi6fDY826869gSrl05AcXBpKZvAnmiA/56EhHVR4UvDTi82NxcpSoi7L0hrXifjDFIeevVcvp1CsvBYSQGSP3Fa0hB/WIKWT98kMLyGMCjvQORDHwxuQT2x8xE4g5bVeS7wAxx8hexh7j10pZ0L5GUwSzR+grzXYFsfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f+TEuJerwgoxpKjPq1mKJlfEfyVd59JZ2Uizl+UuJqw=;
 b=uZY+zidW8P2va0sAX/OWeh8dCQW1d+ak5xra3+REjbE0G0qva36aktzyzTA/UFaDb7IOC5q5f+VEw+cXmEg/07AqvQnTICJwlHdAmlUY6cIHiLDe4UhDNMHKiA9Be9TKmhx9BDIbqy59jHHUPosrCz00/XfM7TzdB9gNyAyO5ZE=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by IA4PR10MB8633.namprd10.prod.outlook.com (2603:10b6:208:56c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Thu, 20 Nov
 2025 03:49:08 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%6]) with mapi id 15.20.9343.009; Thu, 20 Nov 2025
 03:49:08 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Hannes Reinecke <hare@suse.de>,
        "Martin K. Petersen"
 <martin.petersen@oracle.com>,
        Damien Le Moal <dlemoal@kernel.org>,
        Ilia
 Baryshnikov <qwelias@gmail.com>, linux-ide@vger.kernel.org
Subject: Re: [PATCH 2/2] ata: libata-core: Set capacity to zero for a
 security locked drive
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20251119141313.2220084-4-cassel@kernel.org> (Niklas Cassel's
	message of "Wed, 19 Nov 2025 15:13:15 +0100")
Organization: Oracle Corporation
Message-ID: <yq1ecpt8itz.fsf@ca-mkp.ca.oracle.com>
References: <20251119141313.2220084-3-cassel@kernel.org>
	<20251119141313.2220084-4-cassel@kernel.org>
Date: Wed, 19 Nov 2025 22:49:06 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0047.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::28) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|IA4PR10MB8633:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cdce6d7-d1d6-4363-2cad-08de27e7c1f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IXfdPjKzlI1nOnlopuE7Ju8IPL+eqtlLCdgUvkGd4tinL0HDj8swl6Mam7lg?=
 =?us-ascii?Q?2p2XrE9w68uWyxHILhsHca77pTnd25VOrawNcQLDfFm4DoLKatU7eGcm4d9P?=
 =?us-ascii?Q?lMkCdkm6tOASLQR98EVnjFgUFOau0y9ZdAlvT2vzxVEeAHShLODflBRey+GG?=
 =?us-ascii?Q?ey2hyZ7ZrQVI95YiPA0SdoapR/dt6rensgNC0Lt3GuUtVAUfeCFEI6j73LFC?=
 =?us-ascii?Q?CUPT1QpZAfEuF+uzNkDG66pj7FzAzR01zn2ONqMuWVrCi4BJ7a4GQ/m4fOPF?=
 =?us-ascii?Q?eYetXoy56RtVevMMmP3IRAtqfO1HHDH98FV5+r2CmfLsEX3L+7mk78EhCHui?=
 =?us-ascii?Q?NBf+1cGAIXKrHqZeJNcKFnYjFLouuvWO11QhoGC3Tcjee8IKs5KSlal7Upsf?=
 =?us-ascii?Q?IxgqufVuyeRpJfXxwLkEUDKqUtcgH7tXxFp9c4RgLUfUos8hBtd+BwxUioiC?=
 =?us-ascii?Q?ni2EiKVI4rDmjzAdDQvYA5EoW1FQUPWlupGwYA2KokfkWnVTNrJwPFdDJoQB?=
 =?us-ascii?Q?XtzLV1wNgCiNOP5cMk1QPiqEH6HaQbFgCkjmaQLOrOfwsq2Ljv1J2BM/iMPe?=
 =?us-ascii?Q?/Dn8KndV1d1XOI6LGZjWeWw1tLc0oqLJG11XP50Pojd1QhC1QCIHmTQeTuE3?=
 =?us-ascii?Q?r+Lfh0t9Yxlp9Sqc8yRgaaXkGayc4CZQzCsEJatsFOCbyk+/T75JgpfTFADX?=
 =?us-ascii?Q?NWLvQQfbWTgJkz1kDpMUFz44yTY2Clhzj5IwSosHjldUwmQ70Uizxnu7anIS?=
 =?us-ascii?Q?UJpQxlWd/WyWdEWtzeFKy6RrfvVi3sSjTIFmh59Mgyv7l0UjkOo/dBQpg5q9?=
 =?us-ascii?Q?9Oled1rSETExkSIXhcwJpqvn7bj6h+L4B2RjN/m27fnahQngr/flXsaMgKI2?=
 =?us-ascii?Q?aR59lFpe1cZcQEgkWf2yQWO4HXwMnX7cCGsJEasRhvhLr8uiAMcVC6KBrqak?=
 =?us-ascii?Q?MXyj5NwxmgXmW+KxiUSZS/X9Om+zKqhHLHjRfdPx6/LMwNdqFlTAmmNMUGgi?=
 =?us-ascii?Q?Yju7/uaQGKumo8waTqpujDXVEdzXVJZqQPUAa75ixrm9kT799qos1TOvVWce?=
 =?us-ascii?Q?vXTolSnIekPZpyF2+mPyhgpU3n1hxmJh1s8qF8j3lR3xMR5g3+xho/+AeEXm?=
 =?us-ascii?Q?lOWRn4DgLFh9IRalwnSSuPgv23OzetYZOMKN3iVFEu/qhru6nphLWEgLiy3V?=
 =?us-ascii?Q?SpoL8RAylE5MqwLDEfRsQ0Wq0u0LYCub7OHmT8a68nN9mYm5nzwXRm1dzUpQ?=
 =?us-ascii?Q?4cqKaEMMxZwC+ww1/gy7Gb002L+3vxr7uD0UiyJjJrGaf+Q1s2TQB9OdGdmV?=
 =?us-ascii?Q?MuZ1ftiZzr+MymGHD8RJPDWclzxkSpBI/vbb5nUq68UyiL2LybM7N0bkXUCB?=
 =?us-ascii?Q?QVrdqQj22OcnbXZAXYUrthfzSPsT2yEcL8H8PO3Uj9rTzAfKJOlKDz2MvNTh?=
 =?us-ascii?Q?5neLrw5Qa16yzgM/yhs7bU9I++Nj6LKR?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YdccXfY/6+a7tdUSr26mdAAA+lF4vYH9GtQ1EJtVtAr4gYPZHnHd5NwedkAE?=
 =?us-ascii?Q?F2HoYHs5j5uVP/OtmewSeNVNGvF97Dg5M/C8swWujFge3FEukcnf5/lJjYQb?=
 =?us-ascii?Q?IarCLJW195BcGQfWBrmt2Vp2Bx3DBGyRJN+PadFDBVrTNI7aJKRGWvzwth1L?=
 =?us-ascii?Q?LtghT4VPTD2TEIAQchYpavp5qS66B6NGJ9OBIMevaJYe1Tw8n+ErhXLXY2E2?=
 =?us-ascii?Q?f7D/i4wFkdE8DoRvk9PpKJeqocBS8PCVDBgJ7FASGhcZomVbbB1mqPxFQlxV?=
 =?us-ascii?Q?0gxdPmkl5q4Jv+DEmnR4ZWvxOyye7GtE8K6fknHRjFnHkDvZKzUS0/+awl95?=
 =?us-ascii?Q?7F4cz1rohCpMBm6UP6PzTkXVP23nlI2IrzQb+UsRuk7LTWH04FLryY/tMtMB?=
 =?us-ascii?Q?ZLMMCSzoafzJEudtn9lTt2oKvQmvRHE6+6A7vNDUnYQ77wO6iz+doPadvkNP?=
 =?us-ascii?Q?YGlZdkzaFvFz4Htn14EbydvY8tshnNnnXUBamJA2um6KVGPGZqBj2vCQtTM0?=
 =?us-ascii?Q?qCvi8R2u36qmxC9RfpVIVwq+BE7BespFbZNSTHdexVXymJBnZ2gGmekTAq2p?=
 =?us-ascii?Q?bc8yOEhKOV7/px4grdeW9wJRrvKaori0Gi0I3HXW2+s4pVxSiB9KVsJVQ6Ia?=
 =?us-ascii?Q?mIEehQ9HleL1H/qmoY+H9NnVdlyc25qbzT5567qZ5lZeEUi7yqsKqQwbwN1K?=
 =?us-ascii?Q?oWiDqjGi0BXVxLnll2rFRYcLNxGe7KTNcb7PomBSBe34xBsxRSvDVd9igkiZ?=
 =?us-ascii?Q?M+wwusgkMlR8HwYv+tgwkRyfaoUIE49tBIF+Nfo53vORUs4ay/kVvWljsvQ4?=
 =?us-ascii?Q?ADU9g5t+R0GmfD9qsEmuC0Edd8TxPcC7LOtJjJUKj1ejxW4wjXy77xevC5tX?=
 =?us-ascii?Q?6yHGyXuPSTAGTvzrZXf5AJ3uTGnMKK88CB64YNTMSFtR2r7KW3d3kMxjodi3?=
 =?us-ascii?Q?a22vbdCoY+aG1DtNmMLCPMIRKAW4FJkTxHL7C4aD73GlxaE98k4EqXz2dsNf?=
 =?us-ascii?Q?IYfLu3CBjJJeDiYqOvubUoCXZnoXW2zdm1JpMQxxGp4coY+6UqMgpBM52OyY?=
 =?us-ascii?Q?m4Fui41fQfs7dCJ3fiZuT+36FEYxS/iiHFtjxMNR1BVuZ6IYpV2mBDo2ji0n?=
 =?us-ascii?Q?FEJga15PJm2YYs+I2zxXwRh/jcOL+Hte1puSowAGiTvfyqh8jCQRB3ZgIEW9?=
 =?us-ascii?Q?CXu9jyST/Iwu7lTTeDnOIDyFh0hFhNYBEBhau/qbDb6Rdra7wJvHvmGy74XN?=
 =?us-ascii?Q?2ITbUzQGr8T2wxAVy/VkkqJJyR8JpcMS3M2dc+y17Qlf5Gl666Vux3fS/B8Z?=
 =?us-ascii?Q?Vx9YvGTAbyQ73ukr9jRHl89wR4yFkTB6BBYYTJxN/x87ynU+EPJ/7Syx8kL8?=
 =?us-ascii?Q?ynND3u23J9KkHE3gIINSGFeGcS7H+Lvq90V5EcQUtr5ADZe9oyRDa++qVZhK?=
 =?us-ascii?Q?xY6nZvo05KwFZBvMd+hEYW8YZvanBCKYzP20drRvABOzKE4lRbcv1HFqSR0t?=
 =?us-ascii?Q?tL21TqxQEZYZGAzx19CRPMNw8Xc2mWpFI0yPY9iVj1NUPl5qdvZB6/SMehPL?=
 =?us-ascii?Q?uiRJPYg70CPYvlegRjaOYFp/LAgrwH/IASP2BRqBQNnZ5tKx6IyEeSEjjJPL?=
 =?us-ascii?Q?+Q=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	+BgATQSb0Yh3VFdPQDj1+Aopy4K3CI9dIvnaC7jr2yX97E5YJ+Vy6adF0CZ2xlaVq0dXQ0v/+w6phQnqljCqgZZdNkBKfWLKFb4zRsJwNfUceB3hbGk2vRWJNKc23aeCmJ1ijtV+Bs/Vg9TsfWIMygRARtcHI3K1m7MaOTIgIWzZE5+su/mk7PF24EhH+8CjrKpm2vewPpyaPvvI5Aww2yhKoJSk9zCaXcK4p1Pw2ALSMWUm7VRH0xdi//Nv0Htl31mgOBZqU4p/cUIDpC9KtN3c+MulWCIoP1jf05nSuWcS/AldDYbUtchz4BBKRxASKW7IS1IJb+JrFDBDRuxpzFvNH+oFCMTSFSUzzmafJNnoO9r0Qa+eqC+VK0KBNe2mJ4QkFoJXCHsKIr7DMM6qEBZ1/OYEsREVBWc2JGwKz84bGGetllFE9vaLxwQSogpr2HsONaYm+buUify0xiMF6MJ2UjVpqlkhEYVuxGfIubPdzghBB4H3DTAt4T7jmvGvtQMeARl12GdUSlGhAo7kgVOoOx3whQuROaahNefgj3ehoxMeMmrSNaAAHVFUlZT+pFEJD/AEbhE62DqPSXtKSlhM2lHOHLGMMzTrvfS+xVY=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cdce6d7-d1d6-4363-2cad-08de27e7c1f9
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2025 03:49:07.9579
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: +bJ6cT/PtXGfZ4apUGyD/sZBAYSHPzV9pUPMWz7f7ho/4YZ5a/B1yLHp8qylr+3NCnY0q42HeQqyqqlLjfkdNPbdBhKOFSGzvj7/uLjRGgc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8633
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-20_01,2025-11-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0
 malwarescore=0 suspectscore=0 bulkscore=0 spamscore=0 mlxlogscore=999
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2510240000 definitions=main-2511200018
X-Authority-Analysis: v=2.4 cv=DYoaa/tW c=1 sm=1 tr=0 ts=691e8fb7 b=1 cx=c_pps
 a=WeWmnZmh0fydH62SvGsd2A==:117 a=WeWmnZmh0fydH62SvGsd2A==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=6UeiqGixMTsA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=oP2FwjMI8h3TgcNiX1QA:9 a=ZXulRonScM0A:10
X-Proofpoint-GUID: NJ7P7vgwr3wdtdiZgz55nBs-q0Qhwkmy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMSBTYWx0ZWRfX1gBFhGaf1Z5F
 IGysV2Y79tqqMhC1o/7VNTiyWUsXZdbzlYD8xmAl6qjQFSejZD6RADKGJVnhnxiSPlNpx5q1sm1
 aaYO1juwwhDrijC1/LiGQWURNCyustrN6LvOMzMec5XhGIm82hBl+zJRPdGjaaIU6sg7K3DC98N
 kWjtLTiGW/X6ZWJimettDXhL1mxtdSmVz7z/swwvRDU+qL17iFP/R3fXx3zEEAvqH8pP1frkrPm
 wlDF5OMAMVwXbEFdPuxRsOhg0QcP266VC3USBjGDJLNwYR+W1H/E5v86D13t0wLZ0QijAOogmO8
 wiNzKSOOWaQNPa0Htxj5KFZxqxhlOYGbRgCddh/RNu8ncVM997nqOBuElN0KhFugc4lOfZ+Uhfu
 /ZoMrVnLKdGwFB6UoAJhrnCZcB1QjA==
X-Proofpoint-ORIG-GUID: NJ7P7vgwr3wdtdiZgz55nBs-q0Qhwkmy


Niklas,

> For Security locked drives (drives that have Security enabled, and have
> not been Security unlocked by boot firmware), the automatic partition
> scanning will result in the user being spammed with errors such as:

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
