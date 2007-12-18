From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 4/5] libata: reimplement ata_acpi_cbl_80wire() using ata_acpi_gtm_xfermask()
Date: Tue, 18 Dec 2007 16:33:06 +0900
Message-ID: <11979631883682-git-send-email-htejun@gmail.com>
References: <1197963187184-git-send-email-htejun@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rv-out-0910.google.com ([209.85.198.184]:63958 "EHLO
	rv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934064AbXLRHdQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Dec 2007 02:33:16 -0500
Received: by rv-out-0910.google.com with SMTP id k20so2173671rvb.1
        for <linux-ide@vger.kernel.org>; Mon, 17 Dec 2007 23:33:15 -0800 (PST)
In-Reply-To: <1197963187184-git-send-email-htejun@gmail.com>
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
 drivers/ata/libata-acpi.c |   41 ++++++++++++++++-------------------------
 drivers/ata/pata_amd.c    |    3 ++-
 drivers/ata/pata_via.c    |    3 ++-
 include/linux/libata.h    |   10 +++++++---
 4 files changed, 27 insertions(+), 30 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index a6f1a6b..9e8ec19 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -490,38 +490,29 @@ EXPORT_SYMBOL_GPL(ata_acpi_gtm_xfermask);
 /**
  * ata_acpi_cbl_80wire		-	Check for 80 wire cable
  * @ap: Port to check
+ * @gtm: GTM data to use
  *
- * Return 1 if the ACPI mode data for this port indicates the BIOS selected
- * an 80wire mode.
+ * Return 1 if the @gtm indicates the BIOS selected an 80wire mode.
  */
-
-int ata_acpi_cbl_80wire(struct ata_port *ap)
+int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 {
-	const struct ata_acpi_gtm *gtm = ata_acpi_init_gtm(ap);
-	int valid = 0;
+	struct ata_device *dev;
 
-	if (!gtm)
-		return 0;
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
 
-	/* Split timing, DMA enabled */
-	if ((gtm->flags & 0x11) == 0x11 && gtm->drive[0].dma < 55)
-		valid |= 1;
-	if ((gtm->flags & 0x14) == 0x14 && gtm->drive[1].dma < 55)
-		valid |= 2;
-	/* Shared timing, DMA enabled */
-	if ((gtm->flags & 0x11) == 0x01 && gtm->drive[0].dma < 55)
-		valid |= 1;
-	if ((gtm->flags & 0x14) == 0x04 && gtm->drive[0].dma < 55)
-		valid |= 2;
-
-	/* Drive check */
-	if ((valid & 1) && ata_dev_enabled(&ap->link.device[0]))
-		return 1;
-	if ((valid & 2) && ata_dev_enabled(&ap->link.device[1]))
-		return 1;
 	return 0;
 }
-
 EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
 
 static void ata_acpi_gtf_to_tf(struct ata_device *dev,
diff --git a/drivers/ata/pata_amd.c b/drivers/ata/pata_amd.c
index 3cc27b5..e71125a 100644
--- a/drivers/ata/pata_amd.c
+++ b/drivers/ata/pata_amd.c
@@ -272,7 +272,8 @@ static int nv_cable_detect(struct ata_port *ap)
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
index 453d72b..39627ab 100644
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
index 8ede93b..cc4eaef 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -968,18 +968,16 @@ static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 		return &ap->__acpi_init_gtm;
 	return NULL;
 }
-extern int ata_acpi_cbl_80wire(struct ata_port *ap);
 int ata_acpi_stm(struct ata_port *ap, const struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(struct ata_port *ap, struct ata_acpi_gtm *stm);
 unsigned long ata_acpi_gtm_xfermask(struct ata_device *dev,
 				    const struct ata_acpi_gtm *gtm);
-
+int ata_acpi_cbl_80wire(struct ata_port *ap, const struct ata_acpi_gtm *gtm);
 #else
 static inline const struct ata_acpi_gtm *ata_acpi_init_gtm(struct ata_port *ap)
 {
 	return NULL;
 }
-static inline int ata_acpi_cbl_80wire(struct ata_port *ap) { return 0; }
 
 static inline int ata_acpi_stm(const struct ata_port *ap,
 			       struct ata_acpi_gtm *stm)
@@ -998,6 +996,12 @@ static inline unsigned int ata_acpi_gtm_xfermask(struct ata_device *dev,
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

