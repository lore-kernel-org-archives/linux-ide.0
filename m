Return-Path: <linux-ide-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0D42C7EE26
	for <linux-ide@archiver.kernel.org>; Mon, 22 May 2023 11:48:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233416AbjEVLss (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 May 2023 07:48:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233413AbjEVLsq (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 May 2023 07:48:46 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CF69B
        for <linux-ide@vger.kernel.org>; Mon, 22 May 2023 04:48:45 -0700 (PDT)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34M8E6co020147;
        Mon, 22 May 2023 11:48:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=corp-2023-03-30;
 bh=2emCS4sgnqvuq1UhBCvFMh0d6b3ibl/VCx8nUhqTJwk=;
 b=CKC5LuoaOSnMoEYzmnJ1P/Gre8vDGRjWWLHMyhsNOsBdJOC7T6CKkMT5m2T8Y20o6fWJ
 b2+4PFHjWZofnvMLWT5Sj00jiDsZmHUjjLA6G4kphMlcnHEJ7O4nkLGJfiQ6aSO/q+uy
 6bmTlS3UbJdmmB6kosMD4I1h5GqE8UQLQVSZjpZUxtAKwdnMcRvO90dKFola8djDI7hL
 0p0pTlWemRu2/G7Gtg6fAFRarVR8P9RYr02nQA7KWkwAmF0nE7zWfxl9bHkWVmCp/j0+
 pkHAeDRq4WB8Uq/N6rY/6iBw5vUNAZf0hFuvsqFDilgHl/FnzepytBPaVHXIJXc6H4EB GA== 
Received: from iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta01.appoci.oracle.com [130.35.100.223])
        by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 3qpp7yth37-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 11:48:34 +0000
Received: from pps.filterd (iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (8.17.1.19/8.17.1.19) with ESMTP id 34MANvEq023789;
        Mon, 22 May 2023 11:48:34 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2102.outbound.protection.outlook.com [104.47.55.102])
        by iadpaimrmta01.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 3qqk8sud44-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 May 2023 11:48:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hukE96vtRz5esGpIcMpr9dtGF8N9z0L0ZUCsyKCaIyX01oRHFvX2syBlamU9gz6D4MmaMrXN6PaANQAB5nhFgVS3ts0tkj3/fvSiDTBqzfeYL2/6ye/GFV+brXPRpjGR/EbTPtvE9pdBw2m8PqTB7aZtdeWuH73DDm8RgYMO8fKvvHkekGrig0tEa/80FFdlXGGUGDJehTSL0rkULY41DpjMe6UE5BDKHz82XbyuSbvwqG6Qu5l3oHHylnvmbbZy5R5SXSZLrUInW2YL/kSiPQfAaP6yTx0P+ydIjPnDUqCmzj8gsncP7ey9qWXb+JMdYAX7dkeiDh2mRK0IugSQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2emCS4sgnqvuq1UhBCvFMh0d6b3ibl/VCx8nUhqTJwk=;
 b=OnWM5mZfAwd3IQNOQZEd7xcm2ZZaLagfDPHStutvz+y/4cM/KLtqVxQm83zj99Jqt+mREsXEh74NFI/2UE8jvbGBwpy/ZTSWM0mgRWxwlSiV1g7sQmer+kX5JCf7hjJFvoQTAOGAFjLqsuuJ06lSmuOZYsvezBHZ3aAwIBxlFR+GroYfWZP/hs27UkTA1eG2QrMKdaWlADy7m65dEJMBjDujZE9SXTv8IXciY2rzOhpH19JxcWbkm2wYkPilsgmwJRvaB3Eg9akhDt3N3p40gUBW+xInylbzEAS2DdLm7OzfrxhYoKKi+guhB9apXK+YQiiX33XU8em8DxI8CHA0eQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2emCS4sgnqvuq1UhBCvFMh0d6b3ibl/VCx8nUhqTJwk=;
 b=bN5EyAPGHfBRB4hAGjUrbvmo3p2v0deEAs8vRJKjJWmZVt0yaDgeQ7ZKVePvHoRw4Tc5lC2f47fBkiB+Ix+K/rdfDl2FQTi+ugtAgmDPyMK4aHUjAAT7U69ZJbGZA398WTB4UMVxy2A+rKfqqkkfAJcvXNvF33mD+pBbAHz3MH4=
Received: from DM6PR10MB4313.namprd10.prod.outlook.com (2603:10b6:5:212::20)
 by CO6PR10MB5604.namprd10.prod.outlook.com (2603:10b6:303:14b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6411.28; Mon, 22 May
 2023 11:48:12 +0000
Received: from DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804]) by DM6PR10MB4313.namprd10.prod.outlook.com
 ([fe80::8456:ba59:80ec:d804%7]) with mapi id 15.20.6411.028; Mon, 22 May 2023
 11:48:11 +0000
Message-ID: <507d7c2d-ceb3-f03b-0ca0-ca96729ed7ce@oracle.com>
Date:   Mon, 22 May 2023 12:48:08 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ata: libata-scsi: Use correct device no in ata_find_dev()
Content-Language: en-US
To:     Damien Le Moal <dlemoal@kernel.org>, linux-ide@vger.kernel.org
Cc:     Jason Yan <yanaijie@huawei.com>,
        Xingui Yang <yangxingui@huawei.com>
References: <20230522112751.266505-1-dlemoal@kernel.org>
From:   John Garry <john.g.garry@oracle.com>
Organization: Oracle Corporation
In-Reply-To: <20230522112751.266505-1-dlemoal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0106.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::21) To DM6PR10MB4313.namprd10.prod.outlook.com
 (2603:10b6:5:212::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR10MB4313:EE_|CO6PR10MB5604:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ffa939-ad72-47cd-ed27-08db5aba6b7e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Jo6g3/doN8fj481AhfhTJ5QZjtAosQ2bRZQVwKByqxhej0bT048zm8eD7YdXX+xDN0iFWgGVF/BTy6RA/pWVcMpZe2XQi/iTQO/jkib8R1Mfgd1uv9WhbsciEnQR0LGPTeMqKfSig8VaKQQp39WHgsKdM96uQkD5ajBYm4BtM9G6VHYSz1YSJ7LYIVAXRQXeWsc2eIALI6wY4fRtKNrQKgU9WeEowVrVi0jyX+AuUOInMvUgoqjZdyJ0c+bKqLwLg+y0nrW1y9vDqUFrOPG6hrpAFbU/ecblDOV4wP9GKUMQs2rbMictHz4pnKuY4tQfG4dxizzSFyMJgrOa9E3qMv6FKCp1nTy2QLRI2dshQTJHZxdujnp5OJH0qi3Rd/vJGqXBriBBWTHV/UOFzexcoP5ZIAM/cs28/o6fxpw2LA7qLyBxbniGp2HR0IinNzrcAHroNhUyRYedKKRt3YcE8f4s6L5ekxzENoAPiIky3EshKGKH3AIUuu2gEYw9tvP6ChAyJy5EtrkAJ7xdXik0nU5hRUQcvAmLnPR+4nNAcZ6n1nmLc72c9GrEVaiQXShlSc5l4em278ZkjOrLQp8V51EKfl25Y8OaZfcboP0Itn4+wzL0TCTaVjltfdnW6cXIFXfnCp0KA62OvCLe1DtlTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR10MB4313.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(376002)(39860400002)(366004)(396003)(136003)(451199021)(41300700001)(478600001)(316002)(6666004)(26005)(6512007)(6506007)(53546011)(36916002)(54906003)(31686004)(6486002)(66556008)(66946007)(4326008)(66476007)(8676002)(5660300002)(31696002)(8936002)(36756003)(38100700002)(83380400001)(186003)(2906002)(2616005)(86362001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Wm56Uy9MTXBTOGhXcDNSbTBmZW9QSXlOQVZaVnZRWXprbTRTc3BHNEswQ2Yz?=
 =?utf-8?B?OFhMZ2Y0RjI2eFdGWjZRWmt1Tm91M0xQNEpFM0N1R3paL2JsTm9kN0t3MFhi?=
 =?utf-8?B?ZmpBVEJJTzBYSmtBdUpuK2oxSjRUNk1QKzZyRzBnRVN4MUdyWUFydi96VEVG?=
 =?utf-8?B?djk5VzJvYTY5a20wdjJlNEdKNXFLbmtUb2d1azE0Ky9OZDN0RWRjamZMUjhR?=
 =?utf-8?B?ZStGazFEMmw3ZzZUM1l3c3ZQQ2RrOUQ2bXVERXJ3dUdua2dCVE5lUFRWdUVV?=
 =?utf-8?B?SlR3b1FVcWdIYnFwREhVdGRWQTNRbU5RTU0xcWtXbFlYeHlXQzdwSittNnQ5?=
 =?utf-8?B?SExTWkJyaENBcGtVKzFxdXYzU1N5NUd1T3dUV1BvbjN5Ny85U1B4Vm56T1Rj?=
 =?utf-8?B?M3VLbWY2aWJjZVYxTFhuelZicWNCdnZvVlJHN3VjY1JWTUZxN0plTHJWakk2?=
 =?utf-8?B?TkM1NFluZWtLQzAwMWdJVTkxMXkycnhpZS9sRlMveDArUGNFOWs2RjZOYVdv?=
 =?utf-8?B?ZXNGVmNHQmVEd3pYNlBNR2pzQy8vbWZJZGxzcXpDbnFzY3M1UjJjOHB3aSsy?=
 =?utf-8?B?aXJ4dkFkbzdCT1dFZHpWVUMxb05rTExhOFJRNnJ5SXhPcVdSU1drd0ZmWmJL?=
 =?utf-8?B?aVlza3RidEVZbjMzb2RvTU1FTitZZzR0a1ZMOVlsQ1N2UTNkTEwvTE92VE83?=
 =?utf-8?B?RkQwb0VDam9TcE9iRzg2N2tRZzc4eElYV3UrbWdybFdGTFVrZVZwcXJheG9M?=
 =?utf-8?B?R055a0JIajZoeTkyMFJGdGJKeTM3Z1Ryb0FxVzJCSE1ldXlzZnRVdkVsOXJt?=
 =?utf-8?B?dWpCVitZYm42Zlo3NW5YL0w0dXNEbWFFaUpkUXRSbVhPQW5oM2FPYjFUcUVh?=
 =?utf-8?B?NytRdFZXeE5Fak9nRm1EWWhOTVliMTVFT2J0SlJYWnM1YVZpVzJ1UVhSWUlR?=
 =?utf-8?B?dzRiMnpKUEhCN1hOMjVYYm02RHFqNi9yYW0wdHJTRHE1LzFrR3k0dzRyVlR5?=
 =?utf-8?B?WEZrZ1JDSUdoem9zNm9HSldyN3hyL0s1YTdac1VFZzU5MFhHR1plbzVPUmVl?=
 =?utf-8?B?bWhMcWg0b3JCYTVtRlhjYjZCcGYrRjN3WFhTV2hWZFJtck1oRXpmNTVNSVBH?=
 =?utf-8?B?TFg4dlRoWGVlZURXODkvdmY1akVGWC9KUVZoSkpYYmcxSHZyL09kNXFsRFdw?=
 =?utf-8?B?ZW4wYXBTVHpYc1NEYllVQS9GNHJ3QjAyQVcyaWpXb0hIenFpTVVGMDNHQW95?=
 =?utf-8?B?MUZYU1luTnJYZ3Jxam5aSTZRaXN5eVR6UTJyaExhR0tDL3dZVGJsMDlRaVdp?=
 =?utf-8?B?ZHVoWFdJbCt4Ujl4K1NIckMrY2hScVF4bS93R0l1a0NQN1NDMjl2eHZHZU1o?=
 =?utf-8?B?aWdqNEc1NzBnNE5ONUw0Q2k3Uk9YdHh6ZmhURjRSWTFMa1ljWjI5WWwyZ0RF?=
 =?utf-8?B?ODBVVWhmZnRjWDNrMnRUOWxSeEFuYmRRQXZUNEZuZmRVTmZ1OFhHSlg5L3N2?=
 =?utf-8?B?cjBURjdYLzNuQk0xUlFOSkdvVTAvK0h3NXhxQU03S3p6dzFXUFBQbXRISXdC?=
 =?utf-8?B?MzV2ZG5GcEpIbWxhYlV5dVhHRW84WEsxbGdnU3p3V2toRWpPNTdqUVhrT2kv?=
 =?utf-8?B?Mk5YMjd6ZGdRVE12NUQyLzRkVzM1czQ4Qk56UzdwK1E1aEQzR0VuMXQ4S05T?=
 =?utf-8?B?eWIvOHY1K09lalhKV2ZsLzJQT2JwVnJjSDlGQnFSb2cwa3dObnhndCtpMVlu?=
 =?utf-8?B?ZFZodmUzUnRFYk5lMlkrTUVvejJxRVFkQ0NGNWdaME1SZ0NxbmFrVGN6OEVz?=
 =?utf-8?B?U2k2Z3B5cWZMQUhpUnNjcEpzeGVoUGZzeTJRVUV0dTJjMDk5aWFYY1JYdmRy?=
 =?utf-8?B?V2kzdEJvVGVWMVJaMWU1Rm5RcW81eDNBUSt6SUlMTjJETGdKTzFhbzFYajh0?=
 =?utf-8?B?RWFCRjgya0ErMkZUNjdZSFR2QUtNZG4xQWplVlJFNjlBRHRFRUlSYjFnVTNu?=
 =?utf-8?B?ZVQ3L3NZa0FmMEplOHVvbXlxNUJKd2VQKzdMeVlHWGxHZE0xdGIrdHptUjRI?=
 =?utf-8?B?QW05c1g3Z01XazkwUnV4K1gvQVZXUmE0dkhIV3J5NXp6Y29yWVpDNUt1L2Jh?=
 =?utf-8?Q?TKj4U3EGa+UB01+UJ4CHs2SHB?=
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QHCLv38M1/D5spy8Fj+ZPWOoAQ5n8LiJ5MkTdoveuLFGIMbhbhd5sL/ef/EJFC5No/GW2ZPKrSJIPuZO00d1L8yA+XdBJlHEZ6I1jBETKozUmj6WZdKGDNi0IqK+wqGygEaSaJ/2yOtsBW+jJV2aXPCWq1usoQblXsmfLnvIJ0sr3V0h4NnnRHyxCghqsI+XX6HLQWmTMs+bS+d8E3Cu02ZmSZYvc8zYAufR5sBR4faO6Q4nXmqylFYqdTBtj4C4flG+HuJLWZ/oqI/22OpQce6xXVc0GOMU2U5qVVEjwtnNs/1ZWlv5YfMd6TDNIrc3YGe5+0ErQJmV9t2S1W6o2iytHIRaEHxLm5VamFPuZpeaF+KTStjHzS9Cz56ofaMawoB1cPNgF6Khk/Eg74PeF3qc5XZJpi88jHPsbEGk+nTQtV/J+eLNwc9y0/RKcsuDn/6nHYBsYlm4VbKBOEtaiSCWwDJaJh/hJdE4kEecvjGA/Pu7IdIY+neumvEckbfLRYfy/sddg/AIjd+jZJ7o/xE/On+k6Oz1BaFywG2z012EvVA6asBbgCR1kajeFk8tW1nNW694txRCGKfcZ0bosSrC069hdPd7QYDG+ukuF+YFHJ/Jjx3iWrh0t58Uc9ffnIZahKHd1P7h8l2z6iMLPDhEJhJQjXW17dRsqWfCP69DXRU90lKrUIhqoCLHdFwxkgD7mM7ZiQL7sPvjrPyXI0/4NwVeeqcGrGCr7SCtsgqVpggOM7luaV6p2mKD6CK/g15+s3PgHn+qGXhaiutOlJ5Sfv+JPXQGYhU2FdudzTEjQ/ImqFrBjGnV/H+tp24h
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ffa939-ad72-47cd-ed27-08db5aba6b7e
X-MS-Exchange-CrossTenant-AuthSource: DM6PR10MB4313.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 May 2023 11:48:11.9092
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gHoSCrIcbIMcGyll1d/rjIlbMFBGPNmyjkBVxVRbWgEP3iYvOCKZ5GeUHDiO+bwVAYPtdm+2BFMMhYeWYZVRGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR10MB5604
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-22_07,2023-05-22_03,2023-02-09_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 bulkscore=0 malwarescore=0 suspectscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2304280000
 definitions=main-2305220099
X-Proofpoint-ORIG-GUID: TYuSi5jMgdjXaqbgjwTkcrkOJFl11NiW
X-Proofpoint-GUID: TYuSi5jMgdjXaqbgjwTkcrkOJFl11NiW
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On 22/05/2023 12:27, Damien Le Moal wrote:

Hi Damien,

Our mails just crossed...

> For non-pmp attached devices managed directly by libata, the device
> number is always 0 or 1 and lower to the maximum number of devices
> returned by ata_link_max_devices(). However, for libsas managed devices,
> devices are numbered up to the number of device scanned on an HBA port,

It's not really clear to me which number you mean. For libsas and lib 
ata, ata_device->devno is configured the same, it's just that the sdev 
per ata_device does not have the same numbering scheme for libsas. For 
libsas - or scsi_transport_sas, to be more exact - the sdev id is per shost.

> while each device has a regular ata/link setup supporting at most 1
> device per link. This results in ata_find_dev() always returning NULL
> except for the first device with device number 0.
> 
> Fix this by rewriting ata_find_dev() to ignore the device number for
> non-pmp attached devices with a link with at most 1 device. For these,
> device number 0 is always used to return the correct ata_device struct
> of the port link. This change excludes IDE master/slave setups (maximum
> number of devices per link is 2) and port-multiplier attached devices.
> 
> Reported-by: Xingui Yang <yangxingui@huawei.com>
> Fixes: 41bda9c98035 ("libata-link: update hotplug to handle PMP links")
> Cc: stable@vger.kernel.org
> Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
> ---
>   drivers/ata/libata-scsi.c | 31 ++++++++++++++++++++++++-------
>   1 file changed, 24 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
> index 7bb12deab70c..3ba9cb258394 100644
> --- a/drivers/ata/libata-scsi.c
> +++ b/drivers/ata/libata-scsi.c
> @@ -2696,16 +2696,33 @@ static unsigned int atapi_xlat(struct ata_queued_cmd *qc)
>   
>   static struct ata_device *ata_find_dev(struct ata_port *ap, int devno)
>   {
> -	if (!sata_pmp_attached(ap)) {
> -		if (likely(devno >= 0 &&
> -			   devno < ata_link_max_devices(&ap->link)))
> +	if (unlikely(devno < 0))
> +		return NULL;
> +
> +	if (likely(!sata_pmp_attached(ap))) {
> +		/*
> +		 * For the non PMP case, the maximum number of devices per link
> +		 * is 1 (e.g. SATA case), or 2 (IDE master + slave). The former
> +		 * case includes libsas hosted devices which are numbered up to
> +		 * the number of devices scanned on an HBA port, but with each
> +		 * ata device having its own ata port and link. To accommodate
> +		 * these, ignore devno and always use device number 0.
> +		 */
> +		switch (ata_link_max_devices(&ap->link)) {
> +		case 1:
> +			return &ap->link.device[0];
> +		case 2:
> +			if (devno >= 2)

How about ATA_MAX_DEVICES?

> +				return NULL;
>   			return &ap->link.device[devno];
> -	} else {
> -		if (likely(devno >= 0 &&
> -			   devno < ap->nr_pmp_links))
> -			return &ap->pmp_link[devno].device[0];
> +		default:
> +			return NULL;
> +		}
>   	}
>   
> +	if (devno < ap->nr_pmp_links)
> +		return &ap->pmp_link[devno].device[0];
> +
>   	return NULL;
>   }

This looks ok to me, since we have a big comment about what we're doing. 
I did send another suggestion, so I'll leave it to you.

BTW, I think that we can follow-up to this and remove the add ata_device 
arg that we added to sas_change_queue_depth()

Thanks,
John

