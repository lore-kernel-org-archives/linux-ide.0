From: Borislav Petkov <bp@alien8.de>
Subject: [PATCH] ide-cd: Do not access completed requests in the irq handler
Date: Sat, 3 Jul 2010 13:01:04 +0200
Message-ID: <20100703110104.GB25293@liondog.tnic>
References: <20100619005045.2173fcce@cpc>
 <20100619100511.GA31429@liondog.tnic>
 <20100619132708.030fe408@cpc>
 <20100623080200.GB5010@liondog.tnic>
 <20100625185846.72171be0@cpc>
 <20100630065426.GA1857@liondog.tnic>
 <20100630200254.45ab84d1@cpc>
 <20100630183138.GA11036@liondog.tnic>
 <20100703094918.03007437@cbook.fritz.box>
 <20100703082304.GA25293@liondog.tnic>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.skyhub.de ([78.46.96.112]:59395 "EHLO mail.skyhub.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752673Ab0GCLBK (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Jul 2010 07:01:10 -0400
Content-Disposition: inline
In-Reply-To: <20100703082304.GA25293@liondog.tnic>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: David Miller <davem@davemloft.net>
Cc: Andrew Morton <akpm@linux-foundation.org>, Hans Mueller <hans42mueller@googlemail.com>, linux-ide <linux-ide@vger.kernel.org>

Hi Dave,

this came out as a by-product after debugging
https://bugzilla.kernel.org/show_bug.cgi?id=16142

It fixes the oops at
https://bugzilla.kernel.org/attachment.cgi?id=26776, please apply.

--
From: Borislav Petkov <bp@alien8.de>
Date: Fri, 2 Jul 2010 09:08:09 +0200
Subject: [PATCH] ide-cd: Do not access completed requests in the irq handler

ide_cd_error_cmd() can complete an erroneous request with leftover
buffers. Signal this with its return value so that the request is not
accessed after its completion in the irq handler and we oops.

Cc: <stable@kernel.org> # 32.x 33.x 34.x
Signed-off-by: Borislav Petkov <bp@alien8.de>
---
 drivers/ide/ide-cd.c |   14 +++++++++++---
 1 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 64207df..2de76cc 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -506,15 +506,22 @@ int ide_cd_queue_pc(ide_drive_t *drive, const unsigned char *cmd,
 	return (flags & REQ_FAILED) ? -EIO : 0;
 }
 
-static void ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
+/*
+ * returns true if rq has been completed
+ */
+static bool ide_cd_error_cmd(ide_drive_t *drive, struct ide_cmd *cmd)
 {
 	unsigned int nr_bytes = cmd->nbytes - cmd->nleft;
 
 	if (cmd->tf_flags & IDE_TFLAG_WRITE)
 		nr_bytes -= cmd->last_xfer_len;
 
-	if (nr_bytes > 0)
+	if (nr_bytes > 0) {
 		ide_complete_rq(drive, 0, nr_bytes);
+		return true;
+	}
+
+	return false;
 }
 
 static ide_startstop_t cdrom_newpc_intr(ide_drive_t *drive)
@@ -679,7 +686,8 @@ out_end:
 		}
 
 		if (uptodate == 0 && rq->bio)
-			ide_cd_error_cmd(drive, cmd);
+			if (ide_cd_error_cmd(drive, cmd))
+				return ide_stopped;
 
 		/* make sure it's fully ended */
 		if (blk_fs_request(rq) == 0) {
-- 
1.7.1


-- 
Regards/Gruss,
    Boris.
