Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DDCCC48BE8
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D3F205F4
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GTm+sFTy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727619AbfFXHMb (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:12:31 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51572 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfFXHMb (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 03:12:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=ISqXoNpwqytFOlpCezojzWfNrkRm3TbgzWTEpjLuMgw=; b=GTm+sFTy/0nHrtcK/V+jI6/jed
        Q4uVBn3smyirrptrcSHpCPBycqP1vdtEg9JOSyysh2HMmtQ1hDLQdss+cNpinc0HCvXEWz8BKu+x9
        exOM5cArygN0mcXLbwce1llsikermHBgGlt6osCYxLHAOBG4CBjSdstgk7qth7f6WAqoybFjkw6QV
        kPHEcTZxuMzaZzsw4x3m2hkJz52nikMwA7zes4EciLbYcWWJUUy3D70SyPVVDp7HteSJrSU3Vojn+
        e4ixgykIoKcDTNRGhalY4oSV//KfHe8SzKDQTSY5t/I6lzF9lmyPzwhkYDDtRbiTkXgpEvFmneG0c
        hKyXdLVQ==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJ9S-0002eQ-1x; Mon, 24 Jun 2019 07:12:30 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 1/8] acard_ahci: use dma_set_mask_and_coherent
Date:   Mon, 24 Jun 2019 09:12:17 +0200
Message-Id: <20190624071224.24019-2-hch@lst.de>
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
 drivers/ata/acard-ahci.c | 38 +++++---------------------------------
 1 file changed, 5 insertions(+), 33 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index b1b49dbd0b14..c67d6eb92d68 100644
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
@@ -472,9 +441,12 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
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

