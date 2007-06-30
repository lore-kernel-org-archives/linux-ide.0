From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/15] ide: ide_find_best_pio_mode() fixes
Date: Sat, 30 Jun 2007 21:04:42 +0200
Message-ID: <200706302104.42299.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.185]:51198 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754206AbXF3TAL (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:11 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1759202mue
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Check IORDY bit for PIO modes > 2.

* Some devices claim maximum PIO mode > 2 in id->tPIO, they were punished too
  severly for this by being limited to PIO_SLOW.  Limit them to PIO2 instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-timing.h |   10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-timing.h
===================================================================
--- a/drivers/ide/ide-timing.h
+++ b/drivers/ide/ide-timing.h
@@ -111,16 +111,14 @@ static short ide_find_best_pio_mode(ide_
 	struct hd_driveid *id = drive->id;
 	short best = 0;
 
-	if (id->field_valid & 2) {	/* EIDE PIO modes */
-
+	/* EIDE PIO modes */
+	if ((id->field_valid & 2) && (id->capability & 8)) {
 		if ((best = (drive->id->eide_pio_modes & 4) ? XFER_PIO_5 :
 			    (drive->id->eide_pio_modes & 2) ? XFER_PIO_4 :
 			    (drive->id->eide_pio_modes & 1) ? XFER_PIO_3 : 0)) return best;
 	}
-	
-	return  (drive->id->tPIO == 2) ? XFER_PIO_2 :
-		(drive->id->tPIO == 1) ? XFER_PIO_1 :
-		(drive->id->tPIO == 0) ? XFER_PIO_0 : XFER_PIO_SLOW;
+
+	return min_t(u8, id->tPIO, 2);
 }
 
 static void ide_timing_quantize(struct ide_timing *t, struct ide_timing *q, int T, int UT)
