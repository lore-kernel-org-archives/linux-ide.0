From: akpm@linux-foundation.org
Subject: [patch 06/10] pata_hpt37x: Further small fixes
Date: Thu, 26 Apr 2007 00:19:25 -0700
Message-ID: <200704260719.l3Q7JPB2023694@shell0.pdx.osdl.net>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from smtp1.linux-foundation.org ([65.172.181.25]:44728 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S933257AbXDZHTn (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 26 Apr 2007 03:19:43 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org
Cc: linux-ide@vger.kernel.org, akpm@linux-foundation.org, alan@lxorguk.ukuu.org.uk, alan@redhat.com

From: Alan Cox <alan@lxorguk.ukuu.org.uk>

Further HPT37x changes

- No 66MHz 370/370A
- Remove dead special case check now we use the DPLL (as per the IDE driver)

Pointed out by Sergei

Signed-off-by: Alan Cox <alan@redhat.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 drivers/ata/pata_hpt37x.c |   23 +++++++++--------------
 1 file changed, 9 insertions(+), 14 deletions(-)

diff -puN drivers/ata/pata_hpt37x.c~pata_hpt37x-further-small-fixes drivers/ata/pata_hpt37x.c
--- a/drivers/ata/pata_hpt37x.c~pata_hpt37x-further-small-fixes
+++ a/drivers/ata/pata_hpt37x.c
@@ -26,7 +26,7 @@
 #include <linux/libata.h>
 
 #define DRV_NAME	"pata_hpt37x"
-#define DRV_VERSION	"0.6.4"
+#define DRV_VERSION	"0.6.5"
 
 struct hpt_clock {
 	u8	xfer_speed;
@@ -130,7 +130,7 @@ static const struct hpt_chip hpt370 = {
 		hpt37x_timings_33,
 		NULL,
 		NULL,
-		hpt37x_timings_66
+		NULL
 	}
 };
 
@@ -141,7 +141,7 @@ static const struct hpt_chip hpt370a = {
 		hpt37x_timings_33,
 		NULL,
 		hpt37x_timings_50,
-		hpt37x_timings_66
+		NULL
 	}
 };
 
@@ -1019,8 +1019,8 @@ static int hpt37x_init_one(struct pci_de
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
@@ -1132,16 +1132,11 @@ static int hpt37x_init_one(struct pci_de
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
_
