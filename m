From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 6/6] opti621: add PIO 4 support
Date: Wed, 11 Jun 2008 22:01:45 +0200
Message-ID: <200806112201.45328.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.159]:60506 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754934AbYFKU0S (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:26:18 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234784fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:26:17 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Juergen Kosel <juergen.kosel@gmx.de>

* Add PIO 4 support.

While at it:

* Use a single struct ide_port_info instance for OPTi621 and OPTi621X.

Based on a bugreport from Juergen Kosel & inspired by pata_opti.c code.

Tested-by: Juergen Kosel <juergen.kosel@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/opti621.c |   46 ++++++++++++++--------------------------------
 1 file changed, 14 insertions(+), 32 deletions(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -90,16 +90,6 @@
 
 #include <asm/io.h>
 
-//#define OPTI621_MAX_PIO 3
-/* In fact, I do not have any PIO 4 drive
- * (address: 25 ns, data: 70 ns, recovery: 35 ns),
- * but OPTi 82C621 is programmable and it can do (minimal values):
- * on 40MHz PCI bus (pulse 25 ns):
- *  address: 25 ns, data: 25 ns, recovery: 50 ns;
- * on 20MHz PCI bus (pulse 50 ns):
- *  address: 50 ns, data: 50 ns, recovery: 100 ns.
- */
-
 #define READ_REG 0	/* index of Read cycle timing register */
 #define WRITE_REG 1	/* index of Write cycle timing register */
 #define CNTRL_REG 3	/* index of Control register */
@@ -150,13 +140,13 @@ static void opti621_set_pio_mode(ide_dri
 	u8 tim, misc, addr_pio = pio, clk;
 
 	/* DRDY is default 2 (by OPTi Databook) */
-	static const u8 addr_timings[2][4] = {
-		{ 0x20, 0x10, 0x00, 0x00 },	/* 33 MHz */
-		{ 0x10, 0x10, 0x00, 0x00 },	/* 25 MHz */
+	static const u8 addr_timings[2][5] = {
+		{ 0x20, 0x10, 0x00, 0x00, 0x00 },	/* 33 MHz */
+		{ 0x10, 0x10, 0x00, 0x00, 0x00 },	/* 25 MHz */
 	};
-	static const u8 data_rec_timings[2][4] = {
-		{ 0x5b, 0x45, 0x32, 0x21 },	/* 33 MHz */
-		{ 0x48, 0x34, 0x21, 0x10 }	/* 25 MHz */
+	static const u8 data_rec_timings[2][5] = {
+		{ 0x5b, 0x45, 0x32, 0x21, 0x20 },	/* 33 MHz */
+		{ 0x48, 0x34, 0x21, 0x10, 0x10 }	/* 25 MHz */
 	};
 
 	drive->drive_data = XFER_PIO_0 + pio;
@@ -209,30 +199,22 @@ static const struct ide_port_ops opti621
 	.set_pio_mode		= opti621_set_pio_mode,
 };
 
-static const struct ide_port_info opti621_chipsets[] __devinitdata = {
-	{	/* 0 */
-		.name		= "OPTI621",
-		.enablebits	= { {0x45, 0x80, 0x00}, {0x40, 0x08, 0x00} },
-		.port_ops	= &opti621_port_ops,
-		.host_flags	= IDE_HFLAG_NO_DMA,
-		.pio_mask	= ATA_PIO3,
-	}, {	/* 1 */
-		.name		= "OPTI621X",
-		.enablebits	= { {0x45, 0x80, 0x00}, {0x40, 0x08, 0x00} },
-		.port_ops	= &opti621_port_ops,
-		.host_flags	= IDE_HFLAG_NO_DMA,
-		.pio_mask	= ATA_PIO3,
-	}
+static const struct ide_port_info opti621_chipset __devinitdata = {
+	.name		= "OPTI621/X",
+	.enablebits	= { {0x45, 0x80, 0x00}, {0x40, 0x08, 0x00} },
+	.port_ops	= &opti621_port_ops,
+	.host_flags	= IDE_HFLAG_NO_DMA,
+	.pio_mask	= ATA_PIO4,
 };
 
 static int __devinit opti621_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	return ide_setup_pci_device(dev, &opti621_chipsets[id->driver_data]);
+	return ide_setup_pci_device(dev, &opti621_chipset);
 }
 
 static const struct pci_device_id opti621_pci_tbl[] = {
 	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C621), 0 },
-	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C825), 1 },
+	{ PCI_VDEVICE(OPTI, PCI_DEVICE_ID_OPTI_82C825), 0 },
 	{ 0, },
 };
 MODULE_DEVICE_TABLE(pci, opti621_pci_tbl);
