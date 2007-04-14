From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] cmd64x: add/fix enablebits (take 2)
Date: Sat, 14 Apr 2007 23:31:51 +0400
Message-ID: <200704142331.51648.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702150135.28934.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:61330 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751311AbXDNTbE (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Apr 2007 15:31:04 -0400
In-Reply-To: <200702150135.28934.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The IDE core looks at the wrong bit when checking if the secondary channel is
enabled on PCI0646 -- CNTRL register bit 7 is read-ahead disable, bit 3 is the
correct one.
Starting with PCI0646U chip, the primary channel can also be enabled/disabled --
so, add 'enablebits' initializers to each 'ide_pci_device_t' structure, handling
the original PCI0646 via adding the init_setup() method and clearing the 'reg'
field there if necessary...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
This is an update due to patch order changes.  Has also been tested on PCI-649.

 drivers/ide/pci/cmd64x.c |   39 ++++++++++++++++++++++++++++++++++++---
 1 files changed, 36 insertions(+), 3 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,5 +1,5 @@
 /*
- * linux/drivers/ide/pci/cmd64x.c		Version 1.44	Mar 12, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.45	Mar 14, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Due to massive hardware bugs, UltraDMA is only supported
@@ -684,42 +684,75 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->drives[1].autodma = hwif->autodma;
 }
 
+static int __devinit init_setup_cmd64x(struct pci_dev *dev, ide_pci_device_t *d)
+{
+	return ide_setup_pci_device(dev, d);
+}
+
+static int __devinit init_setup_cmd646(struct pci_dev *dev, ide_pci_device_t *d)
+{
+	u8 rev = 0;
+
+	/*
+	 * The original PCI0646 didn't have the primary channel enable bit,
+	 * it appeared starting with PCI0646U (i.e. revision ID 3).
+	 */
+	pci_read_config_byte(dev, PCI_REVISION_ID, &rev);
+	if (rev < 3)
+		d->enablebits[0].reg = 0;
+
+	return ide_setup_pci_device(dev, d);
+}
+
 static ide_pci_device_t cmd64x_chipsets[] __devinitdata = {
 	{	/* 0 */
 		.name		= "CMD643",
+		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
 	},{	/* 1 */
 		.name		= "CMD646",
+		.init_setup	= init_setup_cmd646,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
-		.enablebits	= {{0x00,0x00,0x00}, {0x51,0x80,0x80}},
+		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
 	},{	/* 2 */
 		.name		= "CMD648",
+		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
 	},{	/* 3 */
 		.name		= "CMD649",
+		.init_setup	= init_setup_cmd64x,
 		.init_chipset	= init_chipset_cmd64x,
 		.init_hwif	= init_hwif_cmd64x,
 		.channels	= 2,
 		.autodma	= AUTODMA,
+		.enablebits	= {{0x51,0x04,0x04}, {0x51,0x08,0x08}},
 		.bootable	= ON_BOARD,
 	}
 };
 
+/*
+ * We may have to modify enablebits for PCI0646, so we'd better pass
+ * a local copy of the ide_pci_device_t structure down the call chain...
+ */
 static int __devinit cmd64x_init_one(struct pci_dev *dev, const struct pci_device_id *id)
 {
-	return ide_setup_pci_device(dev, &cmd64x_chipsets[id->driver_data]);
+	ide_pci_device_t d = cmd64x_chipsets[id->driver_data];
+
+	return d.init_setup(dev, &d);
 }
 
 static struct pci_device_id cmd64x_pci_tbl[] = {

