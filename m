From: Tejun Heo <tj@kernel.org>
Subject: [PATCH 1/4 #upstream-fixes] libata: cosmetic updates
Date: Tue, 04 Aug 2009 17:52:08 +0900
Message-ID: <4A77F6B8.4000000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:37339 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755050AbZHDIwW (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 04:52:22 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>, meissner@novell.com

We're about to add more SATA_* and ATA_ACPI_FILTER_* constants.
Reformat them in preparation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-acpi.c |   10 ----------
 include/linux/ata.h       |    4 ++--
 include/linux/libata.h    |    9 +++++++++
 3 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index ac176da..b94fe5f 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
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
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 9c75921..7d0769a 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -304,8 +304,8 @@ enum {
 	SETFEATURES_SATA_DISABLE = 0x90, /* Disable use of SATA feature */
 
 	/* SETFEATURE Sector counts for SATA features */
-	SATA_AN			= 0x05,  /* Asynchronous Notification */
-	SATA_DIPM		= 0x03,  /* Device Initiated Power Management */
+	SATA_DIPM		= 0x03,	/* Device Initiated Power Management */
+	SATA_AN			= 0x05,	/* Asynchronous Notification */
 
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index e5b6e33..8767adf 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -417,6 +417,15 @@ enum {
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
-- 
1.6.0.2


