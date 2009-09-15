From: Tejun Heo <tj@kernel.org>
Subject: [PATCH REDIFFED 1/4 #upstream] libata: cosmetic updates
Date: Wed, 16 Sep 2009 04:16:04 +0900
Message-ID: <4AAFE7F4.9050400@kernel.org>
References: <4A77F6B8.4000000@kernel.org> <4AA702E7.7030905@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:56241 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758530AbZIOTQG (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 15 Sep 2009 15:16:06 -0400
In-Reply-To: <4AA702E7.7030905@pobox.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: ide <linux-ide@vger.kernel.org>, meissner@novell.com

We're about to add more SATA_* and ATA_ACPI_FILTER_* constants.
Reformat them in preparation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
Almost forgot about this series.  Here's the refreshed version.

Thanks.

 drivers/ata/libata-acpi.c |   10 ----------
 include/linux/ata.h       |    6 +++---
 include/linux/libata.h    |    9 +++++++++
 3 files changed, 12 insertions(+), 13 deletions(-)

Index: ata/drivers/ata/libata-acpi.c
===================================================================
--- ata.orig/drivers/ata/libata-acpi.c
+++ ata/drivers/ata/libata-acpi.c
@@ -20,16 +20,6 @@

 #include <acpi/acpi_bus.h>

-enum {
-	ATA_ACPI_FILTER_SETXFER	= 1 << 0,
-	ATA_ACPI_FILTER_LOCK	= 1 << 1,
-	ATA_ACPI_FILTER_DIPM	= 1 << 2,
-
-	ATA_ACPI_FILTER_DEFAULT	= ATA_ACPI_FILTER_SETXFER |
-				  ATA_ACPI_FILTER_LOCK |
-				  ATA_ACPI_FILTER_DIPM,
-};
-
 static unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
 module_param_named(acpi_gtf_filter, ata_acpi_gtf_filter, int, 0644);
 MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=set xfermode, 0x2=lock/freeze lock, 0x4=DIPM)");
Index: ata/include/linux/ata.h
===================================================================
--- ata.orig/include/linux/ata.h
+++ ata/include/linux/ata.h
@@ -334,9 +334,9 @@ enum {
 	SETFEATURES_SATA_DISABLE = 0x90, /* Disable use of SATA feature */

 	/* SETFEATURE Sector counts for SATA features */
-	SATA_AN			= 0x05,  /* Asynchronous Notification */
-	SATA_DIPM		= 0x03,  /* Device Initiated Power Management */
-	SATA_FPDMA_AA		= 0x02,  /* DMA Setup FIS Auto-Activate */
+	SATA_FPDMA_AA		= 0x02, /* FPDMA Setup FIS Auto-Activate */
+	SATA_DIPM		= 0x03,	/* Device Initiated Power Management */
+	SATA_AN			= 0x05,	/* Asynchronous Notification */

 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
Index: ata/include/linux/libata.h
===================================================================
--- ata.orig/include/linux/libata.h
+++ ata/include/linux/libata.h
@@ -418,6 +418,15 @@ enum {
 				  ATA_TIMING_ACTIVE | ATA_TIMING_RECOVER |
 				  ATA_TIMING_DMACK_HOLD | ATA_TIMING_CYCLE |
 				  ATA_TIMING_UDMA,
+
+	/* ACPI constants */
+	ATA_ACPI_FILTER_SETXFER	= 1 << 0,
+	ATA_ACPI_FILTER_LOCK	= 1 << 1,
+	ATA_ACPI_FILTER_DIPM	= 1 << 2,
+
+	ATA_ACPI_FILTER_DEFAULT	= ATA_ACPI_FILTER_SETXFER |
+				  ATA_ACPI_FILTER_LOCK |
+				  ATA_ACPI_FILTER_DIPM,
 };

 enum ata_xfer_mask {
