From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] ide: fix comments in ide_config_drive_speed()
Date: Mon, 19 Jan 2009 14:03:36 +0100
Message-ID: <20090119130336.24745.7606.sendpatchset@localhost.localdomain>
References: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:46104 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760815AbZASNDO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 08:03:14 -0500
In-Reply-To: <20090119130309.24745.40877.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: fix comments in ide_config_drive_speed()

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -369,18 +369,15 @@ int ide_config_drive_speed(ide_drive_t *
 	 * but for some reason these don't work at
 	 * this point (lost interrupt).
 	 */
-        /*
-         * Select the drive, and issue the SETFEATURES command
-         */
-	disable_irq_nosync(hwif->irq);
-	
+
 	/*
 	 *	FIXME: we race against the running IRQ here if
 	 *	this is called from non IRQ context. If we use
 	 *	disable_irq() we hang on the error path. Work
 	 *	is needed.
 	 */
-	 
+	disable_irq_nosync(hwif->irq);
+
 	udelay(1);
 	SELECT_DRIVE(drive);
 	SELECT_MASK(drive, 1);
