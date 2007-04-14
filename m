From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH pata-2.6] cmd64x: fix multiword and remove single-word DMA support
Date: Sat, 14 Apr 2007 23:09:03 +0400
Message-ID: <200704142309.04099.sshtylyov@ru.mvista.com>
References: <200702080000.32852.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from gateway-1237.mvista.com ([63.81.120.155]:61270 "EHLO
	imap.sh.mvista.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751153AbXDNTIM (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 14 Apr 2007 15:08:12 -0400
In-Reply-To: <200702080000.32852.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

Fix the multiword DMA and drop the single-word DMA support (which nobody will
miss, I think).  In order to do it, a number of changes was necessary:

- rename program_drive_counts() to program_cycle_times(), pass to it cycle's
  total/active times instead of the clock counts, and convert them into the
  active/recovery clocks there instead of cmd64x_tune_pio() -- this causes
  quantize_timing() to also move;

- contrarywise, move all the code handling the address setup timing into
  cmd64x_tune_pio(), so that setting MWDMA mode wouldn't change address setup;

- remove from the speedproc() method the  bogus code pretending to set the DMA
  timings by twiddling bits in the BMIDE status register, handle setting MWDMA
  by just calling program_cycle_times(); while at it, improve the style of that
  whole switch statement;

- stop fiddling with the DMA capable bits in the speedproc() method -- they do
  not enable DMA, and are properly dealt with by the dma_host_{on,off} methods;

- don't set hwif->swdma_mask in the init_hwif() method anymore.

In addition to those changes, do the following:

- in cmd64x_tune_pio(), when writing to ARTTIM23 register preserve the interrupt
  status bit, eliminate local_irq_{save|restore}() around this code as there's
  *no* actual race with the interrupt handler, and move cmdprintk() to a more
  fitting place -- after ide_get_best_pio_mode() call;

- make {arttim|drwtim}_regs arrays single-dimensional, indexed with drive->dn;

- rename {setup|recovery}_counts[] into more fitting {setup|recovery}_values[];

- in  the speedproc() method, get rid of the duplicate reads/writes from/to the
  UDIDETCRx registers and of the extra variable used to store the transfer mode
  value after filtering,  use another method of determining master/slave drive,
  and cleanup useless parens;

- beautify cmdprintk() output here and there.

While at it, remove meaningless comment about the driver being used only on
UltraSPARC and long non-relevant RCS tag. :-)

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
This patch is basically the result of merge of the former two:
cmd64x-remove-brokem-sw-mw-dma-support.patch and
cmd64x-add-back-mwdma-support.patch (minus the part removing the timing register
setup form the init_chipset() method -- that's been moved to another patch).
Has been (at last!) tested on PCI-649.

 drivers/ide/pci/cmd64x.c |  246 ++++++++++++++++++++++-------------------------
 1 files changed, 116 insertions(+), 130 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,10 +1,7 @@
-/* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
- *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.42	Feb 8, 2007
+/*
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.43	Mar 10, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
- *           Note, this driver is not used at all on other systems because
- *           there the "BIOS" has done all of the following already.
  *           Due to massive hardware bugs, UltraDMA is only supported
  *           on the 646U2 and not on the 646U.
  *
@@ -195,116 +192,103 @@ static u8 quantize_timing(int timing, in
 }
 
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
+
+	cmdprintk("program_cycle_times parameters: total=%d, active=%d\n",
+		  cycle_time, active_time);
+
+	cycle_count	= quantize_timing( cycle_time, clock_time);
+	active_count	= quantize_timing(active_time, clock_time);
+	recovery_count	= cycle_count - active_count;
 
-	cmdprintk("program_drive_count parameters = s(%d),a(%d),r(%d),p(%d)\n",
-		setup_count, active_count, recovery_count, drive->present);
 	/*
-	 * Set up address setup count registers.
-	 * Primary interface has individual count/timing registers for
-	 * each drive.  Secondary interface has one common set of registers,
-	 * for address setup so we merge these timings, using the slowest
-	 * value.
+	 * In case we've got too long recovery phase, try to lengthen
+	 * the active phase
 	 */
-	if (channel) {
-		drive->drive_data = setup_count;
-		setup_count = max(drives[0].drive_data,
-					drives[1].drive_data);
-		cmdprintk("Secondary interface, setup_count = %d\n",
-					setup_count);
+	if (recovery_count > 16) {
+		active_count += recovery_count - 16;
+		recovery_count = 16;
 	}
+	if (active_count > 16)		/* shouldn't actually happen... */
+	 	active_count = 16;
+
+	cmdprintk("Final counts: total=%d, active=%d, recovery=%d\n",
+		  cycle_count, active_count, recovery_count);
 
 	/*
 	 * Convert values to internal chipset representation
 	 */
-	setup_count = (setup_count > 5) ? 0xc0 : (int) setup_counts[setup_count];
-	active_count &= 0xf; /* Remember, max value is 16 */
-	recovery_count = (int) recovery_counts[recovery_count];
+	recovery_count = recovery_values[recovery_count];
+ 	active_count  &= 0x0f;
 
-	cmdprintk("Final values = %d,%d,%d\n",
-		setup_count, active_count, recovery_count);
-
-	/*
-	 * Now that everything is ready, program the new timings
-	 */
-	local_irq_save(flags);
-	/*
-	 * Program the address_setup clocks into ARTTIM reg,
-	 * and then the active/recovery counts into the DRWTIM reg
-	 */
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
+	/* Program the active/recovery counts into the DRWTIM register */
+	drwtim = (active_count << 4) | recovery_count;
+	(void) pci_write_config_byte(dev, drwtim_regs[drive->dn], drwtim);
+	cmdprintk("Write 0x%02x to reg 0x%x\n", drwtim, drwtim_regs[drive->dn]);
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
-
+	u8 pio_mode, setup_count, arttim = 0;
+	static const u8 setup_values[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
+	static const u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
 	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, &pio);
-	cycle_time = pio.cycle_time;
 
-	setup_time  = ide_pio_timings[pio_mode].setup_time;
-	active_time = ide_pio_timings[pio_mode].active_time;
+	cmdprintk("%s: PIO mode wanted %d, selected %d (%d ns)%s\n",
+		  drive->name, mode_wanted, pio_mode, pio.cycle_time,
+		  pio.overridden ? " (overriding vendor mode)" : "");
 
-	setup_count  = quantize_timing( setup_time, clock_time);
-	cycle_count  = quantize_timing( cycle_time, clock_time);
-	active_count = quantize_timing(active_time, clock_time);
+	program_cycle_times(drive, pio.cycle_time,
+			    ide_pio_timings[pio_mode].active_time);
 
-	recovery_count = cycle_count - active_count;
-	/* program_drive_counts() takes care of zero recovery cycles */
-	if (recovery_count > 16) {
-		active_count += recovery_count - 16;
-		recovery_count = 16;
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
 	}
-	if (active_count > 16)
-		active_count = 16; /* maximum allowed by cmd64x */
 
-	program_drive_counts (drive, setup_count, active_count, recovery_count);
+	if (setup_count > 5)		/* shouldn't actually happen... */
+		setup_count = 5;
+	cmdprintk("Final address setup count: %d\n", setup_count);
 
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
+	cmdprintk("Write 0x%02x to reg 0x%x\n", arttim, arttim_regs[drive->dn]);
 
 	return pio_mode;
 }
@@ -376,61 +360,64 @@ static u8 cmd64x_ratemask (ide_drive_t *
 	return mode;
 }
 
-static int cmd64x_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int cmd64x_tune_chipset (ide_drive_t *drive, u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
+	u8 unit			= drive->dn & 0x01;
+	u8 regU = 0, pciU	= hwif->channel ? UDIDETCR1 : UDIDETCR0;
 
-	u8 unit			= (drive->select.b.unit & 0x01);
-	u8 regU = 0, pciU	= (hwif->channel) ? UDIDETCR1 : UDIDETCR0;
-	u8 regD = 0, pciD	= (hwif->channel) ? BMIDESR1 : BMIDESR0;
-
-	u8 speed	= ide_rate_filter(cmd64x_ratemask(drive), xferspeed);
+	speed = ide_rate_filter(cmd64x_ratemask(drive), speed);
 
 	if (speed >= XFER_SW_DMA_0) {
-		(void) pci_read_config_byte(dev, pciD, &regD);
 		(void) pci_read_config_byte(dev, pciU, &regU);
-		regD &= ~(unit ? 0x40 : 0x20);
 		regU &= ~(unit ? 0xCA : 0x35);
-		(void) pci_write_config_byte(dev, pciD, regD);
-		(void) pci_write_config_byte(dev, pciU, regU);
-		(void) pci_read_config_byte(dev, pciD, &regD);
-		(void) pci_read_config_byte(dev, pciU, &regU);
 	}
 
 	switch(speed) {
-		case XFER_UDMA_5:	regU |= (unit ? 0x0A : 0x05); break;
-		case XFER_UDMA_4:	regU |= (unit ? 0x4A : 0x15); break;
-		case XFER_UDMA_3:	regU |= (unit ? 0x8A : 0x25); break;
-		case XFER_UDMA_2:	regU |= (unit ? 0x42 : 0x11); break;
-		case XFER_UDMA_1:	regU |= (unit ? 0x82 : 0x21); break;
-		case XFER_UDMA_0:	regU |= (unit ? 0xC2 : 0x31); break;
-		case XFER_MW_DMA_2:	regD |= (unit ? 0x40 : 0x10); break;
-		case XFER_MW_DMA_1:	regD |= (unit ? 0x80 : 0x20); break;
-		case XFER_MW_DMA_0:	regD |= (unit ? 0xC0 : 0x30); break;
-		case XFER_SW_DMA_2:	regD |= (unit ? 0x40 : 0x10); break;
-		case XFER_SW_DMA_1:	regD |= (unit ? 0x80 : 0x20); break;
-		case XFER_SW_DMA_0:	regD |= (unit ? 0xC0 : 0x30); break;
-		case XFER_PIO_5:
-		case XFER_PIO_4:
-		case XFER_PIO_3:
-		case XFER_PIO_2:
-		case XFER_PIO_1:
-		case XFER_PIO_0:
-			(void) cmd64x_tune_pio(drive, speed - XFER_PIO_0);
-			break;
-
-		default:
-			return 1;
+	case XFER_UDMA_5:
+		regU |= unit ? 0x0A : 0x05;
+		break;
+	case XFER_UDMA_4:
+		regU |= unit ? 0x4A : 0x15;
+		break;
+	case XFER_UDMA_3:
+		regU |= unit ? 0x8A : 0x25;
+		break;
+	case XFER_UDMA_2:
+		regU |= unit ? 0x42 : 0x11;
+		break;
+	case XFER_UDMA_1:
+		regU |= unit ? 0x82 : 0x21;
+		break;
+	case XFER_UDMA_0:
+		regU |= unit ? 0xC2 : 0x31;
+		break;
+	case XFER_MW_DMA_2:
+		program_cycle_times(drive, 120, 70);
+		break;
+	case XFER_MW_DMA_1:
+		program_cycle_times(drive, 150, 80);
+		break;
+	case XFER_MW_DMA_0:
+		program_cycle_times(drive, 480, 215);
+		break;
+	case XFER_PIO_5:
+	case XFER_PIO_4:
+	case XFER_PIO_3:
+	case XFER_PIO_2:
+	case XFER_PIO_1:
+	case XFER_PIO_0:
+		(void) cmd64x_tune_pio(drive, speed - XFER_PIO_0);
+		break;
+	default:
+		return 1;
 	}
 
-	if (speed >= XFER_SW_DMA_0) {
+	if (speed >= XFER_SW_DMA_0)
 		(void) pci_write_config_byte(dev, pciU, regU);
-		regD |= (unit ? 0x40 : 0x20);
-		(void) pci_write_config_byte(dev, pciD, regD);
-	}
 
-	return (ide_config_drive_speed(drive, speed));
+	return ide_config_drive_speed(drive, speed);
 }
 
 static int config_chipset_for_dma (ide_drive_t *drive)
@@ -665,7 +652,6 @@ static void __devinit init_hwif_cmd64x(i
 
 	hwif->ultra_mask = 0x3f;
 	hwif->mwdma_mask = 0x07;
-	hwif->swdma_mask = 0x07;
 
 	if (dev->device == PCI_DEVICE_ID_CMD_643)
 		hwif->ultra_mask = 0x80;

