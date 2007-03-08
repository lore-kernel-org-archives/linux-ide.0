From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata-core: Fix the iordy methods
Date: Thu, 8 Mar 2007 23:22:59 +0000
Message-ID: <20070308232259.661e1564@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:47068 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030794AbXCHWTN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 8 Mar 2007 17:19:13 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

This alone isn't sufficient to save the universe from prehistoric disks
and controllers but it is a first important step. Split off a separate
function to provide a mode filter when controller iordy is not available.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c
--- linux.vanilla-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:01:10.000000000 +0000
+++ linux-2.6.21-rc3-mm2/drivers/ata/libata-core.c	2007-03-08 16:02:52.000000000 +0000
@@ -1379,30 +1379,44 @@
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
