From: "Randy.Dunlap" <rddunlap@osdl.org>
Subject: [janitor] use kernel min/max (2/2)
Date: Tue, 16 Mar 2004 16:35:20 -0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040316163520.048ce536.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fw.osdl.org ([65.172.181.6]:64938 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261879AbUCQAiD (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Mar 2004 19:38:03 -0500
List-Id: linux-ide@vger.kernel.org
To: bart <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: linux-ide@vger.kernel.org


Hi,
Please apply to 2.6.current.

--
~Randy


From: Michael Veeck <michael.veeck@gmx.net>


Patch (against 2.6.3) removes unnecessary min/max macros and changes
calls to use kernel.h macros instead.

Best Regards
Michael

---

 linux-264-rc2-kj1-rddunlap/drivers/ide/ide-io.c        |    2 +-
 linux-264-rc2-kj1-rddunlap/drivers/ide/ide-proc.c      |    4 ++--
 linux-264-rc2-kj1-rddunlap/drivers/ide/legacy/qd65xx.c |    2 +-
 linux-264-rc2-kj1-rddunlap/drivers/ide/pci/cmd64x.c    |    2 +-
 linux-264-rc2-kj1-rddunlap/drivers/ide/pci/via82cxxx.c |    2 +-
 linux-264-rc2-kj1-rddunlap/drivers/scsi/ide-scsi.c     |   10 +++++-----
 linux-264-rc2-kj1-rddunlap/include/linux/ide.h         |    2 --
 7 files changed, 11 insertions(+), 13 deletions(-)

diff -puN drivers/ide/ide-io.c~drivers_ide_minmax2 drivers/ide/ide-io.c
--- linux-264-rc2-kj1/drivers/ide/ide-io.c~drivers_ide_minmax2	2004-03-08 16:49:15.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/ide-io.c	2004-03-08 16:49:15.000000000 -0800
@@ -741,7 +741,7 @@ repeat:	
 				 && 0 < (signed long)(WAKEUP(drive) - (jiffies - best->service_time))
 				 && 0 < (signed long)((jiffies + t) - WAKEUP(drive)))
 				{
-					ide_stall_queue(best, IDE_MIN(t, 10 * WAIT_MIN_SLEEP));
+					ide_stall_queue(best, min_t(long, t, 10 * WAIT_MIN_SLEEP));
 					goto repeat;
 				}
 			} while ((drive = drive->next) != best);
diff -puN drivers/ide/ide-proc.c~drivers_ide_minmax2 drivers/ide/ide-proc.c
--- linux-264-rc2-kj1/drivers/ide/ide-proc.c~drivers_ide_minmax2	2004-03-08 16:49:15.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/ide-proc.c	2004-03-08 16:49:15.000000000 -0800
@@ -508,8 +508,8 @@ int proc_ide_write_settings
 			}
 			if (*p != ':')
 				goto parse_error;
-			len = IDE_MIN(p - start, MAX_LEN);
-			strncpy(name, start, IDE_MIN(len, MAX_LEN));
+			len = min(p - start, MAX_LEN);
+			strncpy(name, start, min(len, MAX_LEN));
 			name[len] = 0;
 
 			if (n > 0) {
diff -puN drivers/ide/legacy/qd65xx.c~drivers_ide_minmax2 drivers/ide/legacy/qd65xx.c
--- linux-264-rc2-kj1/drivers/ide/legacy/qd65xx.c~drivers_ide_minmax2	2004-03-08 16:49:15.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/legacy/qd65xx.c	2004-03-08 16:49:15.000000000 -0800
@@ -262,7 +262,7 @@ static void qd6580_tune_drive (ide_drive
 
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
 		pio = ide_get_best_pio_mode(drive, pio, 255, &d);
-		pio = IDE_MIN(pio,4);
+		pio = min_t(u8, pio,4);
 
 		switch (pio) {
 			case 0: break;
diff -puN drivers/ide/pci/cmd64x.c~drivers_ide_minmax2 drivers/ide/pci/cmd64x.c
--- linux-264-rc2-kj1/drivers/ide/pci/cmd64x.c~drivers_ide_minmax2	2004-03-08 16:49:15.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/pci/cmd64x.c	2004-03-08 16:49:15.000000000 -0800
@@ -200,7 +200,7 @@ static void program_drive_counts (ide_dr
 	 */
 	if (channel) {
 		drive->drive_data = setup_count;
-		setup_count = IDE_MAX(drives[0].drive_data,
+		setup_count = max(drives[0].drive_data,
 					drives[1].drive_data);
 		cmdprintk("Secondary interface, setup_count = %d\n",
 					setup_count);
diff -puN drivers/ide/pci/via82cxxx.c~drivers_ide_minmax2 drivers/ide/pci/via82cxxx.c
--- linux-264-rc2-kj1/drivers/ide/pci/via82cxxx.c~drivers_ide_minmax2	2004-03-08 16:49:15.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/ide/pci/via82cxxx.c	2004-03-08 16:49:15.000000000 -0800
@@ -375,7 +375,7 @@ static void via82cxxx_tune_drive(ide_dri
 		return;
 	}
 
-	via_set_drive(drive, XFER_PIO_0 + MIN(pio, 5));
+	via_set_drive(drive, XFER_PIO_0 + min_t(u8, pio, 5));
 }
 
 /**
diff -puN drivers/scsi/ide-scsi.c~drivers_ide_minmax2 drivers/scsi/ide-scsi.c
--- linux-264-rc2-kj1/drivers/scsi/ide-scsi.c~drivers_ide_minmax2	2004-03-08 16:49:15.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/drivers/scsi/ide-scsi.c	2004-03-08 16:49:15.000000000 -0800
@@ -145,7 +145,7 @@ static void idescsi_input_buffers (ide_d
 			idescsi_discard_data (drive, bcount);
 			return;
 		}
-		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
+		count = min(pc->sg->length - pc->b_count, bcount);
 		buf = page_address(pc->sg->page) + pc->sg->offset;
 		atapi_input_bytes (drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
@@ -167,7 +167,7 @@ static void idescsi_output_buffers (ide_
 			idescsi_output_zeros (drive, bcount);
 			return;
 		}
-		count = IDE_MIN (pc->sg->length - pc->b_count, bcount);
+		count = min(pc->sg->length - pc->b_count, bcount);
 		buf = page_address(pc->sg->page) + pc->sg->offset;
 		atapi_output_bytes (drive, buf + pc->b_count, count);
 		bcount -= count; pc->b_count += count;
@@ -354,7 +354,7 @@ static int idescsi_end_request (ide_driv
 			if (!test_bit(PC_WRITING, &pc->flags) && pc->actually_transferred && pc->actually_transferred <= 1024 && pc->buffer) {
 				printk(", rst = ");
 				scsi_buf = pc->scsi_cmd->request_buffer;
-				hexdump(scsi_buf, IDE_MIN(16, pc->scsi_cmd->request_bufflen));
+				hexdump(scsi_buf, min_t(int, 16, pc->scsi_cmd->request_bufflen));
 			} else printk("\n");
 		}
 	}
@@ -371,7 +371,7 @@ static int idescsi_end_request (ide_driv
 
 static inline unsigned long get_timeout(idescsi_pc_t *pc)
 {
-	return IDE_MAX(WAIT_CMD, pc->timeout - jiffies);
+	return max_t(long, WAIT_CMD, pc->timeout - jiffies);
 }
 
 /*
@@ -515,7 +515,7 @@ static ide_startstop_t idescsi_issue_pc 
 	scsi->pc=pc;							/* Set the current packet command */
 	pc->actually_transferred=0;					/* We haven't transferred any data yet */
 	pc->current_position=pc->buffer;
-	bcount.all = IDE_MIN(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
+	bcount.all = min(pc->request_transfer, 63 * 1024);		/* Request to transfer the entire buffer at once */
 
 	feature.all = 0;
 	if (drive->using_dma && rq->bio) {
diff -puN include/linux/ide.h~drivers_ide_minmax2 include/linux/ide.h
--- linux-264-rc2-kj1/include/linux/ide.h~drivers_ide_minmax2	2004-03-08 16:49:15.000000000 -0800
+++ linux-264-rc2-kj1-rddunlap/include/linux/ide.h	2004-03-08 16:49:15.000000000 -0800
@@ -237,8 +237,6 @@ typedef unsigned char	byte;	/* used ever
 #define SECTOR_SIZE	512
 #define SECTOR_WORDS	(SECTOR_SIZE / 4)	/* number of 32bit words per sector */
 #define IDE_LARGE_SEEK(b1,b2,t)	(((b1) > (b2) + (t)) || ((b2) > (b1) + (t)))
-#define IDE_MIN(a,b)	((a)<(b) ? (a):(b))
-#define IDE_MAX(a,b)	((a)>(b) ? (a):(b))
 
 /*
  * Timeouts for various operations:

_
