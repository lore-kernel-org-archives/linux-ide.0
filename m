From: Michael Buesch <mb@bu3sch.de>
Subject: [PATCH] ide-tape: Don't leak kernel stack information
Date: Sun, 19 Jul 2009 21:15:19 +0200
Message-ID: <200907192115.19958.mb@bu3sch.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bu3sch.de ([62.75.166.246]:49975 "EHLO vs166246.vserver.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750729AbZGSTQd (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 19 Jul 2009 15:16:33 -0400
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

Don't leak kernel stack information through uninitialized structure members.

Signed-off-by: Michael Buesch <mb@bu3sch.de>
Cc: stable@kernel.org

---

This patch is only compile tested.

---
 drivers/ide/ide-tape.c |    1 +
 1 file changed, 1 insertion(+)

--- linux-2.6.orig/drivers/ide/ide-tape.c
+++ linux-2.6/drivers/ide/ide-tape.c
@@ -1057,20 +1057,21 @@ static int idetape_blkdev_ioctl(ide_driv
 
 	debug_log(DBG_PROCS, "Enter %s\n", __func__);
 
 	switch (cmd) {
 	case 0x0340:
 		if (copy_from_user(&config, argp, sizeof(config)))
 			return -EFAULT;
 		tape->best_dsc_rw_freq = config.dsc_rw_frequency;
 		break;
 	case 0x0350:
+		memset(&config, 0, sizeof(config));
 		config.dsc_rw_frequency = (int) tape->best_dsc_rw_freq;
 		config.nr_stages = 1;
 		if (copy_to_user(argp, &config, sizeof(config)))
 			return -EFAULT;
 		break;
 	default:
 		return -EIO;
 	}
 	return 0;
 }

-- 
Greetings, Michael.
