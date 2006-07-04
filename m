From: alan@lxorguk.ukuu.org.uk
Subject: [PATCH 02/24] pata_ali - further debug work
Date: Tue, 4 Jul 2006 18:14:24 +0000 (UTC)
Message-ID: <1152036109888-git-send-email-alan@lxorguk.ukuu.org.uk>
References: <1152036108346-git-send-email-alan@lxorguk.ukuu.org.uk> <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk>
Reply-To: alan@lxorguk.ukuu.org.uk
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43918 "EHLO
	hraefn.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S932301AbWGDSOP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Jul 2006 14:14:15 -0400
Date: Maw, 04 Gor 2006 19:01:26 +0100
In-Reply-To: <1152036109145-git-send-email-alan@lxorguk.ukuu.org.uk>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: akpm@osdl.org, linux-ide@vger.kernel.org, root <root@hraefn.swansea.linux.org.uk>, Alan Cox <alan@redhat.com>

From: root <root@hraefn.swansea.linux.org.uk>

Further mode setup work for ALi. Follow BIOS guide for the FIFO setup

Signed-off-by: Alan Cox <alan@redhat.com>


---

 drivers/scsi/pata_ali.c |   21 ++++++++++++++-------
 1 files changed, 14 insertions(+), 7 deletions(-)

7dd0e43445080ca5410c99cc4d6788037cdc9138
diff --git a/drivers/scsi/pata_ali.c b/drivers/scsi/pata_ali.c
index 1889551..eacc13b 100644
--- a/drivers/scsi/pata_ali.c
+++ b/drivers/scsi/pata_ali.c
@@ -34,7 +34,7 @@
 #include <linux/dmi.h>
 
 #define DRV_NAME "pata_ali"
-#define DRV_VERSION "0.6.1"
+#define DRV_VERSION "0.6.3"
 
 /*
  *	Cable special cases
@@ -181,11 +181,12 @@ static void ali_fifo_control(struct ata_
 	u8 fifo;
 	int shift = 4 * adev->devno;
 
-	/* Bits 3:2 (7:6 for slave) control the PIO. 00 is off 01
-	   is on. The FIFO must not be used for ATAPI. We preserve
-	   BIOS set thresholds */
+	/* ATA - FIFO on set nibble to 0x05, ATAPI - FIFO off, set nibble to
+	   0x00. Not all the docs agree but the behaviour we now use is the
+	   one stated in the BIOS Programming Guide */
+	   
 	pci_read_config_byte(pdev, pio_fifo, &fifo);
-	fifo &= ~(0x0C << shift);
+	fifo &= ~(0x0F << shift);
 	if (on)
 		fifo |= (on << shift);
 	pci_write_config_byte(pdev, pio_fifo, fifo);
@@ -261,10 +262,10 @@ static void ali_set_piomode(struct ata_p
 
 	/* PIO FIFO is only permitted on ATA disk */
 	if (adev->class != ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0);
+		ali_fifo_control(ap, adev, 0x00);
 	ali_program_modes(ap, adev, &t, 0);
 	if (adev->class == ATA_DEV_ATA)
-		ali_fifo_control(ap, adev, 0x04);
+		ali_fifo_control(ap, adev, 0x05);
 
 }
 
@@ -289,6 +290,12 @@ static void ali_set_dmamode(struct ata_p
 
 	if (adev->dma_mode >= XFER_UDMA_0) {
 		ali_program_modes(ap, adev, NULL, udma_timing[adev->dma_mode - XFER_UDMA_0]);
+		if (adev->dma_mode >= XFER_UDMA_3) {
+			u8 reg54;
+			pci_read_config_byte(pdev, 0x54, &reg54);
+			reg54 |= 1;
+			pci_write_config_byte(pdev, 0x54, reg54);
+		}
 	} else {
 		ata_timing_compute(adev, adev->dma_mode, &t, T, 1);
 		if (pair) {
-- 
1.2.GIT

