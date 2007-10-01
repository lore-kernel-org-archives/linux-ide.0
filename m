From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/15] ht6560b: fix deadlock on error handling
Date: Mon, 1 Oct 2007 23:35:49 +0200
Message-ID: <200710012335.49553.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:62096 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757185AbXJAVjn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 1 Oct 2007 17:39:43 -0400
Received: by ug-out-1314.google.com with SMTP id z38so1977013ugc
        for <linux-ide@vger.kernel.org>; Mon, 01 Oct 2007 14:39:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Stop abusing ide_lock lock (switch to a private locking).

Fixes same issue as fixed by Alan Cox in atiixp host driver with
commit 6c5f8cc33eb2e10b6ab788bbe259fc142a068627.

ht6560b is a bit special cause we still need to leave ide_lock for
->set_pio_mode with 'pio' argument == 8/9 (prefetch disable/enable).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/ht6560b.c |   31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -247,6 +247,8 @@ static u8 ht_pio2timings(ide_drive_t *dr
 	}
 }
 
+static DEFINE_SPINLOCK(ht6560b_lock);
+
 /*
  *  Enable/Disable so called prefetch mode
  */
@@ -254,9 +256,9 @@ static void ht_set_prefetch(ide_drive_t 
 {
 	unsigned long flags;
 	int t = HT_PREFETCH_MODE << 8;
-	
-	spin_lock_irqsave(&ide_lock, flags);
-	
+
+	spin_lock_irqsave(&ht6560b_lock, flags);
+
 	/*
 	 *  Prefetch mode and unmask irq seems to conflict
 	 */
@@ -268,9 +270,9 @@ static void ht_set_prefetch(ide_drive_t 
 		drive->drive_data &= ~t;  /* disable prefetch mode */
 		drive->no_unmask = 0;
 	}
-	
-	spin_unlock_irqrestore(&ide_lock, flags);
-	
+
+	spin_unlock_irqrestore(&ht6560b_lock, flags);
+
 #ifdef DEBUG
 	printk("ht6560b: drive %s prefetch mode %sabled\n", drive->name, (state ? "en" : "dis"));
 #endif
@@ -284,19 +286,22 @@ static void ht6560b_set_pio_mode(ide_dri
 	switch (pio) {
 	case 8:         /* set prefetch off */
 	case 9:         /* set prefetch on */
+		/*
+		 * take ide_lock for drive->[no_]unmask
+		 */
+		spin_lock_irqsave(&ide_lock, flags);
 		ht_set_prefetch(drive, pio & 1);
+		spin_unlock_irqrestore(&ide_lock, flags);
 		return;
 	}
-	
+
 	timing = ht_pio2timings(drive, pio);
-	
-	spin_lock_irqsave(&ide_lock, flags);
-	
+
+	spin_lock_irqsave(&ht6560b_lock, flags);
 	drive->drive_data &= 0xff00;
 	drive->drive_data |= timing;
-	
-	spin_unlock_irqrestore(&ide_lock, flags);
-	
+	spin_unlock_irqrestore(&ht6560b_lock, flags);
+
 #ifdef DEBUG
 	printk("ht6560b: drive %s tuned to pio mode %#x timing=%#x\n", drive->name, pio, timing);
 #endif
