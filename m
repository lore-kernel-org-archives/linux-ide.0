From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt3x2n: Clean up DPLL stuff
Date: Wed, 26 Sep 2007 23:04:24 +0100
Message-ID: <20070926230424.23a302c8@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:57534 "EHLO
	the-village.bc.nu" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1759006AbXIZV6V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 26 Sep 2007 17:58:21 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org

Nobody commented when I asked for review earlier so it must be ok  8)

Lets stick it in -mm to be sure

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --exclude-from /usr/src/exclude --recursive linux.vanilla-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c linux-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c
--- linux.vanilla-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c	2007-09-26 16:46:48.000000000 +0100
+++ linux-2.6.23rc8-mm1/drivers/ata/pata_hpt37x.c	2007-09-18 16:44:32.000000000 +0100
@@ -1,5 +1,5 @@
 /*
- * Libata driver for the highpoint 37x and 30x UDMA66 ATA controllers.
+ * Libata driver for the highpoint 37x and 30x UDMA ATA controllers.
  *
  * This driver is heavily based upon:
  *
@@ -844,6 +844,46 @@
 	/* Never went stable */
 	return 0;
 }
+
+static void *hpt_tune_function(struct pci_dev *dev, int dpll, int clock_slot)
+{
+	static const int MHz[4] = { 33, 40, 50, 66 };
+	/*
+	 *	For non UDMA133 capable devices we should
+	 *	use a 50MHz DPLL by choice
+	 */
+	unsigned int f_low, f_high;
+	int adjust;
+
+	f_low = (MHz[clock_slot] * 48) / MHz[dpll];
+	f_high = f_low + 2;
+	if (clock_slot > 1)
+		f_high += 2;
+	/* Select the DPLL clock. */
+	pci_write_config_byte(dev, 0x5b, 0x21);
+	pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
+
+	for(adjust = 0; adjust < 8; adjust++) {
+		if (hpt37x_calibrate_dpll(dev))
+			break;
+		/* See if it'll settle at a fractionally different clock */
+		if (adjust & 1)
+			f_low -= adjust >> 1;
+		else
+			f_high += adjust >> 1;
+		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
+	}
+	if (adjust == 8) {
+		printk(KERN_WARNING "hpt37x: DPLL did not stabilize.\n");
+		return NULL;
+	}
+	printk(KERN_INFO "hpt37x: Bus clock %dMHz, using DPLL.\n", MHz[dpll]);
+	if (dpll == 3)
+		return hpt37x_timings_66;
+	else
+		return hpt37x_timings_50;
+}
+
 /**
  *	hpt37x_init_one		-	Initialise an HPT37X/302
  *	@dev: PCI device
@@ -944,7 +984,7 @@
 	u8 mcr1;
 	u32 freq;
 	int prefer_dpll = 1;
-
+	int hpt374alt = 0;
 	unsigned long iobase = pci_resource_start(dev, 4);
 
 	const struct hpt_chip *chip_table;
@@ -1046,16 +1086,28 @@
 	if (chip_table == &hpt372a)
 		outb(0x0e, iobase + 0x9c);
 
+	/*
+	 * PLL must be done once
+	 */
+	 
+	if (chip_table == &hpt374 && PCI_FUNC(dev->devfn) & 1) {
+		/* The HPT374 secondary devfn is tuned to 50MHz when we find
+		   the primary */
+		port_info = *port;
+		port_info.private_data = hpt37x_timings_50;
+	}	
 	/* Some devices do not let this value be accessed via PCI space
 	   according to the old driver */
-
 	freq = inl(iobase + 0x90);
 	if ((freq >> 12) != 0xABCDE) {
 		int i;
 		u8 sr;
 		u32 total = 0;
-
+		
 		printk(KERN_WARNING "pata_hpt37x: BIOS has not set timing clocks.\n");
+		if (hpt374alt == 1)
+			printk(KERN_ERR "pata_hpt37x: No saved frequency on primary function.\n");
+
 
 		/* This is the process the HPT371 BIOS is reported to use */
 		for(i = 0; i < 128; i++) {
@@ -1074,48 +1126,19 @@
 
 	clock_slot = hpt37x_clock_slot(freq, chip_table->base);
 	if (chip_table->clocks[clock_slot] == NULL || prefer_dpll) {
-		/*
-		 *	We need to try PLL mode instead
-		 *
-		 *	For non UDMA133 capable devices we should
-		 *	use a 50MHz DPLL by choice
-		 */
-		unsigned int f_low, f_high;
-		int dpll, adjust;
-
 		/* Compute DPLL */
-		dpll = (port->udma_mask & 0xC0) ? 3 : 2;
-
-		f_low = (MHz[clock_slot] * 48) / MHz[dpll];
-		f_high = f_low + 2;
-		if (clock_slot > 1)
-			f_high += 2;
-
-		/* Select the DPLL clock. */
-		pci_write_config_byte(dev, 0x5b, 0x21);
-		pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
-
-		for(adjust = 0; adjust < 8; adjust++) {
-			if (hpt37x_calibrate_dpll(dev))
-				break;
-			/* See if it'll settle at a fractionally different clock */
-			if (adjust & 1)
-				f_low -= adjust >> 1;
-			else
-				f_high += adjust >> 1;
-			pci_write_config_dword(dev, 0x5C, (f_high << 16) | f_low | 0x100);
-		}
-		if (adjust == 8) {
-			printk(KERN_ERR "pata_hpt37x: DPLL did not stabilize!\n");
-			return -ENODEV;
+		int dpll = 2;
+		if (port->udma_mask & 0xC0)
+  			dpll = 3;
+		private_data = hpt_tune_function(dev, dpll, clock_slot);
+		/* For the HPT374 tune both channels together from fn 0 */
+		if (chip_table == &hpt374 && !(PCI_FUNC(dev->devfn) & 1)) {
+			struct pci_dev *pair = pci_get_slot(dev->bus, dev->devfn + 1);
+			if (pair != NULL) {
+				hpt_tune_function(pair, dpll, clock_slot);
+				pci_dev_put(pair);
+			}
 		}
-		if (dpll == 3)
-			private_data = (void *)hpt37x_timings_66;
-		else
-			private_data = (void *)hpt37x_timings_50;
-
-		printk(KERN_INFO "pata_hpt37x: bus clock %dMHz, using %dMHz DPLL.\n",
-		       MHz[clock_slot], MHz[dpll]);
 	} else {
 		private_data = (void *)chip_table->clocks[clock_slot];
 		/*
