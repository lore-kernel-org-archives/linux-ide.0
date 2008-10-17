From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [RFC PATCH] falconide: remove needless ST-DMA locking
Date: Fri, 17 Oct 2008 20:41:17 +0200
Message-ID: <200810172041.17191.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-m68k-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-m68k-owner@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-m68k@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Schmitz <schmitz@debian.org>, Stephen R Marenka <stephen@marenka.net>
List-Id: linux-ide@vger.kernel.org

While working on ide_do_request() improvements I stumbled upon
mismatched ide_get_lock() / ide_release_lock() calls.

[ It seems to be known issue:
  http://marc.info/?l=linux-m68k&m=121423752829622&w=2 ]

I may be completely wrong but how's about the following patch?

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [RFC PATCH] falconide: remove needless ST-DMA locking

According to comments in arch/m68k/atari/stdma.c IDE controller on
Atari Falcon doesn't use ST-DMA chip itself and no locking is needed
(both ST-DMA and IDE IRQ handlers are registered with IRQF_SHARED).

* Remove code for locking ST-DMA from <asm-m68k/ide.h>
  and falconide.c.

* Remove ide_{get,release}_lock() from ide_do_request()
  (it was broken anyway).

* Remove #ifndef IDE_ARCH_LOCK handling from <linux/ide.h>.

This patch should fix "ide_release_lock: bug" errors reported
by Stephen R Marenka.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Michael Schmitz <schmitz@debian.org>
Cc: Stephen R Marenka <stephen@marenka.net>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
against Linus' tree

 drivers/ide/ide-io.c           |   12 +-----------
 drivers/ide/legacy/falconide.c |   11 -----------
 include/asm-m68k/ide.h         |   31 -------------------------------
 include/linux/ide.h            |    6 ------
 4 files changed, 1 insertion(+), 59 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -967,9 +967,6 @@ static void ide_do_request (ide_hwgroup_
 	ide_startstop_t	startstop;
 	int             loops = 0;
 
-	/* for atari only: POSSIBLY BROKEN HERE(?) */
-	ide_get_lock(ide_intr, hwgroup);
-
 	/* caller must own ide_lock */
 	BUG_ON(!irqs_disabled());
 
@@ -1008,15 +1005,8 @@ static void ide_do_request (ide_hwgroup_
 				mod_timer(&hwgroup->timer, sleep);
 				/* we purposely leave hwgroup->busy==1
 				 * while sleeping */
-			} else {
-				/* Ugly, but how can we sleep for the lock
-				 * otherwise? perhaps from tq_disk?
-				 */
-
-				/* for atari only */
-				ide_release_lock();
+			} else
 				hwgroup->busy = 0;
-			}
 
 			/* no more work for this hwgroup (for now) */
 			return;
Index: b/drivers/ide/legacy/falconide.c
===================================================================
--- a/drivers/ide/legacy/falconide.c
+++ b/drivers/ide/legacy/falconide.c
@@ -35,14 +35,6 @@
 
 #define ATA_HD_CONTROL	0x39
 
-    /*
-     *  falconide_intr_lock is used to obtain access to the IDE interrupt,
-     *  which is shared between several drivers.
-     */
-
-int falconide_intr_lock;
-EXPORT_SYMBOL(falconide_intr_lock);
-
 static void falconide_input_data(ide_drive_t *drive, struct request *rq,
 				 void *buf, unsigned int len)
 {
@@ -133,10 +125,7 @@ static int __init falconide_init(void)
 		goto err;
 	}
 
-	ide_get_lock(NULL, NULL);
 	rc = ide_host_register(host, &falconide_port_info, hws);
-	ide_release_lock();
-
 	if (rc)
 		goto err_free;
 
Index: b/include/asm-m68k/ide.h
===================================================================
--- a/include/asm-m68k/ide.h
+++ b/include/asm-m68k/ide.h
@@ -101,37 +101,6 @@
 #define M68K_IDE_SWAPW  (MACH_IS_Q40 || MACH_IS_ATARI)
 #endif
 
-#ifdef CONFIG_BLK_DEV_FALCON_IDE
-#define IDE_ARCH_LOCK
-
-extern int falconide_intr_lock;
-
-static __inline__ void ide_release_lock (void)
-{
-	if (MACH_IS_ATARI) {
-		if (falconide_intr_lock == 0) {
-			printk("ide_release_lock: bug\n");
-			return;
-		}
-		falconide_intr_lock = 0;
-		stdma_release();
-	}
-}
-
-static __inline__ void
-ide_get_lock(irq_handler_t handler, void *data)
-{
-	if (MACH_IS_ATARI) {
-		if (falconide_intr_lock == 0) {
-			if (in_interrupt() > 0)
-				panic( "Falcon IDE hasn't ST-DMA lock in interrupt" );
-			stdma_lock(handler, data);
-			falconide_intr_lock = 1;
-		}
-	}
-}
-#endif /* CONFIG_BLK_DEV_FALCON_IDE */
-
 #define IDE_ARCH_ACK_INTR
 #define ide_ack_intr(hwif)	((hwif)->ack_intr ? (hwif)->ack_intr(hwif) : 1)
 
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -241,12 +241,6 @@ static inline int __ide_default_irq(unsi
 # define ide_ack_intr(hwif) (1)
 #endif
 
-/* Currently only Atari needs it */
-#ifndef IDE_ARCH_LOCK
-# define ide_release_lock()			do {} while (0)
-# define ide_get_lock(hdlr, data)		do {} while (0)
-#endif /* IDE_ARCH_LOCK */
-
 /*
  * Now for the data we need to maintain per-drive:  ide_drive_t
  */
