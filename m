From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] amd74xx: workaround unreliable AltStatus register for nVidia controllers
Date: Fri, 21 Nov 2008 22:38:50 +0100
Message-ID: <200811212238.51161.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ey-out-2122.google.com ([74.125.78.26]:58041 "EHLO
	ey-out-2122.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752864AbYKUVoR (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 21 Nov 2008 16:44:17 -0500
Received: by ey-out-2122.google.com with SMTP id 6so478095eyi.37
        for <linux-ide@vger.kernel.org>; Fri, 21 Nov 2008 13:44:16 -0800 (PST)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Remy LABENE <remy.labene@free.fr>, Borislav Petkov <petkovbb@googlemail.com>

It seems that on some nVidia controllers using AltStatus register
can be unreliable so default to Status register if the PCI device
is in Compatibility Mode.  In order to achieve this:

* Add ide_pci_is_in_compatibility_mode() inline helper to <linux/ide.h>.

* Add IDE_HFLAG_BROKEN_ALTSTATUS host flag and set it in amd74xx host
  driver for nVidia controllers in Compatibility Mode.

* Teach actual_try_to_identify() and drive_is_ready() about the new flag.

This fixes the regression caused by removal of CONFIG_IDEPCI_SHARE_IRQ
config option in 2.6.25 and using AltStatus register unconditionally when
available (kernel.org bug #11659).  [ Moreover for CONFIG_IDEPCI_SHARE_IRQ=y
(which is what most distributions/people use) it never worked correctly. ]

Thanks to Remy LABENE for help with debugging the problem.

More info at:
http://bugzilla.kernel.org/show_bug.cgi?id=11659

Reported-by: Remy LABENE <remy.labene@free.fr>
Cc: Borislav Petkov <petkovbb@googlemail.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
This fix should be safe for both .28 and -stable.

 drivers/ide/amd74xx.c   |   11 ++++++++++-
 drivers/ide/ide-iops.c  |    3 ++-
 drivers/ide/ide-probe.c |    3 ++-
 include/linux/ide.h     |    8 ++++++++
 4 files changed, 22 insertions(+), 3 deletions(-)

Index: b/drivers/ide/amd74xx.c
===================================================================
--- a/drivers/ide/amd74xx.c
+++ b/drivers/ide/amd74xx.c
@@ -3,7 +3,7 @@
  * IDE driver for Linux.
  *
  * Copyright (c) 2000-2002 Vojtech Pavlik
- * Copyright (c) 2007 Bartlomiej Zolnierkiewicz
+ * Copyright (c) 2007-2008 Bartlomiej Zolnierkiewicz
  *
  * Based on the work of:
  *      Andre Hedrick
@@ -263,6 +263,15 @@ static int __devinit amd74xx_probe(struc
 			d.udma_mask = ATA_UDMA5;
 	}
 
+	/*
+	 * It seems that on some nVidia controllers using AltStatus
+	 * register can be unreliable so default to Status register
+	 * if the device is in Compatibility Mode.
+	 */
+	if (dev->vendor == PCI_VENDOR_ID_NVIDIA &&
+	    ide_pci_is_in_compatibility_mode(dev))
+		d.host_flags |= IDE_HFLAG_BROKEN_ALTSTATUS;
+
 	printk(KERN_INFO "%s %s: UDMA%s controller\n",
 		d.name, pci_name(dev), amd_dma[fls(d.udma_mask) - 1]);
 
Index: b/drivers/ide/ide-iops.c
===================================================================
--- a/drivers/ide/ide-iops.c
+++ b/drivers/ide/ide-iops.c
@@ -468,7 +468,8 @@ int drive_is_ready (ide_drive_t *drive)
 	 * an interrupt with another pci card/device.  We make no assumptions
 	 * about possible isa-pnp and pci-pnp issues yet.
 	 */
-	if (hwif->io_ports.ctl_addr)
+	if (hwif->io_ports.ctl_addr &&
+	    (hwif->host_flags & IDE_HFLAG_BROKEN_ALTSTATUS) == 0)
 		stat = hwif->tp_ops->read_altstatus(hwif);
 	else
 		/* Note: this may clear a pending IRQ!! */
Index: b/drivers/ide/ide-probe.c
===================================================================
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -266,7 +266,8 @@ static int actual_try_to_identify (ide_d
 	/* take a deep breath */
 	msleep(50);
 
-	if (io_ports->ctl_addr) {
+	if (io_ports->ctl_addr &&
+	    (hwif->host_flags & IDE_HFLAG_BROKEN_ALTSTATUS) == 0) {
 		a = tp_ops->read_altstatus(hwif);
 		s = tp_ops->read_status(hwif);
 		if ((a ^ s) & ~ATA_IDX)
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1296,6 +1296,13 @@ extern int __ide_pci_register_driver(str
 #define ide_pci_register_driver(d) pci_register_driver(d)
 #endif
 
+static inline int ide_pci_is_in_compatibility_mode(struct pci_dev *dev)
+{
+	if ((dev->class >> 8) == PCI_CLASS_STORAGE_IDE && (dev->class & 5) != 5)
+		return 1;
+	return 0;
+}
+
 void ide_pci_setup_ports(struct pci_dev *, const struct ide_port_info *, int,
 			 hw_regs_t *, hw_regs_t **);
 void ide_setup_pci_noise(struct pci_dev *, const struct ide_port_info *);
@@ -1375,6 +1382,7 @@ enum {
 	IDE_HFLAG_IO_32BIT		= (1 << 24),
 	/* unmask IRQs */
 	IDE_HFLAG_UNMASK_IRQS		= (1 << 25),
+	IDE_HFLAG_BROKEN_ALTSTATUS	= (1 << 26),
 	/* serialize ports if DMA is possible (for sl82c105) */
 	IDE_HFLAG_SERIALIZE_DMA		= (1 << 27),
 	/* force host out of "simplex" mode */
