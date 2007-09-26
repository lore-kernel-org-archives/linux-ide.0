From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_pdc202xx_old
Date: Wed, 26 Sep 2007 15:23:17 +0100
Message-ID: <20070926152317.67f4d6fd@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:49545 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753705AbXIZORQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 10:17:16 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org, jeff@garzik.org, akpm@osdl.org

I've been doing an audit of this driver to try and find out why we have
problems with some Clevo boxes that use it. Didn't get anywhere other
than to discover all the bug reporters I have use vmware, which may or
may not be chance.

In the process however I did find out our MWDMA2 performance was a bit
low and code review showed the MWDMA0/2 timings are reversed due to a
thinko in the table ordering

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --exclude-from /usr/src/exclude --new-file --recursive linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_pdc202xx_old.c linux-2.6.23rc6-mm1/drivers/ata/pata_pdc202xx_old.c
--- linux.vanilla-2.6.23rc6-mm1/drivers/ata/pata_pdc202xx_old.c	2007-09-18 15:32:51.000000000 +0100
+++ linux-2.6.23rc6-mm1/drivers/ata/pata_pdc202xx_old.c	2007-09-26 14:03:33.430372856 +0100
@@ -9,7 +9,7 @@
  * First cut with LBA48/ATAPI
  *
  * TODO:
- *	Channel interlock/reset on both required
+ *	Channel interlock/reset on both required ?
  */
 
 #include <linux/kernel.h>
@@ -22,7 +22,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_pdc202xx_old"
-#define DRV_VERSION "0.4.2"
+#define DRV_VERSION "0.4.3"
 
 static int pdc2026x_cable_detect(struct ata_port *ap)
 {
@@ -106,9 +106,9 @@
 		{ 0x20, 0x01 }
 	};
 	static u8 mdma_timing[3][2] = {
-		{ 0x60, 0x03 },
-		{ 0x60, 0x04 },
 		{ 0xe0, 0x0f },
+		{ 0x60, 0x04 },
+		{ 0x60, 0x03 },
 	};
 	u8 r_bp, r_cp;
 
@@ -139,6 +139,9 @@
  *
  *	In UDMA3 or higher we have to clock switch for the duration of the
  *	DMA transfer sequence.
+ *
+ *	Note: The host lock held by the libata layer protects
+ *	us from two channels both trying to set DMA bits at once
  */
 
 static void pdc2026x_bmdma_start(struct ata_queued_cmd *qc)
@@ -187,6 +190,9 @@
  *
  *	After a DMA completes we need to put the clock back to 33MHz for
  *	PIO timings.
+ *
+ *	Note: The host lock held by the libata layer protects
+ *	us from two channels both trying to set DMA bits at once
  */
 
 static void pdc2026x_bmdma_stop(struct ata_queued_cmd *qc)
@@ -206,7 +212,6 @@
 		iowrite32(0, atapi_reg);
 		iowrite8(ioread8(clock) & ~sel66, clock);
 	}
-	/* Check we keep host level locking here */
 	/* Flip back to 33Mhz for PIO */
 	if (adev->dma_mode >= XFER_UDMA_2)
 		iowrite8(ioread8(clock) & ~sel66, clock);
