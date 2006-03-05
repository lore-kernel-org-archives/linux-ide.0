From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 5/6] libata: reimplement ata_set_mode() using xfer_mask helpers
Date: Mon, 6 Mar 2006 04:31:57 +0900
Message-ID: <11415871172433-git-send-email-htejun@gmail.com>
References: <11415871161709-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from zproxy.gmail.com ([64.233.162.201]:19286 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751804AbWCETcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 5 Mar 2006 14:32:05 -0500
Received: by zproxy.gmail.com with SMTP id 16so587600nzp
        for <linux-ide@vger.kernel.org>; Sun, 05 Mar 2006 11:32:05 -0800 (PST)
In-Reply-To: <11415871161709-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Use xfer_mask helpers to determine transfer mode.  This rewrite also
makes transfer mode determination done before any actual
configuration.  This patch doesn't result in any functional changes.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |  233 +++++++++++++++-----------------------------
 1 files changed, 79 insertions(+), 154 deletions(-)

d06b4f9f33fd7a5ffbb93837f5b4a69d4fa91dbc
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 8849512..d211f0b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,11 +65,9 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
-static unsigned int ata_get_mode_mask(const struct ata_port *ap, int shift);
+static unsigned int ata_dev_xfermask(struct ata_port *ap,
+				     struct ata_device *dev);
 static int fgb(u32 bitmap);
-static int ata_choose_xfer_mode(const struct ata_port *ap,
-				u8 *xfer_mode_out,
-				unsigned int *xfer_shift_out);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -1776,51 +1774,42 @@ static void ata_dev_set_mode(struct ata_
 
 static int ata_host_set_pio(struct ata_port *ap)
 {
-	unsigned int mask;
-	int x, i;
-	u8 base, xfer_mode;
-
-	mask = ata_get_mode_mask(ap, ATA_SHIFT_PIO);
-	x = fgb(mask);
-	if (x < 0) {
-		printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
-		return -1;
-	}
-
-	base = base_from_shift(ATA_SHIFT_PIO);
-	xfer_mode = base + x;
-
-	DPRINTK("base 0x%x xfer_mode 0x%x mask 0x%x x %d\n",
-		(int)base, (int)xfer_mode, mask, x);
+	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_present(dev)) {
-			dev->pio_mode = xfer_mode;
-			dev->xfer_mode = xfer_mode;
-			dev->xfer_shift = ATA_SHIFT_PIO;
-			if (ap->ops->set_piomode)
-				ap->ops->set_piomode(ap, dev);
+
+		if (!ata_dev_present(dev))
+			continue;
+
+		if (!dev->pio_mode) {
+			printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
+			return -1;
 		}
+
+		dev->xfer_mode = dev->pio_mode;
+		dev->xfer_shift = ATA_SHIFT_PIO;
+		if (ap->ops->set_piomode)
+			ap->ops->set_piomode(ap, dev);
 	}
 
 	return 0;
 }
 
-static void ata_host_set_dma(struct ata_port *ap, u8 xfer_mode,
-			    unsigned int xfer_shift)
+static void ata_host_set_dma(struct ata_port *ap)
 {
 	int i;
 
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		if (ata_dev_present(dev)) {
-			dev->dma_mode = xfer_mode;
-			dev->xfer_mode = xfer_mode;
-			dev->xfer_shift = xfer_shift;
-			if (ap->ops->set_dmamode)
-				ap->ops->set_dmamode(ap, dev);
-		}
+
+		if (!ata_dev_present(dev) || !dev->dma_mode)
+			continue;
+
+		dev->xfer_mode = dev->dma_mode;
+		dev->xfer_shift = ata_xfer_mode2shift(dev->dma_mode);
+		if (ap->ops->set_dmamode)
+			ap->ops->set_dmamode(ap, dev);
 	}
 }
 
@@ -1835,28 +1824,34 @@ static void ata_host_set_dma(struct ata_
  */
 static void ata_set_mode(struct ata_port *ap)
 {
-	unsigned int xfer_shift;
-	u8 xfer_mode;
-	int rc;
+	int i, rc;
 
-	/* step 1: always set host PIO timings */
-	rc = ata_host_set_pio(ap);
-	if (rc)
-		goto err_out;
+	/* step 1: calculate xfer_mask */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		unsigned int xfer_mask;
+
+		if (!ata_dev_present(dev))
+			continue;
 
-	/* step 2: choose the best data xfer mode */
-	xfer_mode = xfer_shift = 0;
-	rc = ata_choose_xfer_mode(ap, &xfer_mode, &xfer_shift);
+		xfer_mask = ata_dev_xfermask(ap, dev);
+
+		dev->pio_mode = ata_xfer_mask2mode(xfer_mask & ATA_MASK_PIO);
+		dev->dma_mode = ata_xfer_mask2mode(xfer_mask & (ATA_MASK_MWDMA |
+								ATA_MASK_UDMA));
+	}
+
+	/* step 2: always set host PIO timings */
+	rc = ata_host_set_pio(ap);
 	if (rc)
 		goto err_out;
 
-	/* step 3: if that xfer mode isn't PIO, set host DMA timings */
-	if (xfer_shift != ATA_SHIFT_PIO)
-		ata_host_set_dma(ap, xfer_mode, xfer_shift);
+	/* step 3: set host DMA timings */
+	ata_host_set_dma(ap);
 
 	/* step 4: update devices' xfer mode */
-	ata_dev_set_mode(ap, &ap->device[0]);
-	ata_dev_set_mode(ap, &ap->device[1]);
+	for (i = 0; i < ATA_MAX_DEVICES; i++)
+		ata_dev_set_mode(ap, &ap->device[i]);
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
@@ -2654,77 +2649,45 @@ static int ata_dma_blacklisted(const str
 	return 0;
 }
 
-static unsigned int ata_get_mode_mask(const struct ata_port *ap, int shift)
+/**
+ *	ata_dev_xfermask - Compute supported xfermask of the given device
+ *	@ap: Port on which the device to compute xfermask for resides
+ *	@dev: Device to compute xfermask for
+ *
+ *	Compute supported xfermask of @dev.  This function is
+ *	responsible for applying all known limits including host
+ *	controller limits, device blacklist, etc...
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Computed xfermask.
+ */
+static unsigned int ata_dev_xfermask(struct ata_port *ap,
+				     struct ata_device *dev)
 {
-	const struct ata_device *master, *slave;
-	unsigned int mask;
+	unsigned long xfer_mask;
+	int i;
 
-	master = &ap->device[0];
-	slave = &ap->device[1];
+	xfer_mask = ata_pack_xfermask(ap->pio_mask, ap->mwdma_mask,
+				      ap->udma_mask);
 
-	WARN_ON(!ata_dev_present(master) && !ata_dev_present(slave));
-
-	if (shift == ATA_SHIFT_UDMA) {
-		mask = ap->udma_mask;
-		if (ata_dev_present(master)) {
-			mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-			if (ata_dma_blacklisted(master)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, master);
-			}
-		}
-		if (ata_dev_present(slave)) {
-			mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
-			if (ata_dma_blacklisted(slave)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, slave);
-			}
-		}
-	}
-	else if (shift == ATA_SHIFT_MWDMA) {
-		mask = ap->mwdma_mask;
-		if (ata_dev_present(master)) {
-			mask &= (master->id[ATA_ID_MWDMA_MODES] & 0x07);
-			if (ata_dma_blacklisted(master)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, master);
-			}
-		}
-		if (ata_dev_present(slave)) {
-			mask &= (slave->id[ATA_ID_MWDMA_MODES] & 0x07);
-			if (ata_dma_blacklisted(slave)) {
-				mask = 0;
-				ata_pr_blacklisted(ap, slave);
-			}
-		}
-	}
-	else if (shift == ATA_SHIFT_PIO) {
-		mask = ap->pio_mask;
-		if (ata_dev_present(master)) {
-			/* spec doesn't return explicit support for
-			 * PIO0-2, so we fake it
-			 */
-			u16 tmp_mode = master->id[ATA_ID_PIO_MODES] & 0x03;
-			tmp_mode <<= 3;
-			tmp_mode |= 0x7;
-			mask &= tmp_mode;
-		}
-		if (ata_dev_present(slave)) {
-			/* spec doesn't return explicit support for
-			 * PIO0-2, so we fake it
-			 */
-			u16 tmp_mode = slave->id[ATA_ID_PIO_MODES] & 0x03;
-			tmp_mode <<= 3;
-			tmp_mode |= 0x7;
-			mask &= tmp_mode;
-		}
-	}
-	else {
-		mask = 0xffffffff; /* shut up compiler warning */
-		BUG();
+	/* use port-wide xfermask for now */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		if (!ata_dev_present(d))
+			continue;
+		xfer_mask &= ata_id_xfermask(d->id);
+		if (ata_dma_blacklisted(d))
+			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	}
 
-	return mask;
+	if (ata_dma_blacklisted(dev))
+		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
+		       "disabling DMA\n", ap->id, dev->devno);
+
+	return xfer_mask;
 }
 
 /* find greatest bit */
@@ -2741,44 +2704,6 @@ static int fgb(u32 bitmap)
 }
 
 /**
- *	ata_choose_xfer_mode - attempt to find best transfer mode
- *	@ap: Port for which an xfer mode will be selected
- *	@xfer_mode_out: (output) SET FEATURES - XFER MODE code
- *	@xfer_shift_out: (output) bit shift that selects this mode
- *
- *	Based on host and device capabilities, determine the
- *	maximum transfer mode that is amenable to all.
- *
- *	LOCKING:
- *	PCI/etc. bus probe sem.
- *
- *	RETURNS:
- *	Zero on success, negative on error.
- */
-
-static int ata_choose_xfer_mode(const struct ata_port *ap,
-				u8 *xfer_mode_out,
-				unsigned int *xfer_shift_out)
-{
-	unsigned int mask, shift;
-	int x, i;
-
-	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++) {
-		shift = xfer_mode_classes[i].shift;
-		mask = ata_get_mode_mask(ap, shift);
-
-		x = fgb(mask);
-		if (x >= 0) {
-			*xfer_mode_out = xfer_mode_classes[i].base + x;
-			*xfer_shift_out = shift;
-			return 0;
-		}
-	}
-
-	return -1;
-}
-
-/**
  *	ata_dev_set_xfermode - Issue SET FEATURES - XFER MODE command
  *	@ap: Port associated with device @dev
  *	@dev: Device to which command will be sent
-- 
1.2.4


