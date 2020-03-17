Return-Path: <SRS0=AjNr=5C=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3913CC18E5B
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 075D8205ED
	for <linux-ide@archiver.kernel.org>; Tue, 17 Mar 2020 14:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="eMYUGy45"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726553AbgCQOot (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:44:49 -0400
Received: from mailout2.w1.samsung.com ([210.118.77.12]:40412 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726913AbgCQOnu (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 17 Mar 2020 10:43:50 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout2.w1.samsung.com (KnoxPortal) with ESMTP id 20200317144349euoutp020550d9b711b598e53ce06d0377b5a98d~9Hou56AmF1539415394euoutp02c
        for <linux-ide@vger.kernel.org>; Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.w1.samsung.com 20200317144349euoutp020550d9b711b598e53ce06d0377b5a98d~9Hou56AmF1539415394euoutp02c
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1584456229;
        bh=kDDp9ELtxCrp7at7igqupWVGMtIwlaFUunq9LtktYyo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=eMYUGy45hy12QB7/F0Lrvu49ulKwv24K3bJJpQXgUqJNefYXPt7JE7O+JQzectlkc
         1b1Up28QJdmuAAloFSTEgJh14NQguiOCO8BYry5Z2OekurfKp8MUdhMF6PSDzB/0/v
         eJCHE6AUob+a0zr+yATU7MPGQVqN/Y8WoGTQsx6w=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTP id
        20200317144349eucas1p2c289568e4ec023e2b3c3d4e78be0782c~9HoulB2pt0133401334eucas1p2j;
        Tue, 17 Mar 2020 14:43:49 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 31.F1.60679.422E07E5; Tue, 17
        Mar 2020 14:43:48 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200317144348eucas1p2cce1c6e1ce8bafc0e68dec04655f1932~9HouIZeGX2984629846eucas1p21;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200317144348eusmtrp237c7ad06df27198f22f29a0605ca5c36~9HouHxpZ-0146401464eusmtrp2Q;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
X-AuditID: cbfec7f4-0cbff7000001ed07-48-5e70e2240e82
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 6E.D4.08375.422E07E5; Tue, 17
        Mar 2020 14:43:48 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200317144348eusmtip1eae27f6c502e35fabff0c9563f8fca9a~9HotskO831029210292eusmtip1E;
        Tue, 17 Mar 2020 14:43:48 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v4 15/27] ata: let compiler optimize out ata_eh_set_lpm() on
 non-SATA hosts
Date:   Tue, 17 Mar 2020 15:43:21 +0100
Message-Id: <20200317144333.2904-16-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200317144333.2904-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrDKsWRmVeSWpSXmKPExsWy7djPc7oqjwriDL7csrRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnPf3oWHOes2DHjEHMD4wn2LkZODgkB
        E4ljH68zdTFycQgJrGCU+DB9MyOE84VR4v25PjYI5zOjxJQvB1hhWh7suAlVtZxR4l7rRHa4
        lulf+sGq2ASsJCa2r2IEsUUEFCR6fq8EG8Us8J5RYsWkvSwgCWGBWIn/RzaB2SwCqhKHl69l
        BrF5BWwlLl/ZxAyxTl5i67dPYEM5geLXDv9jg6gRlDg58wlYLzNQTfPW2VD1y9gljl3VhLBd
        JC51vIM6W1ji1fEtUF/LSPzfOR/sawmBdYwSfzteMEM42xkllk+G2CAhYC1x59wvIJsDaIOm
        xPpd+hBhR4kj3VvBwhICfBI33gpC3MAnMWnbdGaIMK9ER5sQRLWaxIZlG9hg1nbtXAlV4iFx
        bLvDBEbFWUiemYXkmVkIaxcwMq9iFE8tLc5NTy02ykst1ytOzC0uzUvXS87P3cQITEOn/x3/
        soNx15+kQ4wCHIxKPLwcGwrihFgTy4orcw8xSnAwK4nwLi7MjxPiTUmsrEotyo8vKs1JLT7E
        KM3BoiTOa7zoZayQQHpiSWp2ampBahFMlomDU6qBcXqN3eX9vHdu3ZjuuXJ9rErA5jUcy742
        du82NX558aLspHXqF4Rlt1w0OfFh8XoDj6ZWa5GtjVFLLh85sDBy8ndBw+1Ti2e8zMk8zNCQ
        +1jKw7O3oLAyK2xdWFuw0vdl7asm/bu7/7PvbQkNY6+7Z5b4+Xz8Y9ww5erDR60fSueLvFIU
        UwvXL1diKc5INNRiLipOBACyRgbaPwMAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprFIsWRmVeSWpSXmKPExsVy+t/xu7oqjwriDCb0yFusvtvPZrFxxnpW
        i2e39jJZrFx9lMni2I5HTBaXd81hs1j+ZC2zxdzW6ewOHB47Z91l97h8ttTj0OEORo+Trd9Y
        PHbfbGDz6NuyitHj8ya5APYoPZui/NKSVIWM/OISW6VoQwsjPUNLCz0jE0s9Q2PzWCsjUyV9
        O5uU1JzMstQifbsEvYznPz0LjnNW7JhxiLmB8QR7FyMnh4SAicSDHTcZuxi5OIQEljJKNEzd
        w9TFyAGUkJE4vr4MokZY4s+1LjaImk+MEvuOn2QFSbAJWElMbF/FCGKLCChI9PxeCVbELPCV
        UWLppG5mkISwQLTErd4/YNtYBFQlDi9fCxbnFbCVuHxlEzPEBnmJrd8+gQ3lBIpfO/yPDcQW
        ErCRePHmPxNEvaDEyZlPWEBsZqD65q2zmScwCsxCkpqFJLWAkWkVo0hqaXFuem6xoV5xYm5x
        aV66XnJ+7iZGYLxsO/Zz8w7GSxuDDzEKcDAq8fBybCiIE2JNLCuuzD3EKMHBrCTCu7gwP06I
        NyWxsiq1KD++qDQntfgQoynQExOZpUST84GxnFcSb2hqaG5haWhubG5sZqEkztshcDBGSCA9
        sSQ1OzW1ILUIpo+Jg1OqgbHXh8f1d3llRELs3QneTBle+8XeOYpXzkxifJNS8ij00N87nZz8
        J/9xSlauq61Wy5Sef+7fc2FHZ17HnintrV8LT3xd4jjlOXfe2U21fis7jZiupKl8EPJS/MGm
        cob3wX1ZJjeZJWXZ+X7GGUtPiy2T3zuX5e4Gpc/rDP5xKek/2ubk9MbqthJLcUaioRZzUXEi
        AGThZR+tAgAA
X-CMS-MailID: 20200317144348eucas1p2cce1c6e1ce8bafc0e68dec04655f1932
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200317144348eucas1p2cce1c6e1ce8bafc0e68dec04655f1932
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200317144348eucas1p2cce1c6e1ce8bafc0e68dec04655f1932
References: <20200317144333.2904-1-b.zolnierkie@samsung.com>
        <CGME20200317144348eucas1p2cce1c6e1ce8bafc0e68dec04655f1932@eucas1p2.samsung.com>
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
index 3b8d276b5107..452c30024f81 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -3449,7 +3449,8 @@ static int ata_eh_set_lpm(struct ata_link *link, enum ata_lpm_policy policy,
 	int rc;
 
 	/* if the link or host doesn't do LPM, noop */
-	if ((link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
+	if (!IS_ENABLED(CONFIG_SATA_HOST) ||
+	    (link->flags & ATA_LFLAG_NO_LPM) || (ap && !ap->ops->set_lpm))
 		return 0;
 
 	/*
-- 
2.24.1

