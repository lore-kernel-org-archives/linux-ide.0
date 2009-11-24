From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] pata_hpt{37x|3x2n}: fix timing register masks
Date: Wed, 25 Nov 2009 00:15:52 +0400
Message-ID: <200911242315.52826.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([206.112.117.35]:10697 "HELO
	imap.sh.mvista.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S932508AbZKXUO7 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 24 Nov 2009 15:14:59 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jgarzik@pobox.com
Cc: linux-ide@vger.kernel.org, stable@kernel.org, alan@lxorguk.ukuu.org.uk

These drivers inherited from the older 'hpt366' IDE driver the buggy timing
register masks in their set_piomode() metods. As a result, too low command
cycle active time is programmed for slow PIO modes.  Quite fortunately, it's
later "fixed up" by the set_dmamode() methods which also "helpfully" reprogram
the command timings, usually to PIO mode 4.

However, the drivers added some breakage of their own too:  the bit that they
set/clear to control the FIFO is wrong -- it's actually the MSB of the command
cycle setup time; setting it in DMA mode is also wrong as this bit is only for
PIO actually...

Fix all this and bump the drivers' versions, accounting for recenjt patches
that forgot to do it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: stable@kernel.org

---
The patch is against the recent Linus' tree. It's intended to go into all
stable kernels starting with 2.6.19, when the PATA drivers were first merged.

 drivers/ata/pata_hpt37x.c  |   13 ++++++-------
 drivers/ata/pata_hpt3x2n.c |   13 ++++++-------
 2 files changed, 12 insertions(+), 14 deletions(-)

Index: linux-2.6/drivers/ata/pata_hpt37x.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt37x.c
+++ linux-2.6/drivers/ata/pata_hpt37x.c
@@ -24,7 +24,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.12"
+#define DRV_VERSION	"0.6.14"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -404,9 +404,9 @@ static void hpt370_set_piomode(struct at
 
 	pci_read_config_dword(pdev, addr1, &reg);
 	mode = hpt37x_find_mode(ap, adev->pio_mode);
-	mode &= ~0x8000000;	/* No FIFO in PIO */
-	mode &= ~0x30070000;	/* Leave config bits alone */
-	reg &= 0x30070000;	/* Strip timing bits */
+	mode &= ~0x80000000;	/* Disable FIFO */
+	mode &= ~0x303C0000;	/* Leave config/UDMA bits alone */
+	reg &= 0x303C0000;	/* Strip timing bits */
 	pci_write_config_dword(pdev, addr1, reg | mode);
 }
 
@@ -438,9 +438,8 @@ static void hpt370_set_dmamode(struct at
 
 	pci_read_config_dword(pdev, addr1, &reg);
 	mode = hpt37x_find_mode(ap, adev->dma_mode);
-	mode |= 0x8000000;	/* FIFO in MWDMA or UDMA */
-	mode &= ~0xC0000000;	/* Leave config bits alone */
-	reg &= 0xC0000000;	/* Strip timing bits */
+	mode &= ~0xCE03FE00;	/* Leave config/command bits alone */
+	reg &= 0xCE03FE00;	/* Strip timing bits */
 	pci_write_config_dword(pdev, addr1, reg | mode);
 }
 
Index: linux-2.6/drivers/ata/pata_hpt3x2n.c
===================================================================
--- linux-2.6.orig/drivers/ata/pata_hpt3x2n.c
+++ linux-2.6/drivers/ata/pata_hpt3x2n.c
@@ -25,7 +25,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt3x2n"
-#define DRV_VERSION	"0.3.4"
+#define DRV_VERSION	"0.3.7"
 
 enum {
 	HPT_PCI_FAST	=	(1 << 31),
@@ -185,9 +185,9 @@ static void hpt3x2n_set_piomode(struct a
 
 	pci_read_config_dword(pdev, addr1, &reg);
 	mode = hpt3x2n_find_mode(ap, adev->pio_mode);
-	mode &= ~0x8000000;	/* No FIFO in PIO */
-	mode &= ~0x30070000;	/* Leave config bits alone */
-	reg &= 0x30070000;	/* Strip timing bits */
+	mode &= ~0x80000000;	/* Disable FIFO */
+	mode &= ~0x303C0000;	/* Leave config/UDMA bits alone */
+	reg &= 0x303C0000;	/* Strip timing bits */
 	pci_write_config_dword(pdev, addr1, reg | mode);
 }
 
@@ -218,9 +218,8 @@ static void hpt3x2n_set_dmamode(struct a
 
 	pci_read_config_dword(pdev, addr1, &reg);
 	mode = hpt3x2n_find_mode(ap, adev->dma_mode);
-	mode |= 0x8000000;	/* FIFO in MWDMA or UDMA */
-	mode &= ~0xC0000000;	/* Leave config bits alone */
-	reg &= 0xC0000000;	/* Strip timing bits */
+	mode &= ~0xCE03FE00;	/* Leave config/command bits alone */
+	reg &= 0xCE03FE00;	/* Strip timing bits */
 	pci_write_config_dword(pdev, addr1, reg | mode);
 }
 

