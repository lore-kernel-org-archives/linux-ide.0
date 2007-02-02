From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: improve ata_down_xfermask_limit()
Date: Fri, 2 Feb 2007 16:22:30 +0900
Message-ID: <11704009501245-git-send-email-htejun@gmail.com>
References: <11704009502014-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from an-out-0708.google.com ([209.85.132.251]:10731 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423169AbXBBHWi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Feb 2007 02:22:38 -0500
Received: by an-out-0708.google.com with SMTP id b33so554968ana
        for <linux-ide@vger.kernel.org>; Thu, 01 Feb 2007 23:22:37 -0800 (PST)
In-Reply-To: <11704009502014-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, alan@lxorguk.ukuu.org.uk, ric@emc.com, edmudama@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Make ata_down_xfermask_limit() accept @sel instead of @force_pio0.
@sel selects how the xfermask limit will be adjusted.  The following
selectors are defined.

* ATA_DNXFER_PIO	: only speed down PIO
* ATA_DNXFER_DMA	: only speed down DMA, don't cause transfer mode change
* ATA_DNXFER_40C	: apply 40c cable limit
* ATA_DNXFER_FORCE_PIO	: force PIO
* ATA_DNXFER_FORCE_PIO0	: force PIO0 (same as original with @force_pio0 == 1)
* ATA_DNXFER_ANY	: same as original with @force_pio0 == 0

Currently, only ANY and FORCE_PIO0 are used to maintain the original
behavior.  Other selectors will be used later to improve EH speed down
sequence.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-core.c |  105 ++++++++++++++++++++++++++++++++++-----------
 drivers/ata/libata-eh.c   |    9 +++-
 drivers/ata/libata.h      |   12 +++++-
 3 files changed, 96 insertions(+), 30 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index a441c75..417394b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -1747,6 +1747,7 @@ int ata_bus_probe(struct ata_port *ap)
 	int tries[ATA_MAX_DEVICES];
 	int i, rc, down_xfermask;
 	struct ata_device *dev;
+	int dnxfer_sel;
 
 	ata_port_probe(ap);
 
@@ -1828,13 +1829,15 @@ int ata_bus_probe(struct ata_port *ap)
 		/* fall through */
 	default:
 		tries[dev->devno]--;
-		if (down_xfermask &&
-		    ata_down_xfermask_limit(dev, tries[dev->devno] == 1))
+		dnxfer_sel = ATA_DNXFER_ANY;
+		if (tries[dev->devno] == 1)
+			dnxfer_sel = ATA_DNXFER_FORCE_PIO0;
+		if (down_xfermask && ata_down_xfermask_limit(dev, dnxfer_sel))
 			tries[dev->devno] = 0;
 	}
 
 	if (!tries[dev->devno]) {
-		ata_down_xfermask_limit(dev, 1);
+		ata_down_xfermask_limit(dev, ATA_DNXFER_FORCE_PIO0);
 		ata_dev_disable(dev);
 	}
 
@@ -2267,7 +2270,7 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 /**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
  *	@dev: Device to adjust xfer masks
- *	@force_pio0: Force PIO0
+ *	@sel: ATA_DNXFER_* selector
  *
  *	Adjust xfer masks of @dev downward.  Note that this function
  *	does not apply the change.  Invoking ata_set_mode() afterwards
@@ -2279,37 +2282,87 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
  *	RETURNS:
  *	0 on success, negative errno on failure
  */
-int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0)
+int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel)
 {
-	unsigned long xfer_mask;
-	int highbit;
+	char buf[32];
+	unsigned int orig_mask, xfer_mask;
+	unsigned int pio_mask, mwdma_mask, udma_mask;
+	int quiet, highbit;
 
-	xfer_mask = ata_pack_xfermask(dev->pio_mask, dev->mwdma_mask,
-				      dev->udma_mask);
+	quiet = !!(sel & ATA_DNXFER_QUIET);
+	sel &= ~ATA_DNXFER_QUIET;
 
-	if (!xfer_mask)
-		goto fail;
-	/* don't gear down to MWDMA from UDMA, go directly to PIO */
-	if (xfer_mask & ATA_MASK_UDMA)
-		xfer_mask &= ~ATA_MASK_MWDMA;
+	xfer_mask = orig_mask = ata_pack_xfermask(dev->pio_mask,
+						  dev->mwdma_mask,
+						  dev->udma_mask);
+	ata_unpack_xfermask(xfer_mask, &pio_mask, &mwdma_mask, &udma_mask);
 
-	highbit = fls(xfer_mask) - 1;
-	xfer_mask &= ~(1 << highbit);
-	if (force_pio0)
-		xfer_mask &= 1 << ATA_SHIFT_PIO;
-	if (!xfer_mask)
-		goto fail;
+	switch (sel) {
+	case ATA_DNXFER_PIO:
+		highbit = fls(pio_mask) - 1;
+		pio_mask &= ~(1 << highbit);
+		break;
+
+	case ATA_DNXFER_DMA:
+		if (udma_mask) {
+			highbit = fls(udma_mask) - 1;
+			udma_mask &= ~(1 << highbit);
+			if (!udma_mask)
+				return -ENOENT;
+		} else if (mwdma_mask) {
+			highbit = fls(mwdma_mask) - 1;
+			mwdma_mask &= ~(1 << highbit);
+			if (!mwdma_mask)
+				return -ENOENT;
+		}
+		break;
+
+	case ATA_DNXFER_40C:
+		udma_mask &= ATA_UDMA_MASK_40C;
+		break;
+
+	case ATA_DNXFER_FORCE_PIO0:
+		pio_mask &= 1;
+	case ATA_DNXFER_FORCE_PIO:
+		mwdma_mask = 0;
+		udma_mask = 0;
+		break;
+
+	case ATA_DNXFER_ANY:
+		/* don't gear down to MWDMA from UDMA, go directly to PIO */
+		if (xfer_mask & ATA_MASK_UDMA)
+			xfer_mask &= ~ATA_MASK_MWDMA;
+
+		highbit = fls(xfer_mask) - 1;
+		xfer_mask &= ~(1 << highbit);
+		break;
+
+	default:
+		BUG();
+	}
+
+	xfer_mask &= ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
+
+	if (!(xfer_mask & ATA_MASK_PIO) || xfer_mask == orig_mask)
+		return -ENOENT;
+
+	if (!quiet) {
+		if (xfer_mask & (ATA_MASK_MWDMA | ATA_MASK_UDMA))
+			snprintf(buf, sizeof(buf), "%s:%s",
+				 ata_mode_string(xfer_mask),
+				 ata_mode_string(xfer_mask & ATA_MASK_PIO));
+		else
+			snprintf(buf, sizeof(buf), "%s",
+				 ata_mode_string(xfer_mask));
+
+		ata_dev_printk(dev, KERN_WARNING,
+			       "limiting speed to %s\n", buf);
+	}
 
 	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
 			    &dev->udma_mask);
 
-	ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
-		       ata_mode_string(xfer_mask));
-
 	return 0;
-
- fail:
-	return -EINVAL;
 }
 
 static int ata_dev_set_mode(struct ata_device *dev)
diff --git a/drivers/ata/libata-eh.c b/drivers/ata/libata-eh.c
index 52c85af..7b61562 100644
--- a/drivers/ata/libata-eh.c
+++ b/drivers/ata/libata-eh.c
@@ -1276,7 +1276,7 @@ static int ata_eh_speed_down(struct ata_device *dev, int is_io,
 		return ATA_EH_HARDRESET;
 
 	/* lower transfer mode */
-	if (ata_down_xfermask_limit(dev, 0) == 0)
+	if (ata_down_xfermask_limit(dev, ATA_DNXFER_ANY) == 0)
 		return ATA_EH_SOFTRESET;
 
 	ata_dev_printk(dev, KERN_ERR,
@@ -1965,6 +1965,7 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 	struct ata_eh_context *ehc = &ap->eh_context;
 	struct ata_device *dev;
 	int down_xfermask, i, rc;
+	int dnxfer_sel;
 
 	DPRINTK("ENTER\n");
 
@@ -2064,8 +2065,10 @@ static int ata_eh_recover(struct ata_port *ap, ata_prereset_fn_t prereset,
 		sata_down_spd_limit(ap);
 	default:
 		ehc->tries[dev->devno]--;
-		if (down_xfermask &&
-		    ata_down_xfermask_limit(dev, ehc->tries[dev->devno] == 1))
+		dnxfer_sel = ATA_DNXFER_ANY;
+		if (ehc->tries[dev->devno] == 1)
+			dnxfer_sel = ATA_DNXFER_FORCE_PIO0;
+		if (down_xfermask && ata_down_xfermask_limit(dev, dnxfer_sel))
 			ehc->tries[dev->devno] = 0;
 	}
 
diff --git a/drivers/ata/libata.h b/drivers/ata/libata.h
index 06ccf23..36e08d2 100644
--- a/drivers/ata/libata.h
+++ b/drivers/ata/libata.h
@@ -41,6 +41,16 @@ struct ata_scsi_args {
 enum {
 	/* flags for ata_dev_read_id() */
 	ATA_READID_POSTRESET	= (1 << 0), /* reading ID after reset */
+
+	/* selector for ata_down_xfermask_limit() */
+	ATA_DNXFER_PIO		= 0,	/* speed down PIO */
+	ATA_DNXFER_DMA		= 1,	/* speed down DMA */
+	ATA_DNXFER_40C		= 2,	/* apply 40c cable limit */
+	ATA_DNXFER_FORCE_PIO	= 3,	/* force PIO */
+	ATA_DNXFER_FORCE_PIO0	= 4,	/* force PIO0 */
+	ATA_DNXFER_ANY		= 5,	/* speed down any */
+
+	ATA_DNXFER_QUIET	= (1 << 31),
 };
 
 extern struct workqueue_struct *ata_aux_wq;
@@ -68,7 +78,7 @@ extern int ata_dev_revalidate(struct ata_device *dev, unsigned int flags);
 extern int ata_dev_configure(struct ata_device *dev);
 extern int sata_down_spd_limit(struct ata_port *ap);
 extern int sata_set_spd_needed(struct ata_port *ap);
-extern int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0);
+extern int ata_down_xfermask_limit(struct ata_device *dev, unsigned int sel);
 extern int ata_set_mode(struct ata_port *ap, struct ata_device **r_failed_dev);
 extern void ata_sg_clean(struct ata_queued_cmd *qc);
 extern void ata_qc_free(struct ata_queued_cmd *qc);
-- 
1.4.4.4


