Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79B55C433EF
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 16:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5AB4C61247
	for <linux-ide@archiver.kernel.org>; Thu, 11 Nov 2021 16:13:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKKQQL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 11 Nov 2021 11:16:11 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:47342 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232366AbhKKQQK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 11 Nov 2021 11:16:10 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1ABG9hCR024089;
        Thu, 11 Nov 2021 16:13:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=Y1PojENPpH8U9boHel/LbO8oFvuaS6Mk1Ko/Pq2F47k=;
 b=tyvWTiJ1tHYr1Xp5YBI1WS+gR1MzKsFBVVvm7lhfEhAi7e/sq8JPX0bWlFW6d4Jz87ut
 jNgAMozeHsOUmYmSDMUkckFwD6+3luNUrfeKdu7lsP3lWxScGg4lpkGVCHzHWcru2inZ
 ppUJiIEj6KidvSG4DIIoxRw6Ev5e2ztQLKfC4BxNMj2zGcOh5AtPiqRx/Cvib2dJJRTM
 9eEydC/hZMBr4FL+LPJ9QqH0FNZ3h3b6B5FxfT/fw/43KE0oJl9cRpZmCRtUpMiwcQGG
 WmZCCxFWq0FutBS/NtCOrCQBngvFnTyL/dFgfNSHsjgmP0ylkKZ9DZrgRdjP9Oc7iZa3 FQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3c85nskgnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 16:13:20 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ABGCtej193120;
        Thu, 11 Nov 2021 16:13:19 GMT
Received: from nam10-mw2-obe.outbound.protection.outlook.com (mail-mw2nam10lp2103.outbound.protection.outlook.com [104.47.55.103])
        by userp3020.oracle.com with ESMTP id 3c63fwf93t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 11 Nov 2021 16:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKkFKLQNC2jwVLbnDVq4+Al3t/qzqHif2osfK48VydS/hLCO62zAtKfNj0pG51SiJcY42myF20Dmf+zzM+THm442xnw1UkoCyAAUfWpz/xwZPo7C3XWGMyqo92ah1rDysD3gAMt4NmS+911ZORvitamSCgITI08G5l6xLI+YEp8ojnkLtnz6jqkgEfTK7Wbn902568dOeBe0MPU6wYCPBIgtCHLRER0RhO5Rm4l/rdOmGdL8zb8lllbsH/D77+d00gC4Q2atdraNA7a2XxKVW6QA0y6RUHYEedcZyvtWAdsFhLW30dGya1aUNMtI7Q/R8WTUTr/uPMsRaCVm4Z3VNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Y1PojENPpH8U9boHel/LbO8oFvuaS6Mk1Ko/Pq2F47k=;
 b=fnlXBko5iVublmXTNTkklm+bli+8xVgjlt8lCpN4vtElwGMj44rDgUQRqCQGXaXVJvkR5XD0/DZeg/h4hjEMPGQAa08+IKlbTkqe9Rgdq4j2Gw4L+LgK8rC7+v8+qT19Ay0sxSAHgppdfct9meDUshLVarFV2/uPqzfMDauZJkC7DXHaJ10ApD7uhl0xS7xjpSo74NeBjKteXKb9FXH1Onqvw565JkP413fCGalJ0GijHUw6dCFS0yOWZ9oVAa2K8Hu7Kni0PAZvTwIo2iCBzhVYpdnM/Cy5Fn9NqeY2JMyxVxKfDuREzqrumnp3NO9q2vfze+4Bf5JE9JkCq17sCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Y1PojENPpH8U9boHel/LbO8oFvuaS6Mk1Ko/Pq2F47k=;
 b=JUe4e3ulE0X2PsK8R1Oag47quVMW2xgStzSKK3wuHI1dhqCfBFLjmK3Ze4y3/SScbKZ7FhblcJOL4WCveGCg/I/4POxJaMtVikygLF5y0noLIGN+waQyDsfE6DZ6yzzyzguK2qGPO1SHv9QXViAMj/YuCoeAJ4kvbero1LyOG/o=
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB5870.namprd10.prod.outlook.com (2603:10b6:510:146::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.15; Thu, 11 Nov
 2021 16:13:17 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::a457:48f2:991f:c349%8]) with mapi id 15.20.4669.016; Thu, 11 Nov 2021
 16:13:17 +0000
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     linux-ide@vger.kernel.org
Subject: Re: [PATCH V2] libata: add horkage for missing Identify Device log
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle
Message-ID: <yq1tugiekmq.fsf@ca-mkp.ca.oracle.com>
References: <20211110081441.587089-1-damien.lemoal@opensource.wdc.com>
Date:   Thu, 11 Nov 2021 11:13:14 -0500
In-Reply-To: <20211110081441.587089-1-damien.lemoal@opensource.wdc.com>
        (Damien Le Moal's message of "Wed, 10 Nov 2021 17:14:41 +0900")
Content-Type: text/plain
X-ClientProxiedBy: SN6PR05CA0030.namprd05.prod.outlook.com
 (2603:10b6:805:de::43) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.201.5) by SN6PR05CA0030.namprd05.prod.outlook.com (2603:10b6:805:de::43) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4690.5 via Frontend Transport; Thu, 11 Nov 2021 16:13:16 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b395f792-0d2b-496b-f95c-08d9a52e2bb4
X-MS-TrafficTypeDiagnostic: PH0PR10MB5870:
X-Microsoft-Antispam-PRVS: <PH0PR10MB5870B4A41A97C15F92F8D0588E949@PH0PR10MB5870.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jzZIz712TawMW8NT1IMiiZmVTIqMbOVPs2UoRvebl0+9ZclHUYnkBPTiAaqt7W5T4kd/eTbCxigTub/gbWhmDYIt7ILDkVCd83xepssChfTc5B4PYmaYpr2NeP9GJvb2YsJVdgnhxDwueYsBEuahABXt2h2cAvw2bdWH2oBTWpIXt/oZ8sTNXpBvctW9ipRvEM652P1dqfer2s8II7+qllpIkXUqFfeZu77spC4n0JV5unuNJh+47B1LYdacH7W22KYYXKOR5V0tW2fopHxWmULz7vkp7hlpbS2RE/BWE/rO26YAXbiw9Y0xPNUm7Uu8kYaGsktP1ADK7OUo5WnRFoC2b/0/ZVG4c71v1PZiHJmEz3gF0ys13GDlWMsGPFFf7pv58Yk+9SezXC8WuTHSgKrv2rG4gS/++qjhHuEi/xznJGLnd/h0u1NmNDN6nj9B2o1e0xLaow5DHe+Mph8mMaritQDWvEWo7HRDNnqPNS5wURy2OisS4StOPUObPTsnIb0bE883mwgLIFkQMTjMT4kws/5fQAVdH5zQ5YPMmKrHK0EEbD5xV80fpYN2qovOSu0Y96ctbmaO+UpikocyR/1CvpJLuA3y7NWvCsxe2Xt8cKK8s9DZEi4BaXwmTK5FFvhdabisln60U9avuB5/mELtjsiU72DjClCg7fvAf0my03DV5B0ryDjOfxZCRHiJzm5uAO3k7hMC6vACDC/b6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(5660300002)(66556008)(66476007)(26005)(8676002)(52116002)(186003)(316002)(55016002)(83380400001)(956004)(4744005)(86362001)(2906002)(4326008)(38350700002)(508600001)(66946007)(7696005)(36916002)(38100700002)(6916009)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iH7MQYaUkSxZSftH7rOyIV+3e7X89Q2q8XMImnUbCovvauAP6xSUb79cTahG?=
 =?us-ascii?Q?ZUZWwxPUF1G1fN9EK15fB9EUINZeIYHsUMcocmXIx7RR1Rnv7M2uVfuDwquY?=
 =?us-ascii?Q?DUM6YVjE2dScQF37vYleRqx26ToKYka96P4yWlaH3DM/DIdGtvRVsGtMtQrQ?=
 =?us-ascii?Q?5XvEyvTUl0VKmDXahfq5eSZt6EliLBvLbtJadTz+12lzODT1Y8WvuQD0r5V5?=
 =?us-ascii?Q?RrLLbXQlybFJm5abKgfHknoXtr+hsWfmqWEyz4D8yIU1sIqkptS9JnSr2J6O?=
 =?us-ascii?Q?cvPbDlAX4qEGOx4tRUXb6Ga1jE2B+uAWr8OGUdznZVEAvb9ltQKCK40jg9ky?=
 =?us-ascii?Q?Iye5XY3I8UXmNq7/shrWBVk8x32QbCHXXZTSAyzzNab2ZHri70eYG6pxU2Y3?=
 =?us-ascii?Q?VqGDIyoHRtC4eVPr7U58lFzkzMnNsdBYsDULjo9C5ea9ekWxh1QzHXvrrJaZ?=
 =?us-ascii?Q?jllDYLs/CTJAMzxJ56voQIT1xxETxIzcbaf+k8QznYmlc6kyQtcF4TUF2R1G?=
 =?us-ascii?Q?g7nwjEy0RaoPTn8l7fqTH30DLEukCh4GspVerNKcoT22/GlKf4pK9cXRNZ+6?=
 =?us-ascii?Q?+D48uCLUeKPZHiMNMRSJUTM8rRtybJBkEDKMXkr+zDcV6lrpc8lzkkWY+D4T?=
 =?us-ascii?Q?pF3a4kvbmCGnpwnmWVV1X4Cq3ulR7xLMIUdDeNkfjGdQJHcEooq+Pse0iqPB?=
 =?us-ascii?Q?GWnqdgt3Gp5+gXyozuJPA3OVrR++fskhzbqP7QWe/hSQlA1Su5RlwcqGP5Sh?=
 =?us-ascii?Q?eocAn7kwh601TWHl3YWD0xyIFgQJcFm5CpyCRr1v1icXdbYB3Sy3kgMeZSB0?=
 =?us-ascii?Q?pAZqEltbeGXFJ0fBwLTUe6VW41OK3tyau7We8nA9e2M1ShUcTbD7zlpqaGHM?=
 =?us-ascii?Q?VDALOeTKAWHih5eDZFeof4cdi+7IppFRKXymkb7HA6+BBFsEGnPYgI8e9RUm?=
 =?us-ascii?Q?fAGgPn7qqEhURrloH0X17rU7K2DMyAs3KMILrxaXmc4XLmWUPuhfcXrOffJM?=
 =?us-ascii?Q?zgElPQ60v/KLdHZXwsnK6j7LHjSncJLYJQzWHnjnccV4j/V/l42BhUxIrEUL?=
 =?us-ascii?Q?PastG0m9qouttb7Z+8hXaNKmZW6Exsu4GQb1Nmo06H6skjuPbTwsaOQ/xHTu?=
 =?us-ascii?Q?QYCspaSTa0YuuvJ3SBVf/5DQ/CFuodIeYhYtlRtnhcPdgc0gXHzjTyrQEiLt?=
 =?us-ascii?Q?shfyOyfplBH8mluBtf5y/KXckpxwGyxJykbh5pi69ham/L1eCaixT1mPLfyZ?=
 =?us-ascii?Q?f2+od/wrCPR7ScJ0glCHpic3gw2AHlrob6dQPVjOIehYnMqarVrgabrbf6cX?=
 =?us-ascii?Q?lDMyRsIrduB0pjOqBHpxDSeIxoErNJO0fO5VuML7pq30L5MaIeirvCXN1a8S?=
 =?us-ascii?Q?O22ZH6Ybs56q0fFFBv/eYU9nZmtupMTJbA9PQUZIB3NVzNCOqORDP8LTVhwi?=
 =?us-ascii?Q?fL4GhZV3nA69Qre/dz+h+FNGdhelUgurMsdvsUviKeH7dBlAbP/Ng5mAA1zz?=
 =?us-ascii?Q?KITRztYwyiP3bxmM5QAXqukeBYnYP2GyjVm5enKpAY0yf5S2TfPx2DxK1RwZ?=
 =?us-ascii?Q?z7dH+yQ19Kcv/jGye5UoBOdaV2AEuUsVkXIhf8zQsQ9+D+YSqa9glSARWlFe?=
 =?us-ascii?Q?fORBlpxTTciRPXQFSSKCwkW/rOW+6LJ86d4zyrL+wtnFcDYdbsKLvIGHqRpY?=
 =?us-ascii?Q?DM4Scg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b395f792-0d2b-496b-f95c-08d9a52e2bb4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2021 16:13:17.1707
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bOR7xQvKYQ2fYX8htWXeMAMibmzaig5nbzvtJKn3wOBjlNVuAHHsCdDFeo5xOfosGHyXEloR3gcuAu3T6cXtofo/arKSCNR5wHzgXkS5XGg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB5870
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10165 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0 mlxscore=0
 bulkscore=0 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111110090
X-Proofpoint-GUID: DmFUOVh12X5XSmAh6Waxo_6Ri0cmSxk4
X-Proofpoint-ORIG-GUID: DmFUOVh12X5XSmAh6Waxo_6Ri0cmSxk4
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Damien,

> ACS-3 introduced the ATA Identify Device Data log as mandatory. A
> warning message currently signals to the user if a device does not
> report supporting this log page in the log directory page, regardless
> of the ATA version of the device. Furthermore, this warning will appear
> for all attempts at accessing this missing log page during device
> revalidation.

Looks fine.

Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>

-- 
Martin K. Petersen	Oracle Linux Engineering
