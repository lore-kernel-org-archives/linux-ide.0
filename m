From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] ide: Stop mapping ROMs
Date: Fri, 22 Jun 2007 14:22:52 +0100
Message-ID: <20070622142252.2ec0d148@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34825 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750718AbXFVNRe (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 22 Jun 2007 09:17:34 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, bzolnier@gmail.com

Various old IDE drivers go mapping ROM devices for no apparent reason and
without using the ROM mapping API we now have. They don't actually use
the ROM they map and the new libata drivers are happy without it being
mapped so rather than port them lets just junk it for the next -rc1.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/aec62xx.c linux-2.6.22-rc4-mm2/drivers/ide/pci/aec62xx.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/aec62xx.c	2007-06-07 14:26:08.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ide/pci/aec62xx.c	2007-06-18 15:57:40.000000000 +0100
@@ -174,12 +174,6 @@
 {
 	int bus_speed = system_bus_clock();
 
-	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS, dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
-			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
-	}
-
 	if (bus_speed <= 33)
 		pci_set_drvdata(dev, (void *) aec6xxx_33_base);
 	else
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/hpt34x.c linux-2.6.22-rc4-mm2/drivers/ide/pci/hpt34x.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/hpt34x.c	2007-06-07 14:25:58.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ide/pci/hpt34x.c	2007-06-18 15:58:51.000000000 +0100
@@ -120,17 +120,10 @@
 	pci_write_config_byte(dev, HPT34X_PCI_INIT_REG, 0x00);
 	pci_read_config_word(dev, PCI_COMMAND, &cmd);
 
-	if (cmd & PCI_COMMAND_MEMORY) {
-		if (pci_resource_start(dev, PCI_ROM_RESOURCE)) {
-			pci_write_config_dword(dev, PCI_ROM_ADDRESS,
-				dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-			printk(KERN_INFO "HPT345: ROM enabled at 0x%08lx\n",
-				(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
-		}
+	if (cmd & PCI_COMMAND_MEMORY)
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0xF0);
-	} else {
+	else
 		pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x20);
-	}
 
 	/*
 	 * Since 20-23 can be assigned and are R/W, we correct them.
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/hpt366.c linux-2.6.22-rc4-mm2/drivers/ide/pci/hpt366.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/hpt366.c	2007-06-07 14:26:08.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ide/pci/hpt366.c	2007-06-18 15:59:08.000000000 +0100
@@ -993,14 +993,6 @@
 	 */
 	*info = *(struct hpt_info *)pci_get_drvdata(dev);
 
-	/*
-	 * FIXME: Not portable. Also, why do we enable the ROM in the first place?
-	 * We don't seem to be using it.
-	 */
-	if (dev->resource[PCI_ROM_RESOURCE].start)
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
-			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-
 	pci_write_config_byte(dev, PCI_CACHE_LINE_SIZE, (L1_CACHE_BYTES / 4));
 	pci_write_config_byte(dev, PCI_LATENCY_TIMER, 0x78);
 	pci_write_config_byte(dev, PCI_MIN_GNT, 0x08);
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_new.c linux-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_new.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_new.c	2007-06-07 14:25:58.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_new.c	2007-06-18 15:59:28.000000000 +0100
@@ -369,13 +369,6 @@
 	int f, r;
 	u8 pll_ctl0, pll_ctl1;
 
-	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
-			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
-			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
-	}
-
 #ifdef CONFIG_PPC_PMAC
 	apple_kiwi_init(dev);
 #endif
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_old.c linux-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_old.c
--- linux.vanilla-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_old.c	2007-06-07 14:26:08.000000000 +0100
+++ linux-2.6.22-rc4-mm2/drivers/ide/pci/pdc202xx_old.c	2007-06-18 15:59:40.000000000 +0100
@@ -314,14 +314,6 @@
 static unsigned int __devinit init_chipset_pdc202xx(struct pci_dev *dev,
 							const char *name)
 {
-	/* This doesn't appear needed */
-	if (dev->resource[PCI_ROM_RESOURCE].start) {
-		pci_write_config_dword(dev, PCI_ROM_ADDRESS,
-			dev->resource[PCI_ROM_RESOURCE].start | PCI_ROM_ADDRESS_ENABLE);
-		printk(KERN_INFO "%s: ROM enabled at 0x%08lx\n", name,
-			(unsigned long)dev->resource[PCI_ROM_RESOURCE].start);
-	}
-
 	return dev->irq;
 }
 
