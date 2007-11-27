From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 08/12] libata: implement ata_timing_cycle2mode() and use it in libata-acpi and pata_acpi
Date: Tue, 27 Nov 2007 19:43:45 +0900
Message-ID: <11961602312814-git-send-email-htejun@gmail.com>
References: <11961602293422-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.190]:39060 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754716AbXK0KoF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:44:05 -0500
Received: by rv-out-0910.google.com with SMTP id k20so840818rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:44:04 -0800 (PST)
In-Reply-To: <11961602293422-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

libata-acpi is using separate timing tables for transfer modes
although libata-core has the complete ata_timing table.  Implement
ata_timing_cycle2mode() to look for matching mode given transfer type
and cycle duration and use it in libata-acpi and pata_acpi to replace
private timing tables.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-acpi.c |   62 +++++++++++----------------------------------
 drivers/ata/libata-core.c |   52 +++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_acpi.c   |   13 +++++----
 include/linux/libata.h    |    5 +---
 4 files changed, 75 insertions(+), 57 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 6dc785d..ba6b61c 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -421,22 +421,6 @@ int ata_acpi_cbl_80wire(struct ata_port *ap)
 
 EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
 
-/* Welcome to ACPI, bring a bucket */
-const unsigned int ata_acpi_pio_cycle[7] = {
-	600, 383, 240, 180, 120, 100, 80
-};
-EXPORT_SYMBOL_GPL(ata_acpi_pio_cycle);
-
-const unsigned int ata_acpi_mwdma_cycle[5] = {
-	480, 150, 120, 100, 80
-};
-EXPORT_SYMBOL_GPL(ata_acpi_mwdma_cycle);
-
-const unsigned int ata_acpi_udma_cycle[7] = {
-	120, 80, 60, 45, 30, 20, 15
-};
-EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);
-
 /**
  * ata_acpi_gtm_xfermode - determine xfermode from GTM parameter
  * @dev: target device
@@ -453,49 +437,33 @@ EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);
 unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
 				    const struct ata_acpi_gtm *gtm)
 {
-	unsigned long pio_mask = 0, mwdma_mask = 0, udma_mask = 0;
-	int unit, i;
-	u32 t;
+	unsigned long xfer_mask = 0;
+	unsigned int type;
+	int unit;
+	u8 mode;
 
 	/* we always use the 0 slot for crap hardware */
 	unit = dev->devno;
 	if (!(gtm->flags & 0x10))
 		unit = 0;
 
-	/* Values larger than the longest cycle results in 0 mask
-	 * while values equal to smaller than the shortest cycle
-	 * results in mask which includes all supported modes.
-	 * Disabled transfer method has the value of 0xffffffff which
-	 * will always result in 0 mask.
-	 */
-
-	/* start by scanning for PIO modes */
-	t = gtm->drive[unit].pio;
-	for (i = 0; i < ARRAY_SIZE(ata_acpi_pio_cycle); i++)
-		if (t > ata_acpi_pio_cycle[i])
-			break;
-	pio_mask = (1 << i) - 1;
+	/* PIO */
+	mode = ata_timing_cycle2mode(ATA_SHIFT_PIO, gtm->drive[unit].pio);
+	xfer_mask |= ata_xfer_mode2mask(mode);
 
 	/* See if we have MWDMA or UDMA data. We don't bother with
 	 * MWDMA if UDMA is available as this means the BIOS set UDMA
 	 * and our error changedown if it works is UDMA to PIO anyway.
 	 */
-	t = gtm->drive[unit].dma;
-	if (!(gtm->flags & (1 << (2 * unit)))) {
-		/* MWDMA */
-		for (i = 0; i < ARRAY_SIZE(ata_acpi_mwdma_cycle); i++)
-			if (t > ata_acpi_mwdma_cycle[i])
-				break;
-		mwdma_mask = (1 << i) - 1;
-	} else {
-		/* UDMA */
-		for (i = 0; i < ARRAY_SIZE(ata_acpi_udma_cycle); i++)
-			if (t > ata_acpi_udma_cycle[i])
-				break;
-		udma_mask = (1 << i) - 1;
-	}
+	if (!(gtm->flags & (1 << (2 * unit))))
+		type = ATA_SHIFT_MWDMA;
+	else
+		type = ATA_SHIFT_UDMA;
+
+	mode = ata_timing_cycle2mode(type, gtm->drive[unit].dma);
+	xfer_mask |= ata_xfer_mode2mask(mode);
 
-	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
+	return xfer_mask;
 }
 EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
 
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 53caad7..9f57b8b 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2889,6 +2889,57 @@ int ata_timing_compute(struct ata_device *adev, unsigned short speed,
 }
 
 /**
+ *	ata_timing_cycle2mode - find xfer mode for the specified cycle duration
+ *	@xfer_shift: ATA_SHIFT_* value for transfer type to examine.
+ *	@cycle: cycle duration in ns
+ *
+ *	Return matching xfer mode for @cycle.  The returned mode is of
+ *	the transfer type specified by @xfer_shift.  If @cycle is too
+ *	slow for @xfer_shift, 0xff is returned.  If @cycle is faster
+ *	than the fastest known mode, the fasted mode is returned.
+ *
+ *	LOCKING:
+ *	None.
+ *
+ *	RETURNS:
+ *	Matching xfer_mode, 0xff if no match found.
+ */
+u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle)
+{
+	u8 base_mode = 0xff, last_mode = 0xff;
+	const struct ata_xfer_ent *ent;
+	const struct ata_timing *t;
+
+	for (ent = ata_xfer_tbl; ent->shift >= 0; ent++)
+		if (ent->shift == xfer_shift)
+			base_mode = ent->base;
+
+	for (t = ata_timing_find_mode(base_mode);
+	     t && ata_xfer_mode2shift(t->mode) == xfer_shift; t++) {
+		unsigned short this_cycle;
+
+		switch (xfer_shift) {
+		case ATA_SHIFT_PIO:
+		case ATA_SHIFT_MWDMA:
+			this_cycle = t->cycle;
+			break;
+		case ATA_SHIFT_UDMA:
+			this_cycle = t->udma;
+			break;
+		default:
+			return 0xff;
+		}
+
+		if (cycle > this_cycle)
+			break;
+
+		last_mode = t->mode;
+	}
+
+	return last_mode;
+}
+
+/**
  *	ata_down_xfermask_limit - adjust dev xfer masks downward
  *	@dev: Device to adjust xfer masks
  *	@sel: ATA_DNXFER_* selector
@@ -7585,6 +7636,7 @@ EXPORT_SYMBOL_GPL(ata_pio_need_iordy);
 EXPORT_SYMBOL_GPL(ata_timing_find_mode);
 EXPORT_SYMBOL_GPL(ata_timing_compute);
 EXPORT_SYMBOL_GPL(ata_timing_merge);
+EXPORT_SYMBOL_GPL(ata_timing_cycle2mode);
 
 #ifdef CONFIG_PCI
 EXPORT_SYMBOL_GPL(pci_test_config_bits);
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index a4737a3..244098a 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -133,13 +133,14 @@ static void pacpi_set_piomode(struct ata_port *ap, struct ata_device *adev)
 {
 	int unit = adev->devno;
 	struct pata_acpi *acpi = ap->private_data;
+	const struct ata_timing *t;
 
 	if (!(acpi->gtm.flags & 0x10))
 		unit = 0;
 
 	/* Now stuff the nS values into the structure */
-	acpi->gtm.drive[unit].pio =
-		ata_acpi_pio_cycle[adev->pio_mode - XFER_PIO_0];
+	t = ata_timing_find_mode(adev->pio_mode);
+	acpi->gtm.drive[unit].pio = t->cycle;
 	ata_acpi_stm(ap, &acpi->gtm);
 	/* See what mode we actually got */
 	ata_acpi_gtm(ap, &acpi->gtm);
@@ -155,18 +156,18 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 {
 	int unit = adev->devno;
 	struct pata_acpi *acpi = ap->private_data;
+	const struct ata_timing *t;
 
 	if (!(acpi->gtm.flags & 0x10))
 		unit = 0;
 
 	/* Now stuff the nS values into the structure */
+	t = ata_timing_find_mode(adev->dma_mode);
 	if (adev->dma_mode >= XFER_UDMA_0) {
-		acpi->gtm.drive[unit].dma =
-			ata_acpi_udma_cycle[adev->dma_mode - XFER_UDMA_0];
+		acpi->gtm.drive[unit].dma = t->udma;
 		acpi->gtm.flags |= (1 << (2 * unit));
 	} else {
-		acpi->gtm.drive[unit].dma =
-			ata_acpi_mwdma_cycle[adev->dma_mode - XFER_MW_DMA_0];
+		acpi->gtm.drive[unit].dma = t->cycle;
 		acpi->gtm.flags &= ~(1 << (2 * unit));
 	}
 	ata_acpi_stm(ap, &acpi->gtm);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index b631eef..a7b999a 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -937,6 +937,7 @@ extern int ata_timing_compute(struct ata_device *, unsigned short,
 extern void ata_timing_merge(const struct ata_timing *,
 			     const struct ata_timing *, struct ata_timing *,
 			     unsigned int);
+extern u8 ata_timing_cycle2mode(unsigned int xfer_shift, int cycle);
 
 enum {
 	ATA_TIMING_SETUP	= (1 << 0),
@@ -957,10 +958,6 @@ enum {
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
-extern const unsigned int ata_acpi_pio_cycle[7];
-extern const unsigned int ata_acpi_mwdma_cycle[5];
-extern const unsigned int ata_acpi_udma_cycle[7];
-
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
 int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
-- 
1.5.2.4

