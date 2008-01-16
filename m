From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 06/22] ide: factor out code initializing devices from ide_init_port()
Date: Thu, 17 Jan 2008 00:26:48 +0100
Message-ID: <20080116232648.9166.52935.sendpatchset@localhost.localdomain>
References: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:10937 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755326AbYAPXOI (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 16 Jan 2008 18:14:08 -0500
Received: by ug-out-1314.google.com with SMTP id z38so275986ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 16 Jan 2008 15:14:07 -0800 (PST)
In-Reply-To: <20080116232556.9166.13457.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

* Factor out code initializing devices from ide_init_port() to
  ide_port_init_devices().

* Call the new function from ide_device_add_all().

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1289,6 +1289,22 @@ static void hwif_register_devices(ide_hw
 	}
 }
 
+static void ide_port_init_devices(ide_hwif_t *hwif)
+{
+	int i;
+
+	for (i = 0; i < MAX_DRIVES; i++) {
+		ide_drive_t *drive = &hwif->drives[i];
+
+		if (hwif->host_flags & IDE_HFLAG_IO_32BIT)
+			drive->io_32bit = 1;
+		if (hwif->host_flags & IDE_HFLAG_UNMASK_IRQS)
+			drive->unmask = 1;
+		if ((hwif->host_flags & IDE_HFLAG_NO_AUTOTUNE) == 0)
+			drive->autotune = 1;
+	}
+}
+
 static void ide_init_port(ide_hwif_t *hwif, unsigned int port,
 			  const struct ide_port_info *d)
 {
@@ -1314,16 +1330,6 @@ static void ide_init_port(ide_hwif_t *hw
 	if ((d->host_flags & IDE_HFLAG_SERIALIZE) && hwif->mate)
 		hwif->mate->serialized = hwif->serialized = 1;
 
-	if (d->host_flags & IDE_HFLAG_IO_32BIT) {
-		hwif->drives[0].io_32bit = 1;
-		hwif->drives[1].io_32bit = 1;
-	}
-
-	if (d->host_flags & IDE_HFLAG_UNMASK_IRQS) {
-		hwif->drives[0].unmask = 1;
-		hwif->drives[1].unmask = 1;
-	}
-
 	hwif->swdma_mask = d->swdma_mask;
 	hwif->mwdma_mask = d->mwdma_mask;
 	hwif->ultra_mask = d->udma_mask;
@@ -1332,11 +1338,6 @@ static void ide_init_port(ide_hwif_t *hw
 	if ((d->host_flags && IDE_HFLAG_NO_DMA) == 0 && hwif->dma_base == 0)
 		hwif->swdma_mask = hwif->mwdma_mask = hwif->ultra_mask = 0;
 
-	if ((d->host_flags & IDE_HFLAG_NO_AUTOTUNE) == 0) {
-		hwif->drives[0].autotune = 1;
-		hwif->drives[1].autotune = 1;
-	}
-
 	if (d->host_flags & IDE_HFLAG_RQSIZE_256)
 		hwif->rqsize = 256;
 
@@ -1371,6 +1372,7 @@ int ide_device_add_all(u8 idx[MAX_HWIFS]
 		mate = (i & 1) ? NULL : hwif;
 
 		ide_init_port(hwif, i & 1, d);
+		ide_port_init_devices(hwif);
 	}
 
 	for (i = 0; i < MAX_HWIFS; i++) {
