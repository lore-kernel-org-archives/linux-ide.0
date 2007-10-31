From: Li Yang <leoli@freescale.com>
Subject: [PATCH 03/12] ata/sata_fsl: save irq in private data for irq unmapping
Date: Wed, 31 Oct 2007 19:27:55 +0800
Message-ID: <1193830084-22298-3-git-send-email-leoli@freescale.com>
References: <1193830084-22298-1-git-send-email-leoli@freescale.com>
 <1193830084-22298-2-git-send-email-leoli@freescale.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from de01egw01.freescale.net ([192.88.165.102]:56718 "EHLO
	de01egw01.freescale.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758093AbXJaLRr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 31 Oct 2007 07:17:47 -0400
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id l9VBHi6b004838
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 04:17:44 -0700 (MST)
Received: from zch01exm26.fsl.freescale.net (zch01exm26.ap.freescale.net [10.192.129.221])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l9VBHdH9005583
	for <linux-ide@vger.kernel.org>; Wed, 31 Oct 2007 06:17:43 -0500 (CDT)
In-Reply-To: <1193830084-22298-2-git-send-email-leoli@freescale.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org
Cc: Li Yang <leoli@freescale.com>

Powerpc uses virtual irq which has to be unmapped.

Signed-off-by: Li Yang <leoli@freescale.com>
---
 drivers/ata/sata_fsl.c |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
index 4c8c820..f8d8614 100644
--- a/drivers/ata/sata_fsl.c
+++ b/drivers/ata/sata_fsl.c
@@ -265,6 +265,7 @@ struct sata_fsl_host_priv {
 	void __iomem *hcr_base;
 	void __iomem *ssr_base;
 	void __iomem *csr_base;
+	int irq;
 };
 
 static inline unsigned int sata_fsl_tag(unsigned int tag,
@@ -1399,6 +1400,7 @@ static int sata_fsl_probe(struct of_device *ofdev,
 		dev_printk(KERN_ERR, &ofdev->dev, "invalid irq from platform\n");
 		goto error_exit_with_cleanup;
 	}
+	host_priv->irq = irq;
 
 	/* allocate host structure */
 	host = ata_host_alloc_pinfo(&ofdev->dev, ppi, SATA_FSL_MAX_PORTS);
@@ -1445,7 +1447,7 @@ static int sata_fsl_remove(struct of_device *ofdev)
 
 	dev_set_drvdata(&ofdev->dev, NULL);
 
-	irq_dispose_mapping(host->irq);
+	irq_dispose_mapping(host_priv->irq);
 	iounmap(host_priv->hcr_base);
 	kfree(host_priv);
 
-- 
1.5.3.2.104.g41ef

