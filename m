From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH/RFC] Port of pdc202xx_new driver to libata
Date: Wed, 13 Oct 2004 18:06:19 +0800
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <00bb01c4b10c$4b2ab330$7301a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:15344 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S269660AbUJMKGm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 Oct 2004 06:06:42 -0400
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>, bzolnier@gmail.com
Cc: IDE Linux <linux-ide@vger.kernel.org>

Hi, Jeff and Bart:

  I am trying to port the Promise pdc202xx_new driver to libata and adding
the
PLL tuning code to it. (The motivation is hotplug of the Promise host
adapter.)

The ported driver has been tested with pdc20269 and pdc20275 on i386 and
x86_64 boxes, with 33 MHz PCI bus and 66 MHz PCI bus respectively.
It seems to be working fine with harddisk drives.
(However, CD-ROM drives not working yet, even when
ATA_ENABLE_PATA and ATA_ENABLE_ATAPI are enabled.)

My question is, in the current kernel, the IDE subsystem drives PATA chips
and libata drives SATA chips. Will PATA driver like this be accepted into
libata?

Thanks,

Albert Lee
(The patch is against 2.6.8.1.)
********************************************************************
diff -Nru linux-2.6.8.1/drivers/scsi/Kconfig
linux-2.6.8.1-mod/drivers/scsi/Kconfig
--- linux-2.6.8.1/drivers/scsi/Kconfig 2004-08-14 18:56:14.000000000 +0800
+++ linux-2.6.8.1-mod/drivers/scsi/Kconfig 2004-10-13 15:38:23.000000000
+0800
@@ -441,6 +441,14 @@

    If unsure, say N.

+config SCSI_PATA_PDC_NEW
+ tristate "Promise PATA 202xx new support"
+ depends on SCSI_SATA && PCI
+ help
+   This option enables support for Promise PATA pdc20268 to pdc20277  Host
Adapters.
+
+   If unsure, say N.
+
 config SCSI_SATA_PROMISE
  tristate "Promise SATA TX2/TX4 support"
  depends on SCSI_SATA && PCI
diff -Nru linux-2.6.8.1/drivers/scsi/Makefile
linux-2.6.8.1-mod/drivers/scsi/Makefile
--- linux-2.6.8.1/drivers/scsi/Makefile 2004-08-14 18:55:59.000000000 +0800
+++ linux-2.6.8.1-mod/drivers/scsi/Makefile 2004-10-13 15:38:26.000000000
+0800
@@ -121,6 +121,7 @@
 obj-$(CONFIG_SCSI_IPR)  += ipr.o
 obj-$(CONFIG_SCSI_SATA_SVW) += libata.o sata_svw.o
 obj-$(CONFIG_SCSI_ATA_PIIX) += libata.o ata_piix.o
+obj-$(CONFIG_SCSI_PATA_PDC_NEW) += libata.o pata_pdc202xx_new.o
 obj-$(CONFIG_SCSI_SATA_PROMISE) += libata.o sata_promise.o
 obj-$(CONFIG_SCSI_SATA_SIL) += libata.o sata_sil.o
 obj-$(CONFIG_SCSI_SATA_VIA) += libata.o sata_via.o
diff -Nru linux-2.6.8.1/drivers/scsi/pata_pdc202xx_new.c
linux-2.6.8.1-mod/drivers/scsi/pata_pdc202xx_new.c
--- linux-2.6.8.1/drivers/scsi/pata_pdc202xx_new.c 1970-01-01
08:00:00.000000000 +0800
+++ linux-2.6.8.1-mod/drivers/scsi/pata_pdc202xx_new.c 2004-10-13
16:52:11.000000000 +0800
@@ -0,0 +1,721 @@
+/*
+ *  Promise PATA TX2/TX4/TX2000/133 IDE driver for pdc20268 to pdc20277.
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ *
+ *  Ported to libata by:
+ *  Albert Lee <albertcc@tw.ibm.com> IBM Corporation
+ *
+ *  Copyright (C) 1998-2002  Andre Hedrick <andre@linux-ide.org>
+ *  Portions Copyright (C) 1999 Promise Technology, Inc.
+ *
+ *  Author: Frank Tiernan (frankt@promise.com)
+ *  Released under terms of General Public License
+ *
+ *
+ */
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/init.h>
+#include <linux/blkdev.h>
+#include <linux/delay.h>
+#include "scsi.h"
+#include <scsi/scsi_host.h>
+#include <linux/libata.h>
+#include <asm/io.h>
+
+#define DRV_NAME "pata_pdc202xx_new"
+#define DRV_VERSION "0.50"
+#undef PDC_DEBUG
+
+#ifdef PDC_DEBUG
+#define PDPRINTK(fmt, args...) printk(KERN_DEBUG "%s: " fmt, __FUNCTION__,
## args)
+#else
+#define PDPRINTK(fmt, args...)
+#endif
+
+enum {
+ PDC_UDMA_100        = 0,
+ PDC_UDMA_133        = 1,
+
+ PDC_100_MHZ         = 100000000,
+ PDC_133_MHZ         = 133333333,
+};
+
+static int pdc_new_init_one(struct pci_dev *pdev, const struct
pci_device_id *ent);
+static void pdc_new_remove_one(struct pci_dev *pdev);
+static void pdc_new_phy_reset(struct ata_port *ap);
+static void pdc_new_set_piomode(struct ata_port *ap, struct ata_device
*adev, unsigned int pio);
+static void pdc_new_set_udmamode(struct ata_port *ap, struct ata_device
*adev, unsigned int udma);
+
+static struct pdc_pata_ide_controller {
+ char* chip_name;
+ int max_udma_mode;
+ long pll_pout_required;
+} pdc_pata_controller_tbl [] = {
+ { "Ultra100 TX2",        PDC_UDMA_100, PDC_100_MHZ }, /* pdc20268 */
+ { "Ultra133 TX2",        PDC_UDMA_133, PDC_133_MHZ }, /* pdc20269 */
+ { "FastTrak LP/TX2/TX4", PDC_UDMA_100, PDC_100_MHZ }, /* pdc20270 */
+ { "FastTrak TX2000",     PDC_UDMA_133, PDC_133_MHZ }, /* pdc20271 */
+ { "MBUltra133",          PDC_UDMA_133, PDC_133_MHZ }, /* pdc20275 */
+ { "MBFastTrak 133 Lite", PDC_UDMA_133, PDC_133_MHZ }, /* pdc20276 */
+ { "SBFastTrak 133 Lite", PDC_UDMA_133, PDC_133_MHZ }, /* pdc20277 */
+};
+
+static struct pci_device_id pdc_new_pci_tbl[] = {
+#ifdef ATA_ENABLE_PATA
+ { PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20268, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 0 },
+ { PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20269, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 1 },
+ { PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20270, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 2 },
+ { PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20271, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 3 },
+ { PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20275, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 4 },
+ { PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20276, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 5 },
+ { PCI_VENDOR_ID_PROMISE, PCI_DEVICE_ID_PROMISE_20277, PCI_ANY_ID,
PCI_ANY_ID, 0, 0, 6 },
+#endif
+ { } /* terminate list */
+};
+
+static struct pci_driver pdc_new_pci_driver = {
+ .name   = DRV_NAME,
+ .id_table  = pdc_new_pci_tbl,
+ .probe   = pdc_new_init_one,
+ .remove   = __devexit_p(pdc_new_remove_one),
+};
+
+static Scsi_Host_Template pdc_new_sht = {
+ .module   = THIS_MODULE,
+ .name   = DRV_NAME,
+ .queuecommand  = ata_scsi_queuecmd,
+ .eh_strategy_handler = ata_scsi_error,
+ .can_queue  = ATA_DEF_QUEUE,
+ .this_id  = ATA_SHT_THIS_ID,
+ .sg_tablesize  = LIBATA_MAX_PRD,
+ .max_sectors  = ATA_MAX_SECTORS,
+ .cmd_per_lun  = ATA_SHT_CMD_PER_LUN,
+ .emulated  = ATA_SHT_EMULATED,
+ .use_clustering  = ATA_SHT_USE_CLUSTERING,
+ .proc_name  = DRV_NAME,
+ .dma_boundary  = ATA_DMA_BOUNDARY,
+ .slave_configure = ata_scsi_slave_config,
+ .bios_param  = ata_std_bios_param,
+};
+
+static struct ata_port_operations pdc_new_pata_ops = {
+ .port_disable  = ata_port_disable,
+ .set_piomode  = pdc_new_set_piomode,
+ .set_udmamode  = pdc_new_set_udmamode,
+
+ .tf_load  = ata_tf_load_pio,
+ .tf_read  = ata_tf_read_pio,
+ .exec_command  = ata_exec_command_pio,
+ .check_status  = ata_check_status_pio,
+
+ .phy_reset  = pdc_new_phy_reset,
+
+ .bmdma_setup            = ata_bmdma_setup_pio,
+ .bmdma_start            = ata_bmdma_start_pio,
+ //.fill_sg  = ata_fill_sg,
+ .qc_prep  = ata_qc_prep,
+ .qc_issue  = ata_qc_issue_prot,
+ .eng_timeout  = ata_eng_timeout,
+
+ .irq_handler  = ata_interrupt,
+ .irq_clear              = ata_bmdma_irq_clear,
+
+ .port_start  = ata_port_start,
+ .port_stop  = ata_port_stop,
+};
+
+static struct ata_port_info pdc_new_port_info[] = {
+ /* PDC_UDMA_100 */
+ {
+  .sht  = &pdc_new_sht,
+  .host_flags = ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
+                    ATA_FLAG_SRST, /* | ATA_FLAG_MMIO, */
+  .pio_mask = 0x03, /* pio3-4 */
+  .udma_mask = ATA_UDMA5,
+  .port_ops = &pdc_new_pata_ops,
+ },
+ /* PDC_UDMA_133 */
+ {
+  .sht  = &pdc_new_sht,
+  .host_flags = ATA_FLAG_NO_LEGACY | ATA_FLAG_SLAVE_POSS |
+                           ATA_FLAG_SRST,
+  .pio_mask = 0x03, /* pio3-4 */
+  .udma_mask = ATA_UDMA6,
+  .port_ops = &pdc_new_pata_ops,
+ },
+};
+
+MODULE_AUTHOR("Andre Hedrick, Frank Tiernan, Albert Lee");
+MODULE_DESCRIPTION("libata driver module for Promise PDC20268 to
PDC20277");
+MODULE_LICENSE("GPL");
+MODULE_DEVICE_TABLE(pci, pdc_new_pci_tbl);
+
+/**
+ * pdc_get_indexed_reg - Set pdc202xx extended register
+ * @ap: Port to which the extended register is set
+ * @index: index of the extended register
+ */
+static u8 pdc_get_indexed_reg(struct ata_port *ap, u8 index)
+{
+ u8 tmp8;
+
+ outb(index, ap->ioaddr.bmdma_addr + 1);
+ tmp8 = inb(ap->ioaddr.bmdma_addr + 3);
+
+ PDPRINTK("Get index reg%X[%X] \n", index, tmp8);
+ return tmp8;
+}
+/**
+ * pdc_set_indexed_reg - Read pdc202xx extended register
+ * @ap: Port to which the extended register is read
+ * @index: index of the extended register
+ */
+static void pdc_set_indexed_reg(struct ata_port *ap, u8 index, u8 value)
+{
+ outb(index, ap->ioaddr.bmdma_addr + 1);
+ outb(value, ap->ioaddr.bmdma_addr + 3);
+ PDPRINTK("Set index reg%X[%X] \n", index, value);
+}
+/**
+ * pdc_set_pio - Set the PIO extended registers
+ * @ap: Port to which the extended register is set
+ * @adev: Device to set
+ * @value0: value for extended register at 0x0c
+ * @value1: value for extended register at 0x0d
+ * @value2: value for extended register at 0x13
+ */
+static void pdc_set_pio(struct ata_port *ap, struct ata_device *adev, u8
value0, u8 value1, u8 value2)
+{
+ unsigned int drive_dn = (ap->port_no ? 2 : 0) + adev->devno;
+ u8 adj   = (drive_dn%2) ? 0x08 : 0x00;
+
+ PDPRINTK("Set pio regs... \n");
+
+ pdc_set_indexed_reg(ap, 0x0c + adj, value0);
+ pdc_set_indexed_reg(ap, 0x0d + adj, value1);
+ pdc_set_indexed_reg(ap, 0x13 + adj, value2);
+
+ PDPRINTK("Set pio regs done\n");
+}
+/**
+ * pdc_set_ultra - Set the UDMA extended registers
+ * @ap: Port to which the extended register is set
+ * @adev: Device to set
+ * @value0: value for extended register at 0x10
+ * @value1: value for extended register at 0x11
+ * @value2: value for extended register at 0x12
+ */
+static void pdc_set_ultra(struct ata_port *ap, struct ata_device *adev, u8
value0, u8 value1, u8 value2)
+{
+ unsigned int drive_dn = (ap->port_no ? 2 : 0) + adev->devno;
+ u8 adj   = (drive_dn%2) ? 0x08 : 0x00;
+
+ PDPRINTK("Set udma regs... \n");
+ pdc_set_indexed_reg(ap, 0x10 + adj, value0);
+ pdc_set_indexed_reg(ap, 0x11 + adj, value1);
+ pdc_set_indexed_reg(ap, 0x12 + adj, value2);
+
+ PDPRINTK("Set udma regs done\n");
+}
+/**
+ * pdc_new_pata_cbl_detect - Probe host controller cable detect info
+ * @ap: Port for which cable detect info is desired
+ *
+ * Read 80c cable indicator from Promise extended  register.
+ *      This register is normally set by firmware.
+ *
+ * LOCKING:
+ * None (inherited from caller).
+ */
+static void pdc_new_cbl_detect(struct ata_port *ap)
+{
+ u8 cbl40c;
+
+ /* For UDMA33, no 80c support is required */
+ if ((ap->udma_mask & ~ATA_UDMA_MASK_40C) == 0)
+  goto cbl40;
+
+ /* check cable detect results */
+ cbl40c = pdc_get_indexed_reg(ap, 0x0b) & 0x04;
+
+ if (cbl40c)
+  goto cbl40;
+
+ PDPRINTK("No cable or 80-conductor cable on port %d\n", ap->port_no);
+
+ ap->cbl = ATA_CBL_PATA80;
+ return;
+
+cbl40:
+ printk(KERN_INFO DRV_NAME ": 40-conductor cable detected on port %d\n",
ap->port_no);
+ ap->cbl = ATA_CBL_PATA40;
+ ap->udma_mask &= ATA_UDMA_MASK_40C;
+}
+/**
+ * pdc_new_port_enabled - Check extended register at 0x04 to see whether
the port is enabled.
+ * @ap: Port to check
+ */
+static inline int pdc_new_port_enabled(struct ata_port *ap)
+{
+ return pdc_get_indexed_reg(ap, 0x04) & 0x02;
+}
+/**
+ * pdc_new_phy_reset - Probe specified port on PATA host controller
+ * @ap: Port to probe
+ *
+ * Probe PATA phy.
+ *
+ * LOCKING:
+ * None (inherited from caller).
+ */
+static void pdc_new_phy_reset(struct ata_port *ap)
+{
+ /* Check whether port enabled */
+ if (!pdc_new_port_enabled(ap)) {
+  ata_port_disable(ap);
+  printk(KERN_INFO "ata%u: port disabled. ignoring.\n", ap->id);
+  return;
+ }
+
+ pdc_new_cbl_detect(ap);
+ ata_port_probe(ap);
+ ata_bus_reset(ap);
+}
+/**
+ * pdc_new_set_piomode - Initialize host controller PATA PIO timings
+ * @ap: Port to configure
+ * @adev: um
+ * @pio: PIO mode, 0 - 4
+ *
+ * Set PIO mode for device.
+ *
+ * LOCKING:
+ * None (inherited from caller).
+ */
+static void pdc_new_set_piomode(struct ata_port *ap, struct ata_device
*adev, unsigned int pio)
+{
+ unsigned int drive_dn = (ap->port_no ? 2 : 0) + adev->devno;
+ u8 adj        = (drive_dn%2) ? 0x08 : 0x00;
+ u8 tmp8;
+
+ switch (pio | 0x08) {
+         case XFER_PIO_4:
+   pdc_set_pio(ap, adev, 0x23, 0x09, 0x25); /* IORDY on, Prefetch off */
+   break;
+  case XFER_PIO_3:
+   pdc_set_pio(ap, adev, 0x27, 0x0d, 0x35); /* IORDY on, Prefetch off */
+   break;
+  //case XFER_PIO_2: pdc_set_pio(ap, adev, 0x23, 0x26, 0x64); break;
+  //case XFER_PIO_1: pdc_set_pio(ap, adev, 0x46, 0x29, 0xa4); break;
+  //case XFER_PIO_0: pdc_set_pio(ap, adev, 0xfb, 0x2b, 0xac); break;
+  default:
+   printk(KERN_ERR DRV_NAME ": Unknown pio mode [%d] ignored\n", pio);
+   return;
+ }
+
+ /*
+  *  Check whether the device supports turning off IORDY.
+  * For PIO3 and above, the device must support IORDY and set bit 10
+  */
+ if (adev->id[49] & 0x400) {
+  /* IORDY_EN & PREFETCH_EN */
+  /* Turn on Prefetch */
+  tmp8 = pdc_get_indexed_reg(ap, 0x13 + adj);
+  pdc_set_indexed_reg(ap, 0x13 + adj, tmp8 | 0x03);
+
+  PDPRINTK("Turn on prefetch\n");
+ }
+
+ printk(KERN_INFO DRV_NAME ": Set to pio mode[%u] \n", pio);
+}
+/**
+ * pdc_new_set_udmamode - Initialize host controller PATA UDMA timings
+ * @ap: Port to configure
+ * @adev: um
+ * @udma: udma mode, XFER_UDMA_0 to XFER_UDMA_6
+ *
+ * Set UDMA mode for device.
+ *
+ * LOCKING:
+ * None (inherited from caller).
+ */
+static void pdc_new_set_udmamode(struct ata_port *ap, struct ata_device
*adev, unsigned int udma)
+{
+ unsigned int drive_dn = (ap->port_no ? 2 : 0) + adev->devno;
+
+ u8 adj   = (drive_dn%2) ? 0x08 : 0x00;
+ u8 tmp8;
+
+ if (udma == XFER_UDMA_2) {
+  /*
+   * Turn off tHOLD.
+   * If tHOLD is '1', the hardware will add half clock for data hold time.
+   * This code segment seems to be no effect. tHOLD will be overwritten
below.
+   */
+  tmp8 = pdc_get_indexed_reg(ap, 0x10 + adj);
+  pdc_set_indexed_reg(ap, 0x10 + adj, tmp8 & 0x7f);
+ }
+
+ switch (udma) {
+  case XFER_UDMA_7:
+   udma = XFER_UDMA_6;
+  case XFER_UDMA_6: pdc_set_ultra(ap, adev, 0x1a, 0x01, 0xcb); break;
+  case XFER_UDMA_5: pdc_set_ultra(ap, adev, 0x1a, 0x02, 0xcb); break;
+  case XFER_UDMA_4: pdc_set_ultra(ap, adev, 0x1a, 0x03, 0xcd); break;
+  case XFER_UDMA_3: pdc_set_ultra(ap, adev, 0x1a, 0x05, 0xcd); break;
+  case XFER_UDMA_2: pdc_set_ultra(ap, adev, 0x2a, 0x07, 0xcd); break;
+  case XFER_UDMA_1: pdc_set_ultra(ap, adev, 0x3a, 0x0a, 0xd0); break;
+  case XFER_UDMA_0: pdc_set_ultra(ap, adev, 0x4a, 0x0f, 0xd5); break;
+  default:
+   printk(KERN_ERR DRV_NAME ": Unknown udma mode [%u] ignored\n", udma &
0x07);
+   return;
+ }
+
+ printk(KERN_INFO DRV_NAME ": Set to udma mode[%u] \n", udma & 0x07);
+}
+/**
+ * adjust_pll - Adjust the PLL input clock in Hz.
+ *
+ * @pdc_controller: controller specific information
+ * @probe_ent: For the port address
+ * @pll_clock: The input of PLL in HZ
+ */
+static void adjust_pll(struct pdc_pata_ide_controller* pdc_controller,
struct ata_probe_ent *probe_ent, long pll_clock)
+{
+
+ u8 pll_ctl0, pll_ctl1;
+ long pll_clock_khz = pll_clock / 1000;
+ long pout_required = pdc_controller->pll_pout_required;
+ long ratio = pout_required / pll_clock_khz;
+ int F, R;
+
+ /* Sanity check */
+ if (unlikely(pll_clock_khz < 5000L || pll_clock_khz > 70000L)) {
+  printk(KERN_ERR DRV_NAME ": Invalid PLL input clock %ldkHz, give up!\n",
pll_clock_khz);
+  return;
+ }
+
+#ifdef PDC_DEBUG
+ /* Show the current clock value of PLL control register
+  * (maybe already configured by the firmware)
+  */
+ outb(0x02, probe_ent->port[1].bmdma_addr + 0x01);
+ pll_ctl0 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+ outb(0x03, probe_ent->port[1].bmdma_addr + 0x01);
+ pll_ctl1 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+
+ printk(KERN_DEBUG DRV_NAME ": pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+#endif
+
+ /*
+  * Calculate the ratio of F, R and OD
+  * POUT = (F + 2) / (( R + 2) * NO)
+  */
+ if (ratio < 8600L) { // 8.6x
+  /* Using NO = 0x01, R = 0x0D */
+  R = 0x0d;
+ } else if (ratio < 12900L) { // 12.9x
+  /* Using NO = 0x01, R = 0x08 */
+  R = 0x08;
+ } else if (ratio < 16100L) { // 16.1x
+  /* Using NO = 0x01, R = 0x06 */
+  R = 0x06;
+ } else if (ratio < 64000L) { // 64x
+  R = 0x00;
+ } else {
+  /* Invalid ratio */
+  printk(KERN_ERR DRV_NAME ": Invalid ratio %ld, give up!\n", ratio);
+  return;
+ }
+
+ F = (ratio * (R+2)) / 1000 - 2;
+
+ if (unlikely(F < 0 || F > 127)) {
+  /* Invalid F */
+  printk(KERN_ERR DRV_NAME ": F[%d] invalid!\n", F);
+  return;
+ }
+
+ PDPRINTK("F[%d] R[%d] ratio*1000[%ld]\n", F, R, ratio);
+
+ pll_ctl0 = (u8) F;
+ pll_ctl1 = (u8) R;
+
+ PDPRINTK("Writing pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+
+ outb(0x02,     probe_ent->port[1].bmdma_addr + 0x01);
+ outb(pll_ctl0, probe_ent->port[1].bmdma_addr + 0x03);
+ outb(0x03,     probe_ent->port[1].bmdma_addr + 0x01);
+ outb(pll_ctl1, probe_ent->port[1].bmdma_addr + 0x03);
+
+ /* Wait the PLL circuit to be stable */
+ mdelay(30);
+
+#ifdef PDC_DEBUG
+ /*
+  *  Show the current clock value of PLL control register
+  * (maybe configured by the firmware)
+  */
+ outb(0x02, probe_ent->port[1].bmdma_addr + 0x01);
+ pll_ctl0 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+ outb(0x03, probe_ent->port[1].bmdma_addr + 0x01);
+ pll_ctl1 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+
+ printk(KERN_DEBUG DRV_NAME ": pll_ctl[%X][%X]\n", pll_ctl0, pll_ctl1);
+#endif
+
+ return;
+}
+/**
+ * detect_pll_input_clock - Detect the PLL input clock in Hz.
+ * @probe_ent: for the port address
+ * Ex. 16949000 on 33MHz PCI bus for pdc20275.
+ *     Half of the PCI clock.
+ */
+static long detect_pll_input_clock(struct ata_probe_ent *probe_ent)
+{
+ u8 scr1;
+ unsigned long ctr0;
+ unsigned long ctr1;
+ unsigned long ctr2 = 0;
+ unsigned long ctr3 = 0;
+
+ unsigned long start_count, end_count;
+ long pll_clock;
+
+ /* Read current counter value */
+ outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);
+ ctr0 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+ outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);
+ ctr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+
+ outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);
+ ctr2 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+ outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);
+ ctr3 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+
+ start_count = (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
+
+ PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, ctr2,
ctr3);
+
+ /* Start the test mode */
+ outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);
+ scr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+ PDPRINTK("scr1[%X]\n", scr1);
+ outb(scr1 | 0x40, probe_ent->port[0].bmdma_addr + 0x03);
+
+ /* Let the counter run for 1000 us. */
+ udelay(1000);
+
+ /* Read the counter values again */
+ outb(0x20, probe_ent->port[0].bmdma_addr + 0x01);
+ ctr0 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+ outb(0x21, probe_ent->port[0].bmdma_addr + 0x01);
+ ctr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+
+ outb(0x20, probe_ent->port[1].bmdma_addr + 0x01);
+ ctr2 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+ outb(0x21, probe_ent->port[1].bmdma_addr + 0x01);
+ ctr3 = inb(probe_ent->port[1].bmdma_addr + 0x03);
+
+ end_count = (ctr3 << 23 ) | (ctr2 << 15) | (ctr1 << 8) | ctr0;
+
+ PDPRINTK("ctr0[%lX] ctr1[%lX] ctr2 [%lX] ctr3 [%lX]\n", ctr0, ctr1, ctr2,
ctr3);
+
+ /* Stop the test mode */
+ outb(0x01, probe_ent->port[0].bmdma_addr + 0x01);
+ scr1 = inb(probe_ent->port[0].bmdma_addr + 0x03);
+ PDPRINTK("scr1[%X]\n", scr1);
+ outb(scr1 & 0xBF, probe_ent->port[0].bmdma_addr + 0x03);
+
+ /* calculate the input clock in Hz */
+ pll_clock = (long) ((start_count - end_count) * 1000);
+
+ PDPRINTK("start[%lu] end[%lu] \n", start_count, end_count);
+ PDPRINTK("PLL input clock[%ld]Hz\n", pll_clock);
+
+ return pll_clock;
+}
+/**
+ * pdc_hardware_init - Initialize the hardware.
+ * @pdev: instance of pci_dev found
+ * @pdc_controller: controller specific information
+ * @pe:  for the port address
+ */
+static int pdc_hardware_init(struct pci_dev *pdev, struct
pdc_pata_ide_controller* pdc_controller, struct ata_probe_ent *pe)
+{
+ long pll_clock;
+
+ /* Enable the ROM */
+ if (pdev->resource[PCI_ROM_RESOURCE].start) {
+  pci_write_config_dword(pdev, PCI_ROM_ADDRESS,
+   pdev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
+  printk(KERN_INFO DRV_NAME ": ROM enabled at 0x%08lx\n",
+         pdev->resource[PCI_ROM_RESOURCE].start);
+ }
+
+ /*
+  * Determine the PLL input clock rate.
+  * On some system, where PCI bus is running at non-standard clock rate.
+  * Ex. 25MHz or 40MHz, we have to adjust the cycle_time.
+  * The pdc20275 controller employs PLL circuit to help correct timing
registers setting.
+  */
+
+ /* Detect PLL input clock rate */
+ pll_clock = detect_pll_input_clock(pe);
+
+ if(pll_clock < 0) /* counter overflow? Try again. */
+  pll_clock = detect_pll_input_clock(pe);
+
+ printk(KERN_INFO DRV_NAME ": PLL input clock %ld kHz\n", pll_clock/1000);
+
+ /* Adjust PLL control register */
+ adjust_pll(pdc_controller, pe, pll_clock);
+
+ return 0;
+}
+/**
+ * pdc_new_init_one - PCI probe function
+ * Called when an instance of PCI adapter is inserted.
+ * This function checks whether the hardware is supported,
+ * initialize hardware and register an instance of ata_host_set to
+ * libata by providing struct ata_probe_ent and ata_device_add().
+ * (implements struct pci_driver.probe() )
+ *
+ * @pdev: instance of pci_dev found
+ * @ent:  matching entry in the id_tbl[]
+ */
+static int __devinit pdc_new_init_one(struct pci_dev *pdev, const struct
pci_device_id *ent)
+{
+ static int printed_version;
+ struct ata_probe_ent *probe_ent = NULL;
+ unsigned int board_idx = (unsigned int) ent->driver_data;
+ struct pdc_pata_ide_controller* pdc_controller = &
(pdc_pata_controller_tbl[board_idx]);
+ int rc;
+
+ if (!printed_version++)
+  printk(KERN_DEBUG DRV_NAME " version " DRV_VERSION "\n");
+
+ printk(KERN_INFO DRV_NAME ": Promise %s ATA/%lu controller\n",
+        pdc_controller->chip_name,
+        pdc_controller->pll_pout_required/1000000);
+
+ /*
+  * FIXME: Skip Promise PDC20276 attached to I2O RAID controller
+  */
+
+ /*
+  * FIXME: Special handling for Promise PDC20270 attached to DEC DC21150
PCI south bridge.
+  */
+
+ /*
+  * FIXME: If this driver happens to only be useful on Apple's K2, then
+  * we should check that here as it has a normal Serverworks ID
+  */
+ rc = pci_enable_device(pdev);
+ if (rc)
+  return rc;
+
+ rc = pci_request_regions(pdev, DRV_NAME);
+ if (rc)
+  goto err_out;
+
+ rc = pci_set_dma_mask(pdev, ATA_DMA_MASK);
+ if (rc)
+  goto err_out_regions;
+
+ rc = pci_set_consistent_dma_mask(pdev, ATA_DMA_MASK);
+ if (rc)
+  goto err_out_regions;
+
+ /* Prepare the probe entry */
+ probe_ent = kmalloc(sizeof(*probe_ent), GFP_KERNEL);
+ if (probe_ent == NULL) {
+  rc = -ENOMEM;
+  goto err_out_regions;
+ }
+
+ memset(probe_ent, 0, sizeof(*probe_ent));
+ probe_ent->pdev = pdev;
+ INIT_LIST_HEAD(&probe_ent->node);
+
+ probe_ent->sht  = pdc_new_port_info[pdc_controller->max_udma_mode].sht;
+ probe_ent->host_flags =
pdc_new_port_info[pdc_controller->max_udma_mode].host_flags;
+ probe_ent->pio_mask =
pdc_new_port_info[pdc_controller->max_udma_mode].pio_mask;
+ probe_ent->udma_mask =
pdc_new_port_info[pdc_controller->max_udma_mode].udma_mask;
+ probe_ent->port_ops =
pdc_new_port_info[pdc_controller->max_udma_mode].port_ops;
+
+        probe_ent->irq = pdev->irq;
+        probe_ent->irq_flags = SA_SHIRQ;
+
+ probe_ent->port[0].cmd_addr = pci_resource_start(pdev, 0);
+ ata_std_ports(&probe_ent->port[0]);
+ probe_ent->port[0].altstatus_addr =
+  probe_ent->port[0].ctl_addr =
+  pci_resource_start(pdev, 1) | ATA_PCI_CTL_OFS;
+ probe_ent->port[0].bmdma_addr = pci_resource_start(pdev, 4);
+
+ probe_ent->port[1].cmd_addr = pci_resource_start(pdev, 2);
+ ata_std_ports(&probe_ent->port[1]);
+ probe_ent->port[1].altstatus_addr =
+  probe_ent->port[1].ctl_addr =
+  pci_resource_start(pdev, 3) | ATA_PCI_CTL_OFS;
+ probe_ent->port[1].bmdma_addr = pci_resource_start(pdev, 4) + 8;
+
+ probe_ent->n_ports = 2;
+
+ pci_set_master(pdev);
+ //pci_enable_intx(pdev);
+
+ /* initialize adapter */
+ if(pdc_hardware_init(pdev, pdc_controller, probe_ent) != 0)
+  goto err_out_free_ent;
+
+ /* FIXME: check ata_device_add return value */
+ ata_device_add(probe_ent);
+ kfree(probe_ent);
+
+ return 0;
+
+err_out_free_ent:
+ kfree(probe_ent);
+err_out_regions:
+ pci_release_regions(pdev);
+err_out:
+ pci_disable_device(pdev);
+ return rc;
+}
+/**
+ * pdc_new_remove_one - Called to remove a single instance of the
+ * adapter.
+ *
+ * @dev: The PCI device to remove.
+ * FIXME: module load/unload not working yet
+ */
+static void __devexit pdc_new_remove_one(struct pci_dev *pdev)
+{
+ ata_pci_remove_one(pdev);
+}
+/**
+ * pdc_new_init - Called after this module is loaded into the kernel.
+ */
+static int __init pdc_new_init(void)
+{
+ return pci_module_init(&pdc_new_pci_driver);
+}
+/**
+ * pdc_new_exit - Called before this module unloaded from the kernel
+ */
+static void __exit pdc_new_exit(void)
+{
+ pci_unregister_driver(&pdc_new_pci_driver);
+}
+
+module_init(pdc_new_init);
+module_exit(pdc_new_exit);



