From: Grant Grundler <grundler@parisc-linux.org>
Subject: NS87415 on C3K broken
Date: Thu, 16 Sep 2004 10:17:49 -0600
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <20040916161749.GA17660@colo.lackof.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from colo.lackof.org ([198.49.126.79]:18393 "EHLO colo.lackof.org")
	by vger.kernel.org with ESMTP id S268486AbUIPQRz (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 16 Sep 2004 12:17:55 -0400
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: parisc-linux@lists.parisc-linux.org
Cc: linux-ide@vger.kernel.org

Hi,
Willy pointed out the 2.6.9-rc2 NS87415 driver for C3000 machine
(uses SuckyIO IDE) is causing HPMC (system crash). This was not
a problem with 2.6.8.1.
But while trying to fix MMIO resource management problems, I ran
into this when testing on C3000.

The HPMC stack trace looks like this:
	ide_inb
	ide_wait_not_busy
	wait_hwif_ready
	probe_hwif
	probe_hwif_init
	ide_setup_pci_device
	ns87415_init_one
	ide_scan_pcidev
	ide_scan_pcibus
	ide_init
	do_initcalls

Changes to ide-probe.c cause this HPMC.
wait_hwif_ready() is inside #ifdef CONFIG_PPC in 2.6.8.1 and the
ifdef/endif was removed in 2.6.9-rcX. The result is inb() is invoked
*BEFORE* ide_setup_pci_device() (indirectly) calls pci_enabled_device() or
pci_set_master(). This is broken because IDE controllers NOT enabled
by firmware will simply not respond to inb() (even if the system
doesn't crash like on parisc).

I'm a wimp. I don't dare to restructure IDE init sequence.
Anyone less of a wimp?
Or are IDE pci drivers required to call pci_enable_device()
in their (mostly non-extistent) init_chipset entry point?


Anyway, ns87415 driver has more problems. The patch below adds
"init_chipset" entry point and init_chipset_ns87415() calls
pci_enable_device() and pci_set_master() before the probe.
And my C3k still HPMCs. My guess is more of the code from
init_hwif_ns87415() needs to be moved to init_chipset_ns87415().
And possible call some special suckyio init routines.
I won't be able to touch this for a few days.
Anyone else on parisc-linux ml want to take a whack at this?

BTW, normally a PCI Master Abort to IO Port space to should NOT fail.
But on parisc is does because the chipset will go "fatal" on
any Master Abort - special hacks enable config space to work.
I strongly prefere not to add those hacks to IO Port space
accessor functions since it's normally not a problem.
And while inconvenient, this behavior does expose programming
problems like the one above.


thanks,
grant


Index: drivers/ide/pci/ns87415.c
===================================================================
RCS file: /var/cvs/linux-2.6/drivers/ide/pci/ns87415.c,v
retrieving revision 1.17
diff -u -p -r1.17 ns87415.c
--- drivers/ide/pci/ns87415.c	13 Sep 2004 15:23:04 -0000	1.17
+++ drivers/ide/pci/ns87415.c	16 Sep 2004 15:06:06 -0000
@@ -133,8 +133,29 @@ static int ns87415_ide_dma_check (ide_dr
 	return __ide_dma_check(drive);
 }
 
+static unsigned int __devinit init_chipset_ns87415(struct pci_dev *dev, const char *name)
+{
+	unsigned short w;
+printk("init_chipset_ns87415(%s,%s)\n", dev->slot_name, name);
+
+	pci_enable_device(dev);
+	pci_set_master(dev);
+
+(void) pci_read_config_word(dev, PCI_COMMAND, &w);
+printk("	cmd 0x%x\n", w);
+
+	if ((w & PCI_COMMAND_IO) == 0) {
+		w |= PCI_COMMAND_IO;
+		(void) pci_write_config_word(dev, PCI_COMMAND, w);
+printk("	enabling IO space\n");
+	}
+	return 0;
+}
+
+
 static void __init init_iops_ns87415(ide_hwif_t *hwif)
 {
+printk("init_iops_ns87415(%s)\n", hwif->pci_dev->slot_name);
 #ifdef CONFIG_SUPERIO
 	superio_ide_init_iops(hwif);
 #endif
@@ -150,12 +171,14 @@ static void __init init_hwif_ns87415 (id
 	u8 stat;
 #endif
 
+printk("init_hwif_ns87415(%s)\n", hwif->pci_dev->slot_name);
 	hwif->autodma = 0;
 	hwif->selectproc = &ns87415_selectproc;
 
+#if 0
 	/* Set a good latency timer and cache line size value. */
 	(void) pci_write_config_byte(dev, PCI_LATENCY_TIMER, 64);
-	/* FIXME: use pci_set_master() to ensure good latency timer value */
+#endif
 
 	/*
 	 * We cannot probe for IRQ: both ports share common IRQ on INTA.
@@ -227,6 +250,8 @@ static void __init init_hwif_ns87415 (id
 
 static ide_pci_device_t ns87415_chipset __devinitdata = {
 	.name		= "NS87415",
+	.init_chipset	= init_chipset_ns87415,
+	.init_iops	= init_iops_ns87415,
 	.init_hwif	= init_hwif_ns87415,
 	.channels	= 2,
 	.autodma	= AUTODMA,
