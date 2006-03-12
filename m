From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 3/4] libata: add per-dev pio/mwdma/udma_mask
Date: Sun, 12 Mar 2006 16:02:35 +0900
Message-ID: <11421469551000-git-send-email-htejun@gmail.com>
References: <11421469551948-git-send-email-htejun@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from pproxy.gmail.com ([64.233.166.176]:26697 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751361AbWCLHCk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 12 Mar 2006 02:02:40 -0500
Received: by pproxy.gmail.com with SMTP id d42so679702pyd
        for <linux-ide@vger.kernel.org>; Sat, 11 Mar 2006 23:02:40 -0800 (PST)
In-Reply-To: <11421469551948-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

Add per-dev pio/mwdma/udma_mask.  All transfer mode limits used to be
applied to ap->*_mask which unnecessarily restricted other devices
sharing the port.  This change will also benefit later EH speed down
and hotplug.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/libata-core.c |   38 ++++++++++++++++++++++----------------
 include/linux/libata.h     |    5 +++++
 2 files changed, 27 insertions(+), 16 deletions(-)

ff1f6ace25a33e2338f7dc18a15951e7aa22c14f
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index eef67f5..beedc4b 100644
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
@@ -1058,6 +1057,10 @@ static void ata_dev_init(struct ata_port
 {
 	memset(dev, 0, sizeof(*dev));
 	dev->devno = dev - ap->device;
+
+	dev->pio_mask = UINT_MAX;
+	dev->mwdma_mask = UINT_MAX;
+	dev->udma_mask = UINT_MAX;
 }
 
 /**
@@ -1825,16 +1828,19 @@ static void ata_set_mode(struct ata_port
 	/* step 1: calculate xfer_mask */
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
-		unsigned int xfer_mask;
+		unsigned int pio_mask, dma_mask;
 
 		if (!ata_dev_present(dev))
 			continue;
 
-		xfer_mask = ata_dev_xfermask(ap, dev);
+		ata_dev_xfermask(ap, dev);
+
+		/* TODO: let LLDD filter dev->*_mask here */
 
-		dev->pio_mode = ata_xfer_mask2mode(xfer_mask & ATA_MASK_PIO);
-		dev->dma_mode = ata_xfer_mask2mode(xfer_mask & (ATA_MASK_MWDMA |
-								ATA_MASK_UDMA));
+		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
+		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
+		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
+		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 	}
 
 	/* step 2: always set host PIO timings */
@@ -2643,18 +2649,15 @@ static int ata_dma_blacklisted(const str
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
@@ -2667,6 +2670,8 @@ static unsigned int ata_dev_xfermask(str
 		struct ata_device *d = &ap->device[i];
 		if (!ata_dev_present(d))
 			continue;
+		xfer_mask &= ata_pack_xfermask(d->pio_mask, d->mwdma_mask,
+					       d->udma_mask);
 		xfer_mask &= ata_id_xfermask(d->id);
 		if (ata_dma_blacklisted(d))
 			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
@@ -2676,7 +2681,8 @@ static unsigned int ata_dev_xfermask(str
 		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
 		       "disabling DMA\n", ap->id, dev->devno);
 
-	return xfer_mask;
+	ata_unpack_xfermask(xfer_mask, &dev->pio_mask, &dev->mwdma_mask,
+			    &dev->udma_mask);
 }
 
 /**
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 239408e..2c624af 100644
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


