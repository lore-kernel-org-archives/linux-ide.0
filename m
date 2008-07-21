From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: enable local IRQs in all handlers for TASKFILE_NO_DATA data phase
Date: Mon, 21 Jul 2008 21:09:09 +0200
Message-ID: <200807212109.09858.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:33547 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753580AbYGUTNg (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jul 2008 15:13:36 -0400
Received: by ug-out-1314.google.com with SMTP id h2so297345ugf.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jul 2008 12:13:35 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

It is already done by task_no_data_intr() and there is no reason
not to do it in other TASKFILE_NO_DATA data phase handlers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-taskfile.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

Index: b/drivers/ide/ide-taskfile.c
===================================================================
--- a/drivers/ide/ide-taskfile.c
+++ b/drivers/ide/ide-taskfile.c
@@ -126,7 +126,10 @@ EXPORT_SYMBOL_GPL(do_rw_taskfile);
 static ide_startstop_t set_multmode_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	u8 stat = hwif->tp_ops->read_status(hwif);
+	u8 stat;
+
+	local_irq_enable_in_hardirq();
+	stat = hwif->tp_ops->read_status(hwif);
 
 	if (OK_STAT(stat, READY_STAT, BAD_STAT))
 		drive->mult_count = drive->mult_req;
@@ -147,6 +150,8 @@ static ide_startstop_t set_geometry_intr
 	int retries = 5;
 	u8 stat;
 
+	local_irq_enable_in_hardirq();
+
 	while (1) {
 		stat = hwif->tp_ops->read_status(hwif);
 		if ((stat & BUSY_STAT) == 0 || retries-- == 0)
@@ -170,7 +175,10 @@ static ide_startstop_t set_geometry_intr
 static ide_startstop_t recal_intr(ide_drive_t *drive)
 {
 	ide_hwif_t *hwif = drive->hwif;
-	u8 stat = hwif->tp_ops->read_status(hwif);
+	u8 stat;
+
+	local_irq_enable_in_hardirq();
+	stat = hwif->tp_ops->read_status(hwif);
 
 	if (!OK_STAT(stat, READY_STAT, BAD_STAT))
 		return ide_error(drive, "recal_intr", stat);
