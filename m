From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 03/11] ide: remove dead code from drive_is_ready()
Date: Sun, 09 Nov 2008 17:22:33 +0100
Message-ID: <20081109162233.18999.12402.sendpatchset@localhost.localdomain>
References: <20081109162219.18999.74912.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.27]:60863 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755527AbYKIQYc (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 9 Nov 2008 11:24:32 -0500
In-Reply-To: <20081109162219.18999.74912.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove dead code from drive_is_ready()

We guarantee 400ns delay at the time of issuing the command.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    5 -----
 1 file changed, 5 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -457,11 +457,6 @@ int drive_is_ready (ide_drive_t *drive)
 	if (drive->waiting_for_dma)
 		return hwif->dma_ops->dma_test_irq(drive);
 
-#if 0
-	/* need to guarantee 400ns since last command was issued */
-	udelay(1);
-#endif
-
 	/*
 	 * We do a passive status test under shared PCI interrupts on
 	 * cards that truly share the ATA side interrupt, but may also share
