From: Tejun Heo <tj@kernel.org>
Subject: [PATCH #upstream-fixes 1/2] libata: cosmetic updates
Date: Wed, 22 Jul 2009 00:12:25 +0900
Message-ID: <4A65DAD9.8050001@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from hera.kernel.org ([140.211.167.34]:40356 "EHLO hera.kernel.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755168AbZGUPNb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 21 Jul 2009 11:13:31 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>, IDE/ATA development list <linux-ide@vger.kernel.org>, Marcus Meissner <meissner@novell.com>

We're about to add more SATA_* and ATA_ACPI_FILTER_* constants.
Reformat them in preparation.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-acpi.c |   12 ++++++------
 include/linux/ata.h       |    4 ++--
 2 files changed, 8 insertions(+), 8 deletions(-)

Index: ata/drivers/ata/libata-acpi.c
===================================================================
--- ata.orig/drivers/ata/libata-acpi.c
+++ ata/drivers/ata/libata-acpi.c
@@ -21,13 +21,13 @@
 #include <acpi/acpi_bus.h>

 enum {
-	ATA_ACPI_FILTER_SETXFER	= 1 << 0,
-	ATA_ACPI_FILTER_LOCK	= 1 << 1,
-	ATA_ACPI_FILTER_DIPM	= 1 << 2,
+	ATA_ACPI_FILTER_SETXFER		= 1 << 0,
+	ATA_ACPI_FILTER_LOCK		= 1 << 1,
+	ATA_ACPI_FILTER_DIPM		= 1 << 2,

-	ATA_ACPI_FILTER_DEFAULT	= ATA_ACPI_FILTER_SETXFER |
-				  ATA_ACPI_FILTER_LOCK |
-				  ATA_ACPI_FILTER_DIPM,
+	ATA_ACPI_FILTER_DEFAULT		= ATA_ACPI_FILTER_SETXFER |
+					  ATA_ACPI_FILTER_LOCK |
+					  ATA_ACPI_FILTER_DIPM,
 };

 static unsigned int ata_acpi_gtf_filter = ATA_ACPI_FILTER_DEFAULT;
Index: ata/include/linux/ata.h
===================================================================
--- ata.orig/include/linux/ata.h
+++ ata/include/linux/ata.h
@@ -304,8 +304,8 @@ enum {
 	SETFEATURES_SATA_DISABLE = 0x90, /* Disable use of SATA feature */

 	/* SETFEATURE Sector counts for SATA features */
-	SATA_AN			= 0x05,  /* Asynchronous Notification */
-	SATA_DIPM		= 0x03,  /* Device Initiated Power Management */
+	SATA_DIPM		= 0x03,	/* Device Initiated Power Management */
+	SATA_AN			= 0x05,	/* Asynchronous Notification */

 	/* feature values for SET_MAX */
 	ATA_SET_MAX_ADDR	= 0x00,
