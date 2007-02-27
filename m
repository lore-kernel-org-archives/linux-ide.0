From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Subject: [PATCH] (pata-2.6 fix queue) cmd64x: fix primary channel address setup time
Date: Wed, 28 Feb 2007 00:49:36 +0300
Message-ID: <200702280049.36593.sshtylyov@ru.mvista.com>
References: <200702032309.43867.sshtylyov@ru.mvista.com> <200702040004.24918.sshtylyov@ru.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from h155.mvista.com ([63.81.120.155]:7846 "EHLO imap.sh.mvista.com"
	rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1750869AbXB0Vts (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Tue, 27 Feb 2007 16:49:48 -0500
In-Reply-To: <200702040004.24918.sshtylyov@ru.mvista.com>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: bzolnier@gmail.com
Cc: linux-ide@vger.kernel.org

The driver used to merge the address setup timing for the secondary channel but
this must have been done for both channels actually despite the primary channel
had separate registers for each drive (I'afraid that this is too common mistake
in both hardware and software -- address setup timing must be the same accross
an IDE channel).  Thus, do a number of changes to the program_drive_counts():

- store the address setup count in the 'drive_data' to select the slowest one
  for the primary channel's drives, and write the selected value into *both*
  ARRTIM0 and ARTTIM1 registers (just writing 0 to their reserved bits 0 to 5);

- when writing to ARTTIM23 register for the secondary channel, preserve the
  interrupt status bit; elminate the local_irq_{save|restore}() calls as there
  is *no* race with the interrupt handler;

- make drwtim_regs[] single-dimensional, indexing it with drive->dn, eliminate
  now useless index variables;

- replace 'temp_b' variable with 'arttim' and 'drwtim';

- rename {setup|recovery}_counts[] into more fitting {setup|recovery}_values[];

- replace the multiple HWIF() invocation with a single one...

And in addition to those changes also do remove:

- needless and misplaced timing registers initialization in the init_chipset()
  method;

- meaningless register #define's...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
Warning: this has only been compile-tested, as usual.

I've finally decided to make this a separate patch, so the MWDMA support
restoring patch is delayed again. :-<

 drivers/ide/pci/cmd64x.c |  106 +++++++++++++++++------------------------------
 1 files changed, 40 insertions(+), 66 deletions(-)

Index: linux-2.6/drivers/ide/pci/cmd64x.c
===================================================================
--- linux-2.6.orig/drivers/ide/pci/cmd64x.c
+++ linux-2.6/drivers/ide/pci/cmd64x.c
@@ -1,6 +1,6 @@
 /* $Id: cmd64x.c,v 1.21 2000/01/30 23:23:16
  *
- * linux/drivers/ide/pci/cmd64x.c		Version 1.47	Feb 16, 2007
+ * linux/drivers/ide/pci/cmd64x.c		Version 1.48	Feb 26, 2007
  *
  * cmd64x.c: Enable interrupts at initialization time on Ultra/PCI machines.
  *           Note, this driver is not used at all on other systems because
@@ -55,9 +55,6 @@
 #define   ARTTIM23_DIS_RA2	0x04
 #define   ARTTIM23_DIS_RA3	0x08
 #define   ARTTIM23_INTR_CH1	0x10
-#define ARTTIM2		0x57
-#define ARTTIM3		0x57
-#define DRWTIM23	0x58
 #define DRWTIM2		0x58
 #define BRST		0x59
 #define DRWTIM3		0x5b
@@ -172,73 +169,62 @@ static int cmd64x_get_info (char *buffer
  * This routine writes the prepared setup/active/recovery counts
  * for a drive into the cmd646 chipset registers to active them.
  */
-static void program_drive_counts (ide_drive_t *drive, int setup_count, int active_count, int recovery_count)
+static void program_drive_counts (ide_drive_t *drive, int setup_count,
+				  int active_count, int recovery_count)
 {
-	unsigned long flags;
-	struct pci_dev *dev = HWIF(drive)->pci_dev;
-	ide_drive_t *drives = HWIF(drive)->drives;
-	u8 temp_b;
-	static const u8 setup_counts[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
-	static const u8 recovery_counts[] =
+	ide_hwif_t *hwif	= HWIF(drive);
+	struct pci_dev *dev	= hwif->pci_dev;
+	ide_drive_t *drives	= hwif->drives;
+	u8 drwtim, arttim	= 0;
+	static const u8 setup_values[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
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
+	static const u8 drwtim_regs[] = {DRWTIM0, DRWTIM1, DRWTIM2, DRWTIM3};
 
 	cmdprintk("program_drive_count parameters = s(%d),a(%d),r(%d),p(%d)\n",
 		setup_count, active_count, recovery_count, drive->present);
+
 	/*
-	 * Set up address setup count registers.
-	 * Primary interface has individual count/timing registers for
-	 * each drive.  Secondary interface has one common set of registers,
-	 * for address setup so we merge these timings, using the slowest
-	 * value.
+	 * The primary channel has individual address setup timing registers
+	 * for each drive, while the secondary channel has one common register.
+	 * We must merge these timings in any case and use the slowest value.
 	 */
-	if (channel) {
-		drive->drive_data = setup_count;
-		setup_count = max(drives[0].drive_data,
-					drives[1].drive_data);
-		cmdprintk("Secondary interface, setup_count = %d\n",
-					setup_count);
-	}
+	drive->drive_data = setup_count;
+	setup_count = max(drives[0].drive_data,	drives[1].drive_data);
+	cmdprintk("Slowest address setup count = %d\n", setup_count);
 
 	/*
 	 * Convert values to internal chipset representation
 	 */
-	setup_count = (setup_count > 5) ? 0xc0 : (int) setup_counts[setup_count];
+	setup_count = (setup_count > 5) ? 0xc0 : setup_values[setup_count];
 	active_count &= 0xf; /* Remember, max value is 16 */
-	recovery_count = (int) recovery_counts[recovery_count];
-
+	recovery_count = recovery_values[recovery_count];
 	cmdprintk("Final values = %d,%d,%d\n",
 		setup_count, active_count, recovery_count);
 
 	/*
-	 * Now that everything is ready, program the new timings
+	 * Program the address setup clocks into the ARTTIM registers.
+	 * Avoid clearing the secondary channel's interrupt bit.
 	 */
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
+	if (hwif->channel) {
+		(void) pci_read_config_byte (dev, ARTTIM23, &arttim);
+		arttim &= ~ARTTIM23_INTR_CH1;
+		arttim &= ~0xc0;
+		arttim |= setup_count;
+		(void) pci_write_config_byte(dev, ARTTIM23, arttim);
+		cmdprintk ("Write %x to %x\n", arttim, ARTTIM23);
+	} else {
+		arttim = setup_count;
+		(void) pci_write_config_byte(dev, ARTTIM0, arttim);
+		cmdprintk ("Write %x to %x\n", arttim, ARTTIM0);
+		(void) pci_write_config_byte(dev, ARTTIM1, arttim);
+		cmdprintk ("Write %x to %x\n", arttim, ARTTIM1);
+	}
+
+	/* Program the active/recovery counts into the DRWTIM register */
+	drwtim = (active_count << 4) | recovery_count;
+	(void) pci_write_config_byte(dev, drwtim_regs[drive->dn], drwtim);
+	cmdprintk ("Write %x to %x\n", drwtim, drwtim_regs[drive->dn]);
 }
 
 static u8 quantize_timing(int timing, int quant)
@@ -575,18 +561,6 @@ static unsigned int __devinit init_chips
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

