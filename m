Return-Path: <linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46E0FC433F5
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24CDD60E94
	for <linux-ide@archiver.kernel.org>; Tue, 12 Oct 2021 06:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233005AbhJLGi5 (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 12 Oct 2021 02:38:57 -0400
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:26016 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232340AbhJLGi4 (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 12 Oct 2021 02:38:56 -0400
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 19C5gnPM017600;
        Tue, 12 Oct 2021 06:36:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=hrtxN5T5DYk3Npm6rCKy0dJQ4Sorb9LnPmW3EsAgRqQ=;
 b=B7QWPYaFtnuA6uyJbKrQ0o600Jf+24+Z+UWl9UmMr1xrUt1WLC5v5yvKAQ6WMrokhcUU
 11pYXe10TiZFCBbIJIWOCZ40oBbSK/VzRnppiFMRzQ534LSDUTAYuje2wovyRxX8mdYA
 aYCOBRds4EAiTz0ezX2RtNctsM21XeriaGhgdqiytOzYnE6k74ow1AMjab62EZvYBZd8
 GCf7dXjTfhME2mDZZml6JH+5MmL07ysqw+CcypyTimeZEQ0wNbYi/DFZUgDFp9xt2vqr
 T77C1WQQ+7LLZbA0lNp0HKwUqfAMoTK5PBnIjYQ281VyyP6wdFPg/9XcyvERZQDcZuQK Og== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3bmtmk3j5t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 06:36:36 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 19C6Z5vl093225;
        Tue, 12 Oct 2021 06:36:35 GMT
Received: from nam04-bn8-obe.outbound.protection.outlook.com (mail-bn8nam08lp2043.outbound.protection.outlook.com [104.47.74.43])
        by userp3020.oracle.com with ESMTP id 3bkyv9kage-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 Oct 2021 06:36:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FsAOYgcVuXdpFCYrLjXMezXZTpyxbSbtXoxYbpFfA/ZtZ69AJbyQdAZ1Pphb1enN1uqNLDOeFDSpIN1o5B+UEQLCDenkGrpw+nd9erOahiNvvtaimN3xJOAHu3DvwkJm4zAW03nODKBlY4oBSjfH5kMlywiR1eGUl75WULvEJjEB+xKKVUP2F1mpOPhbzNpgLzOraoevTg/plMEUjgmifu9IGQk/JbYwtE71JWNldg8vKA+/ryGzw7xmxyoa3ulVxKPsNdIxNmgS6vxyR/SjTgyPQHAyXlqFrHHfCQ+Bero9rpj2PM1O50Q4oqu3blgFabli+HfQr8/h6C7bLYSk3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hrtxN5T5DYk3Npm6rCKy0dJQ4Sorb9LnPmW3EsAgRqQ=;
 b=GCed2NdTlpcN2YIifnUGZXUI/AZkMKXGmAvXSRCoIQqiDe+U0x9spBAE5dKYeNtAhOcPfyc6uOOGwRduOpY0cF9UCAtTjsCs4cmzSwIGhIVyVC3e5og1Il32AgiyGrFGi/7y6bzjOavdkCltmjWaDrDgdGia6cbjrYuihmffBWmDsiFUrl8APmJK9uYaq+A4aai6Ymi0pHgV9dxMJyi1jCPrX0HfukVEhzSInHe/RQlkoeIOfXe/ZpQUsKu3vpTYzsSdRsP7WAFvSe9EmoZ3WCc/HSaslkM0ZrK5utw+cmYnCIByMi9ObBQKHmiQcusLjLofDsvwcuKjsWA1W8HSCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hrtxN5T5DYk3Npm6rCKy0dJQ4Sorb9LnPmW3EsAgRqQ=;
 b=IHZKRo8mxFwzHfNbT0Naq68V75q18u5G175SOjmv8A8kg8aOBaO8cJQUiHlVhgDLJawZ8Nyb6Bkiv70HOLWWf+Gl94LAVV+FrUL8LMy2ObRMkLB/Xne8yLvXkaqCPyyRVOds2RQY1eDX0TZmeYIBKEwuIOKKA/m8KagQdZb55eg=
Authentication-Results: opensource.wdc.com; dkim=none (message not signed)
 header.d=none;opensource.wdc.com; dmarc=none action=none
 header.from=oracle.com;
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR1001MB2320.namprd10.prod.outlook.com
 (2603:10b6:301:2e::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4587.25; Tue, 12 Oct
 2021 06:36:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d409:11b5:5eb2:6be9%5]) with mapi id 15.20.4587.026; Tue, 12 Oct 2021
 06:36:33 +0000
Date:   Tue, 12 Oct 2021 09:36:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
Cc:     Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>,
        linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] pata_legacy: fix a couple uninitialized variable bugs
Message-ID: <20211012063616.GD8429@kadam>
References: <20211006073419.GC8404@kili>
 <9dc07497-050d-1562-70bc-68daa460da67@opensource.wdc.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9dc07497-050d-1562-70bc-68daa460da67@opensource.wdc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (62.8.83.99) by JNAP275CA0037.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::7) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4373.18 via Frontend Transport; Tue, 12 Oct 2021 06:36:29 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 995166ff-5b2e-400d-e0e2-08d98d4aa1f6
X-MS-TrafficTypeDiagnostic: MWHPR1001MB2320:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <MWHPR1001MB23200D9232E603A3BDB9CEAB8EB69@MWHPR1001MB2320.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:4502;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: PBQWJWCQIX0GDanNgHXwld2Lj2wZwXnsPnrKVLdinRofvPNPG00WuPzHZUrs12Y63MkTU5BhTBmq1Bj2oUzx+3dj26FzqFemLx9bpw3XzfWAA+R1CV5d2+Iu/XDBCAU9cO0zMiUYKyBV2wJcimQNryetlJMoBl13RiCe1myzofFpk4AWDsPe/29U3RMxA0V9BYYFVX+EEa6vsssl7HRn5Fad2B40Gzw4OSWLK5jY5R7y3M+MZqTPy3UZwh7+wkbdKHtWXNwaxbQsXa54uOlNjFDATEjejihyqOFYAg/zLRpJ6XrZPRpB46Ak4Xg3Q6EoLi/Ss97R6pKvnn0CJmS/aywqx2ZhAww9n9RvJkDehypibYizjc6CTdisFUPnzMKH5aRpE6PWUAnjhDQUze4qiCJ6P3VZxB4Z4aNwjqSPRsPVXuUO4oUyTZNubFy4MUR3WmJgskKMk5jO+S41LWtKmJnUZT24gv5714MF4wbdI8uC+cFkueEbJnVZ6DzBatVl89PmNw9tlA/Jgd0Y/tr01XzGPcigf/PlYgZKoLmIDzyvH0VFsShDGUSE2yecgiy+KLWPsejB1o1NmCm3B84niBBt9nTVH0QDDGrEsRjD1PjYSwNB7tZzjAh52mm4C62V2+ufh0FNMCBz4tAdxI+i4xidO4t8HW/t6Ew+NrrHX4lwzCS4Sq81aiMKwXtXcOqd1W3ft7cxaxpo+zX1AQEcdg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(38350700002)(6496006)(38100700002)(55016002)(9686003)(33716001)(52116002)(508600001)(8676002)(8936002)(1076003)(5660300002)(44832011)(33656002)(86362001)(66946007)(66476007)(66556008)(186003)(558084003)(6916009)(4326008)(54906003)(9576002)(6666004)(316002)(956004)(26005)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?gYLv+f2WnC6Z1NNP6X3HxcEu21w0G10/kI+JMm2h+1yp9UyhEwu+AI2QEAZf?=
 =?us-ascii?Q?s8rAy/YIIzZR4tvydWLNfSFMsoslJ4sAbsyf3GMx4FGwJxxXamPQNJZYQj26?=
 =?us-ascii?Q?Be9qJNWcZJusHO+1lqwU9/fILni1nKO+pZNkm+FhiJmKCu8d2yxUsYFYUwEe?=
 =?us-ascii?Q?nzbl33CAawja33FBkLyCguSr1oZTIKSAQPo3FSGr2ukITWR3dtjrulRCIU3p?=
 =?us-ascii?Q?70aXppJZ/1A3IV8arL6TSkPkV/JH415ErsNYKLAYfssN0nLB0HilGw2EriY1?=
 =?us-ascii?Q?vugyU8HtZQoP3yPM2AYdcUckrmH76uokmBuhia1Zy9EnyfRZdhTg1/odOXQJ?=
 =?us-ascii?Q?V0QNCD+c09JnxljBOeEx5pRZkd0rM3hbZnVEw7/bITI0uiOzUXyClmi8yH66?=
 =?us-ascii?Q?mNtwKe1J5QxreyGamOoaTx1+MvR2ueFfHLdnIuXR2Lfa+Y62xrHemtS/mnLM?=
 =?us-ascii?Q?mTxgq/8ni0rMb40lUnOoC7VffMNMFA3sXJ8sCuYlSGNoiJDoCK/JL/WFRTHu?=
 =?us-ascii?Q?woIXo8/vLNFfw2wdciBFgbPXZEThR87jZ/AK1OOcHXGPKo3Giz+B3UNbw/ec?=
 =?us-ascii?Q?9I2nsgV06Q9TTDlPygu94hFmsBf2N9r4zhAy5gbCu/Y0XObP7nfCeA8CagnX?=
 =?us-ascii?Q?zEONHx5NcTKzTcevLszTfUvchoqkCjR6VMO1IY4nnZ5Tfq/cx0NiFxuWTU3O?=
 =?us-ascii?Q?WXCDFYUN9zM/4oAu3F38qoPgZQm1utC0PQVwDHwOGOpXojbWA+j++/XufBkZ?=
 =?us-ascii?Q?r1pD2+8eMEB9DzvPNJMmap5stbNzZZ4jkpC/Xv/J0cad0qYKv9I1q8Y4bukY?=
 =?us-ascii?Q?VCdZiPsf19dQnMqr5/AB36yusoni0bWWJX9FkVWeyUC1LWiCcHgDjyHZ4TqU?=
 =?us-ascii?Q?t4ymFheq4P0OYhBC0t+YTRSQE6hWm2evALD9KgPxV40m0olzhI8Mmi1lNUo9?=
 =?us-ascii?Q?tXT5pvSA7p0k1EbghXOo+PhO9ZfnywMLxMMrD/u9W6IkSiMDZ+DDUu8nMW29?=
 =?us-ascii?Q?k5DVKwvjtrDPITJWohIFlq5kI+r/HFptIWtpKKMOmr9rF+lcuhyBWxO4XwK0?=
 =?us-ascii?Q?Sn217MfqzTQc+V5pvCl6jbtF6pDE7/d/D4XQNePryFQes/LF+fpHsizZz6ke?=
 =?us-ascii?Q?GAGLGRRdOZsKWMgDhLBJ4apUfb85cYDD1dcDlz2/o04CApIFZHwievNr4jGO?=
 =?us-ascii?Q?RlfkQHsNJ3BxAKcQzPmgk+eujACxT7YlLqZrQ9ofWyU+nfVGhLbhpPO+sWUT?=
 =?us-ascii?Q?HXL+tv3Zx5UKsMNTPLPZb9b2a8fyydQuVm/UwCeqvIfLMMPkAlWGcUsskLpL?=
 =?us-ascii?Q?iLyFoSjetczkqxMXiQEiqm7Q?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 995166ff-5b2e-400d-e0e2-08d98d4aa1f6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2021 06:36:33.5672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v/iPJ+ReYdFor9VBp0uKQWGNBgIyAnWGpWxLATCeM5tVfvB1/pyTKVKlSI1WOAvrryApKb5B+hYERXZP7jVWAheettht3rOaqspmWPHUnYk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1001MB2320
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10134 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0 mlxlogscore=635
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2109230001 definitions=main-2110120035
X-Proofpoint-GUID: y9GjHTivoiz7K-JTg-UI0ZdEO97C1wQb
X-Proofpoint-ORIG-GUID: y9GjHTivoiz7K-JTg-UI0ZdEO97C1wQb
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

On Tue, Oct 12, 2021 at 09:54:49AM +0900, Damien Le Moal wrote:
> (Note: I added a blank line after the pad declaration to follow kernel
> style).

I wanted to do that too, but took the more conservative approach.  Thanks!

regards,
dan carpenter

