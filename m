From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 5/13] ide: always disable DMA before tuning it
Date: Sat, 10 Mar 2007 22:13:07 +0100
Message-ID: <200703102213.07202.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:46383 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932419AbXCJVJX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 10 Mar 2007 16:09:23 -0500
Received: by ug-out-1314.google.com with SMTP id 44so1749168uga
        for <linux-ide@vger.kernel.org>; Sat, 10 Mar 2007 13:09:22 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org

[PATCH] ide: always disable DMA before tuning it

ide_start_power_step() and set_using_dma() were missing ->dma_off_quietly
call (comment in probe_hwif() states that DMA should be always cleared before
tuning is attempted).  Fix it.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---

 drivers/ide/ide-io.c |    1 +
 drivers/ide/ide.c    |    1 +
 2 files changed, 2 insertions(+)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -223,6 +223,7 @@ static ide_startstop_t ide_start_power_s
 			break;
 		if (drive->hwif->ide_dma_check == NULL)
 			break;
+		drive->hwif->dma_off_quietly(drive);
 		ide_set_dma(drive);
 		break;
 	}
Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -898,6 +898,7 @@ int set_using_dma(ide_drive_t *drive, in
 	if (HWIF(drive)->ide_dma_check == NULL)
 		return -EPERM;
 	if (arg) {
+		HWIF(drive)->dma_off_quietly(drive);
 		if (ide_set_dma(drive))
 			return -EIO;
 		if (HWIF(drive)->ide_dma_on(drive)) return -EIO;
