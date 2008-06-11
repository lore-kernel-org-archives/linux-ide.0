From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 4/6] opti621: program devices timings separately in ->set_pio_mode
Date: Wed, 11 Jun 2008 21:59:58 +0200
Message-ID: <200806112159.58816.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from fg-out-1718.google.com ([72.14.220.152]:60265 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754171AbYFKU0O (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 11 Jun 2008 16:26:14 -0400
Received: by fg-out-1718.google.com with SMTP id 19so2234733fgg.17
        for <linux-ide@vger.kernel.org>; Wed, 11 Jun 2008 13:26:13 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Juergen Kosel <juergen.kosel@gmx.de>

* Set drive->drive_data to 'pio + XFER_PIO_0' instead of 'pio',
  then simplify selecting maximum adress setup timing.

* Remove no longer needed compute_pios() and opti621_port_init_devs().

* Program devices timings separately in ->set_pio_mode.

Based on a bugreport from Juergen Kosel & inspired by pata_opti.c code.

Tested-by: Juergen Kosel <juergen.kosel@gmx.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/pci/opti621.c |   80 ++++++++--------------------------------------
 1 file changed, 15 insertions(+), 65 deletions(-)

Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -115,34 +115,6 @@ static int reg_base;
 
 static DEFINE_SPINLOCK(opti621_lock);
 
-/* there are stored pio numbers from other calls of opti621_set_pio_mode */
-static void compute_pios(ide_drive_t *drive, const u8 pio)
-/* Store values into drive->drive_data
- *	second_contr - 0 for primary controller, 1 for secondary
- *	slave_drive - 0 -> pio is for master, 1 -> pio is for slave
- *	pio - PIO mode for selected drive (for other we don't know)
- */
-{
-	int d;
-	ide_hwif_t *hwif = HWIF(drive);
-
-	drive->drive_data = pio;
-
-	for (d = 0; d < 2; ++d) {
-		drive = &hwif->drives[d];
-		if (drive->present) {
-			if (drive->drive_data == PIO_DONT_KNOW)
-				drive->drive_data = ide_get_best_pio_mode(drive, 255, 3);
-#ifdef OPTI621_DEBUG
-			printk("%s: Selected PIO mode %d\n",
-				drive->name, drive->drive_data);
-#endif
-		} else {
-			drive->drive_data = PIO_NOT_EXIST;
-		}
-	}
-}
-
 static int cmpt_clk(int time, int bus_speed)
 /* Returns (rounded up) time in clocks for time in ns,
  * with bus_speed in MHz.
@@ -226,20 +198,19 @@ static void compute_clocks(int pio, pio_
 
 static void opti621_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	/* primary and secondary drives share some registers,
-	 * so we have to program both drives
-	 */
+	ide_hwif_t *hwif = drive->hwif;
+	ide_drive_t *pair = ide_get_paired_drive(drive);
 	unsigned long flags;
-	u8 pio1 = 0, pio2 = 0;
 	pio_clocks_t first, second;
 	int ax, drdy;
-	u8 cycle1, cycle2, misc, clk;
-	ide_hwif_t *hwif = HWIF(drive);
+	u8 cycle1, misc, clk, addr_pio = pio;
 
-	/* sets drive->drive_data for both drives */
-	compute_pios(drive, pio);
-	pio1 = hwif->drives[0].drive_data;
-	pio2 = hwif->drives[1].drive_data;
+	drive->drive_data = XFER_PIO_0 + pio;
+
+	if (pair->present) {
+		if (pair->drive_data && pair->drive_data < drive->drive_data)
+			addr_pio = pair->drive_data - XFER_PIO_0;
+	}
 
 	spin_lock_irqsave(&opti621_lock, flags);
 
@@ -259,8 +230,8 @@ static void opti621_set_pio_mode(ide_dri
 
 	printk(KERN_INFO "%s: CLK = %d MHz\n", hwif->name, clk ? 25 : 33);
 
-	compute_clocks(pio1, &first,  clk ? 25 : 33);
-	compute_clocks(pio2, &second, clk ? 25 : 33);
+	compute_clocks(pio, &first, clk ? 25 : 33);
+	compute_clocks(addr_pio, &second, clk ? 25 : 33);
 
 	/* ax = max(a1,a2) */
 	ax = (first.address_time < second.address_time) ? second.address_time : first.address_time;
@@ -268,37 +239,23 @@ static void opti621_set_pio_mode(ide_dri
 	drdy = 2; /* DRDY is default 2 (by OPTi Databook) */
 
 	cycle1 = ((first.data_time-1)<<4)  | (first.recovery_time-2);
-	cycle2 = ((second.data_time-1)<<4) | (second.recovery_time-2);
 
 	misc = ((ax - 1) << 4) | ((drdy - 2) << 1);
 
 #ifdef OPTI621_DEBUG
-	printk("%s: master: address: %d, data: %d, "
+	printk("%s: address: %d, data: %d, "
 		"recovery: %d, drdy: %d [clk]\n",
-		hwif->name, ax, first.data_time,
+		drive->name, ax, first.data_time,
 		first.recovery_time, drdy);
-	printk("%s: slave:  address: %d, data: %d, "
-		"recovery: %d, drdy: %d [clk]\n",
-		hwif->name, ax, second.data_time,
-		second.recovery_time, drdy);
 #endif
 
-	/* program primary drive */
-	/* select Index-0 for Register-A */
-	write_reg(0, MISC_REG);
+	/* select Index-0/1 for Register-A/B */
+	write_reg(drive->select.b.unit, MISC_REG);
 	/* set read cycle timings */
 	write_reg(cycle1, READ_REG);
 	/* set write cycle timings */
 	write_reg(cycle1, WRITE_REG);
 
-	/* program secondary drive */
-	/* select Index-1 for Register-B */
-	write_reg(1, MISC_REG);
-	/* set read cycle timings */
-	write_reg(cycle2, READ_REG);
-	/* set write cycle timings */
-	write_reg(cycle2, WRITE_REG);
-
 	/* use Register-A for drive 0 */
 	/* use Register-B for drive 1 */
 	write_reg(0x85, CNTRL_REG);
@@ -310,14 +267,7 @@ static void opti621_set_pio_mode(ide_dri
 	spin_unlock_irqrestore(&opti621_lock, flags);
 }
 
-static void __devinit opti621_port_init_devs(ide_hwif_t *hwif)
-{
-	hwif->drives[0].drive_data = PIO_DONT_KNOW;
-	hwif->drives[1].drive_data = PIO_DONT_KNOW;
-}
-
 static const struct ide_port_ops opti621_port_ops = {
-	.port_init_devs		= opti621_port_init_devs,
 	.set_pio_mode		= opti621_set_pio_mode,
 };
 
