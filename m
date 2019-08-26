Return-Path: <SRS0=SK3w=WW=vger.kernel.org=linux-ide-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FF98C3A59F
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 49DDB20874
	for <linux-ide@archiver.kernel.org>; Mon, 26 Aug 2019 10:57:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aeIBliCl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfHZK5w (ORCPT <rfc822;linux-ide@archiver.kernel.org>);
        Mon, 26 Aug 2019 06:57:52 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:45598 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730199AbfHZK5v (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Mon, 26 Aug 2019 06:57:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=VmOCmv0JtSe4mb6TusKnj2JfHMRcuVHBX1o3d/WmbnM=; b=aeIBliClpRkNsPOnxzbsjXchby
        hgJRNu8ErOdvi2K6RFsGk16BSw1CYJn3D4zzPQ1KcAQ0TalQ5lBqzZDABFzzDDrWuwJnYu5NOx1QT
        r94rBqrH4FHobHZ6onTrYo/CiqAWVXnsptK8lrTo05P6rixs0r/ZykOOqrsupTJFuzKDlua7+fpOT
        wHuKjiv5EX5gBHXI7vSUhE1dstZLqsA/HCWat6I7r8Awt4mBYKp3m2i4O9PsNTedDzHxfjEEWfxr/
        VU3+tufRmuSli7c2e4G/3RkFpRyUqHRS5UJdn0PotzpFU1M73R9HBr9QbvMX9+QV9xIHBqF1u6Qlq
        VNpvS4Wg==;
Received: from clnet-p19-102.ikbnet.co.at ([83.175.77.102] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1i2Ch4-0007ig-Bh; Mon, 26 Aug 2019 10:57:50 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        Mikael Pettersson <mikpelinux@gmail.com>
Cc:     linux-ide@vger.kernel.org
Subject: [PATCH 8/8] libata: switch remaining drivers to use dma_set_mask_and_coherent
Date:   Mon, 26 Aug 2019 12:57:25 +0200
Message-Id: <20190826105725.19405-9-hch@lst.de>
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

Use dma_set_mask_and_coherent instead of separate dma_set_mask and
dma_set_coherent_mask calls.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/ata/libata-sff.c    | 8 +-------
 drivers/ata/pata_atp867x.c  | 7 +------
 drivers/ata/pata_cs5520.c   | 6 +-----
 drivers/ata/pata_hpt3x3.c   | 5 +----
 drivers/ata/pata_ninja32.c  | 5 +----
 drivers/ata/pata_pdc2027x.c | 6 +-----
 drivers/ata/pata_sil680.c   | 5 +----
 drivers/ata/sata_inic162x.c | 8 +-------
 drivers/ata/sata_promise.c  | 5 +----
 drivers/ata/sata_sil.c      | 5 +----
 drivers/ata/sata_svw.c      | 5 +----
 drivers/ata/sata_sx4.c      | 5 +----
 drivers/ata/sata_via.c      | 9 +--------
 drivers/ata/sata_vsc.c      | 5 +----
 14 files changed, 14 insertions(+), 70 deletions(-)

diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 10aa27882142..d911514de05c 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -3147,15 +3147,9 @@ void ata_pci_bmdma_init(struct ata_host *host)
 	 * ->sff_irq_clear method.  Try to initialize bmdma_addr
 	 * regardless of dma masks.
 	 */
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		ata_bmdma_nodma(host, "failed to set dma mask");
-	if (!rc) {
-		rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
-		if (rc)
-			ata_bmdma_nodma(host,
-					"failed to set consistent dma mask");
-	}
 
 	/* request and iomap DMA region */
 	rc = pcim_iomap_regions(pdev, 1 << 4, dev_driver_string(gdev));
diff --git a/drivers/ata/pata_atp867x.c b/drivers/ata/pata_atp867x.c
index 2b9ed4ddef8d..cfd0cf2cbca6 100644
--- a/drivers/ata/pata_atp867x.c
+++ b/drivers/ata/pata_atp867x.c
@@ -463,12 +463,7 @@ static int atp867x_ata_pci_sff_init_host(struct ata_host *host)
 
 	atp867x_fixup(host);
 
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
-	return rc;
+	return dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 }
 
 static int atp867x_init_one(struct pci_dev *pdev,
diff --git a/drivers/ata/pata_cs5520.c b/drivers/ata/pata_cs5520.c
index 099a5c68a4c9..9052148b306d 100644
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -155,14 +155,10 @@ static int cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 		return -ENODEV;
 	}
 
-	if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+	if (dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32))) {
 		printk(KERN_ERR DRV_NAME ": unable to configure DMA mask.\n");
 		return -ENODEV;
 	}
-	if (dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32))) {
-		printk(KERN_ERR DRV_NAME ": unable to configure consistent DMA mask.\n");
-		return -ENODEV;
-	}
 
 	/* Map IO ports and initialize host accordingly */
 	iomap[0] = devm_ioport_map(&pdev->dev, cmd_port[0], 8);
diff --git a/drivers/ata/pata_hpt3x3.c b/drivers/ata/pata_hpt3x3.c
index b2fc023783b1..83974d5eb387 100644
--- a/drivers/ata/pata_hpt3x3.c
+++ b/drivers/ata/pata_hpt3x3.c
@@ -221,10 +221,7 @@ static int hpt3x3_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (rc)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/pata_ninja32.c b/drivers/ata/pata_ninja32.c
index 607db1f05f9a..f9255d6fd194 100644
--- a/drivers/ata/pata_ninja32.c
+++ b/drivers/ata/pata_ninja32.c
@@ -123,10 +123,7 @@ static int ninja32_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 		return rc;
 
 	host->iomap = pcim_iomap_table(dev);
-	rc = dma_set_mask(&dev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&dev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&dev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 	pci_set_master(dev);
diff --git a/drivers/ata/pata_pdc2027x.c b/drivers/ata/pata_pdc2027x.c
index b656e1536855..de834fbb6dfe 100644
--- a/drivers/ata/pata_pdc2027x.c
+++ b/drivers/ata/pata_pdc2027x.c
@@ -722,11 +722,7 @@ static int pdc2027x_init_one(struct pci_dev *pdev,
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
 
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
index c14071be4f55..7ab9aea3b630 100644
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -374,10 +374,7 @@ static int sil680_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
 	host->iomap = pcim_iomap_table(pdev);
 
 	/* Setup DMA masks */
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 	pci_set_master(pdev);
diff --git a/drivers/ata/sata_inic162x.c b/drivers/ata/sata_inic162x.c
index 790968497dfe..7f99e23bff88 100644
--- a/drivers/ata/sata_inic162x.c
+++ b/drivers/ata/sata_inic162x.c
@@ -862,18 +862,12 @@ static int inic_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	}
 
 	/* Set dma_mask.  This devices doesn't support 64bit addressing. */
-	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc) {
 		dev_err(&pdev->dev, "32-bit DMA enable failed\n");
 		return rc;
 	}
 
-	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc) {
-		dev_err(&pdev->dev, "32-bit consistent DMA enable failed\n");
-		return rc;
-	}
-
 	rc = init_controller(hpriv->mmio_base, hpriv->cached_hctl);
 	if (rc) {
 		dev_err(&pdev->dev, "failed to initialize controller\n");
diff --git a/drivers/ata/sata_promise.c b/drivers/ata/sata_promise.c
index f4dfec3b6e42..5fd464765ddc 100644
--- a/drivers/ata/sata_promise.c
+++ b/drivers/ata/sata_promise.c
@@ -1230,10 +1230,7 @@ static int pdc_ata_init_one(struct pci_dev *pdev,
 	/* initialize adapter */
 	pdc_host_init(host);
 
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_sil.c b/drivers/ata/sata_sil.c
index 25b6a52be5ab..e6fbae2f645a 100644
--- a/drivers/ata/sata_sil.c
+++ b/drivers/ata/sata_sil.c
@@ -757,10 +757,7 @@ static int sil_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 		return rc;
 	host->iomap = pcim_iomap_table(pdev);
 
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_svw.c b/drivers/ata/sata_svw.c
index b903d55c6c20..f8552559db7f 100644
--- a/drivers/ata/sata_svw.c
+++ b/drivers/ata/sata_svw.c
@@ -471,10 +471,7 @@ static int k2_sata_init_one(struct pci_dev *pdev, const struct pci_device_id *en
 		ata_port_pbar_desc(ap, 5, offset, "port");
 	}
 
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_sx4.c b/drivers/ata/sata_sx4.c
index ae8e374d0a77..2277ba0c9c7f 100644
--- a/drivers/ata/sata_sx4.c
+++ b/drivers/ata/sata_sx4.c
@@ -1470,10 +1470,7 @@ static int pdc_sata_init_one(struct pci_dev *pdev,
 	}
 
 	/* configure and activate */
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
+	rc = dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 	if (rc)
 		return rc;
 
diff --git a/drivers/ata/sata_via.c b/drivers/ata/sata_via.c
index fcb9245b184f..c7891cc84ea0 100644
--- a/drivers/ata/sata_via.c
+++ b/drivers/ata/sata_via.c
@@ -505,14 +505,7 @@ static int vt6421_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
 	for (i = 0; i < host->n_ports; i++)
 		vt6421_init_addrs(host->ports[i]);
 
-	rc = dma_set_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, ATA_DMA_MASK);
-	if (rc)
-		return rc;
-
-	return 0;
+	return dma_set_mask_and_coherent(&pdev->dev, ATA_DMA_MASK);
 }
 
 static int vt8251_prepare_host(struct pci_dev *pdev, struct ata_host **r_host)
diff --git a/drivers/ata/sata_vsc.c b/drivers/ata/sata_vsc.c
index fd401e9164ef..8fa952cb9f7f 100644
--- a/drivers/ata/sata_vsc.c
+++ b/drivers/ata/sata_vsc.c
@@ -371,10 +371,7 @@ static int vsc_sata_init_one(struct pci_dev *pdev,
 	/*
 	 * Use 32 bit DMA mask, because 64 bit address support is poor.
 	 */
-	rc = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
-	if (rc)
-		return rc;
-	rc = dma_set_coherent_mask(&pdev->dev, DMA_BIT_MASK(32));
+	rc = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
 	if (rc)
 		return rc;
 
-- 
2.20.1

