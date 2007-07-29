From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/12] ide: change master/slave IDENTIFY order
Date: Sun, 29 Jul 2007 19:49:59 +0200
Message-ID: <200707291949.59611.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:59697 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765027AbXG2SFO (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 29 Jul 2007 14:05:14 -0400
Received: by ug-out-1314.google.com with SMTP id j3so945455ugf
        for <linux-ide@vger.kernel.org>; Sun, 29 Jul 2007 11:05:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Craig Block <chblock3@yahoo.com>


Need to probe slave device first to make it release PDIAG-
(this is required for correct device side cable detection).

Based on libata commit f31f0cc2f0b7527072d94d02da332d9bb8d7d94c.

Thanks to Craig for testing this patch.

Cc: Craig Block <chblock3@yahoo.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
I just noticed that previously I sent it only in PM to Craig.

 drivers/ide/ide-iops.c  |    1 -
 drivers/ide/ide-probe.c |    7 +++----
 2 files changed, 3 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -612,7 +612,6 @@ u8 eighty_ninty_three (ide_drive_t *driv
 
 	/*
 	 * FIXME:
-	 * - change master/slave IDENTIFY order
 	 * - force bit13 (80c cable present) check also for !ivb devices
 	 *   (unless the slave device is pre-ATA3)
 	 */
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -719,9 +719,9 @@ EXPORT_SYMBOL_GPL(ide_undecoded_slave);
  */
 static void probe_hwif(ide_hwif_t *hwif, void (*fixup)(ide_hwif_t *hwif))
 {
-	unsigned int unit;
 	unsigned long flags;
 	unsigned int irqd;
+	int unit;
 
 	if (hwif->noprobe)
 		return;
@@ -777,10 +777,9 @@ static void probe_hwif(ide_hwif_t *hwif,
 		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
 
 	/*
-	 * Second drive should only exist if first drive was found,
-	 * but a lot of cdrom drives are configured as single slaves.
+	 * Need to probe slave device first to make it release PDIAG-.
 	 */
-	for (unit = 0; unit < MAX_DRIVES; ++unit) {
+	for (unit = MAX_DRIVES - 1; unit >= 0; unit--) {
 		ide_drive_t *drive = &hwif->drives[unit];
 		drive->dn = (hwif->channel ? 2 : 0) + unit;
 		(void) probe_for_drive(drive);
