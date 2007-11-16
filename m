From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: don't set PIO mode on pre-EIDE drives
Date: Fri, 16 Nov 2007 16:26:25 +0300
Message-ID: <200711161626.25580.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:5835 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1758203AbXKPN0P (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 16 Nov 2007 08:26:15 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix handling of  the PIO modes for the pre-EIDE drives that did not support
the PIO Flow Control Transfer Mode value (00001 nnn) of the Set Transfer Mode
feature by  skipping the actual mode programming.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the Linus' tree...

 drivers/ide/ide-iops.c |    7 ++++++-
 1 files changed, 6 insertions(+), 1 deletion(-)

Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -756,7 +756,7 @@ int ide_driveid_update(ide_drive_t *driv
 int ide_config_drive_speed(ide_drive_t *drive, u8 speed)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	int error;
+	int error = 0;
 	u8 stat;
 
 //	while (HWGROUP(drive)->busy)
@@ -767,6 +767,10 @@ int ide_config_drive_speed(ide_drive_t *
 		hwif->dma_host_off(drive);
 #endif
 
+	/* Skip setting PIO flow-control modes on pre-EIDE drives */
+	if ((speed & 0xf8) == XFER_PIO_0 && !(drive->id->capability & 0x08))
+		goto skip;
+
 	/*
 	 * Don't use ide_wait_cmd here - it will
 	 * attempt to set_geometry and recalibrate,
@@ -814,6 +818,7 @@ int ide_config_drive_speed(ide_drive_t *
 	drive->id->dma_mword &= ~0x0F00;
 	drive->id->dma_1word &= ~0x0F00;
 
+ skip:
 #ifdef CONFIG_BLK_DEV_IDEDMA
 	if (speed >= XFER_SW_DMA_0)
 		hwif->dma_host_on(drive);

