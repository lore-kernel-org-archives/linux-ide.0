From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: H8/300 target support patch
Date: Fri, 20 Feb 2004 16:25:42 +0100
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200402201625.42842.bzolnier@elka.pw.edu.pl>
References: <m2y8r4naht.wl%ysato@users.sourceforge.jp> <200402191734.49496.bzolnier@elka.pw.edu.pl> <m2k72i2avr.wl%ysato@users.sourceforge.jp>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:30366 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S261282AbUBTPUJ
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 20 Feb 2004 10:20:09 -0500
In-Reply-To: <m2k72i2avr.wl%ysato@users.sourceforge.jp>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-ide@vger.kernel.org

On Friday 20 of February 2004 13:28, Yoshinori Sato wrote:
> At Thu, 19 Feb 2004 17:34:49 +0100,
>
> Bartlomiej Zolnierkiewicz wrote:
> > Hi,
> >
> > Can you send updated patch?
> > I am lost in incremental changes. :-)
> >
> > Thanks.
>
> Difference with linux-2.6.3.

Hi,

Your patch lacks Kconfig entries for CONFIG_H8300_IDE_{BASE,ALT,IRQNO}
and they are not present in kernel 2.6.3?

Are you aware that you can't build kernel which will support both controllers?
Not an issue if you can't build kernel which supports both this boards. :-)

I cleaned up patch a bit, changelog:
- h8max_ide.c and aki3068_ide.c merged into ide-h8300.c
- added #if !defined(__H8300H__) to ide-proc.c
  (only place where ->OUTL is used, ->INL is unused in generic IDE code)
- __ide_outl() and __ide_inl() removed 
- redundant includes removed 
- init driver through initcall (so no need to make changes in ide.c)

Not tested et all, I don't know whether it compiles. :-)

 linux-2.6.3-root/drivers/ide/Makefile          |    5 
 linux-2.6.3-root/drivers/ide/h8300/ide-h8300.c |  139 +++++++++++++++++++++++++
 linux-2.6.3-root/drivers/ide/ide-probe.c       |    5 
 linux-2.6.3-root/drivers/ide/ide-proc.c        |    5 
 4 files changed, 149 insertions(+), 5 deletions(-)

diff -puN /dev/null drivers/ide/h8300/ide-h8300.c
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.3-root/drivers/ide/h8300/ide-h8300.c	2004-02-20 16:01:08.884254448 +0100
@@ -0,0 +1,139 @@
+/****************************************************************************/
+/*
+ *  linux/drivers/ide/ide-h8300.c
+ *  H8MAX and aki3068net IDE Interfaces support
+ *
+ *  Copyright (C) 2003 Yoshinori Sato <ysato@users.sourceforge.jp>
+ *
+ *  This file is subject to the terms and conditions of the GNU General Public
+ *  License.  See the file COPYING in the main directory of this archive for
+ *  more details.
+ *
+ */
+/****************************************************************************/
+
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/ide.h>
+#include <linux/interrupt.h>
+#include <asm/irq.h>
+#include <asm/io.h>
+#include <asm/regs306x.h>
+
+/* IDE I/F configuration */
+
+#ifdef CONFIG_H8300H_H8MAX
+#define IDE_BASE 0x200000
+#define IDE_CTRL 0x60000c
+#define IDE_IRQ  EXT_IRQ5
+#endif
+
+#ifdef CONFIG_H8300H_AKI3068NET
+#define IDE_BASE CONFIG_H8300_IDE_BASE
+#define IDE_CTRL CONFIG_H8300_IDE_ALT
+#define IDE_IRQ  (EXT_IRQ0 + CONFIG_H8300_IDE_IRQNO)
+#endif
+
+#define IDE_DATA	0x00
+#define IDE_ERROR	0x02
+#define IDE_NSECTOR	0x04
+#define IDE_SECTOR	0x06
+#define IDE_LCYL	0x08
+#define IDE_HCYL	0x0A
+#define IDE_SELECT	0x0C
+#define IDE_STATUS	0x0E
+
+static void __init h8300_ide_ports(hw_regs_t *hw, unsigned long ioaddr)
+{
+	hw->io_ports[IDE_DATA_OFFSET]	 = ioaddr + IDE_DATA;
+	hw->io_ports[IDE_ERROR_OFFSET]	 = ioaddr + IDE_ERROR;
+	hw->io_ports[IDE_NSECTOR_OFFSET] = ioaddr + IDE_NSECTOR;
+	hw->io_ports[IDE_SECTOR_OFFSET]	 = ioaddr + IDE_SECTOR;
+	hw->io_ports[IDE_LCYL_OFFSET]	 = ioaddr + IDE_LCYL;
+	hw->io_ports[IDE_HCYL_OFFSET]	 = ioaddr + IDE_HCYL;
+	hw->io_ports[IDE_SELECT_OFFSET]	 = ioaddr + IDE_SELECT;
+	hw->io_ports[IDE_STATUS_OFFSET]	 = ioaddr + IDE_STATUS;
+}
+
+/* H8/300 IDE I/F I/O operations */
+
+static void __ide_outb(u8 d, unsigned long a)
+{
+	outb(d,a);
+}
+
+static void __ide_outbsync(ide_drive_t *drive, u8 d, unsigned long a)
+{
+	outb(d,a);
+}
+
+static u8 __ide_inb(unsigned long a)
+{
+	return inb(a);
+}
+
+static void __ide_outw(u16 d, unsigned long a)
+{
+	return outw(d,a);
+}
+
+static u16 __ide_inw(unsigned long a)
+{
+	return inw(a);
+}
+
+static void __ide_outsw(unsigned long addr, void *buf, u32 len)
+{
+	unsigned short *bp = (unsigned short *)buf;
+	while(len--)
+		outw(*bp++,addr);
+}
+
+static void __ide_insw(unsigned long addr, void *buf, u32 len)
+{
+	unsigned short *bp = (unsigned short *)buf;
+	while(len--)
+		*bp++ = inw(addr);
+}
+
+static void __init h8300_hwif_iops(ide_hwif_t *hwif)
+{
+	hwif->OUTB 	= __ide_outb;
+	hwif->OUTBSYNC	= __ide_outbsync;
+	hwif->OUTW	= __ide_outw;
+	hwif->OUTL	= NULL;
+	hwif->OUTSW	= __ide_outsw;
+	hwif->OUTSL	= NULL;
+	hwif->INB	= __ide_inb;
+	hwif->INW	= __ide_inw;
+	hwif->INL	= NULL;
+	hwif->INSW	= __ide_insw;
+	hwif->INSL	= NULL;
+}
+
+static int __init h8300_ide_init(void)
+{
+	hw_regs_t hw;
+	ide_hwif_t *hwif;
+
+#ifdef CONFIG_H8300H_AKI3068NET
+	volatile unsigned char *abwcr = (volatile unsigned char *)ABWCR;
+	volatile unsigned char *cscr = (volatile unsigned char *)CSCR;
+	*abwcr &= ~((1 << ((IDE_BASE >> 21) & 7)) | (1 << ((IDE_CTRL >> 21) & 7)));
+	*cscr  |= (1 << ((IDE_BASE >> 21) & 7)) | (1 << ((IDE_CTRL >> 21) & 7)) | 0x0f;
+#endif
+	memset(&hw, 0, sizeof(hw));
+
+	h8300_ide_ports(&hw, IDE_BASE);
+	hw.io_ports[IDE_CONTROL_OFFSET] = IDE_CTRL;
+	hw.irq = IDE_IRQ;
+
+	if (ide_register_hw(&hw, &hwif) != -1)
+		h8300_hwif_iops(hwif);
+
+	return 0;
+}
+
+module_init(h8300_ide_init);
diff -puN drivers/ide/ide-probe.c~ide_h8300 drivers/ide/ide-probe.c
--- linux-2.6.3/drivers/ide/ide-probe.c~ide_h8300	2004-02-20 16:05:11.900310392 +0100
+++ linux-2.6.3-root/drivers/ide/ide-probe.c	2004-02-20 16:07:23.736268280 +0100
@@ -965,7 +965,7 @@ static int init_irq (ide_hwif_t *hwif)
 	unsigned int index;
 	ide_hwgroup_t *hwgroup;
 	ide_hwif_t *match = NULL;
-
+	unsigned int regs_gap;		/* needed for H8/300 */
 
 	BUG_ON(in_interrupt());
 	BUG_ON(irqs_disabled());	
@@ -1084,10 +1084,11 @@ static int init_irq (ide_hwif_t *hwif)
 		spin_unlock_irq(&ide_lock);
 	}
 
+	regs_gap = hwif->io_ports[IDE_ERROR_OFFSET] - hwif->io_ports[IDE_DATA_OFFSET];
 #if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %d", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],
-		hwif->io_ports[IDE_DATA_OFFSET]+7,
+		hwif->io_ports[IDE_DATA_OFFSET] + regs_gap * 8 - 1,
 		hwif->io_ports[IDE_CONTROL_OFFSET], hwif->irq);
 #elif defined(__sparc__)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %s", hwif->name,
diff -puN drivers/ide/ide-proc.c~ide_h8300 drivers/ide/ide-proc.c
--- linux-2.6.3/drivers/ide/ide-proc.c~ide_h8300	2004-02-20 15:49:23.108548664 +0100
+++ linux-2.6.3-root/drivers/ide/ide-proc.c	2004-02-20 15:50:25.580051552 +0100
@@ -239,8 +239,7 @@ static int proc_ide_write_config
 					}
 #endif	/* CONFIG_BLK_DEV_IDEPCI */
 				} else {	/* not pci */
-#if !defined(__mc68000__) && !defined(CONFIG_APUS)
-
+#if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__H8300H__)
 /*
  * Geert Uytterhoeven
  *
@@ -268,7 +267,7 @@ static int proc_ide_write_config
 						case 8:	hwif->OUTL(val, reg);
 							break;
 					}
-#endif /* !__mc68000__ && !CONFIG_APUS */
+#endif /* !__mc68000__ && !CONFIG_APUS !__H8300H__ */
 				}
 			}
 		}
diff -puN drivers/ide/Makefile~ide_h8300 drivers/ide/Makefile
--- linux-2.6.3/drivers/ide/Makefile~ide_h8300	2004-02-20 15:51:48.649423088 +0100
+++ linux-2.6.3-root/drivers/ide/Makefile	2004-02-20 16:02:33.666365608 +0100
@@ -39,6 +39,11 @@ ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= p
 ide-core-$(CONFIG_BLK_DEV_IDE_SWARM)	+= ppc/swarm.o
 
 obj-$(CONFIG_BLK_DEV_IDE)		+= ide-core.o
+
+# there can be only one interface => no ordering problems
+ide-$(CONFIG_H8300H_H8MAX)		+= h8300/ide-h8300.o
+ide-$(CONFIG_H8300H_AKI3068NET)		+= h8300/ide-h8300.o
+
 obj-$(CONFIG_IDE_GENERIC)		+= ide-generic.o
 
 obj-$(CONFIG_BLK_DEV_IDEDISK)		+= ide-disk.o

_


