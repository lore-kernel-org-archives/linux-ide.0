From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: remove stale ide.h "configuration options"
Date: Fri, 26 Oct 2007 23:29:17 +0200
Message-ID: <200710262329.17605.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.188]:33381 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757761AbXJZVXq (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 26 Oct 2007 17:23:46 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1541467mue
        for <linux-ide@vger.kernel.org>; Fri, 26 Oct 2007 14:23:43 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


Remove stale ide.h "configuration options":

* INITIAL_MULT_COUNT - always defined to 0

* SUPPORT_SLOW_DATA_PORTS - unused

* OK_TO_RESET_CONTROLLER - always defined to 0

* DISABLE_IRQ_NOSYNC - always defined to 0

Leave SUPPORT_VLB_SYNC (defined to 0 for CRIS and FRV, otherwise to 1)
for now but disallow overriding it by <asm/ide.h>.

There should be no functionality changes caused by this patch.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-io.c            |    4 ----
 drivers/ide/ide-iops.c          |    9 ++-------
 drivers/ide/ide-probe.c         |    4 ++--
 include/asm-cris/arch-v10/ide.h |    5 -----
 include/asm-cris/arch-v32/ide.h |    5 -----
 include/asm-frv/ide.h           |    6 ------
 include/asm-powerpc/ide.h       |    3 ---
 include/linux/ide.h             |   27 ++++-----------------------
 8 files changed, 8 insertions(+), 55 deletions(-)

Index: b/drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c
+++ b/drivers/ide/ide-io.c
@@ -1468,12 +1468,8 @@ void ide_timer_expiry (unsigned long dat
 			 */
 			spin_unlock(&ide_lock);
 			hwif  = HWIF(drive);
-#if DISABLE_IRQ_NOSYNC
-			disable_irq_nosync(hwif->irq);
-#else
 			/* disable_irq_nosync ?? */
 			disable_irq(hwif->irq);
-#endif /* DISABLE_IRQ_NOSYNC */
 			/* local CPU only,
 			 * as if we were handling an interrupt */
 			local_irq_disable();
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -1038,8 +1038,7 @@ static void ide_disk_pre_reset(ide_drive
 	drive->special.all = 0;
 	drive->special.b.set_geometry = legacy;
 	drive->special.b.recalibrate  = legacy;
-	if (OK_TO_RESET_CONTROLLER)
-		drive->mult_count = 0;
+	drive->mult_count = 0;
 	if (!drive->keep_settings && !drive->using_dma)
 		drive->mult_req = 0;
 	if (drive->mult_req != drive->mult_count)
@@ -1124,7 +1123,6 @@ static ide_startstop_t do_reset1 (ide_dr
 	for (unit = 0; unit < MAX_DRIVES; ++unit)
 		pre_reset(&hwif->drives[unit]);
 
-#if OK_TO_RESET_CONTROLLER
 	if (!IDE_CONTROL_REG) {
 		spin_unlock_irqrestore(&ide_lock, flags);
 		return ide_stopped;
@@ -1161,11 +1159,8 @@ static ide_startstop_t do_reset1 (ide_dr
 	 * state when the disks are reset this way. At least, the Winbond
 	 * 553 documentation says that
 	 */
-	if (hwif->resetproc != NULL) {
+	if (hwif->resetproc)
 		hwif->resetproc(drive);
-	}
-	
-#endif	/* OK_TO_RESET_CONTROLLER */
 
 	spin_unlock_irqrestore(&ide_lock, flags);
 	return ide_started;
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -109,10 +109,10 @@ static void ide_disk_init_mult_count(ide
 #ifdef CONFIG_IDEDISK_MULTI_MODE
 		id->multsect = ((id->max_multsect/2) > 1) ? id->max_multsect : 0;
 		id->multsect_valid = id->multsect ? 1 : 0;
-		drive->mult_req = id->multsect_valid ? id->max_multsect : INITIAL_MULT_COUNT;
+		drive->mult_req = id->multsect_valid ? id->max_multsect : 0;
 		drive->special.b.set_multmode = drive->mult_req ? 1 : 0;
 #else	/* original, pre IDE-NFG, per request of AC */
-		drive->mult_req = INITIAL_MULT_COUNT;
+		drive->mult_req = 0;
 		if (drive->mult_req > id->max_multsect)
 			drive->mult_req = id->max_multsect;
 		if (drive->mult_req || ((id->multsect_valid & 1) && id->multsect))
Index: b/include/asm-cris/arch-v10/ide.h
===================================================================
--- a/include/asm-cris/arch-v10/ide.h
+++ b/include/asm-cris/arch-v10/ide.h
@@ -89,11 +89,6 @@ static inline void ide_init_default_hwif
 	}
 }
 
-/* some configuration options we don't need */
-
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #endif /* __KERNEL__ */
 
 #endif /* __ASMCRIS_IDE_H */
Index: b/include/asm-cris/arch-v32/ide.h
===================================================================
--- a/include/asm-cris/arch-v32/ide.h
+++ b/include/asm-cris/arch-v32/ide.h
@@ -48,11 +48,6 @@ static inline unsigned long ide_default_
 	return REG_TYPE_CONV(unsigned long, reg_ata_rw_ctrl2, ctrl2);
 }
 
-/* some configuration options we don't need */
-
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #define IDE_ARCH_ACK_INTR
 #define ide_ack_intr(hwif)	((hwif)->ack_intr(hwif))
 
Index: b/include/asm-frv/ide.h
===================================================================
--- a/include/asm-frv/ide.h
+++ b/include/asm-frv/ide.h
@@ -18,12 +18,6 @@
 #include <asm/io.h>
 #include <asm/irq.h>
 
-#undef SUPPORT_SLOW_DATA_PORTS
-#define SUPPORT_SLOW_DATA_PORTS 0
-
-#undef SUPPORT_VLB_SYNC
-#define SUPPORT_VLB_SYNC 0
-
 #ifndef MAX_HWIFS
 #define MAX_HWIFS 8
 #endif
Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -42,9 +42,6 @@ struct ide_machdep_calls {
 
 extern struct ide_machdep_calls ppc_ide_md;
 
-#undef	SUPPORT_SLOW_DATA_PORTS
-#define	SUPPORT_SLOW_DATA_PORTS	0
-
 #define IDE_ARCH_OBSOLETE_DEFAULTS
 
 static __inline__ int ide_default_irq(unsigned long base)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -27,25 +27,10 @@
 #include <asm/semaphore.h>
 #include <asm/mutex.h>
 
-/******************************************************************************
- * IDE driver configuration options (play with these as desired):
- *
- * REALLY_SLOW_IO can be defined in ide.c and ide-cd.c, if necessary
- */
-#define INITIAL_MULT_COUNT	0	/* off=0; on=2,4,8,16,32, etc.. */
-
-#ifndef SUPPORT_SLOW_DATA_PORTS		/* 1 to support slow data ports */
-#define SUPPORT_SLOW_DATA_PORTS	1	/* 0 to reduce kernel size */
-#endif
-#ifndef SUPPORT_VLB_SYNC		/* 1 to support weird 32-bit chips */
-#define SUPPORT_VLB_SYNC	1	/* 0 to reduce kernel size */
-#endif
-#ifndef OK_TO_RESET_CONTROLLER		/* 1 needed for good error recovery */
-#define OK_TO_RESET_CONTROLLER	1	/* 0 for use with AH2372A/B interface */
-#endif
-
-#ifndef DISABLE_IRQ_NOSYNC
-#define DISABLE_IRQ_NOSYNC	0
+#if defined(CRIS) || defined(FRV)
+# define SUPPORT_VLB_SYNC 0
+#else
+# define SUPPORT_VLB_SYNC 1
 #endif
 
 /*
@@ -55,10 +40,6 @@
  
 #define IDE_NO_IRQ		(-1)
 
-/*
- *  "No user-serviceable parts" beyond this point  :)
- *****************************************************************************/
-
 typedef unsigned char	byte;	/* used everywhere */
 
 /*
