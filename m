From: Marc Singer <elf@buici.com>
Subject: Implementing CONFIG_IDE_POLL
Date: Tue, 6 Apr 2004 20:42:40 -0700
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040407034240.GA31195@flea>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="ew6BAiZeqk4r7MaW"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from florence.buici.com ([206.124.142.26]:11912 "HELO
	florence.buici.com") by vger.kernel.org with SMTP id S264085AbUDGDmn
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 6 Apr 2004 23:42:43 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've taken a stab at implementing a polling mode for an IDE
implementation that lacks interrupts.  Yes, yes, I know, I know.
Changing the hardware *is* the right answer.  Well, that doesn't
appear to be happening before I need to ship some running code.  

So, I've made something that works.  It turns out not to be too
difficult nor invasive.  Essentially, I'm allowing the the hardware
initialization to pass IDE_NO_IRQ such that there is no IRQ probing
and no one attempts to enable or disable that interrupt.  Then there
is an ide_poll() function which is called at a couple of different
places.  It does what it can if the device is ready, or it sets a
timer if there is more to be done and it looks like it might be a long
wait.  This code is working on my target platform.  I can use a CF
card for the root filesystem.

I'm looking for some constructive criticism.  Overall, this
implementation was more complex that I would have liked.  Am I missing
anything important?  Is there a better way?

There is one part that is missing.  IDE_POLL is set true when the
ARCH_LPD7A40X architecture is defined.


--ew6BAiZeqk4r7MaW
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="patch-linux-2.6.4-lh7a40x-ms8-ide"

Index: arch/arm/mach-lh7a40x/ide-lpd7a40x.c
===================================================================
--- a/arch/arm/mach-lh7a40x/ide-lpd7a40x.c	(revision 0)
+++ b/arch/arm/mach-lh7a40x/ide-lpd7a40x.c	(revision 73)
@@ -0,0 +1,166 @@
+/* arch/arm/mach-lh7a40x/ide-lpd7a40x.c
+ *
+ *  Copyright (C) 2004 Logic Product Development
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  version 2 as published by the Free Software Foundation.
+ *
+ */
+
+
+#include <linux/config.h>
+#include <linux/ide.h>
+
+#include <asm/io.h>
+
+#define IOBARRIER_READ		readl (IOBARRIER_VIRT)
+
+static u8 lpd7a40x_ide_inb (unsigned long port)
+{
+	u16 v = (u16) readw (port & ~0x1);
+	IOBARRIER_READ;
+	if (port & 0x1)
+		v >>= 8;
+	return v & 0xff;
+}
+
+static u16 lpd7a40x_ide_inw (unsigned long port)
+{
+	u16 v = (u16) readw (port);
+	IOBARRIER_READ;
+	return v;
+}
+
+static void lpd7a40x_ide_insw (unsigned long port, void *addr, u32 count)
+{
+	while (count--) {
+		*((u16*) addr)++ = (u16) readw (port);
+		IOBARRIER_READ;
+	}
+}
+
+static u32 lpd7a40x_ide_inl (unsigned long port)
+{
+	u32 v = (u16) readw (port);
+	IOBARRIER_READ;
+	v |= (u16) readw (port + 2);
+	IOBARRIER_READ;
+
+	return v;
+}
+
+static void lpd7a40x_ide_insl (unsigned long port, void *addr, u32 count)
+{
+	while (count--) {
+		*((u16*) addr)++ = (u16) readw (port);
+		IOBARRIER_READ;
+		*((u16*) addr)++ = (u16) readw (port + 2);
+		IOBARRIER_READ;
+	}
+}
+
+/* lpd7a40x_ide_outb -- this function is complicated by the fact that
+ * the user wants to be able to do byte IO and the hardware cannot.
+ * In order to write the high byte, we need to write a short.  So, we
+ * read before writing in order to maintain the register values that
+ * shouldn't change.  This isn't a good idea for the data IO registers
+ * since reading from them will not return the current value.  We
+ * expect that this function handles the control register adequately.
+*/
+
+static void lpd7a40x_ide_outb (u8 valueUser, unsigned long port)
+{
+	/* Block writes to SELECT register.  Draconian, but the only
+	 * way to cope with this hardware configuration without
+	 * modifying the SELECT_DRIVE call in the ide driver. */
+	if ((port & 0xf) == 0x6)
+		return;
+
+	if (port & 0x1) {	/* Perform read before write.  Only
+				 * the COMMAND register needs
+				 * this.  */
+		u16 value = (u16) readw (port & ~0x1);
+		IOBARRIER_READ;
+		value = (value & 0x00ff) | (valueUser << 8);
+		writew (value, port & ~0x1);
+		IOBARRIER_READ;
+	}
+	else {			/* Allow low-byte writes which seem to
+				 * be OK. */
+		writeb (valueUser, port);
+		IOBARRIER_READ;
+	}
+}
+
+static void lpd7a40x_ide_outbsync (ide_drive_t *drive, u8 value, 
+				   unsigned long port)
+{
+	lpd7a40x_ide_outb (value, port);
+}
+
+static void lpd7a40x_ide_outw (u16 value, unsigned long port)
+{
+	writew (value, port);
+	IOBARRIER_READ;
+}
+
+static void lpd7a40x_ide_outsw (unsigned long port, void *addr, u32 count)
+{
+	while (count-- > 0) {
+		writew (*((u16*) addr)++, port);
+		IOBARRIER_READ;
+	}
+}
+
+static void lpd7a40x_ide_outl (u32 value, unsigned long port)
+{
+	writel (value, port);
+	IOBARRIER_READ;
+}
+
+static void lpd7a40x_ide_outsl (unsigned long port, void *addr, u32 count)
+{
+	while (count-- > 0) {
+		writel (*((u32*) addr)++, port);
+		IOBARRIER_READ;
+	}
+}
+
+void lpd7a40x_SELECT_DRIVE (ide_drive_t *drive)
+{
+	unsigned jifStart = jiffies;
+#define WAIT_TIME	(30*HZ/1000)
+
+	/* Check for readiness. */
+	while ((HWIF(drive)->INB(IDE_STATUS_REG) & 0x40) == 0)
+		if (jifStart <= jiffies + WAIT_TIME)
+			return;
+
+	/* Only allow one drive.  
+	   For more information, see Documentation/arm/Sharp-LH/ */
+	if (drive->select.all & (1<<4))
+		return;
+
+	/* OUTW so that the IDLE_IMMEDIATE (and not NOP) command is sent. */
+	HWIF(drive)->OUTW(drive->select.all | 0xe100, IDE_SELECT_REG);
+}
+
+void lpd7a40x_hwif_ioops (ide_hwif_t *hwif)
+{
+	hwif->mmio      = 2;	/* Just for show */
+	hwif->irq	= IDE_NO_IRQ;	/* Stop this probing */
+
+	hwif->OUTB	= lpd7a40x_ide_outb;
+	hwif->OUTBSYNC	= lpd7a40x_ide_outbsync;
+	hwif->OUTW	= lpd7a40x_ide_outw;
+	hwif->OUTL	= lpd7a40x_ide_outl;
+	hwif->OUTSW	= lpd7a40x_ide_outsw;
+	hwif->OUTSL	= lpd7a40x_ide_outsl;
+	hwif->INB	= lpd7a40x_ide_inb;
+	hwif->INW	= lpd7a40x_ide_inw;
+	hwif->INL	= lpd7a40x_ide_inl;
+	hwif->INSW	= lpd7a40x_ide_insw;
+	hwif->INSL	= lpd7a40x_ide_insl;
+	hwif->selectproc = lpd7a40x_SELECT_DRIVE;
+}
Index: include/asm-arm/arch-lh7a40x/ide.h
===================================================================
--- a/include/asm-arm/arch-lh7a40x/ide.h	(revision 0)
+++ b/include/asm-arm/arch-lh7a40x/ide.h	(revision 73)
@@ -0,0 +1,66 @@
+/* include/asm-arm/arch-lh7a40x/ide.h
+ *
+ *  Copyright (C) 2004 Logic Product Development
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  version 2 as published by the Free Software Foundation.
+ *
+ */
+
+/*  This implementation of ide.h only applies to the LPD CardEngines.
+ *  The KEV, if ever implemented, will be much simpler.
+ */
+
+#ifndef __ASM_ARCH_IDE_H
+#define __ASM_ARCH_IDE_H
+
+#include <linux/config.h>
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/arch/registers.h>
+
+#define IDE_REG_LINE	(1<<12)	/* A12 drives !REG  */
+#define IDE_ALT_LINE	(1<<11)	/* Unused A11 allows non-overlapping regions */
+#define IDE_CONTROLREG_OFFSET	(0xe)
+
+void lpd7a40x_hwif_ioops (struct hwif_s* hwif);
+
+static __inline__ void ide_init_hwif_ports (hw_regs_t *hw, int data_port, 
+					    int ctrl_port, int *irq)
+{
+	ide_ioreg_t reg;
+        int i;
+        int regincr = 1;
+
+        memset (hw, 0, sizeof (*hw));
+
+        reg = (ide_ioreg_t) data_port;
+
+        for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+                hw->io_ports[i] = reg;
+                reg += regincr;
+        }
+
+        hw->io_ports[IDE_CONTROL_OFFSET] = (ide_ioreg_t) ctrl_port;
+
+        if (irq)
+                *irq = IDE_NO_IRQ;
+}
+
+static __inline__  void ide_init_default_hwifs (void)
+{
+	hw_regs_t hw;
+	struct hwif_s* hwif;
+
+	ide_init_hwif_ports (&hw, 
+			     CF_VIRT + IDE_REG_LINE,
+			     CF_VIRT + IDE_REG_LINE + IDE_ALT_LINE
+			     + IDE_CONTROLREG_OFFSET,
+			     NULL);
+
+	ide_register_hw (&hw, &hwif);
+	lpd7a40x_hwif_ioops (hwif); /* Override IO routines */
+}
+
+#endif
Index: include/linux/ide.h
===================================================================
--- a/include/linux/ide.h	(.../2.6.4)	(revision 73)
+++ b/include/linux/ide.h	(.../lh7a40x-2.6.4-ms8)	(revision 73)
@@ -1034,6 +1034,10 @@
 	int pio_clock;
 
 	unsigned char cmd_buf[4];
+
+#ifdef CONFIG_IDE_POLL
+	struct timer_list timer_poll; /* Timer for IRQ-less polling */
+#endif
 } ide_hwgroup_t;
 
 /* structure attached to the request for IDE_TASK_CMDS */
@@ -1703,4 +1707,9 @@
 
 extern struct bus_type ide_bus_type;
 
+#ifdef CONFIG_IDE_POLL
+extern void ide_poll (ide_hwgroup_t* hwif);
+extern void ide_poll_timer (unsigned long data);
+#endif
+
 #endif /* _IDE_H */
Index: drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig	(.../2.6.4)	(revision 73)
+++ b/drivers/ide/Kconfig	(.../lh7a40x-2.6.4-ms8)	(revision 73)
@@ -294,6 +294,9 @@
 
 	  It is safe to say Y to this question, in most cases.
 
+config IDE_POLL
+	bool
+
 comment "IDE chipset support/bugfixes"
 
 config IDE_GENERIC
Index: drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c	(.../2.6.4)	(revision 73)
+++ b/drivers/ide/ide-probe.c	(.../lh7a40x-2.6.4-ms8)	(revision 73)
@@ -396,7 +396,7 @@
 		udelay(5);
 		irq = probe_irq_off(cookie);
 		if (!hwif->irq) {
-			if (irq > 0) {
+			if (irq != 0) {
 				hwif->irq = irq;
 			} else {
 				/* Mmmm.. multiple IRQs..
@@ -729,7 +729,7 @@
 	 * we'll install our IRQ driver much later...
 	 */
 	irqd = hwif->irq;
-	if (irqd)
+	if (irqd && irqd != IDE_NO_IRQ)
 		disable_irq(hwif->irq);
 
 	local_irq_set(flags);
@@ -794,7 +794,7 @@
 	 * Use cached IRQ number. It might be (and is...) changed by probe
 	 * code above
 	 */
-	if (irqd)
+	if (irqd && irqd != IDE_NO_IRQ)
 		enable_irq(irqd);
 
 	if (!hwif->present) {
@@ -1045,12 +1045,18 @@
 		init_timer(&hwgroup->timer);
 		hwgroup->timer.function = &ide_timer_expiry;
 		hwgroup->timer.data = (unsigned long) hwgroup;
+
+#ifdef CONFIG_IDE_POLL
+		init_timer (&hwgroup->timer_poll);
+		hwgroup->timer_poll.function = &ide_poll_timer;
+		hwgroup->timer_poll.data = (unsigned long) hwgroup;
+#endif
 	}
 
 	/*
 	 * Allocate the irq, if not already obtained for another hwif
 	 */
-	if (!match || match->irq != hwif->irq) {
+	if ((!match || match->irq != hwif->irq) && hwif->irq != IDE_NO_IRQ) {
 		int sa = SA_INTERRUPT;
 #if defined(__mc68000__) || defined(CONFIG_APUS)
 		sa = SA_SHIRQ;
Index: drivers/ide/ide-io.c
===================================================================
--- a/drivers/ide/ide-io.c	(.../2.6.4)	(revision 73)
+++ b/drivers/ide/ide-io.c	(.../lh7a40x-2.6.4-ms8)	(revision 73)
@@ -54,6 +54,17 @@
 #include <asm/io.h>
 #include <asm/bitops.h>
 
+
+static inline void ide_enable_irq (ide_hwgroup_t *hwgroup)
+{
+#ifdef CONFIG_IDE_POLL
+	if (hwgroup->hwif->irq == IDE_NO_IRQ)
+		ide_poll (hwgroup);
+	else
+#endif
+		enable_irq (hwgroup->hwif->irq);
+}
+
 /**
  *	ide_end_request		-	complete an IDE I/O
  *	@drive: IDE device for the I/O
@@ -921,7 +932,7 @@
 		startstop = start_request(drive, rq);
 		spin_lock_irq(&ide_lock);
 		if (hwif->irq != masked_irq)
-			enable_irq(hwif->irq);
+			ide_enable_irq (hwgroup);
 		if (startstop == ide_released)
 			goto queue_next;
 		if (startstop == ide_stopped)
@@ -1081,7 +1092,7 @@
 			}
 			drive->service_time = jiffies - drive->service_start;
 			spin_lock_irq(&ide_lock);
-			enable_irq(hwif->irq);
+			ide_enable_irq (hwgroup);
 			if (startstop == ide_stopped)
 				hwgroup->busy = 0;
 		}
@@ -1398,3 +1409,46 @@
 }
 
 EXPORT_SYMBOL(ide_do_drive_cmd);
+
+#ifdef CONFIG_IDE_POLL
+
+#define POLL_TIME	(10*HZ/1000) /* one jiffy...or less */
+
+void ide_poll_timer (unsigned long data)
+{
+	ide_hwgroup_t* hwgroup = (ide_hwgroup_t*) data;
+
+	del_timer (&hwgroup->timer_poll);
+	ide_poll (hwgroup);
+}
+
+void ide_poll (ide_hwgroup_t* hwgroup)
+{
+	ide_drive_t* drive = hwgroup->drive;
+	struct pt_regs regs;
+	memset (&regs, 0, sizeof (regs));
+	do {
+#ifdef POLL_TIME
+		int count = 16;	/* This ought not be very high */
+#endif
+		while ((hwgroup->hwif->INB (IDE_STATUS_REG) & BUSY_STAT) 
+#ifdef POLL_TIME
+		       && --count
+#endif
+			)
+			;
+#ifdef POLL_TIME
+		if (count == 0) { /* Schedule a wake-up call */
+			hwgroup->timer_poll.expires = jiffies + POLL_TIME;
+			add_timer (&hwgroup->timer_poll);
+			return;
+		}
+#endif
+	} while (ide_intr (hwgroup->hwif->irq, hwgroup, &regs) == IRQ_HANDLED);
+}
+
+EXPORT_SYMBOL(ide_poll);
+
+#endif
+
+
Index: drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c	(.../2.6.4)	(revision 73)
+++ b/drivers/ide/ide-iops.c	(.../lh7a40x-2.6.4-ms8)	(revision 73)
@@ -1016,6 +1016,11 @@
 	*/
 	ndelay(400);
 	spin_unlock_irqrestore(&ide_lock, flags);
+
+#if defined (CONFIG_IDE_POLL)
+	if (hwif->irq == IDE_NO_IRQ)
+		ide_poll (hwgroup);
+#endif
 }
 
 EXPORT_SYMBOL(ide_execute_command);
Index: drivers/ide/ide-disk.c
===================================================================
--- a/drivers/ide/ide-disk.c	(.../2.6.4)	(revision 73)
+++ b/drivers/ide/ide-disk.c	(.../lh7a40x-2.6.4-ms8)	(revision 73)
@@ -518,6 +518,12 @@
 			taskfile_output_data(drive, to, SECTOR_WORDS);
 			ide_unmap_buffer(rq, to, &flags);
 		}
+
+#if defined (CONFIG_IDE_POLL)
+		if (hwif->irq == IDE_NO_IRQ)
+			ide_poll (HWGROUP (drive));
+#endif
+
 		return ide_started;
 	}
 	blk_dump_rq_flags(rq, "__ide_do_rw_disk - bad command");

--ew6BAiZeqk4r7MaW--
