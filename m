From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] ide: remove IDE_ARCH_INTR
Date: Tue, 27 Jan 2009 19:02:52 +0100
Message-ID: <20090127180252.28089.70513.sendpatchset@localhost.localdomain>
References: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Return-path: <linux-m68k-owner@vger.kernel.org>
In-Reply-To: <20090127180246.28089.2981.sendpatchset@localhost.localdomain>
Sender: linux-m68k-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, linux-m68k@vger.kernel.org
List-Id: linux-ide@vger.kernel.org

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove IDE_ARCH_INTR

This micro-optimization is not worth it.  Just always check for
existence of ->ack_intr method in ide_intr() and ide_timer_expiry().

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c   |    5 +++--
 include/asm-m68k/ide.h |    3 ---
 include/linux/ide.h    |    5 -----
 3 files changed, 3 insertions(+), 10 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -736,7 +736,8 @@ void ide_timer_expiry (unsigned long dat
 		} else if (drive_is_ready(drive)) {
 			if (drive->waiting_for_dma)
 				hwif->dma_ops->dma_lost_irq(drive);
-			(void)ide_ack_intr(hwif);
+			if (hwif->ack_intr(hwif))
+				hwif->ack_intr(hwif);
 			printk(KERN_WARNING "%s: lost interrupt\n",
 				drive->name);
 			startstop = handler(drive);
@@ -851,7 +852,7 @@ irqreturn_t ide_intr (int irq, void *dev
 
 	spin_lock_irqsave(&hwif->lock, flags);
 
-	if (!ide_ack_intr(hwif))
+	if (hwif->ack_intr && hwif->ack_intr(hwif) == 0)
 		goto out;
 
 	handler = hwif->handler;
Index: b/include/asm-m68k/ide.h
===================================================================
--- a/include/asm-m68k/ide.h
+++ b/include/asm-m68k/ide.h
@@ -123,8 +123,5 @@ ide_get_lock(irq_handler_t handler, void
 }
 #endif /* CONFIG_BLK_DEV_FALCON_IDE */
 
-#define IDE_ARCH_ACK_INTR
-#define ide_ack_intr(hwif)	((hwif)->ack_intr ? (hwif)->ack_intr(hwif) : 1)
-
 #endif /* __KERNEL__ */
 #endif /* _M68K_IDE_H */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -202,11 +202,6 @@ static inline void ide_std_init_ports(hw
 
 #define MAX_HWIFS	10
 
-/* Currently only m68k, apus and m8xx need it */
-#ifndef IDE_ARCH_ACK_INTR
-# define ide_ack_intr(hwif) (1)
-#endif
-
 /* Currently only Atari needs it */
 #ifndef IDE_ARCH_LOCK
 # define ide_release_lock()			do {} while (0)
