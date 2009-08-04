From: Tejun Heo <teheo@novell.com>
Subject: [PATCH 2/4 #upstream-fixes] libata: implement more acpi filtering
 options
Date: Tue, 04 Aug 2009 17:52:52 +0900
Message-ID: <4A77F6E4.6070800@novell.com>
References: <4A77F6B8.4000000@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:56584 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755368AbZHDIxI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 4 Aug 2009 04:53:08 -0400
In-Reply-To: <4A77F6B8.4000000@kernel.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, ide <linux-ide@vger.kernel.org>, meissner@novell.com

Currently libata-acpi can only filter DIPM among SATA feature enables
via _GTF.  This patch adds the capability to filter out FPDMA non-zero
offset, in-order guarantee and auto-activation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-acpi.c |   19 +++++++++++++++----
 include/linux/ata.h       |    4 ++++
 include/linux/libata.h    |    2 ++
 3 files changed, 21 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/libata-acpi.c b/drivers/ata/libata-acpi.c
index b94fe5f..6ea9d02 100644
--- a/drivers/ata/libata-acpi.c
+++ b/drivers/ata/libata-acpi.c
@@ -22,7 +22,7 @@
 
 static unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
 module_param_named(acpi_gtf_filter, ata_acpi_gtf_filter, int, 0644);
-MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=set xfermode, 0x2=lock/freeze lock, 0x4=DIPM)");
+MODULE_PARM_DESC(acpi_gtf_filter, "filter mask for ACPI _GTF commands, set to filter out (0x1=set xfermode, 0x2=lock/freeze lock, 0x4=DIPM, 0x8=FPDMA non-zero offset, 0x10=FPDMA DMA Setup FIS auto-activate)");
 
 #define NO_PORT_MULT		0xffff
 #define SATA_ADR(root, pmp)	(((root) << 16) | (pmp))
@@ -637,12 +637,23 @@ static int ata_acpi_filter_tf(const struct ata_taskfile *tf,
 			return 1;
 	}
 
-	if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_DIPM) {
+	if (tf->command == ATA_CMD_SET_FEATURES &&
+	    tf->feature == SETFEATURES_SATA_ENABLE) {
 		/* inhibit enabling DIPM */
-		if (tf->command == ATA_CMD_SET_FEATURES &&
-		    tf->feature == SETFEATURES_SATA_ENABLE &&
+		if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_DIPM &&
 		    tf->nsect == SATA_DIPM)
 			return 1;
+
+		/* inhibit FPDMA non-zero offset */
+		if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_FPDMA_OFFSET &&
+		    (tf->nsect == SATA_FPDMA_OFFSET ||
+		     tf->nsect == SATA_FPDMA_IN_ORDER))
+			return 1;
+
+		/* inhibit FPDMA auto activation */
+		if (ata_acpi_gtf_filter & ATA_ACPI_FILTER_FPDMA_AA &&
+		    tf->nsect == SATA_FPDMA_AA)
+			return 1;
 	}
 
 	return 0;
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 7d0769a..6066076 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -304,8 +304,12 @@ enum {
 	SETFEATURES_SATA_DISABLE = 0x90, /* Disable use of SATA feature */
 
 	/* SETFEATURE Sector counts for SATA features */
+	SATA_FPDMA_OFFSET	= 0x01,	/* FPDMA non-zero buffer offsets */
+	SATA_FPDMA_AA		= 0x02,	/* FPDMA DMA setup FIS auto-activate */
 	SATA_DIPM		= 0x03,	/* Device Initiated Power Management */
+	SATA_FPDMA_IN_ORDER	= 0x04,	/* FPDMA in-order data delivery */
 	SATA_AN			= 0x05,	/* Asynchronous Notification */
+	SATA_SSP		= 0x06,	/* Software Settings Preservation */
 
 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
diff --git a/include/linux/libata.h b/include/linux/libata.h
index 8767adf..c7938f7 100644
--- a/include/linux/libata.h
+++ b/include/linux/libata.h
@@ -422,6 +422,8 @@ enum {
 	ATA_ACPI_FILTER_SETXFER	= 1 << 0,
 	ATA_ACPI_FILTER_LOCK	= 1 << 1,
 	ATA_ACPI_FILTER_DIPM	= 1 << 2,
+	ATA_ACPI_FILTER_FPDMA_OFFSET = 1 << 3,	/* FPDMA non-zero offset */
+	ATA_ACPI_FILTER_FPDMA_AA = 1 << 4,	/* FPDMA auto activate */
 
 	ATA_ACPI_FILTER_DEFAULT	= ATA_ACPI_FILTER_SETXFER |
 				  ATA_ACPI_FILTER_LOCK |
-- 
1.6.0.2

