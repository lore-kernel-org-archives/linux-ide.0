Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E550A248F68
	for <linux-ide@vger.kernel.org>; Sun,  4 Jan 2026 21:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767563369; cv=fail; b=PtPoZnIu+iJlwsWSd8q6fvM8E5S5hnyc2vFejfyg3uZel+rsKTIiDqzwjm+VU1M8DQCZhTm/ZWFFIOQ4jF0G2OmhnfFOeLrrm5yzIYBR3wLH3HXJZrSm0g016pqMTsf8qM/BU9DSTkJxEEv5JNQYJkh/yqnKqy/6Y/FRwfaIE3A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767563369; c=relaxed/simple;
	bh=gqCBDrDY9ytcw2nTROSaxiiYvoEe0bjESfZJMSNRAk4=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=vAHZhaQ6hUikfwMBwfsZ8vyKi13RG9pSCOcUoNgJEk51+zvGHPuHM4bg2Skrj4blQ3Dy3+l4Yv0n/ev9y9a6NLVmHMwXvQlnzkXgtAZq3P9k0YYrwom6wWO0s3WvVV77OUCBG0qxyCDtrKmKgVujoa+jA0xARXFl3SFAGtWbB4g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=j4/3D81E; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=KFo+3Jo3; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="j4/3D81E";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="KFo+3Jo3"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 604LdLal4166512;
	Sun, 4 Jan 2026 21:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2025-04-25; bh=FGMnVlRD75m7x7fq3A
	PuN42Jpf1yXaTHhEKUqRiRlH8=; b=j4/3D81E8frQULindAdRX5bvKOjHEZNVlm
	z+noHHYPjT9Qri3XAK5BHjZdcP7af+/dbA8uPTJk4cDiPgLMwD30t82RBsIDPkw9
	f7L+ww9nib3tb4qzt0kOEaiwXC7hNnLPFXHeLjP9s0nggMSidCbJdha+TPbJIao9
	PMGIc8Kw5mEhyPPjJFO1KCC7uANdEUbbrLgc8QhEOaGGZaexmvPFoFznzzvho+pf
	ypUl0FCUq7w1Nf8MDgpbzfdm32kmeGa6mok+vFhmSEqPGSYUz1UOBcxM9Q2kfg9t
	wGUH0t8EI5JmZouAkzriI7viaZzN2rAt6aYQhdgTeiHrWmjn+I6w==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37ry4k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 21:49:15 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 604IqT5S030432;
	Sun, 4 Jan 2026 21:49:14 GMT
Received: from sn4pr0501cu005.outbound.protection.outlook.com (mail-southcentralusazon11011052.outbound.protection.outlook.com [40.93.194.52])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjh0hss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 04 Jan 2026 21:49:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I+cw3jJa7/1TxbtfTIJTDn5J1Xrd8fTRI1uD4vi8xnzUaanr2n247b7/V2DMti0VjnwhzST1YS0EFGZONw3+OzDWySJcACRCWNTSaMdfHB7ol1X34v4GX3wtR7YtyMusnJv7AEYc3qKTEeA/inTSJDX9bTR2rAbdOVjqyjoGSOwz3cqNUVke2+vaNmlmaPo9iJW+YF2FXPoGLleZE1Tpqc+zcho4DqHg+NYFbx+oHKq1T8PwLMezNaZcVuKuQuOV3KHnoELVUggu8KGS3YkW8c1oqfEmZugbAqLtbQkp5SDvTtkD3L/Gc2LNdWYq/ZYvSWFaWOTVt+upTKE86wyqqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FGMnVlRD75m7x7fq3APuN42Jpf1yXaTHhEKUqRiRlH8=;
 b=O8ZNfVaZNvijYw6H+D0//8PRdPpkAZSUepuqKgjk1cfblN65Tn0wLAEUlR9j/51oLhg9rahsde7KFJyt9+0WW5eYFPxNdJoelWXMB3RcI/4ZxFIUZHzZ6S1eaVzw0UfEEf8zi4RaoSonzuMn1nDre7AsSF480JUh9VMpz5DQGFhQVmF1/IiL6c6Fvs9Gp0CRQ7k3biKbcgisDGLiGE/kaPLKKprQOr1pcnt3n4nuQlz0Z0s0qlXB5d+tKVmxnSPh5xSxWDJfiRUfvkM4PYDu2/WDH0Oh5T/2Nn0TIKjArYpoSHjYZC/vHKkQs7kXFsnJvS4B+wICO5S06IAT3Ypjrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FGMnVlRD75m7x7fq3APuN42Jpf1yXaTHhEKUqRiRlH8=;
 b=KFo+3Jo3zT6gWW2ku/PQ4H9JZjCpL389XjqS84Cic3SbFdqA1bhgzYOFlPVI9/0B9rYSCwI7FPJByfbVyjrKU/GqrLUeOWSgpAaxZMf+tuvvFHL7ATXhv5IOrmqyxPNHlIfRI6o6Xd2hcHIdJzoA/Sc80cOjzOYRLew3AJFUDFg=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by DM6PR10MB4283.namprd10.prod.outlook.com (2603:10b6:5:219::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Sun, 4 Jan
 2026 21:49:11 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%3]) with mapi id 15.20.9478.004; Sun, 4 Jan 2026
 21:49:11 +0000
To: Damien Le Moal <dlemoal@kernel.org>
Cc: linux-ide@vger.kernel.org, Niklas Cassel <cassel@kernel.org>,
        Igor
 Pylypiv <ipylypiv@google.com>,
        Xingui Yang <yangxingui@huawei.com>,
        John
 Garry <john.g.garry@oracle.com>
Subject: Re: [PATCH v5 0/2] Prevent non-NCQ command starvation
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <20260104082203.1212962-1-dlemoal@kernel.org> (Damien Le Moal's
	message of "Sun, 4 Jan 2026 17:22:01 +0900")
Organization: Oracle Corporation
Message-ID: <yq1fr8lt5g1.fsf@ca-mkp.ca.oracle.com>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
Date: Sun, 04 Jan 2026 16:49:09 -0500
Content-Type: text/plain
X-ClientProxiedBy: YQZPR01CA0066.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:c01:88::15) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|DM6PR10MB4283:EE_
X-MS-Office365-Filtering-Correlation-Id: 00624b9d-22f4-4731-ee15-08de4bdb1849
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?dMYA9xl6r/RrCfWRWRUtzSTIlw2AjX5fl8SGhKzdth0CbLiN7NO5llyzsO0P?=
 =?us-ascii?Q?dj4RO1ej2xUzNbz07aCTzmQGy7DovDmTou/kesg+zOHHyh1d+SN35iMF2o6v?=
 =?us-ascii?Q?rB+WEpI6V1Mwxsqz2Hqai46VqZC4ocwzqPhjrmXT72KXsKKK32aB1HtS285A?=
 =?us-ascii?Q?Cn/Qpw1h7MV0xd/tzNvF2tDB3j2lHDPEcewiAbRN+4TNKSpc2YqkqLr+BUK5?=
 =?us-ascii?Q?rVtrJZnCrmS+YXr6Wy3vZEGKKXGSNNvWn/SxO+8vRbgeknmBcHvtuAsFKlVS?=
 =?us-ascii?Q?SoQxLFl0Gu0QgJgZNHawQXcYRFUgWGStYNAsWy36UI721J3P+clVWL2sI0sS?=
 =?us-ascii?Q?zl/R5eptBGuDBeyeufkfS2lQ+JgtvzAW9BeoO+33YFqxcQEx56dx57xHksVZ?=
 =?us-ascii?Q?o/22W+SDS5AVdSGgTBIUfMFLeZh8JbHUFH61ozLz988qP3KseRwFcY5/xLX9?=
 =?us-ascii?Q?2WQuQ351MB4bcUzOLbyARpFkOx3RYIL8t5YpG12BJSqUbrA0soZLIU9LISbg?=
 =?us-ascii?Q?8Vv/EPB0tNX02bB6lbmFhyCOevSygSHSwdvDArjsIfNB3JiCzqja+S2kbBv9?=
 =?us-ascii?Q?5qZJbWCJY3v4byYU1jBynjbxpvc32RcOrO3ARG46sMQhZu5o0tP+8JCHoSHi?=
 =?us-ascii?Q?Sg4L06BwFs0ijwOdPocIkYxLX/jj8rO18ncVRb2silIY8vWrtsDk0h5zQrL7?=
 =?us-ascii?Q?h72miMEi2rC76NpcZcvkLUCGNfnokVf49J0U0fIwfb9cj/O1Lt/JyAOjiVDT?=
 =?us-ascii?Q?boYwKSo1IcbdrfOd4j4TJp7YM3/LBKbumUeXFJsOhsd/eb+0mXYuHOQUnK2f?=
 =?us-ascii?Q?lZpxxNF/9CuoWFDnveF5JPRwfTRomuH+YYBOKa9fMyEVndggIqHUdSw8978s?=
 =?us-ascii?Q?GomHjWvezqWoXt1l31zU67xuNaWe0E2ls+kju00onY7X2uODbsdGZijdkXqd?=
 =?us-ascii?Q?PnIqdp7bYCuS7LT/Kcxs7q4hrw906Ao2gzrgACEKwKNJKJo7PkOeZYJaOKpf?=
 =?us-ascii?Q?HBdt+zvRrVeOc5ea7QaRbmoAz/8l98Fkjp8MsaKSqypKjbQjdEqB455fFuwh?=
 =?us-ascii?Q?13sDnIU9MYZ7GiQbzo7ZbODs2rEJqQd/hdVdq+OFmFEjnmz4X4dMuHI0zc2z?=
 =?us-ascii?Q?h5Ae9GqZFe6PkF2ESZSsIC3B7/dKSyIbNSy1l34YmMNfBfXsHnRUrl3Z34t+?=
 =?us-ascii?Q?CvSROoZSWQi3Opa2qWvqz/pLKlkwGKIqamf9d1dVpkeq2IlFwQhgjwE2GGHj?=
 =?us-ascii?Q?osvEppypOStmOjUEq7pQENQotqPhKG7Uttnr9wQ/hdHsEg3jWAocUzIu+bC3?=
 =?us-ascii?Q?U1SsViEGHMWrqYVYYKSLPM8CxyqJQxsGOWMs2040TsImcaEA61yhMIbXTm3x?=
 =?us-ascii?Q?AD6kETjxNU2rL5CV1X+7Y4IQVAtyjjk/9yVJa1vt1HR2ng8jf1ArBSho4FrH?=
 =?us-ascii?Q?uT/mJdnf53qBeFcC66P7PCuoYJg5x2gK?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?lXNNc5je8RNqgmXFN0KyZuwoKpSaEiM22r145x3mhLJ2sHs9zrumIfl5e8r1?=
 =?us-ascii?Q?vG4KFF6eJt0ptNJLkF6W0mU05ZqqVrUCH8eJQNva9ITrZu4kbAXTsnmMG1AW?=
 =?us-ascii?Q?9q0E7f6ZongA3XI79E3O3phypM6CqZorcyGu5fUFygAqGSJv3NtJrnx5APKL?=
 =?us-ascii?Q?ELcV9Q/zUq0BKZTOEqTAdo8czm3FYOfn+OS2miPXS8uv35/zkVx5WVIk5S7A?=
 =?us-ascii?Q?87PxGfwP3UQmNem0RdSRbQrC+WVGobDzYnMe3CAzHDkz7fCbcHNV+sQMd+O0?=
 =?us-ascii?Q?+9KUq1U/98OlZQv8m6/aFItHSRDjXClQ0uKhj9zAk57g8jzl64uF4zOmzP28?=
 =?us-ascii?Q?WxG6mO0+lkmVpRaNH2zAp2V3NK9a8Yh6PXmDIdhCj/UbMCFfuSXJOuLy4/pM?=
 =?us-ascii?Q?AAgeIexM7Z1ffe2x/ctA3CHGqp75Y4VaIa5NHiK+ZhvtpFpFAFO+DA/LQpNf?=
 =?us-ascii?Q?1fu5F61aCEcOL9gc1GVAKdLeHuXkTui76iCEGP0vUYngdXInyGL6JraNJE83?=
 =?us-ascii?Q?72HilOr7E54bUaN03M1zzwmymgFYM9oh/RE4RcKeSuFD/j/a1O3W4u1FQeFg?=
 =?us-ascii?Q?lTnMGmVvJtzEHYriWFf00mewgphY/yj/gCThmPPiBuDgmipc12Zt02JeFWH2?=
 =?us-ascii?Q?3lMxRH4bPSDrAvIPvoMJFQ49yApCsJBD3m2C0mpe8dCjz6xET2WtDK+AGGyO?=
 =?us-ascii?Q?IXNSylVNbaahP1qM6bhOCgri9Ri2ZoTOaMQb3tp+SIYhYq05DZZIe8Ul6aw8?=
 =?us-ascii?Q?caAXncFQVqrVI3bQFMBkmGNxJrpGpk8IfT2PaQk1sCBwrnFvDOn28G9iIh1z?=
 =?us-ascii?Q?L3sqsRgnEKr31gjlCQH4TEEStjvm/8V7cTITYJZ7hRWl1iTdE92XYl8Dr3fl?=
 =?us-ascii?Q?CI/ToI/Pvs/qZwUoG0yWhhFehj5n42/gFuzusAbWlVJhRxxKH9Jod1TfqdoF?=
 =?us-ascii?Q?MyYUr3Idq/aTZjqKhv8kiTfbtkdw6O7vQa7RULQDOL4JORBhqfmIRCWj6o6F?=
 =?us-ascii?Q?rkZeRKRmfJifzp52tZPGjoQt5CnRhBFl2FNZbSRI43w9r8VT64jN1OgOUde2?=
 =?us-ascii?Q?m54ILtC6uKjsIl+cfEUCChzVV0Uaui4ldHa5VW4Z+8dpInsPWbVUyO4k1WDI?=
 =?us-ascii?Q?pRhJyE0G4VjlCuefLL6tXh28sn/9C+b7nkYO/X0vx8PwAvD6/lP+cNdpJb3c?=
 =?us-ascii?Q?lxLLfYQl3n0Okg6LgXxCitNrvaLBjkeydn7hIBkWLdeO9FrkWRvnA9ynuCmz?=
 =?us-ascii?Q?30fgRiGB6BDPlGFC7jTmUvljjR0GBSycrpibhd/owX5zA8sLEwnwrlP4W31m?=
 =?us-ascii?Q?BeFUajeRfVK3qn7QbgsVADZHmy3gXIPUz1CAU0L7mxth93jiugolf2Fb4o6a?=
 =?us-ascii?Q?d3Jo+aPKcTu36daWXHQNlXXLzLlXiPNEnSy7ZXRbCo+o4Bi+mfganIk6eGNr?=
 =?us-ascii?Q?Gx6PKukEzlq/2u7IqjzXckOd9oOHIpudJsTls7a7ZUrz2y1ClY/zG5cYuzhV?=
 =?us-ascii?Q?dmOKCkUiRtmWp85Hv4VGTfdfcyVhN+jFupIunrgfNEHDXJHBtDPqublrybeh?=
 =?us-ascii?Q?c9aShPaMGhciTnkp9PRIz2dRb/zjGkPOVGvlhqmmiEq97Vq+EdCcOz+a0hsA?=
 =?us-ascii?Q?SEBb5T/Mau9rMqXB0pVsQWuYQl+K3wCNLm/DWtwDnJf2LtCGEyvDT8pxkRKk?=
 =?us-ascii?Q?TmngB99o5SMcS0n/zPjWIlnm6HesCDA1TyaTvP0ATEotCpi8u5mqqju/mNKs?=
 =?us-ascii?Q?i1FBH0U1+DXYBRad5PtXJxbVgAGqH4k=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	tXCze9kngGfPSfl3yuZxUEqy5pie08FAyEjLmY16d+edzfKlvsIh2D+Bv1qLg+jgnM2GjUOMkgSSQuG7mG7NVdnJ5oq/ZN/6vF6hCwuLlIroy3PniUTf6p1Kyc94ApyPRWE1piEGDM1I8VNDBtzf4IG4p2GKWx7RXrBGpICvyRVLtxHBr+d8y0y4Nkzcr5qcGoCoAp8Cd6absVPmJ11dcEMp0sNI6bSF9q+YF7ol4x79z3xyVfnfwDFH3qNecYpO2QM3xc404frU0phID5is6oJVGmxGFTTvanjYQpSwssZiclQdO/IIsaCFg5k7mGp9+yYenFjFGTopjz6pLHX/mQIJuEEPLsBgbiXWgSpHURrg3iEwwAfOGAHDCGvdzBA4hdjEyZaB9GUMy2pWQWAB0OZ9Up3fclxV7xFWuH73E+RBt4+yTc+1C2NjAhLoU97tmUxBy/uDIodOUCoCD/iQZy02k9QE39g2nF1go7Ruv8aybqejl6vrw96MrwZvXHgHrhBXCh4v34k85XRNbfh2VlQONGKgEtvMjLcNXmuLcnisNrXs+6t15ahf05Kuqbs3uxZmtYfuMNyyEokY+r86psW4JNneTYILF7YSSVTsj68=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 00624b9d-22f4-4731-ee15-08de4bdb1849
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jan 2026 21:49:11.2149
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: st+s5h4iaF2PesMbUeqx8zt3FuxQMWwtqX+9pQRq2XGK6bIQa6UFg24vU3cjEfjCjh5QVG75cxV7BbmPZIHRuvYhUIyIZ39xpKLPv1Dpuvs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4283
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-04_06,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 suspectscore=0 mlxscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601040201
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA0MDIwMCBTYWx0ZWRfX/tG5TKL/IeF+
 QtldU9O7s+9bfs3lCOUURbyDzuXGS5pKhkr7pmTVHekvA2wYSwXfyj6zMlAZfe8YoXdy/Ma+RoE
 najOboZvy53BDFGcUzpnG8KRKKAMSYaYn3OdXwUDgV7GFuFwIHV/MS3Z8FvssXdOwPK69rP4dM+
 DCbeE6CnZdf1oo7djzBrFSyKi6W16Kncz9epJ8Mqrt/yAwehpEJ5GCnUj+nDaL+fGWngyj+xq03
 pzlJnHePAiD8ScOFVRCm8ItIWJD7RnihLQ0ANncZitMYatNQ/TbpeDcCqoL4u55HN84U0jBggh2
 rJdub97JGTwqGaG9XIYoJe1qRjqLZ5Tf7MzwI30J4cF/33J+OHfeYcfAN27PGpE7bSbyO7WnjO2
 YOIaQaTihXMEKjoo8uiHo8B79tdZOh/Fp52E0gT0IWFWVMwJQJYMAUk7dI1P2ffiVtFsnfO38J3
 9oZ7s171kJz2nDhRI/WxehmmyGphVZCqNgtFGd94=
X-Proofpoint-GUID: 6HkMlN5xxOjkzWS2fTX6AQu2mEP8oDg5
X-Proofpoint-ORIG-GUID: 6HkMlN5xxOjkzWS2fTX6AQu2mEP8oDg5
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695ae05b b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=vUbySO9Y5rIA:10
 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=K0fBC52vM2vKGTLBogMA:9 cc=ntf awl=host:12110


Damien,

> This small patch series addresses potential command starvation issues
> with non-NCQ commands issued to a device accessed through a
> multi-queue libsas HBA. In such setup, a non-NCQ command issued to a
> device may suffer long delays and even complete starvation if the
> device is under a constant workload of NCQ commands issued from
> multiple queues.

LGTM.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen
