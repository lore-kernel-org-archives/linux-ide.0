From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] qd65xx: fix PIO mode selection
Date: Sat, 23 Jun 2007 20:02:07 +0200
Message-ID: <200706232002.07091.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.175]:28896 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754816AbXFWRwz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 23 Jun 2007 13:52:55 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1019618ugf
        for <linux-ide@vger.kernel.org>; Sat, 23 Jun 2007 10:52:54 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


PIO4 is a maximum PIO mode supported by a driver.  Using "255" as a max_mode
argument to ide_get_best_pio_mode() could result in wrong timings being used
by a driver (for "pio" equal to 5) or OOPS (for "pio" values > 5 && < 255).

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/legacy/qd65xx.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -258,8 +258,7 @@ static void qd6580_tune_drive (ide_drive
 	int recovery_time = 415; /* worst case values from the dos driver */
 
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
-		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
-		pio = min_t(u8, pio, 4);
+		pio = ide_get_best_pio_mode(drive, pio, 4, &d);
 
 		switch (pio) {
 			case 0: break;
