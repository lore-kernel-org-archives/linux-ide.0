From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 42/68] pata_cs5520: move code to be re-used by ide2libata to pata_cs5520.h
Date: Fri, 29 Jan 2010 17:07:37 +0100
Message-ID: <20100129160737.21495.16421.sendpatchset@localhost>
References: <20100129160308.21495.14120.sendpatchset@localhost>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f220.google.com ([209.85.220.220]:53041 "EHLO
	mail-fx0-f220.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753653Ab0A2QHp (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 29 Jan 2010 11:07:45 -0500
In-Reply-To: <20100129160308.21495.14120.sendpatchset@localhost>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] pata_cs5520: move code to be re-used by ide2libata to pata_cs5520.h

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ata/pata_cs5520.c |   60 ----------------------------------------------
 drivers/ata/pata_cs5520.h |   60 ++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 61 insertions(+), 59 deletions(-)

Index: b/drivers/ata/pata_cs5520.c
===================================================================
--- a/drivers/ata/pata_cs5520.c
+++ b/drivers/ata/pata_cs5520.c
@@ -43,65 +43,7 @@
 #define DRV_NAME	"pata_cs5520"
 #define DRV_VERSION	"0.6.6"
 
-struct pio_clocks
-{
-	int address;
-	int assert;
-	int recovery;
-};
-
-static const struct pio_clocks cs5520_pio_clocks[]={
-	{3, 6, 11},
-	{2, 5, 6},
-	{1, 4, 3},
-	{1, 3, 2},
-	{1, 2, 1}
-};
-
-/**
- *	cs5520_set_timings	-	program PIO timings
- *	@ap: ATA port
- *	@adev: ATA device
- *
- *	Program the PIO mode timings for the controller according to the pio
- *	clocking table.
- */
-
-static void cs5520_set_timings(struct ata_port *ap, struct ata_device *adev, int pio)
-{
-	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
-	int slave = adev->devno;
-
-	pio -= XFER_PIO_0;
-
-	/* Channel command timing */
-	pci_write_config_byte(pdev, 0x62 + ap->port_no,
-				(cs5520_pio_clocks[pio].recovery << 4) |
-				(cs5520_pio_clocks[pio].assert));
-	/* FIXME: should these use address ? */
-	/* Read command timing */
-	pci_write_config_byte(pdev, 0x64 +  4*ap->port_no + slave,
-				(cs5520_pio_clocks[pio].recovery << 4) |
-				(cs5520_pio_clocks[pio].assert));
-	/* Write command timing */
-	pci_write_config_byte(pdev, 0x66 +  4*ap->port_no + slave,
-				(cs5520_pio_clocks[pio].recovery << 4) |
-				(cs5520_pio_clocks[pio].assert));
-}
-
-/**
- *	cs5520_set_piomode	-	program PIO timings
- *	@ap: ATA port
- *	@adev: ATA device
- *
- *	Program the PIO mode timings for the controller according to the pio
- *	clocking table.
- */
-
-static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
-{
-	cs5520_set_timings(ap, adev, adev->pio_mode);
-}
+#include "pata_cs5520.h"
 
 static struct scsi_host_template cs5520_sht = {
 	ATA_BMDMA_SHT(DRV_NAME),
Index: b/drivers/ata/pata_cs5520.h
===================================================================
--- /dev/null
+++ b/drivers/ata/pata_cs5520.h
@@ -0,0 +1,60 @@
+
+struct pio_clocks {
+	int address;
+	int assert;
+	int recovery;
+};
+
+static const struct pio_clocks cs5520_pio_clocks[] = {
+	{ 3, 6, 11 },
+	{ 2, 5,  6 },
+	{ 1, 4,  3 },
+	{ 1, 3,  2 },
+	{ 1, 2,  1 }
+};
+
+/**
+ *	cs5520_set_timings	-	program PIO timings
+ *	@ap: ATA port
+ *	@adev: ATA device
+ *
+ *	Program the PIO mode timings for the controller according to the pio
+ *	clocking table.
+ */
+
+static void cs5520_set_timings(struct ata_port *ap, struct ata_device *adev,
+			       int pio)
+{
+	struct pci_dev *pdev = to_pci_dev(ap->host->dev);
+	int slave = adev->devno;
+
+	pio -= XFER_PIO_0;
+
+	/* Channel command timing */
+	pci_write_config_byte(pdev, 0x62 + ap->port_no,
+				(cs5520_pio_clocks[pio].recovery << 4) |
+				(cs5520_pio_clocks[pio].assert));
+	/* FIXME: should these use address ? */
+	/* Read command timing */
+	pci_write_config_byte(pdev, 0x64 +  4*ap->port_no + slave,
+				(cs5520_pio_clocks[pio].recovery << 4) |
+				(cs5520_pio_clocks[pio].assert));
+	/* Write command timing */
+	pci_write_config_byte(pdev, 0x66 +  4*ap->port_no + slave,
+				(cs5520_pio_clocks[pio].recovery << 4) |
+				(cs5520_pio_clocks[pio].assert));
+}
+
+/**
+ *	cs5520_set_piomode	-	program PIO timings
+ *	@ap: ATA port
+ *	@adev: ATA device
+ *
+ *	Program the PIO mode timings for the controller according to the pio
+ *	clocking table.
+ */
+
+static void cs5520_set_piomode(struct ata_port *ap, struct ata_device *adev)
+{
+	cs5520_set_timings(ap, adev, adev->pio_mode);
+}
