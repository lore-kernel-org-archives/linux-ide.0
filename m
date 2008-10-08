From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/7] ide: unify ide_intr()'s exit points
Date: Wed, 08 Oct 2008 22:29:37 +0200
Message-ID: <20081008202937.19112.15735.sendpatchset@localhost.localdomain>
References: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.171]:10615 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755169AbYJHUbP (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 8 Oct 2008 16:31:15 -0400
Received: by ug-out-1314.google.com with SMTP id k3so697271ugf.37
        for <linux-ide@vger.kernel.org>; Wed, 08 Oct 2008 13:31:12 -0700 (PDT)
In-Reply-To: <20081008202930.19112.90371.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: unify ide_intr()'s exit points

Just a preparation for future changes.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |   27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1363,14 +1363,13 @@ irqreturn_t ide_intr (int irq, void *dev
 	ide_drive_t *drive;
 	ide_handler_t *handler;
 	ide_startstop_t startstop;
+	irqreturn_t irq_ret = IRQ_NONE;
 
 	spin_lock_irqsave(&ide_lock, flags);
 	hwif = hwgroup->hwif;
 
-	if (!ide_ack_intr(hwif)) {
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return IRQ_NONE;
-	}
+	if (!ide_ack_intr(hwif))
+		goto out;
 
 	if ((handler = hwgroup->handler) == NULL || hwgroup->polling) {
 		/*
@@ -1406,9 +1405,9 @@ irqreturn_t ide_intr (int irq, void *dev
 			(void)hwif->tp_ops->read_status(hwif);
 #endif /* CONFIG_BLK_DEV_IDEPCI */
 		}
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return IRQ_NONE;
+		goto out;
 	}
+
 	drive = hwgroup->drive;
 	if (!drive) {
 		/*
@@ -1417,10 +1416,10 @@ irqreturn_t ide_intr (int irq, void *dev
 		 *
 		 * [Note - this can occur if the drive is hot unplugged]
 		 */
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return IRQ_HANDLED;
+		goto out_handled;
 	}
-	if (!drive_is_ready(drive)) {
+
+	if (!drive_is_ready(drive))
 		/*
 		 * This happens regularly when we share a PCI IRQ with
 		 * another device.  Unfortunately, it can also happen
@@ -1428,9 +1427,8 @@ irqreturn_t ide_intr (int irq, void *dev
 		 * their status register is up to date.  Hopefully we have
 		 * enough advance overhead that the latter isn't a problem.
 		 */
-		spin_unlock_irqrestore(&ide_lock, flags);
-		return IRQ_NONE;
-	}
+		goto out;
+
 	if (!hwgroup->busy) {
 		hwgroup->busy = 1;	/* paranoia */
 		printk(KERN_ERR "%s: ide_intr: hwgroup->busy was 0 ??\n", drive->name);
@@ -1467,8 +1465,11 @@ irqreturn_t ide_intr (int irq, void *dev
 				"on exit\n", drive->name);
 		}
 	}
+out_handled:
+	irq_ret = IRQ_HANDLED;
+out:
 	spin_unlock_irqrestore(&ide_lock, flags);
-	return IRQ_HANDLED;
+	return irq_ret;
 }
 
 /**
