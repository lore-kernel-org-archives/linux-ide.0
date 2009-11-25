From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 24/86] pata_cs5520: remove dead VDMA support
Date: Wed, 25 Nov 2009 18:05:11 +0100
Message-ID: <20091125170511.5446.43970.sendpatchset@localhost>
References: <20091125170218.5446.13513.sendpatchset@localhost>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1759261AbZKYRGE@vger.kernel.org>
In-Reply-To: <20091125170218.5446.13513.sendpatchset@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5520: remove dead VDMA support

It has been dead for the last three years (== since the initial driver
merge) and probability that it will ever get fixed is quite low.

Since there is no reason to keep this dead code around any longer just
remove it (it can still be retrieved from the git history if necessary).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5520.c |   39 +--------------------------------------
 1 file changed, 1 insertion(+), 38 deletions(-)

Index: b/drivers/ata/pata_cs5520.c
===================================================================
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -90,48 +90,12 @@ static void cs5520_set_timings(struct at
 }
 
 /**
- *	cs5520_enable_dma	-	turn on DMA bits
- *
- *	Turn on the DMA bits for this disk. Needed because the BIOS probably
- *	has not done the work for us. Belongs in the core SATA code.
- */
-
-static void cs5520_enable_dma(struct ata_port *ap, struct ata_device *adev)
-{
-	/* Set the DMA enable/disable flag */
-	u8 reg = ioread8(ap->ioaddr.bmdma_addr + 0x02);
-	reg |= 1<<(adev->devno + 5);
-	iowrite8(reg, ap->ioaddr.bmdma_addr + 0x02);
-}
-
-/**
- *	cs5520_set_dmamode	-	program DMA timings
- *	@ap: ATA port
- *	@adev: ATA device
- *
- *	Program the DMA mode timings for the controller according to the pio
- *	clocking table. Note that this device sets the DMA timings to PIO
- *	mode values. This may seem bizarre but the 5520 architecture talks
- *	PIO mode to the disk and DMA mode to the controller so the underlying
- *	transfers are PIO timed.
- */
-
-static void cs5520_set_dmamode(struct ata_port *ap, struct ata_device *adev)
-{
-	static const int dma_xlate[3] = { XFER_PIO_0, XFER_PIO_3, XFER_PIO_4 };
-	cs5520_set_timings(ap, adev, dma_xlate[adev->dma_mode]);
-	cs5520_enable_dma(ap, adev);
-}
-
-/**
  *	cs5520_set_piomode	-	program PIO timings
  *	@ap: ATA port
  *	@adev: ATA device
  *
  *	Program the PIO mode timings for the controller according to the pio
- *	clocking table. We know pio_mode will equal dma_mode because of the
- *	CS5520 architecture. At least once we turned DMA on and wrote a
- *	mode setter.
+ *	clocking table.
  */
 
 static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
@@ -149,7 +113,6 @@ static struct ata_port_operations cs5520
 	.qc_prep		= ata_sff_dumb_qc_prep,
 	.cable_detect		= ata_cable_40wire,
 	.set_piomode		= cs5520_set_piomode,
-	.set_dmamode		= cs5520_set_dmamode,
 };
 
 static int __devinit cs5520_init_one(struct pci_dev *pdev, const struct pci_device_id *id)
