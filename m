From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: make ata_device and ata_port use unsigned int xfer_mask
Date: Thu, 16 Feb 2006 23:09:06 +0900
Message-ID: <11400989462545-git-send-email-htejun@gmail.com>
References: <43F3244B.2010600@gmail.com>
Reply-To: Tejun Heo <htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wproxy.gmail.com ([64.233.184.207]:57740 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932295AbWBPOJS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Feb 2006 09:09:18 -0500
Received: by wproxy.gmail.com with SMTP id 71so171759wri
        for <linux-ide@vger.kernel.org>; Thu, 16 Feb 2006 06:09:17 -0800 (PST)
In-Reply-To: <43F3244B.2010600@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, albertcc@tw.ibm.com, alan@lxorguk.ukuu.org.uk, bzolnier@gmail.com, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>

ata_device used pio_mode, dma_mode, xfer_mode and xfer_shift to
describe the currently configured transfer mode and ata_port used
pio_mask, mwdma_mask and udma_mask to describe supported trasnfer
modes.  This patch makes both ata_device and ata_port use single
unsigned int xfer_mask instead.

This change removes simplifies code in libata-core and makes
integration of later EH speed-down and per-device trasnfer mode
configuration easier.  This patch does not change any behavior.

Note that xfer_mode_str array is now only referenced in
ata_mode_string() and thus moved into the function.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 drivers/scsi/ata_piix.c     |    9 -
 drivers/scsi/libata-core.c  |  456 +++++++++++++++++--------------------------
 drivers/scsi/pdc_adma.c     |    2 
 drivers/scsi/sata_promise.c |    2 
 drivers/scsi/sata_sil.c     |    2 
 include/linux/libata.h      |  131 +++++++++++-
 6 files changed, 305 insertions(+), 297 deletions(-)

d6bbac7263b10a4fa5c52d8c3b1447e6ad762ebc
diff --git a/drivers/scsi/ata_piix.c b/drivers/scsi/ata_piix.c
index 4cc1108..f806772 100644
--- a/drivers/scsi/ata_piix.c
+++ b/drivers/scsi/ata_piix.c
@@ -348,7 +348,7 @@ static void piix_pata_cbl_detect(struct 
 	u8 tmp, mask;
 
 	/* no 80c support in host controller? */
-	if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
+	if (ata_xfer_mask2mode(ap->xfer_mask, ATA_SHIFT_UDMA) <= 2)
 		goto cbl40;
 
 	/* check BIOS cable detect results */
@@ -362,7 +362,7 @@ static void piix_pata_cbl_detect(struct 
 
 cbl40:
 	ap->cbl = ATA_CBL_PATA40;
-	ap->udma_mask &= ATA_UDMA_MASK_40C;
+	ap->xfer_mask &= ata_xfer_limitmask(ATA_SHIFT_UDMA, 2);
 }
 
 /**
@@ -474,7 +474,7 @@ static void piix_sata_phy_reset(struct a
 
 static void piix_set_piomode (struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned int pio	= adev->pio_mode - XFER_PIO_0;
+	unsigned int pio	= ata_xfer_mask2mode(ap->xfer_mask, ATA_SHIFT_PIO);
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	unsigned int is_slave	= (adev->devno != 0);
 	unsigned int master_port= ap->hard_port_no ? 0x42 : 0x40;
@@ -526,10 +526,9 @@ static void piix_set_piomode (struct ata
 
 static void piix_set_dmamode (struct ata_port *ap, struct ata_device *adev)
 {
-	unsigned int udma	= adev->dma_mode; /* FIXME: MWDMA too */
 	struct pci_dev *dev	= to_pci_dev(ap->host_set->dev);
 	u8 maslave		= ap->hard_port_no ? 0x42 : 0x40;
-	u8 speed		= udma;
+	u8 speed		= ata_xfer_modeval(ap->xfer_mask);
 	unsigned int drive_dn	= (ap->hard_port_no ? 2 : 0) + adev->devno;
 	int a_speed		= 3 << (drive_dn * 4);
 	int u_flag		= 1 << drive_dn;
diff --git a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
index c971c15..3286df1 100644
--- a/drivers/scsi/libata-core.c
+++ b/drivers/scsi/libata-core.c
@@ -65,11 +65,8 @@ static unsigned int ata_dev_init_params(
 					struct ata_device *dev);
 static void ata_set_mode(struct ata_port *ap);
 static void ata_dev_set_xfermode(struct ata_port *ap, struct ata_device *dev);
-static unsigned int ata_get_mode_mask(const struct ata_port *ap, int shift);
-static int fgb(u32 bitmap);
-static int ata_choose_xfer_mode(const struct ata_port *ap,
-				u8 *xfer_mode_out,
-				unsigned int *xfer_shift_out);
+static unsigned int ata_dev_xfermask(struct ata_port *ap,
+				     struct ata_device *dev);
 
 static unsigned int ata_unique_id = 1;
 static struct workqueue_struct *ata_wq;
@@ -227,58 +224,47 @@ int ata_rwcmd_protocol(struct ata_queued
 	return -1;
 }
 
-static const char * const xfer_mode_str[] = {
-	"UDMA/16",
-	"UDMA/25",
-	"UDMA/33",
-	"UDMA/44",
-	"UDMA/66",
-	"UDMA/100",
-	"UDMA/133",
-	"UDMA7",
-	"MWDMA0",
-	"MWDMA1",
-	"MWDMA2",
-	"PIO0",
-	"PIO1",
-	"PIO2",
-	"PIO3",
-	"PIO4",
-};
-
 /**
- *	ata_udma_string - convert UDMA bit offset to string
- *	@mask: mask of bits supported; only highest bit counts.
+ *	ata_mode_string - convert xfer_mask to string
+ *	@xfer_mask: mask of bits supported; only highest bit counts.
  *
  *	Determine string which represents the highest speed
- *	(highest bit in @udma_mask).
+ *	(highest bit in @modemask).
  *
  *	LOCKING:
  *	None.
  *
  *	RETURNS:
  *	Constant C string representing highest speed listed in
- *	@udma_mask, or the constant C string "<n/a>".
+ *	@modemask, or the constant C string "<n/a>".
  */
 
-static const char *ata_mode_string(unsigned int mask)
+static const char *ata_mode_string(unsigned int xfer_mask)
 {
-	int i;
-
-	for (i = 7; i >= 0; i--)
-		if (mask & (1 << i))
-			goto out;
-	for (i = ATA_SHIFT_MWDMA + 2; i >= ATA_SHIFT_MWDMA; i--)
-		if (mask & (1 << i))
-			goto out;
-	for (i = ATA_SHIFT_PIO + 4; i >= ATA_SHIFT_PIO; i--)
-		if (mask & (1 << i))
-			goto out;
-
+	static const char * const xfer_mode_str[] = {
+		"PIO0",
+		"PIO1",
+		"PIO2",
+		"PIO3",
+		"PIO4",
+		"MWDMA0",
+		"MWDMA1",
+		"MWDMA2",
+		"UDMA/16",
+		"UDMA/25",
+		"UDMA/33",
+		"UDMA/44",
+		"UDMA/66",
+		"UDMA/100",
+		"UDMA/133",
+		"UDMA7",
+	};
+	int highbit;
+
+	highbit = fls(xfer_mask) - 1;
+	if (highbit >= 0 && highbit < ARRAY_SIZE(xfer_mode_str))
+		return xfer_mode_str[highbit];
 	return "<n/a>";
-
-out:
-	return xfer_mode_str[i];
 }
 
 /**
@@ -688,33 +674,49 @@ static inline void ata_dump_id(const u16
 		id[93]);
 }
 
-/*
- *	Compute the PIO modes available for this device. This is not as
- *	trivial as it seems if we must consider early devices correctly.
+/**
+ *	ata_id_xfermask - Compute xfermask from the given IDENTIFY data
+ *	@id: IDENTIFY data to compute xfer mask from
+ *
+ *	Compute the xfermask for this device. This is not as trivial
+ *	as it seems if we must consider early devices correctly.
  *
- *	FIXME: pre IDE drive timing (do we care ?). 
+ *	FIXME: pre IDE drive timing (do we care ?).
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Computed xfermask
  */
-
-static unsigned int ata_pio_modes(const struct ata_device *adev)
+static unsigned int ata_id_xfermask(const u16 *id)
 {
-	u16 modes;
+	unsigned int pio_mask, mwdma_mask, udma_mask;
 
 	/* Usual case. Word 53 indicates word 64 is valid */
-	if (adev->id[ATA_ID_FIELD_VALID] & (1 << 1)) {
-		modes = adev->id[ATA_ID_PIO_MODES] & 0x03;
-		modes <<= 3;
-		modes |= 0x7;
-		return modes;
+	if (id[ATA_ID_FIELD_VALID] & (1 << 1)) {
+		pio_mask = id[ATA_ID_PIO_MODES] & 0x03;
+		pio_mask <<= 3;
+		pio_mask |= 0x7;
+	} else {
+		/* If word 64 isn't valid then Word 51 high byte holds
+		 * the PIO timing number for the maximum. Turn it into
+		 * a mask.
+		 */
+		pio_mask = (2 << (id[ATA_ID_OLD_PIO_MODES] & 0xFF)) - 1 ;
+
+		/* But wait.. there's more. Design your standards by
+		 * committee and you too can get a free iordy field to
+		 * process. However its the speeds not the modes that
+		 * are supported... Note drivers using the timing API
+		 * will get this right anyway
+		 */
 	}
 
-	/* If word 64 isn't valid then Word 51 high byte holds the PIO timing
-	   number for the maximum. Turn it into a mask and return it */
-	modes = (2 << ((adev->id[ATA_ID_OLD_PIO_MODES] >> 8) & 0xFF)) - 1 ;
-	return modes;
-	/* But wait.. there's more. Design your standards by committee and
-	   you too can get a free iordy field to process. However its the 
-	   speeds not the modes that are supported... Note drivers using the
-	   timing API will get this right anyway */
+	mwdma_mask = id[ATA_ID_MWDMA_MODES] & 0x07;
+	udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
+
+	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
 
 static inline void
@@ -879,13 +881,14 @@ ata_exec_internal(struct ata_port *ap, s
 unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 {
 	int pio;
-	int speed = adev->pio_mode - XFER_PIO_0;
+	unsigned int speed;
 
+	speed = ata_xfer_mask2mode(adev->xfer_mask, ATA_SHIFT_PIO);
 	if (speed < 2)
 		return 0;
 	if (speed > 2)
 		return 1;
-		
+
 	/* If we have no drive specific rule, then PIO 2 is non IORDY */
 
 	if (adev->id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE */
@@ -1073,7 +1076,7 @@ static inline u8 ata_dev_knobble(const s
 static int ata_dev_configure(struct ata_port *ap, struct ata_device *dev,
 			     int verbose)
 {
-	unsigned long xfer_modes;
+	unsigned int xfer_mask;
 	int i, rc;
 
 	if (!ata_dev_present(dev)) {
@@ -1104,12 +1107,8 @@ static int ata_dev_configure(struct ata_
 		goto err_out_nosup;
 	}
 
-	/* quick-n-dirty find max transfer mode; for printk only */
-	xfer_modes = dev->id[ATA_ID_UDMA_MODES];
-	if (!xfer_modes)
-		xfer_modes = (dev->id[ATA_ID_MWDMA_MODES]) << ATA_SHIFT_MWDMA;
-	if (!xfer_modes)
-		xfer_modes = ata_pio_modes(dev);
+	/* find max transfer mode; for printk only */
+	xfer_mask = ata_id_xfermask(dev->id);
 
 	ata_dump_id(dev->id);
 
@@ -1133,7 +1132,7 @@ static int ata_dev_configure(struct ata_
 				       "max %s, %Lu sectors: %s\n",
 				       ap->id, dev->devno,
 				       ata_id_major_version(dev->id),
-				       ata_mode_string(xfer_modes),
+				       ata_mode_string(xfer_mask),
 				       (unsigned long long)dev->n_sectors,
 				       lba_desc);
 		} else {
@@ -1157,7 +1156,7 @@ static int ata_dev_configure(struct ata_
 				       "max %s, %Lu sectors: CHS %u/%u/%u\n",
 				       ap->id, dev->devno,
 				       ata_id_major_version(dev->id),
-				       ata_mode_string(xfer_modes),
+				       ata_mode_string(xfer_mask),
 				       (unsigned long long)dev->n_sectors,
 				       dev->cylinders, dev->heads, dev->sectors);
 		}
@@ -1178,7 +1177,7 @@ static int ata_dev_configure(struct ata_
 		/* print device info to dmesg */
 		if (verbose)
 			printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
-			       ap->id, dev->devno, ata_mode_string(xfer_modes));
+			       ap->id, dev->devno, ata_mode_string(xfer_mask));
 	}
 
 	ap->host->max_cmd_len = 0;
@@ -1192,7 +1191,7 @@ static int ata_dev_configure(struct ata_
 		if (verbose)
 			printk(KERN_INFO "ata%u(%u): applying bridge limits\n",
 			       ap->id, dev->devno);
-		ap->udma_mask &= ATA_UDMA5;
+		ap->xfer_mask &= ata_xfer_limitmask(ATA_SHIFT_UDMA, 5);
 		dev->max_sectors = ATA_MAX_SECTORS;
 	}
 
@@ -1561,7 +1560,9 @@ int ata_timing_compute(struct ata_device
 	 */
 
 	if (speed > XFER_PIO_4) {
-		ata_timing_compute(adev, adev->pio_mode, &p, T, UT);
+		unsigned int pio_mode;
+		pio_mode = ata_xfer_modeval(adev->xfer_mask & ATA_MASK_PIO);
+		ata_timing_compute(adev, pio_mode, &p, T, UT);
 		ata_timing_merge(&p, t, t, ATA_TIMING_ALL);
 	}
 
@@ -1582,104 +1583,100 @@ int ata_timing_compute(struct ata_device
 	return 0;
 }
 
-static const struct {
-	unsigned int shift;
-	u8 base;
-} xfer_mode_classes[] = {
-	{ ATA_SHIFT_UDMA,	XFER_UDMA_0 },
-	{ ATA_SHIFT_MWDMA,	XFER_MW_DMA_0 },
-	{ ATA_SHIFT_PIO,	XFER_PIO_0 },
-};
-
-static u8 base_from_shift(unsigned int shift)
+/**
+ *	ata_xfer_modeval - Find matching XFER_* for the given xfer_mask
+ *	@xfer_mask: xfer_mask of interest
+ *
+ *	Return matching XFER_* value for @xfer_mask.  Only the highest
+ *	bit of @xfer_mask is considered.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Matching XFER_* value
+ */
+unsigned int ata_xfer_modeval(unsigned int xfer_mask)
 {
-	int i;
+	int idx = fls(xfer_mask) - 1;
+
+	BUG_ON(idx < 0);
+
+	if (idx < ATA_BITS_PIO)
+		return XFER_PIO_0 + idx;
+	idx -= ATA_BITS_PIO;
+
+	if (idx < ATA_BITS_MWDMA)
+		return XFER_MW_DMA_0 + idx;
+	idx -= ATA_BITS_MWDMA;
 
-	for (i = 0; i < ARRAY_SIZE(xfer_mode_classes); i++)
-		if (xfer_mode_classes[i].shift == shift)
-			return xfer_mode_classes[i].base;
+	if (idx < ATA_BITS_UDMA)
+		return XFER_UDMA_0 + idx;
 
-	return 0xff;
+	BUG();
+	return 0;
 }
 
 static void ata_dev_set_mode(struct ata_port *ap, struct ata_device *dev)
 {
-	int ofs, idx;
-	u8 base;
-
 	if (!ata_dev_present(dev) || (ap->flags & ATA_FLAG_PORT_DISABLED))
 		return;
 
-	if (dev->xfer_shift == ATA_SHIFT_PIO)
+	if (!(dev->xfer_mask & (ATA_MASK_MWDMA | ATA_MASK_UDMA)))
 		dev->flags |= ATA_DFLAG_PIO;
 
 	ata_dev_set_xfermode(ap, dev);
 
-	base = base_from_shift(dev->xfer_shift);
-	ofs = dev->xfer_mode - base;
-	idx = ofs + dev->xfer_shift;
-	WARN_ON(idx >= ARRAY_SIZE(xfer_mode_str));
-
 	if (ata_dev_revalidate(ap, dev, 0)) {
 		printk(KERN_ERR "ata%u: failed to revalidate after set "
 		       "xfermode, disabled\n", ap->id);
 		ata_port_disable(ap);
 	}
 
-	DPRINTK("idx=%d xfer_shift=%u, xfer_mode=0x%x, base=0x%x, offset=%d\n",
-		idx, dev->xfer_shift, (int)dev->xfer_mode, (int)base, ofs);
+	DPRINTK("ap->xfer_mask=0x%x dev->xfer_mask=0x%x,\n",
+		ap->xfer_mask, dev->xfer_mask);
 
 	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
-		ap->id, dev->devno, xfer_mode_str[idx]);
+	       ap->id, dev->devno, ata_mode_string(dev->xfer_mask));
 }
 
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
+		if (!(dev->xfer_mask & ATA_MASK_PIO)) {
+			printk(KERN_WARNING "ata%u: no PIO support\n", ap->id);
+			return -1;
 		}
+
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
+		if (!ata_dev_present(dev))
+			continue;
+
+		if (!(dev->xfer_mask & (ATA_MASK_MWDMA | ATA_MASK_UDMA)))
+			continue;
+
+		if (ap->ops->set_dmamode)
+			ap->ops->set_dmamode(ap, dev);
 	}
 }
 
@@ -1694,24 +1691,22 @@ static void ata_host_set_dma(struct ata_
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
+		if (ata_dev_present(dev))
+			dev->xfer_mask = ata_dev_xfermask(ap, dev);
+	}
 
-	/* step 2: choose the best data xfer mode */
-	xfer_mode = xfer_shift = 0;
-	rc = ata_choose_xfer_mode(ap, &xfer_mode, &xfer_shift);
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
 	ata_dev_set_mode(ap, &ap->device[0]);
@@ -2461,13 +2456,6 @@ int ata_dev_revalidate(struct ata_port *
 	return rc;
 }
 
-static void ata_pr_blacklisted(const struct ata_port *ap,
-			       const struct ata_device *dev)
-{
-	printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, disabling DMA\n",
-		ap->id, dev->devno);
-}
-
 static const char * const ata_dma_blacklist [] = {
 	"WDC AC11000H",
 	"WDC AC22100H",
@@ -2514,128 +2502,43 @@ static int ata_dma_blacklisted(const str
 	return 0;
 }
 
-static unsigned int ata_get_mode_mask(const struct ata_port *ap, int shift)
-{
-	const struct ata_device *master, *slave;
-	unsigned int mask;
-
-	master = &ap->device[0];
-	slave = &ap->device[1];
-
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
-	}
-
-	return mask;
-}
-
-/* find greatest bit */
-static int fgb(u32 bitmap)
-{
-	unsigned int i;
-	int x = -1;
-
-	for (i = 0; i < 32; i++)
-		if (bitmap & (1 << i))
-			x = i;
-
-	return x;
-}
-
 /**
- *	ata_choose_xfer_mode - attempt to find best transfer mode
- *	@ap: Port for which an xfer mode will be selected
- *	@xfer_mode_out: (output) SET FEATURES - XFER MODE code
- *	@xfer_shift_out: (output) bit shift that selects this mode
- *
- *	Based on host and device capabilities, determine the
- *	maximum transfer mode that is amenable to all.
+ *	ata_dev_xfermask - Compute supported xfermask of the given device
+ *	@ap: Port on which the device to compute xfermask for resides
+ *	@dev: Device to compute xfermask for
+ *
+ *	Compute supported xfermask of @dev.  This function is
+ *	responsible for applying all known limits including host
+ *	controller limits, device blacklist, etc...
  *
  *	LOCKING:
- *	PCI/etc. bus probe sem.
+ *	None.
  *
  *	RETURNS:
- *	Zero on success, negative on error.
+ *	Computed xfermask.
  */
+static unsigned int ata_dev_xfermask(struct ata_port *ap,
+				     struct ata_device *dev)
+{
+	unsigned long xfer_mask;
+	int i;
 
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
+	xfer_mask = ap->xfer_mask;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		if (!ata_dev_present(d))
+			continue;
+		xfer_mask &= ata_id_xfermask(d->id);
+		if (ata_dma_blacklisted(d))
+			xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 	}
 
-	return -1;
+	if (ata_dma_blacklisted(dev))
+		printk(KERN_WARNING "ata%u: dev %u is on DMA blacklist, "
+		       "disabling DMA\n", ap->id, dev->devno);
+
+	return xfer_mask;
 }
 
 /**
@@ -2662,7 +2565,7 @@ static void ata_dev_set_xfermode(struct 
 	tf.feature = SETFEATURES_XFER;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf.protocol = ATA_PROT_NODATA;
-	tf.nsect = dev->xfer_mode;
+	tf.nsect = ata_xfer_modeval(dev->xfer_mask);
 
 	if (ata_exec_internal(ap, dev, &tf, DMA_NONE, NULL, 0)) {
 		printk(KERN_ERR "ata%u: failed to set xfermode, disabled\n",
@@ -4600,9 +4503,9 @@ static void ata_host_init(struct ata_por
 	ap->port_no = port_no;
 	ap->hard_port_no =
 		ent->legacy_mode ? ent->hard_port_no : port_no;
-	ap->pio_mask = ent->pio_mask;
-	ap->mwdma_mask = ent->mwdma_mask;
-	ap->udma_mask = ent->udma_mask;
+	ap->xfer_mask = ata_pack_xfermask(ent->pio_mask,
+					  ent->mwdma_mask,
+					  ent->udma_mask);
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
 	ap->cbl = ATA_CBL_NONE;
@@ -4710,23 +4613,19 @@ int ata_device_add(const struct ata_prob
 	/* register each port bound to this device */
 	for (i = 0; i < ent->n_ports; i++) {
 		struct ata_port *ap;
-		unsigned long xfer_mode_mask;
 
 		ap = ata_host_add(ent, host_set, i);
 		if (!ap)
 			goto err_out;
 
 		host_set->ports[i] = ap;
-		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
-				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
-				(ap->pio_mask << ATA_SHIFT_PIO);
 
 		/* print per-port info to dmesg */
 		printk(KERN_INFO "ata%u: %cATA max %s cmd 0x%lX ctl 0x%lX "
 				 "bmdma 0x%lX irq %lu\n",
 			ap->id,
 			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-			ata_mode_string(xfer_mode_mask),
+			ata_mode_string(ap->xfer_mask),
 	       		ap->ioaddr.cmd_addr,
 	       		ap->ioaddr.ctl_addr,
 	       		ap->ioaddr.bmdma_addr,
@@ -5079,6 +4978,7 @@ EXPORT_SYMBOL_GPL(ata_drive_probe_reset)
 EXPORT_SYMBOL_GPL(ata_dev_revalidate);
 EXPORT_SYMBOL_GPL(ata_port_disable);
 EXPORT_SYMBOL_GPL(ata_ratelimit);
+EXPORT_SYMBOL_GPL(ata_xfer_modeval);
 EXPORT_SYMBOL_GPL(ata_busy_sleep);
 EXPORT_SYMBOL_GPL(ata_scsi_ioctl);
 EXPORT_SYMBOL_GPL(ata_scsi_queuecmd);
diff --git a/drivers/scsi/pdc_adma.c b/drivers/scsi/pdc_adma.c
index 5f33cc9..9f9b4d5 100644
--- a/drivers/scsi/pdc_adma.c
+++ b/drivers/scsi/pdc_adma.c
@@ -314,7 +314,7 @@ static int adma_fill_sg(struct ata_queue
 		if (ata_sg_is_last(sg, qc))
 			pFLAGS |= pEND;
 		buf[i++] = pFLAGS;
-		buf[i++] = qc->dev->dma_mode & 0xf;
+		buf[i++] = ata_xfer_mask2mode(qc->dev->xfer_mask, ATA_SHIFT_UDMA);
 		buf[i++] = 0;	/* pPKLW */
 		buf[i++] = 0;	/* reserved */
 
diff --git a/drivers/scsi/sata_promise.c b/drivers/scsi/sata_promise.c
index ba2b7a0..ab3f39a 100644
--- a/drivers/scsi/sata_promise.c
+++ b/drivers/scsi/sata_promise.c
@@ -367,7 +367,7 @@ static void pdc_pata_phy_reset(struct at
 {
 	/* FIXME: add cable detect.  Don't assume 40-pin cable */
 	ap->cbl = ATA_CBL_PATA40;
-	ap->udma_mask &= ATA_UDMA_MASK_40C;
+	ap->xfer_mask &= ata_xfer_limitmask(ATA_SHIFT_UDMA, 2);
 
 	pdc_reset_port(ap);
 	ata_port_probe(ap);
diff --git a/drivers/scsi/sata_sil.c b/drivers/scsi/sata_sil.c
index e14ed4e..4aeb2c3 100644
--- a/drivers/scsi/sata_sil.c
+++ b/drivers/scsi/sata_sil.c
@@ -360,7 +360,7 @@ static void sil_dev_config(struct ata_po
 	if (quirks & SIL_QUIRK_UDMA5MAX) {
 		printk(KERN_INFO "ata%u(%u): applying Maxtor errata fix %s\n",
 		       ap->id, dev->devno, model_num);
-		ap->udma_mask &= ATA_UDMA5;
+		ap->xfer_mask &= ata_xfer_limitmask(ATA_SHIFT_UDMA, 5);
 		return;
 	}
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 81014be..e0ffca4 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -188,11 +188,19 @@ enum {
 	PORT_DISABLED		= 2,
 
 	/* encoding various smaller bitmaps into a single
-	 * unsigned long bitmap
+	 * unsigned int bitmap
 	 */
-	ATA_SHIFT_UDMA		= 0,
-	ATA_SHIFT_MWDMA		= 8,
-	ATA_SHIFT_PIO		= 11,
+	ATA_BITS_PIO		= 5,
+	ATA_BITS_MWDMA		= 3,
+	ATA_BITS_UDMA		= 8,
+
+	ATA_SHIFT_PIO		= 0,
+	ATA_SHIFT_MWDMA		= ATA_SHIFT_PIO + ATA_BITS_PIO,
+	ATA_SHIFT_UDMA		= ATA_SHIFT_MWDMA + ATA_BITS_MWDMA,
+
+	ATA_MASK_PIO		= ((1 << ATA_BITS_PIO) - 1) << ATA_SHIFT_PIO,
+	ATA_MASK_MWDMA		= ((1 << ATA_BITS_MWDMA) - 1) << ATA_SHIFT_MWDMA,
+	ATA_MASK_UDMA		= ((1 << ATA_BITS_UDMA) - 1) << ATA_SHIFT_UDMA,
 
 	/* size of buffer to pad xfers ending on unaligned boundaries */
 	ATA_DMA_PAD_SZ		= 4,
@@ -340,10 +348,7 @@ struct ata_device {
 	unsigned int		class;		/* ATA_DEV_xxx */
 	unsigned int		devno;		/* 0 or 1 */
 	u16			*id;		/* IDENTIFY xxx DEVICE data */
-	u8			pio_mode;
-	u8			dma_mode;
-	u8			xfer_mode;
-	unsigned int		xfer_shift;	/* ATA_SHIFT_xxx */
+	unsigned int		xfer_mask;
 
 	unsigned int		multi_count;	/* sectors count for
 						   READ/WRITE MULTIPLE */
@@ -374,9 +379,7 @@ struct ata_port {
 
 	u8			ctl;	/* cache of ATA control register */
 	u8			last_ctl;	/* Cache last written value */
-	unsigned int		pio_mask;
-	unsigned int		mwdma_mask;
-	unsigned int		udma_mask;
+	unsigned int		xfer_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
 	struct ata_device	device[ATA_MAX_DEVICES];
@@ -512,6 +515,7 @@ extern int ata_scsi_device_suspend(struc
 extern int ata_device_resume(struct ata_port *, struct ata_device *);
 extern int ata_device_suspend(struct ata_port *, struct ata_device *);
 extern int ata_ratelimit(void);
+extern unsigned int ata_xfer_modeval(unsigned int xfer_mask);
 extern unsigned int ata_busy_sleep(struct ata_port *ap,
 				   unsigned long timeout_pat,
 				   unsigned long timeout);
@@ -604,6 +608,111 @@ extern int pci_test_config_bits(struct p
 #endif /* CONFIG_PCI */
 
 
+/**
+ *	ata_pack_xfermask - Pack pio, mwdma and udma masks into xfer_mask
+ *	@pio_mask: pio_mask
+ *	@mwdma_mask: mwdma_mask
+ *	@udma_mask: udma_mask
+ *
+ *	Pack @pio_mask, @mwdma_mask and @udma_mask into a single
+ *	unsigned int xfer_mask.  This is a macro such that it can be
+ *	used as an initializer.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Packed xfer_mask.
+ */
+#define ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask)		\
+	 ((((pio_mask) << ATA_SHIFT_PIO) & ATA_MASK_PIO) |		\
+	  (((mwdma_mask) << ATA_SHIFT_MWDMA) & ATA_MASK_MWDMA) |	\
+	  (((udma_mask) << ATA_SHIFT_UDMA) & ATA_MASK_UDMA))
+
+/**
+ *	ata_unpack_xfermask - Unpack xfer_mask into pio, mwdma and udma masks
+ *	@xfer_mask: xfer_mask to unpack
+ *	@pio_mask: Resulting pio_mask
+ *	@mwdma_mask: Resulting mwdma_mask
+ *	@udma_mask: Resulting udma_mask
+ *
+ *	Unpack @xfer_mask into @pio_mask, @mwdma_mask and @udma_mask.
+ *	Any NULL destination masks will be ignored.
+ *
+ *	LOCKING:
+ *	None.
+ */
+static inline void ata_unpack_xfermask(unsigned int xfer_mask,
+				       unsigned int *pio_mask,
+				       unsigned int *mwdma_mask,
+				       unsigned int *udma_mask)
+{
+	if (pio_mask)
+		*pio_mask = (xfer_mask & ATA_MASK_PIO) >> ATA_SHIFT_PIO;
+	if (mwdma_mask)
+		*mwdma_mask = (xfer_mask & ATA_MASK_MWDMA) >> ATA_SHIFT_MWDMA;
+	if (udma_mask)
+		*udma_mask = (xfer_mask & ATA_MASK_UDMA) >> ATA_SHIFT_UDMA;
+}
+
+static inline unsigned int __ata_xfer_shift2mask(int shift)
+{
+	switch (shift) {
+	case ATA_SHIFT_PIO:
+		return ATA_MASK_PIO;
+	case ATA_SHIFT_MWDMA:
+		return ATA_MASK_MWDMA;
+	case ATA_SHIFT_UDMA:
+		return ATA_MASK_UDMA;
+	}
+	BUG();
+	return 0;
+}
+
+/**
+ *	ata_xfer_mask2mode - Extract transfer mode of given type from xfer_mask
+ *	@xfer_mask: xfer_mask to extract transfer mode from
+ *	@shift: Target transfer type
+ *
+ *	Extract transfer mode of type @shift from @xfer_mask.  e.g. If
+ *	a xfer_mask has PIO 0-3 set, the following returns 3.
+ *
+ *	ata_xfer_mask2mode(xfer_mask, ATA_SHIFT_PIO)
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Extracted transfer mode
+ */
+static inline int ata_xfer_mask2mode(unsigned int xfer_mask, int shift)
+{
+	return fls(xfer_mask & __ata_xfer_shift2mask(shift)) - 1 - shift;
+}
+
+/**
+ *	ata_xfer_limitmask - Compute mask to limit transfer mode of given type
+ *	@shift: Transfer type to limit
+ *	@mode: Maximum transfer mode
+ *
+ *	Compute a bit mask which can be used to limit transfer mode of
+ *	the type @shift to @mode.  e.g. The following will return a
+ *	mask which turns off any PIO mode above PIO 3 but doesn't
+ *	affect any other transfer modes.
+ *
+ *	ata_xfer_limitmask(ATA_SHIFT_PIO, 3)
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Computed limit mask
+ */
+static inline unsigned int ata_xfer_limitmask(int shift, int mode)
+{
+	return ((1 << (shift + mode + 1)) - 1) | ~__ata_xfer_shift2mask(shift);
+}
+
 static inline int
 ata_sg_is_last(struct scatterlist *sg, struct ata_queued_cmd *qc)
 {
-- 
1.1.5


