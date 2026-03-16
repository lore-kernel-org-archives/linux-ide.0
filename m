Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045F6288AD
	for <linux-ide@vger.kernel.org>; Mon, 16 Mar 2026 01:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.165.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773625856; cv=fail; b=heedZ2dnZupD+lFosjS67CnPAYOx7J2ElZkNvuC1ZJzfHB6XMz5HwA10Ctii72EPQX2VuThbh+XcHmlWktZTcL31vr9+wX8zdPaxe5DH3v4yV7fYxRuXM+HY7QTMfv7fuDU08BuMRg7MIXGRu4R1tGOh7EJRpJNm4kExLDLXT1c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773625856; c=relaxed/simple;
	bh=w1wfiIDL8nIS9yPO37fFgw/0aukQFh8k8waRAEF/JH0=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=MOLwN57+3+ioXJEii08Jq6ebFK4LClcDuJJSEzlhUUs+pUYBnj5rDd5UcOf/Msybb/34Lux/JkMnIhUHb3JeWF2gSVGOrDHnciosGbdmBXCWc6O6Av7pL0CP/Ollzbm/UGwBUMmR3rN6cBs24tRtollaNZygN7IGtn81g2lX6fg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=Xc+wG0R0; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=YO4+ul6Q; arc=fail smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="Xc+wG0R0";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="YO4+ul6Q"
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G0M6l8849771;
	Mon, 16 Mar 2026 01:50:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=LN5+WZl4MvvUfZhaJY
	uWrKQx3V0fxVWZDt+4vmK5LO8=; b=Xc+wG0R0zmHnkg01vMnFsx+KpLnk08UCQV
	3vTXn5JMRnFoMwwLFxzNeTeOtIhZoKBmmgALbrb07oQDboC0luWgrmphAuQUU4JX
	V5imFaqGQCM4CrHB17rY+hZwuX5OCuO9C8IrYqvkT+zh/vTZJx8OiLD3ezCfiKJO
	rJCpZ+hdxnFM7vfIU6Pq83hWsV2t75qYwWN7heq6wDZAHwO34RLiUE9Zp1bm+pkS
	+NAR7jVAero37EPlykgYJd4zwos3hb9QdE63aJvPqaUKcFABu7uCJmhQKJPukyPx
	wOijo+WZEsHPOgPd3LSxemXR23gkvojVgrDBe/e3em8u0uiNqp7A==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4cvyj61b4p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:50:48 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 62FLYEmk017819;
	Mon, 16 Mar 2026 01:50:47 GMT
Received: from co1pr03cu002.outbound.protection.outlook.com (mail-westus2azon11010033.outbound.protection.outlook.com [52.101.46.33])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4cvx4jgwag-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 01:50:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dA+2Grx5rtpWpTWQbcxPwmgAnmcBrOkMsTEj+HL+uN6ryvXFcyOgNJEYZY9UuV2BhRuTvNa6x/4C9rOLaOWP5JyGnlqKBeojc2n0iRuy1egTQQp9i0I8uy11XPBbDyaOvN1kYXzYUVlT69AuW5pACdjRNLXxQXRtcqcdCktSMjG/KbLD6SunfWsRnqn3+zRvTeDnfoKlOyQGWHiNR5FO4mdWPLJES2Gzb0lMPzL3bNp6oLjlK4YuutRtCHqtWnNBuOVkgwbTILwb27GVuC6c690VmwbnzYEaItcHeudXj7W751pwd5JWlWo4REb6bGkvREvb/p+N9T/UYT8NVgY7Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LN5+WZl4MvvUfZhaJYuWrKQx3V0fxVWZDt+4vmK5LO8=;
 b=xLHEwdW3jJmS2A+ghAtJKzduJt2m5J0jP0jYXmM2+6V/YxL583MV9VHgPOxJgzk2SulBfCmIjrCctsD3RZhDaFCF/vc20sJXHfdB5mVPML0FLq2N5zTlY8QGg9sFR34GzVKIhtb1CpbiZoper8gm0wvS0ePqxmuCnNq5UZdEPh94bHD4hvG9IQbRt03AbhQJgtkPHDxFCGfMnfzTBmzKBwwHfOSN0VfY0Ca5M3NjgIIkQXdPyp/x/KvN/9+gScUMH7dqaj+eq8NwEHqv9F2817G6HoZqFgLdDjAapUEnWv+cuiKo97FzGhsX+25W3S0cCBp/bamnWF906Vf88bCadw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LN5+WZl4MvvUfZhaJYuWrKQx3V0fxVWZDt+4vmK5LO8=;
 b=YO4+ul6QJHw9hFgGh6GpgeWw/0p3XmojJ+D7Er5K7GpGwCG7CTFKEfccDhx/MwUfw5H3g7Ql34GMohk8QgSytdYt1H7EZK/CcjTOG9fT+h5hWt2cjz8bXLatgcXwbboCh+mzBGHS6oV+8SFhGPvQ3iudJTe39QeAHnwbmgFx1mk=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by PH0PR10MB5660.namprd10.prod.outlook.com (2603:10b6:510:ff::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.22; Mon, 16 Mar
 2026 01:50:44 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::e525:dd71:b002:6ad5%6]) with mapi id 15.20.9700.020; Mon, 16 Mar 2026
 01:50:44 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
        Mohammad
 Khaled Bayan <mhd.khaled.bayan@gmail.com>
Subject: Re: [PATCH] ata: libata-core: disable LPM on ADATA SU680 SSD
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260314222415.51176-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Sun, 15 Mar 2026 07:24:15 +0900")
Organization: Oracle Corporation
Message-ID: <yq1bjgor19e.fsf@ca-mkp.ca.oracle.com>
References: <20260314222415.51176-1-dlemoal@kernel.org>
Date: Sun, 15 Mar 2026 21:50:42 -0400
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0134.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:87::11) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|PH0PR10MB5660:EE_
X-MS-Office365-Filtering-Correlation-Id: a19b3f15-5e99-4ab6-4727-08de82fe6f9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|366016|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mTxox7e88h1mZa0EteHOTppMQvNCZL3HrMp7csSBqgX33/nVpItnx3jLT3qZb8QUJ2wv3NiuumRAgNfc1OLWmemdbacy8aAtnFm+N/vDx6jnPT1A+aY0H3QT0lkzLr3JaOg3BGSWX2V+s0FF7TSUuvG2tMsRt16UyRmtQ2GSR4x9JNe8p8QdS+Qc6IRc2pLQXX1+H09/FauHGRmLYAgW7zEYSBdEEJYE+rFTl7++Gpmk1EvhqVQ9t38FEnzvfasXwAI1LdUP6/C1rCpDg8pkMy2MhWdsiQwczEhTHFvHA6UgFTq41RrZU054SFZxc63QfivoEX8Xflz3rJOUJ/Yg7mFPuE+lfJiNMlir1B/qZVYhEB2KX7c/O4Wx2G4qJqGS6IcoRByBzedPNtkxBu8bGlGhLfQZ5NSeIFlPBaPYj1LOCxsBE5CWgaNszSeE/duYAn4ZbEZv0BlVvUn3nNavhxpDz++zJmWvWOd1u3EK9x08PVZB7W+VVcgn0NfC4HPp2+W//YF+V2paZYVeV9CxkUeXs1rZ3IpnAQ+XTtZWI0q8pBhTaVN9ad+DWRTaEOE7qfsOMvdGuGdW5uLM9he1RtvinT6hn5ZbT91lSprH80flBm165o3pp/bQx9txzqnShI40QVf0GiC3zMCUJQ9eUk+QbDh4dGMOPe4Wr01vwjOEXc02Xr3+dCkPX+k4fMS569BysATYdNh1m2fsYiO4Y8LpII7p4+iESCp+bg0Dj6w=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?e1SD/np9KbPBQuzacwdq0NSxNk+KSYIMca69wuHF1GoZnmoQzXwfQOJ5kSgu?=
 =?us-ascii?Q?o5dCTbUF/4xXU27DldhiszGB0/EL1ZaQFgA4mIGB/XUgw55MV9uwGxZqggwF?=
 =?us-ascii?Q?WGdmBM8PF3cZ9jUp4d+6tbrDfzVTnQCKNMTmWessSUoDOR8rHvuvqxiwWv5Q?=
 =?us-ascii?Q?Lm1GTCW3vHdniTvKG6KgjIzATfc/0mjRwiRhw8GgjG5NH1YVBdKXekFVNnPd?=
 =?us-ascii?Q?iakWlyMIl0IllzCqpTsBZvBEQ99ODK1VJWxjDCcGNAjtqm9xo1BY2epQUxm8?=
 =?us-ascii?Q?EYeJiOGFQzIVBOfWn3Omkinz94EIU8zXeVFF8Ex9MyiXeZN2NYAixfDPZGu+?=
 =?us-ascii?Q?LOnISuHc+k8dfWQZ5KQorKBTBC3UJsSc3KIArPDeT0MLg3dyJfQsUPD/tOrN?=
 =?us-ascii?Q?tC9pgxSCLglG8VPiXKa0Gyt2So0GNO+f91Q1hikF7HMvDa117EhT+aZe1J0y?=
 =?us-ascii?Q?N8GeGyv61B/YpVgl6UWqSSp+0+xcANW4fpjKkMNP2DD2UpJfnMgCpPPgej53?=
 =?us-ascii?Q?6MpF1RvFv3L0YeYF6dFmMFVIb1qQ69kz75HQIXj5U5/kcoWK0M4JB0l1Qr7/?=
 =?us-ascii?Q?vtdUVy6oTP5guzmdoWHAvyPlfQaQ+D4YCndhrFt8BkvJT1b+N/6pB1HlQUzT?=
 =?us-ascii?Q?o5ujqD4oo3vomhvdVNcNfzADBbRDWKZr1TNaFCN238w2+C3gh1asTcd3yRDJ?=
 =?us-ascii?Q?nDWbt9iAWad5Dd5qY+YLKpk8YwXeAm+dHQFbqjwLyHr2Q1f9F+P17gqcZYnU?=
 =?us-ascii?Q?k4k9acNJZkXi+72+D+PIXq8Hvn+2bxKRlZMl1ON4vP04EFUV01UbF9UN1Qeu?=
 =?us-ascii?Q?jSqs9z8tnl20m1nuB+ru0wENbkyGmSlS+s7Uqr20bhInDj4wlhflLTMq42+q?=
 =?us-ascii?Q?G/KBLog3OD0ylI42gmwa6tOZpn4peZw9DLyKx3EGeRnCcrtzLSQB86QY7/N9?=
 =?us-ascii?Q?jygs00JKKRRV0tqrq7Cbjula6UPZW9v8DS34XRxNn2GKzvxjBkXYpeYGrJJF?=
 =?us-ascii?Q?CtlH1A74sogb8Vis5vyveNYGEWKAT6uGBGqf9fweMkBQKB4srM7A6aFJD1SC?=
 =?us-ascii?Q?npoUw/2nVIJHo8wI9RItKlmRHrY+mvwEJaJtBPzzK7Nk2I4mHmE+ODH4Aejt?=
 =?us-ascii?Q?5pCz/Vce7F0s8YPIGiLSzs6RJcbre+N6HHK2/1LoeI+YEttFP6wtt2qCjE73?=
 =?us-ascii?Q?uac+mtVmKRXLKEEBNlAfc9WxdocX0YjY34P3uy/HskmjgLYR4+ULnLLlXsEO?=
 =?us-ascii?Q?LGEgS8n4rtLSXzlLzeRiyGNAnJ6qwJnC6e4SlEqSQlMnb/A2e/SOPq0sGCZU?=
 =?us-ascii?Q?GsMJEg0eApJsEWJ/UPycOxGFA+4QRjgUSV5zM5XHZSC45lwbiw49fK6lbTWU?=
 =?us-ascii?Q?hee7GUCM6Tx3Ac/d4u/mKdYs8VPBoUU5qJq3aXdAmDmNGKmKjDK2jSrntXaf?=
 =?us-ascii?Q?ayh4x7mIF7qbitfqPy+OVKA8F9nDY53wJzsrBe8LfVGrcuMxCpbho1vNQGOn?=
 =?us-ascii?Q?54/nJGwPUjOCUdI+vVHriZOWVquxuKEcgvZog9diXPgy2DMAuK4FhsPrPKcc?=
 =?us-ascii?Q?A7h1JRtOu+Oo0m7NCq59cyqD8VO0mluSY1zSZ8jKHW45fh0qUQIQ9zRs+JeE?=
 =?us-ascii?Q?TVJkLmto+es43sBM3GnHDUFHlZq9YoOoQkiRMQx+wWHf7kKjTd2K8LF47nIE?=
 =?us-ascii?Q?ruRQ8Ae1BwLgICzCSmyl5FuPBCXXesDqwRY63MGCCdqrX+ewjdQmHhDmR2hn?=
 =?us-ascii?Q?9+kgkxY246M7Lu3ISmeQW5bONRD2vq0=3D?=
X-Exchange-RoutingPolicyChecked:
	n5A9nnIuLZg01jtyy3AaNbpModFedUcLlpiI0wxbOKBYti2Wcwwburn+EhL7V1mA1zl/ML+a1YyYQd1/PlDoWUCFHPNelPnJ0pzvZbTo9ojo/xa8bZuNKvCWffa3ehDoLhBhc6cTc0rD8f5NFJsuU+6E0y92ETmxDuDtkAuejswNmHMuC6eVYHkcpIvf9zW++potauz81XgiNnOvc2FMPsnzNqDITYK7TW92eiqi8Zq7bF6VxyxeHfpicVctqBTlAtjtHNJo4sd5EJtnPtEe2XS+dSQZMLh48/uD9pXK2wdFtb7oGgqmS+CWcPltMBWnU1sbO0ifUtCMvGuai81l8Q==
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	b8PHN+2Wsng+1JfsOnIKXN2xY9wzzmIwPYs3hbJctpuMJg04UvrFLisBeLqckQxIvW5q+bLKsBjNBtUb6bvwG08OuKg3sFuUZHsP97BEzKALk6zkXcmZD7h4kg/j+pGo0wyn093W0Mh+jhshkptO15nESUnbtYonblfBF7NTPAIpfBhLIOxkkTGKoapA/rCxm6oKg75pgJGmcLZkzltoxjPnVTiA2hDnSoQnHu23iDRuHAMisC6Wn6anwcZYKS22J1qvjJcCAm9ITiRlXPNeNM399BJITnZhHwslR/nV0mF0EchYmjY711Gx78JxXAswkYDvtzhSYGCoqixnWTg9thfvPu0jQUJK0yD3nkhWCycxYkYGMFmerXfOnrf1vhu/z+PPiLkXax8sxnV+AAlHSsz8Hxnjqbu5HiVolJPX34izAbmpKIRyUnnq5EPkmMJGUIwhNjWlQwHlLcEhVqr6XAZtZ57XojxpvZ0uBZe0spCGdqNwL576IpWeNrxKXNz25jcfYvUIB7fljnmxgytvjIK9RvO/GAscAsGhYSRx/Vao5/UCDDES046hBfMLz4RuE6Yb3gVpwI5sI+WJDrXGvVjC8C+dwHsFNg62Gr1mfhs=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a19b3f15-5e99-4ab6-4727-08de82fe6f9e
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 01:50:44.0841
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: T3gONwvOmL03cOwF1ipe8cQtiSgak+ZpaOiz7k0W33Y2/Q5xp3CmLIlqQBvzlME6wAmfFBgf0UMhyQ/yVK8M9jOged47vyVkCk/q3s59rZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5660
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_01,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 adultscore=0
 suspectscore=0 bulkscore=0 spamscore=0 phishscore=0 mlxlogscore=855
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2603050001 definitions=main-2603160013
X-Authority-Analysis: v=2.4 cv=LKFrgZW9 c=1 sm=1 tr=0 ts=69b761f8 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=Yq5XynenixoA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=jiCTI4zE5U7BLdzWsZGv:22
 a=EIcjfB9IiI4px24ztqRk:22 a=yPCof4ZbAAAA:8 a=pbmRV8vGUoh4RZjMKNkA:9
 a=zZCYzV9kfG8A:10 cc=ntf awl=host:12272
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDAxMyBTYWx0ZWRfX5SMhhyHvvswi
 5npofUbE52vM72f6Rs0mmpapb+IQuWjKWPNKLWpbGlX0wwnutMTet6IV6X6wSSXp1NvAPPv26WM
 fppvXQmvxe/Z7OS/rSbK+O6zFEkBS4AXfnkVoRbkmHMhhpUdc9xl2ZogJR54tPM4K/r5Ef0fSvK
 LABB+9ui2a9f1BodcdIKU0A373a0Ij+OaR+U0al/RhxAjR3ERwyxwdQSfM5ivvclkJ3xLOr5jJg
 ffMLXCVjADD/NTaDQNWYSRSLvQ9QlI1A3ekFFh1glFK1HfGJg+KxgWFawRvaGkFtecG85oB2u6C
 0Xc/qMxzxAix6ClJo9GaUsRj2yh0Oc6OUO2VnfD7HbmOw3m+bKt+zcx6NTs1dtaGUZVuHFBF0NJ
 KdGWo8zq5TDOA3Hr9rgxLmlXA5YqkpP4P296QeJ6svPMRjRJbEZdNWryAzhQioO/2IVRqpoVd5B
 iDdjD9C5y5AY8MC4XfhlOl/5Q2yOfRvULACWtijk=
X-Proofpoint-GUID: iLPXRKPG-3ih8HN2xffNoZGKhxvp3aEU
X-Proofpoint-ORIG-GUID: iLPXRKPG-3ih8HN2xffNoZGKhxvp3aEU


Damien,

> ADATA SU680 SSDs suffer from NCQ read and write commands timeouts or
> bus errors when link power management (LPM) is enabled. Flag these
> devices with the ATA_QUIRK_NOLPM quirk to prevent the use of LPM and
> avoid these command failures.

Looks OK.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
