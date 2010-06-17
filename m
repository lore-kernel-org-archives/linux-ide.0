From: Borislav Petkov <bp@alien8.de>
Subject: [Bug 16142] r8169: Kernel Panic when a lot of data is transferred
 through network interface
Date: Thu, 17 Jun 2010 10:07:26 +0200
Message-ID: <20100617080726.GA13713@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:39795 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759347Ab0FQIHd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 17 Jun 2010 04:07:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Hans42Mueller@googlemail.com
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-ide <linux-ide@vger.kernel.org>

Hi,

switching to mail for now.

Ok, this looks almost exactly like
https://bugzilla.kernel.org/show_bug.cgi?id=13399 and I have a theory :)

Hans, can you apply the debug patch below, rebuild your kernel and catch
the _whole_ output this time (not the oops only) and send it to me? It
might be a bit much with all the stack traces so let me know of any
troubles you might have catching it.

Thanks.

--
diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 64207df..436304c 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -552,8 +552,10 @@ static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
 	if (!OK_STAT(stat, 0, BAD_R_STAT)) {
 		rc = cdrom_decode_status(drive, stat);
 		if (rc) {
-			if (rc == 2)
+			if (rc == 2) {
+				printk(KERN_EMERG "%s: bad status with a sense rq\n", __func__);
 				goto out_end;
+			}
 			return ide_stopped;
 		}
 	}
@@ -667,8 +669,10 @@ out_end:
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
@@ -688,10 +692,13 @@ out_end:
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
index 172ac92..3317778 100644
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -57,6 +57,9 @@
 int ide_end_rq(ide_drive_t *drive, struct request *rq, int error,
 	       unsigned int nr_bytes)
 {
+
+	dump_stack();
+
 	/*
 	 * decide whether to reenable DMA -- 3 is a random magic for now,
 	 * if we DMA timeout more than 3 times, just stay in PIO
@@ -118,6 +121,8 @@ int ide_complete_rq(ide_drive_t *drive, int error, unsigned int nr_bytes)
 	struct request *rq = hwif->rq;
 	int rc;
 
+	dump_stack();
+
 	/*
 	 * if failfast is set on a request, override number of sectors
 	 * and complete the whole request right now
-- 
Regards/Gruss,
    Boris.
