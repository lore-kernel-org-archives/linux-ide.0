From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: IORDY handling, quiet handling
Date: Mon, 5 Feb 2007 16:25:44 +0000
Message-ID: <20070205162544.5e55cff0@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:48340 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751567AbXBEQMv (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 11:12:51 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org

For further review

Turn on the IORDY handling logic.

If a controller doesnt support IORDY don't try and use it
If a device doesn't support IORDY don't try and use it
Otherwise use it whenever possible.
Always use IORDY for PIO3 and higher (it's mandatory)

Send the correct set_features command if operating without IORDY

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/libata-core.c	2007-02-01 16:14:01.000000000 +0000
@@ -1404,30 +1446,44 @@
  *	Check if the current speed of the device requires IORDY. Used
  *	by various controllers for chip configuration.
  */
-
+ 
 unsigned int ata_pio_need_iordy(const struct ata_device *adev)
 {
-	int pio;
-	int speed = adev->pio_mode - XFER_PIO_0;
-
-	if (speed < 2)
+	/* Controller doesn't support  IORDY. Probably a pointless check
+	   as the caller should know this */
+	if (adev->ap->flags & ATA_FLAG_NO_IORDY)
 		return 0;
-	if (speed > 2)
+	/* PIO3 and higher it is mandatory */
+	if (adev->pio_mode > XFER_PIO_2)
 		return 1;
+	/* We turn it on when possible */
+	if (ata_id_has_iordy(adev->id))
+		return 1;
+	return 0;
+}
 
+/**
+ *	ata_pio_mask_no_iordy	-	Return the non IORDY mask
+ *	@adev: ATA device
+ *
+ *	Compute the highest mode possible if we are not using iordy. Return
+ *	-1 if no iordy mode is available.
+ */
+ 
+static u32 ata_pio_mask_no_iordy(const struct ata_device *adev)
+{
 	/* If we have no drive specific rule, then PIO 2 is non IORDY */
-
 	if (adev->id[ATA_ID_FIELD_VALID] & 2) {	/* EIDE */
-		pio = adev->id[ATA_ID_EIDE_PIO];
+		u16 pio = adev->id[ATA_ID_EIDE_PIO];
 		/* Is the speed faster than the drive allows non IORDY ? */
 		if (pio) {
 			/* This is cycle times not frequency - watch the logic! */
 			if (pio > 240)	/* PIO2 is 240nS per cycle */
-				return 1;
-			return 0;
+				return 3 << ATA_SHIFT_PIO;
+			return 7 << ATA_SHIFT_PIO;
 		}
 	}
-	return 0;
+	return 3 << ATA_SHIFT_PIO;
 }
 
 /**
@@ -3410,6 +3470,9 @@
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	if (ap->flags & ATA_FLAG_NO_IORDY)
+		xfer_mask &= ata_pio_mask_no_iordy(dev);
+
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared
 	 *	cable
@@ -3466,8 +3529,18 @@
 	tf.command = ATA_CMD_SET_FEATURES;
 	tf.feature = SETFEATURES_XFER;
 	tf.flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
+
+	/* Older CFA may not support this command */
+	if (ata_id_is_cfa(dev->id))
+        	tf.flags |= ATA_TFLAG_QUIET;
+
 	tf.protocol = ATA_PROT_NODATA;
-	tf.nsect = dev->xfer_mode;
+
+	/* Ancient devices may need us to avoid IORDY */
+	if (ata_pio_need_iordy(dev))
+		tf.nsect = dev->xfer_mode;
+	else
+		tf.nsect = 0x01;
 
 	err_mask = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
 
