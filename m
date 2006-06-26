From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: PATCH: backport piix fixes from libata into the legacy driver
Date: Mon, 26 Jun 2006 14:50:09 +0100
Message-ID: <1151329809.27147.26.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from outpipe-village-512-1.bc.nu ([81.2.110.250]:34180 "EHLO
	lxorguk.ukuu.org.uk") by vger.kernel.org with ESMTP
	id S1751204AbWFZNeI (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 26 Jun 2006 09:34:08 -0400
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: akpm@osdl.org, linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org

Signed-off-by: Alan Cox <alan@redhat.com>

There are three flags being set by default by the PIIX driver for speeds
> PIO 1, and one not being cleared properly on fallback to PIO0. The
most important one is the prefetch/post write control which only works
for ATA and can do bad things with ATAPI.

The patch does its best to set the flags correctly for drivers/ide. Its
not 100% perfect but its closer than the original. 100% perfect requires
proper IORDY handling but this isn't critical (and its not right in
libata either .. yet)

Probably should live in -mm for a bit for testing

Alan


diff -u --new-file --recursive --exclude-from /usr/src/exclude linux.vanilla-2.6.17/drivers/ide/pci/piix.c linux-2.6.17/drivers/ide/pci/piix.c
--- linux.vanilla-2.6.17/drivers/ide/pci/piix.c	2006-06-19 17:17:24.000000000 +0100
+++ linux-2.6.17/drivers/ide/pci/piix.c	2006-06-26 13:44:49.296262720 +0100
@@ -222,29 +222,42 @@
 	unsigned long flags;
 	u16 master_data;
 	u8 slave_data;
+	int control = 0;
 				 /* ISP  RTC */
-	u8 timings[][2]	= { { 0, 0 },
-			    { 0, 0 },
-			    { 1, 0 },
-			    { 2, 1 },
-			    { 2, 3 }, };
+	static const u8 timings[][2]= { 
+					{ 0, 0 },
+					{ 0, 0 },
+					{ 1, 0 },
+					{ 2, 1 },
+					{ 2, 3 }, };
 
 	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
 	spin_lock_irqsave(&ide_lock, flags);
 	pci_read_config_word(dev, master_port, &master_data);
+	
+	if (pio >= 2)
+		control |= 1;	/* Programmable timing on */
+	if (drive->media == ide_disk)
+		control |= 4;	/* Prefetch, post write */
+	if (pio >= 3)
+		control |= 2;	/* IORDY */
 	if (is_slave) {
 		master_data = master_data | 0x4000;
-		if (pio > 1)
+		if (pio > 1) {
 			/* enable PPE, IE and TIME */
-			master_data = master_data | 0x0070;
+			master_data = master_data | (control << 4);
+		} else {
+			master_data &= ~0x0070;
+		}
 		pci_read_config_byte(dev, slave_port, &slave_data);
 		slave_data = slave_data & (hwif->channel ? 0x0f : 0xf0);
 		slave_data = slave_data | (((timings[pio][0] << 2) | timings[pio][1]) << (hwif->channel ? 4 : 0));
 	} else {
 		master_data = master_data & 0xccf8;
-		if (pio > 1)
+		if (pio > 1) {
 			/* enable PPE, IE and TIME */
-			master_data = master_data | 0x0007;
+			master_data = master_data | control;
+		}
 		master_data = master_data | (timings[pio][0] << 12) | (timings[pio][1] << 8);
 	}
 	pci_write_config_word(dev, master_port, master_data);

