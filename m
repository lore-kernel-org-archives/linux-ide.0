From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: handle broken cable reporting
Date: Mon, 5 Nov 2007 22:58:58 +0000
Message-ID: <20071105225858.6c9d11eb@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49089 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752028AbXKEW6U (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Nov 2007 17:58:20 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, jeff@garzik.org, linux-ide@vger.kernel.org

One or two ancient drives predated the cable spec and didn't sent the
valid bits for the field. I had hoped to leave this out of libata as a
piece of historical annoyance but a recent CD drive shows the same bug so
we have to import support for it. 

Same concept as Bartlomiej's changes old IDE except that as we have
centralised blacklists we can avoid keeping another private table of stuff

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc1/drivers/ata/libata-core.c linux-2.6.24-rc1/drivers/ata/libata-core.c
--- linux.vanilla-2.6.24-rc1/drivers/ata/libata-core.c	2007-11-01 11:41:54.000000000 +0000
+++ linux-2.6.24-rc1/drivers/ata/libata-core.c	2007-11-05 22:26:24.523526768 +0000
@@ -4003,6 +4014,10 @@
 	{ "ST340823A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
 	{ "ST320413A",		NULL,		ATA_HORKAGE_HPA_SIZE, },
 
+	/* Devices which get the IVB wrong */
+	{ "QUANTUM FIREBALLlct10 05", "A03.0900", ATA_HORKAGE_IVB, },
+	{ "TSSTcorp CDDVDW SH-S202J", "SB00",	  ATA_HORKAGE_IVB, },
+
 	/* End Marker */
 	{ }
 };
@@ -4064,6 +4079,21 @@
 }
 
 /**
+ *	ata_is_40wire		-	check drive side detection
+ *	@dev: device
+ *
+ *	Perform drive side detection decoding, allowing for device vendors
+ *	who can't follow the documentation.
+ */
+
+static int ata_is_40wire(struct ata_device *dev)
+{
+	if (dev->horkage & ATA_HORKAGE_IVB)
+		return ata_drive_40wire_relaxed(dev->id);
+	return ata_drive_40wire(dev->id);
+}
+
+/**
  *	ata_dev_xfermask - Compute supported xfermask of the given device
  *	@dev: Device to compute xfermask for
  *
@@ -4132,7 +4162,7 @@
 	if (xfer_mask & (0xF8 << ATA_SHIFT_UDMA))
 		/* UDMA/44 or higher would be available */
 		if ((ap->cbl == ATA_CBL_PATA40) ||
-		    (ata_drive_40wire(dev->id) &&
+   		    (ata_is_40wire(dev) &&
 		    (ap->cbl == ATA_CBL_PATA_UNK ||
 		     ap->cbl == ATA_CBL_PATA80))) {
 			ata_dev_printk(dev, KERN_WARNING,
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc1/include/linux/ata.h linux-2.6.24-rc1/include/linux/ata.h
--- linux.vanilla-2.6.24-rc1/include/linux/ata.h	2007-11-01 11:42:08.000000000 +0000
+++ linux-2.6.24-rc1/include/linux/ata.h	2007-11-05 22:25:33.822234536 +0000
@@ -512,6 +532,15 @@
 	return 1;
 }
 
+static inline int ata_drive_40wire_relaxed(const u16 *dev_id)
+{
+	if (ata_id_is_sata(dev_id))
+		return 0;	/* SATA */
+	if ((dev_id[93] & 0x2000) == 0x2000)
+		return 0;	/* 80 wire */
+	return 1;
+}
+
 static inline int atapi_cdb_len(const u16 *dev_id)
 {
 	u16 tmp = dev_id[0] & 0x3;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.24-rc1/include/linux/libata.h linux-2.6.24-rc1/include/linux/libata.h
--- linux.vanilla-2.6.24-rc1/include/linux/libata.h	2007-11-01 11:42:08.000000000 +0000
+++ linux-2.6.24-rc1/include/linux/libata.h	2007-11-05 22:25:33.830233320 +0000
@@ -325,6 +325,7 @@
 	ATA_HORKAGE_BROKEN_HPA	= (1 << 4),	/* Broken HPA */
 	ATA_HORKAGE_SKIP_PM	= (1 << 5),	/* Skip PM operations */
 	ATA_HORKAGE_HPA_SIZE	= (1 << 6),	/* native size off by one */
+	ATA_HORKAGE_IVB		= ( 1<< 7),	/* validity bit bugs on cable detect */
 
 	 /* DMA mask for user DMA control: User visible values; DO NOT
 	    renumber */
