From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: Some IDE issues with 2.6.28 on PC-Engines ALIX2
Date: Mon, 5 Jan 2009 17:36:17 +0100
Message-ID: <200901051736.18026.bzolnier@gmail.com>
References: <49615667.9020408@iwl.com> <4961F824.1090406@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.184]:41991 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751928AbZAEQhH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Jan 2009 11:37:07 -0500
Received: by mu-out-0910.google.com with SMTP id g7so2882268muf.1
        for <linux-ide@vger.kernel.org>; Mon, 05 Jan 2009 08:37:04 -0800 (PST)
In-Reply-To: <4961F824.1090406@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Karl Auerbach <karl@iwl.com>, linux-ide@vger.kernel.org, karl@cavebear.com, "Martin K. Petersen" <mkp@mkp.net>

On Monday 05 January 2009, Sergei Shtylyov wrote:
> Hello.
> 
> Karl Auerbach wrote:
> 
> > I've found what I believe are some problems with the IDE drivers on 
> > the 2.6.8 kernel on
> > the PC-Engines ALIX2 platform.
> >
> > There are two points in particular:
> >
> > 1. The ide_generic driver no longer finds the IDE drive (an EXT3
> > formatted compact flash on an IDE channel on an AMD CS5536 controller)
> > unless the kernel is given the ide_generic.probe_mask=0x## command
> > line parameter.  (I'll get to the values of ## later.)
> 
>    The probing behavior was changes on purpose, IIRC.

Yes, sometimes people were (by accident) using ide_generic for controllers
that have designated PCI host drivers (which offer better support/performance
and know about such things like errata workarounds).  

[ In this particular case ide_pci_generic host driver with "all_generic_ide"
  parameter may be used if BIOS programmed controller correctly. ]

> > 2. The cs5535 ide driver doesn't seem to be able to recognize the
> > newer CS5536 controller for IDE.
> 
>    No wonder, it's even impossible to determine CS5536 IDE controller's 
> device ID from the datasheet; include/linux/pci_ids.h tells me that the 
> device ID is 0x209A, so adding another ID to the 'cs5535' driver's ID 
> table shouldn't be an issue -- if they are indeed compatible. Looking at 
> the datasheets, they are not -- bad luck, we need a new driver... BTW, 
> libata seems to already have support for this chipset.

Indeed...

Karl, care to give a try to the following patch (it is completely untested
so please backup your data first if necessary)?

From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: add CS5536 host driver

This is a port of libata's pata_cs5536.c (written by Martin K. Petersen)
to IDE subsystem.


Changes done while at it:

* Reprogram PIO/MWDMA timings if needed before and after DMA transfer
  (chipset uses shared PIO/MWDMA timings).

* Fix cable detection to report 80-wires cable if BIOS set it for any
  device on a port (IDE core will do drive-side cable detection later).

* Don't disable UDMA while programming PIO timings.

* Simplify PCI/MSR support.


Pros of having IDE host driver in addition to libata's one:

* CS5536 is used in embedded applications and IDE is much lighter
  than SCSI+libata, the host driver itself is also a bit smaller:

   text    data     bss     dec     hex filename
   1237     500       4    1741     6cd drivers/ata/pata_cs5536.o
   1164     132       4    1300     514 drivers/ide/cs5536.o

* CS5536 is used mostly for driving CF cards and this allows use of
  IDE features which are unavailable under libata (32-bit I/O support,
  non-rotational media optimizations, etc).


Cc: Martin K. Petersen <mkp@mkp.net>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Cc: Karl Auerbach <karl@iwl.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/Kconfig  |   10 +
 drivers/ide/Makefile |    1 
 drivers/ide/cs5536.c |  303 +++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 314 insertions(+)

Index: b/drivers/ide/Kconfig
===================================================================
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -465,6 +465,16 @@ config BLK_DEV_CS5535
 
 	  It is safe to say Y to this question.
 
+config BLK_DEV_CS5536
+	tristate "CS5536 chipset support"
+	depends on X86 && !X86_64
+	select BLK_DEV_IDEDMA_PCI
+	help
+	  This option enables support for the AMD CS5536
+	  companion chip used with the Geode LX processor family.
+
+	  If unsure, say N.
+
 config BLK_DEV_HPT366
 	tristate "HPT36X/37X chipset support"
 	select BLK_DEV_IDEDMA_PCI
Index: b/drivers/ide/Makefile
===================================================================
--- a/drivers/ide/Makefile
+++ b/drivers/ide/Makefile
@@ -43,6 +43,7 @@ obj-$(CONFIG_BLK_DEV_CMD64X)		+= cmd64x.
 obj-$(CONFIG_BLK_DEV_CS5520)		+= cs5520.o
 obj-$(CONFIG_BLK_DEV_CS5530)		+= cs5530.o
 obj-$(CONFIG_BLK_DEV_CS5535)		+= cs5535.o
+obj-$(CONFIG_BLK_DEV_CS5536)		+= cs5536.o
 obj-$(CONFIG_BLK_DEV_SC1200)		+= sc1200.o
 obj-$(CONFIG_BLK_DEV_CY82C693)		+= cy82c693.o
 obj-$(CONFIG_BLK_DEV_DELKIN)		+= delkin_cb.o
Index: b/drivers/ide/cs5536.c
===================================================================
--- /dev/null
+++ b/drivers/ide/cs5536.c
@@ -0,0 +1,303 @@
+/*
+ * CS5536 PATA support
+ * (C) 2007 Martin K. Petersen <mkp@mkp.net>
+ * (C) 2009 Bartlomiej Zolnierkiewicz
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ *
+ * Documentation:
+ *	Available from AMD web site.
+ *
+ * The IDE timing registers for the CS5536 live in the Geode Machine
+ * Specific Register file and not PCI config space.  Most BIOSes
+ * virtualize the PCI registers so the chip looks like a standard IDE
+ * controller.  Unfortunately not all implementations get this right.
+ * In particular some have problems with unaligned accesses to the
+ * virtualized PCI registers.  This driver always does full dword
+ * writes to work around the issue.  Also, in case of a bad BIOS this
+ * driver can be loaded with the "msr=1" parameter which forces using
+ * the Machine Specific Registers to configure the device.
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/ide.h>
+#include <asm/msr.h>
+
+#define DRV_NAME	"cs5536"
+
+enum {
+	MSR_IDE_CFG		= 0x51300010,
+	PCI_IDE_CFG		= 0x40,
+
+	CFG			= 0,
+	DTC			= 2,
+	CAST			= 3,
+	ETC			= 4,
+
+	IDE_CFG_CHANEN		= (1 << 1),
+	IDE_CFG_CABLE		= (1 << 17) | (1 << 16),
+
+	IDE_D0_SHIFT		= 24,
+	IDE_D1_SHIFT		= 16,
+	IDE_DRV_MASK		= 0xff,
+
+	IDE_CAST_D0_SHIFT	= 6,
+	IDE_CAST_D1_SHIFT	= 4,
+	IDE_CAST_DRV_MASK	= 0x3,
+
+	IDE_CAST_CMD_SHIFT	= 24,
+	IDE_CAST_CMD_MASK	= 0xff,
+};
+
+static int use_msr;
+
+static int cs5536_read(struct pci_dev *pdev, int reg, u32 *val)
+{
+	if (unlikely(use_msr)) {
+		u32 dummy;
+
+		rdmsr(MSR_IDE_CFG + reg, *val, dummy);
+		return 0;
+	}
+
+	return pci_read_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
+}
+
+static int cs5536_write(struct pci_dev *pdev, int reg, int val)
+{
+	if (unlikely(use_msr)) {
+		wrmsr(MSR_IDE_CFG + reg, val, 0);
+		return 0;
+	}
+
+	return pci_write_config_dword(pdev, PCI_IDE_CFG + reg * 4, val);
+}
+
+static void cs5536_program_dtc(ide_drive_t *drive, u8 tim)
+{
+	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
+	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+	u32 dtc;
+
+	cs5536_read(pdev, DTC, &dtc);
+	dtc &= ~(IDE_DRV_MASK << dshift);
+	dtc |= tim << dshift;
+	cs5536_write(pdev, DTC, dtc);
+}
+
+/**
+ *	cs5536_cable_detect	-	detect cable type
+ *	@hwif: Port to detect on
+ *
+ *	Perform cable detection for ATA66 capable cable.
+ *
+ *	Returns a cable type.
+ */
+
+static u8 cs5536_cable_detect(ide_hwif_t *hwif)
+{
+	struct pci_dev *pdev = to_pci_dev(hwif->dev);
+	u32 cfg;
+
+	cs5536_read(pdev, CFG, &cfg);
+
+	if (cfg & IDE_CFG_CABLE)
+		return ATA_CBL_PATA80;
+	else
+		return ATA_CBL_PATA40;
+}
+
+/**
+ *	cs5536_set_pio_mode		-	PIO timing setup
+ *	@drive: ATA device
+ *	@pio: PIO mode number
+ */
+
+static void cs5536_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	static const u8 drv_timings[5] = {
+		0x98, 0x55, 0x32, 0x21, 0x20,
+	};
+
+	static const u8 addr_timings[5] = {
+		0x2, 0x1, 0x0, 0x0, 0x0,
+	};
+
+	static const u8 cmd_timings[5] = {
+		0x99, 0x92, 0x90, 0x22, 0x20,
+	};
+
+	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
+	ide_drive_t *pair = ide_get_pair_dev(drive);
+	int cshift = (drive->dn & 1) ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
+	u32 cast;
+	u8 cmd_pio = pio;
+
+	if (pair)
+		cmd_pio = min(pio, ide_get_best_pio_mode(pair, 255, 4));
+
+	drive->drive_data &= 0xff00;
+	drive->drive_data |= drv_timings[pio];
+
+	cs5536_program_dtc(drive, drv_timings[pio]);
+
+	cs5536_read(pdev, CAST, &cast);
+
+	cast &= ~(IDE_CAST_DRV_MASK << cshift);
+	cast |= addr_timings[pio] << cshift;
+
+	cast &= ~(IDE_CAST_CMD_MASK << IDE_CAST_CMD_SHIFT);
+	cast |= cmd_timings[cmd_pio] << IDE_CAST_CMD_SHIFT;
+
+	cs5536_write(pdev, CAST, cast);
+}
+
+/**
+ *	cs5536_set_dma_mode		-	DMA timing setup
+ *	@drive: ATA device
+ *	@mode: DMA mode
+ */
+
+static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
+{
+	static const u8 udma_timings[6] = {
+		0xc2, 0xc1, 0xc0, 0xc4, 0xc5, 0xc6,
+	};
+
+	static const u8 mwdma_timings[3] = {
+		0x67, 0x21, 0x20,
+	};
+
+	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
+	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+	u32 etc;
+
+	if (mode >= XFER_UDMA_0) {
+		cs5536_read(pdev, ETC, &etc);
+
+		etc &= ~(IDE_DRV_MASK << dshift);
+		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
+
+		cs5536_write(pdev, ETC, etc);
+	} else { /* MWDMA */
+		drive->drive_data &= 0xff;
+		drive->drive_data |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
+	}
+}
+
+static void cs5536_dma_start(ide_drive_t *drive)
+{
+	if (drive->current_speed < XFER_UDMA_0)
+		cs5536_program_dtc(drive, drive->drive_data >> 8);
+
+	ide_dma_start(drive);
+}
+
+static int cs5536_dma_end(ide_drive_t *drive)
+{
+	int ret = ide_dma_end(drive);
+
+	if (drive->current_speed < XFER_UDMA_0)
+		cs5536_program_dtc(drive, drive->drive_data & 0xff);
+
+	return ret;
+}
+
+static const struct ide_port_ops cs5536_port_ops = {
+	.set_pio_mode		= cs5536_set_pio_mode,
+	.set_dma_mode		= cs5536_set_dma_mode,
+	.cable_detect		= cs5536_cable_detect,
+};
+
+static const struct ide_dma_ops cs5536_dma_ops = {
+	.dma_host_set		= ide_dma_host_set,
+	.dma_setup		= ide_dma_setup,
+	.dma_exec_cmd		= ide_dma_exec_cmd,
+	.dma_start		= cs5536_dma_start,
+	.dma_end		= cs5536_dma_end,
+	.dma_test_irq		= ide_dma_test_irq,
+	.dma_lost_irq		= ide_dma_lost_irq,
+	.dma_timeout		= ide_dma_timeout,
+};
+
+static const struct ide_port_info cs5536_info = {
+	.name		= DRV_NAME,
+	.port_ops	= &cs5536_port_ops,
+	.dma_ops	= &cs5536_dma_ops,
+	.host_flags	= IDE_HFLAG_SINGLE,
+	.pio_mask	= ATA_PIO4,
+	.mwdma_mask	= ATA_MWDMA2,
+	.udma_mask	= ATA_UDMA5,
+};
+
+/**
+ *	cs5536_init_one
+ *	@dev: PCI device
+ *	@id: Entry in match table
+ */
+
+static int cs5536_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	u32 cfg;
+
+	if (use_msr)
+		printk(KERN_ERR DRV_NAME ": Using MSR regs instead of PCI\n");
+
+	cs5536_read(dev, CFG, &cfg);
+
+	if ((cfg & IDE_CFG_CHANEN) == 0) {
+		printk(KERN_ERR DRV_NAME ": disabled by BIOS\n");
+		return -ENODEV;
+	}
+
+	return ide_pci_init_one(dev, &cs5536_info, NULL);
+}
+
+static const struct pci_device_id cs5536_pci_tbl[] = {
+	{ PCI_VDEVICE(AMD, PCI_DEVICE_ID_AMD_CS5536_IDE), },
+	{ },
+};
+
+static struct pci_driver cs5536_pci_driver = {
+	.name		= DRV_NAME,
+	.id_table	= cs5536_pci_tbl,
+	.probe		= cs5536_init_one,
+	.remove		= ide_pci_remove,
+	.suspend	= ide_pci_suspend,
+	.resume		= ide_pci_resume,
+};
+
+static int __init cs5536_init(void)
+{
+	return pci_register_driver(&cs5536_pci_driver);
+}
+
+static void __exit cs5536_exit(void)
+{
+	pci_unregister_driver(&cs5536_pci_driver);
+}
+
+MODULE_AUTHOR("Martin K. Petersen, Bartlomiej Zolnierkiewicz");
+MODULE_DESCRIPTION("low-level driver for the CS5536 IDE controller");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, cs5536_pci_tbl);
+
+module_param_named(msr, use_msr, int, 0644);
+MODULE_PARM_DESC(msr, "Force using MSR to configure IDE function (Default: 0)");
+
+module_init(cs5536_init);
+module_exit(cs5536_exit);
