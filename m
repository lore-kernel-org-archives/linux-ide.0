From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Wed, 23 Jun 2010 10:02:00 +0200
Message-ID: <20100623080200.GB5010@liondog.tnic>
References: <20100617080726.GA13713@liondog.tnic>
 <20100617150008.16a5e653@cpc>
 <20100618074510.GD32368@liondog.tnic>
 <20100619005045.2173fcce@cpc>
 <20100619100511.GA31429@liondog.tnic>
 <20100619132708.030fe408@cpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:48273 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751190Ab0FWICH (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 23 Jun 2010 04:02:07 -0400
Content-Disposition: inline
In-Reply-To: <20100619132708.030fe408@cpc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Sat, Jun 19, 2010 at 01:27:08PM +0200

Right, ok, so this one is starting to get reeeal nasty...

Thanks for the logs.

> The hang seems to occur only if used my testcase (copying the file via
> scp (log11)). If I just boot the system and than shut it down again, the
> hang did not happen (log 10)

yeah, about that, can you boot your machine and do

cat /proc/interrupts > irqs

and

dmesg > dmesg.log

and send me the two files. It could be that the ide layer doesn't see
any interrupts anymore...

Also, when you shutdown after having done your test case, do you see any
activity after the "task ... blocked" backtrace? IOW, your log11 shows
that the device is processing some more requests but it could be because
of that other bug you said the capturing program had and maybe because
the kernel log buffer is not empty yet...

Here's the next debugging patch :), this one enables ide-cd full debug,
please apply and catch the output when shutting down.

Thanks for your hard work!

---
diff --git a/block/blk-core.c b/block/blk-core.c
index 9fe174d..1213e13 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -173,9 +173,9 @@ void blk_dump_rq_flags(struct request *rq, char *msg)
 {
 	int bit;
 
-	printk(KERN_INFO "%s: dev %s: type=%x, flags=%x\n", msg,
+	printk(KERN_INFO "%s: dev %s: type=%x, flags=%x, ref_count: %d\n", msg,
 		rq->rq_disk ? rq->rq_disk->disk_name : "?", rq->cmd_type,
-		rq->cmd_flags);
+		rq->cmd_flags, rq->ref_count);
 
 	printk(KERN_INFO "  sector %llu, nr/cnr %u/%u\n",
 	       (unsigned long long)blk_rq_pos(rq),
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 64207df..cefcaf4 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -448,6 +448,7 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		int error;
 
 		rq = blk_get_request(drive->queue, write, __GFP_WAIT);
+		blk_dump_rq_flags(rq, "ide_cd_queue_pc got rq");
 
 		memcpy(rq->cmd, cmd, BLK_MAX_CDB);
 		rq->cmd_type = REQ_TYPE_ATA_PC;
@@ -464,12 +465,14 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 		}
 
 		error = blk_execute_rq(drive->queue, info->disk, rq, 0);
+		blk_dump_rq_flags(rq, "ide_cd_queue_pc exec rq");
 
 		if (buffer)
 			*bufflen = rq->resid_len;
 
 		flags = rq->cmd_flags;
 		blk_put_request(rq);
+		blk_dump_rq_flags(rq, "ide_cd_queue_pc put rq");
 
 		/*
 		 * FIXME: we should probably abort/retry or something in case of
@@ -506,15 +509,23 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 	return (flags & REQ_FAILED) ? -EIO : 0;
 }
 
-static void ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
+/*
+ * notify callers that we ended the rq by returning a true value
+ */
+static bool ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	unsigned int nr_bytes = cmd->nbytes - cmd->nleft;
 
 	if (cmd->tf_flags & IDE_TFLAG_WRITE)
 		nr_bytes -= cmd->last_xfer_len;
 
-	if (nr_bytes > 0)
+	if (nr_bytes > 0) {
+		blk_dump_rq_flags(drive->hwif->rq, "ide_cd_error_cmd completes rq");
 		ide_complete_rq(drive, 0, nr_bytes);
+		return true;
+	}
+
+	return false;
 }
 
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
@@ -552,8 +563,10 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 	if (!OK_STAT(stat, 0, BAD_R_STAT)) {
 		rc = cdrom_decode_status(drive, stat);
 		if (rc) {
-			if (rc == 2)
+			if (rc == 2) {
+				printk(KERN_EMERG "%s: bad status with a sense rq: %p\n", __func__, rq);
 				goto out_end;
+			}
 			return ide_stopped;
 		}
 	}
@@ -667,8 +680,10 @@ out_end:
 		blk_end_request_all(rq, 0);
 		hwif->rq = NULL;
 	} else {
-		if (sense && uptodate)
+		if (sense && uptodate) {
+			printk(KERN_EMERG "%s: complete failed rq: %p\n", __func__, rq);
 			ide_cd_complete_failed_rq(drive, rq);
+		}
 
 		if (blk_fs_request(rq)) {
 			if (cmd->nleft == 0)
@@ -679,7 +694,10 @@ out_end:
 		}
 
 		if (uptodate == 0 && rq->bio)
-			ide_cd_error_cmd(drive, cmd);
+			if (ide_cd_error_cmd(drive, cmd)) {
+				printk(KERN_EMERG "ide_cd_error_cmd completes rq");
+				return ide_stopped;
+			}
 
 		/* make sure it's fully ended */
 		if (blk_fs_request(rq) == 0) {
@@ -688,10 +706,13 @@ out_end:
 				rq->resid_len += cmd->last_xfer_len;
 		}
 
+		printk(KERN_EMERG "%s: completing rq %p\n", __func__, rq);
 		ide_complete_rq(drive, uptodate ? 0 : -EIO, blk_rq_bytes(rq));
 
-		if (sense && rc == 2)
+		if (sense && rc == 2) {
+			printk(KERN_EMERG "%s: request sense failure, rq: %p\n", __func__, rq);
 			ide_error(drive, "request sense failure", stat);
+		}
 	}
 	return ide_stopped;
 }
@@ -1707,6 +1728,8 @@ static int ide_cd_probe(ide_drive_t *drive)
 	struct gendisk *g;
 	struct request_sense sense;
 
+	drive->debug_mask = 0xffffffff;
+
 	ide_debug_log(IDE_DBG_PROBE, "driver_req: %s, media: 0x%x",
 				     drive->driver_req, drive->media);
 
@@ -1716,7 +1739,6 @@ static int ide_cd_probe(ide_drive_t *drive)
 	if (drive->media != ide_cdrom && drive->media != ide_optical)
 		goto failed;
 
-	drive->debug_mask = debug_mask;
 	drive->irq_handler = cdrom_newpc_intr;
 
 	info = kzalloc(sizeof(struct cdrom_info), GFP_KERNEL);
diff --git a/drivers/ide/ide-cd.h b/drivers/ide/ide-cd.h
index 93a3cf1..613542a 100644
--- a/drivers/ide/ide-cd.h
+++ b/drivers/ide/ide-cd.h
@@ -8,7 +8,7 @@
 #include <linux/cdrom.h>
 #include <asm/byteorder.h>
 
-#define IDECD_DEBUG_LOG		0
+#define IDECD_DEBUG_LOG		1
 
 #if IDECD_DEBUG_LOG
 #define ide_debug_log(lvl, fmt, args...) __ide_debug_log(lvl, fmt, ## args)
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 172ac92..c522435 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -126,8 +126,13 @@ int ide_complete_rq(ide_drive_t *drive, int error, unsigned int nr_bytes)
 		nr_bytes = blk_rq_sectors(rq) << 9;
 
 	rc = ide_end_rq(drive, rq, error, nr_bytes);
-	if (rc == 0)
+	if (rc == 0) {
+		printk(KERN_EMERG "ide_complete_rq: no buffers pending for this rq");
 		hwif->rq = NULL;
+	}
+	else
+		blk_dump_rq_flags(rq, "still buffers pending for this rq");
+
 
 	return rc;
 }

-- 
Regards/Gruss,
    Boris.
