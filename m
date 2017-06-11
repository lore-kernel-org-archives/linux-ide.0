From: Minwoo Im <dn3108@gmail.com>
Subject: [PATCH] libahci: wrong comments in ahci_do_softreset()
Date: Sun, 11 Jun 2017 23:53:00 +0900
Message-ID: <1497192780-7772-1-git-send-email-dn3108@gmail.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33916 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751764AbdFKOxH (ORCPT
        <rfc822;linux-ide@vger.kernel.org>); Sun, 11 Jun 2017 10:53:07 -0400
Received: by mail-pg0-f66.google.com with SMTP id v14so12117575pgn.1
        for <linux-ide@vger.kernel.org>; Sun, 11 Jun 2017 07:53:07 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: linux-ide@vger.kernel.org, Minwoo Im <dn3108@gmail.com>

AHCI 1.3.1 Spec says that software shall build two H2D register
FISes in the command list to send a software reset.
The comments in ahci_do_softreset() is currently D2H instead of H2D.

Signed-off-by: Minwoo Im <dn3108@gmail.com>
---
 drivers/ata/libahci.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/ata/libahci.c b/drivers/ata/libahci.c
index 3159f9e..835efe4 100644
--- a/drivers/ata/libahci.c
+++ b/drivers/ata/libahci.c
@@ -1400,7 +1400,7 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 
 	ata_tf_init(link->device, &tf);
 
-	/* issue the first D2H Register FIS */
+	/* issue the first H2D Register FIS */
 	msecs = 0;
 	now = jiffies;
 	if (time_after(deadline, now))
@@ -1417,7 +1417,7 @@ int ahci_do_softreset(struct ata_link *link, unsigned int *class,
 	/* spec says at least 5us, but be generous and sleep for 1ms */
 	ata_msleep(ap, 1);
 
-	/* issue the second D2H Register FIS */
+	/* issue the second H2D Register FIS */
 	tf.ctl &= ~ATA_SRST;
 	ahci_exec_polled_cmd(ap, pmp, &tf, 0, 0, 0);
 
-- 
1.7.9.5

