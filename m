From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] ide: insert BUG_ON() into __ide_set_handler()
Date: Thu, 7 Feb 2008 20:05:50 +0300
Message-ID: <200802072005.50028.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtsoft3.corbina.net ([85.21.88.6]:57262 "EHLO
	buildserver.ru.mvista.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755630AbYBGRE6 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 7 Feb 2008 12:04:58 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Replace the check for hwgroup->handler and printk(KERN_CRIT, ...) at the start
of __ide_set_handler() with mere BUG_ON() while removing such from the caller,
ide_execute_command(). Fix up the code formatting, while at it...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/ide-iops.c |    9 ++-------
 1 files changed, 2 insertions(+), 7 deletions(-)

Index: linux-2.6/drivers/ide/ide-iops.c
===================================================================
--- linux-2.6.orig/drivers/ide/ide-iops.c
+++ linux-2.6/drivers/ide/ide-iops.c
@@ -786,15 +786,11 @@ static void __ide_set_handler (ide_drive
 {
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 
-	if (hwgroup->handler != NULL) {
-		printk(KERN_CRIT "%s: ide_set_handler: handler not null; "
-			"old=%p, new=%p\n",
-			drive->name, hwgroup->handler, handler);
-	}
+	BUG_ON(hwgroup->handler);
 	hwgroup->handler	= handler;
 	hwgroup->expiry		= expiry;
 	hwgroup->timer.expires	= jiffies + timeout;
-	hwgroup->req_gen_timer = hwgroup->req_gen;
+	hwgroup->req_gen_timer	= hwgroup->req_gen;
 	add_timer(&hwgroup->timer);
 }
 
@@ -831,7 +827,6 @@ void ide_execute_command(ide_drive_t *dr
 	ide_hwif_t *hwif = HWIF(drive);
 
 	spin_lock_irqsave(&ide_lock, flags);
-	BUG_ON(hwgroup->handler);
 	__ide_set_handler(drive, handler, timeout, expiry);
 	hwif->OUTBSYNC(drive, cmd, IDE_COMMAND_REG);
 	/*

