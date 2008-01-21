From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 10/16] ide: use __ide_set_handler() in ide_execute_command()
Date: Tue, 22 Jan 2008 00:31:44 +0100
Message-ID: <20080121233144.30311.5346.sendpatchset@localhost.localdomain>
References: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.169]:43625 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760690AbYAUXSj (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 21 Jan 2008 18:18:39 -0500
Received: by ug-out-1314.google.com with SMTP id z38so975308ugc.16
        for <linux-ide@vger.kernel.org>; Mon, 21 Jan 2008 15:18:37 -0800 (PST)
In-Reply-To: <20080121233036.30311.76015.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org


* Use __ide_set_handler() in ide_execute_command().

While at it:

* Fix whitespace damage in ide_execute_command().

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c |   21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -882,22 +882,17 @@ void ide_execute_command(ide_drive_t *dr
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = HWGROUP(drive);
 	ide_hwif_t *hwif = HWIF(drive);
-	
+
 	spin_lock_irqsave(&ide_lock, flags);
-	
 	BUG_ON(hwgroup->handler);
-	hwgroup->handler	= handler;
-	hwgroup->expiry		= expiry;
-	hwgroup->timer.expires	= jiffies + timeout;
-	hwgroup->req_gen_timer = hwgroup->req_gen;
-	add_timer(&hwgroup->timer);
+	__ide_set_handler(drive, handler, timeout, expiry);
 	hwif->OUTBSYNC(drive, cmd, IDE_COMMAND_REG);
-	/* Drive takes 400nS to respond, we must avoid the IRQ being
-	   serviced before that. 
-	   
-	   FIXME: we could skip this delay with care on non shared
-	   devices 
-	*/
+	/*
+	 * Drive takes 400nS to respond, we must avoid the IRQ being
+	 * serviced before that.
+	 *
+	 * FIXME: we could skip this delay with care on non shared devices
+	 */
 	ndelay(400);
 	spin_unlock_irqrestore(&ide_lock, flags);
 }
