From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] hpt366: coding style cleanup
Date: Thu, 30 Dec 2010 22:10:31 +0300
Message-ID: <201012302210.31659.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail.dev.rtsoft.ru ([213.79.90.226]:50745 "HELO
	mail.dev.rtsoft.ru" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754941Ab0L3TLu (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 30 Dec 2010 14:11:50 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: davem@davemloft.net
Cc: linux-ide@vger.kernel.org

Fix 36 errors and 18 warnings given by checkpatch.pl:

- including <asm/uaccess.h> instead of <linux/uaccess.h>;

- including <asm/io.h> instead of <linux/io.h>;

- printk() not including KERN_* facility level;

- *switch* and *case* not on the same indentation level;

- no space between *for*/*if*/*switch* and open parenthesis;

- trailing statement and *case*/*if* on the same line;

- space after open parentesis of the *if* statement;

- space between function name and open parenthesis;

- space before semicolon after *case*;

- no space after comma;

- no space after closing brace in initializer;

- C99-style // comments;

- trailing whitespace;

- spaces before tabs;

- lines over 80 characters.

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
The patch is against the recent Linus' tree.

 drivers/ide/hpt366.c |  158 ++++++++++++++++++++++++++++-----------------------
 1 file changed, 88 insertions(+), 70 deletions(-)

Index: linux-2.6/drivers/ide/hpt366.c
===================================================================
--- linux-2.6.orig/drivers/ide/hpt366.c
+++ linux-2.6/drivers/ide/hpt366.c
@@ -3,7 +3,7 @@
  * Portions Copyright (C) 2001	        Sun Microsystems, Inc.
  * Portions Copyright (C) 2003		Red Hat Inc
  * Portions Copyright (C) 2007		Bartlomiej Zolnierkiewicz
- * Portions Copyright (C) 2005-2009	MontaVista Software, Inc.
+ * Portions Copyright (C) 2005-2010	MontaVista Software, Inc.
  *
  * Thanks to HighPoint Technologies for their assistance, and hardware.
  * Special Thanks to Jon Burchmore in SanDiego for the deep pockets, his
@@ -12,7 +12,7 @@
  *
  *
  * HighPoint has its own drivers (open source except for the RAID part)
- * available from http://www.highpoint-tech.com/USA_new/service_support.htm 
+ * available from http://www.highpoint-tech.com/USA_new/service_support.htm
  * This may be useful to anyone wanting to work on this driver, however  do not
  * trust  them too much since the code tends to become less and less meaningful
  * as the time passes... :-/
@@ -20,10 +20,10 @@
  * Note that final HPT370 support was done by force extraction of GPL.
  *
  * - add function for getting/setting power status of drive
- * - the HPT370's state machine can get confused. reset it before each dma 
+ * - the HPT370's state machine can get confused. reset it before each dma
  *   xfer to prevent that from happening.
  * - reset state engine whenever we get an error.
- * - check for busmaster state at end of dma. 
+ * - check for busmaster state at end of dma.
  * - use new highpoint timings.
  * - detect bus speed using highpoint register.
  * - use pll if we don't have a clock table. added a 66MHz table that's
@@ -32,26 +32,26 @@
  *   pci clocks as the chip can glitch in those cases. the highpoint
  *   approved workaround slows everything down too much to be useful. in
  *   addition, we would have to serialize access to each chip.
- * 	Adrian Sun <a.sun@sun.com>
+ *	Adrian Sun <a.sun@sun.com>
  *
  * add drive timings for 66MHz PCI bus,
  * fix ATA Cable signal detection, fix incorrect /proc info
  * add /proc display for per-drive PIO/DMA/UDMA mode and
  * per-channel ATA-33/66 Cable detect.
- * 	Duncan Laurie <void@sun.com>
+ *	Duncan Laurie <void@sun.com>
  *
  * fixup /proc output for multiple controllers
  *	Tim Hockin <thockin@sun.com>
  *
- * On hpt366: 
+ * On hpt366:
  * Reset the hpt366 on error, reset on dma
  * Fix disabling Fast Interrupt hpt366.
- * 	Mike Waychison <crlf@sun.com>
+ *	Mike Waychison <crlf@sun.com>
  *
  * Added support for 372N clocking and clock switching. The 372N needs
  * different clocks on read/write. This requires overloading rw_disk and
  * other deeply crazy things. Thanks to <http://www.hoerstreich.de> for
- * keeping me sane. 
+ * keeping me sane.
  *		Alan Cox <alan@lxorguk.ukuu.org.uk>
  *
  * - fix the clock turnaround code: it was writing to the wrong ports when
@@ -128,10 +128,9 @@
 #include <linux/pci.h>
 #include <linux/init.h>
 #include <linux/ide.h>
+#include <linux/io.h>
 #include <linux/slab.h>
-
-#include <asm/uaccess.h>
-#include <asm/io.h>
+#include <linux/uaccess.h>
 
 #define DRV_NAME "hpt366"
 
@@ -184,13 +183,18 @@ static const char *bad_ata66_3[] = {
 };
 
 static const char *bad_ata33[] = {
-	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3", "Maxtor 90845U3", "Maxtor 90650U2",
-	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5", "Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
-	"Maxtor 91152D8", "Maxtor 91008D7", "Maxtor 90845D6", "Maxtor 90840D6", "Maxtor 90720D5", "Maxtor 90648D5", "Maxtor 90576D4",
+	"Maxtor 92720U8", "Maxtor 92040U6", "Maxtor 91360U4", "Maxtor 91020U3",
+	"Maxtor 90845U3", "Maxtor 90650U2",
+	"Maxtor 91360D8", "Maxtor 91190D7", "Maxtor 91020D6", "Maxtor 90845D5",
+	"Maxtor 90680D4", "Maxtor 90510D3", "Maxtor 90340D2",
+	"Maxtor 91152D8", "Maxtor 91008D7", "Maxtor 90845D6", "Maxtor 90840D6",
+	"Maxtor 90720D5", "Maxtor 90648D5", "Maxtor 90576D4",
 	"Maxtor 90510D4",
 	"Maxtor 90432D3", "Maxtor 90288D2", "Maxtor 90256D2",
-	"Maxtor 91000D8", "Maxtor 90910D8", "Maxtor 90875D7", "Maxtor 90840D7", "Maxtor 90750D6", "Maxtor 90625D5", "Maxtor 90500D4",
-	"Maxtor 91728D8", "Maxtor 91512D7", "Maxtor 91303D6", "Maxtor 91080D5", "Maxtor 90845D4", "Maxtor 90680D4", "Maxtor 90648D3", "Maxtor 90432D2",
+	"Maxtor 91000D8", "Maxtor 90910D8", "Maxtor 90875D7", "Maxtor 90840D7",
+	"Maxtor 90750D6", "Maxtor 90625D5", "Maxtor 90500D4",
+	"Maxtor 91728D8", "Maxtor 91512D7", "Maxtor 91303D6", "Maxtor 91080D5",
+	"Maxtor 90845D4", "Maxtor 90680D4", "Maxtor 90648D3", "Maxtor 90432D2",
 	NULL
 };
 
@@ -446,7 +450,9 @@ static struct hpt_timings hpt37x_timings
 static const struct hpt_info hpt36x __devinitdata = {
 	.chip_name	= "HPT36x",
 	.chip_type	= HPT36x,
-	.udma_mask	= HPT366_ALLOW_ATA66_3 ? (HPT366_ALLOW_ATA66_4 ? ATA_UDMA4 : ATA_UDMA3) : ATA_UDMA2,
+	.udma_mask	= HPT366_ALLOW_ATA66_3 ?
+			  (HPT366_ALLOW_ATA66_4 ? ATA_UDMA4 : ATA_UDMA3) :
+			  ATA_UDMA2,
 	.dpll_clk	= 0,	/* no DPLL */
 	.timings	= &hpt36x_timings
 };
@@ -558,7 +564,7 @@ static u8 hpt3xx_udma_filter(ide_drive_t
 {
 	ide_hwif_t *hwif	= drive->hwif;
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
-	u8 mask 		= hwif->ultra_mask;
+	u8 mask			= hwif->ultra_mask;
 
 	switch (info->chip_type) {
 	case HPT36x:
@@ -579,10 +585,10 @@ static u8 hpt3xx_udma_filter(ide_drive_t
 		if (!HPT370_ALLOW_ATA100_5 ||
 		    check_in_drive_list(drive, bad_ata100_5))
 			return ATA_UDMA4;
-	case HPT372 :
+	case HPT372:
 	case HPT372A:
 	case HPT372N:
-	case HPT374 :
+	case HPT374:
 		if (ata_id_is_sata(drive->id))
 			mask &= ~0x0e;
 		/* Fall thru */
@@ -599,10 +605,10 @@ static u8 hpt3xx_mdma_filter(ide_drive_t
 	struct hpt_info *info	= hpt3xx_get_info(hwif->dev);
 
 	switch (info->chip_type) {
-	case HPT372 :
+	case HPT372:
 	case HPT372A:
 	case HPT372N:
-	case HPT374 :
+	case HPT374:
 		if (ata_id_is_sata(drive->id))
 			return 0x00;
 		/* Fall thru */
@@ -696,7 +702,7 @@ static void hpt366_dma_lost_irq(ide_driv
 	pci_read_config_byte(dev, 0x50, &mcr1);
 	pci_read_config_byte(dev, 0x52, &mcr3);
 	pci_read_config_byte(dev, 0x5a, &scr1);
-	printk("%s: (%s)  mcr1=0x%02x, mcr3=0x%02x, scr1=0x%02x\n",
+	printk(KERN_DEBUG "%s: (%s)  mcr1=0x%02x, mcr3=0x%02x, scr1=0x%02x\n",
 		drive->name, __func__, mcr1, mcr3, scr1);
 	if (scr1 & 0x10)
 		pci_write_config_byte(dev, 0x5a, scr1 & ~0x10);
@@ -762,7 +768,8 @@ static int hpt374_dma_test_irq(ide_drive
 
 	pci_read_config_word(dev, hwif->select_data + 2, &bfifo);
 	if (bfifo & 0x1FF) {
-//		printk("%s: %d bytes in FIFO\n", drive->name, bfifo);
+		/* printk(KERN_DEBUG "%s: %d bytes in FIFO\n", drive->name,
+		       bfifo); */
 		return 0;
 	}
 
@@ -857,21 +864,21 @@ static int hpt37x_calibrate_dpll(struct 
 	pci_write_config_dword(dev, 0x5c, dpll);
 
 	/* Wait for oscillator ready */
-	for(i = 0; i < 0x5000; ++i) {
+	for (i = 0; i < 0x5000; ++i) {
 		udelay(50);
 		pci_read_config_byte(dev, 0x5b, &scr2);
 		if (scr2 & 0x80)
 			break;
 	}
 	/* See if it stays ready (we'll just bail out if it's not yet) */
-	for(i = 0; i < 0x1000; ++i) {
+	for (i = 0; i < 0x1000; ++i) {
 		pci_read_config_byte(dev, 0x5b, &scr2);
 		/* DPLL destabilized? */
-		if(!(scr2 & 0x80))
+		if (!(scr2 & 0x80))
 			return 0;
 	}
 	/* Turn off tuning, we have the DPLL set */
-	pci_read_config_dword (dev, 0x5c, &dpll);
+	pci_read_config_dword(dev,  0x5c, &dpll);
 	pci_write_config_dword(dev, 0x5c, (dpll & ~0x100));
 	return 1;
 }
@@ -1001,9 +1008,9 @@ static int init_chipset_hpt366(struct pc
 		/* Clamp PCI clock to bands. */
 		if (pci_clk < 40)
 			pci_clk = 33;
-		else if(pci_clk < 45)
+		else if (pci_clk < 45)
 			pci_clk = 40;
-		else if(pci_clk < 55)
+		else if (pci_clk < 55)
 			pci_clk = 50;
 		else
 			pci_clk = 66;
@@ -1017,38 +1024,38 @@ static int init_chipset_hpt366(struct pc
 		pci_read_config_dword(dev, 0x40, &itr1);
 
 		/* Detect PCI clock by looking at cmd_high_time. */
-		switch((itr1 >> 8) & 0x07) {
-			case 0x09:
-				pci_clk = 40;
-				break;
-			case 0x05:
-				pci_clk = 25;
-				break;
-			case 0x07:
-			default:
-				pci_clk = 33;
-				break;
+		switch ((itr1 >> 8) & 0x07) {
+		case 0x09:
+			pci_clk = 40;
+			break;
+		case 0x05:
+			pci_clk = 25;
+			break;
+		case 0x07:
+		default:
+			pci_clk = 33;
+			break;
 		}
 	}
 
 	/* Let's assume we'll use PCI clock for the ATA clock... */
 	switch (pci_clk) {
-		case 25:
-			clock = ATA_CLOCK_25MHZ;
-			break;
-		case 33:
-		default:
-			clock = ATA_CLOCK_33MHZ;
-			break;
-		case 40:
-			clock = ATA_CLOCK_40MHZ;
-			break;
-		case 50:
-			clock = ATA_CLOCK_50MHZ;
-			break;
-		case 66:
-			clock = ATA_CLOCK_66MHZ;
-			break;
+	case 25:
+		clock = ATA_CLOCK_25MHZ;
+		break;
+	case 33:
+	default:
+		clock = ATA_CLOCK_33MHZ;
+		break;
+	case 40:
+		clock = ATA_CLOCK_40MHZ;
+		break;
+	case 50:
+		clock = ATA_CLOCK_50MHZ;
+		break;
+	case 66:
+		clock = ATA_CLOCK_66MHZ;
+		break;
 	}
 
 	/*
@@ -1091,7 +1098,7 @@ static int init_chipset_hpt366(struct pc
 		f_low = (pci_clk * 48) / dpll_clk;
 
 		for (adjust = 0; adjust < 8; adjust++) {
-			if(hpt37x_calibrate_dpll(dev, f_low, f_low + delta))
+			if (hpt37x_calibrate_dpll(dev, f_low, f_low + delta))
 				break;
 
 			/*
@@ -1130,8 +1137,8 @@ static int init_chipset_hpt366(struct pc
 		 * Reset the state engines.
 		 * NOTE: Avoid accidentally enabling the disabled channels.
 		 */
-		pci_read_config_byte (dev, 0x50, &mcr1);
-		pci_read_config_byte (dev, 0x54, &mcr4);
+		pci_read_config_byte(dev,  0x50, &mcr1);
+		pci_read_config_byte(dev,  0x54, &mcr4);
 		pci_write_config_byte(dev, 0x50, (mcr1 | 0x32));
 		pci_write_config_byte(dev, 0x54, (mcr4 | 0x32));
 		udelay(100);
@@ -1247,8 +1254,10 @@ static int __devinit init_dma_hpt366(ide
 	pci_read_config_byte(dev, hwif->channel ? 0x4b : 0x43, &masterdma);
 	pci_read_config_byte(dev, hwif->channel ? 0x4f : 0x47,  &slavedma);
 
-	if (masterdma & 0x30)	dma_new |= 0x20;
-	if ( slavedma & 0x30)	dma_new |= 0x40;
+	if (masterdma & 0x30)
+		dma_new |= 0x20;
+	if (slavedma  & 0x30)
+		dma_new |= 0x40;
 	if (dma_new != dma_old)
 		outb(dma_new, base + 2);
 
@@ -1373,7 +1382,7 @@ static const struct ide_port_info hpt366
 		 * to both functions -- really stupid design decision... :-(
 		 * Bit 4 is for the primary channel, bit 5 for the secondary.
 		 */
-		.enablebits	= {{0x50,0x10,0x10}, {0x54,0x04,0x04}},
+		.enablebits	= { {0x50, 0x10, 0x10}, {0x54, 0x04, 0x04} },
 		.port_ops	= &hpt3xx_port_ops,
 		.dma_ops	= &hpt36x_dma_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX | IDE_HFLAG_SINGLE,
@@ -1385,7 +1394,7 @@ static const struct ide_port_info hpt366
 		.init_chipset	= init_chipset_hpt366,
 		.init_hwif	= init_hwif_hpt366,
 		.init_dma	= init_dma_hpt366,
-		.enablebits	= {{0x50,0x04,0x04}, {0x54,0x04,0x04}},
+		.enablebits	= { {0x50, 0x04, 0x04}, {0x54, 0x04, 0x04} },
 		.port_ops	= &hpt3xx_port_ops,
 		.dma_ops	= &hpt37x_dma_ops,
 		.host_flags	= IDE_HFLAGS_HPT3XX,
@@ -1402,7 +1411,8 @@ static const struct ide_port_info hpt366
  *	Called when the PCI registration layer (or the IDE initialization)
  *	finds a device matching our IDE device tables.
  */
-static int __devinit hpt366_init_one(struct pci_dev *dev, const struct pci_device_id *id)
+static int __devinit hpt366_init_one(struct pci_dev *dev,
+				     const struct pci_device_id *id)
 {
 	const struct hpt_info *info = NULL;
 	struct hpt_info *dyn_info;
@@ -1421,10 +1431,18 @@ static int __devinit hpt366_init_one(str
 			info = &hpt36x;
 		else {
 			switch (min_t(u8, rev, 6)) {
-			case 3: info = &hpt370;  break;
-			case 4: info = &hpt370a; break;
-			case 5: info = &hpt372;  break;
-			case 6: info = &hpt372n; break;
+			case 3:
+				info = &hpt370;
+				break;
+			case 4:
+				info = &hpt370a;
+				break;
+			case 5:
+				info = &hpt372;
+				break;
+			case 6:
+				info = &hpt372n;
+				break;
 			}
 			idx++;
 		}
