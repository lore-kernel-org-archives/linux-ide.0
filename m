From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] alim15x3: fix CD_ROM DMA and PIO FIFO settings setup
Date: Mon, 17 Sep 2007 22:07:11 +0200
Message-ID: <200709172207.11275.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.173]:8879 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753547AbXIQUIS (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 17 Sep 2007 16:08:18 -0400
Received: by ug-out-1314.google.com with SMTP id z38so8883ugc
        for <linux-ide@vger.kernel.org>; Mon, 17 Sep 2007 13:08:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Setup CD_ROM DMA and PIO FIFO settings in init_chipset_ali15x3() instead
  of ata66_ali15x3().  The latter is called from init_hwif_common_ali15x3()
  only if DMA base exists (which insists m5529_revision > 0x20).

  This changes makes CD_ROM DMA / PIO FIFO bits being set only once
  and also when "idex=ata66" kernel parameter is used.

* While at it move also chip_is_1543c_e setup from ata66_ali15x3() to
  init_chipset_ali15x3() and check if isa_dev exists before accessing it.

* Bump driver version.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/alim15x3.c |   60 +++++++++++++++++++++++----------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/alim15x3.c		Version 0.27	Aug 27 2007
+ * linux/drivers/ide/pci/alim15x3.c		Version 0.28	Sep 15 2007
  *
  *  Copyright (C) 1998-2000 Michel Aubry, Maintainer
  *  Copyright (C) 1998-2000 Andrzej Krzysztofowicz, Maintainer
@@ -492,6 +492,13 @@ static unsigned int __devinit init_chips
 		 * clear bit 7
 		 */
 		pci_write_config_byte(dev, 0x4b, tmpbyte & 0x7F);
+		/*
+		 * check m1533, 0x5e, bit 1~4 == 1001 => & 00011110 = 00010010
+		 */
+		if (m5229_revision >= 0x20 && isa_dev) {
+			pci_read_config_byte(isa_dev, 0x5e, &tmpbyte);
+			chip_is_1543c_e = ((tmpbyte & 0x1e) == 0x12) ? 1: 0;
+		}
 		goto out;
 	}
 
@@ -537,7 +544,30 @@ static unsigned int __devinit init_chips
 			pci_write_config_byte(isa_dev, 0x79, tmpbyte | 0x02);
 		}
 	}
+
 out:
+	/*
+	 * CD_ROM DMA on (m5229, 0x53, bit0)
+	 *      Enable this bit even if we want to use PIO.
+	 * PIO FIFO off (m5229, 0x53, bit1)
+	 *      The hardware will use 0x54h and 0x55h to control PIO FIFO.
+	 *	(Not on later devices it seems)
+	 *
+	 *	0x53 changes meaning on later revs - we must no touch
+	 *	bit 1 on them.  Need to check if 0x20 is the right break.
+	 */
+	if (m5229_revision >= 0x20) {
+		pci_read_config_byte(dev, 0x53, &tmpbyte);
+
+		if (m5229_revision <= 0x20)
+			tmpbyte = (tmpbyte & (~0x02)) | 0x01;
+		else if (m5229_revision == 0xc7 || m5229_revision == 0xc8)
+			tmpbyte |= 0x03;
+		else
+			tmpbyte |= 0x01;
+
+		pci_write_config_byte(dev, 0x53, tmpbyte);
+	}
 	pci_dev_put(north);
 	pci_dev_put(isa_dev);
 	local_irq_restore(flags);
@@ -616,36 +646,8 @@ static u8 __devinit ata66_ali15x3(ide_hw
 			if ((tmpbyte & (1 << hwif->channel)) == 0)
 				cbl = ATA_CBL_PATA80;
 		}
-	} else {
-		/*
-		 * check m1533, 0x5e, bit 1~4 == 1001 => & 00011110 = 00010010
-		 */
-		pci_read_config_byte(isa_dev, 0x5e, &tmpbyte);
-		chip_is_1543c_e = ((tmpbyte & 0x1e) == 0x12) ? 1: 0;
 	}
 
-	/*
-	 * CD_ROM DMA on (m5229, 0x53, bit0)
-	 *      Enable this bit even if we want to use PIO
-	 * PIO FIFO off (m5229, 0x53, bit1)
-	 *      The hardware will use 0x54h and 0x55h to control PIO FIFO
-	 *	(Not on later devices it seems)
-	 *
-	 *	0x53 changes meaning on later revs - we must no touch
-	 *	bit 1 on them. Need to check if 0x20 is the right break
-	 */
-	 
-	pci_read_config_byte(dev, 0x53, &tmpbyte);
-	
-	if(m5229_revision <= 0x20)
-		tmpbyte = (tmpbyte & (~0x02)) | 0x01;
-	else if (m5229_revision == 0xc7 || m5229_revision == 0xc8)
-		tmpbyte |= 0x03;
-	else
-		tmpbyte |= 0x01;
-
-	pci_write_config_byte(dev, 0x53, tmpbyte);
-
 	local_irq_restore(flags);
 
 	return cbl;
