From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 12/12] ide: remove try_to_identify() wrapper
Date: Mon, 19 Jan 2009 15:15:10 +0100
Message-ID: <20090119141510.27613.61429.sendpatchset@localhost.localdomain>
References: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-fx0-f20.google.com ([209.85.220.20]:40670 "EHLO
	mail-fx0-f20.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752767AbZASOOs (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 19 Jan 2009 09:14:48 -0500
In-Reply-To: <20090119141330.27613.34546.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove try_to_identify() wrapper

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |   34 +++++++++-------------------------
 1 file changed, 9 insertions(+), 25 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -250,7 +250,7 @@ err_misc:
 }
 
 /**
- *	actual_try_to_identify	-	send ata/atapi identify
+ *	try_to_identify	-	send ATA/ATAPI identify
  *	@drive: drive to identify
  *	@cmd: command to use
  *
@@ -264,7 +264,7 @@ err_misc:
  *			2  device aborted the command (refused to identify itself)
  */
 
-static int actual_try_to_identify (ide_drive_t *drive, u8 cmd)
+static int try_to_identify(ide_drive_t *drive, u8 cmd)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	struct ide_io_ports *io_ports = &hwif->io_ports;
@@ -273,6 +273,13 @@ static int actual_try_to_identify (ide_d
 	unsigned long timeout;
 	u8 s = 0, a = 0;
 
+	/*
+	 * Disable device IRQ.  Otherwise we'll get spurious interrupts
+	 * during the identify phase that the IRQ handler isn't expecting.
+	 */
+	if (io_ports->ctl_addr)
+		tp_ops->set_irq(hwif, 0);
+
 	/* take a deep breath */
 	msleep(50);
 
@@ -329,29 +336,6 @@ static int actual_try_to_identify (ide_d
 	return rc;
 }
 
-/**
- *	try_to_identify	-	try to identify a drive
- *	@drive: drive to probe
- *	@cmd: command to use
- *
- *	Issue the identify command.
- */
- 
-static int try_to_identify (ide_drive_t *drive, u8 cmd)
-{
-	ide_hwif_t *hwif = drive->hwif;
-	const struct ide_tp_ops *tp_ops = hwif->tp_ops;
-
-	/*
-	 * Disable device IRQ.  Otherwise we'll get spurious interrupts
-	 * during the identify phase that the IRQ handler isn't expecting.
-	 */
-	if (hwif->io_ports.ctl_addr)
-		tp_ops->set_irq(hwif, 0);
-
-	return actual_try_to_identify(drive, cmd);
-}
-
 int ide_busy_sleep(ide_hwif_t *hwif, unsigned long timeout, int altstatus)
 {
 	u8 stat;
