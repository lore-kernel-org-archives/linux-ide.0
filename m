From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: [PATCH] ARM{26} IDE cleanups
Date: Wed, 21 Apr 2004 01:48:33 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200404210148.33415.bzolnier@elka.pw.edu.pl>
References: <200404202335.59291.bzolnier@elka.pw.edu.pl> <20040420233323.F16428@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:33719 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S263862AbUDTXtR
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 20 Apr 2004 19:49:17 -0400
In-Reply-To: <20040420233323.F16428@flint.arm.linux.org.uk>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Russell King <rmk@arm.linux.org.uk>
Cc: Ian Molton <spyro@f2s.com>, linux-ide@vger.kernel.org

On Wednesday 21 of April 2004 00:33, Russell King wrote:
> > - Kill <asm-arm/arch-*/ide.h> (except broken
> > <asm-arm/arch-sa1100/ide.h>).
>
> How are you handling the different register increments between the
> machines?  Some have registers placed at +4 offsets, others +1.
> Others even +32.
>
> I don't see any provision for this.  Sure, the majority  have used
> increments of one, but SA1100 doesn't, and I can see PXA being the
> same - and this is the why architectures were given control over
> the address initialisation.

This is my (failed) attempt to fix SA1100 IDE, just as example how
to do interface initialization w/o ide_init_default_hwifs().

The only difference in functionality is that "ide=base[,ctl,[irq]]"
kernel parameter and HDIO_SCAN_HWIF ioctl won't work (they both use
obsolete ide_init_hwif_ports()).  They will die in 2.7 but for now
(if you *really* need them) you can add hack for your interface to
generic ide_init_hwif_ports() in <linux/ide.h> (well, I just left
ide_init_hwif_ports() in <asm/arch-sa1100/ide.h> in my patch).

Bartlomiej


 linux-2.6.6-rc1-bk4-bzolnier/drivers/ide/Makefile              |    3 
 linux-2.6.6-rc1-bk4-bzolnier/drivers/ide/arm/ide_sa1100.c      |  165 ++++++++++
 linux-2.6.6-rc1-bk4-bzolnier/drivers/ide/ide.c                 |    4 
 linux-2.6.6-rc1-bk4-bzolnier/include/asm-arm/arch-sa1100/ide.h |   93 -----
 4 files changed, 173 insertions(+), 92 deletions(-)

diff -puN /dev/null drivers/ide/arm/ide_sa1100.c
--- /dev/null	2004-01-17 00:25:55.000000000 +0100
+++ linux-2.6.6-rc1-bk4-bzolnier/drivers/ide/arm/ide_sa1100.c	2004-04-19 18:41:42.374487296 +0200
@@ -0,0 +1,165 @@
+/*
+ * ARM SA1100 IDE host driver
+ *
+ * Copyright (C) 2004 Bartlomiej Zolnierkiewicz
+ *
+ * Moved here from linux/include/asm-arm/arch-sa1100/ide.h:
+ * Copyright (C) 1998 Hugo Fiennes & Nicolas Pitre
+ * Copyright (C) 2000 Erik Mouw (J.A.K.Mouw@its.tudelft.nl)
+ *
+ * May be copied or modified under the terms of the GNU General Public License.
+ */
+
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <linux/config.h>
+
+#include <asm/irq.h>
+#include <asm/hardware.h>
+#include <asm/mach-types.h>
+
+#ifdef CONFIG_SA1100_LART
+# include <asm/arch/lart.h>
+#endif
+
+#ifdef CONFIG_SA1100_TRIZEPS
+# include <asm/arch/trizeps.h>
+#endif
+
+static inline void sa1100_init_hwif(ide_hwif_t *hwif,
+				    unsigned long io_addr,
+				    unsigned long ctl_addr,
+				    int irq)
+{
+	hw_regs_t *hw = &hwif->hw;
+	unsigned int i;
+
+	if (hwif->chipset == ide_forced)
+		return;
+
+	memset(hw, 0, sizeof(*hw));
+
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
+		hw->io_ports[i] = io_addr;
+
+		/*
+		 * The Empeg has the first two address lines unused,
+		 * the LART doesn't use A0 for IDE.
+		 */
+		if (machine_is_empeg())
+			io_addr += 1 << 2;
+		else if (machine_is_lart())
+			io_addr += 1 << 1;
+		else
+			io_addr++;
+	}
+	hw->io_ports[IDE_CONTROL_OFFSET] = ctl_addr;
+
+	memcpy(hwif->io_ports, hw->io_ports, sizeof(hw->io_ports));
+
+	hwif->irq = hwif->hw.irq = irq;
+
+	hwif->noprobe = 0;
+}
+
+static inline void empeg_ide_init(void)
+{
+#ifdef CONFIG_SA1100_EMPEG
+	/* PCMCIA IO space */
+	MECR = 0x21062106;
+
+	/* Issue 3 is much neater than issue 2. */
+	GPDR &= ~(EMPEG_IDE1IRQ|EMPEG_IDE2IRQ);
+
+	/*
+	 * Interrupts on rising edge:
+	 * lines are inverted before they get to the SA.
+	 */
+	set_irq_type(EMPEG_IDE1IRQ|EMPEG_IDE2IRQ, IRQT_FALLING);
+
+	/* Take hard drives out of reset. */
+	GPSR = (EMPEG_IDERESET);
+
+	/*
+	 * Sonja and her successors have two IDE ports.
+	 * MAC 23/4/1999, swap these round so that the left hand
+	 * hard disk is hda when viewed from the front.
+	 * This doesn't match the silkscreen however.
+	 */
+	sa1100_init_hwif(&ide_hwifs[0],
+			 PCMCIA_IO_0_BASE + 0x40,
+			 PCMCIA_IO_0_BASE + 0x78,
+			 EMPEG_IRQ_IDE2);
+	sa1100_init_hwif(&ide_hwifs[1],
+			 PCMCIA_IO_0_BASE + 0x00,
+			 PCMCIA_IO_0_BASE + 0x38,
+			 EMPEG_IRQ_IDE1);
+#endif
+}
+
+static inline void victor_ide_init(void)
+{
+#ifdef CONFIG_SA1100_VICTOR
+	/* Enable appropriate GPIOs as interrupt lines. */
+	GPDR &= ~GPIO_GPIO7;
+	set_irq_type(GPIO_GPIO7, IRQT_RISING);
+
+	/* Set PCMCIA interface timing. */
+	MECR = 0x00060006;
+
+	sa1100_init_hwif(&ide_hwifs[0],
+			 PCMCIA_IO_0_BASE + 0x1f0,
+			 PCMCIA_IO_0_BASE + 0x3f6,
+			 IRQ_GPIO7);
+#endif
+}
+
+static inline void lart_ide_init(void)
+{
+#ifdef CONFIG_SA1100_LART
+	/* Enable GPIO as interrupt line. */
+	GPDR &= ~LART_GPIO_IDE;
+	set_irq_type(LART_IRQ_IDE, IRQT_RISING);
+
+	/* Set PCMCIA interface timing. */
+	MECR = 0x00060006;
+
+	sa1100_init_hwif(&ide_hwifs[0],
+			 PCMCIA_IO_0_BASE + 0x0000,
+			 PCMCIA_IO_0_BASE + 0x1000,
+			 LART_IRQ_IDE);
+#endif
+}
+
+static inline void trizeps_ide_init(void)
+{
+#ifdef CONFIG_SA1100_TRIZEPS
+	/* Enable appropriate GPIOs as interrupt lines. */
+	GPDR &= ~GPIO_GPIO(TRIZEPS_IRQ_IDE);
+	set_irq_type(TRIZEPS_IRQ_IDE, IRQT_RISING);
+
+	/* Set PCMCIA interface timing. */
+	//MECR = 0x00060006;	/* Done on trizeps init. */
+
+	/* Take hard drives out of reset. */
+	GPSR = GPIO_GPIO(TRIZEPS_IRQ_IDE);
+
+	sa1100_init_hwif(&ide_hwifs[0],
+			 TRIZEPS_IDE_CS0 + 0,
+			 TRIZEPS_IDE_CS1 + 6,
+			 TRIZEPS_IRQ_IDE);
+#endif
+}
+
+void __init ide_sa1100_init(void)
+{
+	if (machine_is_empeg())
+		empeg_ide_init();
+	else if (machine_is_victor())
+		victor_ide_init();
+	else if (machine_is_lart())
+		lart_ide_init();
+	else if (machine_is_trizeps())
+		trizeps_ide_init();
+}
diff -puN drivers/ide/ide.c~ide_sa1100 drivers/ide/ide.c
--- linux-2.6.6-rc1-bk4/drivers/ide/ide.c~ide_sa1100	2004-04-19 18:14:55.573758136 +0200
+++ linux-2.6.6-rc1-bk4-bzolnier/drivers/ide/ide.c	2004-04-19 18:26:22.000000000 +0200
@@ -2364,6 +2364,7 @@ struct bus_type ide_bus_type = {
 };
 
 extern void ide_arm_init(void);
+extern void ide_sa1100_init(void);
 
 /*
  * This is gets invoked once during initialization, to set *everything* up
@@ -2385,6 +2386,9 @@ int __init ide_init (void)
 #ifdef CONFIG_IDE_ARM
 	ide_arm_init();
 #endif
+#if defined(CONFIG_ARM) && defined(CONFIG_ARCH_SA1100)
+	ide_sa1100_init();
+#endif
 #ifdef CONFIG_BLK_DEV_ALI14XX
 	if (probe_ali14xx)
 		(void)ali14xx_init();
diff -puN drivers/ide/Makefile~ide_sa1100 drivers/ide/Makefile
--- linux-2.6.6-rc1-bk4/drivers/ide/Makefile~ide_sa1100	2004-04-19 18:14:55.577757528 +0200
+++ linux-2.6.6-rc1-bk4-bzolnier/drivers/ide/Makefile	2004-04-19 18:14:55.590755552 +0200
@@ -27,6 +27,9 @@ ide-core-$(CONFIG_BLK_DEV_IDEPNP)	+= ide
 
 # built-in only drivers from arm/
 ide-core-$(CONFIG_IDE_ARM)		+= arm/ide_arm.o
+ifeq ($(CONFIG_ARM),y)
+ide-core-$(CONFIG_ARCH_SA1100)		+= arm/ide_sa1100.o
+endif
 
 # built-in only drivers from legacy/
 ide-core-$(CONFIG_BLK_DEV_IDE_PC9800)	+= legacy/pc9800.o
diff -puN include/asm-arm/arch-sa1100/ide.h~ide_sa1100 include/asm-arm/arch-sa1100/ide.h
--- linux-2.6.6-rc1-bk4/include/asm-arm/arch-sa1100/ide.h~ide_sa1100	2004-04-19 18:14:55.000000000 +0200
+++ linux-2.6.6-rc1-bk4-bzolnier/include/asm-arm/arch-sa1100/ide.h	2004-04-19 18:14:55.000000000 +0200
@@ -51,95 +51,4 @@ static inline void ide_init_hwif_ports(h
 #include <asm/arch/trizeps.h>
 #endif
 
-/*
- * This registers the standard ports for this architecture with the IDE
- * driver.
- */
-static __inline__ void
-ide_init_default_hwifs(void)
-{
-    if( machine_is_empeg() ){
-#ifdef CONFIG_SA1100_EMPEG
-	hw_regs_t hw;
-
-	/* First, do the SA1100 setup */
-
-	/* PCMCIA IO space */
-	MECR=0x21062106;
-
-        /* Issue 3 is much neater than issue 2 */
-	GPDR&=~(EMPEG_IDE1IRQ|EMPEG_IDE2IRQ);
-
-	/* Interrupts on rising edge: lines are inverted before they get to
-           the SA */
-	set_GPIO_IRQ_edge( (EMPEG_IDE1IRQ|EMPEG_IDE2IRQ), GPIO_FALLING_EDGE );
-
-	/* Take hard drives out of reset */
-	GPSR=(EMPEG_IDERESET);
-
-	/* Sonja and her successors have two IDE ports. */
-	/* MAC 23/4/1999, swap these round so that the left hand
-	   hard disk is hda when viewed from the front. This
-	   doesn't match the silkscreen however. */
-	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x40, PCMCIA_IO_0_BASE + 0x78, NULL);
-	hw.irq = EMPEG_IRQ_IDE2;
-	ide_register_hw(&hw);
-	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x00, PCMCIA_IO_0_BASE + 0x38, NULL);
-	hw.irq = ,EMPEG_IRQ_IDE1;
-	ide_register_hw(&hw);
-#endif
-    }
-
-    else if( machine_is_victor() ){
-#ifdef CONFIG_SA1100_VICTOR
-	hw_regs_t hw;
-
-	/* Enable appropriate GPIOs as interrupt lines */
-	GPDR &= ~GPIO_GPIO7;
-	set_GPIO_IRQ_edge( GPIO_GPIO7, GPIO_RISING_EDGE );
-
-	/* set the pcmcia interface timing */
-	MECR = 0x00060006;
-
-	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x1f0, PCMCIA_IO_0_BASE + 0x3f6, NULL);
-	hw.irq = IRQ_GPIO7;
-	ide_register_hw(&hw);
-#endif
-    }
-    else if (machine_is_lart()) {
-#ifdef CONFIG_SA1100_LART
-        hw_regs_t hw;
-
-        /* Enable GPIO as interrupt line */
-        GPDR &= ~LART_GPIO_IDE;
-	set_irq_type(LART_IRQ_IDE, IRQT_RISING);
-
-        /* set PCMCIA interface timing */
-        MECR = 0x00060006;
-
-        /* init the interface */
-	ide_init_hwif_ports(&hw, PCMCIA_IO_0_BASE + 0x0000, PCMCIA_IO_0_BASE + 0x1000, NULL);
-        hw.irq = LART_IRQ_IDE;
-        ide_register_hw(&hw);
-#endif
-    }
-    else if( machine_is_trizeps() ){
-#ifdef CONFIG_SA1100_TRIZEPS
-	hw_regs_t hw;
-
-	/* Enable appropriate GPIOs as interrupt lines */
-	GPDR &= ~GPIO_GPIO(TRIZEPS_IRQ_IDE);
-	set_irq_type( TRIZEPS_IRQ_IDE, IRQT_RISING );
-
-	/* set the pcmcia interface timing */
-	//MECR = 0x00060006; // Done on trizeps init
-
-	/* Take hard drives out of reset */
-	GPSR = GPIO_GPIO(TRIZEPS_IRQ_IDE);
-
-	ide_init_hwif_ports(&hw, TRIZEPS_IDE_CS0 + 0, TRIZEPS_IDE_CS1 + 6, NULL);
-	hw.irq = TRIZEPS_IRQ_IDE;
-	ide_register_hw(&hw, NULL);
-#endif
-    }
-}
+static inline void ide_init_default_hwifs(void) { ; }

_

