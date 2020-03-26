Return-Path: <SRS0=jBxd=5L=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0E37C2D0EC
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8A3E02073E
	for <linux-ide@archiver.kernel.org>; Thu, 26 Mar 2020 16:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="gRF/Gfv1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725994AbgCZQAB (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:00:01 -0400
Received: from mailout1.w1.samsung.com ([210.118.77.11]:58866 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728401AbgCZP6p (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 26 Mar 2020 11:58:45 -0400
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200326155844euoutp013d2552c3d4da293a430379ccff5bc94e~-5dtpAPFF3025530255euoutp01J
        for <linux-ide@vger.kernel.org>; Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200326155844euoutp013d2552c3d4da293a430379ccff5bc94e~-5dtpAPFF3025530255euoutp01J
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1585238324;
        bh=YfwcHfKOwZYJZHVC8nOUalc48rrP1wjNNKazMglRzk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gRF/Gfv18MGOlaLbyDQQBWl/RCE6ID3KcmMDyUjhE+tBgET9WG445cYIQNR6nDiUI
         MiDeER1F9lFEiqUKzVQACs783FqoNySooXB16cxAhjlG1Nx31kFcETLZpqrH03yhT5
         Gbb4OKY67tWaU9OzsdYbalrN86YiKMHkjF6qh0MM=
Received: from eusmges2new.samsung.com (unknown [203.254.199.244]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200326155844eucas1p1d81409e39f5b7a8ae165bd0075c5a0be~-5dtaP6Z_0942909429eucas1p1R;
        Thu, 26 Mar 2020 15:58:44 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges2new.samsung.com (EUCPMTA) with SMTP id 75.E9.60679.431DC7E5; Thu, 26
        Mar 2020 15:58:44 +0000 (GMT)
Received: from eusmtrp1.samsung.com (unknown [182.198.249.138]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155843eucas1p1c3f378cfd16d7f2a29d46e1456d8cbfd~-5dtCsvqT0136101361eucas1p1C;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20200326155843eusmtrp199352f27fb28941a8a51472d09f0c6bf~-5dtCJNqU2091520915eusmtrp1L;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
X-AuditID: cbfec7f4-0e5ff7000001ed07-cb-5e7cd134a517
Received: from eusmtip1.samsung.com ( [203.254.199.221]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 0C.5A.08375.331DC7E5; Thu, 26
        Mar 2020 15:58:43 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip1.samsung.com (KnoxPortal) with ESMTPA id
        20200326155843eusmtip1b31a2b9474a93a64b4900a39c669e6ed~-5dspYKQk0820308203eusmtip1h;
        Thu, 26 Mar 2020 15:58:43 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v5 13/27] ata: add CONFIG_SATA_HOST=n version of
 ata_ncq_enabled()
Date:   Thu, 26 Mar 2020 16:58:08 +0100
Message-Id: <20200326155822.19400-14-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200326155822.19400-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrNKsWRmVeSWpSXmKPExsWy7djPc7omF2viDL5/ZrNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBnzVs1gLTjHVbH1vFkDYx9HFyMnh4SA
        icS24y2sXYxcHEICKxglXpy5zwbhfGGUeLr3OQuE85lR4uGty8wwLdMPLmCHSCxnlFgwq5sN
        JAHW0tDEBWKzCVhJTGxfxQhiiwgoSPT8Xgk2llngPaPEikl7WUASwgIhEqsmnQIrYhFQlWjc
        9BRsEK+AncTknzMYIbbJS2z99okVxOYEii9fN58ZokZQ4uTMJ2BzmIFqmrfOhrpuGbvEtrkx
        ELaLxKuZvWwQtrDEq+Nb2CFsGYnTk3vAXpMQWMco8bfjBTOEs51RYvnkf1Ad1hJ3zv0CsjmA
        NmhKrN+lDxF2lGh/t5AVJCwhwCdx460gxA18EpO2TWeGCPNKdLQJQVSrSWxYtoENZm3XzpVQ
        JR4Stz9LTWBUnIXkmVlInpmFsHYBI/MqRvHU0uLc9NRio7zUcr3ixNzi0rx0veT83E2MwCR0
        +t/xLzsYd/1JOsQowMGoxMOr0VITJ8SaWFZcmXuIUYKDWUmE92kkUIg3JbGyKrUoP76oNCe1
        +BCjNAeLkjiv8aKXsUIC6YklqdmpqQWpRTBZJg5OqQbGRXfPuB47fM5NfzPTu8TPq1/bPFHU
        EO+cssJw5YeLEUskp/x2MIia1rBIawFHJVu5s+kTYQYprY+1kr+fB9zvT67QWnDEIy/Jpz5q
        bufWRPXDvaW71iukdVjkeHz+r5bXeuQFtx7jtiXtGkF1IhsfXH46xaZtt8HU/9rnprcdEA9U
        q1UNMHNXYinOSDTUYi4qTgQAOBEl+D4DAAA=
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprJIsWRmVeSWpSXmKPExsVy+t/xu7rGF2viDK6d1bRYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehnzVs1gLTjHVbH1vFkDYx9HFyMnh4SAicT0gwvYQWwhgaWMEhebsrsY
        OYDiMhLH15dBlAhL/LnWxdbFyAVU8olR4vGtD2wgCTYBK4mJ7asYQWwRAQWJnt8rwYqYBb4y
        Siyd1M0MkhAWCJL49OsSC4jNIqAq0bjpKVgzr4CdxOSfMxghNshLbP32iRXE5gSKL183nxni
        IFuJxV8+MEHUC0qcnPkEbA4zUH3z1tnMExgFZiFJzUKSWsDItIpRJLW0ODc9t9hQrzgxt7g0
        L10vOT93EyMwWrYd+7l5B+OljcGHGAU4GJV4eDVaauKEWBPLiitzDzFKcDArifA+jQQK8aYk
        VlalFuXHF5XmpBYfYjQFemIis5Rocj4wkvNK4g1NDc0tLA3Njc2NzSyUxHk7BA7GCAmkJ5ak
        ZqemFqQWwfQxcXBKNTCafP9483bo/voasf/fGV2C9jCrlLTtPfX34u4sN+nmhb3sThvlHuYf
        +v8gz1dnh2vzQt/bDHJR62QMWkWXOhiXzfafrNrUdUffjkN/990/Wbfrp9ZotejuDedjS/yV
        E6o3a5tK+L2+Gy2f/py84Ouo90Zh4dU/nHNks2IsJ95fxmVWevKBeKkSS3FGoqEWc1FxIgAc
        evyurAIAAA==
X-CMS-MailID: 20200326155843eucas1p1c3f378cfd16d7f2a29d46e1456d8cbfd
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200326155843eucas1p1c3f378cfd16d7f2a29d46e1456d8cbfd
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200326155843eucas1p1c3f378cfd16d7f2a29d46e1456d8cbfd
References: <20200326155822.19400-1-b.zolnierkie@samsung.com>
        <CGME20200326155843eucas1p1c3f378cfd16d7f2a29d46e1456d8cbfd@eucas1p1.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

When CONFIG_SATA_HOST=n there are no NCQ capable host drivers
built so it is safe to hardwire ata_ncq_enabled() to always
return zero.

Code size savings on m68k arch using (modified) atari_defconfig:

   text    data     bss     dec     hex filename
before:
  37820     572      40   38432    9620 drivers/ata/libata-core.o
  21040     105     576   21721    54d9 drivers/ata/libata-scsi.o
  17405      18       0   17423    440f drivers/ata/libata-eh.o
after:
  37582     572      40   38194    9532 drivers/ata/libata-core.o
  20702     105     576   21383    5387 drivers/ata/libata-scsi.o
  17353      18       0   17371    43db drivers/ata/libata-eh.o

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 include/linux/libata.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/libata.h b/include/linux/libata.h
index 500b709ed3de..661d76038684 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -1633,6 +1633,8 @@ extern struct ata_device *ata_dev_next(struct ata_device *dev,
  */
 static inline int ata_ncq_enabled(struct ata_device *dev)
 {
+	if (!IS_ENABLED(CONFIG_SATA_HOST))
+		return 0;
 	return (dev->flags & (ATA_DFLAG_PIO | ATA_DFLAG_NCQ_OFF |
 			      ATA_DFLAG_NCQ)) == ATA_DFLAG_NCQ;
 }
-- 
2.24.1

