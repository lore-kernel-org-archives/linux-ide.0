From: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/3] libata: extend ata_acpi_cbl_80wire() and fix cable detection
 in pata_via and pata_amd
Date: Sat, 03 Nov 2007 00:21:28 +0900
Message-ID: <472B4078.90009@gmail.com>
References: <472B402A.4030009@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nz-out-0506.google.com ([64.233.162.236]:11328 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754715AbXKBPVh (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 2 Nov 2007 11:21:37 -0400
Received: by nz-out-0506.google.com with SMTP id s18so683653nze
        for <linux-ide@vger.kernel.org>; Fri, 02 Nov 2007 08:21:36 -0700 (PDT)
In-Reply-To: <472B402A.4030009@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>

The current ata_acpi_cbl_80wire() is too retricted in its
functionality.  It always reads GTM itself and only returns whether
the cable is 80 wire or not.  Extend it such that...

* It accepts @gtm argument instead of reading iteslf.

* Returns one of ATA_CBL_PATA40, ATA_CBL_PATA80 or ATA_CBL_PATA_UNK.

The function is renamed to ata_acpi_cbl().  Currently there are two
users - cable detection functions of pata_via and pata_amd.  Both are
converted to use the new function with ap->acpi_init_gtm.

Using the initial GTM value is the right thing to do because both are
trying to check firmware setting and by the time ->cable_detect runs
the controller is already forced into PIO0 by reset.

Signed-off-by: Tejun Heo <htejun@gmail.com>
---
 drivers/ata/libata-acpi.c |   68 +++++++++++++++++++++++++---------------------
 drivers/ata/pata_amd.c    |    3 +-
 drivers/ata/pata_via.c    |    3 +-
 include/linux/libata.h    |    2 -
 4 files changed, 43 insertions(+), 33 deletions(-)

Index: work/drivers/ata/libata-acpi.c
===================================================================
--- work.orig/drivers/ata/libata-acpi.c
+++ work/drivers/ata/libata-acpi.c
@@ -390,42 +390,50 @@ static int ata_dev_get_GTF(struct ata_de
 }
 
 /**
- * ata_acpi_cbl_80wire		-	Check for 80 wire cable
- * @ap: Port to check
+ * ata_acpi_cbl - determine cable type from GTM values
+ * @ap: target ATA port
+ * @gtm: GTM to use
+ *
+ * Determine cable type from UDMA configuration in @gtm.  If UDMA is
+ * disabled, it returns ATA_CBL_PATA_UNK.  If UDMA is enabled and
+ * faster than 33, PATA_80; otherwise, PATA_40.
+ *
+ * LOCKING:
+ * None.
  *
- * Return 1 if the ACPI mode data for this port indicates the BIOS selected
- * an 80wire mode.
+ * RETURNS:
+ * Determined cable type (ATA_CBL_*).
  */
-
-int ata_acpi_cbl_80wire(struct ata_port *ap)
+int ata_acpi_cbl(struct ata_port *ap, const struct ata_acpi_gtm *gtm)
 {
-	struct ata_acpi_gtm gtm;
-	int valid = 0;
+	int cbl = ATA_CBL_PATA_UNK;
 
-	/* No _GTM data, no information */
-	if (ata_acpi_gtm(ap, &gtm) < 0)
-		return 0;
+	if (ata_dev_enabled(&ap->link.device[0]) && (gtm->flags & 0x1)) {
+		if (gtm->drive[0].dma < 55)
+			return ATA_CBL_PATA80;
+		else
+			cbl = ATA_CBL_PATA40;
+	}
 
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
+	if (ata_dev_enabled(&ap->link.device[1]) && (gtm->flags & 0x4)) {
+		u32 acpi_dma;
 
-EXPORT_SYMBOL_GPL(ata_acpi_cbl_80wire);
+		/* if split timing, use drive[0]; otherwise, drive[1] */
+		if (gtm->flags & 0x10)
+			acpi_dma = gtm->drive[1].dma;
+		else
+			acpi_dma = gtm->drive[0].dma;
+
+		if (acpi_dma < 55)
+			return ATA_CBL_PATA80;
+		else
+			cbl = ATA_CBL_PATA40;
+	}
+
+	return cbl;
+
+}
+EXPORT_SYMBOL_GPL(ata_acpi_cbl);
 
 /**
  * taskfile_load_raw - send taskfile registers to host controller
Index: work/drivers/ata/pata_amd.c
===================================================================
--- work.orig/drivers/ata/pata_amd.c
+++ work/drivers/ata/pata_amd.c
@@ -271,7 +271,8 @@ static int nv_cable_detect(struct ata_po
  	if ((udma & 0xC4) == 0xC4 || (udma & 0xC400) == 0xC400)
 		cbl = ATA_CBL_PATA80;
 	/* And a triple check across suspend/resume with ACPI around */
-	if (ata_acpi_cbl_80wire(ap))
+	if ((ap->pflags & ATA_PFLAG_INIT_GTM_VALID) &&
+	    ata_acpi_cbl(ap, &ap->acpi_init_gtm) == ATA_CBL_PATA80)
 		cbl = ATA_CBL_PATA80;
 	return cbl;
 }
Index: work/drivers/ata/pata_via.c
===================================================================
--- work.orig/drivers/ata/pata_via.c
+++ work/drivers/ata/pata_via.c
@@ -185,7 +185,8 @@ static int via_cable_detect(struct ata_p
 	if (ata66 & (0x10100000 >> (16 * ap->port_no)))
 		return ATA_CBL_PATA80;
 	/* Check with ACPI so we can spot BIOS reported SATA bridges */
-	if (ata_acpi_cbl_80wire(ap))
+	if ((ap->pflags & ATA_PFLAG_INIT_GTM_VALID) &&
+	    ata_acpi_cbl(ap, &ap->acpi_init_gtm) == ATA_CBL_PATA80)
 		return ATA_CBL_PATA80;
 	return ATA_CBL_PATA40;
 }
Index: work/include/linux/libata.h
===================================================================
--- work.orig/include/linux/libata.h
+++ work/include/linux/libata.h
@@ -921,7 +921,7 @@ enum {
 
 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
-extern int ata_acpi_cbl_80wire(struct ata_port *ap);
+int ata_acpi_cbl(struct ata_port *ap, const struct ata_acpi_gtm *gtm);
 int ata_acpi_stm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 int ata_acpi_gtm(const struct ata_port *ap, struct ata_acpi_gtm *stm);
 #else
