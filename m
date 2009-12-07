From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH 1/5] pata_hpt3x2n: always stretch UltraDMA timing
Date: Mon, 7 Dec 2009 23:25:52 +0400
Message-ID: <200912072225.52223.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:50576 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1758773AbZLGTYi (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 7 Dec 2009 14:24:38 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

The UltraDMA Tss timing must be stretched with ATA clock of 66 MHz, but the
driver only does this when PCI clock is 66 MHz, whereas it always programs
DPLL clock (which is used as the ATA clock) to 66 MHz.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: <stable@kernel.org>

---
The patch is against the recent Linus' tree. It's intended to go into all
stable kernels up to 2.6.22 -- when HPT371N support was merged.

 drivers/ata/pata_hpt3x2n.c |   20 ++++++++++----------
 1 files changed, 10 insertions(+), 10 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.8"
+#define DRV_VERSION	"0.3.9"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -547,16 +547,16 @@ static int hpt3x2n_init_one(struct pci_d
 	       pci_mhz);
 	/* Set our private data up. We only need a few flags so we use
 	   it directly */
-	if (pci_mhz > 60) {
+	if (pci_mhz > 60)
 		hpriv = (void *)(PCI66 | USE_DPLL);
-		/*
-		 * On  HPT371N, if ATA clock is 66 MHz we must set bit 2 in
-		 * the MISC. register to stretch the UltraDMA Tss timing.
-		 * NOTE: This register is only writeable via I/O space.
-		 */
-		if (dev->device == PCI_DEVICE_ID_TTI_HPT371)
-			outb(inb(iobase + 0x9c) | 0x04, iobase + 0x9c);
-	}
+
+	/*
+	 * On  HPT371N, if ATA clock is 66 MHz we must set bit 2 in
+	 * the MISC. register to stretch the UltraDMA Tss timing.
+	 * NOTE: This register is only writeable via I/O space.
+	 */
+	if (dev->device == PCI_DEVICE_ID_TTI_HPT371)
+		outb(inb(iobase + 0x9c) | 0x04, iobase + 0x9c);
 
 	/* Now kick off ATA set up */
 	return ata_pci_sff_init_one(dev, ppi, &hpt3x2n_sht, hpriv);

