From: Harman Kalra <harman4linux@gmail.com>
Subject: [PATCH] ata: sata_mv: Replacing dma_pool_alloc and memset with a single call  dma_pool_zalloc.
Date: Wed, 21 Sep 2016 01:14:40 +0530
Message-ID: <1474400680-12254-1-git-send-email-harman4linux@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33260 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751501AbcITTot (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Tue, 20 Sep 2016 15:44:49 -0400
Received: by mail-pf0-f196.google.com with SMTP id q2so1341871pfj.0
        for <linux-ide@vger.kernel.org>; Tue, 20 Sep 2016 12:44:48 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org, linux-ide@vger.kernel.org
Cc: Harman Kalra <harman4linux@gmail.com>

Replacing dma_pool_alloc and memset with a single call to dma_pool_zalloc

Signed-off-by: Harman Kalra <harman4linux@gmail.com>
---
 drivers/ata/sata_mv.c |    6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/sata_mv.c b/drivers/ata/sata_mv.c
index 745489a..efc48bf 100644
--- a/drivers/ata/sata_mv.c
+++ b/drivers/ata/sata_mv.c
@@ -1727,15 +1727,13 @@ static int mv_port_start(struct ata_port *ap)
 		return -ENOMEM;
 	ap->private_data = pp;
 
-	pp->crqb = dma_pool_alloc(hpriv->crqb_pool, GFP_KERNEL, &pp->crqb_dma);
+	pp->crqb = dma_pool_zalloc(hpriv->crqb_pool, GFP_KERNEL, &pp->crqb_dma);
 	if (!pp->crqb)
 		return -ENOMEM;
-	memset(pp->crqb, 0, MV_CRQB_Q_SZ);
 
-	pp->crpb = dma_pool_alloc(hpriv->crpb_pool, GFP_KERNEL, &pp->crpb_dma);
+	pp->crpb = dma_pool_zalloc(hpriv->crpb_pool, GFP_KERNEL, &pp->crpb_dma);
 	if (!pp->crpb)
 		goto out_port_free_dma_mem;
-	memset(pp->crpb, 0, MV_CRPB_Q_SZ);
 
 	/* 6041/6081 Rev. "C0" (and newer) are okay with async notify */
 	if (hpriv->hp_flags & MV_HP_ERRATA_60X1C0)
-- 
1.7.9.5

