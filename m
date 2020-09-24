Return-Path: <SRS0=07Tt=DB=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84002C4363D
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0617E2395B
	for <linux-ide@archiver.kernel.org>; Thu, 24 Sep 2020 11:22:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="DLsznSWR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726617AbgIXLWy (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 24 Sep 2020 07:22:54 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:35758 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726465AbgIXLWy (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 24 Sep 2020 07:22:54 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200924112252euoutp01da373cae4de32ecb5bb4ffe501beac82~3tG0FK9pu2096620966euoutp019
        for <linux-ide@vger.kernel.org>; Thu, 24 Sep 2020 11:22:52 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200924112252euoutp01da373cae4de32ecb5bb4ffe501beac82~3tG0FK9pu2096620966euoutp019
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1600946572;
        bh=1HVgujXL6+VFHAinjipBTSMhpDiAZWzmTesRTiQUnYE=;
        h=To:Cc:From:Subject:Date:References:From;
        b=DLsznSWRI6mXxbNlOe8NdYt5RqPV9zoRdtTInzW17/lh5T2+rn8eHnF4Ivpdb72cU
         CNANoOa+JIBK6WQ9lJrDiGu9yHuyabTurZoDogl3M1SsXfmtukaTa2o0BvFGfGplRf
         WkM7+1D2OqTMuD5W6+ch/ZCQhZ3j/nEAwRbjivlk=
Received: from eusmges3new.samsung.com (unknown [203.254.199.245]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200924112252eucas1p2fb6d4757dff7fa9643fd533149b49ab1~3tGz6Q8hm2922129221eucas1p2X;
        Thu, 24 Sep 2020 11:22:52 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges3new.samsung.com (EUCPMTA) with SMTP id 12.E7.06318.C818C6F5; Thu, 24
        Sep 2020 12:22:52 +0100 (BST)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200924112252eucas1p2e372d1ce6d6f8cf8106572adeb200fee~3tGzkec1U1794217942eucas1p2X;
        Thu, 24 Sep 2020 11:22:52 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200924112252eusmtrp1348420c81288c5e35fabede0444b26b0~3tGzj5E-e2014820148eusmtrp1f;
        Thu, 24 Sep 2020 11:22:52 +0000 (GMT)
X-AuditID: cbfec7f5-371ff700000018ae-26-5f6c818c004d
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6A.75.06314.C818C6F5; Thu, 24
        Sep 2020 12:22:52 +0100 (BST)
Received: from [106.120.51.71] (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200924112252eusmtip18983928ef9ee893900e3033b552c28d3~3tGzYZA3a3166431664eusmtip19;
        Thu, 24 Sep 2020 11:22:52 +0000 (GMT)
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Subject: [PATCH] MAINTAINERS: remove LIBATA PATA DRIVERS entry
Message-ID: <1c6cdd00-93a2-55f7-9494-1c0058de384a@samsung.com>
Date:   Thu, 24 Sep 2020 13:22:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
        Thunderbird/60.8.0
MIME-Version: 1.0
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpjleLIzCtJLcpLzFFi42LZduzned2expx4g5M31CxW3+1nszi24xGT
        xeVdc9gcmD0uny31+LxJLoApissmJTUnsyy1SN8ugSvj2PFpTAWLOCo+HlnN1MDYw97FyMkh
        IWAiseLMfbYuRi4OIYEVjBL3Vs8HSwgJfGGUmLYyHiLxmVFiyrXLzF2MHGAdLZfdIeLLGSW2
        nljPAuG8ZZQ4+38ZC0i3iICCRM/vlWwgNrOAtcTW1mlgU9kErCQmtq9iBLGFBewknk5ZzwRi
        8wLZe3q+sYLYLAKqEtuPLwCLiwpESHx6cJgVokZQ4uTMJywQM8Ulbj2ZzwRhy0tsfzuHGeQI
        CYHHbBJXr/yG+s1FYtWUTkYIW1ji1fEtUHEZidOTe1ggGtYxSvzteAHVvZ1RYvnkf2wQVdYS
        d879YgP5mVlAU2L9Ln2IsKNE3/9b0KDgk7jxVhDiCD6JSdumQ4V5JTrahCCq1SQ2LNvABrO2
        a+dKZgjbQ+LSyz3sExgVZyF5bRaS12YheW0Wwg0LGFlWMYqnlhbnpqcWG+ellusVJ+YWl+al
        6yXn525iBKaO0/+Of93BuO9P0iFGAQ5GJR5eDt3seCHWxLLiytxDjBIczEoivE5nT8cJ8aYk
        VlalFuXHF5XmpBYfYpTmYFES5zVe9DJWSCA9sSQ1OzW1ILUIJsvEwSnVwHjhSvozfRWnhD1/
        pLSn9vxL7jv5aMPXz5EZxw6skNRpU4iwdnqVl9Ixdevx0w6nF+wwUPnq5aPRf2zzUV+1HZ+U
        paKk7hxRyPgYrJBx2fPYUYVZBucehm7rC7TWCRa9/0bgcewupmb/T3IrAvqW3SlO7vbu0Txf
        usel97zBo9/sb779WKB6zV+JpTgj0VCLuag4EQBhaKAYGQMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrPLMWRmVeSWpSXmKPExsVy+t/xu7o9jTnxBh+mCFusvtvPZnFsxyMm
        i8u75rA5MHtcPlvq8XmTXABTlJ5NUX5pSapCRn5xia1StKGFkZ6hpYWekYmlnqGxeayVkamS
        vp1NSmpOZllqkb5dgl7GsePTmAoWcVR8PLKaqYGxh72LkYNDQsBEouWyexcjF4eQwFJGieXT
        HrNBxGUkjq8v62LkBDKFJf5c62KDqHnNKPFh+k42kISIgIJEz++VYDazgLXE1tZp7CA2m4CV
        xMT2VYwgtrCAncTTKeuZQGxeIHtPzzdWEJtFQFVi+/EFYHFRgQiJwztmMULUCEqcnPmEBWKm
        usSfeZeYIWxxiVtP5jNB2PIS29/OYZ7AKDALScssJC2zkLTMQtKygJFlFaNIamlxbnpusaFe
        cWJucWleul5yfu4mRmDgbzv2c/MOxksbgw8xCnAwKvHwcuhmxwuxJpYVV+YeYpTgYFYS4XU6
        ezpOiDclsbIqtSg/vqg0J7X4EKMp0EMTmaVEk/OBUZlXEm9oamhuYWlobmxubGahJM7bIXAw
        RkggPbEkNTs1tSC1CKaPiYNTqoGRx8aERanl5vmMrLvtnrqfDrkYx9QfyRSfsp3Z9dRCjawe
        s/hpl/f9y56xpyJMzSlY9N7FhIszDBsyL/6raLy+Z/K5y347Znh3XW0L2CE+d3FS9/HubUs3
        rWIp3zTtrkd//Ns7F3cuvXb7e+g0zuj/3Nq+Qme//MqLE9UOzjnvNOlLT5PVm8MWSizFGYmG
        WsxFxYkAepmCfZICAAA=
X-CMS-MailID: 20200924112252eucas1p2e372d1ce6d6f8cf8106572adeb200fee
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200924112252eucas1p2e372d1ce6d6f8cf8106572adeb200fee
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200924112252eucas1p2e372d1ce6d6f8cf8106572adeb200fee
References: <CGME20200924112252eucas1p2e372d1ce6d6f8cf8106572adeb200fee@eucas1p2.samsung.com>
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Even though there is not much happening for libata PATA drivers
I don't have time to look after them anymore.

Since Jens is maintaining the whole libata anyway just remove
"LIBATA PATA DRIVERS" entry.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 MAINTAINERS |    9 ---------
 1 file changed, 9 deletions(-)

Index: b/MAINTAINERS
===================================================================
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9912,15 +9912,6 @@ T:	git git://git.kernel.org/pub/scm/linu
 F:	drivers/ata/pata_arasan_cf.c
 F:	include/linux/pata_arasan_cf_data.h
 
-LIBATA PATA DRIVERS
-M:	Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
-M:	Jens Axboe <axboe@kernel.dk>
-L:	linux-ide@vger.kernel.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git
-F:	drivers/ata/ata_generic.c
-F:	drivers/ata/pata_*.c
-
 LIBATA PATA FARADAY FTIDE010 AND GEMINI SATA BRIDGE DRIVERS
 M:	Linus Walleij <linus.walleij@linaro.org>
 L:	linux-ide@vger.kernel.org
