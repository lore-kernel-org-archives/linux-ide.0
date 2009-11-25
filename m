From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 07/86] pata_artop: remove dead 34MHz PCI clock support
Date: Wed, 25 Nov 2009 18:03:07 +0100
Message-ID: <20091125170307.5446.12439.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1758997AbZKYRDv@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_artop: remove dead 34MHz PCI clock support

It has been dead for the last three years (== since the initial driver
merge) and probability that it will ever get fixed is quite low.

Since there is no reason to keep this dead code around any longer just
remove it (it can still be retrieved from the git history if necessary).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_artop.c |   29 ++++++++---------------------
 1 file changed, 8 insertions(+), 21 deletions(-)

Index: b/drivers/ata/pata_artop.c
===================================================================
--- a/drivers/ata/pata_artop.c
+++ b/drivers/ata/pata_artop.c
@@ -30,15 +30,6 @@
 #define DRV_NAME	"pata_artop"
 #define DRV_VERSION	"0.4.5"
 
-/*
- *	The ARTOP has 33 Mhz and "over clocked" timing tables. Until we
- *	get PCI bus speed functionality we leave this as 0. Its a variable
- *	for when we get the functionality and also for folks wanting to
- *	test stuff.
- */
-
-static int clock = 0;
-
 /**
  *	atp8xx_prereset	-	probe begin
  *	@link: link
@@ -101,13 +92,11 @@ static void atp850_load_piomode(struct a
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
-	const u16 timing[2][5] = {
-		{ 0x0000, 0x000A, 0x0008, 0x0303, 0x0301 },
-		{ 0x0700, 0x070A, 0x0708, 0x0403, 0x0401 }
+	const u16 timing[5] =
+		{ 0x0000, 0x000A, 0x0008, 0x0303, 0x0301 };
 
-	};
 	/* Load the PIO timing active/recovery bits */
-	pci_write_config_word(pdev, 0x40 + 2 * dn, timing[clock][pio]);
+	pci_write_config_word(pdev, 0x40 + 2 * dn, timing[pio]);
 }
 
 /**
@@ -156,13 +145,11 @@ static void atp86x_load_piomode(struct a
 {
 	struct pci_dev *pdev	= to_pci_dev(ap->host->dev);
 	int dn = adev->devno + 2 * ap->port_no;
-	const u8 timing[2][5] = {
-		{ 0x00, 0x0A, 0x08, 0x33, 0x31 },
-		{ 0x70, 0x7A, 0x78, 0x43, 0x41 }
+	const u8 timing[5] =
+		{ 0x00, 0x0A, 0x08, 0x33, 0x31 };
 
-	};
 	/* Load the PIO timing active/recovery bits */
-	pci_write_config_byte(pdev, 0x40 + dn, timing[clock][pio]);
+	pci_write_config_byte(pdev, 0x40 + dn, timing[pio]);
 }
 
 /**
@@ -223,7 +210,7 @@ static void atp850_set_dmamode(struct at
 
 	/* Add ultra DMA bits if in UDMA mode */
 	if (adev->dma_mode >= XFER_UDMA_0) {
-		u8 mode = (adev->dma_mode - XFER_UDMA_0) + 1 - clock;
+		u8 mode = (adev->dma_mode - XFER_UDMA_0) + 1;
 		if (mode == 0)
 			mode = 1;
 		ultra |= (mode << (2 * dn));
@@ -261,7 +248,7 @@ static void atp86x_set_dmamode(struct at
 	pci_read_config_byte(pdev, 0x44 + ap->port_no, &ultra);
 	ultra &= ~(7 << (4  * adev->devno));	/* One nibble per drive */
 	if (adev->dma_mode >= XFER_UDMA_0) {
-		u8 mode = adev->dma_mode - XFER_UDMA_0 + 1 - clock;
+		u8 mode = adev->dma_mode - XFER_UDMA_0 + 1;
 		if (mode == 0)
 			mode = 1;
 		ultra |= (mode << (4 * adev->devno));
