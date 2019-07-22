Return-Path: <SRS0=rYxM=VT=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B3ADC7618F
	for <linux-ide@archiver.kernel.org>; Mon, 22 Jul 2019 20:29:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE31E218F0
	for <linux-ide@archiver.kernel.org>; Mon, 22 Jul 2019 20:29:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="BQIHYfZw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727647AbfGVU3n (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 22 Jul 2019 16:29:43 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:46768 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729511AbfGVU3n (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 22 Jul 2019 16:29:43 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MKTJgg165853;
        Mon, 22 Jul 2019 20:29:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=iYP91cuMUZs4/lDrYDsU4/c3z30iv2LaHlaIVaOSmhs=;
 b=BQIHYfZwlQhOGQsQNm7xpiBnRPGMQyOrmfkgGJ3pvhqBFCh2z2xabDEBtXGWmz88bK6T
 yLuYC+fxBPUA3Dus9vMlV9AKKSnjQVJvYB9gFM2IR70qxxA4riR/OxoS+eFl6nWM7VP3
 ncKNS18CHRaj/2KJAWTAOHVHLpCbd81xqOxN/pMYFV5UHxJk3rD3St8ob7pJRUoeCL52
 +QTO0jhD1WuG9X+ekuPwCfx47+ITdIr3axPF+sF4xNVr+GrRDS6kkiOA29x5evRNEKc4
 NCwDYbOmbd9unRwwIdhZu6yoS6rCW5c5CNmYZWLhbiqyifKqihSLMhTk+sPkKDfnFnD8 Ow== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2tutct9h1x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 20:29:35 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6MKRO6d150916;
        Mon, 22 Jul 2019 20:29:35 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 2tuts37bnb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 22 Jul 2019 20:29:35 +0000
Received: from abhmp0017.oracle.com (abhmp0017.oracle.com [141.146.116.23])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6MKTWBn012380;
        Mon, 22 Jul 2019 20:29:33 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 22 Jul 2019 13:29:32 -0700
To:     Roman Mamedov <rm@romanrm.net>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-ide@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        stable@vger.kernel.org
Subject: Re: [PATCH] libata: Disable queued TRIM for Samsung 860 series SSDs
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190714224242.4689a874@natsu> <yq1y30z2ojx.fsf@oracle.com>
        <20190715224215.2186bc8e@natsu> <yq1lfwuwwxc.fsf@oracle.com>
        <20190719103706.6f452ca3@natsu>
Date:   Mon, 22 Jul 2019 16:29:30 -0400
In-Reply-To: <20190719103706.6f452ca3@natsu> (Roman Mamedov's message of "Fri,
        19 Jul 2019 10:37:06 +0500")
Message-ID: <yq1h87du82d.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=960
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907220225
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9326 signatures=668684
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907220225
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org


Roman,

> What is the firmware version?

RVT41B6Q

> Also, do you have an ASMedia ASM1062 controller to try (often seen on
> motherboards for additional SATA ports)? That's the one I tested with.

I'm afraid not.

> With ASMedia only queued TRIM fails and everything else works fine. So I
> wonder if 850's queued TRIM issue in 860's case remains only on some SATA
> controllers.

Looks likely. In that case we will have to extend the existing trim
heuristic to match on controller as well.

-- 
Martin K. Petersen	Oracle Linux Engineering
