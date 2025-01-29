Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5BCA166F1A
	for <linux-ide@vger.kernel.org>; Wed, 29 Jan 2025 03:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738120197; cv=fail; b=FY3UZiFGu825aO+d0SmJOSnvU3hr68f+PIqukO8hwGHZQ56MENY7S45Nt6T+bM+rF0XWXshdwlubUjG55NsqGApriISYSdcwmsrBW50MJs3DI/4dJIiII9OYMRVTnhSo5Q5iWoefcM94OQ8+vM3f4bqnoGv9DW/vltrk139bKEM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738120197; c=relaxed/simple;
	bh=QS4wqTi3JOXo8yeG3ZYOl6JpQvTFWYgTtCb5Aq1HlQg=;
	h=To:Cc:Subject:From:In-Reply-To:Message-ID:References:Date:
	 Content-Type:MIME-Version; b=uoJ39EqYRgCEhnC4KBx04fQ9Q5goQdERMgXY/FwLYku/bIcasOwCIRiYQf9dEylr5t/4r9RT4KjznboLzlLEdTQFd+4yeVbjx7hak+8fjODLgiwD2mx8JSwEaLs31owDuKd92tP6Td2sQu9CzaoZROSQvDZOaZPLoXF87I2jS74=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=jWHo1mfC; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=XlChx9Uz; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="jWHo1mfC";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="XlChx9Uz"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2lmHX030306;
	Wed, 29 Jan 2025 03:09:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=corp-2023-11-20; bh=LCqWtdabKrfySbqBqV
	Hcnn3J0BI6JtK9v2y08VeS7jk=; b=jWHo1mfCZGpiztNDyAUAG2wnXbts6D0nHw
	1Mwqxe59FGicI2oCy+qph78rDDDlW85y9LcWLQn8jXUPjqXr4PqipFupIBl9kD8B
	h+M3Yx0QA+3rsP2E0OQOxR7QeFQ4I+rFBEDo2TaZ7HuhglpfLNQ22Zo4gwp4cjQJ
	h97vG8/kJXElG7wG5uTKGoNaLFvI0C9GfUXNGri2bEprdovyUyKVoxzDAlJ0s3g7
	FpdkZm7PK0dpra9DytYpqEOvreF4kOWd8IpEp/pfjMfT6IXWDCyd3NYX9vFaZVWb
	zJaaBt/EDCjBmqZYD8ScT2A3/hN4ffOG3d8nDO08UznFRalqmlxw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 44fbuh00j7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 03:09:42 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 50T2ElqI035860;
	Wed, 29 Jan 2025 03:09:41 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam04lp2043.outbound.protection.outlook.com [104.47.73.43])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 44cpdf74x7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 03:09:41 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HfQAY+ugWqtbFV0/pka0qi1IrPckaqtRjwSzSjI8Z3VSynyrVa75fPYnTSGy5PFU+J+lRZTIpNsEXbTsoNWYUhSp3jIfyZsHlMgI5puTzmE24y2t8N6HtWSfqIG2uQhYE0VCb0srHTBCjzNDuf912MOSlQNx8D3rDBgFnXWsc1awB6MPOGTtdL8zElo+Fu4Jdp8g8eYb/22Y5vhDGVTXa87MQciWq4n4cK5RXLM2inyiGd3ReVY6V9MnRhoRcLgwPyKJn1K0eZ/ItCnKDHNvzJaxKE+13kT08iVbsBbgGIo7qGvRPmebWy4KSk54qy6003+ypEP+tUiW+1MOWB/rkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LCqWtdabKrfySbqBqVHcnn3J0BI6JtK9v2y08VeS7jk=;
 b=xyTBSOGHytVLT8Gmgla7cnZaadBpyI5wXnTnuU+dWu0Zwu1ZRemFmStKi2v/XXDse5TZPTRgiSrAp/DmiJ1dn8YuKJbG0SPXv9s5MUFRCVhEmhJDo5bCKKr/qxi5021mKw4ccM97y1LPESURhoMeyeqbFh0CXRPbvfiSk8OpjbctASutvCC3N3CA9+a/8HNejzSP7Aeq44nf8OTWJMhR745OMaa6ulh8MzrAe6Bs1WK9EOZs/tkbniG/T8nTGAaR6NNE54U3dLknh/DHqPOU51Q+1fodb7s5MM+IP9J6WBjiqI6TVYQge4kKS/HNwjiNz7TMfK+58QUwXb0xevVQTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LCqWtdabKrfySbqBqVHcnn3J0BI6JtK9v2y08VeS7jk=;
 b=XlChx9Uzq9C8aivZSBYknIEyzPybnbJ8px1JMCjBvouFXZl+R7Q4Ymg81JNutVtoPLiTVylFSlo8O2XNq0PGc+lrfrz2wmsY2gyAfxWEGTyTfth9MuRO8aMkNn5xTvErQuk+R825sx2d41X3Awov0OizsbktRv7rbzVcp9Q1RyA=
Received: from CH0PR10MB5338.namprd10.prod.outlook.com (2603:10b6:610:cb::8)
 by CH3PR10MB6884.namprd10.prod.outlook.com (2603:10b6:610:145::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.22; Wed, 29 Jan
 2025 03:09:39 +0000
Received: from CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf]) by CH0PR10MB5338.namprd10.prod.outlook.com
 ([fe80::5cca:2bcc:cedb:d9bf%4]) with mapi id 15.20.8398.017; Wed, 29 Jan 2025
 03:09:38 +0000
To: Niklas Cassel <cassel@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        "Martin
 K. Petersen" <martin.petersen@oracle.com>,
        Damien Le Moal
 <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        reveliofuzzing
 <reveliofuzzing@gmail.com>
Subject: Re: out-of-bounds write in the function ata_pio_sector
From: "Martin K. Petersen" <martin.petersen@oracle.com>
In-Reply-To: <Z5EHwRtTL1Oy6T8_@ryzen> (Niklas Cassel's message of "Wed, 22 Jan
	2025 15:59:13 +0100")
Organization: Oracle Corporation
Message-ID: <yq1wmees4lw.fsf@ca-mkp.ca.oracle.com>
References: <CA+-ZZ_jTgxh3bS7m+KX07_EWckSnW3N2adX3KV63y4g7M4CZ2A@mail.gmail.com>
	<Z5EHwRtTL1Oy6T8_@ryzen>
Date: Tue, 28 Jan 2025 22:09:35 -0500
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0349.namprd03.prod.outlook.com
 (2603:10b6:a03:39c::24) To CH0PR10MB5338.namprd10.prod.outlook.com
 (2603:10b6:610:cb::8)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR10MB5338:EE_|CH3PR10MB6884:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a3cc292-2d53-4296-c301-08dd40125d64
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0Wa94B/2e4rVaQCYHzGIXqxGXm/QdTIwgF2O/eIWj6i6nfM/4gZ7dYOJl4pS?=
 =?us-ascii?Q?ahAgYwkgnO0ixpsgo7pKEXTI8jGgeSpUh1k1CCaFV6Nmhd45/OxR0lZMQaA5?=
 =?us-ascii?Q?D4RBtl0x6MXA1oEs2LbmPZg1wbNq78kj4auusBiwVYL5ZLNcKJJHthHfqM2l?=
 =?us-ascii?Q?+C6hm4ZIeElAQ8D/hasPr18RSnI4cfiF8AQUWRfZkwys29bHBOKVqmVtjT79?=
 =?us-ascii?Q?tHVQjjCi3xNX7ryTvfsWtqiOiLuPmhSwJxmxVwY19mQwVtb8xv6IXGIX4B5g?=
 =?us-ascii?Q?223vd6MFCOWigO5r6nH4LhvWo61JzBHlR4y9Xpp6jsLR55b9lkXX1EIy8Hre?=
 =?us-ascii?Q?4Oqm6cvyFZDsfqj0o2Uvh6LfjUFEKX33fpI+lXY+E4BcA5dKLj+WfBvMNbEF?=
 =?us-ascii?Q?/xKe1ioWZpID2/FfSdeSW2vt4uNLh51A1z/TKlgxFiYDJGKFUEr9NwmMYyX1?=
 =?us-ascii?Q?/YObtSVp/jQnkp8ddGDwHF0V/E1KMadQl8Db2v4Tc8rRCq+kMF+/IJ1YbItM?=
 =?us-ascii?Q?1U8HRJD30sbBKAZb7KYy9sIE4GvFHzqT/AVekdFOdAG3oehJwC8UOF7BPiEl?=
 =?us-ascii?Q?tSW33Kb3BqKTg65fPF1qekAAUMqqUTCo25jQWNfjGk/IdpemOv1qa3kCAGLt?=
 =?us-ascii?Q?ZPOdlO5lmqs0om1P/Ev5J/84PMqJCEll2UTQWK7hFQMCw9vgBlJ8QDms/WGQ?=
 =?us-ascii?Q?/L6mp1RZ8Gz+k4eICeUlD5TOaFMWbIDC7yXtS6kXARvTbSAoojJjGZdBB0Ko?=
 =?us-ascii?Q?hdU6G8NSBQp7OkzPQIqiKuw7/tDyEC0FSn+X8rNAHdiCDzEccH8H4uK+4qBD?=
 =?us-ascii?Q?DdzuLamO8iU7TSjFs+T/MLc/irsknMnpvAJFn/1xYPcqEeDwkNCNlOqL2JZN?=
 =?us-ascii?Q?7YWWU5TaWu8fY+mfaK2YNxqAZvTXvWPMjQAStx1kv0aEyidfmGbDqHtQ4zQT?=
 =?us-ascii?Q?94PiUME6tIUo5ZANM+gXgELfvSPZhxFZoUjuuFdiJhpS+ol5RuswkX19JWk2?=
 =?us-ascii?Q?1dUpnUKwG1cpIdpjpu54D4PnppxzsYWGwCZ52YvL5Ypx/pQeBtSuKAbIL8MZ?=
 =?us-ascii?Q?ZXVUyyF7SdqJaemqCGLqgg3oAkZovL533Egd3oFIigu0tyx9PGVDG0hjKkeb?=
 =?us-ascii?Q?/cCLJDFJpvVfN8fV3lnImM4b3jxwYcLso9u5DcufGAmkNSUpmosaUiLx0wRe?=
 =?us-ascii?Q?fmtMDsdq1++Ygz90T5QJscfjq5Z7/jzXTMY38P/Rj6fehyNeXe5Le3TisEbt?=
 =?us-ascii?Q?N+LE27zdLcjXIdEdkUU5csQUBkjIDxfGYmdtGeGeNc4QlW/zWxgNdWHMgnp8?=
 =?us-ascii?Q?clVpnJYYiVBMlrzQdMC/vq+8wblw6F9DTdMvUcHH4AMJuxVb+GUSwiveFgxW?=
 =?us-ascii?Q?2XX5RwlK5mF2BptrkTOCuks22i6f?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR10MB5338.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ZCyxV4eDhFNg+2c2nCNdMYEIM+XU+sdspKzo7U0bqKUAo75AXhnDqDN1CLbt?=
 =?us-ascii?Q?xQ+ZxtpivDi2/PlpmXBmRza/Zmf0lu2hGrYVjqDlsuBWbmFJ3N8RDrch4f+7?=
 =?us-ascii?Q?oW5mfoyRmDBe6htiwk0kYvVUQ7puQKzocrhxCc3MFAxm/0l/QvujTFT6F0gK?=
 =?us-ascii?Q?1294y1FW4rlng5wKDacbRoFjdE4d09OJGglJeUKBm4FtkPjswUJOjQk58IUp?=
 =?us-ascii?Q?wW0tn0b+0m9qM4JhQsm4DQ8IH23WIxXD622xXeVduGaiwz40VNtyttAMvrCy?=
 =?us-ascii?Q?yqzLIt2lRI5hhynsPPghCqybh/5O97Ihu6m+l5Y9T5phEu8dD7FTmD1PUU9Z?=
 =?us-ascii?Q?PInXsGartkpreUhHHeUjiaQJFfOLR8lvh7iZVkLAcSQJhmElHjQoISusMHGN?=
 =?us-ascii?Q?G92T3I1kh12hKoDyD4eDtlS2qKqRMw7Zmsu6IaIlga3mjGXvzSsYz3uYeEXm?=
 =?us-ascii?Q?4WGgqtEi6H8romKlMb4CdW2Jy1ZY5VvykeU2hOSDaeQEDb/EPA1iPMK3ooWD?=
 =?us-ascii?Q?Yj47/5PQpzglTF8OYBJyrJhSCpiybPNpe+yVVYgpssZY9WPz3kfMJe6Foli7?=
 =?us-ascii?Q?vC402D3RfvqYfMAHSnlvpTpP5DindUopU72nRfRsRdo9uNZl5PJ0a6Rl/7BL?=
 =?us-ascii?Q?etjKOcI5iEy9RzjfaMIvTMgdoQcjsiXXN1HYidzfBRFmIKX3T/g0ZxoSWOx8?=
 =?us-ascii?Q?wKlUA9vaW2ruZ3hQoWLMgKadjjMT9CXgZaytBV/SyMqBE57TLouqDYWjji9q?=
 =?us-ascii?Q?ms5sGuN4w6Uxf5pxz6vTn8/bbHcMgyWMLLOmOtc138kI9kGD6WL5ecjtTu1S?=
 =?us-ascii?Q?Ph0FpULD+PqlyEEN6Ahh0zRRjqcR0g8hHFR+zggziPk433eq71qymd0wiQgu?=
 =?us-ascii?Q?5Yf09OQkkYTsqfbjm6vqLhCDSX1VxRdCA8LtuBic+lNvxKJfbW7FhPsPlFcW?=
 =?us-ascii?Q?nAihlW238FyesEJCYf/dtVmTwGVd88sn9R24abX1MGIwTdv6dzU709Gjcqi+?=
 =?us-ascii?Q?TJm/xaYgfBli62fprQqMevGq1Erz+HqmrbtPunfzROsxlz+PVTRzZx/E2aoY?=
 =?us-ascii?Q?t9mngnihbJjqodXDcD2ddIw6MPB5vks0QNY2RoxG3K2L4dFaiHyU5ktQpJfu?=
 =?us-ascii?Q?226ECwNEaon8Y74x21V/9fmfbVqlFnrIZ/WD3jq+5WVJO8yYWwV3XaIvYjGS?=
 =?us-ascii?Q?k2LchkUK3DkpjWDKHzYp1cWuP8llqpy236j2bjcuBUt3eG8qlMjG9J9U1lwi?=
 =?us-ascii?Q?9ECNK2mD3TuslZD2+oJjNwR/n1ZpFKFa5YW3vEh99it+AMrgpgUyVsOc0K/b?=
 =?us-ascii?Q?ig1QW44jcIcPV8wP5XB3XsUjEgOzXRHRcSHEhPpa/iCQNUp/NSYKpjlWRxZh?=
 =?us-ascii?Q?hmI8ZNGB7jr+q0Yfy2a7QHH9M+vcJtGjJGZ+/0v3qPhByKISPetw//Zi9CsO?=
 =?us-ascii?Q?cGTnq3QdxNoqtsn3OLZy4Lox5luke91HTvSwQ5H0wFouKylevvp2Qn9UxvaI?=
 =?us-ascii?Q?O0fRym3muYNGiBTCjmi4V61z2sK4klvdjoEAd9CDD42sq/Y31lmKuBv6s6nu?=
 =?us-ascii?Q?mspuOKfyWusJhJjm4BgE+hmRG4100DOwl+E3NFjIsuhyJIQO5tlqs9M0F+GZ?=
 =?us-ascii?Q?rQ=3D=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	SHpUjl2CIxFEcmajIzqI7wUauw/p1eJRVK0z6T2631nVw+q6+n5g+8fT07JBmmHIgYySLkDes7KyNmp2M1IKZIo7XhnP0Abw/KucSNYgaY3rh2T9IKxDKqB+e1EkFOeiXLiMH6omD0/woPJs3YAxBWrgo4aBQ6QGgKoVuKpgoDKxLkbhuFONcQwSFEp1IL00eMumksBRyK9SE5eUU0WBUB72JaBFmvnjT6fFI1MHZxe8XFjH+mgtaoTS1kBUTIFW6lam/vtDES4S+6Lxm54ZpKW5zPu2N6xZQ00ht8gKojsULJb8pwqvLAMlsL6tc0oR6vQcQombbqYf9jEbQhMctaOTV2tvH70bNx+CCoQ4ngoQ2YxXZJ9WLSfxmP1FUll9bdRy9KpWC1GZEacTj6hnv34cjAGMgCNbtBcgIKbC6DY/Mixeaj5D5+oLdWktsoQHE4xhnJOOvsUIs/ILDOyb3uyiv+qJs5ooepVgSDBPL4WMv7XOifCh1Pkw4GSsUHJwfYY88d1gzRrEddOJ45kH0Ze7dSPADb2vetQekDBAfeXT6klZuUSLLNKtXp2BI5qhpnWBRhdF5dwPXvXJl0q1I1OgOG+gGaqz5Zke6403rdo=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a3cc292-2d53-4296-c301-08dd40125d64
X-MS-Exchange-CrossTenant-AuthSource: CH0PR10MB5338.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2025 03:09:38.0091
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Y/kEYpN3MQrL7826eKC3yeDdYGKsTM3b/K2KDXxphdiI2siUYuqixAyKvZYIpGr1W8NoivYCkym10hjxfdu+nmHyN3QFDKiIZeTcbI3WwYc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR10MB6884
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxscore=0 bulkscore=0
 phishscore=0 suspectscore=0 adultscore=0 spamscore=0 mlxlogscore=805
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2411120000
 definitions=main-2501290024
X-Proofpoint-GUID: 02v9tu1iElOwik7PNZ9-qvJqsLk46lyR
X-Proofpoint-ORIG-GUID: 02v9tu1iElOwik7PNZ9-qvJqsLk46lyR


Niklas,

Sorry about the delay, was out for a few days.

> I was kind of expecting some upper layer, SCSI or block, to have rejected
> an operation that is not a multiple of the sector size.
>
> Is that a silly assumption?

Not all SCSI commands operate on logical blocks. Plus even if they do
the actual data transfer could still be larger than one block due to PI
or long writes.

That's all a bit theoretical in the context of the archaic
sg_scsi_ioctl() call since that only takes a single page and has little
practical use. But in general we can't assume that everything is a
multiple of 512 bytes.

Your fix looks OK to me.

-- 
Martin K. Petersen	Oracle Linux Engineering
