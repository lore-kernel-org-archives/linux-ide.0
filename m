Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594D222F772
	for <linux-ide@vger.kernel.org>; Mon,  5 Jan 2026 10:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=205.220.177.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767609079; cv=fail; b=eynt9qDEmrrs/Oq5d584bxJqahT4r1Xr1p3/+sRQl+1gW8P1aYNDoAXX+8jn7OVpua4l6hM8FGHfq9e+RhrX2s1Wf4bFKM7zOgSS42D6REDvv8vzRJ7hSEo4qRk+f2H9PDkf6dTkmrH3z8lyCtgEXmqGOxSIOArm/a8109ET+tE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767609079; c=relaxed/simple;
	bh=6QIlaBCLz+y9Ue+s4F8m1eL1MFpptDHYkQ8nptRGpjE=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=sXpPSodgAz2pik9Cas2dsu3sH+3XRLx+B3FNVskFMNNcQmx5Gut0+y8e4VNV3qxZTaoIiGTBB5cZ3w9dWtje/HYcyHF5rFAa+BLLQ8RXsi2Ku6RSrcwgVuoJkzFF01DyHhbQHjJsSFoQ+9gVb+NE3j/fN/IpSUfbLO2Zzce7sFE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=caB3wXWO; dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b=dBu86Dvw; arc=fail smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="caB3wXWO";
	dkim=pass (1024-bit key) header.d=oracle.onmicrosoft.com header.i=@oracle.onmicrosoft.com header.b="dBu86Dvw"
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 60501v1Y191951;
	Mon, 5 Jan 2026 10:31:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=
	corp-2025-04-25; bh=3b6y9vabvG8+sXT36+K9qLWn9Sdb6nKKtqiflWLK+8Y=; b=
	caB3wXWOJzlVQNhcIfRBDiGxfEFfDwl/peh7b43Apk8ZN2CAXaR40RW+T3M/USFX
	TKrrR23H7J04jfRcOEeEA7Nwc86hVUluPspQJcvbdOAhPDDynT33iQHkbcd20ek9
	7Kz9YhbJw21VxcOTnw7nZd/XNhfrsRA+Bk/C7aE/jKkz4NHfafwzC6GX139jZfUx
	tSYOzopX9yjkCbKHna60pVXZYQWkKT9PlMb0365IRNn3BgF3cTgPG9lWuTwtCBSH
	b8BwvYv3iKopzy9lyl3YjCD2jYFl05E2aRTkYB83KGhLTUjhkn8lzKzwpUdCb9at
	raQ3PTJsBWXYw1sy0WxU/w==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4bev37sh8m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:31:03 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 6059UOKh030735;
	Mon, 5 Jan 2026 10:31:03 GMT
Received: from bl0pr03cu003.outbound.protection.outlook.com (mail-eastusazon11012008.outbound.protection.outlook.com [52.101.53.8])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 4besjb80r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 05 Jan 2026 10:31:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUblj61oGv0QifRWB0W7V9gK4PsJXpnzE5y8JyPtgRiH7aubb2VMUu+g/gxJ4C1QGQDKp0NkWi63fOCxGlBMK69e+cCm0fYX4tja8lBbcEmNiOUFgT6IwHK6Ge0KkAXny5UppHrT0wOwTxQPCJPTJ1iY/4DxtSssOcv1tzRZye1ayF6LNopedMYae4rpVwKFi/htTLMBguSlyJYtipOeKVS4OVrBmBZtsNrxLxlxBQuYBo/JCDW2k5tIwXOkA1iSuqrfd5lQQLhsT7MHa0i/pB62yBqjYC6VUCwPWhne6lvrnQM2l9BXfmi21r2/UukN4yM9Sf7rVQGYlBxHsQgAEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3b6y9vabvG8+sXT36+K9qLWn9Sdb6nKKtqiflWLK+8Y=;
 b=h80KaTDDFp5b6nlIOHwfuVLxYuljypyo6RRV6MiN1S6UL35ByQVEI2iX8EZq+RC2lduPd6vz4jEYNqmdq2Vdh1up/0uoYa8J1BYNvE0ZIkYw6TUWHpT5vUXlTbUT9Mp4xGc5FfGZo3g3D0XNoILNJVoWBh6iMa+mMhbke/zgtLrzXG3L9uPwCYglEjVK+i0TTIUwWdlryzKGsD+lP9mcWfTYXWiqclJDe3xiYeg3WvuUQGmyJNehBA8sYwc5UBwIIrynM19um2pTzJQ1wy1MO7ZeX4PlNAaPa4DlmcHsdREz1jZxY5D6U2T8ANIWIZrpFNxIjTHn0CDIGIOBexpeKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3b6y9vabvG8+sXT36+K9qLWn9Sdb6nKKtqiflWLK+8Y=;
 b=dBu86DvwFvBT17KApzaM9pyzJitHAPF71OhZ9bF6O02WRNr93F6vGAFTPsB4fVxPUvMvYEXJKbASFMSesbApx0ulhpKzpXxvF0YTvDzRt1W+9uRtJvtA6blUdvme6R+lx9j8zBmyFWJN6JZA3/t93rgzKgSzk1c4qxWtD9q5TbQ=
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54) by CH0PR10MB5145.namprd10.prod.outlook.com
 (2603:10b6:610:db::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 10:30:49 +0000
Received: from DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861]) by DS4PPFEAFA21C69.namprd10.prod.outlook.com
 ([fe80::ba87:9589:750c:6861%8]) with mapi id 15.20.9478.004; Mon, 5 Jan 2026
 10:30:49 +0000
Message-ID: <b7afc804-58c4-456f-b5f7-31fc2570d192@oracle.com>
Date: Mon, 5 Jan 2026 10:30:46 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/2] ata: libata-scsi: refactor ata_scsi_translate()
To: Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org,
        Niklas Cassel <cassel@kernel.org>
Cc: Igor Pylypiv <ipylypiv@google.com>, Xingui Yang <yangxingui@huawei.com>
References: <20260104082203.1212962-1-dlemoal@kernel.org>
 <20260104082203.1212962-2-dlemoal@kernel.org>
Content-Language: en-US
From: John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20260104082203.1212962-2-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0101.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a1::10) To DS4PPFEAFA21C69.namprd10.prod.outlook.com
 (2603:10b6:f:fc00::d54)
Precedence: bulk
X-Mailing-List: linux-ide@vger.kernel.org
List-Id: <linux-ide.vger.kernel.org>
List-Subscribe: <mailto:linux-ide+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-ide+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS4PPFEAFA21C69:EE_|CH0PR10MB5145:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b49aeb9-a20c-40eb-6f91-08de4c457ea9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N0EyNnNlbWo5WWpZblZJTjlBc3QvR2Q2RktJVzJDcXdmak9WdFdyMDRBUThO?=
 =?utf-8?B?dmVDRkdPeGJpSGNDeDhVd2dtWFFsOWhsSWk1b3dZa1VKSitqTDVQYTdjbHBM?=
 =?utf-8?B?KzlBTFhSeE9HL1BDb05CdExkWTBZeE9oWXdVY2VBUXZhdFkrYkZLVHBLa3k5?=
 =?utf-8?B?STJVYm9UTjdkQWZJRmNCUmpwY0N2Ymh2UWtGZTFXdS8wTWVCdGlDaFhQVmdE?=
 =?utf-8?B?NjBESkpXK05VaEJ0czdJKzcyVk5ReksvTmhRWE0wTlorZFdHQzEwUzVVTkxH?=
 =?utf-8?B?YU8xRmlsRkRPYWk2NjRlQ0o0UDRNQTk0TlVUYmtGUlZza0VhalZwVnlyWkh4?=
 =?utf-8?B?TTB3UUhUSThmdnp0VWpiSTNsZHhxbU51M2xYOFZpbG45UlpJUTlHdmp3QWx2?=
 =?utf-8?B?amdtTXZzWWV1ckpJVmtIWG9UK3F3SXdaeGthbS92dENlRW1oeDQ0ODlJb3ds?=
 =?utf-8?B?djMyQ1hMK2doRVpxdlh0OEx2MTFick1YMXFraUZxTFhNTXk4cHBEeU5yOW5Y?=
 =?utf-8?B?K0RUU2dXUmVEbU01OUF6RmRsdndMUDZBeDhpMEYxcXVrelNqaXBwZ1V0WmtP?=
 =?utf-8?B?SXJONnVBQ2FxL1pvSHU5T293R0x0V2J1YXh1Ulh5UHZQbXBoY1dUb1dLbnlo?=
 =?utf-8?B?Ry9ZaDFBdVlFTGU3dk4rZU5hemxuY1c3WGdLeC9WMEVVOFJBOS96Vm9kTHlW?=
 =?utf-8?B?cStUZ3VUZkF0QTB6Smd3alF1SG9QcXJQTEVReVk1RFI3Nmp2OFJxUWMrMXFQ?=
 =?utf-8?B?R3p4Sk8xUy9malNPZUl5ZExQN0YvSDRDdE5KYTVpYTNpcVM1YXRKRTEwOG81?=
 =?utf-8?B?OXhhRUkvS3FTd25ITlBGa1NmcjgzUzNQUzhpditqZkRHdGNFR3B2SlM4Q2Rl?=
 =?utf-8?B?eE0waEVYeklpYU5jUkN0d2l0VXlvTi8rZG1mdFcxNmNLRkRoOHVneFE5WFpj?=
 =?utf-8?B?eUZWSGd2Z252c1NINTlKRWFRbmNFTXFoa1YvdStmOFB2MzU1bXpFR0pZS0t2?=
 =?utf-8?B?Q2R0YWpqNGNVV0JtZkRZS2pnUFNlZlV4WG1yMmRoK0dJUVlIYlVhT3RpdUZC?=
 =?utf-8?B?dGg0QTNnRjFIYUVaTlVZZExGbkdvWk94ekF4YjJBUy9XeVlGeXZWTUtxYUdu?=
 =?utf-8?B?eVB3VVQrVGtscVBZY0FtRjlDSG1FL2RZOWE5Y3hzeFo5dGNiRm1ZNERlcXF3?=
 =?utf-8?B?dnFtdEhldHRSQnl1c2Z4VkNQcm1hZG1KYk1wV3loOUtnaVpUMUNPMFhjYkt3?=
 =?utf-8?B?ank5bmN5YnZxd1E1dmd5L0hOVERES1FkNHM4N2VXVytWYS9lV3hTUW9DTWJa?=
 =?utf-8?B?VDZNdkk5bGQ0U2ZnTVJtU3ZYVWw0NFlWM0dGTkQvNVR1SjdYenBQOUszZXd0?=
 =?utf-8?B?R2xLbGVtN3l2dU5jZDk4Z1ZxRmVYVnhXV1V6bk9OdzU3ZklKUUtUZyt0WFVF?=
 =?utf-8?B?dm9SNVo5K0N2OXFCM1FPWlE5SmlPS09xcG5FYUxUMFBmcnIxd3RnSDFmVVhJ?=
 =?utf-8?B?ZS9KMnMrcVBkZ3IwbEFTK1AydVJKcEdnWWM5MDNkNk9VWGVpc0ZNVTlaSmJz?=
 =?utf-8?B?OGE0QnYvSVhNTDNaV1hwRkVHV0ZyM0VzOE5ZUDZaRkJRUUxmdjFmWDVxckVo?=
 =?utf-8?B?OGZoQmxRejQ5N2I1OW96cXBEZ2grSFlFdWZzSjdPZWtrOVdScy90NWdHakpz?=
 =?utf-8?B?Z3dMS3ZLT0FmVnR6SExMUnJQVW1pMVhEMDl2YXVBbHI4M3JKVnVHVmZzc09G?=
 =?utf-8?B?ejlIeXZVSDlZVUVYY3VDYUJVaHlxc29MckNHc0NqOVlGbDMxZGtMV2wzUEtp?=
 =?utf-8?B?a08yVEJTNUx5OGw5SHpVb3MxRjhmTkVVTnAzNXJONjVYTko0RWVSV1c1cFJ3?=
 =?utf-8?B?UFdyZ1dKMEtRbUMya3ZVL0FlaWxjY1QrYnZRc2svUUprYkxKS2tzbW1vN0pa?=
 =?utf-8?Q?XzX/+LYFkYhilA/GKcTwDxWkqaDKQtDd?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS4PPFEAFA21C69.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGo5WXRMUFBZaFVwR3dsN3JGTnVmNmlLQnYzSVVrd1dHa1lqK25JdG95eGF3?=
 =?utf-8?B?WTdwYmt4RmpPQWtDVVdoZ1Z3SWdtNHM1RDBRZElwQXluZlRzU0dMVG9MZmdR?=
 =?utf-8?B?cEN3VDVmdm9uTEFJVjZpcFduL091YVNpL0hwbzF5M0gvcFRwQmd4WW82V1gr?=
 =?utf-8?B?TjNjam9QN2ovWnFkOG95WDVPRG81NmRsY0VJaFY4QllPT2p4QkVnZGxhZndI?=
 =?utf-8?B?cE1rZnRNanFHMVpWTDk5eFUwTlhLOVNNa3lsTVJBZ3BSUVNuVC95VUhlSEEx?=
 =?utf-8?B?VWx6bmF4b0RDbWNsSDhsR0ZML2l3bkFkSVViOGpKVXpWdVBjc216cGtJM1g5?=
 =?utf-8?B?akxNUE8zeklFSlo4enJhT21rZ2xBd3JJOFMrd3BlM0RXNWkwdGRmTmlQTm1k?=
 =?utf-8?B?NW9rU2lCNmdQdzJSWFRESUZRenNXNXhSNFc3SXNZZFh4MkVOTXhsdklwTjdJ?=
 =?utf-8?B?bTZvcGwyRzZ5K1ZJZ0JrUFpFY2dEUlpvQ2Q1ZXpYaEloT2tORmhjL2NzWTFj?=
 =?utf-8?B?Y3Y4eWdSYWRyRm9jcVNRMWwxcWxKbFpNdHRybDJzb1RIUkExUDJYejFsUUww?=
 =?utf-8?B?d1o2QXRjdG1McGRPbEMwczk2SUVzL3V3eXp4SEJvZFVTdGhYV2ZYdW9WUyt3?=
 =?utf-8?B?Y3JUcm12S1ZkakZEc2RNNVRpSWdxc0JTcWxRSHlhcEFuM0VMcUpMYnJ0cUhY?=
 =?utf-8?B?K3lOVkZzN1FhWGxUa2NXekhzMmJiZk1HejdOYTFwZU56MFRubGp4UUpjMWVq?=
 =?utf-8?B?NFFZS2xIK1VFZmtEdGJkcElXSjgxQUFjNWhBczNUcGlHdUNLd1M3bjZMaXhl?=
 =?utf-8?B?MVl1bVpFVWtXSlp3VnEzdjUxSVliakcyTHVlWHJlc2lPaS9mRzR1OXlVMkNr?=
 =?utf-8?B?YmwxNlZkVnlVZEdvOURkNm1EbmVqZUovZzhwYWs1NFRkWjhUMnc0UStSYWp0?=
 =?utf-8?B?dVJQeUs3YnR6ZmNQOGtyVGRFbXNqQ2poQnk5V2xTbGx0bVJSMHFqc05QR3Zn?=
 =?utf-8?B?NDNrRkF5K0crUjJuRFFoVDM1NTVuVWNHMTZETmhCSjR1bHN0NWZVNGdZdTlI?=
 =?utf-8?B?cXArNHZXK0NxVzcvY1pvVzB5eVQrTllvRGdjc3BOblNnVEFOLzFsaGdoSkc4?=
 =?utf-8?B?RGQvL1NsS3lmRVMvU05kWXBxVUhnUHd5bU9LMk1ra21YN0xoNXp3Q0E1OFht?=
 =?utf-8?B?Qm1sbFlTNUMzb29ZYW42SDhPYk0ySDlKbkYyWDdyUFE1THcyS2t5eFlKOVVS?=
 =?utf-8?B?VTB0bHk0ZDYzelFQM1pyb2dSMmZCbGdJaTF6VUpmSmZxNlVLUGtVSFA2MHNJ?=
 =?utf-8?B?aFdLYnV6cng5NjdKOEVTRE1XUURiZTVqdzQ2QXk5aGZMTENjVGk2VGNVZk9o?=
 =?utf-8?B?Y0QydjRPVHo1QjN6elpPeFF3QlJMQlF6SW1kcll5WmdCTDZ3TGtZcFFLY2RI?=
 =?utf-8?B?elUrRndOdm5mMmdRb0trUXlTVnVhM2x4TktsbkczeDd2K0IvSjEyRmFBMU8z?=
 =?utf-8?B?L1Z3dllYUHBuRVdxeStCNExsZ1AyMEUyaEJ4bzlyRDl6elhjTWtTZTBkUDJq?=
 =?utf-8?B?dHpoV3ZxYlM0cnZKZ243Vk9rQm1ma2ljSkJ5Y0Q3aTlVdk5YWjVwbUtyYkN2?=
 =?utf-8?B?aUFkS24zTlR5clpMblpMYUQ4RDc3OVlobXFUUjF3WXBXMWFHeFhCMEJrVGFo?=
 =?utf-8?B?bndLVE9ENzRnYi9kMGFVNWJiWDhUMnU5VkdrYUU2TkRXTitzeWF3WCtPZkpW?=
 =?utf-8?B?bkwxQ3E4M05KZms5TGRDbUwyU2V0cVFWUmJ2alU1a2UvUkhmQXo5QUVwdm0y?=
 =?utf-8?B?RkNPaUZURlR2NW9sMFNvTi9KK1VJUEhVSi9sbVhrNTg5SmViMS9vVjAvK0Fm?=
 =?utf-8?B?aEpINXBwRmczdWRCTDFwcFUyekpsNGZOR3FCWmc3aHJtc2xwMTVSb1FTNGFI?=
 =?utf-8?B?MDBUMHBaVHJCVVFVYS91bHlUd1RCNDc0U0FWYi8wbkw4bHVuU0w5WWxJR0dQ?=
 =?utf-8?B?a2ROTWFkQWJyZnBEVmNwQjhJczJ2TTNnTWMxOENWM2c2SjhtdGMxN3l6dFJw?=
 =?utf-8?B?VXcxTG94d21NandiYVU1OVlIRUlMcSs0NWFBYmxTbVNEOTRGLzdxQzVnNWZW?=
 =?utf-8?B?Y2xST0xQZWp2MmZPZ1FRemVzdnJlellwbVVtVzBlUG4yVUxubmhubmIxR3Ax?=
 =?utf-8?B?QXYwWVcwNjQ0Z1VocmdaMjRCZ2UvQklJS1BwbHFNNnlKOU1ERm13bVBrZDE4?=
 =?utf-8?B?OFFSdHRkcXJCaWhieXZHSEl4SjFJb1hITDlLQTNyeWhzTkFvU1NER01vdVZX?=
 =?utf-8?B?dXJIeGtHWWc5MkdjV01tMk9CRlgvWGxlUjlOeWI1SDhRZEFST2MvR1Q3UTZ3?=
 =?utf-8?Q?ay6vXavvrzKOx7iQ=3D?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0:
	6vPBbVVsv+EBrMYsEUCuGmz+dSud8pIKDHy02TIMAi31bzZfc1XLLZK3hAePvO828m2achpcLwUbxapK7dBfNAh0IRXzU5h6zmwdTMVHD0hxFkrCafrLwRbN2hr3P4a+aqkTlaC5jevRFyk/d71L/tiS8ddbp4Q1w5+XG+jZB14mHa1i3yflhXSmqYzCs1UoFUbnZWmG4+iRA7prmp9ZSKAwot6L7EYZU2HYU5vtfiX///BWYjDs7fuY0Tu5seO+Fhqg4j91vOrxfW3oCkZne5j12vhlh9d1uU4ckJRdv7wZW2ZTOLdrIEuwAQCyMI5Wo+jZs5vc72QqjUUlpj+GfeSb4w7OAK7OtnMhwHHfd+eLsmXObHaRc/IPKoGzOp26Xs2geMygI3HL0tO/2jiNjkp7KBIqfhLuItancmoS1PF35Ujc/jBTPzLEf98mWNBA4jtALl9ji3O9rb19xKxQq45sVTCbemJUxZ6OdF5ynsVTlzDSiKQcLdE0OHmjKyP2zZwmAKOVkEUxixf6qIq6/MS1lGBBaZrrZHhG6pUUcup+4w0v/3q+5O64inGu0eh5VOAFqrsxg8gEnPH2A4oBYGvTi7Q5ZYxyVV7Vb82x81E=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b49aeb9-a20c-40eb-6f91-08de4c457ea9
X-MS-Exchange-CrossTenant-AuthSource: DS4PPFEAFA21C69.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 10:30:49.7124
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XpbyfEhpdM3d9TomnHX0hbC1O1yvPYplOZ8wEVq7F/CoaelREeg5DgiV9dH7Uo0+Gakj1P2LPunIP3q9e+1ArQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5145
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-05_01,2025-12-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 adultscore=0
 malwarescore=0 suspectscore=0 mlxscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2512120000
 definitions=main-2601050092
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTA1MDA5MyBTYWx0ZWRfX0Pr6K5epKM5D
 F7mdG9jtUR66gq8KOwOEi84CBiO6pMrcDtAjciLnlHaBkAReotLsiAX87NuD9iP3jCstIpUC5hi
 mLWuYYyTZ+a3zUzNIn87lPYEFQ2QpLWnqHYEb84xbQ6JLtjDSoWJidIN1iYEnHUjympl4XAM4Q+
 PclLpr3BY3owHXMU4QJYVxoj1vDg4iTDtuGfg0gF9500DRz5qdIJ0w8OHfirWm5ffEtzEen6HBk
 6PooYWAhPiAOdKBvQn8QydEfGmaZIkmpqvWDSx1zYqclE0+MMIF4zwxDYOX4pF+9qr6pXa0n+v/
 K+mrG3WWT6FLeVEwm24ga70udr2fNS35nGsEjW8zFuXeJc2AV0iYX8+0EMNiwMNSjumk9BL5vLu
 dKRHK7lrwgtZFlqHnapruVtC28Agt7KJOdbrI6vNu61NoxQfm+N+6R+179Rmln5UKFUlFxlpRd3
 zl4VqbN6OL4N0QXXv2CcBenYykmtsIrCESx4Eqj4=
X-Proofpoint-GUID: gIHAAMJdK3MXkY5C-L64IYD-QrSCqzPs
X-Proofpoint-ORIG-GUID: gIHAAMJdK3MXkY5C-L64IYD-QrSCqzPs
X-Authority-Analysis: v=2.4 cv=F89at6hN c=1 sm=1 tr=0 ts=695b92e7 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=6eWqkTHjU83fiwn7nKZWdM+Sl24=:19 a=z/mQ4Ysz8XfWz/Q5cLBRGdckG28=:19
 a=lCpzRmAYbLLaTzLvsPZ7Mbvzbb8=:19 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=vUbySO9Y5rIA:10 a=GoEa3M9JfhUA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=9AwXcRW6VGd-RbYZ0UYA:9 a=QEXdDO2ut3YA:10
 cc=ntf awl=host:13654

On 04/01/2026 08:22, Damien Le Moal wrote:
> Factor out of ata_scsi_translate() the code handling queued command
> deferral using the port qc_defer callback and inssuing the queued
> command with ata_qc_issue() into the new function ata_scsi_qc_issue(),
> and simplify the goto used in ata_scsi_translate().
> While at it, also add a lockdep annotation to check that the port lock
> is held when ata_scsi_translate() is called.
> 
> No functional changes.
> 
> Cc:stable@vger.kernel.org
> Signed-off-by: Damien Le Moal<dlemoal@kernel.org>

Reviewed-by: John Garry <john.g.garry@oracle.com>

> ---
>   drivers/ata/libata-scsi.c | 81 ++++++++++++++++++++++++---------------
>   1 file changed, 50 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 721d3f270c8e..5b6b5f1ff3c7 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -1691,6 +1691,42 @@ static void ata_scsi_qc_complete(struct ata_queued_cmd *qc)
>   	ata_qc_done(qc);
>   }
>   
> +static int ata_scsi_qc_issue(struct ata_port *ap, struct ata_queued_cmd *qc)
> +{
> +	int ret;
> +
> +	if (!ap->ops->qc_defer)
> +		goto issue;
> +
> +	/* Check if the command needs to be deferred. */

nit: I am not sure if there is much value in this comment

> +	ret = ap->ops->qc_defer(qc);
> +	switch (ret) {
> +	case 0:
> +		break;

