From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/6] ide: make "paranoia" ->handler check in ide_intr() more strict
Date: Mon, 29 Dec 2008 20:04:15 +0100
Message-ID: <20081229190415.1020.43119.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:54079 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751677AbYL2TD4 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 29 Dec 2008 14:03:56 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: make "paranoia" ->handler check in ide_intr() more strict

If ->handler is set while it shouldn't be it indicates deep problems
so BUG_ON()-ning and preventing further damage is much more appropriate
than merely printing an error message.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
trivia for pata-2.6 tree

 drivers/ide/ide-io.c |    9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1159,12 +1159,9 @@ irqreturn_t ide_intr (int irq, void *dev
 	 * won't allow another of the same (on any CPU) until we return.
 	 */
 	if (startstop == ide_stopped) {
-		if (hwif->handler == NULL) {	/* paranoia */
-			ide_unlock_port(hwif);
-			plug_device = 1;
-		} else
-			printk(KERN_ERR "%s: %s: huh? expected NULL handler "
-					"on exit\n", __func__, drive->name);
+		BUG_ON(hwif->handler);
+		ide_unlock_port(hwif);
+		plug_device = 1;
 	}
 out_handled:
 	irq_ret = IRQ_HANDLED;
