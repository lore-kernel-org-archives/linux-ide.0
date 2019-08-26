Return-Path: <SRS0=SK3w=WW=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D3AC3A5A4
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E361C217F5
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RY5HtZ02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730584AbfHZK5q (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:57:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45574 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfHZK5q (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Aug 2019 06:57:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EDlmgU6jZe7sc0CPisNk6E98A53q0pQfsfPb+EiEziE=; b=RY5HtZ02C96ngBXvUpxQRygWId
        CbGMGpKzY7YqowMbQfZIr0U+hfi35J6JaX+Hy6GvUo5kcCsr+myctkY2tJa/A/VTYVllM/RWsrGQB
        DCcXgYE+pXLDvHjYeJKxBnQfg8ccVGLziY/nwZFJAvLGF+b3Xcn233tGt55FwSAdKgRqL21Dfm/77
        9m9VUJqX+dm8UixFaAyTBU6c4IWB04XVk60+NYhwzStm6f4O4FTV/4sImwE5hXW5bqPl03spZmT/X
        nplQhWeosBMgC0z3MDqSGzfd7ZB1vcxlAq66n6Pu7jCt8qjbr9RLyXW5K0vJwF6f/hyASDOjS3Jiq
        3+V/iMzA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Cgy-0007hV-Uy; Mon, 26 Aug 2019 10:57:45 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 6/8] sata_qstor: use dma_set_mask_and_coherent
Date:   Mon, 26 Aug 2019 12:57:23 +0200
Message-Id: <20190826105725.19405-7-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190826105725.19405-1-hch@lst.de>
References: <20190826105725.19405-1-hch@lst.de>
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
 drivers/ata/sata_qstor.c | 34 +++++++---------------------------
 1 file changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/ata/sata_qstor.c b/drivers/ata/sata_qstor.c
index 865e5c58bd94..c53c5a47204d 100644
--- a/drivers/ata/sata_qstor.c
+++ b/drivers/ata/sata_qstor.c
@@ -537,33 +537,13 @@ static void qs_host_init(struct ata_host *host, unsigned int chip_id)
 static int qs_set_dma_masks(struct pci_dev *pdev, void __iomem *mmio_base)
 {
 	u32 bus_info = readl(mmio_base + QS_HID_HPHY);
-	int rc, have_64bit_bus = (bus_info & QS_HPHY_64BIT);
-
-	if (have_64bit_bus &&
-	    !dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
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
-	}
-	return 0;
+	int dma_bits = (bus_info & QS_HPHY_64BIT) ? 64 : 32;
+	int rc;
+
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(dma_bits));
+	if (rc)
+		dev_err(&pdev->dev, "%d-bit DMA enable failed\n", dma_bits);
+	return rc;
 }
 
 static int qs_ata_init_one(struct pci_dev *pdev,
-- 
2.20.1

