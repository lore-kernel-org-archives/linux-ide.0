From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/9] ide: remove local_irq_set() macro
Date: Tue, 16 Dec 2008 20:31:57 +0100
Message-ID: <20081216193157.3959.80875.sendpatchset@localhost.localdomain>
References: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fk-out-0910.google.com ([209.85.128.187]:48276 "EHLO
	fk-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757867AbYLPTcF (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 16 Dec 2008 14:32:05 -0500
Received: by fk-out-0910.google.com with SMTP id 18so1900646fkq.5
        for <linux-ide@vger.kernel.org>; Tue, 16 Dec 2008 11:32:05 -0800 (PST)
In-Reply-To: <20081216193137.3959.70339.sendpatchset@localhost.localdomain>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-kernel@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove local_irq_set() macro

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-iops.c  |    3 ++-
 drivers/ide/ide-probe.c |    3 ++-
 include/linux/ide.h     |    2 --
 3 files changed, 4 insertions(+), 4 deletions(-)

Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -503,7 +503,8 @@ static int __ide_wait_stat(ide_drive_t *
 	stat = tp_ops->read_status(hwif);
 
 	if (stat & ATA_BUSY) {
-		local_irq_set(flags);
+		local_irq_save(flags);
+		local_irq_enable_in_hardirq();
 		timeout += jiffies;
 		while ((stat = tp_ops->read_status(hwif)) & ATA_BUSY) {
 			if (time_after(jiffies, timeout)) {
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -796,7 +796,8 @@ static int ide_probe_port(ide_hwif_t *hw
 	if (irqd)
 		disable_irq(hwif->irq);
 
-	local_irq_set(flags);
+	local_irq_save(flags);
+	local_irq_enable_in_hardirq();
 
 	if (ide_port_wait_ready(hwif) == -EBUSY)
 		printk(KERN_DEBUG "%s: Wait for ready failed before probe !\n", hwif->name);
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1585,8 +1585,6 @@ static inline void ide_set_max_pio(ide_d
 	ide_set_pio(drive, 255);
 }
 
-#define local_irq_set(flags)	do { local_save_flags((flags)); local_irq_enable_in_hardirq(); } while (0)
-
 char *ide_media_string(ide_drive_t *);
 
 extern struct device_attribute ide_dev_attrs[];
