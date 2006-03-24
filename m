From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: add per-dev pio/mwdma/udma_mask
Date: Fri, 24 Mar 2006 14:07:50 +0900
Message-ID: <11431768704184-git-send-email-htejun@gmail.com>
References: <11431768691564-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from xproxy.gmail.com ([66.249.82.202]:38359 "EHLO xproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932441AbWCXFHz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 24 Mar 2006 00:07:55 -0500
Received: by xproxy.gmail.com with SMTP id t10so445377wxc
        for <linux-ide@vger.kernel.org>; Thu, 23 Mar 2006 21:07:54 -0800 (PST)
In-Reply-To: <11431768691564-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add per-dev pio/mwdma/udma_mask.  All transfer mode limits used to be
applied to ap->*_mask which unnecessarily restricted other devices
sharing the port.  This change will also benefit later EH speed down
and hotplug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   43 +++++++++++++++++++++++++------------------
 include/linux/libata.h     |    5 +++++
 2 files changed, 30 insertions(+), 18 deletions(-)

31c02ad0eeb7c73243a109a75e41b09511c1576f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index 1514cb5..a87748b 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,8 +65,7 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
-static unsigned int ata_dev_xfermask(struct ata_port *ap,
-				     struct ata_device *dev);
+static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -1801,16 +1800,19 @@ static void ata_set_mode(struct ata_port
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		unsigned int xfer_mask;
+		unsigned int pio_mask, dma_mask;
 
 		if (!ata_dev_present(dev))
 			continue;
 
-		xfer_mask = ata_dev_xfermask(ap, dev);
+		ata_dev_xfermask(ap, dev);
 
-		dev->pio_mode = ata_xfer_mask2mode(xfer_mask & ATA_MASK_PIO);
-		dev->dma_mode = ata_xfer_mask2mode(xfer_mask & (ATA_MASK_MWDMA |
-								ATA_MASK_UDMA));
+		/* TODO: let LLDD filter dev->*_mask here */
+
+		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
+		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
+		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
+		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 	}
 
 	/* step 2: always set host PIO timings */
@@ -2653,18 +2655,15 @@ static int ata_dma_blacklisted(const str
  *	@ap: Port on which the device to compute xfermask for resides
  *	@dev: Device to compute xfermask for
  *
- *	Compute supported xfermask of @dev.  This function is
- *	responsible for applying all known limits including host
- *	controller limits, device blacklist, etc...
+ *	Compute supported xfermask of @dev and store it in
+ *	dev->*_mask.  This function is responsible for applying all
+ *	known limits including host controller limits, device
+ *	blacklist, etc...
  *
  *	LOCKING:
  *	None.
- *
- *	RETURNS:
- *	Computed xfermask.
  */
-static unsigned int ata_dev_xfermask(struct ata_port *ap,
-				     struct ata_device *dev)
+static void ata_dev_xfermask(struct ata_port *ap, struct ata_device *dev)
 {
 	unsigned long xfer_mask;
 	int i;
@@ -2677,6 +2676,8 @@ static unsigned int ata_dev_xfermask(str
 		struct ata_device *d = &ap->device[i];
 		if (!ata_dev_present(d))
 			continue;
+		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
+					       d->udma_mask);
 		xfer_mask &= ata_id_xfermask(d->id);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
@@ -2686,7 +2687,8 @@ static unsigned int ata_dev_xfermask(str
 		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
 		       "disabling DMA\n", ap->id, dev->devno);
 
-	return xfer_mask;
+	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
+			    &dev->udma_mask);
 }
 
 /**
@@ -4436,8 +4438,13 @@ static void ata_host_init(struct ata_por
 	INIT_WORK(&ap->port_task, NULL, NULL);
 	INIT_LIST_HEAD(&ap->eh_done_q);
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		ap->device[i].devno = i;
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		dev->devno = i;
+		dev->pio_mask = UINT_MAX;
+		dev->mwdma_mask = UINT_MAX;
+		dev->udma_mask = UINT_MAX;
+	}
 
 #ifdef ATA_IRQ_TRAP
 	ap->stats.unhandled_irq = 1;
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 7a54244..fbe8ba2 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -358,6 +358,11 @@ struct ata_device {
 	unsigned int		max_sectors;	/* per-device max sectors */
 	unsigned int		cdb_len;
 
+	/* per-dev xfer mask */
+	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
+	unsigned int		udma_mask;
+
 	/* for CHS addressing */
 	u16			cylinders;	/* Number of cylinders */
 	u16			heads;		/* Number of heads */
-- 
1.2.4


