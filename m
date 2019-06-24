Return-Path: <SRS0=MoT+=UX=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F4C8C43613
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12D37205F4
	for <linux-ide@archiver.kernel.org>; Mon, 24 Jun 2019 07:12:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GoonAH68"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727658AbfFXHMg (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 24 Jun 2019 03:12:36 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:51600 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727426AbfFXHMg (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 24 Jun 2019 03:12:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5MI48m+ES4xHmdGXoulElqWyraEIeEooMxOwKkyZidU=; b=GoonAH68YwtWAU8I1cCmXlRG9X
        Am1kbB3OWwZYTWCSfHlt1xG1cR1U/NEPWehdb9+UX/ReWfVfr4UI4ypHpDFHzCnl2V8zf2eH5/8Fs
        qzBz98Fm567Oyy6DmoKkKnqX/ijS+521SYL0snhVuLAO2YA1sReo7hu+S5tfqVudE9JhcCQi2Wst0
        j7pDpOFSGQAzDpFP2TaG+wn+on5l9hso9uGv9Tf7bLlXjAOXzVGcKmozpSgPNbN7V/hhDU+6I3kbD
        LkdEGZHejpz2LOJJx+LEvtNlNgiXV9700hRcxALO1PvY5zwyjzfy5EOUGeZP56DAwo7xNQ+JwJfB8
        XVkC4ykA==;
Received: from 213-225-6-159.nat.highway.a1.net ([213.225.6.159] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hfJ9X-0002fP-95; Mon, 24 Jun 2019 07:12:35 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 3/8] pdc_adma: use dma_set_mask_and_coherent
Date:   Mon, 24 Jun 2019 09:12:19 +0200
Message-Id: <20190624071224.24019-4-hch@lst.de>
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
 drivers/ata/pdc_adma.c | 23 ++++-------------------
 1 file changed, 4 insertions(+), 19 deletions(-)

diff --git a/drivers/ata/pdc_adma.c b/drivers/ata/pdc_adma.c
index 52fa8606a25f..965727af569b 100644
--- a/drivers/ata/pdc_adma.c
+++ b/drivers/ata/pdc_adma.c
@@ -573,23 +573,6 @@ static void adma_host_init(struct ata_host *host, unsigned int chip_id)
 		adma_reset_engine(host->ports[port_no]);
 }
 
-static int adma_set_dma_masks(struct pci_dev *pdev, void __iomem *mmio_base)
-{
-	int rc;
-
-	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc) {
-		dev_err(&pdev->dev, "32-bit DMA enable failed\n");
-		return rc;
-	}
-	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc) {
-		dev_err(&pdev->dev, "32-bit consistent DMA enable failed\n");
-		return rc;
-	}
-	return 0;
-}
-
 static int adma_ata_init_one(struct pci_dev *pdev,
 			     const struct pci_device_id *ent)
 {
@@ -620,9 +603,11 @@ static int adma_ata_init_one(struct pci_dev *pdev,
 	host->iomap = pcim_iomap_table(pdev);
 	mmio_base = host->iomap[ADMA_MMIO_BAR];
 
-	rc = adma_set_dma_masks(pdev, mmio_base);
-	if (rc)
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+	if (rc) {
+		dev_err(&pdev->dev, "32-bit DMA enable failed\n");
 		return rc;
+	}
 
 	for (port_no = 0; port_no < ADMA_PORTS; ++port_no) {
 		struct ata_port *ap = host->ports[port_no];
-- 
2.20.1

