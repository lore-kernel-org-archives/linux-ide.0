Return-Path: <SRS0=ljer=4P=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BDD2C35E1D
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38339246A6
	for <linux-ide@archiver.kernel.org>; Thu, 27 Feb 2020 18:24:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=samsung.com header.i=@samsung.com header.b="ks1ZGpw+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731272AbgB0SYY (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Thu, 27 Feb 2020 13:24:24 -0500
Received: from mailout1.w1.samsung.com ([210.118.77.11]:39695 "EHLO
        mailout1.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730879AbgB0SWn (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Thu, 27 Feb 2020 13:22:43 -0500
Received: from eucas1p2.samsung.com (unknown [182.198.249.207])
        by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20200227182241euoutp016cb322d6e7bf1b7dc946f0818b07d61e~3VXZwPrV_1368713687euoutp01M
        for <linux-ide@vger.kernel.org>; Thu, 27 Feb 2020 18:22:41 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20200227182241euoutp016cb322d6e7bf1b7dc946f0818b07d61e~3VXZwPrV_1368713687euoutp01M
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1582827761;
        bh=SD29ru+XPRj8/MpkvAn2nNtxS7lNQ61UJF7W2WDfjqI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ks1ZGpw+lgJDqyK+IQwC+zvEiBAkWi8NkoAVyszZOtZOcJ5YG0+6wzwOmQkFYaJA8
         OZs2ZAJuvKsPpI73mt5JJXzC4SQHZKkQrfR/XhM7OUsVHgB6+XuT1PSDts7a+q62TQ
         sBAnrQzfQc90v3qiElfSEv9KuPxFT+8xLGQsoqbw=
Received: from eusmges1new.samsung.com (unknown [203.254.199.242]) by
        eucas1p1.samsung.com (KnoxPortal) with ESMTP id
        20200227182240eucas1p1016739a86fa86f0213df0574c648fda5~3VXZh6xf40931609316eucas1p1_;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
Received: from eucas1p1.samsung.com ( [182.198.249.206]) by
        eusmges1new.samsung.com (EUCPMTA) with SMTP id D2.5F.61286.0F8085E5; Thu, 27
        Feb 2020 18:22:40 +0000 (GMT)
Received: from eusmtrp2.samsung.com (unknown [182.198.249.139]) by
        eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182240eucas1p272bac5df6668bbb7fee7638b4022a7b1~3VXZPXMzJ3194731947eucas1p2E;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
Received: from eusmgms1.samsung.com (unknown [182.198.249.179]) by
        eusmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20200227182240eusmtrp24ca19a2ef3fc04694fdbb80b4039de39~3VXZO2_aG1813218132eusmtrp2i;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
X-AuditID: cbfec7f2-ef1ff7000001ef66-5c-5e5808f082c0
Received: from eusmtip2.samsung.com ( [203.254.199.222]) by
        eusmgms1.samsung.com (EUCPMTA) with SMTP id 8C.B1.08375.0F8085E5; Thu, 27
        Feb 2020 18:22:40 +0000 (GMT)
Received: from AMDC3058.digital.local (unknown [106.120.51.71]) by
        eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20200227182240eusmtip27751114e671c0a6097b397184342df9d~3VXYzf5Ze0595905959eusmtip2j;
        Thu, 27 Feb 2020 18:22:40 +0000 (GMT)
From:   Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Michael Schmitz <schmitzmic@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christoph Hellwig <hch@lst.de>, linux-ide@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
        b.zolnierkie@samsung.com
Subject: [PATCH v3 04/27] sata_promise: use ata_cable_sata()
Date:   Thu, 27 Feb 2020 19:22:03 +0100
Message-Id: <20200227182226.19188-5-b.zolnierkie@samsung.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200227182226.19188-1-b.zolnierkie@samsung.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrHKsWRmVeSWpSXmKPExsWy7djPc7ofOCLiDKZvtbJYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRXDYpqTmZZalF+nYJXBlNn3YwF2zkrpjx5zB7A+Nhzi5GTg4J
        AROJ+ZeOsXYxcnEICaxglNh35Dg7hPOFUWLyp8tMEM5nRomeWeuYYVoWf+phhEgsZ5RYsXov
        E1zLuRenWUCq2ASsJCa2r2IEsUUEFCR6fq9kAyliFngP1DFpL1iRsICNxP/+ZUwgNouAqsS3
        m9fBGngFbCWurz8KtU5eYuu3T6wgNqeAncSNvu1sEDWCEidnPgGbwwxU07x1NjPIAgmBVewS
        X7f/AxrEAeS4SJy4LQ0xR1ji1fEt7BC2jMT/nfOZIOrXMUr87XgB1bydUWL55H9sEFXWEnfO
        /WIDGcQsoCmxfpc+RNhR4t7aaWwQ8/kkbrwVhLiBT2LStunMEGFeiY42IYhqNYkNyzawwazt
        2rkS6i0PifanL5knMCrOQvLNLCTfzELYu4CReRWjeGppcW56arFhXmq5XnFibnFpXrpecn7u
        JkZgKjr97/inHYxfLyUdYhTgYFTi4V2wIzxOiDWxrLgy9xCjBAezkgjvxq+hcUK8KYmVValF
        +fFFpTmpxYcYpTlYlMR5jRe9jBUSSE8sSc1OTS1ILYLJMnFwSjUwZpct8mk8N0WHn7nXemZ3
        kmzEQqco5s2b478JuE7W/ytqOGnvmvss7zZG6tyYsnfFJY5rjI0fHArvFr0PvLPM+efzorNF
        DI+F/cpfHtVfeNBIOawiWf3Yhh0SNx4Lnlln9O6gjciC02tndxbcntJi8+7VF/OsDpeq2X6b
        vj7fVdMs3s378Ck/nxJLcUaioRZzUXEiAB5rRzdBAwAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFprNIsWRmVeSWpSXmKPExsVy+t/xe7ofOCLiDK4fULNYfbefzWLjjPWs
        Fs9u7WWyWLn6KJPFsR2PmCwu75rDZrH8yVpmi7mt09kdODx2zrrL7nH5bKnHocMdjB4nW7+x
        eOy+2cDm0bdlFaPH501yAexRejZF+aUlqQoZ+cUltkrRhhZGeoaWFnpGJpZ6hsbmsVZGpkr6
        djYpqTmZZalF+nYJehlNn3YwF2zkrpjx5zB7A+Nhzi5GTg4JAROJxZ96GLsYuTiEBJYySlxf
        tJapi5EDKCEjcXx9GUSNsMSfa11sEDWfGCWWbPrHBJJgE7CSmNi+ihHEFhFQkOj5vRKsiFng
        K6PE0kndzCAJYQEbif/9y8AaWARUJb7dvA7WwCtgK3F9/VFmiA3yElu/fWIFsTkF7CRu9G1n
        A7GFgGq6Op5C1QtKnJz5hAXEZgaqb946m3kCo8AsJKlZSFILGJlWMYqklhbnpucWG+oVJ+YW
        l+al6yXn525iBEbMtmM/N+9gvLQx+BCjAAejEg/vgh3hcUKsiWXFlbmHGCU4mJVEeDd+DY0T
        4k1JrKxKLcqPLyrNSS0+xGgK9MREZinR5HxgNOeVxBuaGppbWBqaG5sbm1koifN2CByMERJI
        TyxJzU5NLUgtgulj4uCUamC031RtL/tHnu/0nowVUVc+aCz+1OfmVrQr36L1vH2RTGJXx0HN
        F0V3922+yFkjeDY67sKt8B+rT/9refWjvERiht2GmQePZG+S/KU6+e7epXWKsss1mRuzDquq
        HDA7mRZTVK0V75sjeOEho42J9rYJ2+N+nZBKl3ZTX8i22enX7UNP70T/75+kxFKckWioxVxU
        nAgA9EzTaK4CAAA=
X-CMS-MailID: 20200227182240eucas1p272bac5df6668bbb7fee7638b4022a7b1
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20200227182240eucas1p272bac5df6668bbb7fee7638b4022a7b1
X-EPHeader: CA
CMS-TYPE: 201P
X-CMS-RootMailID: 20200227182240eucas1p272bac5df6668bbb7fee7638b4022a7b1
References: <20200227182226.19188-1-b.zolnierkie@samsung.com>
        <CGME20200227182240eucas1p272bac5df6668bbb7fee7638b4022a7b1@eucas1p2.samsung.com>
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use core helper instead of open-coding it.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
---
 drivers/ata/sata_promise.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index c451d7d1c817..8729f78cef5f 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -157,7 +157,6 @@ static int pdc_sata_hardreset(struct ata_link *link, unsigned int *class,
 static void pdc_error_handler(struct ata_port *ap);
 static void pdc_post_internal_cmd(struct ata_queued_cmd *qc);
 static int pdc_pata_cable_detect(struct ata_port *ap);
-static int pdc_sata_cable_detect(struct ata_port *ap);
 
 static struct scsi_host_template pdc_ata_sht = {
 	ATA_BASE_SHT(DRV_NAME),
@@ -183,7 +182,7 @@ static const struct ata_port_operations pdc_common_ops = {
 
 static struct ata_port_operations pdc_sata_ops = {
 	.inherits		= &pdc_common_ops,
-	.cable_detect		= pdc_sata_cable_detect,
+	.cable_detect		= ata_cable_sata,
 	.freeze			= pdc_sata_freeze,
 	.thaw			= pdc_sata_thaw,
 	.scr_read		= pdc_sata_scr_read,
@@ -459,11 +458,6 @@ static int pdc_pata_cable_detect(struct ata_port *ap)
 	return ATA_CBL_PATA80;
 }
 
-static int pdc_sata_cable_detect(struct ata_port *ap)
-{
-	return ATA_CBL_SATA;
-}
-
 static int pdc_sata_scr_read(struct ata_link *link,
 			     unsigned int sc_reg, u32 *val)
 {
-- 
2.24.1

