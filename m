From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Sun, 15 Feb 2004 15:40:56 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402151540.56377.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:39657 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264604AbUBOOf2
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 15 Feb 2004 09:35:28 -0500
In-Reply-To: <m2y8r4naht.wl%ysato@users.sourceforge.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: linux-ide@vger.kernel.org

On Sunday 15 of February 2004 07:05, Yoshinori Sato wrote:
> Hello.
> I develop H8/300 support of linux kernel.
>
> I made a patch to use IDE driver with a H8/300 target.
> I want to do merge to source if possible.
>
> How will about it?

Hi,

+ *  reference schematic is http://www.linet.gr.jp/mituiwa/h8/h8osv3/hddprog/hdd.png

this link is dead

+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/blkdev.h>

why do you include mm.h and blkdev.h?

+static void _outsw(unsigned long addr, void *buf, u32 len)
+{
+	unsigned volatile short *ap = (unsigned volatile short *)addr;
+	unsigned short *bp = (unsigned short *)buf;
+	unsigned short d;
+	while(len--) {
+		d = *bp++;
+		*ap = (d << 8) | (d >> 8);
+	}
+}
+
+static void _insw(unsigned long addr, void *buf, u32 len)
+{
+	unsigned volatile short *ap = (unsigned volatile short *)addr;
+	unsigned short *bp = (unsigned short *)buf;
+	unsigned short d;
+	while(len--) {
+		d = *ap;
+		*bp++ = (d << 8) | (d >> 8);
+	}
+}

why you don't use outsw() and insw() from include/asm-h8300/io.h?


+	ide_setup_ports(&hw, IDE_BASE, (int *)offsets,
+                             IDE_CTRL, 0, NULL,IDE_IRQ);

ide_setup_ports() is deprecated, please do not use it.

+		hwif->mmio  = 0;

Your driver is doing MMIO, it should request and release resources itself
and set hwif->mmio to 2.

+void __init h8300_ide_print_resource(char *name, hw_regs_t *hw)
+{
+	printk("%s at 0x%08x-0x%08x,0x%08x on irq %d", name,
+		(unsigned int)hw->io_ports[IDE_DATA_OFFSET],
+		(unsigned int)hw->io_ports[IDE_DATA_OFFSET]+15,
+		(unsigned int)hw->io_ports[IDE_CONTROL_OFFSET],
+		hw->irq);
+}

Is this necessary (this is a reason for extra #ifdefs in ide-probe.c)?
Can't we do what m68k is doing (print only address and IRQ) for now?

Both drivers use same IO ops so they can be moved to some include file
or both drivers can be merged (preferred solution) - they are for different
boards and can't work together (plus MAX_HWIFS is defined to 1 for h8300).

Here is patch (not tested) addressing some of these issues...

Thanks,
--bart

 linux-2.6.3-rc2-bk4-root/drivers/ide/h8300/aki3068_ide.c |   96 ++-------------
 linux-2.6.3-rc2-bk4-root/drivers/ide/h8300/h8_ide_iops.h |   72 +++++++++++
 linux-2.6.3-rc2-bk4-root/drivers/ide/h8300/h8max_ide.c   |   94 ++------------
 3 files changed, 109 insertions(+), 153 deletions(-)

diff -puN drivers/ide/h8300/aki3068_ide.c~h8300-ide-fixes drivers/ide/h8300/aki3068_ide.c
--- linux-2.6.3-rc2-bk4/drivers/ide/h8300/aki3068_ide.c~h8300-ide-fixes	2004-02-15 14:14:20.429869920 +0100
+++ linux-2.6.3-rc2-bk4-root/drivers/ide/h8300/aki3068_ide.c	2004-02-15 15:00:29.804860928 +0100
@@ -2,7 +2,6 @@
 /*
  *  linux/drivers/ide/h8300/aki3068_ide.c
  *  AE-3068/AE-3069 IDE I/F support
- *  reference schematic is http://www.linet.gr.jp/mituiwa/h8/h8osv3/hddprog/hdd.png
  *
  *  Copyright (C) 2003 Yoshinori Sato <ysato@users.sourceforge.jp>
  *
@@ -25,6 +24,8 @@
 #include <asm/irq.h>
 #include <asm/regs306x.h>
 
+#include "h8_ide_iops.h"
+
 /* IDE I/F configuration */
 #define IDE_BASE CONFIG_H8300_IDE_BASE
 #define IDE_CTRL CONFIG_H8300_IDE_ALT
@@ -39,67 +40,16 @@
 #define IDE_SELECT	0x0C
 #define IDE_STATUS	0x0E
 
-const static int offsets[IDE_NR_PORTS] = {
-    IDE_DATA, IDE_ERROR,  IDE_NSECTOR, IDE_SECTOR, IDE_LCYL,
-    IDE_HCYL, IDE_SELECT, IDE_STATUS,          -1,       -1
-};
-
-static void _outb(u8 d, unsigned long a)
-{
-	*(unsigned short *)a = (d & 0xff);
-}
-
-static void _outbsync(ide_drive_t *drive, u8 d, unsigned long a)
-{
-	*(unsigned short *)a = (d & 0xff);
-}
-
-static u8 _inb(unsigned long a)
+static void h8300_ide_ports(hw_regs_t *hw, unsigned long ioaddr)
 {
-	return *(unsigned short *)a;
-}
-
-static void _outw(u16 d, unsigned long a)
-{
-	*(unsigned short *)a = (d << 8) | (d >> 8);
-}
-
-static u16 _inw(unsigned long a)
-{
-	unsigned short d;
-	d = *(unsigned short *)a;
-	return (d << 8) | (d >> 8);
-}
-
-static void _outl(u32 d, unsigned long a)
-{
-}
-
-static u32 _inl(unsigned long a)
-{
-	return 0xffffffffUL;
-}
-
-static void _outsw(unsigned long addr, void *buf, u32 len)
-{
-	unsigned volatile short *ap = (unsigned volatile short *)addr;
-	unsigned short *bp = (unsigned short *)buf;
-	unsigned short d;
-	while(len--) {
-		d = *bp++;
-		*ap = (d << 8) | (d >> 8);
-	}
-}
-
-static void _insw(unsigned long addr, void *buf, u32 len)
-{
-	unsigned volatile short *ap = (unsigned volatile short *)addr;
-	unsigned short *bp = (unsigned short *)buf;
-	unsigned short d;
-	while(len--) {
-		d = *ap;
-		*bp++ = (d << 8) | (d >> 8);
-	}
+	hw->io_ports[IDE_DATA_OFFSET]	 = ioaddr + IDE_DATA;
+	hw->io_ports[IDE_ERROR_OFFSET]	 = ioaddr + IDE_ERROR;
+	hw->io_ports[IDE_NSECTOR_OFFSET] = ioaddr + IDE_NSECTOR;
+	hw->io_ports[IDE_SECTOR_OFFSET]	 = ioaddr + IDE_SECTOR;
+	hw->io_ports[IDE_LCYL_OFFSET]	 = ioaddr + IDE_LCYL;
+	hw->io_ports[IDE_HCYL_OFFSET]	 = ioaddr + IDE_HCYL;
+	hw->io_ports[IDE_SELECT_OFFSET]	 = ioaddr + IDE_SELECT;
+	hw->io_ports[IDE_STATUS_OFFSET]	 = ioaddr + IDE_STATUS;
 }
 
 void __init h8300_ide_init(void)
@@ -110,23 +60,15 @@ void __init h8300_ide_init(void)
 	volatile unsigned char *cscr = (volatile unsigned char *)CSCR;
 	*abwcr &= ~((1 << ((IDE_BASE >> 21) & 7)) | (1 << ((IDE_CTRL >> 21) & 7)));
 	*cscr  |= (1 << ((IDE_BASE >> 21) & 7)) | (1 << ((IDE_CTRL >> 21) & 7)) | 0x0f;
+
 	memset(&hw,0,sizeof(hw));
-	ide_setup_ports(&hw, IDE_BASE, (int *)offsets,
-                             IDE_CTRL, 0, NULL,IDE_IRQ);
-	if (ide_register_hw(&hw, &hwif) != -1) {
-		hwif->mmio  = 0;
-		hwif->OUTB  = _outb;
-		hwif->OUTBSYNC = _outbsync;
-		hwif->OUTW  = _outw;
-		hwif->OUTL  = _outl;
-		hwif->OUTSW = _outsw;
-		hwif->OUTSL = NULL;
-		hwif->INB   = _inb;
-		hwif->INW   = _inw;
-		hwif->INL   = _inl;
-		hwif->INSW  = _insw;
-		hwif->INSL  = NULL;
-	}
+
+	h8300_ide_ports(&hw, IDE_BASE);
+	hw.io_ports[IDE_CONTROL_OFFSET] = IDE_CTRL;
+	hw.irq = IDE_IRQ;
+
+	if (ide_register_hw(&hw, &hwif) != -1)
+		h8300_hwif_iops(hwif);
 }
 
 void __init h8300_ide_print_resource(char *name, hw_regs_t *hw)
diff -puN drivers/ide/h8300/h8max_ide.c~h8300-ide-fixes drivers/ide/h8300/h8max_ide.c
--- linux-2.6.3-rc2-bk4/drivers/ide/h8300/h8max_ide.c~h8300-ide-fixes	2004-02-15 14:14:23.858348712 +0100
+++ linux-2.6.3-rc2-bk4-root/drivers/ide/h8300/h8max_ide.c	2004-02-15 14:59:50.338860672 +0100
@@ -23,6 +23,8 @@
 #include <linux/init.h>
 #include <asm/irq.h>
 
+#include "h8_ide_iops.h"
+
 /* IDE I/F configuration */
 #define IDE_BASE 0x200000
 #define IDE_CTRL 0x60000c
@@ -37,67 +39,16 @@
 #define IDE_SELECT	0x0C
 #define IDE_STATUS	0x0E
 
-const static int offsets[IDE_NR_PORTS] = {
-    IDE_DATA, IDE_ERROR,  IDE_NSECTOR, IDE_SECTOR, IDE_LCYL,
-    IDE_HCYL, IDE_SELECT, IDE_STATUS,          -1,       -1
-};
-
-static void h8max_outb(u8 d, unsigned long a)
-{
-	*(unsigned short *)a = (d & 0xff);
-}
-
-static void h8max_outbsync(ide_drive_t *drive, u8 d, unsigned long a)
-{
-	*(unsigned short *)a = (d & 0xff);
-}
-
-static u8 h8max_inb(unsigned long a)
-{
-	return (*(unsigned short *)a) & 0xff;
-}
-
-static void h8max_outw(u16 d, unsigned long a)
-{
-	*(unsigned short *)a = ((d << 8) & 0xff00) | ((d >> 8) & 0x00ff);
-}
-
-static u16 h8max_inw(unsigned long a)
+static void h8300_ide_ports(hw_regs_t *hw, unsigned long ioaddr)
 {
-	unsigned short d;
-	d = *(unsigned short *)a;
-	return ((d << 8) & 0xff00) | ((d >> 8) & 0x00ff);
-}
-
-static void h8max_outl(u32 d, unsigned long a)
-{
-}
-
-static u32 h8max_inl(unsigned long a)
-{
-	return 0xffffffffUL;
-}
-
-static void h8max_outsw(unsigned long addr, void *buf, u32 len)
-{
-	unsigned volatile short *ap = (unsigned volatile short *)addr;
-	unsigned short *bp = (unsigned short *)buf;
-	unsigned short d;
-	while(len--) {
-		d = *bp++;
-		*ap = (d >> 8) | (d << 8);
-	}
-}
-
-static void h8max_insw(unsigned long addr, void *buf, u32 len)
-{
-	unsigned volatile short *ap = (unsigned volatile short *)addr;
-	unsigned short *bp = (unsigned short *)buf;
-	unsigned short d;
-	while(len--) {
-		d = *ap;
-		*bp++ = (d >> 8) | (d << 8);
-	}
+	hw->io_ports[IDE_DATA_OFFSET]	 = ioaddr + IDE_DATA;
+	hw->io_ports[IDE_ERROR_OFFSET]	 = ioaddr + IDE_ERROR;
+	hw->io_ports[IDE_NSECTOR_OFFSET] = ioaddr + IDE_NSECTOR;
+	hw->io_ports[IDE_SECTOR_OFFSET]	 = ioaddr + IDE_SECTOR;
+	hw->io_ports[IDE_LCYL_OFFSET]	 = ioaddr + IDE_LCYL;
+	hw->io_ports[IDE_HCYL_OFFSET]	 = ioaddr + IDE_HCYL;
+	hw->io_ports[IDE_SELECT_OFFSET]	 = ioaddr + IDE_SELECT;
+	hw->io_ports[IDE_STATUS_OFFSET]	 = ioaddr + IDE_STATUS;
 }
 
 void __init h8300_ide_init(void)
@@ -106,22 +57,13 @@ void __init h8300_ide_init(void)
 	ide_hwif_t *hwif;
 
 	memset(&hw,0,sizeof(hw));
-	ide_setup_ports(&hw, IDE_BASE, (int *)offsets,
-                             IDE_CTRL, 0, NULL,IDE_IRQ);
-	if (ide_register_hw(&hw, &hwif) != -1) {
-		hwif->mmio  = 0;
-		hwif->OUTB  = h8max_outb;
-		hwif->OUTBSYNC = h8max_outbsync;
-		hwif->OUTW  = h8max_outw;
-		hwif->OUTL  = h8max_outl;
-		hwif->OUTSW = h8max_outsw;
-		hwif->OUTSL = NULL;
-		hwif->INB   = h8max_inb;
-		hwif->INW   = h8max_inw;
-		hwif->INL   = h8max_inl;
-		hwif->INSW  = h8max_insw;
-		hwif->INSL  = NULL;
-	}
+
+	h8300_ide_ports(&hw, IDE_BASE);
+	hw.io_ports[IDE_CONTROL_OFFSET] = IDE_CTRL;
+	hw.irq = IDE_IRQ;
+
+	if (ide_register_hw(&hw, &hwif) != -1)
+		h8300_hwif_iops(hwif);
 }
 
 void __init h8300_ide_print_resource(char *name, hw_regs_t *hw)
diff -puN /dev/null drivers/ide/h8300/h8_ide_iops.h
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.3-rc2-bk4-root/drivers/ide/h8300/h8_ide_iops.h	2004-02-15 14:59:58.588606520 +0100
@@ -0,0 +1,72 @@
+static void __ide_outb(u8 d, unsigned long a)
+{
+	*(unsigned short *)a = d;
+}
+
+static void __ide_outbsync(ide_drive_t *drive, u8 d, unsigned long a)
+{
+	*(unsigned short *)a = d;
+}
+
+static u8 __ide_inb(unsigned long a)
+{
+	return *(unsigned short *)a;
+}
+
+static void __ide_outw(u16 d, unsigned long a)
+{
+	*(unsigned short *)a = (d << 8) | (d >> 8);
+}
+
+static u16 __ide_inw(unsigned long a)
+{
+	unsigned short d;
+	d = *(unsigned short *)a;
+	return (d << 8) | (d >> 8);
+}
+
+static void __ide_outl(u32 d, unsigned long a)
+{
+}
+
+static u32 __ide_inl(unsigned long a)
+{
+	return 0xffffffffUL;
+}
+
+static void __ide_outsw(unsigned long addr, void *buf, u32 len)
+{
+	unsigned volatile short *ap = (unsigned volatile short *)addr;
+	unsigned short *bp = (unsigned short *)buf;
+	unsigned short d;
+	while(len--) {
+		d = *bp++;
+		*ap = (d << 8) | (d >> 8);
+	}
+}
+
+static void __ide_insw(unsigned long addr, void *buf, u32 len)
+{
+	unsigned volatile short *ap = (unsigned volatile short *)addr;
+	unsigned short *bp = (unsigned short *)buf;
+	unsigned short d;
+	while(len--) {
+		d = *ap;
+		*bp++ = (d << 8) | (d >> 8);
+	}
+}
+
+static void h8300_hwif_iops(ide_hwif_t *hwif)
+{
+	hwif->OUTB 	= __ide_outb;
+	hwif->OUTBSYNC	= __ide_outbsync;
+	hwif->OUTW	= __ide_outw;
+	hwif->OUTL	= __ide_outl;
+	hwif->OUTSW	= __ide_outsw;
+	hwif->OUTSL	= NULL;
+	hwif->INB	= __ide_inb;
+	hwif->INW	= __ide_inw;
+	hwif->INL	= __ide_inl;
+	hwif->INSW	= __ide_insw;
+	hwif->INSL	= NULL;
+}

_

