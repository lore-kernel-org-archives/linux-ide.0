Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5E96C43613
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAA60205F4
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="lRsgLRFB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727692AbfFXHMr (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:12:47 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51656 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfFXHMr (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 03:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=PJTmDCTAccqW0SYTmuJdPgb35ifcV2QdsECKWjsPKCM=; b=lRsgLRFB+0T1l/Fx30EGEcIquB
        cRNsrdmOMoAiyiTFIPNafvtz8+tUBAMNbWkuZuna+p6qxD+crLda6ReXwMu4uWVWK6Y20GJpxOsUa
        WZ7UOCztTVz1lrSdncAyxuQvMY/qnBgo5CxQF75zNvwYe5Qi5heMroR0ZJ01lxjdHs/1/qV7JuO37
        hjDL5eAuuwwF7/shQZNOD2ibsFWQXF6IyOYsSYS7Zo/MXrk9fF1ii5tS/j/ONpNWYR3UM69kmezUc
        f6Dy/bXsvJbrB2s262olXtIoJN1Rz7KCuHfOOvNSd8XZj19jEBH2WrYMZrzSEBuGfOv4N3qKm4eEb
        VZOIkkXw==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJ9h-0002h3-Id; Mon, 24 Jun 2019 07:12:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 7/8] sata_sil24: use dma_set_mask_and_coherent
Date:   Mon, 24 Jun 2019 09:12:23 +0200
Message-Id: <20190624071224.24019-8-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190624071224.24019-1-hch@lst.de>
References: <20190624071224.24019-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-ide-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-ide.vger.kernel.org>
X-Mailing-List: linux-ide@vger.kernel.org

Use the dma_set_mask_and_coherent helper to set the DMA mask.  Rely
on the relatively recent change that setting a larger than required
mask will never fail to avoid the need for the boilerplate 32-bit
fallback code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/sata_sil24.c | 26 ++++----------------------
 1 file changed, 4 insertions(+), 22 deletions(-)

diff --git a/drivers/ata/sata_sil24.c b/drivers/ata/sata_sil24.c
index bfdf41912588..1efb280715d1 100644
--- a/drivers/ata/sata_sil24.c
+++ b/drivers/ata/sata_sil24.c
@@ -1302,28 +1302,10 @@ static int sil24_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	host->iomap = iomap;
 
 	/* configure and activate the device */
-	if (!dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
-		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-		if (rc) {
-			rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-			if (rc) {
-				dev_err(&pdev->dev,
-					"64-bit DMA enable failed\n");
-				return rc;
-			}
-		}
-	} else {
-		rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(&pdev->dev, "32-bit DMA enable failed\n");
-			return rc;
-		}
-		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-		if (rc) {
-			dev_err(&pdev->dev,
-				"32-bit consistent DMA enable failed\n");
-			return rc;
-		}
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (rc) {
+		dev_err(&pdev->dev, "DMA enable failed\n");
+		return rc;
 	}
 
 	/* Set max read request size to 4096.  This slightly increases
-- 
2.20.1

