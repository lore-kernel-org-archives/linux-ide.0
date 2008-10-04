From: Borislav Petkov <petkovbb@googlemail.com>
Subject: Bug 11581
Date: Sat, 4 Oct 2008 11:12:32 +0200
Message-ID: <20081004091232.GB4160@gollum.tnic>
Reply-To: petkovbb@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.157]:7366 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793AbYJDJMk (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 4 Oct 2008 05:12:40 -0400
Received: by fg-out-1718.google.com with SMTP id 19so1311302fgg.17
        for <linux-ide@vger.kernel.org>; Sat, 04 Oct 2008 02:12:38 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Santiago Vila <sanvila@unex.es>
Cc: bzolnier@gmail.com, axboe@kernel.dk, linux-ide@vger.kernel.org

Hi,

can you please apply the following revised inquiry patch and send me your dmesg
so that we get more info on what exactly triggers that begavior with your drive?

Thanks.

---
 drivers/ide/ide-cd.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/ide/ide-cd.c b/drivers/ide/ide-cd.c
index 1f2df24..d5106d0 100644
--- a/drivers/ide/ide-cd.c
+++ b/drivers/ide/ide-cd.c
@@ -1329,6 +1329,15 @@ static ide_startstop_t ide_cd_do_request(ide_drive_t *drive, struct request *rq,
 		if (!rq->timeout)
 			rq->timeout = ATAPI_WAIT_PC;
 
+		if (blk_pc_request(rq)) {
+			printk(KERN_ERR "Sending BLOCK_PC to drive! Fixed.\n");
+			blk_dump_rq_flags(rq, "Original rq: ");
+			printk(KERN_ERR "rq->cmd_len: %d\n", rq->cmd_len);
+			rq->cmd_type = REQ_TYPE_ATA_PC;
+
+			dump_stack();
+		}
+
 		cdrom_do_block_pc(drive, rq);
 	} else if (blk_special_request(rq)) {
 		/* right now this can only be a reset... */
-- 
1.5.5.4

-- 
Regards/Gruss,
    Boris.
