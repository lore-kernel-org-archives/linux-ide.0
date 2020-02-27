Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 785BCC35DF9
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548D3246AD
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:23:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="CBv7IIa6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730712AbgB0SXm (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:23:42 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39762 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730960AbgB0SWr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:47 -0500
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182246euoutp01b7115642b3ecb431206c9e3a0d790c70~3VXe0z2Kg1368713687euoutp01V
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182246euoutp01b7115642b3ecb431206c9e3a0d790c70~3VXe0z2Kg1368713687euoutp01V
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827766;
        bh=aHu8VSvz6Jo5mCNhfIdaPkPjkQbwXXjvZKwXq8fNubM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CBv7IIa6CBA22ehBFXmqz4iiJL0K7bBqDPJK2EXAPkwIDUhMcNjPO1e2TgoEh3vRA
         Xew5aIfTWsgPphajgn1WaNn/8cc3y1gC0ZuxUsDofjrC7RcdRsOZUM7QfJwGnIDJIU
         8Q5DTKWvKIe7D1/rGekMCOxqqXu0OIFDpHfJ21Po=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200227182246eucas1p233abc87a0df867db226768434131f151~3VXekq7e22012220122eucas1p2f;
        Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
Received: from eucas1p2.samsung.com ( [182.198.249.207]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 27.5F.60679.6F8085E5; Thu, 27
        Feb 2020 18:22:46 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182246eucas1p2b20cf3379bb774d236e53301e2180252~3VXeRWJZk3196231962eucas1p2I;
        Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182246eusmtrp28835454397cb8fb25edc6501c58f9f21~3VXeQzBO21813218132eusmtrp2q;
        Thu, 27 Feb 2020 18:22:46 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-b6-5e5808f6c417
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 90.C1.08375.5F8085E5; Thu, 27
        Feb 2020 18:22:46 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182245eusmtip271490fb9421596a81e338e74b8bfb898~3VXdz7TXS1203512035eusmtip2P;
        Thu, 27 Feb 2020 18:22:45 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 15/27] ata: let compiler optimize out ata_eh_set_lpm() on
 non-SATA hosts
Date:   Thu, 27 Feb 2020 19:22:14 +0100
Message-Id: <20200227182226.19188-16-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrLKsWRmVeSWpSXmKPExsWy7djP87rfOCLiDC5/ErFYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBk9X2eyFBznrDj7oJulgfEEexcjJ4eE
        gInE7QNzmLsYuTiEBFYwSuy9sIQJJCEk8IVRouuYIUTiM6PEh+bnbDAdK7ddZIMoWs4osXyu
        D0QRUMPX87NYQRJsAlYSE9tXMYLYIgIKEj2/V7KBFDELvGeUWDFpLwtIQlggVuLS9+dgDSwC
        qhIdHf/BGngF7CR2v7vGDLFNXmLrt09gNZxA8Rt929kgagQlTs58AjaHGaimeetssB8kBBax
        SyxcPAfqVBeJU/tXQNnCEq+Ob4F6Wkbi/875TBAN6xgl/na8gOreDvTP5H9QHdYSd879ArI5
        gFZoSqzfpQ8RdpS4uuU/K0hYQoBP4sZbQYgj+CQmbZvODBHmlehoE4KoVpPYsGwDG8zarp0r
        of7ykNj7dBvzBEbFWUjemYXknVkIexcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQI
        TESn/x3/soNx15+kQ4wCHIxKPLwLdoTHCbEmlhVX5h5ilOBgVhLh3fg1NE6INyWxsiq1KD++
        qDQntfgQozQHi5I4r/Gil7FCAumJJanZqakFqUUwWSYOTqkGxt60U3t2rzZYfuXCiSXtB3In
        SC/ecCeoK2izkAPPOovzSs/3bxSSlNaMvy1xc20up1zB1jbR21pb150RvjU74frVsqP+z5on
        RU/Je3rWSPtflv3OiXP3z8qdbX5EtP2iWf7hyYxz6vhTy/kEP7V5PvuZkr2qy6Pv9oSKsDie
        t3d/qXKxTVM/l67EUpyRaKjFXFScCAAmfvu5QAMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xe7rfOCLiDCbrWKy+289msXHGelaL
        Z7f2MlmsXH2UyeLYjkdMFpd3zWGzWP5kLbPF3Nbp7A4cHjtn3WX3uHy21OPQ4Q5Gj5Ot31g8
        dt9sYPPo27KK0ePzJrkA9ig9m6L80pJUhYz84hJbpWhDCyM9Q0sLPSMTSz1DY/NYKyNTJX07
        m5TUnMyy1CJ9uwS9jJ6vM1kKjnNWnH3QzdLAeIK9i5GTQ0LARGLltotsXYxcHEICSxklVt78
        DORwACVkJI6vL4OoEZb4c60LquYTo0TDqumsIAk2ASuJie2rGEFsEQEFiZ7fK8GKmAW+Mkos
        ndTNDDJIWCBa4tRmHpAaFgFViY6O/2D1vAJ2ErvfXWOGWCAvsfXbJ7CZnEDxG33b2UBsIQFb
        ia6Op1D1ghInZz5hAbGZgeqbt85mnsAoMAtJahaS1AJGplWMIqmlxbnpucWGesWJucWleel6
        yfm5mxiB0bLt2M/NOxgvbQw+xCjAwajEw7tgR3icEGtiWXFl7iFGCQ5mJRHejV9D44R4UxIr
        q1KL8uOLSnNSiw8xmgI9MZFZSjQ5HxjJeSXxhqaG5haWhubG5sZmFkrivB0CB2OEBNITS1Kz
        U1MLUotg+pg4OKUaGIvSmKyWL1lh1fA0XX9d5P+EeSsDOQtLj/96nvO3oup28atzezUL/gQy
        mf1k0pGv2zCt/Sy7uSVPyrtfKSrJP8Wjin2COx/pCL+b4DoxL8Dw/rd0S4XUFttfRssUs1aW
        cBjp7Vh+z140dUXL33eGDEwmoXyxeY6nfPKzOlssb1WnqXLI+fxUYinOSDTUYi4qTgQA/1QA
        7qwCAAA=
X-CMS-MailID: 20200227182246eucas1p2b20cf3379bb774d236e53301e2180252
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182246eucas1p2b20cf3379bb774d236e53301e2180252
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182246eucas1p2b20cf3379bb774d236e53301e2180252
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182246eucas1p2b20cf3379bb774d236e53301e2180252@eucas1p2.samsung.com>
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

