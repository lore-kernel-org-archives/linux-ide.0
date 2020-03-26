Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62B8C2D0ED
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AE8D220B80
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 15:59:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="LUgLDR4k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728554AbgCZP7p (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 11:59:45 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58909 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728535AbgCZP6q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:46 -0400
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155845euoutp018542bfead9f209ea42cec8569928e6fe~-5dueW6bH2919829198euoutp012
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:45 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155845euoutp018542bfead9f209ea42cec8569928e6fe~-5dueW6bH2919829198euoutp012
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238325;
        bh=KXPBOA8pCdCfmyYS49/G6CL0wSa+ocM7OXVKPEDaw7w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LUgLDR4k8rhcOgD9WIdMbUsp0pdPx4/SmGNToGZCALgItdWfwChuYGwLADnl2utv6
         okUSdj90apxvFnujjYupnZZWZiTGxKBvutHXbOrN0Nvp6tEUnzYPIYnK0JKtyldhnD
         sSSz4BIDuo73cDETj/RtYcWswpogBWWYAfRmXyME=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155844eucas1p1d0c24d700b8e96885f18740e39408e99~-5duKA_7f1223212232eucas1p1m;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 96.E9.60679.431DC7E5; Thu, 26
        Mar 2020 15:58:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200326155844eucas1p264f9d573deb8bf9019e2e2d5cb59472b~-5dt4bdoe3015130151eucas1p20;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155844eusmtrp1c3a7b7077ff73e4d55d022fc17a6b023~-5dt32P0F2091520915eusmtrp1O;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-cf-5e7cd134b4b5
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id DD.5A.08375.431DC7E5; Thu, 26
        Mar 2020 15:58:44 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155844eusmtip1d21478cfb0f4b7262b83c3afa75415fc~-5dtax9Lg1506115061eusmtip1z;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 15/27] ata: let compiler optimize out ata_eh_set_lpm() on
 non-SATA hosts
Date:   Thu, 26 Mar 2020 16:58:10 +0100
Message-Id: <20200326155822.19400-16-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrPKsWRmVeSWpSXmKPExsWy7djP87omF2viDHY/N7NYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBmrOzeyFnzhrFjzfjVjA+MH9i5GTg4J
        AROJCd1tzF2MXBxCAisYJWbNmQXlfGGUmL5oPRuE85lR4vvnqXAt765Pg0osZ5S487ubFa7l
        wqppjCBVbAJWEhPbV4HZIgIKEj2/V4J1MAu8Z5RYMWkvC0hCWCBW4uSRP2A2i4CqxMubK1lB
        bF4BO4nbJxewQKyTl9j67RNYnBMovnzdfGaIGkGJkzOfgNUwA9U0b50NdriEwDJ2iX2PF0Ld
        6iJx6dJPKFtY4tXxLVC2jMTpyT0sEA3rGCX+dryA6t7OKLF88j82iCpriTvnfgHZHEArNCXW
        79KHCDtKTH39iRkkLCHAJ3HjrSDEEXwSk7ZNhwrzSnS0CUFUq0lsWLaBDWZt186VzBC2h8S/
        jS+YJzAqzkLyziwk78xC2LuAkXkVo3hqaXFuemqxUV5quV5xYm5xaV66XnJ+7iZGYDI6/e/4
        lx2Mu/4kHWIU4GBU4uHVaKmJE2JNLCuuzD3EKMHBrCTC+zQSKMSbklhZlVqUH19UmpNafIhR
        moNFSZzXeNHLWCGB9MSS1OzU1ILUIpgsEwenVAPjlEVHJtgu702V5blilbUywYzV/9vlC9O8
        n83yMrK852B1nT2cQaBDPf1eS1D93I53GtvXPAg4NKfirYh3X2sOm4ikfWuVdXe69noxN67d
        vF07xd/cenmuZ2m89fGz17awmoVlPPgaNbNyv0Vqad739fOer1QLsPkVutcxuvqc7KkU7hU7
        zm1SYinOSDTUYi4qTgQA662WOkIDAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xu7omF2viDG48V7BYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehmrOzeyFnzhrFjzfjVjA+MH9i5GTg4JAROJd9ensXUxcnEICSxllOhY
        vJOpi5EDKCEjcXx9GUSNsMSfa11QNZ8YJQ5u/cYGkmATsJKY2L6KEcQWEVCQ6Pm9EqyIWeAr
        o8TSSd3MIAlhgWiJvZPmM4HYLAKqEi9vrmQFsXkF7CRun1zAArFBXmLrt09gcU6g+PJ188F6
        hQRsJRZ/+cAEUS8ocXLmE7B6ZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYMRsO/Zz8w7GSxuDDzEKcDAq8fBqtNTECbEmlhVX5h5ilOBgVhLhfRoJFOJN
        SaysSi3Kjy8qzUktPsRoCvTERGYp0eR8YDTnlcQbmhqaW1gamhubG5tZKInzdggcjBESSE8s
        Sc1OTS1ILYLpY+LglGpgjCs6YtLFfzTR/fKiookOVwwKZxVfe79idjKHm+Ynu69x3V87mhXi
        8tWkfk+8vc7i++TAJUFVjoKbpi1ZfWQi9yr9d7s72YXUZr8uN39gas77vOpo9TyvS8WBYunP
        Xk7dpJSfrtWx/sPCDJ5PJ+a+5b8i+k4i57mu+LpZAoF7n/9/Ifln1gxpDiWW4oxEQy3mouJE
        AI/b2ZWuAgAA
X-CMS-MailID: 20200326155844eucas1p264f9d573deb8bf9019e2e2d5cb59472b
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155844eucas1p264f9d573deb8bf9019e2e2d5cb59472b
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155844eucas1p264f9d573deb8bf9019e2e2d5cb59472b
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155844eucas1p264f9d573deb8bf9019e2e2d5cb59472b@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Add !IS_ENABLED(CONFIG_SATA_HOST) to ata_eh_set_lpm() to allow
compiler to optimize out the function for non-SATA configs (for
PATA hosts "ap && !ap->ops->set_lpm" condition is always true so
it's sufficient for the function to return zero).

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  17353      18       0   17371    43db drivers/ata/libata-eh.o
after:
  16607      18       0   16625    40f1 drivers/ata/libata-eh.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/libata-eh.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 04275f4c8d36..8dc33b6832f0 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3443,7 +3443,8 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	int rc;
 
 	/* if the link or host doesn't do LPM, noop */
-	if ((link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
+	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
+	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
 		return 0;
 
 	/*
-- 
2.24.1

