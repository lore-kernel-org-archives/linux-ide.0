Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2A54C433EF
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 13:08:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A4A6610CC
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 13:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349299AbhICNJw (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Fri, 3 Sep 2021 09:09:52 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:41908 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1349488AbhICNJw (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Fri, 3 Sep 2021 09:09:52 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1839LUkY007481;
        Fri, 3 Sep 2021 13:08:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=3fNxM/wgkZj8SdyAPPV4O02hpE3PfmKj9A3CjXg/Wok=;
 b=bny36laO1oPyAjvxlLYj63wwD84Jx/JE0P9jMjQH57Y6C+UwHKBw53kNXcV6hLiWy9f6
 SPekp7d+OC5SwD/Eyr1+TH+OBlLwLUPqv1UvExTRS9qDdCRzJMrIWgi43vtxM8wqeNnh
 TKLNh4ynV7fN3N4L8bVakLfNNrl/6dtlyY8lXivYzGsBY5NevvPkECPWZ2+PitoWKUqg
 iSjmPvYr0GziWE/U2G+rsbcdDVdU/W85eLMzkZFfgvm2HjMo9JKHSE6xAVB/puMEOX5x
 SSBdIOnmn4IeFL+LR/NtLzQD/UjSds4PutJOQNVVcEuE2yYyW34iY+brgCotWS8BJjMY BA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=3fNxM/wgkZj8SdyAPPV4O02hpE3PfmKj9A3CjXg/Wok=;
 b=b32OdlQ8yEDncHneWgbATDCg9akohLpTrIOrDhBD8C6JD1QTVZErDFFXx+oO+qiq2m+/
 MyFBhTDMMLd0jUvE2sa23HcQa52IOT/QORhV8EVtYlPjWvlHy1Xmzgj2x2tk3u+uQB1P
 OhKsEhcnyxtJxZRw9udSaYkj778cN1Ir+hU+0kdAak6StqfNGS6AeqMCUINW2Ldx5Y4V
 jnD1/e8XgWDljf+oWC1ys3s0sA3/2uJ9GX3UX0pzJHlMtYO/OivnEpcR7MlOtgnl0fmv
 zWf/ga92IMKLC4DFvf2enu7BzTGOCO0oUvgA5oaZn2Q6bQtJIyn/N/22YvvacSajfhOP 2Q== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3audq7h41v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 13:08:48 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 183D5lmu086095;
        Fri, 3 Sep 2021 13:08:47 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2107.outbound.protection.outlook.com [104.47.55.107])
        by aserp3020.oracle.com with ESMTP id 3aufp39y3a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 13:08:47 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=I1cojqPzqL5wOp6svuDjgZh5HjObGZlu1FL82pISYPUph43/F0V4d+uubWqF/ObcwcSb9E0c+pBcAL3EuaHgx/fTXXSPHMCvqxw77ulgIqjKBMlqHuwuB3aAriNRjSWAj2VMp7lUQeKcbHnx+PIhrW0aKTWRL7jhDqumnPg2Cbh20TCMGrSFmaqAqXWVtgfJITEUdzJaMdxfxzZQCoThQ5sHVnNRWxkWgtTJ+BRZx1PjvDuX37Lb0Enj3TLZ19oPBN7EYT9LkiwNMVXzSLD41uKSXg7UhUGYWt0F/EiX11E7lqYWp6H1l2xMGeZ+TX7N/B+Gy83rroI/IPkFCzWagw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=3fNxM/wgkZj8SdyAPPV4O02hpE3PfmKj9A3CjXg/Wok=;
 b=eVcc/lGRmHHl+BLFvn+SSQmczeSn/O3UnK2baY3RpOqweBIqjKonQtrZCfrJmHXKud9Qer423YmtjPSvro3+bNJdorwV9f+vV5RmEmC3LHsJQsZcyfY2JRi/sa/PKlhn1bODdJxypQJggx+enewcrA1MrgIttrCm8fypyuOsUXHrlDtmf8I7eCQ6zBkngeV68SykGvtrGHQJ68DmYGwzIrZ6vxndBGimDZ6syiFjYfIxPRdGlEYWUQ4Vgy6shoGlzTv5DCrblHz31uC/gPz5lTTd1+OHdAQ8R/PFO9s/l0w9xepO8dUGNogg/HMltgE8vTbIuhy4dAorhS8HFQEeOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3fNxM/wgkZj8SdyAPPV4O02hpE3PfmKj9A3CjXg/Wok=;
 b=ry1xBZLBdRYwWmtbserB/+uEjJn15mKkKJhHKabp9RxX67NreqtKLqHC43xQHCcM5qhi4S0RsUjGM8Cc7nf/Q4b3I4OSc/OA7R4O7p0sTUVkEKxG6i1eWE9CNTjMQ599fRDt7irF0bqauZp6T6chKLSSpb0ZZQK2Y4kHtkZiY0U=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5450.namprd10.prod.outlook.com (2603:10b6:510:ee::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Fri, 3 Sep
 2021 13:08:46 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%7]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 13:08:45 +0000
To:     Kate Hsuan <hpa@redhat.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Hans de Goede <hdegoede@redhat.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] libata: Add ATA_HORKAGE_NO_NCQ_ON_ATI for Samsung
 860 and 870 SSD.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1wnnx3iyp.fsf@ca-mkp.ca.oracle.com>
References: <20210903094411.58749-1-hpa@redhat.com>
Date:   Fri, 03 Sep 2021 09:08:41 -0400
In-Reply-To: <20210903094411.58749-1-hpa@redhat.com> (Kate Hsuan's message of
        "Fri, 3 Sep 2021 17:44:11 +0800")
Content-Type: text/plain
X-ClientProxiedBy: DM6PR14CA0071.namprd14.prod.outlook.com
 (2603:10b6:5:18f::48) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by DM6PR14CA0071.namprd14.prod.outlook.com (2603:10b6:5:18f::48) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4457.17 via Frontend Transport; Fri, 3 Sep 2021 13:08:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 625b7a47-a76b-472f-555d-08d96edbf63e
X-MS-TrafficTypeDiagnostic: PH0PR10MB5450:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB5450849F83F65B6D2F6A4EB28ECF9@PH0PR10MB5450.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:3276;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0O+RqWFgM9eR+MhaZIvIOtqKLI8G8iwUc3+SuoTQ6wNAUFb0iZSnF4PWrq2Ma0wOwad2zNUYGCrcuN9iVTbICyXDeuW3ncIa+InjN/ZfalM7pI0pGdamajAQmJvVCHAXOBR+DGpxP8nNjk8cpn6/D1dXfFDMeptBbi7szEm2UZl6QLBfh92vkFoVPMEwlS10euGvRVcHlm2b2NOk9LTQqHy4jRh0uhUcVm3jhwqGK7IYT+nNUZi2Qw+7WVYfDi1QYdT6gL21POwBf1gARsOT+V1qgYXI8gwWNHVYUpYi5eqjWTMG60gg6jtPsQHYVks8NJii/X2EyxGYvHtc60YiCy6Vo7VWxqTiHGrvpo0awq9q+8NAt5/O6ZvgzlDpumzt8V16jV9US7ZJf6bY3l2czVSpvQu/63NoAmXsI138pMieORsRYDxayOQ+ouR7XRCouAV1zvaQsNLZszTjwU9a6vErdfnLmriyER76cXbPebcOrZogrOHPh72j9HKoVuLNPXZTi456HJG5vFDJkmd0l01qdNvaj2pdCQfR2b354b9o2VokYpM8fURiYTzmJ4CfsHJdcB5nfaNkoJrHb281WUtF04PMeZay5wfZzSQbbWz9S3V9202Hsd58rsygwCtoY+5jfUzhV/PSfGdkzj7Qh57w8WwCA9sMXfqbWEvcCOimzWSjNX/Q/fZML1NbXWUtGs/gVg1HeNQQLszPnwyjRw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(39860400002)(136003)(396003)(376002)(346002)(366004)(5660300002)(186003)(478600001)(86362001)(6666004)(26005)(4744005)(38350700002)(55016002)(38100700002)(6916009)(8676002)(956004)(2906002)(36916002)(4326008)(7696005)(54906003)(8936002)(52116002)(66556008)(66476007)(66946007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UrAF/hlavMkWt7VwmAzdUA+PX9hKtP3Dpm3wN55NSHK/RIBg0x56qISQSxYf?=
 =?us-ascii?Q?SUxmZ6PKoVnINSgMBF4xxixzLnQvRJP7Vtt9AIkG42m0u5n9ivDhVhm4sJzx?=
 =?us-ascii?Q?M48dJmmkd+Cg0T4D3tKpQ7hN9dQK/Gx2BeDjBo7bKKQ9yJqZmtNwyWWGKdtf?=
 =?us-ascii?Q?XXpCVgXB49ss3czXOJM/rQzZbDLjJ1gLHTrCCrXTTrrMkM+h5NxwzwEZmaKa?=
 =?us-ascii?Q?8xeX8KDIJTHgm3XI8b8mWqI7D6kC2LqN2qv1OPPnhRn2IinHHhPRPibDStpj?=
 =?us-ascii?Q?HzN2KPXYPkbbq80HzpeSK7LywVUSB1Snn7/tPiyCMMXmAQejpUed+kYCfJBR?=
 =?us-ascii?Q?ZK7V6+foa4czMRN2T68NliED6nTtFy3QeR0TOYE40Judp79KeuEUqfg3NmEV?=
 =?us-ascii?Q?wJ4avqvFblSMiv6TJKcSuglYM/gxw3vEGxPt8yy3u63F4JyHvQsk26sqVUXa?=
 =?us-ascii?Q?LqjfD7MOMk5PFkzaTifMZ1FsH66bhGT8ZRwHHg78T7ACHf2U640krb1yYVUV?=
 =?us-ascii?Q?5dRr8+lc52VZf/PCCPPuPwe5SJNmcORQBHyHxIFjGYD0Q3TVcYdrUKIvfSet?=
 =?us-ascii?Q?ibSy/FLzysm1szG4bub19BBKbpJa/ZBQwYALtLBGS6j2F/fNo4ON1/buc2py?=
 =?us-ascii?Q?9XCzFMOdKaVxMDSNCVL5waJNbCNkLjAeNqMdm5nKgBs3Pn07gZRTzW+tj9i+?=
 =?us-ascii?Q?/JWvCV/6m+dJjV/5A2NCzXVs3lUIbeEZJyewAt26/6z6CuF2qqjsbPF4KpWg?=
 =?us-ascii?Q?iO3RignE3e3Oc9q3XV0Xsb2buoP8MMaJh/eXsUH+IDJ0s5Y4TdWTlp0Qv6cU?=
 =?us-ascii?Q?YrIWo28Dd0WQ9M6xpOqDGBR0HZbMfuX2pfv+gWZp0h/VMkUdT2dRmRVMT8bS?=
 =?us-ascii?Q?KJHWelndmULFlCMOOrnj7JItuxyIn69AH4UQ43ees/+DVWUTfC0178XZ0TBi?=
 =?us-ascii?Q?iIxypgZopy9+QaqKcK6eB1lPzEqIw2aSgWh9W0Db67Gl4FXfvbmSQNystmjr?=
 =?us-ascii?Q?jxfZJkQT3w+rOBtFkpfNs+U3mbpIeK+fPE4seW3pJ7qtnfzG7Cp1BTDuRK/P?=
 =?us-ascii?Q?ZAsoUUOu7laKHdQW/pA/2ohpl87XwO3YShZdu8e3LWNOH41jyndb9EyFe+iG?=
 =?us-ascii?Q?EBkGrn7zt8awlRiqyWI5arbGD6PQq7ACjeibJnZFOpkyukMqiz7tXL0ssiEw?=
 =?us-ascii?Q?mI6gFEdrkk5sKjzRZIQ3pUxEOr28rID0DHn0wspWDP02d6tGdgTCARz/u/VS?=
 =?us-ascii?Q?RMibGZ65XX1I4cmcosFVjXSAwHgGviaLTbxLnrplDuoqkn5U5L/8h6rJX9Fv?=
 =?us-ascii?Q?eOVR3B/w2CfV3AGJO8empKvz?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 625b7a47-a76b-472f-555d-08d96edbf63e
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 13:08:45.8914
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+166uM/UeQg1MH0aua+xbtvLMGpOsfEbLpxz5DcgZeOQz1e2KtC9RNQnR2oNfNg3RQJggoEf+RyvRM/scoVF0GS/6ogUoddCAaa6knasCc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5450
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 phishscore=0 suspectscore=0
 malwarescore=0 mlxscore=0 mlxlogscore=999 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030081
X-Proofpoint-ORIG-GUID: Nqrl4SOx99z3_jX7akLV7Wl96HdeV3nP
X-Proofpoint-GUID: Nqrl4SOx99z3_jX7akLV7Wl96HdeV3nP
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Kate,

> Many users are reporting that the Samsung 860 and 870 SSD are having
> various issues when combined with AMD/ATI (vendor ID 0x1002) SATA
> controllers and only completely disabling NCQ helps to avoid these
> issues.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
