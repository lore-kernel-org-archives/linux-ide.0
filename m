From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 10/12] libata: reimplement ata_acpi_cbl_80wire() using ata_acpi_gtm_xfermask()
Date: Tue, 27 Nov 2007 19:43:47 +0900
Message-ID: <11961602312210-git-send-email-htejun@gmail.com>
References: <11961602293422-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.189]:40853 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754767AbXK0KoH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 27 Nov 2007 05:44:07 -0500
Received: by rv-out-0910.google.com with SMTP id k20so840800rvb
        for <linux-ide@vger.kernel.org>; Tue, 27 Nov 2007 02:44:06 -0800 (PST)
In-Reply-To: <11961602293422-git-send-email-htejun@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org
Cc: Tejun Heo <htejun@gmail.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

Reimplement ata_acpi_cbl_80wire() using ata_acpi_gtm_xfermask() and
while at it relocate the function below ata_acpi_gtm_xfermask().

New ata_acpi_cbl_80wire() implementation takes @gtm, in both pata_via
and pata_amd, use the initial GTM value.  Both are trying to peek
initial BIOS configuration, so using initial caching value makes
sense.  This fixes ACPI part of cable detection in pata_amd which
previously always returned 0 because configuring PIO0 during reset
clears DMA configuration.

Signed-off-by: Tejun Heo <htejun@gmail.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
---
 drivers/ata/libata-acpi.c |   66 +++++++++++++++++++--------------------------
 drivers/ata/pata_amd.c    |    3 +-
 drivers/ata/pata_via.c    |    3 +-
 include/linux/libata.h    |   10 +++++--
 4 files changed, 39 insertions(+), 43 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index 357f9a2..5ef2841 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -387,44 +387,6 @@ static int ata_dev_get_GTF(struct ata_device *dev, struct ata_acpi_gtf **gtf,
 }
 
 /**
- * ata_acpi_cbl_80wire		-	Check for 80 wire cable
- * @ap: Port to check
- *
- * Return 1 if the ACPI mode data for this port indicates the BIOS selected
- * an 80wire mode.
- */
-
-int ata_acpi_cbl_80wire(struct ata_port *ap)
-{
-	struct ata_acpi_gtm gtm;
-	int valid = 0;
-
-	/* No _GTM data, no information */
-	if (ata_acpi_gtm(ap, &gtm) < 0)
-		return 0;
-
-	/* Split timing, DMA enabled */
-	if ((gtm.flags & 0x11) == 0x11 && gtm.drive[0].dma < 55)
-		valid |= 1;
-	if ((gtm.flags & 0x14) == 0x14 && gtm.drive[1].dma < 55)
-		valid |= 2;
-	/* Shared timing, DMA enabled */
-	if ((gtm.flags & 0x11) == 0x01 && gtm.drive[0].dma < 55)
-		valid |= 1;
-	if ((gtm.flags & 0x14) == 0x04 && gtm.drive[0].dma < 55)
-		valid |= 2;
-
-	/* Drive check */
-	if ((valid & 1) && ata_dev_enabled(&ap->link.device[0]))
-		return 1;
-	if ((valid & 2) && ata_dev_enabled(&ap->link.device[1]))
-		return 1;
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
-
-/**
  * ata_acpi_gtm_xfermode - determine xfermode from GTM parameter
  * @dev: target device
  * @gtm: GTM parameter to use
@@ -471,6 +433,34 @@ unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
 EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
 
 /**
+ * ata_acpi_cbl_80wire		-	Check for 80 wire cable
+ * @ap: Port to check
+ * @gtm: GTM data to use
+ *
+ * Return 1 if the @gtm indicates the BIOS selected an 80wire mode.
+ */
+int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
+{
+	struct ata_device *dev;
+
+	ata_link_for_each_dev(dev, &ap->link) {
+		unsigned long xfer_mask, udma_mask;
+
+		if (!ata_dev_enabled(dev))
+			continue;
+
+		xfer_mask = ata_acpi_gtm_xfermask(dev, gtm);
+		ata_unpack_xfermask(xfer_mask, NULL, NULL, &udma_mask);
+
+		if (udma_mask & ~ATA_UDMA_MASK_40C)
+			return 1;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
+
+/**
  * taskfile_load_raw - send taskfile registers to host controller
  * @dev: target ATA device
  * @gtf: raw ATA taskfile register set (0x1f1 - 0x1f7)
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index c5779ad..f65fa6c 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -271,7 +271,8 @@ static int nv_cable_detect(struct ata_port *ap)
  	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
 		cbl = ATA_CBL_PATA80;
 	/* And a triple check across suspend/resume with ACPI around */
-	if (ata_acpi_cbl_80wire(ap))
+	if (ata_acpi_init_gtm(ap) &&
+	    ata_acpi_cbl_80wire(ap, ata_acpi_init_gtm(ap)))
 		cbl = ATA_CBL_PATA80;
 	return cbl;
 }
diff --git a/drivers/ata/pata_via.c b/drivers/ata/pata_via.c
index a4175fb..3f28ed4 100644
--- a/drivers/ata/pata_via.c
+++ b/drivers/ata/pata_via.c
@@ -185,7 +185,8 @@ static int via_cable_detect(struct ata_port *ap) {
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
 	/* Check with ACPI so we can spot BIOS reported SATA bridges */
-	if (ata_acpi_cbl_80wire(ap))
+	if (ata_acpi_init_gtm(ap) &&
+	    ata_acpi_cbl_80wire(ap, ata_acpi_init_gtm(ap)))
 		return ATA_CBL_PATA80;
 	return ATA_CBL_PATA40;
 }
diff --git a/include/linux/libata.h b/include/linux/libata.h
index f056b2c..7375341 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -966,19 +966,17 @@ static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 		return &ap->__acpi_init_gtm;
 	return NULL;
 }
-extern int ata_acpi_cbl_80wire(struct ata_port *ap);
 int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
 				    const struct ata_acpi_gtm *gtm);
+int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm);
 #else
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 {
 	return NULL;
 }
 
-static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
-
 static inline int ata_acpi_stm(const struct ata_port *ap,
 			       struct ata_acpi_gtm *stm)
 {
@@ -996,6 +994,12 @@ static inline unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
 {
 	return 0;
 }
+
+static inline int ata_acpi_cbl_80wire(struct ata_port *ap,
+				      const struct ata_acpi_gtm *gtm)
+{
+	return 0;
+}
 #endif
 
 #ifdef CONFIG_PCI
-- 
1.5.2.4

