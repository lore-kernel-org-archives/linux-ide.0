From: Alan Cox <alan@linux.intel.com>
Subject: [RESEND RFC PATCH] libata: cache device select
Date: Wed, 05 May 2010 10:27:47 +0100
Message-ID: <20100505092730.960.94960.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from earthlight.etchedpixels.co.uk ([81.2.110.250]:39746 "EHLO
	bob.linux.org.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932398Ab0EEKGQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 5 May 2010 06:06:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

Avoid the device select overhead on every qc_issue (> 10uS) by caching the
currently selected device. This shows up on profiles under load.

Signed-off-by: Alan Cox <alan@linux.intel.com>
---

 drivers/ata/libata-sff.c |    6 +++++-
 include/linux/libata.h   |    1 +
 2 files changed, 6 insertions(+), 1 deletions(-)


diff --git a/drivers/ata/libata-sff.c b/drivers/ata/libata-sff.c
index 4b57ae9..4fb1229 100644
--- a/drivers/ata/libata-sff.c
+++ b/drivers/ata/libata-sff.c
@@ -470,6 +470,7 @@ void ata_sff_dev_select(struct ata_port *ap, unsigned int device)
 
 	iowrite8(tmp, ap->ioaddr.device_addr);
 	ata_sff_pause(ap);	/* needed; also flushes, for mmio */
+	ap->sff_selected = device;
 }
 EXPORT_SYMBOL_GPL(ata_sff_dev_select);
 
@@ -1559,7 +1560,8 @@ unsigned int ata_sff_qc_issue(struct ata_queued_cmd *qc)
 	}
 
 	/* select the device */
-	ata_dev_select(ap, qc->dev->devno, 1, 0);
+	if (qc->dev->devno != ap->sff_selected)
+        	ata_dev_select(ap, qc->dev->devno, 1, 0);
 
 	/* start the command */
 	switch (qc->tf.protocol) {
@@ -1971,6 +1973,8 @@ int ata_sff_prereset(struct ata_link *link, unsigned long deadline)
 	struct ata_eh_context *ehc = &link->eh_context;
 	int rc;
 
+	link->ap->sff_selected = -1;	/* Unknown */
+
 	rc = ata_std_prereset(link, deadline);
 	if (rc)
 		return rc;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index c4811d9..63a9489 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -727,6 +727,7 @@ struct ata_port {
 
 #ifdef CONFIG_ATA_SFF
 	struct ata_ioports	ioaddr;	/* ATA cmd/ctl/dma register blocks */
+	int			sff_selected;	/* Cache of selected device */
 #endif /* CONFIG_ATA_SFF */
 
 	u8			ctl;	/* cache of ATA control register */

