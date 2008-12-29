From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/6] ide: remove now redundant ->cur_dev checks
Date: Mon, 29 Dec 2008 20:04:49 +0100
Message-ID: <20081229190449.1020.75781.sendpatchset@localhost.localdomain>
References: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:54079 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753418AbYL2TE2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:04:28 -0500
In-Reply-To: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove now redundant ->cur_dev checks

* ->cur_dev should now be always valid if ->handler is set so
  remove redundant checks from ide_intr() and ide_timer_expiry().

* Apply CodingStyle fixups in ide_timer_expiry() while at it.

There should be no functional changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c |  105 +++++++++++++++++++++------------------------------
 1 file changed, 45 insertions(+), 60 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -920,60 +920,55 @@ void ide_timer_expiry (unsigned long dat
 		 * Either way, we don't really want to complain about anything.
 		 */
 	} else {
+		ide_expiry_t *expiry = hwif->expiry;
+		ide_startstop_t startstop = ide_stopped;
+
 		drive = hwif->cur_dev;
-		if (!drive) {
-			printk(KERN_ERR "%s: ->cur_dev was NULL\n", __func__);
-			hwif->handler = NULL;
-		} else {
-			ide_expiry_t *expiry = hwif->expiry;
-			ide_startstop_t startstop = ide_stopped;
 
-			if (expiry) {
-				/* continue */
-				if ((wait = expiry(drive)) > 0) {
-					/* reset timer */
-					hwif->timer.expires  = jiffies + wait;
-					hwif->req_gen_timer = hwif->req_gen;
-					add_timer(&hwif->timer);
-					spin_unlock_irqrestore(&hwif->lock, flags);
-					return;
-				}
-			}
-			hwif->handler = NULL;
-			/*
-			 * We need to simulate a real interrupt when invoking
-			 * the handler() function, which means we need to
-			 * globally mask the specific IRQ:
-			 */
-			spin_unlock(&hwif->lock);
-			/* disable_irq_nosync ?? */
-			disable_irq(hwif->irq);
-			/* local CPU only,
-			 * as if we were handling an interrupt */
-			local_irq_disable();
-			if (hwif->polling) {
-				startstop = handler(drive);
-			} else if (drive_is_ready(drive)) {
-				if (drive->waiting_for_dma)
-					hwif->dma_ops->dma_lost_irq(drive);
-				(void)ide_ack_intr(hwif);
-				printk(KERN_WARNING "%s: lost interrupt\n", drive->name);
-				startstop = handler(drive);
-			} else {
-				if (drive->waiting_for_dma) {
-					startstop = ide_dma_timeout_retry(drive, wait);
-				} else
-					startstop =
-					ide_error(drive, "irq timeout",
-						  hwif->tp_ops->read_status(hwif));
-			}
-			spin_lock_irq(&hwif->lock);
-			enable_irq(hwif->irq);
-			if (startstop == ide_stopped) {
-				ide_unlock_port(hwif);
-				plug_device = 1;
+		if (expiry) {
+			wait = expiry(drive);
+			if (wait > 0) { /* continue */
+				/* reset timer */
+				hwif->timer.expires = jiffies + wait;
+				hwif->req_gen_timer = hwif->req_gen;
+				add_timer(&hwif->timer);
+				spin_unlock_irqrestore(&hwif->lock, flags);
+				return;
 			}
 		}
+		hwif->handler = NULL;
+		/*
+		 * We need to simulate a real interrupt when invoking
+		 * the handler() function, which means we need to
+		 * globally mask the specific IRQ:
+		 */
+		spin_unlock(&hwif->lock);
+		/* disable_irq_nosync ?? */
+		disable_irq(hwif->irq);
+		/* local CPU only, as if we were handling an interrupt */
+		local_irq_disable();
+		if (hwif->polling) {
+			startstop = handler(drive);
+		} else if (drive_is_ready(drive)) {
+			if (drive->waiting_for_dma)
+				hwif->dma_ops->dma_lost_irq(drive);
+			(void)ide_ack_intr(hwif);
+			printk(KERN_WARNING "%s: lost interrupt\n",
+				drive->name);
+			startstop = handler(drive);
+		} else {
+			if (drive->waiting_for_dma)
+				startstop = ide_dma_timeout_retry(drive, wait);
+			else
+				startstop = ide_error(drive, "irq timeout",
+					hwif->tp_ops->read_status(hwif));
+		}
+		spin_lock_irq(&hwif->lock);
+		enable_irq(hwif->irq);
+		if (startstop == ide_stopped) {
+			ide_unlock_port(hwif);
+			plug_device = 1;
+		}
 	}
 	spin_unlock_irqrestore(&hwif->lock, flags);
 
@@ -1115,15 +1110,6 @@ irqreturn_t ide_intr (int irq, void *dev
 	}
 
 	drive = hwif->cur_dev;
-	if (!drive) {
-		/*
-		 * This should NEVER happen, and there isn't much
-		 * we could do about it here.
-		 *
-		 * [Note - this can occur if the drive is hot unplugged]
-		 */
-		goto out_handled;
-	}
 
 	if (!drive_is_ready(drive))
 		/*
@@ -1162,7 +1148,6 @@ irqreturn_t ide_intr (int irq, void *dev
 		ide_unlock_port(hwif);
 		plug_device = 1;
 	}
-out_handled:
 	irq_ret = IRQ_HANDLED;
 out:
 	spin_unlock_irqrestore(&hwif->lock, flags);
