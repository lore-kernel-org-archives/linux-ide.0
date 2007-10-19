From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add hwif->ack_intr hook
Date: Fri, 19 Oct 2007 23:20:05 +0200
Message-ID: <200710192320.06049.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.188]:21328 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S966738AbXJSVYr (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 19 Oct 2007 17:24:47 -0400
Received: by nf-out-0910.google.com with SMTP id g13so547669nfb
        for <linux-ide@vger.kernel.org>; Fri, 19 Oct 2007 14:24:46 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>, Roman Zippel <zippel@linux-m68k.org>, Geert Uytterhoeven <geert@linux-m68k.org>


* Add hwif->ack_intr hook and use it instead of hwif->hw.ack_intr.

* Add missing brackets to cris-v32 and powerpc ide_ack_intr() macros.

Cc: Roman Zippel <zippel@linux-m68k.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
Andrew has noticed that:

http://kernel.org/pub/linux/kernel/people/bart/pata-2.6/patches/ide-remove-write-only-hwif-hw.patch

broke m68k, this pre-patch should fix it (together with fixing cris-v32/mpc8xx).

 drivers/ide/ide.c               |    1 +
 drivers/ide/ppc/mpc8xx.c        |    4 ++--
 include/asm-cris/arch-v32/ide.h |    2 +-
 include/asm-m68k/ide.h          |    2 +-
 include/asm-powerpc/ide.h       |    2 +-
 include/linux/ide.h             |    2 ++
 6 files changed, 8 insertions(+), 5 deletions(-)

Index: b/drivers/ide/ide.c
===================================================================
--- a/drivers/ide/ide.c
+++ b/drivers/ide/ide.c
@@ -737,6 +737,7 @@ found:
 	hwif->fixup = fixup;
 	hwif->chipset = hw->chipset;
 	hwif->gendev.parent = hw->dev;
+	hwif->ack_intr = hw->ack_intr;
 
 	if (initializing == 0) {
 		u8 idx[4] = { index, 0xff, 0xff, 0xff };
Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -316,8 +316,8 @@ m8xx_ide_init_hwif_ports(hw_regs_t *hw, 
 
 	ide_hwifs[data_port].pio_mask = ATA_PIO4;
 	ide_hwifs[data_port].set_pio_mode = m8xx_ide_set_pio_mode;
+	ide_hwifs[data_port].ack_intr = (ide_ack_intr_t *)ide_interrupt_ack;
 
-	hw->ack_intr = (ide_ack_intr_t *) ide_interrupt_ack;
 	/* Enable Harddisk Interrupt,
 	 * and make it edge sensitive
 	 */
@@ -402,8 +402,8 @@ void m8xx_ide_init_hwif_ports (hw_regs_t
 
 	ide_hwifs[data_port].pio_mask = ATA_PIO4;
 	ide_hwifs[data_port].set_pio_mode = m8xx_ide_set_pio_mode;
+	ide_hwifs[data_port].ack_intr = (ide_ack_intr_t *)ide_interrupt_ack;
 
-	hw->ack_intr = (ide_ack_intr_t *) ide_interrupt_ack;
 	/* Enable Harddisk Interrupt,
 	 * and make it edge sensitive
 	 */
Index: b/include/asm-cris/arch-v32/ide.h
===================================================================
--- a/include/asm-cris/arch-v32/ide.h
+++ b/include/asm-cris/arch-v32/ide.h
@@ -54,7 +54,7 @@ static inline unsigned long ide_default_
 #define SUPPORT_VLB_SYNC 0
 
 #define IDE_ARCH_ACK_INTR
-#define ide_ack_intr(hwif)	(hwif)->hw.ack_intr(hwif)
+#define ide_ack_intr(hwif)	((hwif)->ack_intr(hwif))
 
 #endif /* __KERNEL__ */
 
Index: b/include/asm-m68k/ide.h
===================================================================
--- a/include/asm-m68k/ide.h
+++ b/include/asm-m68k/ide.h
@@ -137,7 +137,7 @@ ide_get_lock(irq_handler_t handler, void
 #endif /* CONFIG_BLK_DEV_FALCON_IDE */
 
 #define IDE_ARCH_ACK_INTR
-#define ide_ack_intr(hwif)	((hwif)->hw.ack_intr ? (hwif)->hw.ack_intr(hwif) : 1)
+#define ide_ack_intr(hwif)	((hwif)->ack_intr ? (hwif)->ack_intr(hwif) : 1)
 
 #endif /* __KERNEL__ */
 #endif /* _M68K_IDE_H */
Index: b/include/asm-powerpc/ide.h
===================================================================
--- a/include/asm-powerpc/ide.h
+++ b/include/asm-powerpc/ide.h
@@ -69,7 +69,7 @@ static __inline__ unsigned long ide_defa
 
 #ifdef CONFIG_BLK_DEV_MPC8xx_IDE
 #define IDE_ARCH_ACK_INTR  1
-#define ide_ack_intr(hwif) (hwif->hw.ack_intr ? hwif->hw.ack_intr(hwif) : 1)
+#define ide_ack_intr(hwif) ((hwif)->ack_intr ? (hwif)->ack_intr(hwif) : 1)
 #endif
 
 #endif /* __powerpc64__ */
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -683,6 +683,8 @@ typedef struct hwif_s {
 	struct pci_dev  *pci_dev;	/* for pci chipsets */
 	struct ide_pci_device_s	*cds;	/* chipset device struct */
 
+	ide_ack_intr_t *ack_intr;
+
 	void (*rw_disk)(ide_drive_t *, struct request *);
 
 #if 0
