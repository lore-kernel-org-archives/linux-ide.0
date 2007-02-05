From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (2.6.20) pata_mpiix: fix PIO setup issues
Date: Mon, 5 Feb 2007 20:24:57 +0300
Message-ID: <200702052024.57511.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:16232 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752037AbXBERZF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 12:25:05 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, alan@lxorguk.ukuu.org.uk

Fix clearing/setting the wrong TIME/IE/PPE bits for a slave drive caused by a
wrong shift count.
Fix the PIO mode 1 being overclocked by wrongly selecting the fast timing bank.
Also, fix/rephrase some comments while at it.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
 drivers/ata/pata_mpiix.c |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

Index: linux-2.6/drivers/ata/pata_mpiix.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_mpiix.c
+++ linux-2.6/drivers/ata/pata_mpiix.c
@@ -35,7 +35,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME "pata_mpiix"
-#define DRV_VERSION "0.7.3"
+#define DRV_VERSION "0.7.4"
 
 enum {
 	IDETIM = 0x6C,		/* IDE control register */
@@ -80,8 +80,8 @@ static void mpiix_error_handler(struct a
  *	@adev: ATA device
  *
  *	Called to do the PIO mode setup. The MPIIX allows us to program the
- *	IORDY sample point (2-5 clocks), recovery 1-4 clocks and whether
- *	prefetching or iordy are used.
+ *	IORDY sample point (2-5 clocks), recovery (1-4 clocks) and whether
+ *	prefetching or IORDY are used.
  *
  *	This would get very ugly because we can only program timing for one
  *	device at a time, the other gets PIO0. Fortunately libata calls
@@ -103,18 +103,19 @@ static void mpiix_set_piomode(struct ata
 			    { 2, 3 }, };
 
 	pci_read_config_word(pdev, IDETIM, &idetim);
-	/* Mask the IORDY/TIME/PPE0 bank for this device */
+
+	/* Mask the IORDY/TIME/PPE for this device */
 	if (adev->class == ATA_DEV_ATA)
-		control |= PPE;		/* PPE enable for disk */
+		control |= PPE;		/* Enable prefetch/posting for disk */
 	if (ata_pio_need_iordy(adev))
-		control |= IORDY;	/* IORDY */
-	if (pio > 0)
+		control |= IORDY;
+	if (pio > 1)
 		control |= FTIM;	/* This drive is on the fast timing bank */
 
 	/* Mask out timing and clear both TIME bank selects */
 	idetim &= 0xCCEE;
-	idetim &= ~(0x07  << (2 * adev->devno));
-	idetim |= (control << (2 * adev->devno));
+	idetim &= ~(0x07  << (4 * adev->devno));
+	idetim |= control << (4 * adev->devno);
 
 	idetim |= (timings[pio][0] << 12) | (timings[pio][1] << 8);
 	pci_write_config_word(pdev, IDETIM, idetim);

