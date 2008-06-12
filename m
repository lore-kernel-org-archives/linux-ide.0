From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/7] ide-pmac: add ->init_dev method
Date: Fri, 13 Jun 2008 01:13:09 +0200
Message-ID: <20080612231309.18335.27624.sendpatchset@localhost.localdomain>
References: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.153]:25204 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760803AbYFLXL1 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 12 Jun 2008 19:11:27 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2634644fgg.17
        for <linux-ide@vger.kernel.org>; Thu, 12 Jun 2008 16:11:27 -0700 (PDT)
In-Reply-To: <20080612231224.18335.91182.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linuxppc-dev@ozlabs.org, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org

There should be no functional changes caused by this patch.

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ppc/pmac.c |   27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -941,7 +941,23 @@ static u8 pmac_ide_cable_detect(ide_hwif
 	return ATA_CBL_PATA40;
 }
 
+static void pmac_ide_init_dev(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	pmac_ide_hwif_t *pmif =
+		(pmac_ide_hwif_t *)drv_get_drvdata(hwif->gendev.parent);
+
+	if (pmif->mediabay) {
+#ifdef CONFIG_PMAC_MEDIABAY
+		if (check_media_bay(np->parent, MB_CD) == -ENODEV)
+			return;
+#endif
+		drive->noprobe = 1;
+	}
+}
+
 static const struct ide_port_ops pmac_ide_ata6_port_ops = {
+	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
 	.selectproc		= pmac_ide_kauai_selectproc,
@@ -949,6 +965,7 @@ static const struct ide_port_ops pmac_id
 };
 
 static const struct ide_port_ops pmac_ide_ata4_port_ops = {
+	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
 	.selectproc		= pmac_ide_selectproc,
@@ -956,6 +973,7 @@ static const struct ide_port_ops pmac_id
 };
 
 static const struct ide_port_ops pmac_ide_port_ops = {
+	.init_dev		= pmac_ide_init_dev,
 	.set_pio_mode		= pmac_ide_set_pio_mode,
 	.set_dma_mode		= pmac_ide_set_dma_mode,
 	.selectproc		= pmac_ide_selectproc,
@@ -1065,15 +1083,6 @@ pmac_ide_setup_device(pmac_ide_hwif_t *p
 	       hwif->index, model_name[pmif->kind], pmif->aapl_bus_id,
 	       pmif->mediabay ? " (mediabay)" : "", hwif->irq);
 
-	if (pmif->mediabay) {
-#ifdef CONFIG_PMAC_MEDIABAY
-		if (check_media_bay(np->parent, MB_CD) == -ENODEV)
-			break;
-#endif
-		hwif->drives[0].noprobe = 1;
-		hwif->drives[1].noprobe = 1;
-	}
-
 	idx[0] = hwif->index;
 
 	ide_device_add(idx, &d);
