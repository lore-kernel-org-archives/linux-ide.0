From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 7/15] ide: drop "PIO data" argument from ide_get_best_pio_mode()
Date: Sat, 30 Jun 2007 21:05:20 +0200
Message-ID: <200706302105.20596.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ug-out-1314.google.com ([66.249.92.168]:9971 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753878AbXF3TAN (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sat, 30 Jun 2007 15:00:13 -0400
Received: by ug-out-1314.google.com with SMTP id j3so1014814ugf
        for <linux-ide@vger.kernel.org>; Sat, 30 Jun 2007 12:00:12 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org


* Drop no longer needed "PIO data" argument from ide_get_best_pio_mode()
  and convert all users accordingly.

* Remove no longer needed ide_pio_data_t.

Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/ide-lib.c          |    6 +-----
 drivers/ide/legacy/ali14xx.c   |    2 +-
 drivers/ide/legacy/dtc2278.c   |    2 +-
 drivers/ide/legacy/ht6560b.c   |    2 +-
 drivers/ide/legacy/qd65xx.c    |    2 +-
 drivers/ide/legacy/umc8672.c   |    2 +-
 drivers/ide/mips/au1xxx-ide.c  |    2 +-
 drivers/ide/pci/aec62xx.c      |    2 +-
 drivers/ide/pci/alim15x3.c     |    3 +--
 drivers/ide/pci/atiixp.c       |    2 +-
 drivers/ide/pci/cmd640.c       |    2 +-
 drivers/ide/pci/cmd64x.c       |    2 +-
 drivers/ide/pci/cs5520.c       |    2 +-
 drivers/ide/pci/cs5530.c       |    2 +-
 drivers/ide/pci/cs5535.c       |    6 +++---
 drivers/ide/pci/cy82c693.c     |    2 +-
 drivers/ide/pci/hpt34x.c       |    2 +-
 drivers/ide/pci/hpt366.c       |    2 +-
 drivers/ide/pci/it8213.c       |    4 ++--
 drivers/ide/pci/it821x.c       |    4 ++--
 drivers/ide/pci/jmicron.c      |    2 +-
 drivers/ide/pci/opti621.c      |    4 ++--
 drivers/ide/pci/pdc202xx_new.c |    2 +-
 drivers/ide/pci/pdc202xx_old.c |    2 +-
 drivers/ide/pci/piix.c         |    2 +-
 drivers/ide/pci/sc1200.c       |    2 +-
 drivers/ide/pci/scc_pata.c     |    2 +-
 drivers/ide/pci/serverworks.c  |    2 +-
 drivers/ide/pci/siimage.c      |    4 ++--
 drivers/ide/pci/sis5513.c      |    2 +-
 drivers/ide/pci/sl82c105.c     |    2 +-
 drivers/ide/pci/slc90e66.c     |    2 +-
 drivers/ide/pci/tc86c001.c     |    2 +-
 drivers/ide/pci/triflex.c      |    2 +-
 drivers/ide/ppc/mpc8xx.c       |    3 +--
 drivers/ide/ppc/pmac.c         |    2 +-
 include/linux/ide.h            |    6 +-----
 37 files changed, 43 insertions(+), 53 deletions(-)

Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -277,7 +277,6 @@ EXPORT_SYMBOL_GPL(ata_pio_cycle_time);
  *	@drive: drive to consider
  *	@mode_wanted: preferred mode
  *	@max_mode: highest allowed mode
- *	@d: PIO data
  *
  *	This routine returns the recommended PIO settings for a given drive,
  *	based on the drive->id information and the ide_pio_blacklist[].
@@ -286,7 +285,7 @@ EXPORT_SYMBOL_GPL(ata_pio_cycle_time);
  *	This is used by most chipset support modules when "auto-tuning".
  */
 
-u8 ide_get_best_pio_mode (ide_drive_t *drive, u8 mode_wanted, u8 max_mode, ide_pio_data_t *d)
+u8 ide_get_best_pio_mode (ide_drive_t *drive, u8 mode_wanted, u8 max_mode)
 {
 	int pio_mode;
 	struct hd_driveid* id = drive->id;
@@ -335,9 +334,6 @@ u8 ide_get_best_pio_mode (ide_drive_t *d
 	if (pio_mode > max_mode)
 		pio_mode = max_mode;
 
-	if (d)
-		d->pio_mode = pio_mode;
-
 	return pio_mode;
 }
 
Index: b/drivers/ide/legacy/ali14xx.c
===================================================================
--- a/drivers/ide/legacy/ali14xx.c
+++ b/drivers/ide/legacy/ali14xx.c
@@ -117,7 +117,7 @@ static void ali14xx_tune_drive (ide_driv
 	unsigned long flags;
 	int bus_speed = system_bus_clock();
 
-	pio = ide_get_best_pio_mode(drive, pio, ALI_MAX_PIO, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, ALI_MAX_PIO);
 
 	/* calculate timing, according to PIO mode */
 	time1 = ata_pio_cycle_time(drive, pio);
Index: b/drivers/ide/legacy/dtc2278.c
===================================================================
--- a/drivers/ide/legacy/dtc2278.c
+++ b/drivers/ide/legacy/dtc2278.c
@@ -71,7 +71,7 @@ static void tune_dtc2278 (ide_drive_t *d
 {
 	unsigned long flags;
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 
 	if (pio >= 3) {
 		spin_lock_irqsave(&ide_lock, flags);
Index: b/drivers/ide/legacy/ht6560b.c
===================================================================
--- a/drivers/ide/legacy/ht6560b.c
+++ b/drivers/ide/legacy/ht6560b.c
@@ -208,7 +208,7 @@ static u8 ht_pio2timings(ide_drive_t *dr
         if (pio) {
 		unsigned int cycle_time;
 
-		pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+		pio = ide_get_best_pio_mode(drive, pio, 5);
 		cycle_time = ata_pio_cycle_time(drive, pio);
 
 		/*
Index: b/drivers/ide/legacy/qd65xx.c
===================================================================
--- a/drivers/ide/legacy/qd65xx.c
+++ b/drivers/ide/legacy/qd65xx.c
@@ -258,7 +258,7 @@ static void qd6580_tune_drive (ide_drive
 	int recovery_time = 415; /* worst case values from the dos driver */
 
 	if (drive->id && !qd_find_disk_type(drive, &active_time, &recovery_time)) {
-		pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+		pio = ide_get_best_pio_mode(drive, pio, 4);
 		cycle_time = ata_pio_cycle_time(drive, pio);
 
 		switch (pio) {
Index: b/drivers/ide/legacy/umc8672.c
===================================================================
--- a/drivers/ide/legacy/umc8672.c
+++ b/drivers/ide/legacy/umc8672.c
@@ -110,7 +110,7 @@ static void tune_umc (ide_drive_t *drive
 	unsigned long flags;
 	ide_hwgroup_t *hwgroup = ide_hwifs[HWIF(drive)->index^1].hwgroup;
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	printk("%s: setting umc8672 to PIO mode%d (speed %d)\n",
 		drive->name, pio, pio_to_umc[pio]);
 	spin_lock_irqsave(&ide_lock, flags);
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -106,7 +106,7 @@ static void auide_tune_drive(ide_drive_t
 	u8 speed;
 
 	/* get the best pio mode for the drive */
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 
 	printk(KERN_INFO "%s: setting Au1XXX IDE to PIO mode%d\n",
 	       drive->name, pio);
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -142,7 +142,7 @@ static int aec6260_tune_chipset (ide_dri
 
 static void aec62xx_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void) HWIF(drive)->speedproc(drive, pio + XFER_PIO_0);
 }
 
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -295,7 +295,6 @@ static int ali_get_info (char *buffer, c
  
 static u8 ali15x3_tune_pio (ide_drive_t *drive, u8 pio)
 {
-	ide_pio_data_t d;
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
 	int s_time, a_time, c_time;
@@ -307,7 +306,7 @@ static u8 ali15x3_tune_pio (ide_drive_t 
 	u8 cd_dma_fifo = 0;
 	int unit = drive->select.b.unit & 1;
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, &d);
+	pio = ide_get_best_pio_mode(drive, pio, 5);
 	s_time = ide_pio_timings[pio].setup_time;
 	a_time = ide_pio_timings[pio].active_time;
 	if ((s_clc = (s_time * bus_speed + 999) / 1000) >= 8)
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -155,7 +155,7 @@ static void atiixp_tune_pio(ide_drive_t 
 
 static void atiixp_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	atiixp_tune_pio(drive, pio);
 	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
Index: b/drivers/ide/pci/cmd640.c
===================================================================
--- a/drivers/ide/pci/cmd640.c
+++ b/drivers/ide/pci/cmd640.c
@@ -661,7 +661,7 @@ static void cmd640_tune_drive (ide_drive
 			return;
 	}
 
-	mode_wanted = ide_get_best_pio_mode(drive, mode_wanted, 5, NULL);
+	mode_wanted = ide_get_best_pio_mode(drive, mode_wanted, 5);
 	cycle_time = ata_pio_cycle_time(drive, mode_wanted);
 	cmd640_set_mode(index, mode_wanted, cycle_time);
 
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -228,7 +228,7 @@ static u8 cmd64x_tune_pio (ide_drive_t *
 	static const u8 setup_values[] = {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
 	static const u8 arttim_regs[4] = {ARTTIM0, ARTTIM1, ARTTIM23, ARTTIM23};
 
-	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5, NULL);
+	pio_mode = ide_get_best_pio_mode(drive, mode_wanted, 5);
 	cycle_time = ata_pio_cycle_time(drive, pio_mode);
 
 	cmdprintk("%s: PIO mode wanted %d, selected %d (%d ns)\n",
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -126,7 +126,7 @@ static int cs5520_tune_chipset(ide_drive
 	
 static void cs5520_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	cs5520_tune_chipset(drive, (XFER_PIO_0 + pio));
 }
 
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -82,7 +82,7 @@ static void cs5530_tunepio(ide_drive_t *
 
 static void cs5530_tuneproc (ide_drive_t *drive, u8 pio)	/* pio=255 means "autotune" */
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 
 	if (cs5530_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
 		cs5530_tunepio(drive, pio);
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -89,7 +89,7 @@ static void cs5535_set_speed(ide_drive_t
 
 		pioa = speed - XFER_PIO_0;
 		piob = ide_get_best_pio_mode(&(drive->hwif->drives[!unit]),
-						255, 4, NULL);
+						255, 4);
 		cmd = pioa < piob ? pioa : piob;
 
 		/* Write the speed of the current drive */
@@ -159,7 +159,7 @@ static void cs5535_tuneproc(ide_drive_t 
 	/* cs5535 max pio is pio 4, best_pio will check the blacklist.
 	i think we don't need to rate_filter the incoming xferspeed
 	since we know we're only going to choose pio */
-	xferspeed = ide_get_best_pio_mode(drive, xferspeed, 4, NULL);
+	xferspeed = ide_get_best_pio_mode(drive, xferspeed, 4);
 	ide_config_drive_speed(drive, modes[xferspeed]);
 	cs5535_set_speed(drive, xferspeed);
 }
@@ -174,7 +174,7 @@ static int cs5535_dma_check(ide_drive_t 
 		return 0;
 
 	if (ide_use_fast_pio(drive)) {
-		speed = ide_get_best_pio_mode(drive, 255, 4, NULL);
+		speed = ide_get_best_pio_mode(drive, 255, 4);
 		cs5535_set_drive(drive, speed);
 	}
 
Index: b/drivers/ide/pci/cy82c693.c
===================================================================
--- a/drivers/ide/pci/cy82c693.c
+++ b/drivers/ide/pci/cy82c693.c
@@ -330,7 +330,7 @@ static void cy82c693_tune_drive (ide_dri
 #endif /* CY82C693_DEBUG_LOGS */
 
 	/* first let's calc the pio modes */
-	pio = ide_get_best_pio_mode(drive, pio, CY82C693_MAX_PIO, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, CY82C693_MAX_PIO);
 
 #if CY82C693_DEBUG_INFO
 	printk (KERN_INFO "%s: Selected PIO mode %d\n", drive->name, pio);
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -80,7 +80,7 @@ static int hpt34x_tune_chipset (ide_driv
 
 static void hpt34x_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 5);
 	(void) hpt34x_tune_chipset(drive, (XFER_PIO_0 + pio));
 }
 
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -652,7 +652,7 @@ static int hpt3xx_tune_chipset(ide_drive
 
 static void hpt3xx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void) hpt3xx_tune_chipset (drive, XFER_PIO_0 + pio);
 }
 
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -82,7 +82,7 @@ static void it8213_tuneproc (ide_drive_t
 					{ 2, 1 },
 					{ 2, 3 }, };
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 
 	spin_lock_irqsave(&tune_lock, flags);
 	pci_read_config_word(dev, master_port, &master_data);
@@ -214,7 +214,7 @@ static int it8213_config_drive_for_dma (
 	if (ide_tune_dma(drive))
 		return 0;
 
-	pio = ide_get_best_pio_mode(drive, 255, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, 255, 4);
 	it8213_tune_chipset(drive, XFER_PIO_0 + pio);
 
 	return -1;
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -255,7 +255,7 @@ static int it821x_tunepio(ide_drive_t *d
 	 * on the cable.
 	 */
 	if (pair) {
-		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);
+		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4);
 		/* trim PIO to the slowest of the master/slave */
 		if (pair_pio < set_pio)
 			set_pio = pair_pio;
@@ -276,7 +276,7 @@ static int it821x_tunepio(ide_drive_t *d
 
 static void it821x_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void)it821x_tunepio(drive, pio);
 }
 
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -97,7 +97,7 @@ static void jmicron_tuneproc (ide_drive_
 
 static void config_jmicron_chipset_for_pio (ide_drive_t *drive, byte set_speed)
 {
-	u8 speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5, NULL);
+	u8 speed = XFER_PIO_0 + ide_get_best_pio_mode(drive, 255, 5);
 	if (set_speed)
 		(void) ide_config_drive_speed(drive, speed);
 }
Index: b/drivers/ide/pci/opti621.c
===================================================================
--- a/drivers/ide/pci/opti621.c
+++ b/drivers/ide/pci/opti621.c
@@ -147,12 +147,12 @@ static void compute_pios(ide_drive_t *dr
 	int d;
 	ide_hwif_t *hwif = HWIF(drive);
 
-	drive->drive_data = ide_get_best_pio_mode(drive, pio, OPTI621_MAX_PIO, NULL);
+	drive->drive_data = ide_get_best_pio_mode(drive, pio, OPTI621_MAX_PIO);
 	for (d = 0; d < 2; ++d) {
 		drive = &hwif->drives[d];
 		if (drive->present) {
 			if (drive->drive_data == PIO_DONT_KNOW)
-				drive->drive_data = ide_get_best_pio_mode(drive, 255, OPTI621_MAX_PIO, NULL);
+				drive->drive_data = ide_get_best_pio_mode(drive, 255, OPTI621_MAX_PIO);
 #ifdef OPTI621_DEBUG
 			printk("%s: Selected PIO mode %d\n",
 				drive->name, drive->drive_data);
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -219,7 +219,7 @@ static int pdcnew_tune_chipset(ide_drive
 
 static void pdcnew_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void)pdcnew_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -145,7 +145,7 @@ static int pdc202xx_tune_chipset (ide_dr
 
 static void pdc202xx_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	pdc202xx_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -219,7 +219,7 @@ static void piix_tune_pio (ide_drive_t *
  */
 static void piix_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	piix_tune_pio(drive, pio);
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -304,7 +304,7 @@ static void sc1200_tuneproc (ide_drive_t
 		return;
 	}
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	printk("SC1200: %s: setting PIO mode%d\n", drive->name, pio);
 
 	if (sc1200_set_xfer_mode(drive, XFER_PIO_0 + pio) == 0)
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -210,7 +210,7 @@ static void scc_tuneproc(ide_drive_t *dr
 	unsigned char speed = XFER_PIO_0;
 	int offset;
 
-	mode_wanted = ide_get_best_pio_mode(drive, mode_wanted, 4, NULL);
+	mode_wanted = ide_get_best_pio_mode(drive, mode_wanted, 4);
 	switch (mode_wanted) {
 	case 4:
 		speed = XFER_PIO_4;
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -209,7 +209,7 @@ static int svwks_tune_chipset (ide_drive
 
 static void svwks_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	svwks_tune_pio(drive, pio);
 	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -189,7 +189,7 @@ static void sil_tune_pio(ide_drive_t *dr
 
 	/* trim *taskfile* PIO to the slowest of the master/slave */
 	if (pair->present) {
-		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4, NULL);
+		u8 pair_pio = ide_get_best_pio_mode(pair, 255, 4);
 
 		if (pair_pio < tf_pio)
 			tf_pio = pair_pio;
@@ -221,7 +221,7 @@ static void sil_tune_pio(ide_drive_t *dr
 
 static void sil_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	sil_tune_pio(drive, pio);
 	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -521,7 +521,7 @@ static void config_art_rwp_pio (ide_driv
 
 static int sis5513_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	config_art_rwp_pio(drive, pio);
 	return ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -83,7 +83,7 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 
 	DBG(("sl82c105_tune_pio(drive:%s, pio:%u)\n", drive->name, pio));
 
-	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 5);
 
 	drv_ctrl = get_pio_timings(drive, pio);
 
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -103,7 +103,7 @@ static void slc90e66_tune_pio (ide_drive
 
 static void slc90e66_tune_drive (ide_drive_t *drive, u8 pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	slc90e66_tune_pio(drive, pio);
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -47,7 +47,7 @@ static int tc86c001_tune_chipset(ide_dri
 
 static void tc86c001_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	pio =  ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void) tc86c001_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -96,7 +96,7 @@ static int triflex_tune_chipset(ide_driv
 
 static void triflex_tune_drive(ide_drive_t *drive, u8 pio)
 {
-	int use_pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	int use_pio = ide_get_best_pio_mode(drive, pio, 4);
 	(void) triflex_tune_chipset(drive, (XFER_PIO_0 + use_pio));
 }
 
Index: b/drivers/ide/ppc/mpc8xx.c
===================================================================
--- a/drivers/ide/ppc/mpc8xx.c
+++ b/drivers/ide/ppc/mpc8xx.c
@@ -431,13 +431,12 @@ void m8xx_ide_init_hwif_ports (hw_regs_t
 static void
 m8xx_ide_tuneproc(ide_drive_t *drive, u8 pio)
 {
-	ide_pio_data_t d;
 #if defined(CONFIG_IDE_8xx_PCCARD) || defined(CONFIG_IDE_8xx_DIRECT)
 	volatile pcmconf8xx_t	*pcmp;
 	ulong timing, mask, reg;
 #endif
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, &d);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 
 #if 1
 	printk("%s[%d] %s: best PIO mode: %d\n",
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -627,7 +627,7 @@ pmac_ide_tuneproc(ide_drive_t *drive, u8
 	/* which drive is it ? */
 	timings = &pmif->timings[drive->select.b.unit & 0x01];
 
-	pio = ide_get_best_pio_mode(drive, pio, 4, NULL);
+	pio = ide_get_best_pio_mode(drive, pio, 4);
 	cycle_time = ata_pio_cycle_time(drive, pio);
 
 	switch (pmif->kind) {
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -1377,12 +1377,8 @@ typedef struct ide_pio_timings_s {
 				/* active + recovery (+ setup for some chips) */
 } ide_pio_timings_t;
 
-typedef struct ide_pio_data_s {
-	u8 pio_mode;
-} ide_pio_data_t;
-
 unsigned int ata_pio_cycle_time(ide_drive_t *, u8);
-extern u8 ide_get_best_pio_mode (ide_drive_t *drive, u8 mode_wanted, u8 max_mode, ide_pio_data_t *d);
+u8 ide_get_best_pio_mode(ide_drive_t *, u8, u8);
 extern const ide_pio_timings_t ide_pio_timings[6];
 
 
