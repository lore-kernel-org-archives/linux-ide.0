From: Borislav Petkov <bp@alien8.de>
Subject: Re: [Bug 16142] r8169: Kernel Panic when a lot of data is
 transferred through network interface
Date: Fri, 18 Jun 2010 09:45:10 +0200
Message-ID: <20100618074510.GD32368@liondog.tnic>
References: <20100617080726.GA13713@liondog.tnic>
 <20100617150008.16a5e653@cpc>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:38182 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752461Ab0FRHpQ (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 18 Jun 2010 03:45:16 -0400
Content-Disposition: inline
In-Reply-To: <20100617150008.16a5e653@cpc>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans Mueller <hans42mueller@googlemail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

From: Hans Mueller <hans42mueller@googlemail.com>
Date: Thu, Jun 17, 2010 at 03:00:08PM +0200

(readding original Cc list)

Ok, here's another debug/fix patch which should fix your issue. It boots
fine here but I can't hit your condition so please test it exactly
the same as yesterday and do catch the _complete_ output again. By
complete I mean not only the output from the ide-cd driver only but of
the machine from the very first line after it restarts for it could
contain valuable information there too.

Thanks a lot for your effort, here's the patch (you should replace this
one with the old patch, ask for help if you need any):

---
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 64207df..5ccc93d 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -506,15 +506,22 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 	return (flags & REQ_FAILED) ? -EIO : 0;
 }
 
-static void ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
+/*
+ * notify callers that we ended the rq by returning a !0 value
+ */
+static int ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	unsigned int nr_bytes = cmd->nbytes - cmd->nleft;
 
 	if (cmd->tf_flags & IDE_TFLAG_WRITE)
 		nr_bytes -= cmd->last_xfer_len;
 
-	if (nr_bytes > 0)
+	if (nr_bytes > 0) {
 		ide_complete_rq(drive, 0, nr_bytes);
+		return 1;
+	}
+
+	return 0;
 }
 
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
@@ -552,8 +559,10 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
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
@@ -667,8 +676,10 @@ out_end:
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
@@ -679,7 +690,10 @@ out_end:
 		}
 
 		if (uptodate == 0 && rq->bio)
-			ide_cd_error_cmd(drive, cmd);
+			if (ide_cd_error_cmd(drive, cmd)) {
+				printk(KERN_EMERG "ide_cd_error_cmd completes rq: %p\n", rq);
+				return ide_stopped;
+			}
 
 		/* make sure it's fully ended */
 		if (blk_fs_request(rq) == 0) {
@@ -688,10 +702,13 @@ out_end:
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
diff --git a/drivers/ide/ide-io.c b/drivers/ide/ide-io.c
index 172ac92..0952e3b 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -57,6 +57,8 @@
 int ide_end_rq(ide_drive_t *drive, struct request *rq, int error,
 	       unsigned int nr_bytes)
 {
+	dump_stack();
+
 	/*
 	 * decide whether to reenable DMA -- 3 is a random magic for now,
 	 * if we DMA timeout more than 3 times, just stay in PIO

-- 
Regards/Gruss,
    Boris.
