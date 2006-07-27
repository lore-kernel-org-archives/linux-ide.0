From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: Add full Compact Flash support to libata
Date: Thu, 27 Jul 2006 17:13:30 +0100
Message-ID: <1154016810.13509.61.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:9166 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1750810AbWG0P4L (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jul 2006 11:56:11 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com, linux-ide@vger.kernel.org, akpm@osdl.org

This is mostly interesting from the embedded end of the universe
where people use the CFA high speed non UDMA modes more. Some generic
controllers can do PIO5 and friends, that will follow later on.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/drivers/scsi/libata-core.c linux-2.6.18-rc2-mm1/drivers/scsi/libata-core.c
--- linux.vanilla-2.6.18-rc2-mm1/drivers/scsi/libata-core.c	2006-07-27 16:19:52.077333872 +0100
+++ linux-2.6.18-rc2-mm1/drivers/scsi/libata-core.c	2006-07-27 16:34:09.213029440 +0100
@@ -387,9 +387,13 @@
 		"PIO2",
 		"PIO3",
 		"PIO4",
+		"PIO5",
+		"PIO6",
 		"MWDMA0",
 		"MWDMA1",
 		"MWDMA2",
+		"MWDMA3",
+		"MWDMA4",
 		"UDMA/16",
 		"UDMA/25",
 		"UDMA/33",
@@ -876,6 +880,23 @@
 
 	mwdma_mask = id[ATA_ID_MWDMA_MODES] & 0x07;
 
+	if (ata_id_is_cfa(id)) {
+		/*
+		 *	Process compact flash extended modes
+		 */
+		int pio = id[163] & 0x7;
+		int dma = (id[163] >> 3) & 7;
+
+		if (pio)
+			pio_mask |= (1 << 5);
+		if (pio > 1)
+			pio_mask |= (1 << 6);
+		if (dma)
+			mwdma_mask |= (1 << 3);
+		if (dma > 1)
+			mwdma_mask |= (1 << 4);
+	}
+
 	udma_mask = 0;
 	if (id[ATA_ID_FIELD_VALID] & (1 << 2))
 		udma_mask = id[ATA_ID_UDMA_MODES] & 0xff;
@@ -1357,6 +1378,7 @@
 	struct ata_port *ap = dev->ap;
 	const u16 *id = dev->id;
 	unsigned int xfer_mask;
+	char revbuf[7];		/* XYZ-99\0 */
 	int rc;
 
 	if (!ata_dev_enabled(dev) && ata_msg_info(ap)) {
@@ -1400,6 +1422,15 @@
 
 	/* ATA-specific feature tests */
 	if (dev->class == ATA_DEV_ATA) {
+		if (ata_id_is_cfa(id)) {
+			if (id[162] & 1) /* CPRM may make this media unusable */
+				ata_dev_printk(dev, KERN_WARNING, "ata%u: device %u  supports DRM functions and may not be fully accessable.\n",
+					ap->id, dev->devno);
+			snprintf(revbuf, 7, "CFA");
+		}
+		else
+			snprintf(revbuf, 7, "ATA-%d",  ata_id_major_version(id));
+
 		dev->n_sectors = ata_id_n_sectors(id);
 
 		if (ata_id_has_lba(id)) {
@@ -1418,9 +1449,9 @@
 
 			/* print device info to dmesg */
 			if (ata_msg_drv(ap) && print_info)
-				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
+				ata_dev_printk(dev, KERN_INFO, "%s, "
 					"max %s, %Lu sectors: %s %s\n",
-					ata_id_major_version(id),
+					revbuf,
 					ata_mode_string(xfer_mask),
 					(unsigned long long)dev->n_sectors,
 					lba_desc, ncq_desc);
@@ -1441,9 +1472,9 @@
 
 			/* print device info to dmesg */
 			if (ata_msg_drv(ap) && print_info)
-				ata_dev_printk(dev, KERN_INFO, "ATA-%d, "
+				ata_dev_printk(dev, KERN_INFO, "%s, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
-					ata_id_major_version(id),
+					revbuf,
 					ata_mode_string(xfer_mask),
 					(unsigned long long)dev->n_sectors,
 					dev->cylinders, dev->heads,
@@ -1901,10 +1932,11 @@
  * drivers/ide/ide-timing.h and was originally written by Vojtech Pavlik
  */
 /*
- * PIO 0-5, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
+ * PIO 0-4, MWDMA 0-2 and UDMA 0-6 timings (in nanoseconds).
  * These were taken from ATA/ATAPI-6 standard, rev 0a, except
- * for PIO 5, which is a nonstandard extension and UDMA6, which
- * is currently supported only by Maxtor drives.
+ * for UDMA6, which is currently supported only by Maxtor drives.
+ *
+ * For PIO 5/6 MWDMA 3/4 see the CFA specification 3.0.
  */
 
 static const struct ata_timing ata_timing[] = {
@@ -1914,6 +1946,8 @@
 	{ XFER_UDMA_4,     0,   0,   0,   0,   0,   0,   0,  30 },
 	{ XFER_UDMA_3,     0,   0,   0,   0,   0,   0,   0,  45 },
 
+	{ XFER_MW_DMA_4,  25,   0,   0,   0,  55,  20,  80,   0 },
+	{ XFER_MW_DMA_3,  25,   0,   0,   0,  65,  25, 100,   0 },
 	{ XFER_UDMA_2,     0,   0,   0,   0,   0,   0,   0,  60 },
 	{ XFER_UDMA_1,     0,   0,   0,   0,   0,   0,   0,  80 },
 	{ XFER_UDMA_0,     0,   0,   0,   0,   0,   0,   0, 120 },
@@ -1928,7 +1962,8 @@
 	{ XFER_SW_DMA_1,  90,   0,   0,   0, 240, 240, 480,   0 },
 	{ XFER_SW_DMA_0, 120,   0,   0,   0, 480, 480, 960,   0 },
 
-/*	{ XFER_PIO_5,     20,  50,  30, 100,  50,  30, 100,   0 }, */
+	{ XFER_PIO_6,     10,  55,  20,  80,  55,  20,  80,   0 }, 
+	{ XFER_PIO_5,     15,  65,  25, 100,  65,  25, 100,   0 }, 
 	{ XFER_PIO_4,     25,  70,  25, 120,  70,  25, 120,   0 },
 	{ XFER_PIO_3,     30,  80,  70, 180,  80,  70, 180,   0 },
 
@@ -3073,6 +3108,17 @@
 					dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	/*
+	 *	CFA Advanced TrueIDE timings are not allowed on a shared
+	 *	cable
+	 */
+	if (ata_dev_pair(dev)) {
+		/* No PIO5 or PIO6 */
+		xfer_mask &= ~(0x03 << (ATA_SHIFT_PIO + 5));
+		/* No MWDMA3 or MWDMA 4 */
+		xfer_mask &= ~(0x03 << (ATA_SHIFT_MWDMA + 3));
+	}
+
 	if (ata_dma_blacklisted(dev)) {
 		xfer_mask &= ~(ATA_MASK_MWDMA | ATA_MASK_UDMA);
 		ata_dev_printk(dev, KERN_WARNING,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/include/linux/ata.h linux-2.6.18-rc2-mm1/include/linux/ata.h
--- linux.vanilla-2.6.18-rc2-mm1/include/linux/ata.h	2006-07-27 16:19:52.946201784 +0100
+++ linux-2.6.18-rc2-mm1/include/linux/ata.h	2006-07-27 16:24:49.697088792 +0100
@@ -170,12 +170,16 @@
 	XFER_UDMA_2		= 0x42,
 	XFER_UDMA_1		= 0x41,
 	XFER_UDMA_0		= 0x40,
+	XFER_MW_DMA_4		= 0x24,	/* CFA only */
+	XFER_MW_DMA_3		= 0x23,	/* CFA only */
 	XFER_MW_DMA_2		= 0x22,
 	XFER_MW_DMA_1		= 0x21,
 	XFER_MW_DMA_0		= 0x20,
 	XFER_SW_DMA_2		= 0x12,
 	XFER_SW_DMA_1		= 0x11,
 	XFER_SW_DMA_0		= 0x10,
+	XFER_PIO_6		= 0x0E,	/* CFA only */
+	XFER_PIO_5		= 0x0D,	/* CFA only */
 	XFER_PIO_4		= 0x0C,
 	XFER_PIO_3		= 0x0B,
 	XFER_PIO_2		= 0x0A,
@@ -274,7 +278,6 @@
 };
 
 #define ata_id_is_ata(id)	(((id)[0] & (1 << 15)) == 0)
-#define ata_id_is_cfa(id)	((id)[0] == 0x848A)
 #define ata_id_is_sata(id)	((id)[93] == 0)
 #define ata_id_rahead_enabled(id) ((id)[85] & (1 << 6))
 #define ata_id_wcache_enabled(id) ((id)[85] & (1 << 5))
@@ -306,6 +309,9 @@
 {
 	unsigned int mver;
 
+	if (id[ATA_ID_MAJOR_VER] == 0xFFFF)
+		return 0;
+
 	for (mver = 14; mver >= 1; mver--)
 		if (id[ATA_ID_MAJOR_VER] & (1 << mver))
 			break;
@@ -324,6 +330,18 @@
 		id[56];    /* sectors in current translation */
 }
 
+static inline int ata_id_is_cfa(const u16 *id)
+{
+	u16 v = id[0];
+	if (v == 0x848A)	/* Standard CF */
+		return 1;
+	/* Could be CF hiding as standard ATA */
+	if (ata_id_major_version(id) >= 3 &&  id[82] != 0xFFFF && 
+			(id[82] & ( 1 << 2)))
+		return 1;
+	return 0;
+}
+	
 static inline int atapi_cdb_len(const u16 *dev_id)
 {
 	u16 tmp = dev_id[0] & 0x3;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.18-rc2-mm1/include/linux/libata.h linux-2.6.18-rc2-mm1/include/linux/libata.h
--- linux.vanilla-2.6.18-rc2-mm1/include/linux/libata.h	2006-07-27 16:19:53.711085504 +0100
+++ linux-2.6.18-rc2-mm1/include/linux/libata.h	2006-07-27 16:25:29.462043600 +0100
@@ -225,8 +225,8 @@
 	/* encoding various smaller bitmaps into a single
 	 * unsigned int bitmap
 	 */
-	ATA_BITS_PIO		= 5,
-	ATA_BITS_MWDMA		= 3,
+	ATA_BITS_PIO		= 7,
+	ATA_BITS_MWDMA		= 5,
 	ATA_BITS_UDMA		= 8,
 
 	ATA_SHIFT_PIO		= 0,

