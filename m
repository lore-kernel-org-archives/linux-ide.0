From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 9/9] ide: init_irq() doesn't need to hold ide_cfg_mtx
Date: Tue, 06 Jan 2009 19:36:18 +0100
Message-ID: <20090106183618.21193.63493.sendpatchset@localhost.localdomain>
References: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-bw0-f21.google.com ([209.85.218.21]:63672 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755167AbZAFSff (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 6 Jan 2009 13:35:35 -0500
In-Reply-To: <20090106183520.21193.63704.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: init_irq() doesn't need to hold ide_cfg_mtx

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-probe.c |    4 ----
 1 file changed, 4 deletions(-)

Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -938,8 +938,6 @@ static int init_irq (ide_hwif_t *hwif)
 	struct ide_io_ports *io_ports = &hwif->io_ports;
 	int sa = 0;
 
-	mutex_lock(&ide_cfg_mtx);
-
 #if defined(__mc68000__)
 	sa = IRQF_SHARED;
 #endif /* __mc68000__ */
@@ -965,10 +963,8 @@ static int init_irq (ide_hwif_t *hwif)
 		printk(KERN_CONT " (serialized)");
 	printk(KERN_CONT "\n");
 
-	mutex_unlock(&ide_cfg_mtx);
 	return 0;
 out_up:
-	mutex_unlock(&ide_cfg_mtx);
 	return 1;
 }
 
