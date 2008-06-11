From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/6] opti621: use PCI clock value provided by controller
Date: Wed, 11 Jun 2008 21:59:00 +0200
Message-ID: <200806112159.00256.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:60653 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754022AbYFKU0L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:26:11 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234785fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:26:10 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Juergen Kosel <juergen.kosel@gmx.de>

Use PCI clock value provided by controller instead of depending on
a default (or user supplied) value.

Based on a bugreport from Juergen Kosel & inspired by pata_opti.c code.

Tested-by: Juergen Kosel <juergen.kosel@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/opti621.c |   42 ++++++++++++++++++++++--------------------
 1 file changed, 22 insertions(+), 20 deletions(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -193,11 +193,10 @@ typedef struct pio_clocks_s {
 	int	recovery_time;	/* Recovery time (clocks) */
 } pio_clocks_t;
 
-static void compute_clocks(int pio, pio_clocks_t *clks)
+static void compute_clocks(int pio, pio_clocks_t *clks, int bus_speed)
 {
 	if (pio != PIO_NOT_EXIST) {
 		int adr_setup, data_pls;
-		int bus_speed = ide_pci_clk ? ide_pci_clk : system_bus_clock();
 
 		adr_setup = ide_pio_timings[pio].setup_time;
 		data_pls = ide_pio_timings[pio].active_time;
@@ -234,7 +233,7 @@ static void opti621_set_pio_mode(ide_dri
 	u8 pio1 = 0, pio2 = 0;
 	pio_clocks_t first, second;
 	int ax, drdy;
-	u8 cycle1, cycle2, misc;
+	u8 cycle1, cycle2, misc, clk;
 	ide_hwif_t *hwif = HWIF(drive);
 
 	/* sets drive->drive_data for both drives */
@@ -242,8 +241,26 @@ static void opti621_set_pio_mode(ide_dri
 	pio1 = hwif->drives[0].drive_data;
 	pio2 = hwif->drives[1].drive_data;
 
-	compute_clocks(pio1, &first);
-	compute_clocks(pio2, &second);
+	spin_lock_irqsave(&opti621_lock, flags);
+
+	reg_base = hwif->io_ports.data_addr;
+
+	/* allow Register-B */
+	outb(0xc0, reg_base + CNTRL_REG);
+	/* hmm, setupvic.exe does this ;-) */
+	outb(0xff, reg_base + 5);
+	/* if reads 0xff, adapter not exist? */
+	(void)inb(reg_base + CNTRL_REG);
+	/* if reads 0xc0, no interface exist? */
+	read_reg(CNTRL_REG);
+
+	/* check CLK speed */
+	clk = read_reg(STRAP_REG) & 1;
+
+	printk(KERN_INFO "%s: CLK = %d MHz\n", hwif->name, clk ? 25 : 33);
+
+	compute_clocks(pio1, &first,  clk ? 25 : 33);
+	compute_clocks(pio2, &second, clk ? 25 : 33);
 
 	/* ax = max(a1,a2) */
 	ax = (first.address_time < second.address_time) ? second.address_time : first.address_time;
@@ -266,21 +283,6 @@ static void opti621_set_pio_mode(ide_dri
 		second.recovery_time, drdy);
 #endif
 
-	spin_lock_irqsave(&opti621_lock, flags);
-
-	reg_base = hwif->io_ports.data_addr;
-
-	/* allow Register-B */
-	outb(0xc0, reg_base + CNTRL_REG);
-	/* hmm, setupvic.exe does this ;-) */
-	outb(0xff, reg_base + 5);
-	/* if reads 0xff, adapter not exist? */
-	(void)inb(reg_base + CNTRL_REG);
-	/* if reads 0xc0, no interface exist? */
-	read_reg(CNTRL_REG);
-	/* read version, probably 0 */
-	read_reg(STRAP_REG);
-
 	/* program primary drive */
 	/* select Index-0 for Register-A */
 	write_reg(0, MISC_REG);
