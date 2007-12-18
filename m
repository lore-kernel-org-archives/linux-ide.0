From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/5] libata: fix ata_acpi_gtm_xfermask()
Date: Tue, 18 Dec 2007 16:33:04 +0900
Message-ID: <11979631882948-git-send-email-htejun@gmail.com>
References: <1197963187184-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:64085 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934534AbXLRHdP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2007 02:33:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2173663rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 17 Dec 2007 23:33:14 -0800 (PST)
In-Reply-To: <1197963187184-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

ata_acpi_gtm_xfermask() as separated out from pacpi_discover_modes()
has various bugs.  Fix them.

* The wrong comparison operator is used when finding for matching
  cycle resulting totally bogus result.

* With the comparion operator fixed, boundary condtion handling is
  clumsy.

* Setting of any DMA mask bit set all bits in PIO mask.

* MWDMA and UDMA blocks are swapped.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-acpi.c |   42 +++++++++++++++++++++---------------------
 1 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index d6697ba..9f0b208 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -473,49 +473,49 @@ EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);
 unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
 				    const struct ata_acpi_gtm *gtm)
 {
+	unsigned long pio_mask = 0, mwdma_mask = 0, udma_mask = 0;
 	int unit, i;
 	u32 t;
-	unsigned long mask = (0x7f << ATA_SHIFT_UDMA) | (0x7 << ATA_SHIFT_MWDMA) | (0x1F << ATA_SHIFT_PIO);
 
 	/* we always use the 0 slot for crap hardware */
 	unit = dev->devno;
 	if (!(gtm->flags & 0x10))
 		unit = 0;
 
+	/* Values larger than the longest cycle results in 0 mask
+	 * while values equal to smaller than the shortest cycle
+	 * results in mask which includes all supported modes.
+	 * Disabled transfer method has the value of 0xffffffff which
+	 * will always result in 0 mask.
+	 */
+
 	/* start by scanning for PIO modes */
-	for (i = 0; i < 7; i++) {
-		t = gtm->drive[unit].pio;
-		if (t <= ata_acpi_pio_cycle[i]) {
-			mask |= (2 << (ATA_SHIFT_PIO + i)) - 1;
+	t = gtm->drive[unit].pio;
+	for (i = 0; i < ARRAY_SIZE(ata_acpi_pio_cycle); i++)
+		if (t > ata_acpi_pio_cycle[i])
 			break;
-		}
-	}
+	pio_mask = (1 << i) - 1;
 
 	/* See if we have MWDMA or UDMA data. We don't bother with
 	 * MWDMA if UDMA is available as this means the BIOS set UDMA
 	 * and our error changedown if it works is UDMA to PIO anyway.
 	 */
-	if (gtm->flags & (1 << (2 * unit))) {
+	t = gtm->drive[unit].dma;
+	if (!(gtm->flags & (1 << (2 * unit)))) {
 		/* MWDMA */
-		for (i = 0; i < 5; i++) {
-			t = gtm->drive[unit].dma;
-			if (t <= ata_acpi_mwdma_cycle[i]) {
-				mask |= (2 << (ATA_SHIFT_MWDMA + i)) - 1;
+		for (i = 0; i < ARRAY_SIZE(ata_acpi_mwdma_cycle); i++)
+			if (t > ata_acpi_mwdma_cycle[i])
 				break;
-			}
-		}
+		mwdma_mask = (1 << i) - 1;
 	} else {
 		/* UDMA */
-		for (i = 0; i < 7; i++) {
-			t = gtm->drive[unit].dma;
-			if (t <= ata_acpi_udma_cycle[i]) {
-				mask |= (2 << (ATA_SHIFT_UDMA + i)) - 1;
+		for (i = 0; i < ARRAY_SIZE(ata_acpi_udma_cycle); i++)
+			if (t > ata_acpi_udma_cycle[i])
 				break;
-			}
-		}
+		udma_mask = (1 << i) - 1;
 	}
 
-	return mask;
+	return ata_pack_xfermask(pio_mask, mwdma_mask, udma_mask);
 }
 EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
 
-- 
1.5.2.4

