From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH] ide: move ide_rate_filter() calls to the upper layer (take 2)
Date: Fri, 21 Sep 2007 01:10:35 +0200
Message-ID: <200709210110.36105.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.186]:39468 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750797AbXITXRX (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 20 Sep 2007 19:17:23 -0400
Received: by mu-out-0910.google.com with SMTP id i10so1064915mue
        for <linux-ide@vger.kernel.org>; Thu, 20 Sep 2007 16:17:21 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>


* Move ide_rate_filter() calls from host drivers to IDE core.

* Make ide_rate_filter() static.

* Make 'speed' argument of ->speedproc const.

v2:
* Fix it8213_tune_chipset() comment.

There should be no functionality changes caused by this patch.

Acked-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
replacement patch for the one currently in IDE quilt tree

Sergei: since v2's change is purely cosmetic I kept your ACK

 drivers/ide/arm/icside.c       |    7 +------
 drivers/ide/cris/ide-cris.c    |    4 +---
 drivers/ide/ide-lib.c          |   17 ++++++++---------
 drivers/ide/mips/au1xxx-ide.c  |    4 +---
 drivers/ide/pci/aec62xx.c      |    6 ++----
 drivers/ide/pci/alim15x3.c     |    7 +++----
 drivers/ide/pci/amd74xx.c      |    4 +---
 drivers/ide/pci/atiixp.c       |    8 +++-----
 drivers/ide/pci/cmd64x.c       |    4 +---
 drivers/ide/pci/cs5520.c       |    5 ++---
 drivers/ide/pci/cs5530.c       |    4 +---
 drivers/ide/pci/cs5535.c       |    3 +--
 drivers/ide/pci/hpt34x.c       |    3 +--
 drivers/ide/pci/hpt366.c       |    6 ++----
 drivers/ide/pci/it8213.c       |   10 +++-------
 drivers/ide/pci/it821x.c       |   10 +++-------
 drivers/ide/pci/jmicron.c      |    9 +++------
 drivers/ide/pci/pdc202xx_new.c |    4 +---
 drivers/ide/pci/pdc202xx_old.c |    3 +--
 drivers/ide/pci/piix.c         |    7 +++----
 drivers/ide/pci/sc1200.c       |    4 +---
 drivers/ide/pci/scc_pata.c     |    5 ++---
 drivers/ide/pci/serverworks.c  |    3 +--
 drivers/ide/pci/siimage.c      |   11 ++++-------
 drivers/ide/pci/sis5513.c      |    7 ++-----
 drivers/ide/pci/sl82c105.c     |    4 +---
 drivers/ide/pci/slc90e66.c     |    3 +--
 drivers/ide/pci/tc86c001.c     |    4 +---
 drivers/ide/pci/triflex.c      |    3 +--
 drivers/ide/pci/via82cxxx.c    |    4 +---
 drivers/ide/ppc/pmac.c         |    6 +-----
 include/linux/ide.h            |    3 +--
 32 files changed, 59 insertions(+), 123 deletions(-)

Index: b/drivers/ide/arm/icside.c
===================================================================
--- a/drivers/ide/arm/icside.c
+++ b/drivers/ide/arm/icside.c
@@ -248,15 +248,10 @@ static void icside_build_sglist(ide_driv
  *	MW1	80	50	50	150	C
  *	MW2	70	25	25	120	C
  */
-static int icside_set_speed(ide_drive_t *drive, u8 xfer_mode)
+static int icside_set_speed(ide_drive_t *drive, const u8 xfer_mode)
 {
 	int on = 0, cycle_time = 0, use_dma_info = 0;
 
-	/*
-	 * Limit the transfer speed to MW_DMA_2.
-	 */
-	xfer_mode = ide_rate_filter(drive, xfer_mode);
-
 	switch (xfer_mode) {
 	case XFER_MW_DMA_2:
 		cycle_time = 250;
Index: b/drivers/ide/cris/ide-cris.c
===================================================================
--- a/drivers/ide/cris/ide-cris.c
+++ b/drivers/ide/cris/ide-cris.c
@@ -722,12 +722,10 @@ static void tune_cris_ide(ide_drive_t *d
 	(void)ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static int speed_cris_ide(ide_drive_t *drive, u8 speed)
+static int speed_cris_ide(ide_drive_t *drive, const u8 speed)
 {
 	int cyc = 0, dvs = 0, strobe = 0, hold = 0;
 
-	speed = ide_rate_filter(drive, speed);
-
 	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
 		tune_cris_ide(drive, speed - XFER_PIO_0);
 		return ide_config_drive_speed(drive, speed);
Index: b/drivers/ide/ide-lib.c
===================================================================
--- a/drivers/ide/ide-lib.c
+++ b/drivers/ide/ide-lib.c
@@ -79,7 +79,7 @@ EXPORT_SYMBOL(ide_xfer_verbose);
  *	TODO: check device PIO capabilities
  */
 
-u8 ide_rate_filter(ide_drive_t *drive, u8 speed)
+static u8 ide_rate_filter(ide_drive_t *drive, u8 speed)
 {
 	ide_hwif_t *hwif = drive->hwif;
 	u8 mode = ide_find_dma_mode(drive, speed);
@@ -96,8 +96,6 @@ u8 ide_rate_filter(ide_drive_t *drive, u
 	return min(speed, mode);
 }
 
-EXPORT_SYMBOL(ide_rate_filter);
-
 int ide_use_fast_pio(ide_drive_t *drive)
 {
 	struct hd_driveid *id = drive->id;
@@ -364,13 +362,14 @@ void ide_toggle_bounce(ide_drive_t *driv
  
 int ide_set_xfer_rate(ide_drive_t *drive, u8 rate)
 {
-#ifndef CONFIG_BLK_DEV_IDEDMA
-	rate = min(rate, (u8) XFER_PIO_4);
-#endif
-	if(HWIF(drive)->speedproc)
-		return HWIF(drive)->speedproc(drive, rate);
-	else
+	ide_hwif_t *hwif = drive->hwif;
+
+	if (hwif->speedproc == NULL)
 		return -1;
+
+	rate = ide_rate_filter(drive, rate);
+
+	return hwif->speedproc(drive, rate);
 }
 
 static void ide_dump_opcode(ide_drive_t *drive)
Index: b/drivers/ide/mips/au1xxx-ide.c
===================================================================
--- a/drivers/ide/mips/au1xxx-ide.c
+++ b/drivers/ide/mips/au1xxx-ide.c
@@ -175,13 +175,11 @@ static void auide_tune_drive(ide_drive_t
 	ide_config_drive_speed(drive, speed);
 }
 
-static int auide_tune_chipset (ide_drive_t *drive, u8 speed)
+static int auide_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	int mem_sttime;
 	int mem_stcfg;
 
-	speed = ide_rate_filter(drive, speed);
-
 	mem_sttime = 0;
 	mem_stcfg  = au_readl(MEM_STCFG2);
 
Index: b/drivers/ide/pci/aec62xx.c
===================================================================
--- a/drivers/ide/pci/aec62xx.c
+++ b/drivers/ide/pci/aec62xx.c
@@ -87,12 +87,11 @@ static u8 pci_bus_clock_list_ultra (u8 s
 	return chipset_table->ultra_settings;
 }
 
-static int aec6210_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int aec6210_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u16 d_conf		= 0;
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 	u8 ultra = 0, ultra_conf = 0;
 	u8 tmp0 = 0, tmp1 = 0, tmp2 = 0;
 	unsigned long flags;
@@ -115,11 +114,10 @@ static int aec6210_tune_chipset (ide_dri
 	return(ide_config_drive_speed(drive, speed));
 }
 
-static int aec6260_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int aec6260_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed	= ide_rate_filter(drive, xferspeed);
 	u8 unit		= (drive->select.b.unit & 0x01);
 	u8 tmp1 = 0, tmp2 = 0;
 	u8 ultra = 0, drive_conf = 0, ultra_conf = 0;
Index: b/drivers/ide/pci/alim15x3.c
===================================================================
--- a/drivers/ide/pci/alim15x3.c
+++ b/drivers/ide/pci/alim15x3.c
@@ -409,17 +409,16 @@ static u8 ali_udma_filter(ide_drive_t *d
 /**
  *	ali15x3_tune_chipset	-	set up chipset/drive for new speed
  *	@drive: drive to configure for
- *	@xferspeed: desired speed
+ *	@speed: desired speed
  *
  *	Configure the hardware for the desired IDE transfer mode.
  *	We also do the needed drive configuration through helpers
  */
- 
-static int ali15x3_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+
+static int ali15x3_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 	u8 speed1		= speed;
 	u8 unit			= (drive->select.b.unit & 0x01);
 	u8 tmpbyte		= 0x00;
Index: b/drivers/ide/pci/amd74xx.c
===================================================================
--- a/drivers/ide/pci/amd74xx.c
+++ b/drivers/ide/pci/amd74xx.c
@@ -234,14 +234,12 @@ static void amd_set_speed(struct pci_dev
  * by upper layers.
  */
 
-static int amd_set_drive(ide_drive_t *drive, u8 speed)
+static int amd_set_drive(ide_drive_t *drive, const u8 speed)
 {
 	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
 	struct ide_timing t, p;
 	int T, UT;
 
-	speed = ide_rate_filter(drive, speed);
-
 	if (speed != XFER_PIO_SLOW)
 		ide_config_drive_speed(drive, speed);
 
Index: b/drivers/ide/pci/atiixp.c
===================================================================
--- a/drivers/ide/pci/atiixp.c
+++ b/drivers/ide/pci/atiixp.c
@@ -163,23 +163,21 @@ static void atiixp_tuneproc(ide_drive_t 
 /**
  *	atiixp_tune_chipset	-	tune a ATIIXP interface
  *	@drive: IDE drive to tune
- *	@xferspeed: speed to configure
+ *	@speed: speed to configure
  *
  *	Set a ATIIXP interface channel to the desired speeds. This involves
  *	requires the right timing data into the ATIIXP configuration space
  *	then setting the drive parameters appropriately
  */
 
-static int atiixp_speedproc(ide_drive_t *drive, u8 xferspeed)
+static int atiixp_speedproc(ide_drive_t *drive, const u8 speed)
 {
 	struct pci_dev *dev = drive->hwif->pci_dev;
 	unsigned long flags;
 	int timing_shift = (drive->dn & 2) ? 16 : 0 + (drive->dn & 1) ? 0 : 8;
 	u32 tmp32;
 	u16 tmp16;
-	u8 speed, pio;
-
-	speed = ide_rate_filter(drive, xferspeed);
+	u8 pio;
 
 	if (speed >= XFER_PIO_0 && speed <= XFER_PIO_4) {
 		atiixp_tune_pio(drive, speed - XFER_PIO_0);
Index: b/drivers/ide/pci/cmd64x.c
===================================================================
--- a/drivers/ide/pci/cmd64x.c
+++ b/drivers/ide/pci/cmd64x.c
@@ -288,15 +288,13 @@ static void cmd64x_tune_drive (ide_drive
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static int cmd64x_tune_chipset (ide_drive_t *drive, u8 speed)
+static int cmd64x_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 unit			= drive->dn & 0x01;
 	u8 regU = 0, pciU	= hwif->channel ? UDIDETCR1 : UDIDETCR0;
 
-	speed = ide_rate_filter(drive, speed);
-
 	if (speed >= XFER_SW_DMA_0) {
 		(void) pci_read_config_byte(dev, pciU, &regU);
 		regU &= ~(unit ? 0xCA : 0x35);
Index: b/drivers/ide/pci/cs5520.c
===================================================================
--- a/drivers/ide/pci/cs5520.c
+++ b/drivers/ide/pci/cs5520.c
@@ -66,16 +66,15 @@ static struct pio_clocks cs5520_pio_cloc
 	{1, 2, 1}
 };
 
-static int cs5520_tune_chipset(ide_drive_t *drive, u8 xferspeed)
+static int cs5520_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *pdev = hwif->pci_dev;
-	u8 speed = ide_rate_filter(drive, xferspeed);
 	int pio = speed;
 	u8 reg;
 	int controller = drive->dn > 1 ? 1 : 0;
 	int error;
-	
+
 	switch(speed)
 	{
 		case XFER_PIO_4:
Index: b/drivers/ide/pci/cs5530.c
===================================================================
--- a/drivers/ide/pci/cs5530.c
+++ b/drivers/ide/pci/cs5530.c
@@ -143,13 +143,11 @@ static int cs5530_config_dma(ide_drive_t
 	return 1;
 }
 
-static int cs5530_tune_chipset(ide_drive_t *drive, u8 mode)
+static int cs5530_tune_chipset(ide_drive_t *drive, const u8 mode)
 {
 	unsigned long basereg;
 	unsigned int reg, timings = 0;
 
-	mode = ide_rate_filter(drive, mode);
-
 	/*
 	 * Tell the drive to switch to the new mode; abort on failure.
 	 */
Index: b/drivers/ide/pci/cs5535.c
===================================================================
--- a/drivers/ide/pci/cs5535.c
+++ b/drivers/ide/pci/cs5535.c
@@ -75,7 +75,7 @@ static unsigned int cs5535_udma_timings[
  *
  *	cs5535_set_speed() configures the chipset to a new speed.
  */
-static void cs5535_set_speed(ide_drive_t *drive, u8 speed)
+static void cs5535_set_speed(ide_drive_t *drive, const u8 speed)
 {
 
 	u32 reg = 0, dummy;
@@ -141,7 +141,6 @@ static void cs5535_set_speed(ide_drive_t
  */
 static int cs5535_set_drive(ide_drive_t *drive, u8 speed)
 {
-	speed = ide_rate_filter(drive, speed);
 	ide_config_drive_speed(drive, speed);
 	cs5535_set_speed(drive, speed);
 
Index: b/drivers/ide/pci/hpt34x.c
===================================================================
--- a/drivers/ide/pci/hpt34x.c
+++ b/drivers/ide/pci/hpt34x.c
@@ -43,10 +43,9 @@
 
 #define HPT343_DEBUG_DRIVE_INFO		0
 
-static int hpt34x_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int hpt34x_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	struct pci_dev *dev	= HWIF(drive)->pci_dev;
-	u8 speed = ide_rate_filter(drive, xferspeed);
 	u32 reg1= 0, tmp1 = 0, reg2 = 0, tmp2 = 0;
 	u8			hi_speed, lo_speed;
 
Index: b/drivers/ide/pci/hpt366.c
===================================================================
--- a/drivers/ide/pci/hpt366.c
+++ b/drivers/ide/pci/hpt366.c
@@ -582,12 +582,11 @@ static u32 get_speed_setting(u8 speed, s
 	return (*info->settings)[i];
 }
 
-static int hpt36x_tune_chipset(ide_drive_t *drive, u8 xferspeed)
+static int hpt36x_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
 	struct hpt_info	*info	= pci_get_drvdata(dev);
-	u8  speed		= ide_rate_filter(drive, xferspeed);
 	u8  itr_addr		= drive->dn ? 0x44 : 0x40;
 	u32 old_itr		= 0;
 	u32 itr_mask, new_itr;
@@ -610,12 +609,11 @@ static int hpt36x_tune_chipset(ide_drive
 	return ide_config_drive_speed(drive, speed);
 }
 
-static int hpt37x_tune_chipset(ide_drive_t *drive, u8 xferspeed)
+static int hpt37x_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev  *dev	= hwif->pci_dev;
 	struct hpt_info	*info	= pci_get_drvdata(dev);
-	u8  speed		= ide_rate_filter(drive, xferspeed);
 	u8  itr_addr		= 0x40 + (drive->dn * 4);
 	u32 old_itr		= 0;
 	u32 itr_mask, new_itr;
Index: b/drivers/ide/pci/it8213.c
===================================================================
--- a/drivers/ide/pci/it8213.c
+++ b/drivers/ide/pci/it8213.c
@@ -115,20 +115,16 @@ static void it8213_tuneproc(ide_drive_t 
 /**
  *	it8213_tune_chipset	-	set controller timings
  *	@drive: Drive to set up
- *	@xferspeed: speed we want to achieve
+ *	@speed: speed we want to achieve
  *
- *	Tune the ITE chipset for the desired mode. If we can't achieve
- *	the desired mode then tune for a lower one, but ultimately
- *	make the thing work.
+ *	Tune the ITE chipset for the desired mode.
  */
 
-static int it8213_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int it8213_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
-
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 maslave		= 0x40;
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 	int a_speed		= 3 << (drive->dn * 4);
 	int u_flag		= 1 << drive->dn;
 	int v_flag		= 0x01 << drive->dn;
Index: b/drivers/ide/pci/it821x.c
===================================================================
--- a/drivers/ide/pci/it821x.c
+++ b/drivers/ide/pci/it821x.c
@@ -405,23 +405,19 @@ static int it821x_dma_end(ide_drive_t *d
 	return ret;
 }
 
-
 /**
  *	it821x_tune_chipset	-	set controller timings
  *	@drive: Drive to set up
- *	@xferspeed: speed we want to achieve
+ *	@speed: speed we want to achieve
  *
- *	Tune the ITE chipset for the desired mode. If we can't achieve
- *	the desired mode then tune for a lower one, but ultimately
- *	make the thing work.
+ *	Tune the ITE chipset for the desired mode.
  */
 
-static int it821x_tune_chipset (ide_drive_t *drive, byte xferspeed)
+static int it821x_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 
 	ide_hwif_t *hwif	= drive->hwif;
 	struct it821x_dev *itdev = ide_get_hwifdata(hwif);
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 
 	switch (speed) {
 	case XFER_PIO_4:
Index: b/drivers/ide/pci/jmicron.c
===================================================================
--- a/drivers/ide/pci/jmicron.c
+++ b/drivers/ide/pci/jmicron.c
@@ -92,17 +92,14 @@ static void jmicron_tuneproc(ide_drive_t
 /**
  *	jmicron_tune_chipset	-	set controller timings
  *	@drive: Drive to set up
- *	@xferspeed: speed we want to achieve
+ *	@speed: speed we want to achieve
  *
  *	As the JMicron snoops for timings all we actually need to do is
- *	make sure we don't set an invalid mode. We do need to honour
- *	the cable detect here.
+ *	set the transfer mode on the device.
  */
 
-static int jmicron_tune_chipset (ide_drive_t *drive, byte xferspeed)
+static int jmicron_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
-	u8 speed = ide_rate_filter(drive, xferspeed);
-
 	return ide_config_drive_speed(drive, speed);
 }
 
Index: b/drivers/ide/pci/pdc202xx_new.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_new.c
+++ b/drivers/ide/pci/pdc202xx_new.c
@@ -146,14 +146,12 @@ static struct udma_timing {
 	{ 0x1a, 0x01, 0xcb },	/* UDMA mode 6 */
 };
 
-static int pdcnew_tune_chipset(ide_drive_t *drive, u8 speed)
+static int pdcnew_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	u8 adj			= (drive->dn & 1) ? 0x08 : 0x00;
 	int			err;
 
-	speed = ide_rate_filter(drive, speed);
-
 	/*
 	 * Issue SETFEATURES_XFER to the drive first. PDC202xx hardware will
 	 * automatically set the timing registers based on 100 MHz PLL output.
Index: b/drivers/ide/pci/pdc202xx_old.c
===================================================================
--- a/drivers/ide/pci/pdc202xx_old.c
+++ b/drivers/ide/pci/pdc202xx_old.c
@@ -63,12 +63,11 @@ static const char *pdc_quirk_drives[] = 
 
 static void pdc_old_disable_66MHz_clock(ide_hwif_t *);
 
-static int pdc202xx_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int pdc202xx_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 drive_pci		= 0x60 + (drive->dn << 2);
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 
 	u8			AP = 0, BP = 0, CP = 0;
 	u8			TA = 0, TB = 0, TC = 0;
Index: b/drivers/ide/pci/piix.c
===================================================================
--- a/drivers/ide/pci/piix.c
+++ b/drivers/ide/pci/piix.c
@@ -221,19 +221,18 @@ static void piix_tune_drive (ide_drive_t
 /**
  *	piix_tune_chipset	-	tune a PIIX interface
  *	@drive: IDE drive to tune
- *	@xferspeed: speed to configure
+ *	@speed: speed to configure
  *
  *	Set a PIIX interface channel to the desired speeds. This involves
  *	requires the right timing data into the PIIX configuration space
  *	then setting the drive parameters appropriately
  */
- 
-static int piix_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+
+static int piix_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 maslave		= hwif->channel ? 0x42 : 0x40;
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 	int a_speed		= 3 << (drive->dn * 4);
 	int u_flag		= 1 << drive->dn;
 	int v_flag		= 0x01 << drive->dn;
Index: b/drivers/ide/pci/sc1200.c
===================================================================
--- a/drivers/ide/pci/sc1200.c
+++ b/drivers/ide/pci/sc1200.c
@@ -138,7 +138,7 @@ out:
 	return mask;
 }
 
-static int sc1200_tune_chipset(ide_drive_t *drive, u8 mode)
+static int sc1200_tune_chipset(ide_drive_t *drive, const u8 mode)
 {
 	ide_hwif_t		*hwif = HWIF(drive);
 	int			unit = drive->select.b.unit;
@@ -146,8 +146,6 @@ static int sc1200_tune_chipset(ide_drive
 	unsigned short		pci_clock;
 	unsigned int		basereg = hwif->channel ? 0x50 : 0x40;
 
-	mode = ide_rate_filter(drive, mode);
-
 	/*
 	 * Tell the drive to switch to the new mode; abort on failure.
 	 */
Index: b/drivers/ide/pci/scc_pata.c
===================================================================
--- a/drivers/ide/pci/scc_pata.c
+++ b/drivers/ide/pci/scc_pata.c
@@ -231,16 +231,15 @@ static void scc_tuneproc(ide_drive_t *dr
 /**
  *	scc_tune_chipset	-	tune a drive DMA mode
  *	@drive: Drive to set up
- *	@xferspeed: speed we want to achieve
+ *	@speed: speed we want to achieve
  *
  *	Load the timing settings for this device mode into the
  *	controller.
  */
 
-static int scc_tune_chipset(ide_drive_t *drive, byte xferspeed)
+static int scc_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif = HWIF(drive);
-	u8 speed = ide_rate_filter(drive, xferspeed);
 	struct scc_ports *ports = ide_get_hwifdata(hwif);
 	unsigned long ctl_base = ports->ctl;
 	unsigned long cckctrl_port = ctl_base + 0xff0;
Index: b/drivers/ide/pci/serverworks.c
===================================================================
--- a/drivers/ide/pci/serverworks.c
+++ b/drivers/ide/pci/serverworks.c
@@ -145,7 +145,7 @@ static void svwks_tune_pio(ide_drive_t *
 	}
 }
 
-static int svwks_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int svwks_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	static const u8 udma_modes[]		= { 0x00, 0x01, 0x02, 0x03, 0x04, 0x05 };
 	static const u8 dma_modes[]		= { 0x77, 0x21, 0x20 };
@@ -153,7 +153,6 @@ static int svwks_tune_chipset (ide_drive
 
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 	u8 unit			= (drive->select.b.unit & 0x01);
 
 	u8 ultra_enable	 = 0, ultra_timing = 0, dma_timing = 0;
Index: b/drivers/ide/pci/siimage.c
===================================================================
--- a/drivers/ide/pci/siimage.c
+++ b/drivers/ide/pci/siimage.c
@@ -229,14 +229,12 @@ static void sil_tuneproc(ide_drive_t *dr
 /**
  *	siimage_tune_chipset	-	set controller timings
  *	@drive: Drive to set up
- *	@xferspeed: speed we want to achieve
+ *	@speed: speed we want to achieve
  *
- *	Tune the SII chipset for the desired mode. If we can't achieve
- *	the desired mode then tune for a lower one, but ultimately
- *	make the thing work.
+ *	Tune the SII chipset for the desired mode.
  */
- 
-static int siimage_tune_chipset (ide_drive_t *drive, byte xferspeed)
+
+static int siimage_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	u8 ultra6[]		= { 0x0F, 0x0B, 0x07, 0x05, 0x03, 0x02, 0x01 };
 	u8 ultra5[]		= { 0x0C, 0x07, 0x05, 0x04, 0x02, 0x01 };
@@ -245,7 +243,6 @@ static int siimage_tune_chipset (ide_dri
 	ide_hwif_t *hwif	= HWIF(drive);
 	u16 ultra = 0, multi	= 0;
 	u8 mode = 0, unit	= drive->select.b.unit;
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 	unsigned long base	= (unsigned long)hwif->hwif_data;
 	u8 scsc = 0, addr_mask	= ((hwif->channel) ?
 				    ((hwif->mmio) ? 0xF4 : 0x84) :
Index: b/drivers/ide/pci/sis5513.c
===================================================================
--- a/drivers/ide/pci/sis5513.c
+++ b/drivers/ide/pci/sis5513.c
@@ -531,15 +531,12 @@ static void sis5513_tuneproc(ide_drive_t
 	(void)sis5513_tune_drive(drive, pio);
 }
 
-static int sis5513_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int sis5513_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
-
-	u8 drive_pci, reg, speed;
 	u32 regdw;
-
-	speed = ide_rate_filter(drive, xferspeed);
+	u8 drive_pci, reg;
 
 	/* See config_art_rwp_pio for drive pci config registers */
 	drive_pci = 0x40;
Index: b/drivers/ide/pci/sl82c105.c
===================================================================
--- a/drivers/ide/pci/sl82c105.c
+++ b/drivers/ide/pci/sl82c105.c
@@ -113,7 +113,7 @@ static u8 sl82c105_tune_pio(ide_drive_t 
 /*
  * Configure the drive and chipset for a new transfer speed.
  */
-static int sl82c105_tune_chipset(ide_drive_t *drive, u8 speed)
+static int sl82c105_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	static u16 mwdma_timings[] = {0x0707, 0x0201, 0x0200};
 	u16 drv_ctrl;
@@ -121,8 +121,6 @@ static int sl82c105_tune_chipset(ide_dri
  	DBG(("sl82c105_tune_chipset(drive:%s, speed:%s)\n",
 	     drive->name, ide_xfer_verbose(speed)));
 
-	speed = ide_rate_filter(drive, speed);
-
 	switch (speed) {
 	case XFER_MW_DMA_2:
 	case XFER_MW_DMA_1:
Index: b/drivers/ide/pci/slc90e66.c
===================================================================
--- a/drivers/ide/pci/slc90e66.c
+++ b/drivers/ide/pci/slc90e66.c
@@ -102,12 +102,11 @@ static void slc90e66_tune_drive (ide_dri
 	(void) ide_config_drive_speed(drive, XFER_PIO_0 + pio);
 }
 
-static int slc90e66_tune_chipset (ide_drive_t *drive, u8 xferspeed)
+static int slc90e66_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	struct pci_dev *dev	= hwif->pci_dev;
 	u8 maslave		= hwif->channel ? 0x42 : 0x40;
-	u8 speed		= ide_rate_filter(drive, xferspeed);
 	int sitre = 0, a_speed	= 7 << (drive->dn * 4);
 	int u_speed = 0, u_flag = 1 << drive->dn;
 	u16			reg4042, reg44, reg48, reg4a;
Index: b/drivers/ide/pci/tc86c001.c
===================================================================
--- a/drivers/ide/pci/tc86c001.c
+++ b/drivers/ide/pci/tc86c001.c
@@ -13,14 +13,12 @@
 #include <linux/pci.h>
 #include <linux/ide.h>
 
-static int tc86c001_tune_chipset(ide_drive_t *drive, u8 speed)
+static int tc86c001_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif	= HWIF(drive);
 	unsigned long scr_port	= hwif->config_data + (drive->dn ? 0x02 : 0x00);
 	u16 mode, scr		= hwif->INW(scr_port);
 
-	speed = ide_rate_filter(drive, speed);
-
 	switch (speed) {
 		case XFER_UDMA_4:	mode = 0x00c0; break;
 		case XFER_UDMA_3:	mode = 0x00b0; break;
Index: b/drivers/ide/pci/triflex.c
===================================================================
--- a/drivers/ide/pci/triflex.c
+++ b/drivers/ide/pci/triflex.c
@@ -40,7 +40,7 @@
 #include <linux/ide.h>
 #include <linux/init.h>
 
-static int triflex_tune_chipset(ide_drive_t *drive, u8 xferspeed)
+static int triflex_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	ide_hwif_t *hwif = HWIF(drive);
 	struct pci_dev *dev = hwif->pci_dev;
@@ -48,7 +48,6 @@ static int triflex_tune_chipset(ide_driv
 	u16 timing = 0;
 	u32 triflex_timings = 0;
 	u8 unit = (drive->select.b.unit & 0x01);
-	u8 speed = ide_rate_filter(drive, xferspeed);
 	
 	pci_read_config_dword(dev, channel_offset, &triflex_timings);
 	
Index: b/drivers/ide/pci/via82cxxx.c
===================================================================
--- a/drivers/ide/pci/via82cxxx.c
+++ b/drivers/ide/pci/via82cxxx.c
@@ -158,15 +158,13 @@ static void via_set_speed(ide_hwif_t *hw
  *	by upper layers.
  */
 
-static int via_set_drive(ide_drive_t *drive, u8 speed)
+static int via_set_drive(ide_drive_t *drive, const u8 speed)
 {
 	ide_drive_t *peer = HWIF(drive)->drives + (~drive->dn & 1);
 	struct via82cxxx_dev *vdev = pci_get_drvdata(drive->hwif->pci_dev);
 	struct ide_timing t, p;
 	unsigned int T, UT;
 
-	speed = ide_rate_filter(drive, speed);
-
 	if (speed != XFER_PIO_SLOW)
 		ide_config_drive_speed(drive, speed);
 
Index: b/drivers/ide/ppc/pmac.c
===================================================================
--- a/drivers/ide/ppc/pmac.c
+++ b/drivers/ide/ppc/pmac.c
@@ -411,7 +411,6 @@ kauai_lookup_timing(struct kauai_timing*
 
 static void pmac_ide_setup_dma(pmac_ide_hwif_t *pmif, ide_hwif_t *hwif);
 static int pmac_ide_build_dmatable(ide_drive_t *drive, struct request *rq);
-static int pmac_ide_tune_chipset(ide_drive_t *drive, u8 speed);
 static void pmac_ide_tuneproc(ide_drive_t *drive, u8 pio);
 static void pmac_ide_selectproc(ide_drive_t *drive);
 static void pmac_ide_kauai_selectproc(ide_drive_t *drive);
@@ -920,16 +919,13 @@ set_timings_mdma(ide_drive_t *drive, int
  * our dedicated function is more precise as it uses the drive provided
  * cycle time value. We should probably fix this one to deal with that too...
  */
-static int
-pmac_ide_tune_chipset (ide_drive_t *drive, byte speed)
+static int pmac_ide_tune_chipset(ide_drive_t *drive, const u8 speed)
 {
 	int unit = (drive->select.b.unit & 0x01);
 	int ret = 0;
 	pmac_ide_hwif_t* pmif = (pmac_ide_hwif_t *)HWIF(drive)->hwif_data;
 	u32 *timings, *timings2;
 
-	speed = ide_rate_filter(drive, speed);
-
 	if (pmif == NULL)
 		return 1;
 		
Index: b/include/linux/ide.h
===================================================================
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -705,7 +705,7 @@ typedef struct hwif_s {
 	/* routine to tune PIO mode for drives */
 	void	(*tuneproc)(ide_drive_t *, u8);
 	/* routine to retune DMA modes for drives */
-	int	(*speedproc)(ide_drive_t *, u8);
+	int	(*speedproc)(ide_drive_t *, const u8);
 	/* tweaks hardware to select drive */
 	void	(*selectproc)(ide_drive_t *);
 	/* chipset polling based on hba specifics */
@@ -1377,7 +1377,6 @@ static inline void ide_set_hwifdata (ide
 }
 
 /* ide-lib.c */
-u8 ide_rate_filter(ide_drive_t *, u8);
 extern char *ide_xfer_verbose(u8 xfer_rate);
 extern void ide_toggle_bounce(ide_drive_t *drive, int on);
 extern int ide_set_xfer_rate(ide_drive_t *drive, u8 rate);
