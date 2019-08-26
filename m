Return-Path: <SRS0=SK3w=WW=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EBE0C3A5A4
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2482120874
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Fotfszln"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730261AbfHZK5e (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:57:34 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45506 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfHZK5e (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Aug 2019 06:57:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FWhzKlUwNr60KV/L8CYscQYJ86yIhGbyog1z3vTLodo=; b=Fotfszln8F7YKFBGEPmR9U1gT4
        KXjAhbLXA4D7gmi3w71+BPLsYKA9aOB89Md2Sw2PrgIBy4sIjnC/bJW79HIw79ryjL0icvkZsDoAE
        fYoLYp+f7Nq9MX3+UNvDVN/JQJG4hTEy+OuWJsck6DZNPZXeZfu3mP8UuVGk145+FnV21AC2rEIwo
        Y+XIfCb6k0WLvOsvlXhRwXwozDviDChgROAq5izrRLVuoddEZzQbNcVypk/xrQQGIYH6z0tmZi7w8
        mxaNr0YCZKj7J0grhviMMIM9SdlLvg6xLQ9mfbnprDFEDZfLaMxIlSc0ptLo/ReDo7V3Xp9UdUmIw
        ycB2FHVA==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Cgl-0007fN-Hc; Mon, 26 Aug 2019 10:57:31 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 1/8] acard_ahci: use dma_set_mask_and_coherent
Date:   Mon, 26 Aug 2019 12:57:18 +0200
Message-Id: <20190826105725.19405-2-hch@lst.de>
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
 drivers/ata/acard-ahci.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 85357f27a66b..753985c01517 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -160,37 +160,6 @@ static int acard_ahci_pci_device_resume(struct pci_dev *pdev)
 }
 #endif
 
-static int acard_ahci_configure_dma_masks(struct pci_dev *pdev, int using_dac)
-{
-	int rc;
-
-	if (using_dac &&
-	    !dma_set_mask(&pdev->dev, DMA_BIT_MASK(64))) {
-		rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(64));
-		if (rc) {
-			rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-			if (rc) {
-				dev_err(&pdev->dev,
-					   "64-bit DMA enable failed\n");
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
-}
-
 static void acard_ahci_pci_print_info(struct ata_host *host)
 {
 	struct pci_dev *pdev = to_pci_dev(host->dev);
@@ -471,9 +440,12 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	}
 
 	/* initialize adapter */
-	rc = acard_ahci_configure_dma_masks(pdev, hpriv->cap & HOST_CAP_64);
-	if (rc)
+	rc = dma_set_mask_and_coherent(&pdev->dev,
+			DMA_BIT_MASK((hpriv->cap & HOST_CAP_64) ? 64 : 32));
+	if (rc) {
+		dev_err(&pdev->dev, "DMA enable failed\n");
 		return rc;
+	}
 
 	rc = ahci_reset_controller(host);
 	if (rc)
-- 
2.20.1

