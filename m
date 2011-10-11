From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/3] pata_sil680: documentation fixes
Date: Tue, 11 Oct 2011 20:17:05 +0200
Message-ID: <201110112017.06133.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH v2] pata_sil680: documentation fixes

Fix documentation for sil680_sel[reg,dev]() and sil680_set_[pio,dma]mode().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_sil680.c |   24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

Index: b/drivers/ata/pata_sil680.c
===================================================================
--- a/drivers/ata/pata_sil680.c
+++ b/drivers/ata/pata_sil680.c
@@ -38,11 +38,12 @@
 
 /**
  *	sil680_selreg		-	return register base
- *	@hwif: interface
+ *	@ap: ATA interface
  *	@r: config offset
  *
- *	Turn a config register offset into the right address in either
- *	PCI space or MMIO space to access the control register in question
+ *	Turn a config register offset into the right address in PCI space
+ *	to access the control register in question.
+ *
  *	Thankfully this is a configuration operation so isn't performance
  *	criticial.
  */
@@ -56,12 +57,12 @@ static unsigned long sil680_selreg(struc
 
 /**
  *	sil680_seldev		-	return register base
- *	@hwif: interface
+ *	@ap: ATA interface
  *	@r: config offset
  *
- *	Turn a config register offset into the right address in either
- *	PCI space or MMIO space to access the control register in question
- *	including accounting for the unit shift.
+ *	Turn a config register offset into the right address in PCI space
+ *	to access the control register in question including accounting for
+ *	the unit shift.
  */
 
 static unsigned long sil680_seldev(struct ata_port *ap, struct ata_device *adev, int r)
@@ -93,7 +94,7 @@ static int sil680_cable_detect(struct at
 }
 
 /**
- *	sil680_set_piomode	-	set initial PIO mode data
+ *	sil680_set_piomode	-	set PIO mode data
  *	@ap: ATA interface
  *	@adev: ATA device
  *
@@ -140,12 +141,13 @@ static void sil680_set_piomode(struct at
 }
 
 /**
- *	sil680_set_dmamode	-	set initial DMA mode data
+ *	sil680_set_dmamode	-	set DMA mode data
  *	@ap: ATA interface
  *	@adev: ATA device
  *
- *	Program the MWDMA/UDMA modes for the sil680 k
- *	chipset. The MWDMA mode values are pulled from a lookup table
+ *	Program the MWDMA/UDMA modes for the sil680 chipset.
+ *
+ *	The MWDMA mode values are pulled from a lookup table
  *	while the chipset uses mode number for UDMA.
  */
 
