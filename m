Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MSGID_FROM_MTA_HEADER,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D19DC433EF
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 19:02:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 310D96108B
	for <linux-ide@archiver.kernel.org>; Thu,  2 Sep 2021 19:02:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233197AbhIBTDR (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 2 Sep 2021 15:03:17 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:6464 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230204AbhIBTDQ (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 2 Sep 2021 15:03:16 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 182I9Y5U027857;
        Thu, 2 Sep 2021 19:02:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2021-07-09;
 bh=MrSp4N5d2wRZ793jBTGTXRgVuKhqnKxu8wRyOpop0Cc=;
 b=dXSw3UPPm7M2dQu/+YtgeK9yIBaI0NLuOiP8JniFXmFzW4WvA/wSoyZiHDr8YHmm/ViS
 9yjmTIJPZZ1tauejnJKiVG7F5G8elN+SyH6o2Xm7Yqc+Wtr9vX3CFJyqkABkSStGDQ7t
 7xDxxcriuZ74vqMT4tLtdWZHm8faNonGhC3tWnSmGmwuPGsBasqiLoMj9VcpTOutgHs6
 yQpeE2AFQxKLWd0MOdNPSVM/3+FDfb/xp83/MkAFSpOmGZ+YC71HhdVIB+rugUHJM8wF
 1KrrtIU+Vt3L94d/RhxWhShiLLMqGkwSaTZ7WxdqpuKZ4X2cToDq/lT1cCkA7cHzYH7W 6A== 
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : content-type :
 mime-version; s=corp-2020-01-29;
 bh=MrSp4N5d2wRZ793jBTGTXRgVuKhqnKxu8wRyOpop0Cc=;
 b=hcnrlpYG4O1DnOFxgqeEKr8Gidoe8W9MzOQY4uJut+NU6dp98yn9uNySab3TydNxCJ8z
 DqrLm0w0StTzJDwSJABwwlODF0/kXWgUjtn6xlQkNxxuWVdxUY7//klaNBJEVTGeBoxz
 bVD6aiQG1m0+nXkczSdKoVSHJdxGA/kgmoCOdZOk8WuNVGvGqwbtup106iOMLcRR/4Bg
 a5nndzj+p1nQnOiPtxTfVTrPFlM80bljZ03TJuOtLsHC2nRbfzoRYgmuw/BQfNVbfZGV
 xsWxMZVTeFU/fE0IolST/P0Qnd4daEyd6Tzk6r1vyd+sxs2RLJ48GcTwz3P21f9UNHuA 1Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3atdw1bu2s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 19:02:02 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 182IuVaQ142636;
        Thu, 2 Sep 2021 19:02:01 GMT
Received: from nam11-dm6-obe.outbound.protection.outlook.com (mail-dm6nam11lp2170.outbound.protection.outlook.com [104.47.57.170])
        by userp3030.oracle.com with ESMTP id 3ate06a3m4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 02 Sep 2021 19:02:01 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iTqpKqn7KFbg19ndLeZw2nGgkOQiUNtGCTmAf0IAWIJrLM4EzdeXheasJ7+4vRnVVA2kLWFl+XyOaU5R1jrIXD0IzRAWcOBC3NzsSXRgZesIrndsRsT12BwRbEZ1KdhLL+g8vj+27fTU9txZEuym8jOjrqyUP/EfYtuOv9lD8gu4TfRTHeMgAeyS18vxdPoDnEV2XJcBFWfndZuHC25dzM/lK4iCm+qR+ZBRNsar+ASIz9weEMDtzHSo1ba+9sJUh+bYVZM+/1q+/1rWLcdTFkyubknmbAjxE43WPXMiIi1NATxNR9DeIaGW+dJMcOHK0J+rS+yWj0khjQIamxK/ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=MrSp4N5d2wRZ793jBTGTXRgVuKhqnKxu8wRyOpop0Cc=;
 b=hMNM9UlkpOYCZXtq5Dr6R70kLlVRRrOYd5lppIoIyVMQIAFPXJBUxwbE22TKGUZ1ZzeMVAeaxJNnLJLCgBJENq9uZhzOoKp1F3rrffWkq8/3sIZb0U23N4K0ckkKAtn9Zv+qk3ET1SC1TWHqGUxkRPCdmescg9Rc8wAPjtzpbq+x5+GlfG4FAzOXzM0cG8aLVMc9zrYvAxsBtQHyUt4sB0of1XKEAR1Z6wMLG54R78GAFFrq8vDHaKCIj5GmQ+hC8CuEJN1ZLPDnyjeOOLYqUTtPEVa4h6tIzcmKalyDpRQJdRx/FivILAbEIYb0dKUJgHxDRhKhFiIU+ggDZEfX9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MrSp4N5d2wRZ793jBTGTXRgVuKhqnKxu8wRyOpop0Cc=;
 b=JLZ5uGN0q9HSsWdq/3gVv5hG1X1z8bRUqk/B8TbQwsl0v9LvWl5RzxONlIR7Uj9uS5WYmet5SfSbHV/obcKfnwtSkBVIT5kuix9LwJEjbkjP5Ch6hGuq/qUE2Sej2UbflTUEdL/9/uWG3cIapCqdZ/+5VClJ9mNh4ixhz0JdL+M=
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=oracle.com;
Received: from PH0PR10MB4759.namprd10.prod.outlook.com (2603:10b6:510:3d::12)
 by PH0PR10MB4662.namprd10.prod.outlook.com (2603:10b6:510:38::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.19; Thu, 2 Sep
 2021 19:01:59 +0000
Received: from PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc]) by PH0PR10MB4759.namprd10.prod.outlook.com
 ([fe80::c0ed:36a0:7bc8:f2dc%7]) with mapi id 15.20.4478.020; Thu, 2 Sep 2021
 19:01:59 +0000
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Kate Hsuan <hpa@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Tor Vic <torvic9@mailbox.org>, linux-ide@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5] libata: Add ATA_HORKAGE_NO_NCQ_ON_AMD for Samsung
 860 and 870 SSD.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1h7f24y6f.fsf@ca-mkp.ca.oracle.com>
References: <20210901151643.13562-1-hpa@redhat.com>
        <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com>
Date:   Thu, 02 Sep 2021 15:01:55 -0400
In-Reply-To: <3e26e7a5-0d99-b993-d5ce-aa517e1bf1bb@redhat.com> (Hans de
        Goede's message of "Thu, 2 Sep 2021 18:07:10 +0200")
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:a03:338::18) To PH0PR10MB4759.namprd10.prod.outlook.com
 (2603:10b6:510:3d::12)
MIME-Version: 1.0
Received: from ca-mkp.ca.oracle.com (138.3.200.58) by SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4478.20 via Frontend Transport; Thu, 2 Sep 2021 19:01:58 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e3a16c01-ded0-4d1c-68a0-08d96e442424
X-MS-TrafficTypeDiagnostic: PH0PR10MB4662:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <PH0PR10MB4662DCB0C07D4C3BBFFCF1478ECE9@PH0PR10MB4662.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xPMcwBxmu6mqmZUXF247L040O3fdIpFd6z7meXsYdgOUKWCmkaMTRQWEde2h9rDmVdlkdPkTFqMFdlBUZ3MhC1VcRgA5mVOaXCLR9Lsy1R52xeafAYJcjxp9BGp+nkRmi0TcQ5ko2mdYtNF9MyiyOVEuQvypLx7rN/x/zYt7AYhe4rrQKYZQLxg9PaqVxvcuv8NEE8evDeahkla2z2/H8pXYemXTmmZyfIopW1qnr5ihY0MDrOUUsp9GbwA1wnHnVSU/Wb2uAwQEp3osex3AlQO4cp+c5oEQgoKLwA02vpb2Is6S/o8bMHaUzy5e00P+aj5KjYTpTGwore1NRPnsO7ubQDnzAXjcGC9fyNOwAOYxlivDxwy2RtgA3ISg9CEsYQYUXmeVXqbWlmFN70sYLAWpAdr5+1fV1P4ZWDD04Xd2f9yHFtJM0YiI6y52LteHMD9lwU1X0R65fxubo2AVVMn5L+HmKPHEg+UPsaVylm8oJpDT7sF6v1swBE4qjh+/37nAST7ZSNhWYNfh90peTaxzGXmMN2LD4yro3m4SYJBRlS8KuIh34kIDtN0Hbtc5ksiPuA4Hzox9Qtf/jN2+qVpLWv1YK0iKMD3qaRJ2ZnB54c09ta9lUITimSSt5qmoe1gmayxMuJrptINAyNtoqA55gUAxkAgWXwy1YEYEWTcACjIbRjViLYj46CaSo+Loi1/KMe3ukSwmz9RzhY5bbg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR10MB4759.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(136003)(39860400002)(376002)(396003)(346002)(366004)(2906002)(478600001)(86362001)(4326008)(38100700002)(52116002)(38350700002)(36916002)(26005)(7696005)(186003)(316002)(54906003)(956004)(6666004)(66476007)(6916009)(8936002)(66946007)(8676002)(55016002)(5660300002)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?PMNTYdB+bMMQMza2cB8DtG8Npy6/1lavy3mSH2qzm50amSlhJ6S/8yGwxRyP?=
 =?us-ascii?Q?3FZytvqJgc5ZSqYnU7TnVGNO7VQLuYVZCCHL+TL+sttIUAw3SzvN2Ga2m2jF?=
 =?us-ascii?Q?K7MCOK9NZhPZMLHlsmVCGicIVnpn1DX7Ss14HQvMQrN8a7CfhoIwViLzhDsx?=
 =?us-ascii?Q?CY/h4/NbemMDJAFD9MkZqRiEhEJw5bXch//Gf+Hl7NOFcipQ6WM/bPuPJ3pt?=
 =?us-ascii?Q?yhLh0miEYVPsa5i9vjOcCs2Cn+Xt3vQpkYhu2UtT7nM2fpCmUnX35XE8pPlJ?=
 =?us-ascii?Q?LnRzJ9oDrK7phlXFHzkNKs9TrWU70+7B/ZssGrFGixHckIpjfKIOtyTUNn49?=
 =?us-ascii?Q?Gb9dmMk600Rn9PjySHzfGkTDCZahHwORXhS1n3qk3SprMYXurQ/YeREumutf?=
 =?us-ascii?Q?rR2lARDbOcrJ9il35lFK75AQHTQf2PYvrgziCFM+QOWdVmwVuboM5jKv5CXh?=
 =?us-ascii?Q?obJYk+YjS+kTvNOURlMRsu4qJMw26Lh4p5akxccw9kbXsL38Wji+xnuy8FUV?=
 =?us-ascii?Q?UOVdkA3qwwsBz3tvljh0dnAzL8B6eyr7sd6p+y4rOTDm2nk57Qn9HJGLELsh?=
 =?us-ascii?Q?G9HapD9UAzKFDUqHVVX3wWzAT8/QbjwxyFuX6FdKpRHSzDILTUcartuix5Sk?=
 =?us-ascii?Q?G2KvDbnY2BezRCOyHrfFT2LFDsnxX1ki+b+OrI7z1SBiPQm7riBOY24otMnY?=
 =?us-ascii?Q?7a4jHRkmZl3BZRZEI9LBlBsLrXVltkKE/uak6n44et+YuN7CglrWLAL4oEVZ?=
 =?us-ascii?Q?wDEtzwxv4fcg1SRPneGHw6lPQiRLTPOz55D++dhxX05O2nmUeNq6Mdr5B8uG?=
 =?us-ascii?Q?V7F7BrrTOwGVwAoBorNmWEgM03d5AsPwOA/cD+mShn5rd2FMobH6bQ04ujQM?=
 =?us-ascii?Q?Fkq4HfchKU2T32L6RzPQ/E37KMipXBg8NTFJzEgB+RfHQqN+Pt1t1rfJc3Gv?=
 =?us-ascii?Q?VNUQhn/t4sWbHzr+VFB7YrbVmoBJPPtidho6Lse+fgCLjEraLwmd0VRM/zVc?=
 =?us-ascii?Q?UrXFY/LRQpd2PvKKvHVcqXlvv96CQcq4qmUoEOrP4A/fWBcFWvB6foc7cMXQ?=
 =?us-ascii?Q?1BcRs2Lsl28IxbVpy1CmTXRD54mHNHovosHvNj994PPn2LvdqIN/wUw8tk7X?=
 =?us-ascii?Q?ZfOA+BjMuhD7t7y95lWM1SkkckrhIe6yJebshpsj56vQY3aYvKWMEaIBgH4v?=
 =?us-ascii?Q?lfgXqfTZtEbXHmH1xXpY8bPAusU14Q6SyW/4Ecn3toX+mSGbqF4ziEWu2v/n?=
 =?us-ascii?Q?5zNi0VnE6JmjMnzYY3gt0PX3msh8A4XICyHP3m2Spl+zXr7AFP7Yt951b4Wb?=
 =?us-ascii?Q?DeB6YQLCKAlUehBjfm1LvOza?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3a16c01-ded0-4d1c-68a0-08d96e442424
X-MS-Exchange-CrossTenant-AuthSource: PH0PR10MB4759.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Sep 2021 19:01:59.3828
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZNE1TOx4YizobCqkv25/pNndTFdphaPlitQp2fSYEU9TvWSRYUR0jRyG5xMemh7K5OZ2RliK3mv3tT67fp6ScTkgwQX42ecfJ80Fg8AYDdI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR10MB4662
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10095 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 adultscore=0 mlxscore=0
 phishscore=0 malwarescore=0 suspectscore=0 bulkscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2108310000
 definitions=main-2109020107
X-Proofpoint-GUID: rGhBavdvrvL1H-sojpSuiPaAK8EmNV71
X-Proofpoint-ORIG-GUID: rGhBavdvrvL1H-sojpSuiPaAK8EmNV71
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Hans,

> So it looks like we actually need to disable NCQ for Samsung 860/870
> devices when the SATA controller has a vendor-id of PCI_VENDOR_ID_ATI
> rather then AMD.

That's another great data point!

I wonder if there actually is a Samsung problem (given that these drives
work fine on other controllers). Or if it is just the queued trim
handling that's broken on 1002:4391 controllers from ATI.

When I originally experimented with queued trim I had systems I could
not get to work. But queued trim worked fine when the same drives were
connected to more modern chipsets (note that this was "did not work at
all" as opposed to "randomly corrupting data").

Do we have any evidence at all of queued trim working with non-Samsung
drives on these controllers? Not sure how many modern SATA drives
actually implement this feature. Maybe the reason we see Samsung drives
in the bug reports is due to a combination of popularity and the fact
that these drives actually implement queued trim support.

> So lets wait a bit for some more info to become available and then
> I think we need a v6 with s/AMD/ATI/ (everywhere, also in the name
> of the horkage-flag, the cmdline options, etc.).

Sounds good!

-- 
Martin K. Petersen	Oracle Linux Engineering
