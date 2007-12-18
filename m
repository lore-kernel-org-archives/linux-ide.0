From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 1/5] libata: separate out ata_acpi_gtm_xfermask() from pacpi_discover_modes()
Date: Tue, 18 Dec 2007 16:33:03 +0900
Message-ID: <11979631871447-git-send-email-htejun@gmail.com>
References: <1197963187184-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:64101 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934543AbXLRHdP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2007 02:33:15 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2173665rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 17 Dec 2007 23:33:15 -0800 (PST)
In-Reply-To: <1197963187184-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Finding out matching transfer mode from ACPI GTM values is useful for
other purposes too.  Separate out the function and timing tables from
pata_acpi::pacpi_discover_modes().

Other than checking shared-configuration bit after doing
ata_acpi_gtm() in pacpi_discover_modes() which should be safe, this
patch doesn't introduce any behavior change.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-acpi.c |   78 +++++++++++++++++++++++++++++++++++++++++++++
 drivers/ata/pata_acpi.c   |   66 ++++++-------------------------------
 include/linux/libata.h    |   25 ++++++++++++++
 3 files changed, 114 insertions(+), 55 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index ebc4dfc..d6697ba 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -441,6 +441,84 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf)
 	return rc;
 }
 
+/* Welcome to ACPI, bring a bucket */
+const unsigned int ata_acpi_pio_cycle[7] = {
+	600, 383, 240, 180, 120, 100, 80
+};
+EXPORT_SYMBOL_GPL(ata_acpi_pio_cycle);
+
+const unsigned int ata_acpi_mwdma_cycle[5] = {
+	480, 150, 120, 100, 80
+};
+EXPORT_SYMBOL_GPL(ata_acpi_mwdma_cycle);
+
+const unsigned int ata_acpi_udma_cycle[7] = {
+	120, 80, 60, 45, 30, 20, 15
+};
+EXPORT_SYMBOL_GPL(ata_acpi_udma_cycle);
+
+/**
+ * ata_acpi_gtm_xfermode - determine xfermode from GTM parameter
+ * @dev: target device
+ * @gtm: GTM parameter to use
+ *
+ * Determine xfermask for @dev from @gtm.
+ *
+ * LOCKING:
+ * None.
+ *
+ * RETURNS:
+ * Determined xfermask.
+ */
+unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
+				    const struct ata_acpi_gtm *gtm)
+{
+	int unit, i;
+	u32 t;
+	unsigned long mask = (0x7f << ATA_SHIFT_UDMA) | (0x7 << ATA_SHIFT_MWDMA) | (0x1F << ATA_SHIFT_PIO);
+
+	/* we always use the 0 slot for crap hardware */
+	unit = dev->devno;
+	if (!(gtm->flags & 0x10))
+		unit = 0;
+
+	/* start by scanning for PIO modes */
+	for (i = 0; i < 7; i++) {
+		t = gtm->drive[unit].pio;
+		if (t <= ata_acpi_pio_cycle[i]) {
+			mask |= (2 << (ATA_SHIFT_PIO + i)) - 1;
+			break;
+		}
+	}
+
+	/* See if we have MWDMA or UDMA data. We don't bother with
+	 * MWDMA if UDMA is available as this means the BIOS set UDMA
+	 * and our error changedown if it works is UDMA to PIO anyway.
+	 */
+	if (gtm->flags & (1 << (2 * unit))) {
+		/* MWDMA */
+		for (i = 0; i < 5; i++) {
+			t = gtm->drive[unit].dma;
+			if (t <= ata_acpi_mwdma_cycle[i]) {
+				mask |= (2 << (ATA_SHIFT_MWDMA + i)) - 1;
+				break;
+			}
+		}
+	} else {
+		/* UDMA */
+		for (i = 0; i < 7; i++) {
+			t = gtm->drive[unit].dma;
+			if (t <= ata_acpi_udma_cycle[i]) {
+				mask |= (2 << (ATA_SHIFT_UDMA + i)) - 1;
+				break;
+			}
+		}
+	}
+
+	return mask;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
+
 /**
  * ata_acpi_cbl_80wire		-	Check for 80 wire cable
  * @ap: Port to check
diff --git a/drivers/ata/pata_acpi.c b/drivers/ata/pata_acpi.c
index e4542ab..a4737a3 100644
--- a/drivers/ata/pata_acpi.c
+++ b/drivers/ata/pata_acpi.c
@@ -81,17 +81,6 @@ static void pacpi_error_handler(struct ata_port *ap)
 				  NULL, ata_std_postreset);
 }
 
-/* Welcome to ACPI, bring a bucket */
-static const unsigned int pio_cycle[7] = {
-	600, 383, 240, 180, 120, 100, 80
-};
-static const unsigned int mwdma_cycle[5] = {
-	480, 150, 120, 100, 80
-};
-static const unsigned int udma_cycle[7] = {
-	120, 80, 60, 45, 30, 20, 15
-};
-
 /**
  *	pacpi_discover_modes	-	filter non ACPI modes
  *	@adev: ATA device
@@ -103,56 +92,20 @@ static const unsigned int udma_cycle[7] = {
 
 static unsigned long pacpi_discover_modes(struct ata_port *ap, struct ata_device *adev)
 {
-	int unit = adev->devno;
 	struct pata_acpi *acpi = ap->private_data;
-	int i;
-	u32 t;
-	unsigned long mask = (0x7f << ATA_SHIFT_UDMA) | (0x7 << ATA_SHIFT_MWDMA) | (0x1F << ATA_SHIFT_PIO);
-
 	struct ata_acpi_gtm probe;
+	unsigned int xfer_mask;
 
 	probe = acpi->gtm;
 
-	/* We always use the 0 slot for crap hardware */
-	if (!(probe.flags & 0x10))
-		unit = 0;
-
 	ata_acpi_gtm(ap, &probe);
 
-	/* Start by scanning for PIO modes */
-	for (i = 0; i < 7; i++) {
-		t = probe.drive[unit].pio;
-		if (t <= pio_cycle[i]) {
-			mask |= (2 << (ATA_SHIFT_PIO + i)) - 1;
-			break;
-		}
-	}
+	xfer_mask = ata_acpi_gtm_xfermask(adev, &probe);
 
-	/* See if we have MWDMA or UDMA data. We don't bother with MWDMA
-	   if UDMA is availabe as this means the BIOS set UDMA and our
-	   error changedown if it works is UDMA to PIO anyway */
-	if (probe.flags & (1 << (2 * unit))) {
-		/* MWDMA */
-		for (i = 0; i < 5; i++) {
-			t = probe.drive[unit].dma;
-			if (t <= mwdma_cycle[i]) {
-				mask |= (2 << (ATA_SHIFT_MWDMA + i)) - 1;
-				break;
-			}
-		}
-	} else {
-		/* UDMA */
-		for (i = 0; i < 7; i++) {
-			t = probe.drive[unit].dma;
-			if (t <= udma_cycle[i]) {
-				mask |= (2 << (ATA_SHIFT_UDMA + i)) - 1;
-				break;
-			}
-		}
-	}
-	if (mask & (0xF8 << ATA_SHIFT_UDMA))
+	if (xfer_mask & (0xF8 << ATA_SHIFT_UDMA))
 		ap->cbl = ATA_CBL_PATA80;
-	return mask;
+
+	return xfer_mask;
 }
 
 /**
@@ -185,7 +138,8 @@ static void pacpi_set_piomode(struct ata_port *ap, struct ata_device *adev)
 		unit = 0;
 
 	/* Now stuff the nS values into the structure */
-	acpi->gtm.drive[unit].pio = pio_cycle[adev->pio_mode - XFER_PIO_0];
+	acpi->gtm.drive[unit].pio =
+		ata_acpi_pio_cycle[adev->pio_mode - XFER_PIO_0];
 	ata_acpi_stm(ap, &acpi->gtm);
 	/* See what mode we actually got */
 	ata_acpi_gtm(ap, &acpi->gtm);
@@ -207,10 +161,12 @@ static void pacpi_set_dmamode(struct ata_port *ap, struct ata_device *adev)
 
 	/* Now stuff the nS values into the structure */
 	if (adev->dma_mode >= XFER_UDMA_0) {
-		acpi->gtm.drive[unit].dma = udma_cycle[adev->dma_mode - XFER_UDMA_0];
+		acpi->gtm.drive[unit].dma =
+			ata_acpi_udma_cycle[adev->dma_mode - XFER_UDMA_0];
 		acpi->gtm.flags |= (1 << (2 * unit));
 	} else {
-		acpi->gtm.drive[unit].dma = mwdma_cycle[adev->dma_mode - XFER_MW_DMA_0];
+		acpi->gtm.drive[unit].dma =
+			ata_acpi_mwdma_cycle[adev->dma_mode - XFER_MW_DMA_0];
 		acpi->gtm.flags &= ~(1 << (2 * unit));
 	}
 	ata_acpi_stm(ap, &acpi->gtm);
diff --git a/include/linux/libata.h b/include/linux/libata.h
index bdb7c6e..8022e5b 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -961,6 +961,10 @@ enum {
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
+extern const unsigned int ata_acpi_pio_cycle[7];
+extern const unsigned int ata_acpi_mwdma_cycle[5];
+extern const unsigned int ata_acpi_udma_cycle[7];
+
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 {
 	if (ap->pflags & ATA_PFLAG_INIT_GTM_VALID)
@@ -970,12 +974,33 @@ static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 extern int ata_acpi_cbl_80wire(struct ata_port *ap);
 int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
+unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
+				    const struct ata_acpi_gtm *gtm);
+
 #else
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 {
 	return NULL;
 }
 static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
+
+static inline int ata_acpi_stm(const struct ata_port *ap,
+			       struct ata_acpi_gtm *stm)
+{
+	return -ENOSYS;
+}
+
+static inline int ata_acpi_gtm(const struct ata_port *ap,
+			       struct ata_acpi_gtm *stm)
+{
+	return -ENOSYS;
+}
+
+static inline unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
+					const struct ata_acpi_gtm *gtm)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCI
-- 
1.5.2.4

