From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 07/15] libata: reorganize ata_set_mode()
Date: Sat, 1 Apr 2006 01:38:18 +0900
Message-ID: <11438230982830-git-send-email-htejun@gmail.com>
References: <1143823097579-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.193]:11491 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751407AbWCaQi1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 31 Mar 2006 11:38:27 -0500
Received: by zproxy.gmail.com with SMTP id o37so955009nzf
        for <linux-ide@vger.kernel.org>; Fri, 31 Mar 2006 08:38:27 -0800 (PST)
In-Reply-To: <1143823097579-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, albertcc@tw.ibm.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Merge ata_host_set_pio() and ata_host_set_dma() into ata_set_mode()
and use function-level *dev to iterate over devices.  This eases
soon-to-follow ata_set_mode() interface change.

While at it, kill an unnecessary comment and normalize others.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   91 +++++++++++++++++---------------------------
 1 files changed, 35 insertions(+), 56 deletions(-)

dd939109a2ed9d9ad567d3688eace13cca31a9e1
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 913e378..f04561a 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -1771,47 +1771,6 @@ static int ata_dev_set_mode(struct ata_p
 	return 0;
 }
 
-static int ata_host_set_pio(struct ata_port *ap)
-{
-	int i;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-
-		if (!ata_dev_enabled(dev))
-			continue;
-
-		if (!dev->pio_mode) {
-			printk(KERN_WARNING "ata%u: no PIO support for device %d.\n", ap->id, i);
-			return -1;
-		}
-
-		dev->xfer_mode = dev->pio_mode;
-		dev->xfer_shift = ATA_SHIFT_PIO;
-		if (ap->ops->set_piomode)
-			ap->ops->set_piomode(ap, dev);
-	}
-
-	return 0;
-}
-
-static void ata_host_set_dma(struct ata_port *ap)
-{
-	int i;
-
-	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
-
-		if (!ata_dev_enabled(dev) || !dev->dma_mode)
-			continue;
-
-		dev->xfer_mode = dev->dma_mode;
-		dev->xfer_shift = ata_xfer_mode2shift(dev->dma_mode);
-		if (ap->ops->set_dmamode)
-			ap->ops->set_dmamode(ap, dev);
-	}
-}
-
 /**
  *	ata_set_mode - Program timings and issue SET FEATURES - XFER
  *	@ap: port on which timings will be programmed
@@ -1823,20 +1782,20 @@ static void ata_host_set_dma(struct ata_
  */
 static void ata_set_mode(struct ata_port *ap)
 {
+	struct ata_device *dev;
 	int i, rc, used_dma = 0, found = 0;
 
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
 		unsigned int pio_mask, dma_mask;
 
+		dev = &ap->device[i];
+
 		if (!ata_dev_enabled(dev))
 			continue;
 
 		ata_dev_xfermask(ap, dev);
 
-		/* TODO: let LLDD filter dev->*_mask here */
-
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
@@ -1850,16 +1809,40 @@ static void ata_set_mode(struct ata_port
 		return;
 
 	/* step 2: always set host PIO timings */
-	rc = ata_host_set_pio(ap);
-	if (rc)
-		goto err_out;
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+		if (!ata_dev_enabled(dev))
+			continue;
+
+		if (!dev->pio_mode) {
+			printk(KERN_WARNING "ata%u: dev %u no PIO support\n",
+			       ap->id, dev->devno);
+			rc = -EINVAL;
+			goto err_out;
+		}
+
+		dev->xfer_mode = dev->pio_mode;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		if (ap->ops->set_piomode)
+			ap->ops->set_piomode(ap, dev);
+	}
 
 	/* step 3: set host DMA timings */
-	ata_host_set_dma(ap);
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		dev = &ap->device[i];
+
+		if (!ata_dev_enabled(dev) || !dev->dma_mode)
+			continue;
+
+		dev->xfer_mode = dev->dma_mode;
+		dev->xfer_shift = ata_xfer_mode2shift(dev->dma_mode);
+		if (ap->ops->set_dmamode)
+			ap->ops->set_dmamode(ap, dev);
+	}
 
 	/* step 4: update devices' xfer mode */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
-		struct ata_device *dev = &ap->device[i];
+		dev = &ap->device[i];
 
 		if (!ata_dev_enabled(dev))
 			continue;
@@ -1869,17 +1852,13 @@ static void ata_set_mode(struct ata_port
 			goto err_out;
 	}
 
-	/*
-	 *	Record simplex status. If we selected DMA then the other
-	 *	host channels are not permitted to do so.
+	/* Record simplex status. If we selected DMA then the other
+	 * host channels are not permitted to do so.
 	 */
-
 	if (used_dma && (ap->host_set->flags & ATA_HOST_SIMPLEX))
 		ap->host_set->simplex_claimed = 1;
 
-	/*
-	 *	Chip specific finalisation
-	 */
+	/* step5: chip specific finalisation */
 	if (ap->ops->post_set_mode)
 		ap->ops->post_set_mode(ap);
 
-- 
1.2.4


