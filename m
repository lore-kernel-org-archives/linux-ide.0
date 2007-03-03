From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6 fix queue] cmd64x: fix recovery time calculation (take 3)
Date: Sat, 3 Mar 2007 23:17:10 +0300
Message-ID: <200703032317.10173.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com> <200702262332.31751.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:46456 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751723AbXCCURT (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sat, 3 Mar 2007 15:17:19 -0500
In-Reply-To: <200702262332.31751.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

[PATCH] cmd64x: fix recovery time calculation

The driver wrongly takes the address setup time into account when calculating
the PIO recovery time -- this leads to slight overclocking of the PIO modes 0
and 1 (so, the prayers failed to help, as usual :-).  Rework the code to be
calculating recovery clock count as a difference between the total cycle count
and the active count (we don't need to calculate the recovery time itself since
it's not specified for the PIO modes 0 to 2, and for modes 3 and 4 this formula
gives enough recovery time anyway in the chip's supported PCI frequency range).

This patch has been inspired by reading the datasheets and looking at what the
libata driver does; it has been compile-tested only (as usual :-) but anyway,
the new code gives the same or longer recovery times than the old one...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>

---
This patch has been changed in accordance to the pending reordering as DMA
support removal and addition patches are going to be merged.  In addition,
I've put quantize_timing() to its proper place to avoid moving it later...

 drivers/ide/pci/cmd64x.c |   49 +++++++++++++++++++++--------------------------
 1 files changed, 22 insertions(+), 27 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.41	Feb 3, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.42	Feb 8, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -189,6 +189,11 @@ static int cmd64x_get_info (char *buffer
 
 #endif	/* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS) */
 
+static u8 quantize_timing(int timing, int quant)
+{
+	return (timing + quant - 1) / quant;
+}
+
 /*
  * This routine writes the prepared setup/active/recovery counts
  * for a drive into the cmd646 chipset registers to active them.
@@ -268,47 +273,37 @@ static void program_drive_counts (ide_dr
  */
 static u8 cmd64x_tune_pio (ide_drive_t *drive, u8 mode_wanted)
 {
-	int setup_time, active_time, recovery_time;
-	int clock_time, pio_mode, cycle_time;
-	u8 recovery_count2, cycle_count;
-	int setup_count, active_count, recovery_count;
-	int bus_speed = system_bus_clock();
-	ide_pio_data_t  d;
+	int setup_time, active_time, cycle_time;
+	u8  cycle_count, setup_count, active_count, recovery_count;
+	u8  pio_mode;
+	int clock_time = 1000 / system_bus_clock();
+	ide_pio_data_t pio;
 
-	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &d);
-	cycle_time = d.cycle_time;
+	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &pio);
+	cycle_time = pio.cycle_time;
 
-	/*
-	 * I copied all this complicated stuff from cmd640.c and made a few
-	 * minor changes.  For now I am just going to pray that it is correct.
-	 */
 	setup_time  = ide_pio_timings[pio_mode].setup_time;
 	active_time = ide_pio_timings[pio_mode].active_time;
-	recovery_time = cycle_time - (setup_time + active_time);
-	clock_time = 1000 / bus_speed;
-	cycle_count = (cycle_time + clock_time - 1) / clock_time;
-
-	setup_count = (setup_time + clock_time - 1) / clock_time;
-
-	active_count = (active_time + clock_time - 1) / clock_time;
-
-	recovery_count = (recovery_time + clock_time - 1) / clock_time;
-	recovery_count2 = cycle_count - (setup_count + active_count);
-	if (recovery_count2 > recovery_count)
-		recovery_count = recovery_count2;
+
+	setup_count  = quantize_timing( setup_time, clock_time);
+	cycle_count  = quantize_timing( cycle_time, clock_time);
+	active_count = quantize_timing(active_time, clock_time);
+
+	recovery_count = cycle_count - active_count;
+	/* program_drive_counts() takes care of zero recovery cycles */
 	if (recovery_count > 16) {
 		active_count += recovery_count - 16;
 		recovery_count = 16;
 	}
 	if (active_count > 16)
-		active_count = 16; /* maximum allowed by cmd646 */
+		active_count = 16; /* maximum allowed by cmd64x */
 
 	program_drive_counts (drive, setup_count, active_count, recovery_count);
 
 	cmdprintk("%s: PIO mode wanted %d, selected %d (%dns)%s, "
 		"clocks=%d/%d/%d\n",
 		drive->name, mode_wanted, pio_mode, cycle_time,
-		d.overridden ? " (overriding vendor mode)" : "",
+		pio.overridden ? " (overriding vendor mode)" : "",
 		setup_count, active_count, recovery_count);
 
 	return pio_mode;

