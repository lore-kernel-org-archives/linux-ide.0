From: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: cirrus ep93xx pata driver (was: Re: PATA drivers queued for 2.6.19)
Date: Sun, 28 Jan 2007 21:21:17 +0100
Message-ID: <20070128202117.GA6147@xi.wantstofly.org>
References: <44FC0779.9030405@garzik.org> <20060921115533.GA26960@xi.wantstofly.org> <4513B21A.30507@garzik.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from alephnull.demon.nl ([83.160.184.112]:44833 "EHLO
	xi.wantstofly.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932820AbXA1UnJ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 28 Jan 2007 15:43:09 -0500
Content-Disposition: inline
In-Reply-To: <4513B21A.30507@garzik.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org

(please CC, not on the list)

On Fri, Sep 22, 2006 at 05:51:22AM -0400, Jeff Garzik wrote:

> > Allessandro Zummo sent the patch below to me a while ago, for support
> > for the PATA controller (PIO only, although the hardware can also do
> > UDMA) in the cirrus logic ep93xx ARM cpu.
> >
> > The driver has bitrotted somewhat, and apart from that it never honored
> > PIO timings properly and has some other issues, but Allessandro seems to
> > have disappeared off the face of the planet.  I'd still like to see
> > support for this go in at some point, so I'll have a try at cleaning it
> > up and updating it (and converting it to a platform driver, etc.)
> 
> Please do, I'm definitely interested in it.

Below is a mostly rewritten driver against 2.6.20-rcX for the ep93xx.
Lightly tested, appears to work at least with CompactFlash cards.

There are still several issues with the current version that I am aware
of, and so I'm not asking for a review of pata_ep93xx.c yet.  I _would_
like to get some input on the libata-* changes in the patch.

The main problem with the ep93xx is that its "IDE controller" is really
just a (somewhat) glorified GPIO controller.  You can't trigger a PATA
bus read or write by reading or writing some specified memory location,
oh no, that would have been too easy.  Instead, you have to set CS/DA
manually, then assert DIORn/DIOWn manually, delay for the right number
of nanoseconds corresponding to this PIO mode, and then deassert
DIORn/DIOWn again by hand.

libata-{core,sff}.c assume that we can read from device registers
using readb()/inb() and write to them via writeb()/outb().  While it
is possible to avoid some of these codepaths by defining your own
ata_port_operations, some codepaths that do direct accesses aren't
override-able.

The approach taken below is to add ops for these, which isn't
necessarily the best approach.  (Another approach might be to define
ATA_FLAG_FITH as a third access method alongside ATA_FLAG_MMIO and
!ATA_FLAG_MMIO.)

The other thing is that it's not guaranteed that the INTRQ line is
actually hooked up to something, while some libata code paths bail
out if ent->irq is zero.

Comments?


Signed-off-by: Lennert Buytenhek <buytenh@wantstofly.org>

Index: linux-2.6.19/drivers/ata/Kconfig
===================================================================
--- linux-2.6.19.orig/drivers/ata/Kconfig
+++ linux-2.6.19/drivers/ata/Kconfig
@@ -246,6 +246,15 @@ config ATA_GENERIC
 
 	  If unsure, say N.
 
+config PATA_EP93XX
+	tristate "Cirrus Logic EP93XX PATA support"
+	depends on ARCH_EP93XX
+	help
+	  This option enables support for the PATA controller in
+	  the Cirrus Logic ep93xx ARM CPU.
+
+	  If unsure, say N.
+
 config PATA_HPT366
 	tristate "HPT 366/368 PATA support (Very Experimental)"
 	depends on PCI && EXPERIMENTAL
Index: linux-2.6.19/drivers/ata/Makefile
===================================================================
--- linux-2.6.19.orig/drivers/ata/Makefile
+++ linux-2.6.19/drivers/ata/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_PATA_CS5530)	+= pata_cs5530
 obj-$(CONFIG_PATA_CS5535)	+= pata_cs5535.o
 obj-$(CONFIG_PATA_CYPRESS)	+= pata_cypress.o
 obj-$(CONFIG_PATA_EFAR)		+= pata_efar.o
+obj-$(CONFIG_PATA_EP93XX)	+= pata_ep93xx.o
 obj-$(CONFIG_PATA_HPT366)	+= pata_hpt366.o
 obj-$(CONFIG_PATA_HPT37X)	+= pata_hpt37x.o
 obj-$(CONFIG_PATA_HPT3X2N)	+= pata_hpt3x2n.o
Index: linux-2.6.19/drivers/ata/libata-core.c
===================================================================
--- linux-2.6.19.orig/drivers/ata/libata-core.c
+++ linux-2.6.19/drivers/ata/libata-core.c
@@ -59,6 +59,14 @@
 
 #include "libata.h"
 
+#ifdef CONFIG_ARCH_EP93XX
+#warning remove this
+#undef readb
+#undef writeb
+#define readb(x) printk(KERN_CRIT "readb() at core line %d\n",  __LINE__)
+#define writeb(d,a) printk(KERN_CRIT "writeb() at core line %d\n", __LINE__)
+#endif
+
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
 const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
@@ -701,6 +709,9 @@ static unsigned int ata_mmio_devchk(stru
 static unsigned int ata_devchk(struct ata_port *ap,
 				    unsigned int device)
 {
+	if (ap->ops->dev_check != NULL)
+		return ap->ops->dev_check(ap, device);
+
 	if (ap->flags & ATA_FLAG_MMIO)
 		return ata_mmio_devchk(ap, device);
 	return ata_pio_devchk(ap, device);
@@ -2657,7 +2668,9 @@ static unsigned int ata_bus_softreset(st
 	DPRINTK("ata%u: bus reset via SRST\n", ap->id);
 
 	/* software reset.  causes dev0 to be selected */
-	if (ap->flags & ATA_FLAG_MMIO) {
+	if (ap->ops->bus_softreset != NULL) {
+		ap->ops->bus_softreset(ap);
+	} else if (ap->flags & ATA_FLAG_MMIO) {
 		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 		udelay(20);	/* FIXME: flush */
 		writeb(ap->ctl | ATA_SRST, (void __iomem *) ioaddr->ctl_addr);
@@ -2770,7 +2783,9 @@ void ata_bus_reset(struct ata_port *ap)
 
 	if (ap->flags & (ATA_FLAG_SATA_RESET | ATA_FLAG_SRST)) {
 		/* set up device control for ATA_FLAG_SATA_RESET */
-		if (ap->flags & ATA_FLAG_MMIO)
+		if (ap->ops->irq_on != NULL)
+			ap->ops->irq_on(ap);		// @@@ wrong
+		else if (ap->flags & ATA_FLAG_MMIO)
 			writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 		else
 			outb(ap->ctl, ioaddr->ctl_addr);
@@ -5780,10 +5795,12 @@ int ata_device_add(const struct ata_prob
 
 	DPRINTK("ENTER\n");
 	
+#if 0
 	if (ent->irq == 0) {
 		dev_printk(KERN_ERR, dev, "is not available: No interrupt assigned.\n");
 		return 0;
 	}
+#endif
 	/* alloc a container for our list of ATA ports (buses) */
 	host = kzalloc(sizeof(struct ata_host) +
 		       (ent->n_ports * sizeof(void *)), GFP_KERNEL);
@@ -5841,17 +5858,22 @@ int ata_device_add(const struct ata_prob
 				ap->ioaddr.bmdma_addr,
 				irq_line);
 
+		if (!ent->irq)
+			printk(KERN_INFO "ata%u: polling mode\n", ap->id);
+
 		/* freeze port before requesting IRQ */
 		ata_eh_freeze_port(ap);
 	}
 
-	/* obtain irq, that may be shared between channels */
-	rc = request_irq(ent->irq, ent->port_ops->irq_handler, ent->irq_flags,
-			 DRV_NAME, host);
-	if (rc) {
-		dev_printk(KERN_ERR, dev, "irq %lu request failed: %d\n",
-			   ent->irq, rc);
-		goto err_out;
+	if (ent->irq) {
+		/* obtain irq, that may be shared between channels */
+		rc = request_irq(ent->irq, ent->port_ops->irq_handler,
+				 ent->irq_flags, DRV_NAME, host);
+		if (rc) {
+			dev_printk(KERN_ERR, dev, "irq %lu request failed: "
+				    "%d\n", ent->irq, rc);
+			goto err_out;
+		}
 	}
 
 	/* do we have a second IRQ for the other channel, eg legacy mode */
@@ -5943,7 +5965,8 @@ int ata_device_add(const struct ata_prob
 	return ent->n_ports; /* success */
 
 err_out_free_irq:
-	free_irq(ent->irq, host);
+	if (ent->irq)
+		free_irq(ent->irq, host);
 err_out:
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap = host->ports[i];
@@ -6034,7 +6057,8 @@ void ata_host_remove(struct ata_host *ho
 	for (i = 0; i < host->n_ports; i++)
 		ata_port_detach(host->ports[i]);
 
-	free_irq(host->irq, host);
+	if (host->irq)
+		free_irq(host->irq, host);
 	if (host->irq2)
 		free_irq(host->irq2, host);
 
Index: linux-2.6.19/drivers/ata/libata-sff.c
===================================================================
--- linux-2.6.19.orig/drivers/ata/libata-sff.c
+++ linux-2.6.19/drivers/ata/libata-sff.c
@@ -38,6 +38,14 @@
 
 #include "libata.h"
 
+#ifdef CONFIG_ARCH_EP93XX
+#warning remove this
+#undef readb
+#undef writeb
+#define readb(x) printk(KERN_CRIT "readb() at sff line %d\n",  __LINE__)
+#define writeb(d,a) printk(KERN_CRIT "writeb() at sff line %d\n", __LINE__)
+#endif
+
 /**
  *	ata_irq_on - Enable interrupts on a port.
  *	@ap: Port on which interrupts are enabled.
@@ -56,7 +64,9 @@ u8 ata_irq_on(struct ata_port *ap)
 	ap->ctl &= ~ATA_NIEN;
 	ap->last_ctl = ap->ctl;
 
-	if (ap->flags & ATA_FLAG_MMIO)
+	if (ap->ops->irq_on != NULL)
+		ap->ops->irq_on(ap);
+	else if (ap->flags & ATA_FLAG_MMIO)
 		writeb(ap->ctl, (void __iomem *) ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
@@ -417,6 +427,9 @@ static u8 ata_check_status_mmio(struct a
  */
 u8 ata_check_status(struct ata_port *ap)
 {
+	if (ap->ops->check_status)
+		return ap->ops->check_status(ap);
+
 	if (ap->flags & ATA_FLAG_MMIO)
 		return ata_check_status_mmio(ap);
 	return ata_check_status_pio(ap);
Index: linux-2.6.19/drivers/ata/pata_ep93xx.c
===================================================================
--- /dev/null
+++ linux-2.6.19/drivers/ata/pata_ep93xx.c
@@ -0,0 +1,459 @@
+/*
+ * EP93XX PATA controller driver.
+ * Copyright (C) 2007 Lennert Buytenhek <buytenh@wantstofly.org>
+ *
+ * An ATA driver for the Cirrus Logic EP93xx PATA controller.
+ *
+ * Based on an earlier version by Alessandro Zummo, which is:
+ *   Copyright (C) 2006 Tower Technologies
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <scsi/scsi_host.h>
+
+#define DRV_NAME	"pata_ep93xx"
+#define DRV_VERSION	"0.2"
+
+#define PATA_REG(x)		(EP93XX_IDE_BASE + (x))
+#define PATA_CTRL		PATA_REG(0x0000)
+#define  PATA_CTRL_IORDY	0x0400
+#define  PATA_CTRL_DIOWn	0x0040
+#define  PATA_CTRL_DIORn	0x0020
+#define PATA_CFG		PATA_REG(0x0004)
+#define  PATA_CFG_IDEEN		0x0001
+#define  PATA_CFG_PIO		0x0002
+#define  PATA_CFG_MODE(x)	((x & 0x0f) << 4)
+#define PATA_CFG_WST(x)		((x & 0x03) << 8)
+#define PATA_DATAOUT		PATA_REG(0x0010)
+#define PATA_DATAIN		PATA_REG(0x0014)
+
+#define nop5()			{ nop(); nop(); nop(); nop(); nop(); }
+#define nop10()			{ nop5(); nop5(); }
+
+static unsigned short pata_read(unsigned long addr)
+{
+	addr &= 0x1f;
+
+	__raw_writel(PATA_CTRL_DIOWn | PATA_CTRL_DIORn | addr, PATA_CTRL);
+
+	// delay 70/50/30/30/25 ns
+	nop10(); nop(); nop(); nop(); nop();
+
+	__raw_writel(PATA_CTRL_DIOWn | addr, PATA_CTRL);
+
+	// delay 290/290/290/80/70 ns
+	nop10(); nop10(); nop10(); nop10(); nop10(); nop5(); nop(); nop(); nop();
+
+	__raw_writel(PATA_CTRL_DIOWn | PATA_CTRL_DIORn | addr, PATA_CTRL);
+
+	return __raw_readl(PATA_DATAIN);
+}
+
+static void pata_write(u16 value, unsigned long addr)
+{
+	addr &= 0x1f;
+
+	__raw_writel(value, PATA_DATAOUT);
+
+	__raw_writel(PATA_CTRL_DIOWn | PATA_CTRL_DIORn | addr, PATA_CTRL);
+
+	// delay 70/50/30/30/25 ns
+	nop10(); nop(); nop(); nop(); nop();
+
+	__raw_writel(PATA_CTRL_DIORn | addr, PATA_CTRL);
+
+	// delay 290/290/290/80/70 ns
+	nop10(); nop10(); nop10(); nop10(); nop10(); nop5(); nop(); nop(); nop();
+
+ 	__raw_writel(PATA_CTRL_DIOWn | PATA_CTRL_DIORn | addr, PATA_CTRL);
+
+	// delay 240/50/20/70/25 ns
+	nop10(); nop10(); nop10(); nop10(); nop5(); nop(); nop(); nop();
+}
+
+static unsigned long ep93xx_mode_filter(const struct ata_port *ap, struct ata_device *adev, unsigned long xfer_mask)
+{
+	return xfer_mask & ATA_MASK_PIO;
+}
+
+static void ep93xx_tf_load(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+
+	if (tf->ctl != ap->last_ctl) {
+		pata_write(tf->ctl, ioaddr->ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		pata_write(tf->hob_feature, ioaddr->feature_addr);
+		pata_write(tf->hob_nsect, ioaddr->nsect_addr);
+		pata_write(tf->hob_lbal, ioaddr->lbal_addr);
+		pata_write(tf->hob_lbam, ioaddr->lbam_addr);
+		pata_write(tf->hob_lbah, ioaddr->lbah_addr);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+
+	if (is_addr) {
+		pata_write(tf->feature, ioaddr->feature_addr);
+		pata_write(tf->nsect, ioaddr->nsect_addr);
+		pata_write(tf->lbal, ioaddr->lbal_addr);
+		pata_write(tf->lbam, ioaddr->lbam_addr);
+		pata_write(tf->lbah, ioaddr->lbah_addr);
+		VPRINTK("feat 0x%X nsect 0x%X lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		pata_write(tf->device, ioaddr->device_addr);
+		VPRINTK("device 0x%X\n", tf->device);
+	}
+
+	ata_wait_idle(ap);
+}
+
+static void ep93xx_tf_read(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+
+	tf->command = ap->ops->check_status(ap);
+	tf->feature = pata_read(ioaddr->error_addr);
+	tf->nsect = pata_read(ioaddr->nsect_addr);
+	tf->lbal = pata_read(ioaddr->lbal_addr);
+	tf->lbam = pata_read(ioaddr->lbam_addr);
+	tf->lbah = pata_read(ioaddr->lbah_addr);
+	tf->device = pata_read(ioaddr->device_addr);
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		pata_write(tf->ctl | ATA_HOB, ioaddr->ctl_addr);
+		tf->hob_feature = pata_read(ioaddr->error_addr);
+		tf->hob_nsect = pata_read(ioaddr->nsect_addr);
+		tf->hob_lbal = pata_read(ioaddr->lbal_addr);
+		tf->hob_lbam = pata_read(ioaddr->lbam_addr);
+		tf->hob_lbah = pata_read(ioaddr->lbah_addr);
+	}
+}
+
+static void ep93xx_exec_command(struct ata_port *ap, const struct ata_taskfile *tf)
+{
+	DPRINTK("ata%u: cmd 0x%X\n", ap->id, tf->command);
+
+	pata_write(tf->command, ap->ioaddr.command_addr);
+	ata_pause(ap);
+}
+
+static u8 ep93xx_check_status(struct ata_port *ap)
+{
+	return pata_read(ap->ioaddr.status_addr);
+}
+
+static u8 ep93xx_check_altstatus(struct ata_port *ap)
+{
+	return pata_read(ap->ioaddr.altstatus_addr);
+}
+
+static void ep93xx_dev_select(struct ata_port *ap, unsigned int device)
+{
+	u8 tmp;
+
+	if (device == 0)
+		tmp = ATA_DEVICE_OBS;
+	else
+		tmp = ATA_DEVICE_OBS | ATA_DEV1;
+
+	pata_write(tmp, ap->ioaddr.device_addr);
+
+	ata_pause(ap);	/* needed; also flushes, for mmio */
+}
+
+static unsigned int ep93xx_dev_check(struct ata_port *ap, unsigned int device)
+{
+	struct ata_ioports *ioaddr = &ap->ioaddr;
+	u8 nsect, lbal;
+
+	ep93xx_dev_select(ap, device);
+
+	pata_write(0x55, ioaddr->nsect_addr);
+	pata_write(0xaa, ioaddr->lbal_addr);
+
+	pata_write(0xaa, ioaddr->nsect_addr);
+	pata_write(0x55, ioaddr->lbal_addr);
+
+	pata_write(0x55, ioaddr->nsect_addr);
+	pata_write(0xaa, ioaddr->lbal_addr);
+
+	nsect = pata_read(ioaddr->nsect_addr);
+	lbal = pata_read(ioaddr->lbal_addr);
+
+	if ((nsect == 0x55) && (lbal == 0xaa))
+		return 1;	/* we found a device */
+
+	return 0;		/* nothing found */
+}
+
+static void ep93xx_phy_reset(struct ata_port *ap)
+{
+	ap->cbl = ATA_CBL_PATA40;
+	ata_port_probe(ap);
+	ata_bus_reset(ap);
+}
+
+static void ep93xx_bus_softreset(struct ata_port *ap)
+{
+	pata_write(ap->ctl, ap->ioaddr.ctl_addr);
+	udelay(20);     /* FIXME: flush */
+	pata_write(ap->ctl | ATA_SRST, ap->ioaddr.ctl_addr);
+	udelay(20);     /* FIXME: flush */
+	pata_write(ap->ctl, ap->ioaddr.ctl_addr);
+}
+
+static void ep93xx_set_mode(struct ata_port *ap)
+{
+	int i;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+		if (ata_dev_enabled(dev)) {
+			dev->pio_mode = XFER_PIO_0;
+			dev->xfer_mode = XFER_PIO_0;
+			dev->xfer_shift = ATA_SHIFT_PIO;
+			dev->flags |= ATA_DFLAG_PIO;
+		}
+	}
+}
+
+static void ep93xx_data_xfer(struct ata_device *adev, unsigned char *buf,
+				unsigned int buflen, int write_data)
+{
+	struct ata_port *ap = adev->ap;
+	unsigned long addr;
+	unsigned int words;
+	u16 *buf16;
+	unsigned int i;
+
+	addr = ap->ioaddr.data_addr;
+	words = buflen >> 1;
+	buf16 = (u16 *)buf;
+
+	/* Transfer multiple of 2 bytes */
+	if (write_data) {
+		for (i = 0; i < words; i++)
+			pata_write(le16_to_cpu(buf16[i]), addr);
+	} else {
+		for (i = 0; i < words; i++)
+			buf16[i] = cpu_to_le16(pata_read(addr));
+	}
+
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 1)) {
+		u16 align_buf[1] = { 0 };
+		unsigned char *trailing_buf = buf + buflen - 1;
+
+		if (write_data) {
+			memcpy(align_buf, trailing_buf, 1);
+			pata_write(le16_to_cpu(align_buf[0]), addr);
+		} else {
+			align_buf[0] = cpu_to_le16(pata_read(addr));
+			memcpy(trailing_buf, align_buf, 1);
+		}
+	}
+}
+
+static u8 ep93xx_irq_ack(struct ata_port *ap)
+{
+	BUG();
+}
+
+static void ep93xx_irq_clear(struct ata_port *ap)
+{
+}
+
+static void ep93xx_irq_on(struct ata_port *ap)
+{
+	pata_write(ap->ctl, ap->ioaddr.ctl_addr);
+}
+
+static struct scsi_host_template ep93xx_sht = {
+	.module			= THIS_MODULE,
+	.name			= DRV_NAME,
+	.ioctl			= ata_scsi_ioctl,
+	.queuecommand		= ata_scsi_queuecmd,
+	.slave_configure	= ata_scsi_slave_config,
+	.slave_destroy		= ata_scsi_slave_destroy,
+	.bios_param		= ata_std_bios_param,
+	.proc_name		= DRV_NAME,
+	.can_queue		= ATA_DEF_QUEUE,
+	.this_id		= ATA_SHT_THIS_ID,
+	.sg_tablesize		= LIBATA_MAX_PRD,
+	.max_sectors		= ATA_MAX_SECTORS,
+	.dma_boundary		= ATA_DMA_BOUNDARY,
+	.cmd_per_lun		= ATA_SHT_CMD_PER_LUN,
+	.use_clustering		= ATA_SHT_USE_CLUSTERING,
+	.emulated		= ATA_SHT_EMULATED,
+};
+
+static struct ata_port_operations ep93xx_port_ops = {
+	.port_disable		= ata_port_disable,
+	.mode_filter		= ep93xx_mode_filter,
+
+	.tf_load		= ep93xx_tf_load,
+	.tf_read		= ep93xx_tf_read,
+
+	.exec_command		= ep93xx_exec_command,
+	.check_status 		= ep93xx_check_status,
+	.check_altstatus 	= ep93xx_check_altstatus,
+	.dev_select 		= ep93xx_dev_select,
+	.dev_check		= ep93xx_dev_check,
+
+	.phy_reset		= ep93xx_phy_reset,
+	.bus_softreset		= ep93xx_bus_softreset,
+	.set_mode		= ep93xx_set_mode,
+
+	.data_xfer		= ep93xx_data_xfer,
+
+	.qc_prep 		= ata_qc_prep,
+	.qc_issue		= ata_qc_issue_prot,
+
+	.eng_timeout		= ata_eng_timeout,
+
+	.irq_handler		= ata_interrupt,
+	.irq_ack		= ep93xx_irq_ack,
+	.irq_clear		= ep93xx_irq_clear,
+	.irq_on			= ep93xx_irq_on,
+
+	.port_start		= ata_port_start,
+	.port_stop		= ata_port_stop,
+
+	.host_stop		= ata_host_stop,
+};
+
+static void ep93xx_setup_port(struct ata_ioports *ioaddr)
+{
+	ioaddr->cmd_addr	= 0 + 2; /* CS1 */
+
+	ioaddr->data_addr	= (ATA_REG_DATA << 2) + 2;
+	ioaddr->error_addr	= (ATA_REG_ERR << 2) + 2;
+	ioaddr->feature_addr	= (ATA_REG_FEATURE << 2) + 2;
+	ioaddr->nsect_addr	= (ATA_REG_NSECT << 2) + 2;
+	ioaddr->lbal_addr	= (ATA_REG_LBAL << 2) + 2;
+	ioaddr->lbam_addr	= (ATA_REG_LBAM << 2) + 2;
+	ioaddr->lbah_addr	= (ATA_REG_LBAH << 2) + 2;
+	ioaddr->device_addr	= (ATA_REG_DEVICE << 2) + 2;
+	ioaddr->status_addr	= (ATA_REG_STATUS << 2) + 2;
+	ioaddr->command_addr	= (ATA_REG_CMD << 2) + 2;
+
+	ioaddr->altstatus_addr	= (0x06 << 2) + 1; /* CS0 */
+	ioaddr->ctl_addr	= (0x06 << 2) + 1; /* CS0 */
+}
+
+static int __devinit ep93xx_pata_probe(struct platform_device *pdev)
+{
+	struct ata_probe_ent ae;
+	int irq;
+
+	if (__raw_readl(EP93XX_SYSCON_DEVICE_CONFIG) & 0x0d00) {
+		dev_printk(KERN_INFO, &pdev->dev, "IDE/GPIO pin conflict\n");
+		return -EINVAL;
+	}
+
+	irq = platform_get_irq(pdev, 0);
+
+	pdev->dev.coherent_dma_mask = DMA_32BIT_MASK;
+
+	memset(&ae, 0, sizeof(struct ata_probe_ent));
+	INIT_LIST_HEAD(&ae.node);
+
+	ae.dev		= &pdev->dev;
+	ae.port_ops	= &ep93xx_port_ops;
+	ae.sht		= &ep93xx_sht;
+	ae.n_ports	= 1;
+	ae.pio_mask	= 0x1f;
+	ae.irq		= irq > 0 ? irq : 0;		// @@@
+	ae.irq_flags	= 0;
+	ae.port_flags	= ATA_FLAG_MMIO | ATA_FLAG_SRST;
+
+	if (!ae.irq)
+		ae.port_flags |= ATA_FLAG_PIO_POLLING;
+
+	ep93xx_setup_port(&ae.port[0]);
+
+	dev_printk(KERN_INFO, &pdev->dev, "version " DRV_VERSION "\n");
+
+	/* enable ide and set pio mode 4 */
+	// @@@ # of wait states: 3/2/2/1/1, depending on PIO mode
+	__raw_writel(PATA_CFG_IDEEN | PATA_CFG_PIO | PATA_CFG_WST(3) |
+			PATA_CFG_MODE(4), PATA_CFG);
+
+	if (ata_device_add(&ae) == 0)
+		return -ENODEV;
+
+	return 0;
+}
+
+static int __devexit ep93xx_pata_remove(struct platform_device *dev)
+{
+	struct ata_host *host = platform_get_drvdata(dev);
+
+	ata_host_remove(host);
+	platform_set_drvdata(dev, NULL);
+
+	return 0;
+}
+
+static struct platform_driver ep93xx_pata_platform_driver = {
+	.driver = {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+	.probe		= ep93xx_pata_probe,
+	.remove		= __devexit_p(ep93xx_pata_remove),
+};
+
+static struct platform_device ep93xx_pata = {
+	.name		= DRV_NAME,
+	.id		= 0,
+	.dev		= {
+		.platform_data	= NULL,
+	},
+	.num_resources	= 0,
+};
+
+static int __init ep93xx_pata_init(void)
+{
+	int err;
+
+	err = platform_driver_register(&ep93xx_pata_platform_driver);
+	if (err == 0)
+		platform_device_register(&ep93xx_pata);
+
+	return err;
+}
+
+static void __exit ep93xx_pata_exit(void)
+{
+	platform_device_unregister(&ep93xx_pata);
+	platform_driver_unregister(&ep93xx_pata_platform_driver);
+}
+
+MODULE_AUTHOR("Lennert Buytenhek <buytenh@wantstofly.org>");
+MODULE_DESCRIPTION("low-level driver for cirrus ep93xx PATA controller");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+
+module_init(ep93xx_pata_init);
+module_exit(ep93xx_pata_exit);
Index: linux-2.6.19/include/linux/libata.h
===================================================================
--- linux-2.6.19.orig/include/linux/libata.h
+++ linux-2.6.19/include/linux/libata.h
@@ -610,8 +610,10 @@ struct ata_port_operations {
 	u8   (*check_status)(struct ata_port *ap);
 	u8   (*check_altstatus)(struct ata_port *ap);
 	void (*dev_select)(struct ata_port *ap, unsigned int device);
+	unsigned int (*dev_check)(struct ata_port *ap, unsigned int device);
 
 	void (*phy_reset) (struct ata_port *ap); /* obsolete */
+	void (*bus_softreset) (struct ata_port *ap);
 	void (*set_mode) (struct ata_port *ap);
 
 	void (*post_set_mode) (struct ata_port *ap);
@@ -637,7 +639,9 @@ struct ata_port_operations {
 	void (*post_internal_cmd) (struct ata_queued_cmd *qc);
 
 	irq_handler_t irq_handler;
+	u8 (*irq_ack) (struct ata_port *);
 	void (*irq_clear) (struct ata_port *);
+	void (*irq_on) (struct ata_port *);
 
 	u32 (*scr_read) (struct ata_port *ap, unsigned int sc_reg);
 	void (*scr_write) (struct ata_port *ap, unsigned int sc_reg,
@@ -1179,7 +1183,9 @@ static inline u8 ata_irq_ack(struct ata_
 			printk(KERN_ERR "abnormal status 0x%X\n", status);
 
 	/* get controller status; clear intr, err bits */
-	if (ap->flags & ATA_FLAG_MMIO) {
+	if (ap->ops->irq_ack) {
+		post_stat = ap->ops->irq_ack(ap);
+	} else if (ap->flags & ATA_FLAG_MMIO) {
 		void __iomem *mmio = (void __iomem *) ap->ioaddr.bmdma_addr;
 		host_stat = readb(mmio + ATA_DMA_STATUS);
 		writeb(host_stat | ATA_DMA_INTR | ATA_DMA_ERR,
