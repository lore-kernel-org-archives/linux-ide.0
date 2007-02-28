From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) cmd64x: add back MWDMA support
Date: Wed, 28 Feb 2007 23:52:41 +0300
Message-ID: <200702282352.41128.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:19060 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750718AbXB1Uws (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Wed, 28 Feb 2007 15:52:48 -0500
In-Reply-To: <200702040004.24918.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Add back the multiword DMA support (I think nobody will miss single-word DMA).
In order to do it, a number of changes had to be done:

- rename program_drive_counts() to program_cycle_times(), pass to it cycle's
  total/active times instead of the clock counts, and convert them into the
  active/recovery clocks there instead of cmd64x_tune_pio() -- this causes
  quantize_timing() to also move;

- contrarywise, move all the code handling the address setup timing into
  cmd64x_tune_pio(), so that setting MWDMA mode wouldn't change address setup;

- add MWDMA cases to the speedproc() method and handle them by just calling
  program_cycle_times();

- set hwif->mdwma_mask in the init_hwif() method.

In addition to those changes, do the following:

- when writing to ARTTIM23 register for the secondary channel, preserve the
  interrupt status bit; eliminate the local_irq_{save|restore}() around this
  code as there is *no* actual race with interrupt handler;

- make {arttim|drwtim}_regs[] single-dimensional, indexed with drive->dn;

- rename {setup|recovery}_counts[] into more fitting {setup|recovery}_values[];

While at it, also do remove:

- needless and misplaced timing registers initialization in the init_chipset()
  method;

- meaningless register "aliases";

- meaningless comment about the driver being used only on SPARC Ultra. :-)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Warning: this has only been compile-tested, as usual, so *needs* real testing.

Note that this implementation doesn't take care of properly merging MWDMA and
PIO timings which share the same registers (well, that's not done by the most
IDE drivers anyway).

Still have no idea about why PPC needs to explicitly disable UltraDMA on the
primary channel -- it should be disabled by default...

 drivers/ide/pci/cmd64x.c |  194 +++++++++++++++++++++--------------------------
 1 files changed, 88 insertions(+), 106 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,10 +1,8 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.47	Feb 16, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.50	Feb 27, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
- *           Note, this driver is not used at all on other systems because
- *           there the "BIOS" has done all of the following already.
  *           Due to massive hardware bugs, UltraDMA is only supported
  *           on the 646U2 and not on the 646U.
  *
@@ -55,9 +53,6 @@
 #define   ARTTIM23_DIS_RA2	0x04
 #define   ARTTIM23_DIS_RA3	0x08
 #define   ARTTIM23_INTR_CH1	0x10
-#define ARTTIM2		0x57
-#define ARTTIM3		0x57
-#define DRWTIM23	0x58
 #define DRWTIM2		0x58
 #define BRST		0x59
 #define DRWTIM3		0x5b
@@ -168,122 +163,111 @@ static int cmd64x_get_info (char *buffer
 
 #endif	/* defined(DISPLAY_CMD64X_TIMINGS) && defined(CONFIG_PROC_FS) */
 
+static u8 quantize_timing (int timing, int quant)
+{
+	return (timing + quant - 1) / quant;
+}
+
 /*
- * This routine writes the prepared setup/active/recovery counts
- * for a drive into the cmd646 chipset registers to active them.
+ * This routine calculates active/recovery counts and then writes them into
+ * the chipset registers.
  */
-static void program_drive_counts (ide_drive_t *drive, int setup_count, int active_count, int recovery_count)
+static void program_cycle_times (ide_drive_t *drive, int cycle_time, int active_time)
 {
-	unsigned long flags;
-	struct pci_dev *dev = HWIF(drive)->pci_dev;
-	ide_drive_t *drives = HWIF(drive)->drives;
-	u8 temp_b;
-	static const u8 setup_counts[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
-	static const u8 recovery_counts[] =
+	struct pci_dev *dev	= HWIF(drive)->pci_dev;
+	int clock_time		= 1000 / system_bus_clock();
+	u8  cycle_count, active_count, recovery_count, drwtim;
+	static const u8 recovery_values[] =
 		{15, 15, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 0};
-	static const u8 arttim_regs[2][2] = {
-			{ ARTTIM0, ARTTIM1 },
-			{ ARTTIM23, ARTTIM23 }
-		};
-	static const u8 drwtim_regs[2][2] = {
-			{ DRWTIM0, DRWTIM1 },
-			{ DRWTIM2, DRWTIM3 }
-		};
-	int channel = (int) HWIF(drive)->channel;
-	int slave = (drives != drive);  /* Is this really the best way to determine this?? */
+	static const u8 drwtim_regs[4] = {DRWTIM0, DRWTIM1, DRWTIM2, DRWTIM3};
 
-	cmdprintk("program_drive_count parameters = s(%d),a(%d),r(%d),p(%d)\n",
-		setup_count, active_count, recovery_count, drive->present);
-	/*
-	 * Set up address setup count registers.
-	 * Primary interface has individual count/timing registers for
-	 * each drive.  Secondary interface has one common set of registers,
-	 * for address setup so we merge these timings, using the slowest
-	 * value.
-	 */
-	if (channel) {
-		drive->drive_data = setup_count;
-		setup_count = max(drives[0].drive_data,
-					drives[1].drive_data);
-		cmdprintk("Secondary interface, setup_count = %d\n",
-					setup_count);
-	}
+	cmdprintk("program_cycle_times parameters: total=%d, active=%d\n",
+		  cycle_time, active_time);
+
+	cycle_count	= quantize_timing( cycle_time, clock_time);
+	active_count	= quantize_timing(active_time, clock_time);
+	recovery_count	= cycle_count - active_count;
 
 	/*
-	 * Convert values to internal chipset representation
+	 * In case we've got too long recovery phase, try to lengthen
+	 * the active phase
 	 */
-	setup_count = (setup_count > 5) ? 0xc0 : (int) setup_counts[setup_count];
-	active_count &= 0xf; /* Remember, max value is 16 */
-	recovery_count = (int) recovery_counts[recovery_count];
+	if (recovery_count > 16) {
+		active_count += recovery_count - 16;
+		recovery_count = 16;
+	}
+	if (active_count > 16)		/* shouldn't actually happen... */
+	 	active_count = 16;
 
-	cmdprintk("Final values = %d,%d,%d\n",
-		setup_count, active_count, recovery_count);
+	cmdprintk("Final counts: total=%d, active=%d, recovery=%d\n",
+		  cycle_count, active_count, recovery_count);
 
 	/*
-	 * Now that everything is ready, program the new timings
-	 */
-	local_irq_save(flags);
-	/*
-	 * Program the address_setup clocks into ARTTIM reg,
-	 * and then the active/recovery counts into the DRWTIM reg
+	 * Convert values to internal chipset representation
 	 */
-	(void) pci_read_config_byte(dev, arttim_regs[channel][slave], &temp_b);
-	(void) pci_write_config_byte(dev, arttim_regs[channel][slave],
-		((u8) setup_count) | (temp_b & 0x3f));
-	(void) pci_write_config_byte(dev, drwtim_regs[channel][slave],
-		(u8) ((active_count << 4) | recovery_count));
-	cmdprintk ("Write %x to %x\n",
-		((u8) setup_count) | (temp_b & 0x3f),
-		arttim_regs[channel][slave]);
-	cmdprintk ("Write %x to %x\n",
-		(u8) ((active_count << 4) | recovery_count),
-		drwtim_regs[channel][slave]);
-	local_irq_restore(flags);
-}
+	recovery_count = recovery_values[recovery_count];
+ 	active_count &= 0x0f;
 
-static u8 quantize_timing(int timing, int quant)
-{
-	return (timing + quant - 1) / quant;
+	/* Program the active/recovery counts into the DRWTIM register */
+	drwtim = (active_count << 4) | recovery_count;
+	(void) pci_write_config_byte(dev, drwtim_regs[drive->dn], drwtim);
+	cmdprintk ("Write %x to %x\n", drwtim, drwtim_regs[drive->dn]);
 }
 
 /*
- * This routine selects drive's best PIO mode, calculates setup/active/recovery
- * counts, and then writes them into the chipset registers.
+ * This routine selects drive's best PIO mode and writes into the chipset
+ * registers setup/active/recovery timings.
  */
 static u8 cmd64x_tune_pio (ide_drive_t *drive, u8 mode_wanted)
 {
-	int setup_time, active_time, cycle_time;
-	u8  cycle_count, setup_count, active_count, recovery_count;
-	u8  pio_mode;
-	int clock_time = 1000 / system_bus_clock();
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
 	ide_pio_data_t pio;
+	u8 pio_mode, setup_count, arttim = 0;
+	static const u8 setup_values[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
+	static const u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
 
 	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &pio);
-	cycle_time = pio.cycle_time;
 
-	setup_time  = ide_pio_timings[pio_mode].setup_time;
-	active_time = ide_pio_timings[pio_mode].active_time;
+	program_cycle_times(drive, pio.cycle_time,
+			    ide_pio_timings[pio_mode].active_time);
 
-	setup_count  = quantize_timing( setup_time, clock_time);
-	cycle_count  = quantize_timing( cycle_time, clock_time);
-	active_count = quantize_timing(active_time, clock_time);
+	setup_count = quantize_timing(ide_pio_timings[pio_mode].setup_time,
+				      1000 / system_bus_clock());
+
+	/*
+	 * The primary channel has individual address setup timing registers
+	 * for each drive and the hardware selects the slowest timing itself.
+	 * The secondary channel has one common register and we have to select
+	 * the slowest address setup timing ourselves.
+	 */
+	if (hwif->channel) {
+		ide_drive_t *drives = hwif->drives;
+
+		drive->drive_data = setup_count;
+		setup_count = max(drives[0].drive_data, drives[1].drive_data);
 
-	recovery_count = cycle_count - active_count;
-	/* program_drive_counts() takes care of zero recovery cycles */
-	if (recovery_count > 16) {
-		active_count += recovery_count - 16;
-		recovery_count = 16;
 	}
-	if (active_count > 16)
-		active_count = 16; /* maximum allowed by cmd64x */
 
-	program_drive_counts (drive, setup_count, active_count, recovery_count);
+	if (setup_count > 5)		/* shouldn't actually happen... */
+		setup_count = 5;
+	cmdprintk("Final address setup count = %d\n", setup_count);
 
-	cmdprintk("%s: PIO mode wanted %d, selected %d (%dns)%s, "
-		"clocks=%d/%d/%d\n",
-		drive->name, mode_wanted, pio_mode, cycle_time,
-		pio.overridden ? " (overriding vendor mode)" : "",
-		setup_count, active_count, recovery_count);
+	/*
+	 * Program the address setup clocks into the ARTTIM registers.
+	 * Avoid clearing the secondary channel's interrupt bit.
+	 */
+	(void) pci_read_config_byte (dev, arttim_regs[drive->dn], &arttim);
+	if (hwif->channel)
+		arttim &= ~ARTTIM23_INTR_CH1;
+	arttim &= ~0xc0;
+	arttim |= setup_values[setup_count];
+	(void) pci_write_config_byte(dev, arttim_regs[drive->dn], arttim);
+	cmdprintk ("Write %x to %x\n", arttim, arttim_regs[drive->dn]);
+
+	cmdprintk("%s: PIO mode wanted %d, selected %d (%d ns)%s\n",
+		  drive->name, mode_wanted, pio_mode, pio.cycle_time,
+		  pio.overridden ? " (overriding vendor mode)" : "");
 
 	return pio_mode;
 }
@@ -388,6 +372,15 @@ static int cmd64x_tune_chipset (ide_driv
 	case XFER_UDMA_0:
 		regU |= unit ? 0xC2 : 0x31;
 		break;
+	case XFER_MW_DMA_2:
+		program_cycle_times(drive, 120, 70);
+		break;
+	case XFER_MW_DMA_1:
+		program_cycle_times(drive, 150, 80);
+		break;
+	case XFER_MW_DMA_0:
+		program_cycle_times(drive, 480, 215);
+		break;
 	case XFER_PIO_5:
 	case XFER_PIO_4:
 	case XFER_PIO_3:
@@ -575,18 +568,6 @@ static unsigned int __devinit init_chips
 	 */
 	(void) pci_write_config_byte(dev, MRDMODE, mrdmode | 0x02);
 
-	/* Set reasonable active/recovery/address-setup values. */
-	(void) pci_write_config_byte(dev, ARTTIM0,  0x40);
-	(void) pci_write_config_byte(dev, DRWTIM0,  0x3f);
-	(void) pci_write_config_byte(dev, ARTTIM1,  0x40);
-	(void) pci_write_config_byte(dev, DRWTIM1,  0x3f);
-#ifdef __i386__
-	(void) pci_write_config_byte(dev, ARTTIM23, 0x1c);
-#else
-	(void) pci_write_config_byte(dev, ARTTIM23, 0x5c);
-#endif
-	(void) pci_write_config_byte(dev, DRWTIM23, 0x3f);
-	(void) pci_write_config_byte(dev, DRWTIM3,  0x3f);
 #ifdef CONFIG_PPC
 	(void) pci_write_config_byte(dev, UDIDETCR0, 0xf0);
 #endif /* CONFIG_PPC */
@@ -639,6 +620,7 @@ static void __devinit init_hwif_cmd64x(i
 	hwif->atapi_dma = 1;
 
 	hwif->ultra_mask = 0x3f;
+	hwif->mwdma_mask = 0x07;
 
 	if (dev->device == PCI_DEVICE_ID_CMD_643)
 		hwif->ultra_mask = 0x80;

