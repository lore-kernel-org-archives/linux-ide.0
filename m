From: Alan <alan@lxorguk.ukuu.org.uk>
Subject: [PATCH] libata: Add a host flag to indicate lack of IORDY
 capability
Date: Mon, 5 Feb 2007 16:15:15 +0000
Message-ID: <20070205161515.38b8107d@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:56035 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751532AbXBEQC2 (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Mon, 5 Feb 2007 11:02:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: jeff@garzik.org, linux-ide@vger.kernel.org, akpm@osdl.org

This is the first preparation to doing the !IORDY cases properly. Further
diffs will then add the needed logic to do it right.

Signed-off-by: Alan Cox <alan@redhat.com>

diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/include/linux/libata.h linux-2.6.20-rc6-mm3/include/linux/libata.h
--- linux.vanilla-2.6.20-rc6-mm3/include/linux/libata.h	2007-01-31 14:20:43.000000000 +0000
+++ linux-2.6.20-rc6-mm3/include/linux/libata.h	2007-02-01 16:11:57.000000000 +0000
@@ -175,6 +175,7 @@
 	ATA_FLAG_DEBUGMSG	= (1 << 13),
 	ATA_FLAG_SETXFER_POLLING= (1 << 14), /* use polling for SETXFER */
 	ATA_FLAG_IGN_SIMPLEX	= (1 << 15), /* ignore SIMPLEX */
+	ATA_FLAG_NO_IORDY	= (1 << 16), /* controller lacks iordy */
 
 	/* The following flag belongs to ap->pflags but is kept in
 	 * ap->flags because it's referenced in many LLDs and will be
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_qdi.c linux-2.6.20-rc6-mm3/drivers/ata/pata_qdi.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_qdi.c	2007-01-31 14:20:10.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/pata_qdi.c	2007-01-31 14:31:28.000000000 +0000
@@ -257,16 +257,17 @@
 	if (type == 6580) {
 		ae.port_ops = &qdi6580_port_ops;
 		ae.pio_mask = 0x1F;
+		ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
 	} else {
 		ae.port_ops = &qdi6500_port_ops;
 		ae.pio_mask = 0x07;	/* Actually PIO3 !IORDY is possible */
+		ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST | ATA_FLAG_NO_IORDY;
 	}
 
 	ae.sht = &qdi_sht;
 	ae.n_ports = 1;
 	ae.irq = irq;
 	ae.irq_flags = 0;
-	ae.port_flags = ATA_FLAG_SLAVE_POSS | ATA_FLAG_SRST;
 	ae.port[0].cmd_addr = io;
 	ae.port[0].altstatus_addr = ctrl;
 	ae.port[0].ctl_addr =	ctrl;
diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_legacy.c linux-2.6.20-rc6-mm3/drivers/ata/pata_legacy.c
--- linux.vanilla-2.6.20-rc6-mm3/drivers/ata/pata_legacy.c	2007-01-31 14:20:39.000000000 +0000
+++ linux-2.6.20-rc6-mm3/drivers/ata/pata_legacy.c	2007-02-01 16:07:10.000000000 +0000
@@ -89,9 +89,10 @@
 static int ht6560a;			/* HT 6560A on primary 1, secondary 2, both 3 */
 static int ht6560b;			/* HT 6560A on primary 1, secondary 2, both 3 */
 static int opti82c611a;			/* Opti82c611A on primary 1, secondary 2, both 3 */
-static int opti82c46x;		/* Opti 82c465MV present (pri/sec autodetect) */
+static int opti82c46x;			/* Opti 82c465MV present (pri/sec autodetect) */
 static int autospeed;			/* Chip present which snoops speed changes */
 static int pio_mask = 0x1F;		/* PIO range for autospeed devices */
++static int iordy_mask = 0xFFFFFFFF;	/* Use iordy if available */
 
 /**
  *	legacy_set_mode		-	mode setting
@@ -113,6 +114,7 @@
 	for (i = 0; i < ATA_MAX_DEVICES; i++) {
 		struct ata_device *dev = &ap->device[i];
 		if (ata_dev_enabled(dev)) {
+			ata_dev_printk(dev, KERN_INFO, "configured for PIO\n");
 			dev->pio_mode = XFER_PIO_0;
 			dev->xfer_mode = XFER_PIO_0;
 			dev->xfer_shift = ATA_SHIFT_PIO;
@@ -693,6 +695,7 @@
 	struct ata_port_operations *ops = &legacy_port_ops;
 	int pio_modes = pio_mask;
 	u32 mask = (1 << port);
+	u32 iordy = (iordy_mask & mask) ? 0: ATA_FLAG_NO_IORDY;
 
 	if (request_region(io, 8, "pata_legacy") == NULL)
 		return -EBUSY;
@@ -708,6 +711,7 @@
 	if (ht6560a & mask) {
 		ops = &ht6560a_port_ops;
 		pio_modes = 0x07;
+		iordy = ATA_FLAG_NO_IORDY;
 	}
 	if (ht6560b & mask) {
 		ops = &ht6560b_port_ops;
@@ -743,6 +747,7 @@
 			printk(KERN_INFO "PDC20230-C/20630 VLB ATA controller detected.\n");
 				pio_modes = 0x07;
 			ops = &pdc20230_port_ops;
+			iordy = ATA_FLAG_NO_IORDY;
 			udelay(100);
 			inb(0x1F5);
 		} else {
@@ -760,6 +765,7 @@
 	/* Chip does mode setting by command snooping */
 	if (ops == &legacy_port_ops && (autospeed & mask))
 		ops = &simple_port_ops;
+
 	memset(&ae, 0, sizeof(struct ata_probe_ent));
 	INIT_LIST_HEAD(&ae.node);
 	ae.dev = &pdev->dev;
@@ -769,7 +775,7 @@
 	ae.pio_mask = pio_modes;
 	ae.irq = irq;
 	ae.irq_flags = 0;
-	ae.port_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST;
+	ae.port_flags = ATA_FLAG_SLAVE_POSS|ATA_FLAG_SRST|iordy;
 	ae.port[0].cmd_addr = io;
 	ae.port[0].altstatus_addr = ctrl;
 	ae.port[0].ctl_addr =	ctrl;
@@ -947,6 +953,7 @@
 module_param(opti82c611a, int, 0);
 module_param(opti82c46x, int, 0);
 module_param(pio_mask, int, 0);
+module_param(iordy_mask, int, 0);
 
 module_init(legacy_init);
 module_exit(legacy_exit);
