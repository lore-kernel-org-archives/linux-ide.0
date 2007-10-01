From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 8/15] ide: take ide_lock for prefetch disable/enable in do_special()
Date: Mon, 1 Oct 2007 23:36:42 +0200
Message-ID: <200710012336.42728.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.172]:61343 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757195AbXJAVjo (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:44 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977009ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:44 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Take ide_lock for prefetch disable/enable in do_special(),
then cleanup cmd640 and ht6560b host drivers.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c         |   15 ++++++++++++++-
 drivers/ide/legacy/ht6560b.c |    5 -----
 drivers/ide/pci/cmd640.c     |    6 ------
 3 files changed, 14 insertions(+), 12 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -835,7 +835,20 @@ static ide_startstop_t do_special (ide_d
 		s->b.set_tune = 0;
 
 		if (set_pio_mode_abuse(drive->hwif, req_pio)) {
-			if (hwif->set_pio_mode)
+
+			if (hwif->set_pio_mode == NULL)
+				return ide_stopped;
+
+			/*
+			 * take ide_lock for drive->[no_]unmask/[no_]io_32bit
+			 */
+			if (req_pio == 8 || req_pio == 9) {
+				unsigned long flags;
+
+				spin_lock_irqsave(&ide_lock, flags);
+				hwif->set_pio_mode(drive, req_pio);
+				spin_unlock_irqrestore(&ide_lock, flags);
+			} else
 				hwif->set_pio_mode(drive, req_pio);
 		} else {
 			int keep_dma = drive->using_dma;
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -286,12 +286,7 @@ static void ht6560b_set_pio_mode(ide_dri
 	switch (pio) {
 	case 8:         /* set prefetch off */
 	case 9:         /* set prefetch on */
-		/*
-		 * take ide_lock for drive->[no_]unmask
-		 */
-		spin_lock_irqsave(&ide_lock, flags);
 		ht_set_prefetch(drive, pio & 1);
-		spin_unlock_irqrestore(&ide_lock, flags);
 		return;
 	}
 
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -632,7 +632,6 @@ static void cmd640_set_mode (unsigned in
 
 static void cmd640_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	unsigned long flags;
 	unsigned int index = 0, cycle_time;
 	u8 b;
 
@@ -655,12 +654,7 @@ static void cmd640_set_pio_mode(ide_driv
 
 		case 8: /* set prefetch off */
 		case 9: /* set prefetch on */
-			/*
-			 * take ide_lock for drive->[no_]unmask/[no_]io_32bit
-			 */
-			spin_lock_irqsave(&ide_lock, flags);
 			set_prefetch_mode(index, pio & 1);
-			spin_unlock_irqrestore(&ide_lock, flags);
 			printk("%s: %sabled cmd640 prefetch\n", drive->name, (pio & 1) ? "en" : "dis");
 			return;
 	}
