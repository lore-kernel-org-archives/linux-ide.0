From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] pata_hpt37x: Further small fixes
Date: Fri, 23 Mar 2007 19:00:23 +0000
Message-ID: <20070323190023.64d0b954@lxorguk.ukuu.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:43972 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751493AbXCWR6G (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Mar 2007 13:58:06 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-ide@vger.kernel.org, jgarzik@pobox.com

Further HPT37x changes

- No 66MHz 370/370A
- Remove dead special case check now we use the DPLL (as per the IDE driver)

Pointed out by Sergei

Signed-off-by: Alan Cox <alan@redhat.com>


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.21-rc4-mm1/drivers/ata/pata_hpt37x.c linux-2.6.21-rc4-mm1/drivers/ata/pata_hpt37x.c
--- linux.vanilla-2.6.21-rc4-mm1/drivers/ata/pata_hpt37x.c	2007-03-23 11:49:49.000000000 +0000
+++ linux-2.6.21-rc4-mm1/drivers/ata/pata_hpt37x.c	2007-03-23 13:29:49.000000000 +0000
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.4"
+#define DRV_VERSION	"0.6.5"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -130,7 +130,7 @@
 		hpt37x_timings_33,
 		NULL,
 		NULL,
-		hpt37x_timings_66
+		NULL
 	}
 };
 
@@ -141,7 +141,7 @@
 		hpt37x_timings_33,
 		NULL,
 		hpt37x_timings_50,
-		hpt37x_timings_66
+		NULL
 	}
 };
 
@@ -1019,8 +1019,8 @@
 					return -ENODEV;
 				port = &info_hpt372;
 				chip_table = &hpt371;
-				/* Single channel device, paster is not present
-				   but the NIOS (or us for non x86) must mark it
+				/* Single channel device, master is not present
+				   but the BIOS (or us for non x86) must mark it
 				   absent */
 				pci_read_config_byte(dev, 0x50, &mcr1);
 				mcr1 &= ~0x04;
@@ -1132,16 +1132,11 @@
 	} else {
 		port->private_data = (void *)chip_table->clocks[clock_slot];
 		/*
-		 *	Perform a final fixup. The 371 and 372 clock determines
-		 *	if UDMA133 is available. (FIXME: should we use DPLL then ?)
-		 */
+		 *	Perform a final fixup. Note that we will have used the
+		 *	DPLL on the HPT372 which means we don't have to worry
+		 *	about lack of UDMA133 support on lower clocks
+ 		 */
 
-		if (clock_slot == 2 && chip_table == &hpt372) {	/* 50Mhz */
-			printk(KERN_WARNING "pata_hpt37x: No UDMA133 support available with 50MHz bus clock.\n");
-			if (port == &info_hpt372)
-				port = &info_hpt372_50;
-			else BUG();
-		}
 		if (clock_slot < 2 && port == &info_hpt370)
 			port = &info_hpt370_33;
 		if (clock_slot < 2 && port == &info_hpt370a)
