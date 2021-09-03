Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8418AC433EF
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 03:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5DA2C60FE6
	for <linux-ide@archiver.kernel.org>; Fri,  3 Sep 2021 03:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbhICDXL (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Sep 2021 23:23:11 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:9610 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230074AbhICDXK (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2021 23:23:10 -0400
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182MsF1f023057;
        Fri, 3 Sep 2021 03:22:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=vDpz3l5PQaCJAVmRxpFwXYyMtB/ZfM0xaNLB2Ga3fNY=;
 b=QWhxFvihx01GzRYWOwInPYFO+yklcx0qvmJWh6YPhBetMtAqGYhFSuAKNlYT9G1xSPVg
 lcjLND/kkM2X55LjLZmWcTXwndT7xX84u5AvLJ19s2sAvZbrP0VNb5tv3w6vXhCG6CBc
 8DWskaUt/iiqsmgXzYPaVZxvdtbA5fw70OgDC5FDtonsd3Zrmv2ZGQ0ONxs2QcCkjWVR
 cJEloUNt7mezcNr6Nv1OGFWjXuq14GetHwSlvY2T/EE3aLvyIrQQ5E5s3+llYQyIOsc5
 3u8Qx3kkbmZqQfQST7WEsz2IdrOQQvH5OHTMRr5zej2fX4NyabL1VlU/CVSKIqxO0cS1 ZA== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=vDpz3l5PQaCJAVmRxpFwXYyMtB/ZfM0xaNLB2Ga3fNY=;
 b=zpISq/16tgBAZhvL14dNUPnnERZyo32bz4w+ZNkshoEFS+d7YJDzB8eVDXifle87b6lY
 +7e0Vi3NWihSxO7DkLB7pJftYbE2wwpw76HR1pLEwdizyMqNcjvlBAY91POtomu36uy/
 sZFpyFKOPaNAckQzM21E9d7v+aXa8aw2LjBtWTk5SmvTMmelGoEHnPikxbIvyICz60/3
 ooiR8t0whztIKa7L6QV36AIwzYukVBsWs27sHoPrS+jbur/VXrg6ueQBd4MIYMThH7DT
 53P18mqRgYrZUq8C1fMkMnFcTyrOtrWZNH9LG8S1oe70/g6lNAJnaTmgSzH/Rgp90XTa Eg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdvymyf1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 03:22:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1833AX5S103527;
        Fri, 3 Sep 2021 03:21:58 GMT
Received: from nam11-co1-obe.outbound.protection.outlook.com (mail-co1nam11lp2174.outbound.protection.outlook.com [104.47.56.174])
        by userp3030.oracle.com with ESMTP id 3ate06v5ds-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Sep 2021 03:21:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mxuzT8zsdTNpoEwJhIDdNN/YijUIU+3SFV6f4L8GTRD5aeluveKlDSDQkk/xK0OG9wKh1zBTe/OrCZQf/Uuc12ViQysSS3ZE2fMlj4ozE+72/6NsT13/7trutNtJVPvsblVNoq64bAUOtzXLjQv6EESMOElLaYVKdiDDYburJaLT7zshS+RRMRXbRi4Or6Nm7uW35F/if1b3dxv0mdLutgg/bbK9DXgaJbsxjdjtq+HAbv4WU1Dm9XfhKfAYRBEqfgdMyyM+N6AyaEZoBc283TMAvHRCUPxDWGa+NXJbEBMMfqUd+p90oqaYXeec7n6Ued6sVMA4Ku6pfT5nqeg84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=vDpz3l5PQaCJAVmRxpFwXYyMtB/ZfM0xaNLB2Ga3fNY=;
 b=PZYrro6yAATVVGrqU9L6bfFsBLshH/EQoUBdXDtTCTZKqcHkWPUS07n5KxHNCwCbCd6PLUkwSpa1L+BLZqUy4uHeIyrNboMTQTDhlmRsl+MjkK7mZ6DgfTktavvJ7y5bYiRYalzEsq3ZgG9DpEYXYPPl1fQzkz89ghIX0iV7rDICIGo9MebuyTBcUivDsjgpiVmVRN7pQC+SAYRp6nEGFobhj+9ai/C/L0cWF5C/CbRljYdt/ga0kp35nM8MzgHDRXuKGteiNWXIM7q4bZY8n9RekXg3BHCchyzVaA+ghYhEx7PbJdMEQ3LzMuKgw6ogm2iGD0TvbePAKX2PHOoOag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vDpz3l5PQaCJAVmRxpFwXYyMtB/ZfM0xaNLB2Ga3fNY=;
 b=Sfz4BRHppxx0ZvfiIk+9nxSNUWXKARjtG1X2Eb9abve3QKbP+waxxKp8sykqXIiiEh+LOJmpdX3CHQ84+31G5bTiuOYIKpjaQZ4Zwvyoy+D425eToUevGP3qxSBMmD34t3jMPOcw8Bpi6mndjAp7VPpcy5vrTkLEo6uZulWhP6k=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4536.namprd10.prod.outlook.com (2603:10b6:510:40::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.22; Fri, 3 Sep
 2021 03:21:55 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%7]) with mapi id 15.20.4478.020; Fri, 3 Sep 2021
 03:21:55 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tor Vic <torvic9@mailbox.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung
 860 and 870 SSD.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq14kb24e97.fsf@ca-mkp.ca.oracle.com>
References: <20210901151643.13562-1-hpa@redhat.com>
        <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
        <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
        <238d0841-0f03-928f-5441-89d5c9dcf9b9@redhat.com>
        <cd75fa32-8c4d-664e-5adb-f2f325d3c58e@redhat.com>
Date:   Thu, 02 Sep 2021 23:21:52 -0400
In-Reply-To: <cd75fa32-8c4d-664e-5adb-f2f325d3c58e@redhat.com> (Hans de
        Goede's message of "Thu, 2 Sep 2021 22:50:04 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0154.namprd03.prod.outlook.com
 (2603:10b6:a03:338::9) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0154.namprd03.prod.outlook.com (2603:10b6:a03:338::9) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19 via Frontend Transport; Fri, 3 Sep 2021 03:21:54 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 4c959737-171a-4135-f5e7-08d96e89fada
X-MS-TrafficTypeDiagnostic: PH0PR10MB4536:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4536742ACF8DFC230FD39AB18ECF9@PH0PR10MB4536.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vOKh3SQTHObwVho7fmYGcPc/IIamdBT806m59e22bsRdkvJ1kxLGNQiogeEVzWlNI54gEIrshnNqoVU2LwpWtE3tnTNxXlmCDHERdMnu7AEhrzAr7aH6yZJUNW9I7UTnYtAyMCrRqt4TMOVSZ+cc+mimCFx25v01tAJQP51/10dcUqU+3Ha0SuXYjpvPVLheJHpr3QyhqOKBPd5hMb5Ou5+gr0puBqVnVaw4CIo75cokePXHi7jUJ1GdCqVX5nHyIn2/fM4t/fuIIOhXPyRY27iIvuBjixqZpMRMmHXl70AjzCwOFf1zC7xBCZGg+1kVDCXh9petDzPTVJpKHetUK6osPr7nVH2oJHZ1ArCTzK9cXB8aiaWDLGVxs503oko487TKjK8QmJsREHtRx+dkPMjnjG2dVaNsX0bKpWMS5fntF05tmX83Q34Z6DAQ+qf1dox1I1eN/0clyL/917RZLPN2yH+uFV2vV5GP7XeXWnXFxMro7eSCkRO8fM//bcBfTpRekZJyes8Vri99U7Pby7KTjoDxIA7e0JtC25lupo8eESWdA/CRQuEfBbj31WQrxk3/9bbfcP8UfFh5Sj9HI3PzeDkIVhtEvDiLY4LdyuKQXFNVBEkC6iX6dalE8TuEc3BPlqV3tErYamU2E1gLseAcyyLlxP6Y7z2RsJ8XFeeW8ygCl4Dshnu09k7jesRjzXzWQKyrCxPQjUFwASXmNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(376002)(136003)(396003)(39860400002)(346002)(366004)(26005)(478600001)(38350700002)(5660300002)(956004)(66556008)(66476007)(38100700002)(55016002)(8676002)(66946007)(52116002)(8936002)(7696005)(4326008)(36916002)(186003)(2906002)(6916009)(54906003)(86362001)(83380400001)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?F2DH+MIcOCdIPWO67EXJOeTaxOeqd3y7w9SaTsiimhmPtDUVdWt86msHrmsw?=
 =?us-ascii?Q?u0cpuI88H5827XuU/qeN38Nclowm8YkTzVlSvbTf/NHhbgHVPE1zNG3nqdPm?=
 =?us-ascii?Q?ClV8s4Ci34un6zv2c72Z1wNT7FDLLgTqn6zyg+MESyUBkxduqmpeoTTdxwuh?=
 =?us-ascii?Q?D31Y/EzE/DgfBKG425D2T4Ni1kgh3+DeCcApSyDHL5YR8WielDicz8zygVH6?=
 =?us-ascii?Q?H8jGvUUzqkVAeTyJZ30BVrK+c42PD/qFuf9j/tODmpaWOfNJKlbs6Uu7e+Ub?=
 =?us-ascii?Q?ywCl5e52Xcs0EGfich77ktCyoSpAJzoiyBQ8r0K+kiYRT4v0m8f3UmmsHGyD?=
 =?us-ascii?Q?5h7NBZ9WqQi1wRW/85CpIoefqwQ3kW5fMvZCZzNqU+RR34C17+Uf+OGnhJVg?=
 =?us-ascii?Q?9o94HiFI6VoqPXGO9tOxljMtQ54PvGpcet1RfsN1g8Nj1CcYYWcF96+OlwqF?=
 =?us-ascii?Q?hp3DsYI/FDhZ3gpAzU3LObZQKbThg6/eoRCJeD+Dc1Z018ZAhSn8MPLI2uTT?=
 =?us-ascii?Q?mzqUb+EzzEZ0P+j+lKCY8h88VJWFnQ6QgEaX/MurW56hNLBWRltu8us1VnfI?=
 =?us-ascii?Q?WU3EqPC8tTVaHWGoo6rNjmZ0d/iC1s4qAEm+hN725m2NUkQB8LEym00R4sfa?=
 =?us-ascii?Q?pc0GwaNcG5T818SeGJHCZUswjb+CKcrFOIcr657tl50xfNY+9aWTiVdOPhAD?=
 =?us-ascii?Q?UtemEhXicc9b9f84+lX7TghSrVgKFzvdtyRYbBV/v0R6P4vFeqIbUd7z8aYL?=
 =?us-ascii?Q?sHAKjBCvjhwLHSfWwRrExwhHZjDPD+pNrlaSk8PiQDoWNwHO/92xyuliX/h2?=
 =?us-ascii?Q?7MtYBFt+HctG9jAlPTPhQxM9p3d2XkoM64o3knhrK5hNUi4APwdyd2Yyj4Q7?=
 =?us-ascii?Q?xeAJVZLgteSsxwrUMlpPQ+tA/okPhTWJeqx09fYqdxPrSO2ymBM2chgFFu58?=
 =?us-ascii?Q?88uXNoLjyt5twuo0lXTNE76zeLt8sas16UaGY2lv7VIf1nyooAA0CEjdNmYD?=
 =?us-ascii?Q?qRy5Rc4PXaD9d9bnNamtaT3QxDikKnsBegK4sSvaiZeqJ4IXVmabPNTW8IOv?=
 =?us-ascii?Q?hRMgW/cK4jTXV6lNki2gPFvfSJoP0cXAYY7oPS8vbSQEziKLshgJLN8cIEGG?=
 =?us-ascii?Q?qpR5GsKiAcCdb1IZwmtGd7rws5tOwFlGwaUJ48lO0yg2HzAhIPMEImmaUwYV?=
 =?us-ascii?Q?1UiwRIlMBxPdbtw99mU5RDdLlNgq3fU7z1zr5siiK5nrJ65F28fCl6mrC0SQ?=
 =?us-ascii?Q?ZO+4ozvcCnclQqkJ1Dt4lz0rChPybgUMZSbPHbuKQplP87uB6t8WiUolkha9?=
 =?us-ascii?Q?VYqnucWTsYG5HI38eNefvOiA?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c959737-171a-4135-f5e7-08d96e89fada
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Sep 2021 03:21:54.9766
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S/PO83g3vPOWVJ5KvgrTfdaJFBQxrpnD9x4uQNn+5067CfyIh2PRiarzJaEIL+rCtNCCgICH2i9tE4TsCBXUdbVMxmocIas5OFN/xCMRFVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4536
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109030018
X-Proofpoint-GUID: raWx8D2buXa9zse8_Ojln-gm4n9Nkmd1
X-Proofpoint-ORIG-GUID: raWx8D2buXa9zse8_Ojln-gm4n9Nkmd1
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Hans,

> I just realized that all newer Samsung models are non SATA...
>
> Still I cponsider it likely that some of the other vendors also
> implement queued trim support and there are no reports of issues
> with the other vendors' SSDs.

When I originally worked on this the only other drive that supported
queued trim was a specific controller generation from Crucial/Micron.

Since performance-sensitive workloads quickly moved to NVMe, I don't
know if implementing queued trim has been very high on the SSD
manufacturers' todo lists. FWIW, I just checked and none of the more
recent SATA SSD drives I happen to have support queued trim.

Purely anecdotal: I have a Samsung 863 which I believe is
architecturally very similar to the 860. That drive clocked over 40K
hours as my main git repo/build drive until it was retired last
fall. And it ran a queued fstrim every night.

Anyway. I am not against disabling queued trim for these drives. As far
as I'm concerned it was a feature that didn't quite get enough industry
momentum. It just irks me that we don't have a good understanding of why
it works for some and not for others...

-- 
Martin K. Petersen	Oracle Linux Engineering
