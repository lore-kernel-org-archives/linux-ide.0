From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Sun, 17 May 2009 17:20:28 +0200
Message-ID: <200905171720.28640.bzolnier@gmail.com>
References: <49CCD7C4.8000207@inov.pt> <200905121923.08159.bzolnier@gmail.com> <4A0AA880.8070209@inov.pt>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-ew0-f176.google.com ([209.85.219.176]:38278 "EHLO
	mail-ew0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753105AbZEQPUi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Sun, 17 May 2009 11:20:38 -0400
Received: by mail-ew0-f176.google.com with SMTP id 24so3531116ewy.37
        for <linux-ide@vger.kernel.org>; Sun, 17 May 2009 08:20:38 -0700 (PDT)
In-Reply-To: <4A0AA880.8070209@inov.pt>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: =?iso-8859-15?q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

On Wednesday 13 May 2009 13:01:20 Jo=E3o Ramos wrote:
> Here's the revised patches, according to the changes you suggested.

Thanks, I applied set_pio_mode.patch with the following minor fixup:

@@ -1035,7 +1035,7 @@
=20
 	ide_port_for_each_dev(i, drive, hwif) {
 		/*
-		 * default to PIO Mode 0 before we  figure out
+		 * default to PIO Mode 0 before we figure out
 		 * the most suited mode for the attached device
 		 */
 		if (port_ops && port_ops->set_pio_mode)

and will apply the following version of ide_drive_data.patch
(unless there are some major complains):

=46rom: Joao Ramos <joao.ramos@inov.pt>
Subject: ide: do not access ide_drive_t 'drive_data' field directly

Change ide_drive_t 'drive_data' field from 'unsigned int' type to 'void=
 *'
type, allowing a wider range of values/types to be stored in this field=
=2E

Added 'ide_get_drivedata' and 'ide_set_drivedata' helpers to get and se=
t
the 'drive_data' field.

=46ixed all host drivers to maintain coherency with the change in the
'drive_data' field type.

Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
[bart: fix qd65xx build, cast to 'unsigned long', minor Coding Style fi=
xups]
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/ide/cmd64x.c   |    8 +++++---
 drivers/ide/cs5536.c   |   23 +++++++++++++++--------
 drivers/ide/ht6560b.c  |   33 ++++++++++++++++++++++++---------
 drivers/ide/icside.c   |   10 ++++++----
 drivers/ide/opti621.c  |    8 +++++---
 drivers/ide/qd65xx.c   |   11 +++++++----
 drivers/ide/qd65xx.h   |   11 +++++++++--
 drivers/ide/sl82c105.c |   18 ++++++++++++------
 include/linux/ide.h    |   12 +++++++++++-
 9 files changed, 94 insertions(+), 40 deletions(-)

Index: b/drivers/ide/cmd64x.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -118,8 +118,9 @@ static void cmd64x_tune_pio(ide_drive_t=20
 	ide_hwif_t *hwif	=3D drive->hwif;
 	struct pci_dev *dev	=3D to_pci_dev(hwif->dev);
 	struct ide_timing *t	=3D ide_timing_find_mode(XFER_PIO_0 + pio);
+	unsigned long setup_count;
 	unsigned int cycle_time;
-	u8 setup_count, arttim =3D 0;
+	u8 arttim =3D 0;
=20
 	static const u8 setup_values[] =3D {0x40, 0x40, 0x40, 0x80, 0, 0xc0};
 	static const u8 arttim_regs[4] =3D {ARTTIM0, ARTTIM1, ARTTIM23, ARTTI=
M23};
@@ -140,10 +141,11 @@ static void cmd64x_tune_pio(ide_drive_t=20
 	if (hwif->channel) {
 		ide_drive_t *pair =3D ide_get_pair_dev(drive);
=20
-		drive->drive_data =3D setup_count;
+		ide_set_drivedata(drive, (void *)setup_count);
=20
 		if (pair)
-			setup_count =3D max_t(u8, setup_count, pair->drive_data);
+			setup_count =3D max_t(u8, setup_count,
+					(unsigned long)ide_get_drivedata(pair));
 	}
=20
 	if (setup_count > 5)		/* shouldn't actually happen... */
Index: b/drivers/ide/cs5536.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -146,14 +146,16 @@ static void cs5536_set_pio_mode(ide_driv
 	struct pci_dev *pdev =3D to_pci_dev(drive->hwif->dev);
 	ide_drive_t *pair =3D ide_get_pair_dev(drive);
 	int cshift =3D (drive->dn & 1) ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIF=
T;
+	unsigned long timings =3D (unsigned long)ide_get_drivedata(drive);
 	u32 cast;
 	u8 cmd_pio =3D pio;
=20
 	if (pair)
 		cmd_pio =3D min(pio, ide_get_best_pio_mode(pair, 255, 4));
=20
-	drive->drive_data &=3D (IDE_DRV_MASK << 8);
-	drive->drive_data |=3D drv_timings[pio];
+	timings &=3D (IDE_DRV_MASK << 8);
+	timings |=3D drv_timings[pio];
+	ide_set_drivedata(drive, (void *)timings);
=20
 	cs5536_program_dtc(drive, drv_timings[pio]);
=20
@@ -186,6 +188,7 @@ static void cs5536_set_dma_mode(ide_driv
=20
 	struct pci_dev *pdev =3D to_pci_dev(drive->hwif->dev);
 	int dshift =3D (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
+	unsigned long timings =3D (unsigned long)ide_get_drivedata(drive);
 	u32 etc;
=20
 	cs5536_read(pdev, ETC, &etc);
@@ -195,8 +198,9 @@ static void cs5536_set_dma_mode(ide_driv
 		etc |=3D udma_timings[mode - XFER_UDMA_0] << dshift;
 	} else { /* MWDMA */
 		etc &=3D ~(IDE_ETC_UDMA_MASK << dshift);
-		drive->drive_data &=3D IDE_DRV_MASK;
-		drive->drive_data |=3D mwdma_timings[mode - XFER_MW_DMA_0] << 8;
+		timings &=3D IDE_DRV_MASK;
+		timings |=3D mwdma_timings[mode - XFER_MW_DMA_0] << 8;
+		ide_set_drivedata(drive, (void *)timings);
 	}
=20
 	cs5536_write(pdev, ETC, etc);
@@ -204,9 +208,11 @@ static void cs5536_set_dma_mode(ide_driv
=20
 static void cs5536_dma_start(ide_drive_t *drive)
 {
+	unsigned long timings =3D (unsigned long)ide_get_drivedata(drive);
+
 	if (drive->current_speed < XFER_UDMA_0 &&
-	    (drive->drive_data >> 8) !=3D (drive->drive_data & IDE_DRV_MASK))
-		cs5536_program_dtc(drive, drive->drive_data >> 8);
+	    (timings >> 8) !=3D (timings & IDE_DRV_MASK))
+		cs5536_program_dtc(drive, timings >> 8);
=20
 	ide_dma_start(drive);
 }
@@ -214,10 +220,11 @@ static void cs5536_dma_start(ide_drive_t
 static int cs5536_dma_end(ide_drive_t *drive)
 {
 	int ret =3D ide_dma_end(drive);
+	unsigned long timings =3D (unsigned long)ide_get_drivedata(drive);
=20
 	if (drive->current_speed < XFER_UDMA_0 &&
-	    (drive->drive_data >> 8) !=3D (drive->drive_data & IDE_DRV_MASK))
-		cs5536_program_dtc(drive, drive->drive_data & IDE_DRV_MASK);
+	    (timings >> 8) !=3D (timings & IDE_DRV_MASK))
+		cs5536_program_dtc(drive, timings & IDE_DRV_MASK);
=20
 	return ret;
 }
Index: b/drivers/ide/ht6560b.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/ht6560b.c
+++ b/drivers/ide/ht6560b.c
@@ -44,7 +44,12 @@
  *    bit3 (0x08): "1" 3 cycle time, "0" 2 cycle time	      (?)
  */
 #define HT_CONFIG_PORT	  0x3e6
-#define HT_CONFIG(drivea) (u8)(((drivea)->drive_data & 0xff00) >> 8)
+
+static inline u8 HT_CONFIG(ide_drive_t *drive)
+{
+	return ((unsigned long)ide_get_drivedata(drive) & 0xff00) >> 8;
+}
+
 /*
  * FIFO + PREFETCH (both a/b-model)
  */
@@ -90,7 +95,11 @@
  * Active Time for each drive. Smaller value gives higher speed.
  * In case of failures you should probably fall back to a higher value=
=2E
  */
-#define HT_TIMING(drivea) (u8)((drivea)->drive_data & 0x00ff)
+static inline u8 HT_TIMING(ide_drive_t *drive)
+{
+	return (unsigned long)ide_get_drivedata(drive) & 0x00ff;
+}
+
 #define HT_TIMING_DEFAULT 0xff
=20
 /*
@@ -242,23 +251,27 @@ static DEFINE_SPINLOCK(ht6560b_lock);
  */
 static void ht_set_prefetch(ide_drive_t *drive, u8 state)
 {
-	unsigned long flags;
+	unsigned long flags, config;
 	int t =3D HT_PREFETCH_MODE << 8;
=20
 	spin_lock_irqsave(&ht6560b_lock, flags);
=20
+	config =3D (unsigned long)ide_get_drivedata(drive);
+
 	/*
 	 *  Prefetch mode and unmask irq seems to conflict
 	 */
 	if (state) {
-		drive->drive_data |=3D t;   /* enable prefetch mode */
+		config |=3D t;   /* enable prefetch mode */
 		drive->dev_flags |=3D IDE_DFLAG_NO_UNMASK;
 		drive->dev_flags &=3D ~IDE_DFLAG_UNMASK;
 	} else {
-		drive->drive_data &=3D ~t;  /* disable prefetch mode */
+		config &=3D ~t;  /* disable prefetch mode */
 		drive->dev_flags &=3D ~IDE_DFLAG_NO_UNMASK;
 	}
=20
+	ide_set_drivedata(drive, (void *)config);
+
 	spin_unlock_irqrestore(&ht6560b_lock, flags);
=20
 #ifdef DEBUG
@@ -268,7 +281,7 @@ static void ht_set_prefetch(ide_drive_t=20
=20
 static void ht6560b_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
-	unsigned long flags;
+	unsigned long flags, config;
 	u8 timing;
 =09
 	switch (pio) {
@@ -281,8 +294,10 @@ static void ht6560b_set_pio_mode(ide_dri
 	timing =3D ht_pio2timings(drive, pio);
=20
 	spin_lock_irqsave(&ht6560b_lock, flags);
-	drive->drive_data &=3D 0xff00;
-	drive->drive_data |=3D timing;
+	config =3D (unsigned long)ide_get_drivedata(drive);
+	config &=3D 0xff00;
+	config |=3D timing;
+	ide_set_drivedata(drive, (void *)config);
 	spin_unlock_irqrestore(&ht6560b_lock, flags);
=20
 #ifdef DEBUG
@@ -299,7 +314,7 @@ static void __init ht6560b_init_dev(ide_
 	if (hwif->channel)
 		t |=3D (HT_SECONDARY_IF << 8);
=20
-	drive->drive_data =3D t;
+	ide_set_drivedata(drive, (void *)t);
 }
=20
 static int probe_ht6560b;
Index: b/drivers/ide/icside.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -236,7 +236,8 @@ static const struct ide_port_ops icside_
  */
 static void icside_set_dma_mode(ide_drive_t *drive, const u8 xfer_mode=
)
 {
-	int cycle_time, use_dma_info =3D 0;
+	unsigned long cycle_time;
+	int use_dma_info =3D 0;
=20
 	switch (xfer_mode) {
 	case XFER_MW_DMA_2:
@@ -267,10 +268,11 @@ static void icside_set_dma_mode(ide_driv
 	if (use_dma_info && drive->id[ATA_ID_EIDE_DMA_TIME] > cycle_time)
 		cycle_time =3D drive->id[ATA_ID_EIDE_DMA_TIME];
=20
-	drive->drive_data =3D cycle_time;
+	ide_set_drivedata(drive, (void *)cycle_time);
=20
 	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
-		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);
+		ide_xfer_verbose(xfer_mode),
+		2000 / (unsigned long)ide_get_drivedata(drive));
 }
=20
 static const struct ide_port_ops icside_v6_port_ops =3D {
@@ -332,7 +334,7 @@ static int icside_dma_setup(ide_drive_t=20
 	/*
 	 * Select the correct timing for this drive.
 	 */
-	set_dma_speed(ec->dma, drive->drive_data);
+	set_dma_speed(ec->dma, (unsigned long)ide_get_drivedata(drive));
=20
 	/*
 	 * Tell the DMA engine about the SG table and
Index: b/drivers/ide/opti621.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/opti621.c
+++ b/drivers/ide/opti621.c
@@ -138,6 +138,7 @@ static void opti621_set_pio_mode(ide_dri
 	ide_hwif_t *hwif =3D drive->hwif;
 	ide_drive_t *pair =3D ide_get_pair_dev(drive);
 	unsigned long flags;
+	unsigned long mode =3D XFER_PIO_0 + pio, pair_mode;
 	u8 tim, misc, addr_pio =3D pio, clk;
=20
 	/* DRDY is default 2 (by OPTi Databook) */
@@ -150,11 +151,12 @@ static void opti621_set_pio_mode(ide_dri
 		{ 0x48, 0x34, 0x21, 0x10, 0x10 }	/* 25 MHz */
 	};
=20
-	drive->drive_data =3D XFER_PIO_0 + pio;
+	ide_set_drivedata(drive, (void *)mode);
=20
 	if (pair) {
-		if (pair->drive_data && pair->drive_data < drive->drive_data)
-			addr_pio =3D pair->drive_data - XFER_PIO_0;
+		pair_mode =3D (unsigned long)ide_get_drivedata(pair);
+		if (pair_mode && pair_mode < mode)
+			addr_pio =3D pair_mode - XFER_PIO_0;
 	}
=20
 	spin_lock_irqsave(&opti621_lock, flags);
Index: b/drivers/ide/qd65xx.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/qd65xx.c
+++ b/drivers/ide/qd65xx.c
@@ -180,8 +180,11 @@ static int qd_find_disk_type (ide_drive_
=20
 static void qd_set_timing (ide_drive_t *drive, u8 timing)
 {
-	drive->drive_data &=3D 0xff00;
-	drive->drive_data |=3D timing;
+	unsigned long data =3D (unsigned long)ide_get_drivedata(drive);
+
+	data &=3D 0xff00;
+	data |=3D timing;
+	ide_set_drivedata(drive, (void *)data);
=20
 	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
 }
@@ -292,7 +295,7 @@ static void __init qd6500_init_dev(ide_d
 	u8 base =3D (hwif->config_data & 0xff00) >> 8;
 	u8 config =3D QD_CONFIG(hwif);
=20
-	drive->drive_data =3D QD6500_DEF_DATA;
+	ide_set_drivedata(drive, (void *)QD6500_DEF_DATA);
 }
=20
 static void __init qd6580_init_dev(ide_drive_t *drive)
@@ -308,7 +311,7 @@ static void __init qd6580_init_dev(ide_d
 	} else
 		t2 =3D t1 =3D hwif->channel ? QD6580_DEF_DATA2 : QD6580_DEF_DATA;
=20
-	drive->drive_data =3D (drive->dn & 1) ? t2 : t1;
+	ide_set_drivedata(drive, (void *)((drive->dn & 1) ? t2 : t1));
 }
=20
 static const struct ide_tp_ops qd65xx_tp_ops =3D {
Index: b/drivers/ide/qd65xx.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/qd65xx.h
+++ b/drivers/ide/qd65xx.h
@@ -31,8 +31,15 @@
=20
 #define QD_CONFIG(hwif)		((hwif)->config_data & 0x00ff)
=20
-#define QD_TIMING(drive)	(u8)(((drive)->drive_data) & 0x00ff)
-#define QD_TIMREG(drive)	(u8)((((drive)->drive_data) & 0xff00) >> 8)
+static inline u8 QD_TIMING(ide_drive_t *drive)
+{
+	return (unsigned long)ide_get_drivedata(drive) & 0x00ff;
+}
+
+static inline u8 QD_TIMREG(ide_drive_t *drive)
+{
+	return ((unsigned long)ide_get_drivedata(drive) & 0xff00) >> 8;
+}
=20
 #define QD6500_DEF_DATA		((QD_TIM1_PORT<<8) | (QD_ID3 ? 0x0c : 0x08))
 #define QD6580_DEF_DATA		((QD_TIM1_PORT<<8) | (QD_ID3 ? 0x0a : 0x00))
Index: b/drivers/ide/sl82c105.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -74,6 +74,7 @@ static unsigned int get_pio_timings(ide_
 static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	struct pci_dev *dev	=3D to_pci_dev(drive->hwif->dev);
+	unsigned long timings	=3D (unsigned long)ide_get_drivedata(drive);
 	int reg			=3D 0x44 + drive->dn * 4;
 	u16 drv_ctrl;
=20
@@ -83,8 +84,9 @@ static void sl82c105_set_pio_mode(ide_dr
 	 * Store the PIO timings so that we can restore them
 	 * in case DMA will be turned off...
 	 */
-	drive->drive_data &=3D 0xffff0000;
-	drive->drive_data |=3D drv_ctrl;
+	timings &=3D 0xffff0000;
+	timings |=3D drv_ctrl;
+	ide_set_drivedata(drive, (void *)timings);
=20
 	pci_write_config_word(dev, reg,  drv_ctrl);
 	pci_read_config_word (dev, reg, &drv_ctrl);
@@ -100,6 +102,7 @@ static void sl82c105_set_pio_mode(ide_dr
 static void sl82c105_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	static u16 mwdma_timings[] =3D {0x0707, 0x0201, 0x0200};
+	unsigned long timings =3D (unsigned long)ide_get_drivedata(drive);
 	u16 drv_ctrl;
=20
  	DBG(("sl82c105_tune_chipset(drive:%s, speed:%s)\n",
@@ -111,8 +114,9 @@ static void sl82c105_set_dma_mode(ide_dr
 	 * Store the DMA timings so that we can actually program
 	 * them when DMA will be turned on...
 	 */
-	drive->drive_data &=3D 0x0000ffff;
-	drive->drive_data |=3D (unsigned long)drv_ctrl << 16;
+	timings &=3D 0x0000ffff;
+	timings |=3D (unsigned long)drv_ctrl << 16;
+	ide_set_drivedata(drive, (void *)timings);
 }
=20
 /*
@@ -184,7 +188,8 @@ static void sl82c105_dma_start(ide_drive
=20
 	DBG(("%s(drive:%s)\n", __func__, drive->name));
=20
-	pci_write_config_word(dev, reg, drive->drive_data >> 16);
+	pci_write_config_word(dev, reg,
+			      (unsigned long)ide_get_drivedata(drive) >> 16);
=20
 	sl82c105_reset_host(dev);
 	ide_dma_start(drive);
@@ -209,7 +214,8 @@ static int sl82c105_dma_end(ide_drive_t=20
=20
 	ret =3D ide_dma_end(drive);
=20
-	pci_write_config_word(dev, reg, drive->drive_data);
+	pci_write_config_word(dev, reg,
+			      (unsigned long)ide_get_drivedata(drive));
=20
 	return ret;
 }
Index: b/include/linux/ide.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -559,7 +559,7 @@ struct ide_drive_s {
=20
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
-	unsigned int	drive_data;	/* used by set_pio_mode/dev_select() */
+	void		*drive_data;	/* used by set_pio_mode/dev_select() */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	u64		probed_capacity;/* initial reported media capacity (ide-cd only =
currently) */
@@ -1567,6 +1567,16 @@ static inline ide_drive_t *ide_get_pair_
 	return (peer->dev_flags & IDE_DFLAG_PRESENT) ? peer : NULL;
 }
=20
+static inline void *ide_get_drivedata(ide_drive_t *drive)
+{
+	return drive->drive_data;
+}
+
+static inline void ide_set_drivedata(ide_drive_t *drive, void *data)
+{
+	drive->drive_data =3D data;
+}
+
 #define ide_port_for_each_dev(i, dev, port) \
 	for ((i) =3D 0; ((dev) =3D (port)->devices[i]) || (i) < MAX_DRIVES; (=
i)++)
=20
