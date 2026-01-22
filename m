Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00E4D30596F
	for <linux-ide@vger.kernel.org>; Thu, 22 Jan 2026 15:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769094618; cv=fail; b=YXrfah1mNgrTOxIQi3dShccn3Q/FOHlDPoYkuBsAi2/ufWGBEK4vrCDGibsd518V9zbaKJPEtjE702erwWs5hWkiTlJGtdRB4db05+PKrFEDCvYqnLa2fOJpo45zuVEgNHAj5picLqecKTmN0ZsOnioJkP+yJ64W/nl/iM2SZyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769094618; c=relaxed/simple;
	bh=ewHw8LeItGeqoNW151UAg7uztO/Lx9388WC1o6BFWr8=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=Nl3nOIpCZ0ZCY8tdJt3rZGzX8ErI1nWAOpOR+BzPkdMiOzNkzguJTTpRnCI3pIEB8ktlQ6FSveHBv3jbUaESuyGUoAYr6y5g0e/gFe0IOcDcMNiKniu5IRcZz+ITiBc9vHdqWYm/cRnnvK1TBKEMHlvGU48R9XP12dAtTqRBsXg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=FozINX2U; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=ZXhz53o1; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="FozINX2U";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="ZXhz53o1"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60MDglgl596501;
	Thu, 22 Jan 2026 15:09:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=7i8SG6lj0mvLj0slGh
	MSZLq5X1Ib4wgppAEiuaK+lQk=; b=FozINX2UYh6nk+TFVPMkQqXMF/nCSJtWas
	p5oygfzm3gGrak7kPADlEZELdZhb8srl+xFBuopef0oB+wN9F8++mPKfX0FZr+ec
	NVw+aYYgFQgh5zNw1K3G/DDrrk0gYciTOI4JAy6Wdj70bIbIC8BoWatjWdzjjnIJ
	U1O4utz6/E84QpU4RVQCXrVKMDxJL9j8QzjTihU6M7Q7DgJILhGcToMDCkS6lNEq
	r7RnE5eyvxYX+a9n5+V1d5HgRuVEKhESZlYtzJOmZHN0sSRC0MQG23Zuv17fZtF6
	T+ImREgaanExca+EyHYLkwLhpIYHYhNi2G9NjLNVtWNn5S95yN2Q==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4br2a5qt0d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 15:09:57 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 60ME3Ha9032182;
	Thu, 22 Jan 2026 15:09:56 GMT
Received: from cy3pr05cu001.outbound.protection.outlook.com (mail-westcentralusazon11013046.outbound.protection.outlook.com [40.93.201.46])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4br0vgry19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Jan 2026 15:09:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UlgkQXQiXAFceNgW0hLKC8fQQ8F9XyG1kYrBUnCsSP1RwHtkmg3DrSio7TuvYGakBUCs6Ws0V7VKyyO1qlOT5It1swcS1PraS993yM5lvPU92U4ri3y1VEnlKxsSa/jkpaznV1bNYQRj7SAWYKHBIkgIvhbCAVjdZTce6MY3Rbf9Pgk3PKEpuPPSeoCdkIhPdvArQC7YLb1fzWj8xMlrSA9EfqpKM1+9YkFBl+WqbkEfrHTxslHAz/ukthlk61s1OcYF7q3SlZalUCAliTQwwUpHFDyG7iRirrJPZBFEjNi9GEmFEUMn7wSpz+qPM4Z+q9Doe/Ei4oxEvRjXnSxzRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7i8SG6lj0mvLj0slGhMSZLq5X1Ib4wgppAEiuaK+lQk=;
 b=bdc9jKzIWqrm02/AmbCWiuovieHisCNr9GIUEeBJ7f9ot8ZOI0/mgJ9UTfUgKBNg9J1V6IdJhweBkuCqZjOxsjhdSXkYLPRhmbAI/ay7Sj9smU8rpNzncaKux7ZEch1OqoG1B/2jPBG5ts3auJU0HrL/PgrcUJEq/ZtUmaGlF13jQ5Mbiud7NDLWGx3i5eJDP40cN0VuSvJaNikenmGNqFqZiYiiW7G2YGm9Ahs6j70ZOBRSrODcOaCge1q4B3TQdrt4hAhOgbQBb6wVt8F/2GOEvpUkQyODMxkz7ulojPIyBw0u+5WRvF16ZE31/BehRk7LuQ8DdoHROcQgG4WZFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7i8SG6lj0mvLj0slGhMSZLq5X1Ib4wgppAEiuaK+lQk=;
 b=ZXhz53o1wWOJ7MJPxdawml+Wo4jLjDcqLh9Ds2u24vz8AKoSlXspfZDMGf8hF+BCqhTJOohTGExxwNKyjYPynShZdPTEBjidvy5f9yz7rJwK9lF4pNU3rbijx8KPggQcFm/zsg3bVJe3Bu6GmVSwrB96Bi32cza+Q1+GZPe2JWQ=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH4PR10MB8073.namprd10.prod.outlook.com (2603:10b6:610:23a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.10; Thu, 22 Jan
 2026 15:09:51 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9542.010; Thu, 22 Jan 2026
 15:09:51 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Wolf
 <snow.wolf.29@proton.me>,
        Salvatore Bonaccorso <carnil@debian.org>
Subject: Re: [PATCH] ata: libata-core: Quirk INTEL SSDSC2KG480G8 max_sectors
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260120103237.3922391-2-cassel@kernel.org> (Niklas Cassel's
	message of "Tue, 20 Jan 2026 11:32:38 +0100")
Organization: Oracle Corporation
Message-ID: <yq11pjh3cra.fsf@ca-mkp.ca.oracle.com>
References: <20260120103237.3922391-2-cassel@kernel.org>
Date: Thu, 22 Jan 2026 10:09:49 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0038.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:86::9) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH4PR10MB8073:EE_
X-MS-Office365-Filtering-Correlation-Id: c0c15719-e6f6-49b7-fba9-08de59c84aa7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?I8UW0g5WlgWvVZ1+SJPXQhOnGr2TlXJFRNA9pzQZc4LNm+OSISk57W7HzxPF?=
 =?us-ascii?Q?zke1/E8HUD4yHlKYC82G4e2foS8LkKVCs3CCetkeLMLjA9S9Yar3qHcFIkcq?=
 =?us-ascii?Q?ioNfKot5KUEeiVfbo335GXDwKl84ZeWob+uaknniJbhZUpI6EXg8x+mMgQGJ?=
 =?us-ascii?Q?OqcOtxBojoKmKwUIwRvH0ay0w2TMCyOIn9wAAFRN9qAnpHXQkU70wv53NlBZ?=
 =?us-ascii?Q?tkGOdcsRt9PhSdvzhCrin5XPhaB93PiqRnZNa/20fezvCxH7SodcCOBq0cfx?=
 =?us-ascii?Q?VvOXrk4GqbRNS0ZuUOiJdUDbf+80SqzYb9HA/9wKpvNTeUipi16wYaM7y6PS?=
 =?us-ascii?Q?OHZyoCCzXUXR07bsQjtF8fisCGqbV/As59RPdL9I47e9TpY79miZ9Pz4BNwm?=
 =?us-ascii?Q?osREiBJTFPaKzXLnfZ2AkhP+sFLEbfImQpHo5P+NdfH1jwwQgJwN33JS8Dgg?=
 =?us-ascii?Q?S/nYubCKwA73WfukSkhOZDPFW31ZIUVKJxJH8Ql3+Tj5k9VNBXpFOdj6uQET?=
 =?us-ascii?Q?QCZ4P/I8ImDja9xFrjYTT9kC5n3ObJu8KoKBJ4a8mAm1h5295hX8UBg6dKXb?=
 =?us-ascii?Q?HY6egEubVsB+BMDVZQ3FHIjYHFMXVwzV1xmaEVUYi9fCHvzSH8tINxRL2WX9?=
 =?us-ascii?Q?hf7Z1G87TdHRbc2AhLpfJax9QFhbwCw29u8j1hlpbtNwvpdLTjfUQlD/pVN8?=
 =?us-ascii?Q?r7ZuiHtPr9+sG2zPZTZOqZBiokqMZjHG/S4ny6DteugEiI5aFWvXc7jS3QjX?=
 =?us-ascii?Q?+8I0J45s5dcr4Dna0q/mq6V0ppn0G1CyfnD0g6PO6gVcATj0VXl+0k9u6ilo?=
 =?us-ascii?Q?uK2k13OqABe/cdcMrKlU0gTm4A5y7VHiBnsGWXGml2IK87trryR+aIGZ2I9s?=
 =?us-ascii?Q?xxhMc7hw6Z3iKrwkmlaVReCajDz+VmrwPclDTWnAR6oUbH8N/AhLitalJTzi?=
 =?us-ascii?Q?b5eNivyFR/iJuK82/lypaXlgY33ivhpDFAOQGQ6ZKphPDROvDIRfz64Ja8fb?=
 =?us-ascii?Q?d+D3jvd+BopYrkftxBcDJpJSe7SXz3ZQffrtzHFkcBOngtBIUj5msaE4AaEb?=
 =?us-ascii?Q?TJLNQj8vEPeVCkSU05hC7/R2t8cyG8plwrY52U49O4Qv/kFGBWqTNDyTsjuq?=
 =?us-ascii?Q?l7ClcCdC2CpVeG5T15p+Kg0gb7RlJf2t7yN+bA+6jKi9SqozvedzvnNNOukx?=
 =?us-ascii?Q?yaGhvGujOz/bLR+xcXoD0IaIe/jSYHfWkMmFfR37Fn+kpNQquJVWYS7umKyQ?=
 =?us-ascii?Q?rBbDZA/J8saNns8CtM7hNfkvtSuhfVHeP2IKGQvYsqbOvqNtMkaKn9feAKhi?=
 =?us-ascii?Q?pqu9tnoKeQVIUy9uTqd55I3wC3yKUsQhvgT5FRb8eXWIGhQVQ2myiEcr3B3X?=
 =?us-ascii?Q?ZBvjBrOwZgaMarswR2d5Em+XJvUyeoQVdqL44weWjPA/HcyObcLgqnQgJzpA?=
 =?us-ascii?Q?9WMo9jh2+XbEp2KradRvj1OVibYOSf97yFnyPjmhRqKt3ShAD7hgGU4auQA/?=
 =?us-ascii?Q?wt0blR1fufegM1oayFj6dKfE/MliuBgBW+CZ63jDj05kOuH1FPNQVsr7wiUM?=
 =?us-ascii?Q?2OejgaNvxqK+V79xINs=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?90emo+LS2soiF6Fd1IIYQJrCEsw75KNZHQf6UMdgcQ37mPzqls2eD4AJSM33?=
 =?us-ascii?Q?egLT6U1yH7KnTT/+93FzLIre8gIjRCjRvmV82URY/bUAqX0UwGOP5oSwE4OZ?=
 =?us-ascii?Q?YvvG+4ohTYI7BKHplYcU3tqPhvnvdtJ/Y8lGTBA2oAFrVARzPeaPXFhopfHn?=
 =?us-ascii?Q?DQ9oSkG5ZflsYl9e6sYx57hVKAjsJ7r7ingVURxq9cr5Ac6+MP9ZXgsLPoTw?=
 =?us-ascii?Q?otenaeulIcVJBcCovObP3D840fUbtIeAKxAga98khfmpbJE3LaeDZ7QFRF4C?=
 =?us-ascii?Q?DKvsMB4ih6+AqgMM8b2ThQjPLYACFEBeDbJY95o+d8uQqAsNd6unhnuCnwcj?=
 =?us-ascii?Q?kHpQJA739GgzbpjD1cnt+HbngVJ26eEY0jMiZVGb4VBMtUp0D3wHYdmHBmFY?=
 =?us-ascii?Q?Y5+i1AyMiIKfx+Zrmw/QJXV+8zXz/Fz70R3/U73o3+zy8bH0nSi1u6rLbGRA?=
 =?us-ascii?Q?3jedYdaZnvVaEJGoqZx7IjZWBMvQR03AY8eax9K0o8xVzQK90SFFyUUYRTDL?=
 =?us-ascii?Q?QycSMvwHFy+ROBckFf/T5hP3rBaoTbueOIltk4M4jFxPKcaATQjC/9TPpARW?=
 =?us-ascii?Q?izmgrMRaz6kYqqp4oCVEjojflfhTjTvDh79wzSfaQrNUNnnzSO/GneeEt+qX?=
 =?us-ascii?Q?mJgHEPfDWqsuBpWLPfWRWpMVakjdZrsHik4HPEZjMu9CZcl7w6QlChJfAkOG?=
 =?us-ascii?Q?+0me5rTt4SNJ7cIUz8D7yUUmSiFLKucJLgzfPRcP80b+/9P4IJ6Ukg5oOLIZ?=
 =?us-ascii?Q?95k3Ytn9UXHq8v3+uRMw9IXUbDPFTWNc2MFhkQ+zTkuPQ3arXv1os1i4+EA5?=
 =?us-ascii?Q?3AsUmZgy4OrFTMVO5fksJdkV1sgj+2mtISreiLEcZQvW6w0+21OrP7LzkqF2?=
 =?us-ascii?Q?bJLPPPPKUQs/DuANQ5+Cq5lQ2UTMKccvxFiL9OCHpj3OpJ7ci5iKlYSA87Xh?=
 =?us-ascii?Q?Q0TRUAnSCGRxbslOl7KLLY7UVrb5T2H+eEapynTAJp89Lf96oaZCz+fhJPk8?=
 =?us-ascii?Q?rYsUC4RHUqkeKFj4Mm+hNXcGidT7lJmhsCvgkJogr2SZjN8M/S4ByDQjxpmi?=
 =?us-ascii?Q?BuwZDG0jusk3ZWYwgIYWRtJCR0bQvG6BoHTtzx2vfQ0zw6/w6GC9AvpA6M+r?=
 =?us-ascii?Q?mkYswiIMrf4M1q9zgqu+wP3/p5HyVqmvfVWBM2zmoLx8irg2e9YxEKmKPaHn?=
 =?us-ascii?Q?ELSaoYqVzFjyA9Ats60Mhe4Efrrl2mHI+B7MufSEEY5+jK6CnK+27TypDsUR?=
 =?us-ascii?Q?VTGYcwNt/m8l+FkQrMcQzBAuAjNkxEquJOZOXkCMPFTO5oJeGPj/JNDGsRkS?=
 =?us-ascii?Q?KCYo/1TIqsKZKvU96dacam9MU3RkGZumY6q5NwOhL/VlfVCzBzTcItgTZ99Q?=
 =?us-ascii?Q?DqN3l2w+Q9mE0U/cbXCG5fz2r01BE0nxolbgnS8VhuENT9bzgWKE5J34ZTpM?=
 =?us-ascii?Q?UauvXSpE2EtSfXka6fG6m8+3h5bclSOHrX14+VY5kc/qzt+LaCyykaTldP0G?=
 =?us-ascii?Q?3v5BgKyyCIAKHd34RF6vs7iEWYP7qKm56+LFBldODVHMb0U0bvxAioqKug22?=
 =?us-ascii?Q?KGWfhTjFUFkkIOkToCcLhEMlO35RFDWqVObxrRk4xx1wGp1MSgb3ccWVRHDG?=
 =?us-ascii?Q?zfIe2Xr0Af1BHsAEt65O4mh2rNN/3jN9h2RTSCKjtOXQwC9N3Fvj45eW8XBp?=
 =?us-ascii?Q?MMixaKus1yrGbPXGSxOFbah3vRAnZcncSClB1UWtBt5wvDIlMJ0RDU0eXd2F?=
 =?us-ascii?Q?cmV7NENnZ8v4LV2C5Z2Vqm/V3Ivaf0Q=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	kYQ31Qe4+dHJqihi9Rx0gLAhy+QdC/NUIG9ksK+M+F4y+KCPHlJqDVmSKGcTkm6L+xjN1x4XCyGPqUkemC4CSRYcBXmidM2m+9HKnBOmnEbb085pBBrFhUKzPAwf79ChP1+5nYb+A9WV9+JVJpBS57b9QrHRxtD32+TSjLwgBXwjjnIpHIlIQYg9O3iNstwxfnFLkuEVoLjYGYoqkn7i355VvaOgct0LoyuZNXzTQFkeHhtfRAKjJySWmZcK0pnD96QLREX/IjyBxH713V/vBjrntIeHo10KFrRWUM7drDkmGpQdvB1DOeD5qxsXxpDZ4FRth9cT8LUZhcQy2Dgls2IwKAmgIC7XHxKJnaykiZKpZkwvsuc7Hv7SnEk6fIHU09eWmrZyWZiCD/CADCedpKqWYpAe4Km/FLbsRyBurPumKavXBxnqxFCWoYmx3LUMfNOkXHwl6xNNEYB9bkzeqrF/fWOH/YBwULl+ohfxkEVC7bKIQwYe2twBv6bIj38o+PZaqCL6Lm90vdXfptgGO9e1aQmYKiK7Is8D9Lq1/RgnR9LOxJFnKfqO92h94+JQmU7yytLlzK0HElvvbC9MZdPp6dDfvtJxqaGZw/CeNUA=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0c15719-e6f6-49b7-fba9-08de59c84aa7
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2026 15:09:51.5342
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sI24Wjqby54ISExXIqavrsazQId4vzOcGnuc46gDWAx2s03fpXBqRDsn99zpwvdgyxapYwc+GIBMbL5uDOp9IPH7N0BK2q82KEGj9KnBqZc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR10MB8073
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-22_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 bulkscore=0 adultscore=0
 spamscore=0 phishscore=0 mlxscore=0 mlxlogscore=999 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2601150000
 definitions=main-2601220115
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTIyMDExNSBTYWx0ZWRfXzSUEMq4PCMih
 391X7P1Q/DgsD5dhuvaaKG4KLvIKLDB4CIo5vL7W1Kw4ZnHJ+ELx0i2p3bPI/r8e3hZtbCE5fty
 SQUpk7oQ/1VtctWoJZE2Sy15gGNYwSCQlOL6fIlkWlVAq9D/w93uGciKjYy/wsyWTIWmk45HI1S
 QOh8Zj7F9hWbjphWWqCwx/3Fic8Z+xgvq/FiVZOcnv9sspf9ocMHkEXSMmt1d5oWKg7ov38tkwo
 EdIIeuNr/8KnKLFErS0Gzt11qi/xm/6rWZKiLovs4tOTiLKUud4saWeUK7BUsYbvNzTFDWcBut3
 /vKHVYV51AYD1Cyo76Xn4rSgdgmEr0pwpWBBnsuyXaTstqLIwLYR8tP8tBwRbcbwYtCDMZgttWj
 3WAn2FykaoX1+TbXnv+1NHuAR9KGrHUGGbYCsT65W92vo2YHpAD5Nn2NriwjDPKy5etIT242TDX
 BrrwNdOTinv5OsQG7PKEG+vFB/QV+DUCHv31jGfo=
X-Proofpoint-GUID: Xlpu7SM-y82t2qsWCsjsV5pGMDGdx8mN
X-Authority-Analysis: v=2.4 cv=XK49iAhE c=1 sm=1 tr=0 ts=69723dc5 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=GILQXRegsb_ztLwdyZsA:9 cc=ntf awl=host:13644
X-Proofpoint-ORIG-GUID: Xlpu7SM-y82t2qsWCsjsV5pGMDGdx8mN


Niklas,

> Commit 9b8b84879d4a ("block: Increase BLK_DEF_MAX_SECTORS_CAP") increased
> the default max_sectors_kb from 1280 KiB to 4096 KiB.
>
> INTEL SSDSC2KG480G8 with FW rev XCV10120 times out when sending I/Os of
> size 4096 KiB.
>
> Enable ATA_QUIRK_MAX_SEC, with value 8191 (sectors) for this device,
> since any I/O with more sectors than that lead to I/O timeouts.

Looks good.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
