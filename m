From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 52/63] ide-cd: add ide_cd_drain_data() helper
Date: Thu, 20 Dec 2007 02:31:57 +0100
Message-ID: <200712200231.57744.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.170]:12451 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755712AbXLTBe4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 19 Dec 2007 20:34:56 -0500
Received: by ug-out-1314.google.com with SMTP id z38so389252ugc.16
        for <linux-ide@vger.kernel.org>; Wed, 19 Dec 2007 17:34:55 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org


Add ide_cd_drain_data() and use it in cdrom_{buffer_sectors,read_intr}()
(as a nice side-effect this cuts 0.5kB of code from ide-cd.o).

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
-511 bytes
 drivers/ide/ide-cd.c |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-cd.c
===================================================================
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -626,6 +626,16 @@ static void ide_cd_pad_transfer(ide_driv
 	}
 }
 
+static void ide_cd_drain_data(ide_drive_t *drive, int nsects)
+{
+	while (nsects > 0) {
+		static char dum[SECTOR_SIZE];
+
+		drive->hwif->atapi_input_bytes(drive, dum, sizeof(dum));
+		nsects--;
+	}
+}
+
 /*
  * Buffer up to SECTORS_TO_TRANSFER sectors from the drive in our sector
  * buffer.  Once the first sector is added, any subsequent sectors are
@@ -664,11 +674,7 @@ static void cdrom_buffer_sectors (ide_dr
 	}
 
 	/* Throw away any remaining data. */
-	while (sectors_to_transfer > 0) {
-		static char dum[SECTOR_SIZE];
-		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));
-		--sectors_to_transfer;
-	}
+	ide_cd_drain_data(drive, sectors_to_transfer);
 }
 
 /*
@@ -791,14 +797,10 @@ static ide_startstop_t cdrom_read_intr (
 	   any of the leading sectors. */
 	nskip = min_t(int, rq->current_nr_sectors - bio_cur_sectors(rq->bio), sectors_to_transfer);
 
-	while (nskip > 0) {
-		/* We need to throw away a sector. */
-		static char dum[SECTOR_SIZE];
-		HWIF(drive)->atapi_input_bytes(drive, dum, sizeof (dum));
-
-		--rq->current_nr_sectors;
-		--nskip;
-		--sectors_to_transfer;
+	if (nskip > 0) {
+		ide_cd_drain_data(drive, nskip);
+		rq->current_nr_sectors -= nskip;
+		sectors_to_transfer -= nskip;
 	}
 
 	/* Now loop while we still have data to read from the drive. */
