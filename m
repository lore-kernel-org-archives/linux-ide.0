From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [janitor] use kernel min/max (1/2)
Date: Tue, 16 Mar 2004 16:34:00 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040316163400.553e96b3.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:64682 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261875AbUCQAiD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Mar 2004 19:38:03 -0500
List-Id: linux-ide@vger.kernel.org
To: bart <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org

Hi,

Please apply to 2.6.current.

Thanks,
--
~Randy


From: Michael Veeck <michael.veeck@gmx.net>


Patch (against 2.6.3) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Regards
Michael


---

 linux-264-rc2-kj1-rddunlap/drivers/ide/ide-cd.c   |    8 ++++----
 linux-264-rc2-kj1-rddunlap/drivers/ide/ide-cd.h   |    2 --
 linux-264-rc2-kj1-rddunlap/drivers/ide/ide-tape.c |    2 +-
 3 files changed, 5 insertions(+), 7 deletions(-)

diff -puN drivers/ide/ide-cd.c~drivers_ide_minmax drivers/ide/ide-cd.c
--- linux-264-rc2-kj1/drivers/ide/ide-cd.c~drivers_ide_minmax	2004-03-08 16:48:59.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/ide-cd.c	2004-03-08 16:48:59.000000000 -0800
@@ -1012,7 +1012,7 @@ static void cdrom_buffer_sectors (ide_dr
 	struct cdrom_info *info = drive->driver_data;
 
 	/* Number of sectors to read into the buffer. */
-	int sectors_to_buffer = MIN (sectors_to_transfer,
+	int sectors_to_buffer = min_t(int, sectors_to_transfer,
 				     (SECTOR_BUFFER_SIZE >> SECTOR_BITS) -
 				       info->nsectors_buffered);
 
@@ -1161,7 +1161,7 @@ static ide_startstop_t cdrom_read_intr (
 
 	/* First, figure out if we need to bit-bucket
 	   any of the leading sectors. */
-	nskip = MIN((int)(rq->current_nr_sectors - bio_cur_sectors(rq->bio)), sectors_to_transfer);
+	nskip = min_t(int, (rq->current_nr_sectors - bio_cur_sectors(rq->bio)), sectors_to_transfer);
 
 	while (nskip > 0) {
 		/* We need to throw away a sector. */
@@ -1191,7 +1191,7 @@ static ide_startstop_t cdrom_read_intr (
 			/* Transfer data to the buffers.
 			   Figure out how many sectors we can transfer
 			   to the current buffer. */
-			this_transfer = MIN (sectors_to_transfer,
+			this_transfer = min_t(int, sectors_to_transfer,
 					     rq->current_nr_sectors);
 
 			/* Read this_transfer sectors
@@ -1907,7 +1907,7 @@ static ide_startstop_t cdrom_write_intr(
 		/*
 		 * Figure out how many sectors we can transfer
 		 */
-		this_transfer = MIN(sectors_to_transfer,rq->current_nr_sectors);
+		this_transfer = min_t(int, sectors_to_transfer,rq->current_nr_sectors);
 
 		while (this_transfer > 0) {
 			HWIF(drive)->atapi_output_bytes(drive, rq->buffer, SECTOR_SIZE);
diff -puN drivers/ide/ide-cd.h~drivers_ide_minmax drivers/ide/ide-cd.h
--- linux-264-rc2-kj1/drivers/ide/ide-cd.h~drivers_ide_minmax	2004-03-08 16:48:59.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/ide-cd.h	2004-03-08 16:48:59.000000000 -0800
@@ -54,8 +54,6 @@
 
 #define BLOCKS_PER_FRAME	(CD_FRAMESIZE / BLOCK_SIZE)
 
-#define MIN(a,b) ((a) < (b) ? (a) : (b))
-
 /* special command codes for strategy routine. */
 #define PACKET_COMMAND        4315
 #define REQUEST_SENSE_COMMAND 4316
diff -puN drivers/ide/ide-tape.c~drivers_ide_minmax drivers/ide/ide-tape.c
--- linux-264-rc2-kj1/drivers/ide/ide-tape.c~drivers_ide_minmax	2004-03-08 16:48:59.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/ide-tape.c	2004-03-08 16:48:59.000000000 -0800
@@ -4698,7 +4698,7 @@ static void idetape_setup (ide_drive_t *
 	 *	Ensure that the number we got makes sense; limit
 	 *	it within IDETAPE_DSC_RW_MIN and IDETAPE_DSC_RW_MAX.
 	 */
-	tape->best_dsc_rw_frequency = max((unsigned long) min(t, (unsigned long) IDETAPE_DSC_RW_MAX), (unsigned long) IDETAPE_DSC_RW_MIN);
+	tape->best_dsc_rw_frequency = max_t(unsigned long, min_t(unsigned long, t, IDETAPE_DSC_RW_MAX), IDETAPE_DSC_RW_MIN);
 	printk(KERN_INFO "ide-tape: %s <-> %s: %dKBps, %d*%dkB buffer, "
 		"%dkB pipeline, %lums tDSC%s\n",
 		drive->name, tape->name, tape->capabilities.speed,

_
