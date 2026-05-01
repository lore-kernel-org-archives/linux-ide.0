Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88D541A6834
	for <linux-ide@vger.kernel.org>; Fri,  1 May 2026 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777645182; cv=fail; b=dGiSvmS7hKIjWfB2uAvocKuGxf95/gyE6wr8ozp7QNU2k8MV/2MdvmgWD7l34T8VBAMm9TnOz1nKC70hbASGyz5FyRZXZRkcw2rAnCxfdRt6/KRXAoLLSLjCOu+AsPhNjeSZDOzLtyFsu0UJA9bvZK44aamK4t289aRBs3oVzsA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777645182; c=relaxed/simple;
	bh=5mgd/Jr9Si5I09K0qJ4PfMTCi97kVIPxDB1iLgvL6w8=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=qzSAV94wOTNIsnrUYejZkclAZs810ZFpFzlKH06/l/nw+tWgDiz8kJSSxE+FjB7jCYPXjg3FwjVYgDA0ubG+71ojWbIJ2LGcBuFwQVQ3PEK6vyODBSp9I49sd2VY73w3flW5wJevJvI9YuNpO/zoXhagdn7qjSqsQ60KL1ONRFg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ZK4L2irM; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=p/CRscl4; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ZK4L2irM";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="p/CRscl4"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6414GrwL622771;
	Fri, 1 May 2026 14:19:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=c9/615yX9p2mfp38bF8U4poaNsHlsQ+yW2jJaJMsljI=; b=
	ZK4L2irMvk3lhYyu8BbN9br9sRJXBv42DKIP2olJtoYndecunCbXoMq/ZHuf5FOQ
	spvN/5ABb/aZy4JMyaKbBeSYf18gnBGmdTRCs08uhQmTpKIRoLvIXZ2mVGRunkGy
	W7w4yYj+XLCgKb/icmS0xW2Hu+TKNZPVNF6rW7uCFdtuofzSxx6WqSwPxfUFN/+3
	T3HacmMo/CzikAWFBINTBt2FrBQEkwMGkvwbSkheBWyQB1zLKvXkywwLRcfSOG3N
	lUoToxqoZsqoy6qgY22Sj+P/fAxodDJTWrWZwexKiIJ3w9+3FS3Preghn6lSgxLo
	HdFncttsSN1TkVPt7uHj5w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4drng8qftf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 May 2026 14:19:11 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.7/8.18.1.7) with ESMTP id 641EGIOc015097;
	Fri, 1 May 2026 14:19:10 GMT
Received: from dm1pr04cu001.outbound.protection.outlook.com (mail-centralusazon11010036.outbound.protection.outlook.com [52.101.61.36])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4drm2gwhwb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 01 May 2026 14:19:10 +0000 (GMT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZTXK6+us5CQk4/GDDyPH0iV0jYxexIcf3C0aVX/4JtEqVOoVAsOK4i5UQHj2JyI+nv2rmfx9DTV46jWQTIaTYP8bKqVPiQ7SID1irqp5JdTMWvcLxjL5GDajJPg9ajLKDXlqBCS5xIEIwYe0uKaRWsta3+edor93clCEjWiAVC0L4SK99ihT1DoYdmCn91r1YDpAOEYUBQeKzqZFW/oII+aQXK1wX12e9FK66SyQCu+H/HvIVYap+H3dcnQ9zLVZ1kgOHEJDvJJOd0YK0TjydIhAImebbydGOkyi2Z3dnXHI8nLuMftoi5bEDn32Rydt7GkKEzCeToQvIyUcBP4iGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c9/615yX9p2mfp38bF8U4poaNsHlsQ+yW2jJaJMsljI=;
 b=O4raERd7gklJyNrQ8Vuze3e0PS6vSftisZHBTBz7grscI7YLW/+o3ZK0KsFor+//jxotN4LFfjoUTlQJFuOvvAvPZF521HEcRr4khcpUGQQJ3HBHU0uXiMbgOOAYN+YB+fh/vakw8LuRp6BuFeQFPgJj7LP4VBhT+oNygOM1//a/zePn2tGUXwno7z/hfe5PB1ddh3wvJ3GcsbOBgon8/SQX/1rJUvcaSM+7v08t8kYnl1AyjBvnqEYwVZf2t1rezRJ0GZnXJeovBmc2m7ajOGYrDrvGL+x6VTGye4qs0JCVPJOHAAIuQYPrplfXV69y0RiXXETY9BiFIEkbKYRwOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c9/615yX9p2mfp38bF8U4poaNsHlsQ+yW2jJaJMsljI=;
 b=p/CRscl4YCYeSWLc8/3vF7Vgde8JN1KJlXoloBy8+v8tAxVCrgb5FLXQgDlkpJZQ9qqLCtfgZQfV5OwvikTab5w7DeUUzX7/FE9z/d4YJ6UzOqfOa0dO3q6+Wn1AUA4fOaoxG/squ84nKpZPxBbUQGXZOfSxGif73yXXTWgqShA=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by PH3PPF2B2347B8A.namprd10.prod.outlook.com
 (2603:10b6:518:1::792) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9846.26; Fri, 1 May
 2026 14:19:07 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::9da2:46fe:4d63:a74b%7]) with mapi id 15.20.9870.022; Fri, 1 May 2026
 14:19:07 +0000
Message-ID: <4be77745-2b7d-416c-b01a-88669d9bbeb8@oracle.com>
Date: Fri, 1 May 2026 15:19:03 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] ata: fix deferred QC handling for port multipliers
To: Niklas Cassel <cassel@kernel.org>, Tommy Kelly <linux@tkel.ly>,
        Damien Le Moal <dlemoal@kernel.org>, Tejun Heo <htejun@gmail.com>,
        Jeff Garzik <jeff@garzik.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-ide@vger.kernel.org, hare@suse.de
References: <20260501125410.1204490-5-cassel@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260501125410.1204490-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0150.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::11) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|PH3PPF2B2347B8A:EE_
X-MS-Office365-Filtering-Correlation-Id: 2de41cbc-f431-465f-0db9-08dea78c9af5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|376014|1800799024|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	eE5KrleeSvDUrLQUu3fsn310Lrm5TBeyrPdsdB5vS9XrSJVF6vbNWbQ2mg6FkZ3RFs4PsiN6lWMVezNHcmoE4B8/KBN2Mnew6+Q9me36f697V6Q0WC9YQJ2mxyS//iJ/xtQnB8zGFWELGALwFog0SIKY+CgOkSl1SIXSvh9SR/fku4d+TQW5ALJDtdGGyO3UVYbTOI0AugvoSug+9MGHI4J4xOLcNrNJpkQJXhLVUgBdQz42GGqgBjuZUirND80Jv8SbSkjSODh8+ijI2hJX6+/vYIaPRnv7NLU6wDJFJq8ZChjsGRgfK7fC0/OWwdUgYH0j+9zZB7G0zUQ+knqfL2ZgWqR9NIpNbJimgiqC8mng3d/CzwmON+kgojmNUov6Aa0yA6I4UGSFOQnPDppnQWI7UJpwh1l1pXB1AoK/ikpKIzU2tgKsnozDf8syaR5RSoNeW6BtrRfoz7p4/zWSegfE/BouWtXlUTm9vkm8i4sztcPkGQazJEC2Ty2Tt4cFNvfQbypXoqCej7+52LjVFI/rOgdDDmKhBbYagpDx0/+e5gKjO7uMaUT2L0LaUo25T5Hcc4PTJR6Gk8U+rAjFtVSw2h4B/J6On72V/mU2B4P2fBhPXI4uZD8rSYlgxm5cfBHOnBHGa6jf50v9bGoYCw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WHZaRURoRGVFMERPTFVjSDNmbmlkMEVkbnF2MTFlRnltWGxETFV0R3E4Zmty?=
 =?utf-8?B?NWhOYmRWNDNxZ0x5TEYrYzU3MUEra0I4RS93OWlOQXpGK1JrOWFacVV4ZExM?=
 =?utf-8?B?SmkzRnJkakoyMkNtNjk5d1V1MDk4WTk5djV2dGVRUDY3cXFKR3c0RWdsankw?=
 =?utf-8?B?M2pBcVdvYzUyYVJmWmIxQlF3R2dCNFVwNEtwVDFPZHVGUml6R0p0UHVIMTVE?=
 =?utf-8?B?cFIvZE9DTHZ1SGVqa21YWW1mNEJWTEFwdGRaM1dhclRuenpUUkR1eEJOQU1Q?=
 =?utf-8?B?WmhFN09YQ0dJeXlaR3BISTNlNlBkS0VLOUNzRkVaN09wNDlmNkZLa3VMMHp0?=
 =?utf-8?B?c0tlTkUwaWlMM1hSQ2JHNFE5Mkc0RS8wYXloWWJTY0FuR3pLWEhOdXFJbU8w?=
 =?utf-8?B?M2FvZ0tWTFF4Z2xZd3dtRDk1NVM3U3hOVGswajNYRDl2WFU5ZmhDekpJNU1O?=
 =?utf-8?B?NDkycE5sOTFTRTZaQXh0T0szc2hBSi9mZDNmT1d2a0lxbitzcU5hWjNHdkJa?=
 =?utf-8?B?Vmc3V0NaYUFFc0RIRk16WHA5aDc2MzJweG9JY0tEeUNpZXZkeVNVbFFpOVpD?=
 =?utf-8?B?UTVvNVYwUmlhWThLMGFRclZjYzlmaWNvc0dLdXdnWlFMVVpONlY2OEdFeWVY?=
 =?utf-8?B?WCtpVXVrY2xqUFg4SThKOUFzd1c3cGhSMEVCN2RsbkNNTXdDSy9VaUJJM0lT?=
 =?utf-8?B?cGgzMWJobkUxK2NkR3NCbXdhcEd5N0ZGaFpOaUlOTThFT1owVWgrbHdoTHFN?=
 =?utf-8?B?RU5rUHdpSWJTZHhoNFJZaTJuN3RnR3JVUXRFZ1J1bnRkOWdMaDdBbFRCc2Jz?=
 =?utf-8?B?Z0ZYLzR0KzhqVkNZdFcxc1BCMUg1Nm1ia3dtOHZXNmNMN1EwdmpZaWp5d1NR?=
 =?utf-8?B?UGl1dU8yR1Q2bGtVaVl0TzNFOWhUM2duNC9MUDlLSlBuOW5ENXY5eHdjTGw1?=
 =?utf-8?B?Y2JmQjlPRDhKR3RNYTcrNzdNcGRsb2FWTGdnMXZiWkVpQUVPUVFRQ1JhVEdr?=
 =?utf-8?B?K2hBbDZOemdTUEU3bFRSbFplWDJaOWx4cUxQa1ZxYlkyTGpjaGoybVJyNkdw?=
 =?utf-8?B?dWp0c0JaUjhKYU9GelZoMmhScDVqbVRjUGVyRkhvb3lSeWdOQTFMQlpVZTV5?=
 =?utf-8?B?ZC9kMWM3L29McEVCZDVab3cyK2VUSGhiU1o1UHdCWXIrRnBhclJSeFNiK0Jy?=
 =?utf-8?B?YWQ5SDRlQjRsWXUzMFdDei9QMG1sWVExcE91OWtIOU9zTDBzR051ZGs2d2N5?=
 =?utf-8?B?NXRjZXFMeUkyZ013ZmowRDI1R2hsVUV4RzduMnA3SXNTN1ZON1FPVFRRdCtr?=
 =?utf-8?B?RW1KTURPTkRJZnZwaVUwNTlORWJpZDhQUHF1S0hjSkdmMzRJbEh2Zm96Y2Jo?=
 =?utf-8?B?YW5JalFkMGlDTDc4eXJVSTJ4bjlLajZxRVBUK3I3L3FXWW5WdUhORjZ2bVg3?=
 =?utf-8?B?OFJBUmpvUEd4SVRqNlcwbWZ1M1EwajFLa1VzSVpaa1NJOTYzS1J2b2YweUo5?=
 =?utf-8?B?dlhVSjNxMm93VjNFMlJ6bHh5SElybFBLYldTZU84SDVka0RYV3lJK29WT2JI?=
 =?utf-8?B?STllWjZBNWc0UmlNQ0JVNDFPd2JndlE1dVVwRFVkUC9GNjNSdTh0M1dsZFh4?=
 =?utf-8?B?R0xiSDYreFQyNEtRVCtlTHQreFRNTWg4UmhPbHJYVTRQMVpyY1ZnWTVMTytH?=
 =?utf-8?B?b3FPaXY0V2gwdEdPMGF3M2IvQlhwb3g3MTR4UXEwQTJ4a3RiVDNnNGlXN1Jj?=
 =?utf-8?B?OGdKdWtvV0VXMEY1ZHZ2bUJmYTZvQUxYTUg4L1AvL24zUytQZDZMSzg3NjB3?=
 =?utf-8?B?NE04dC9iODFtY1Q5RGQySUYxaFZtT3JXTkpkR3BOcXpFWms4NHFXTFFtd0Qv?=
 =?utf-8?B?ZkJIc2xWTisvcFM0RUNZbVNkazJYWmVEN3R4cFBSWXVNQzJnaGp1aGgyc1NP?=
 =?utf-8?B?RkVCdHpaQ25Od3JoQXo2Q28xNmpSZWJvbVlHSnFqaWQ5Zlh2Qlh0L2c2VUts?=
 =?utf-8?B?UmZIY0dncVMvWDZUaUxVV3hVSzFucVpmZ1FRRlV5UUErT1U5dUV4WDk2Uzdr?=
 =?utf-8?B?YjQxSUMvZ0pFNHRRZkI5aTRKaElqb0J6VDZycmNQYVJJRzNmNndkVVRxL3F6?=
 =?utf-8?B?NXdMZHBncTZ1REw2dDA3d2pCa0tIQ1pEYlNpaWxIME5tdHQ3WitaeEorM0F3?=
 =?utf-8?B?S0RRV3l1L3Jid1pDUUZ3b2lLV2tyWkZIcFlEN3QxcDcyUWNGZWhGcytKaUpw?=
 =?utf-8?B?V2Y4QzNFM1FlbWFTRnNUUkFaWVJzWlB2TW1YeVNPV3ZXMk1XZmJmM2pxMjFQ?=
 =?utf-8?B?UDlCN1BhZ1VmZ3JHdFJTdTJsRVhTLzZZN3MxaEpUaThqZkdsbjZVUT09?=
X-Exchange-RoutingPolicyChecked:
	OCIcsjFhrqsdjW9mj1lK1EKZFUOOxflLjdYle1GgVz1rvg6GCaJo3zo9phbRQ34Ex73Mo3Spy+izEIa7DiNkfT4K64fXP3ZFGRbArP1r683IffPrfQrVtZCCTZuBSrLndLDsDRn8iYui/xvHQGDh/WIFFUhZwHckm8nugOOok7qAyhgSqZ5zaapWIcyErynDdBsaW0web8q+q2e3V36ew29V/8HBH8IUCXZ2y9uIjkHa6X43YqDWrsUKTbHj1fdda5BENIjZ0AKFEiKJ6hrKbYFXnqAJQotzxuDmDz2BXOMq/LXF/U0ol2PNDxho09AEsG1DP6+axNtvrHEb/G5ZHw==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	iq7FTO71xiTkTPiSAdDNEv5/oKNxhA/2rvR1X9VCSzSbEa+So5XJ+litqRvA8qLY586r5MzVSYeOo3JMzjmgaqCMaIrvS+F6wcAFKoWvg6sxElJORzpmbvfBdHVoL14f3qRf5F3YKaDLCNNsgwJ4+7fatuVQTZxEDWfwIwtEZ8uJPqbbeKGhZ1fHDnZoc0gn8UpkezSSKYuLykWja0SxYYFejYMoDbmOEDwacDz0JM9ohJwdWLMGA8+GmWZiCms1DCmJl+PqA6jC41dcXKDzx0rLniu1cOuaIZZwSGs+ZxUe1sCEsjkVIzmYTHV9DETyKzBdSle5oJrMxyXFXp9qMxVNdeB4BSmm1gCBH3KK2mY7xzk/YBZga0vYGLi1x9KlWaV02f+IO2zoOO+8gNcIPWMaFi+9M6CfVLh00rlJO3Jgc5+/UKQLSwOACxaxmBTdoqAvCA6VRUc4jqlKzcSMvwKxFBtpuSn7YQeZHOQ+goXFsvza1qlaFJYWUqZEj+YDbtx63j94SzKvYrlnW3IMt/La//YqhEGmMJPQ4ZxNNlQOYELR+BPMivxbnbX+YbSspLflPkE00dtKQgVwhvUBVUMFxwzBxYFzFocJKdlVwL0=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2de41cbc-f431-465f-0db9-08dea78c9af5
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 May 2026 14:19:07.1501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeDAC6f4xC90PWFDOh3RX00EuTZaVc4N7mP6JNgAvi2ks63x9bowztr3LLDhh2FB9s+C/x0N/QdnI1Sgco8hqg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH3PPF2B2347B8A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-01_04,2026-04-30_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 spamscore=0 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2604200000 definitions=main-2605010139
X-Authority-Analysis: v=2.4 cv=U7uiy+ru c=1 sm=1 tr=0 ts=69f4b65f b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=NGcC8JguVDcA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=jiCTI4zE5U7BLdzWsZGv:22 a=EIcjfB9IiI4px24ztqRk:22 a=VwQbUJbxAAAA:8
 a=07-hrkyYv0_hsO-RJ1gA:9 a=QEXdDO2ut3YA:10 cc=ntf awl=host:13840
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTAxMDEzOSBTYWx0ZWRfX3Q4HLiUcI0xx
 n5DISK6ezu0RmAM8mjFE5SlMXn5resc0mXvkzPxFw6A99EKw8/RncZbEIEhhIyttbk/Nfagiykz
 atDDROnMAfnIrox0yc4UeE2X9A+r+qdgjzXS4mF/q7AoTIo71CczcVEeNyPt+IOL03db0xaqzVq
 k/2DH4uIdwsSdFBlDUnjIFedoQMk1HK4T/l9bvbROyJQPQkmMEmAbasjo/fXX7hCcs5W93OENDb
 P5e6NE278NM+woDZ572VKZFpY5tNZrBAxzS9Pa1pTbMEe+8D1OWL3pYdpMmNeJS7eROhtIQuz2Q
 4Ix0LrJFHgWdSwnJRNm4fnZ7wJ/omAwUrech9RAwN2lkMV2PMm6KQizBy4YJDMiJPPS9JIvczTe
 JSK7mGcy1ofE5hGXty2K2YkONP76FqfV2ZX7aNFjsJYSriA5OVOfdMEewQgMzIW3Fsqe+2ajIkj
 hiamEd4FIUV4BV/Z8TXvApMXQ+maSTuggMS2vePM=
X-Proofpoint-GUID: vZfQ-TGaUE-mPhNeAqTt6Y3ttx4eWHdN
X-Proofpoint-ORIG-GUID: vZfQ-TGaUE-mPhNeAqTt6Y3ttx4eWHdN

On 01/05/2026 13:54, Niklas Cassel wrote:
> Hello all,
> 
> Tommy Kelly reported a regression with PMP that use CBS:
> https://lore.kernel.org/linux-ide/ce09cc21-a8e9-4845-b205-35411e22fba9@tkel.ly/
> 
> To me, this appears to be a problem in ata_pmp_qc_defer_cmd_switch() that
> has been there since this function was introduced. ap->excl_link did not
> always get set. This is fixed in patch 1/3.
> 
> While looking at the code, when using a PMP with CBS, it turns out that we
> are incorrectly using the deferred_qc feature that issues a QC via a
> workqueue, even for non-NCQ commands that are issued to another link
> (a link that is not the active link). This workqueue feature was meant to
> avoid dealing with non-NCQ vs NCQ commands for a single drive, not to
> duplicate the existing ap->excl_link logic. This is fixed in patch 2/3.
> 
> While looking at the code, it turns out that the deferred qc issuing via
> workqueue is misdesigned. It assumed that we can't mix NCQ and non-NCQ
> commands on the same port. The limitation is that you can not mix NCQ and
> non-NCQ commands on the same drive. However, with a PMP with FBS, you can
> issue (mixed NCQ and non-NCQ commands) to the different drives. Thus, move
> the saved deferred QC from struct ata_port to struct ata_link. This is
> fixed in patch 3/3.
> 
> Tommy, it would be nice if you could apply this series and see if it solves
> your problem. Right now the series is compile tested only.
> 
> 

Hi Niklas,

As I understand, this deferred QC scheme was intended to solve 
starvation problems for multiqueue SAS HBAs (using libsas-based 
drivers). libsas has no port multiplier support, so I wonder why we make 
deferred QC scheme work for port multiplier, i.e. non-libsas scenario.

Thanks,
John

> Niklas Cassel (3):
>    ata: libata-pmp: fix ata_pmp_qc_defer_cmd_switch()
>    ata: libata-scsi: do not use the deferred QC feature on PMPs with CBS
>    ata: libata-scsi: do not needlessly defer commands when using PMP with
>      FBS
> 
>   drivers/ata/libata-core.c | 16 +++++++---
>   drivers/ata/libata-eh.c   |  8 ++---
>   drivers/ata/libata-pmp.c  | 13 +++++---
>   drivers/ata/libata-scsi.c | 66 ++++++++++++++++++++++-----------------
>   include/linux/libata.h    |  6 ++--
>   5 files changed, 64 insertions(+), 45 deletions(-)
> 

