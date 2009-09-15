From: Tejun Heo <tj@kernel.org>
Subject: [PATCH REDIFFED 3/4 #upstream] libata: make gtf_filter per-dev
Date: Wed, 16 Sep 2009 04:17:28 +0900
Message-ID: <4AAFE848.5090501@kernel.org>
References: <4A77F6B8.4000000@kernel.org> <4AA702E7.7030905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56302 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758514AbZIOTR3 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Sep 2009 15:17:29 -0400
In-Reply-To: <4AA702E7.7030905@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: ide <linux-ide@vger.kernel.org>, meissner@novell.com

Add ->gtf_filter to ata_device and set it to ata_acpi_gtf_filter when
initializing ata_link.  This is to allow quirks which apply different
gtf filters.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-acpi.c |   17 +++++++++--------
 drivers/ata/libata-core.c |    3 +++
 drivers/ata/libata.h      |    2 ++
 include/linux/libata.h    |    1 +
 4 files changed, 15 insertions(+), 8 deletions(-)

Index: ata/drivers/ata/libata-acpi.c
===================================================================
--- ata.orig/drivers/ata/libata-acpi.c
+++ ata/drivers/ata/libata-acpi.c
@@ -20,7 +20,7 @@

 #include <acpi/acpi_bus.h>

-static unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
+unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
 module_param_named(acpi_gtf_filter, ata_acpi_gtf_filter, int, 0644);
 MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=set xfermode, 0x2=lock/freeze lock, 0x4=DIPM, 0x8=FPDMA non-zero offset, 0x10=FPDMA DMA Setup FIS auto-activate)");

@@ -603,10 +603,11 @@ static void ata_acpi_gtf_to_tf(struct at
 	tf->command = gtf->tf[6];	/* 0x1f7 */
 }

-static int ata_acpi_filter_tf(const struct ata_taskfile *tf,
+static int ata_acpi_filter_tf(struct ata_device *dev,
+			      const struct ata_taskfile *tf,
 			      const struct ata_taskfile *ptf)
 {
-	if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_SETXFER) {
+	if (dev->gtf_filter & ATA_ACPI_FILTER_SETXFER) {
 		/* libata doesn't use ACPI to configure transfer mode.
 		 * It will only confuse device configuration.  Skip.
 		 */
@@ -615,7 +616,7 @@ static int ata_acpi_filter_tf(const stru
 			return 1;
 	}

-	if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_LOCK) {
+	if (dev->gtf_filter & ATA_ACPI_FILTER_LOCK) {
 		/* BIOS writers, sorry but we don't wanna lock
 		 * features unless the user explicitly said so.
 		 */
@@ -640,18 +641,18 @@ static int ata_acpi_filter_tf(const stru
 	if (tf->command == ATA_CMD_SET_FEATURES &&
 	    tf->feature == SETFEATURES_SATA_ENABLE) {
 		/* inhibit enabling DIPM */
-		if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_DIPM &&
+		if (dev->gtf_filter & ATA_ACPI_FILTER_DIPM &&
 		    tf->nsect == SATA_DIPM)
 			return 1;

 		/* inhibit FPDMA non-zero offset */
-		if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_FPDMA_OFFSET &&
+		if (dev->gtf_filter & ATA_ACPI_FILTER_FPDMA_OFFSET &&
 		    (tf->nsect == SATA_FPDMA_OFFSET ||
 		     tf->nsect == SATA_FPDMA_IN_ORDER))
 			return 1;

 		/* inhibit FPDMA auto activation */
-		if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_FPDMA_AA &&
+		if (dev->gtf_filter & ATA_ACPI_FILTER_FPDMA_AA &&
 		    tf->nsect == SATA_FPDMA_AA)
 			return 1;
 	}
@@ -705,7 +706,7 @@ static int ata_acpi_run_tf(struct ata_de
 		pptf = &ptf;
 	}

-	if (!ata_acpi_filter_tf(&tf, pptf)) {
+	if (!ata_acpi_filter_tf(dev, &tf, pptf)) {
 		rtf = tf;
 		err_mask = ata_exec_internal(dev, &rtf, NULL,
 					     DMA_NONE, NULL, 0, 0);
Index: ata/drivers/ata/libata-core.c
===================================================================
--- ata.orig/drivers/ata/libata-core.c
+++ ata/drivers/ata/libata-core.c
@@ -5591,6 +5591,9 @@ void ata_link_init(struct ata_port *ap,

 		dev->link = link;
 		dev->devno = dev - link->device;
+#ifdef CONFIG_ATA_ACPI
+		dev->gtf_filter = ata_acpi_gtf_filter;
+#endif
 		ata_dev_init(dev);
 	}
 }
Index: ata/drivers/ata/libata.h
===================================================================
--- ata.orig/drivers/ata/libata.h
+++ ata/drivers/ata/libata.h
@@ -118,6 +118,8 @@ extern void ata_lpm_schedule(struct ata_

 /* libata-acpi.c */
 #ifdef CONFIG_ATA_ACPI
+extern unsigned int ata_acpi_gtf_filter;
+
 extern void ata_acpi_associate_sata_port(struct ata_port *ap);
 extern void ata_acpi_associate(struct ata_host *host);
 extern void ata_acpi_dissociate(struct ata_host *host);
Index: ata/include/linux/libata.h
===================================================================
--- ata.orig/include/linux/libata.h
+++ ata/include/linux/libata.h
@@ -598,6 +598,7 @@ struct ata_device {
 #ifdef CONFIG_ATA_ACPI
 	acpi_handle		acpi_handle;
 	union acpi_object	*gtf_cache;
+	unsigned int		gtf_filter;
 #endif
 	/* n_sector is CLEAR_BEGIN, read comment above CLEAR_BEGIN */
 	u64			n_sectors;	/* size of device, if ATA */
