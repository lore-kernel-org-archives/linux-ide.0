From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: Re: [PATCH] (2.6.20-rc7) cmd64x: fix PIO mode setup (take 2)
Date: Sun, 4 Feb 2007 00:04:24 +0300
Message-ID: <200702040004.24918.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:5704 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751672AbXBCVEb (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Feb 2007 16:04:31 -0500
In-Reply-To: <200702032309.43867.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

[Finally forgot to stamp MV's copyright on the driver, so here's take #2...]

The driver's tuneproc() method fails to set the drive's own speed -- fix this
by renaming the function to cmd64x_tune_pio(), making it return the mode set,
and "wrapping" the new tuneproc() method around it; while at it, also get rid
of the non-working prefetch control code, remove redundant PIO5 mode limitation,
and make cmdprintk() give more sensible mode info.  Also, get rid of the broken
config_chipset_for_pio() which always tried to set PIO4 instead auto-tuning PIO.
Note that removing a call from config_chipset_for_dma() breaks "rudimentary"
MWDMA2 support which can only work because of the timing registers being pre-
setup for PIO4 since the code in the speedproc() method which sets up the chip
for SW/MW DMA is completely bogus (!) and I'm going to remove it for the time
being in the next patch.
Oh, and add the missing PIO5 support to the speedproc() method while at it. :-)

Warning: compile tested only -- getting to the real hardware isn't that easy...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

 drivers/ide/pci/cmd64x.c |   95 ++++++++++++++++-------------------------------
 1 files changed, 34 insertions(+), 61 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.30	Sept 10, 2002
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.41	Feb 3, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -12,6 +12,7 @@
  * Copyright (C) 1998		David S. Miller (davem@redhat.com)
  *
  * Copyright (C) 1999-2002	Andre Hedrick <andre@linux-ide.org>
+ * Copyright (C) 2007		MontaVista Software, Inc. <source@mvista.com>
  */
 
 #include <linux/module.h>
@@ -262,43 +263,25 @@ static void program_drive_counts (ide_dr
 }
 
 /*
- * Attempts to set the interface PIO mode.
- * The preferred method of selecting PIO modes (e.g. mode 4) is 
- * "echo 'piomode:4' > /proc/ide/hdx/settings".  Special cases are
- * 8: prefetch off, 9: prefetch on, 255: auto-select best mode.
- * Called with 255 at boot time.
+ * This routine selects drive's best PIO mode, calculates setup/active/recovery
+ * counts, and writes them into the chipset registers.
  */
-
-static void cmd64x_tuneproc (ide_drive_t *drive, u8 mode_wanted)
+static u8 cmd64x_tune_pio (ide_drive_t *drive, u8 mode_wanted)
 {
 	int setup_time, active_time, recovery_time;
 	int clock_time, pio_mode, cycle_time;
 	u8 recovery_count2, cycle_count;
 	int setup_count, active_count, recovery_count;
 	int bus_speed = system_bus_clock();
-	/*byte b;*/
 	ide_pio_data_t  d;
 
-	switch (mode_wanted) {
-		case 8: /* set prefetch off */
-		case 9: /* set prefetch on */
-			mode_wanted &= 1;
-			/*set_prefetch_mode(index, mode_wanted);*/
-			cmdprintk("%s: %sabled cmd640 prefetch\n",
-				drive->name, mode_wanted ? "en" : "dis");
-			return;
-	}
-
-	mode_wanted = ide_get_best_pio_mode (drive, mode_wanted, 5, &d);
-	pio_mode = d.pio_mode;
+	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &d);
 	cycle_time = d.cycle_time;
 
 	/*
 	 * I copied all this complicated stuff from cmd640.c and made a few
 	 * minor changes.  For now I am just going to pray that it is correct.
 	 */
-	if (pio_mode > 5)
-		pio_mode = 5;
 	setup_time  = ide_pio_timings[pio_mode].setup_time;
 	active_time = ide_pio_timings[pio_mode].active_time;
 	recovery_time = cycle_time - (setup_time + active_time);
@@ -320,22 +303,27 @@ static void cmd64x_tuneproc (ide_drive_t
 	if (active_count > 16)
 		active_count = 16; /* maximum allowed by cmd646 */
 
-	/*
-	 * In a perfect world, we might set the drive pio mode here
-	 * (using WIN_SETFEATURE) before continuing.
-	 *
-	 * But we do not, because:
-	 *	1) this is the wrong place to do it
-	 *		(proper is do_special() in ide.c)
-	 * 	2) in practice this is rarely, if ever, necessary
-	 */
 	program_drive_counts (drive, setup_count, active_count, recovery_count);
 
-	cmdprintk("%s: selected cmd646 PIO mode%d : %d (%dns)%s, "
+	cmdprintk("%s: PIO mode wanted %d, selected %d (%dns)%s, "
 		"clocks=%d/%d/%d\n",
-		drive->name, pio_mode, mode_wanted, cycle_time,
+		drive->name, mode_wanted, pio_mode, cycle_time,
 		d.overridden ? " (overriding vendor mode)" : "",
 		setup_count, active_count, recovery_count);
+
+	return pio_mode;
+}
+
+/*
+ * Attempts to set drive's PIO mode.
+ * The preferred method of selecting PIO modes (e.g. mode 4) is
+ * "echo 'piomode:4' > /proc/ide/hdx/settings".
+ * Special case is 255: auto-select best mode (used at boot time).
+ */
+static void cmd64x_tune_drive (ide_drive_t *drive, u8 pio)
+{
+	pio = cmd64x_tune_pio(drive, pio);
+	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
 static u8 cmd64x_ratemask (ide_drive_t *drive)
@@ -387,22 +375,6 @@ static u8 cmd64x_ratemask (ide_drive_t *
 	return mode;
 }
 
-static void config_cmd64x_chipset_for_pio (ide_drive_t *drive, u8 set_speed)
-{
-	u8 speed	= 0x00;
-	u8 set_pio	= ide_get_best_pio_mode(drive, 4, 5, NULL);
-
-	cmd64x_tuneproc(drive, set_pio);
-	speed = XFER_PIO_0 + set_pio;
-	if (set_speed)
-		(void) ide_config_drive_speed(drive, speed);
-}
-
-static void config_chipset_for_pio (ide_drive_t *drive, u8 set_speed)
-{
-	config_cmd64x_chipset_for_pio(drive, set_speed);
-}
-
 static int cmd64x_tune_chipset (ide_drive_t *drive, u8 xferspeed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
@@ -414,7 +386,7 @@ static int cmd64x_tune_chipset (ide_driv
 
 	u8 speed	= ide_rate_filter(cmd64x_ratemask(drive), xferspeed);
 
-	if (speed > XFER_PIO_4) {
+	if (speed >= XFER_SW_DMA_0) {
 		(void) pci_read_config_byte(dev, pciD, &regD);
 		(void) pci_read_config_byte(dev, pciU, &regU);
 		regD &= ~(unit ? 0x40 : 0x20);
@@ -438,17 +410,20 @@ static int cmd64x_tune_chipset (ide_driv
 		case XFER_SW_DMA_2:	regD |= (unit ? 0x40 : 0x10); break;
 		case XFER_SW_DMA_1:	regD |= (unit ? 0x80 : 0x20); break;
 		case XFER_SW_DMA_0:	regD |= (unit ? 0xC0 : 0x30); break;
-		case XFER_PIO_4:	cmd64x_tuneproc(drive, 4); break;
-		case XFER_PIO_3:	cmd64x_tuneproc(drive, 3); break;
-		case XFER_PIO_2:	cmd64x_tuneproc(drive, 2); break;
-		case XFER_PIO_1:	cmd64x_tuneproc(drive, 1); break;
-		case XFER_PIO_0:	cmd64x_tuneproc(drive, 0); break;
+		case XFER_PIO_5:
+		case XFER_PIO_4:
+		case XFER_PIO_3:
+		case XFER_PIO_2:
+		case XFER_PIO_1:
+		case XFER_PIO_0:
+			(void) cmd64x_tune_pio(drive, speed - XFER_PIO_0);
+			break;
 
 		default:
 			return 1;
 	}
 
-	if (speed > XFER_PIO_4) {
+	if (speed >= XFER_SW_DMA_0) {
 		(void) pci_write_config_byte(dev, pciU, regU);
 		regD |= (unit ? 0x40 : 0x20);
 		(void) pci_write_config_byte(dev, pciD, regD);
@@ -461,8 +436,6 @@ static int config_chipset_for_dma (ide_d
 {
 	u8 speed	= ide_dma_speed(drive, cmd64x_ratemask(drive));
 
-	config_chipset_for_pio(drive, !speed);
-
 	if (!speed)
 		return 0;
 
@@ -491,7 +464,7 @@ static int cmd64x_config_drive_for_dma (
 
 	} else if ((id->capability & 8) || (id->field_valid & 2)) {
 fast_ata_pio:
-		config_chipset_for_pio(drive, 1);
+		cmd64x_tune_drive(drive, 255);
 		return hwif->ide_dma_off_quietly(drive);
 	}
 	/* IORDY not supported */
@@ -694,7 +667,7 @@ static void __devinit init_hwif_cmd64x(i
 	pci_read_config_dword(dev, PCI_CLASS_REVISION, &class_rev);
 	class_rev &= 0xff;
 
-	hwif->tuneproc  = &cmd64x_tuneproc;
+	hwif->tuneproc  = &cmd64x_tune_drive;
 	hwif->speedproc = &cmd64x_tune_chipset;
 
 	if (!hwif->dma_base) {

