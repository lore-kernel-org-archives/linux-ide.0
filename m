From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Wed, 13 May 2009 12:01:20 +0100
Message-ID: <4A0AA880.8070209@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <4A08079A.9080803@inov.pt> <4A09A8A1.5070002@ru.mvista.com> <200905121923.08159.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080007070906030505040104"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:54131 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758583AbZEMLBz (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 13 May 2009 07:01:55 -0400
In-Reply-To: <200905121923.08159.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------080007070906030505040104
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Here's the revised patches, according to the changes you suggested.

Best regards,
João Ramos

-- 
************************************************************************

    João Ramos        <joao.ramos@inov.pt>

    INOV INESC Inovação - ESTG Leiria
    Escola Superior de Tecnologia e Gestão de Leiria
    Edíficio C1, Campus 2
    Morro do Lena, Alto do Vieiro
    Leiria
    2411-901 Leiria
    Portugal

    Tel: +351244843424
    Fax: +351244843424

************************************************************************


--------------080007070906030505040104
Content-Type: text/plain;
 name="ide_drive_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_drive_data.patch"

Change ide_drive_t 'drive_data' field from 'unsigned int' type to 'void *'
type, allowing a wider range of values/types to be stored in this field.
Added 'ide_get_drivedata' and 'ide_set_drivedata' helpers to get and set
the 'drive_data' field.
Fixed all host drivers to maintain coherency with the change in the
'drive_data' field type.

Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>

---

diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index 80b777e..986842e 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -140,10 +140,10 @@ static void cmd64x_tune_pio(ide_drive_t *drive, const u8 pio)
 	if (hwif->channel) {
 		ide_drive_t *pair = ide_get_pair_dev(drive);
 
-		drive->drive_data = setup_count;
+		ide_set_drivedata(drive, (void *)setup_count);
 
 		if (pair)
-			setup_count = max_t(u8, setup_count, pair->drive_data);
+			setup_count = max_t(u8, setup_count, ide_get_drivedata(pair));
 	}
 
 	if (setup_count > 5)		/* shouldn't actually happen... */
diff --git a/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
index 0332a95..d4440bd 100644
--- a/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -146,14 +146,16 @@ static void cs5536_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
 	ide_drive_t *pair = ide_get_pair_dev(drive);
 	int cshift = (drive->dn & 1) ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
 	u32 cast;
 	u8 cmd_pio = pio;
 
 	if (pair)
 		cmd_pio = min(pio, ide_get_best_pio_mode(pair, 255, 4));
 
-	drive->drive_data &= (IDE_DRV_MASK << 8);
-	drive->drive_data |= drv_timings[pio];
+	timings &= (IDE_DRV_MASK << 8);
+	timings |= drv_timings[pio];
+	ide_set_drivedata(drive, (void *)timings);
 
 	cs5536_program_dtc(drive, drv_timings[pio]);
 
@@ -184,6 +186,8 @@ static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
 		0x67, 0x21, 0x20,
 	};
 
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
+
 	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
 	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
 	u32 etc;
@@ -195,8 +199,9 @@ static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
 		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
 	} else { /* MWDMA */
 		etc &= ~(IDE_ETC_UDMA_MASK << dshift);
-		drive->drive_data &= IDE_DRV_MASK;
-		drive->drive_data |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
+		timings &= IDE_DRV_MASK;
+		timings |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
+		ide_set_drivedata(drive, (void *)timings);
 	}
 
 	cs5536_write(pdev, ETC, etc);
@@ -204,9 +209,11 @@ static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
 
 static void cs5536_dma_start(ide_drive_t *drive)
 {
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
+
 	if (drive->current_speed < XFER_UDMA_0 &&
-	    (drive->drive_data >> 8) != (drive->drive_data & IDE_DRV_MASK))
-		cs5536_program_dtc(drive, drive->drive_data >> 8);
+	    (timings >> 8) != (timings & IDE_DRV_MASK))
+		cs5536_program_dtc(drive, timings >> 8);
 
 	ide_dma_start(drive);
 }
@@ -214,10 +221,11 @@ static void cs5536_dma_start(ide_drive_t *drive)
 static int cs5536_dma_end(ide_drive_t *drive)
 {
 	int ret = ide_dma_end(drive);
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
 
 	if (drive->current_speed < XFER_UDMA_0 &&
-	    (drive->drive_data >> 8) != (drive->drive_data & IDE_DRV_MASK))
-		cs5536_program_dtc(drive, drive->drive_data & IDE_DRV_MASK);
+	    (timings >> 8) != (timings & IDE_DRV_MASK))
+		cs5536_program_dtc(drive, timings & IDE_DRV_MASK);
 
 	return ret;
 }
diff --git a/drivers/ide/ht6560b.c b/drivers/ide/ht6560b.c
index 2fb0f29..5d94af3 100644
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
+	return ((unsigned int)ide_get_drivedata(drive) & 0xff00) >> 8;
+}
+
 /*
  * FIFO + PREFETCH (both a/b-model)
  */
@@ -90,7 +95,11 @@
  * Active Time for each drive. Smaller value gives higher speed.
  * In case of failures you should probably fall back to a higher value.
  */
-#define HT_TIMING(drivea) (u8)((drivea)->drive_data & 0x00ff)
+static inline u8 HT_TIMING(ide_drive_t *drive)
+{
+	return (unsigned int)ide_get_drivedata(drive) & 0x00ff;
+}
+
 #define HT_TIMING_DEFAULT 0xff
 
 /*
@@ -244,6 +253,7 @@ static void ht_set_prefetch(ide_drive_t *drive, u8 state)
 {
 	unsigned long flags;
 	int t = HT_PREFETCH_MODE << 8;
+	unsigned int config = (unsigned int)ide_get_drivedata(drive);
 
 	spin_lock_irqsave(&ht6560b_lock, flags);
 
@@ -251,14 +261,16 @@ static void ht_set_prefetch(ide_drive_t *drive, u8 state)
 	 *  Prefetch mode and unmask irq seems to conflict
 	 */
 	if (state) {
-		drive->drive_data |= t;   /* enable prefetch mode */
+		config |= t;   /* enable prefetch mode */
 		drive->dev_flags |= IDE_DFLAG_NO_UNMASK;
 		drive->dev_flags &= ~IDE_DFLAG_UNMASK;
 	} else {
-		drive->drive_data &= ~t;  /* disable prefetch mode */
+		config &= ~t;  /* disable prefetch mode */
 		drive->dev_flags &= ~IDE_DFLAG_NO_UNMASK;
 	}
 
+	ide_set_drivedata(drive, (void *)config);
+
 	spin_unlock_irqrestore(&ht6560b_lock, flags);
 
 #ifdef DEBUG
@@ -270,6 +282,7 @@ static void ht6560b_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	unsigned long flags;
 	u8 timing;
+	unsigned int config = (unsigned int)ide_get_drivedata(drive);
 	
 	switch (pio) {
 	case 8:         /* set prefetch off */
@@ -281,8 +294,9 @@ static void ht6560b_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	timing = ht_pio2timings(drive, pio);
 
 	spin_lock_irqsave(&ht6560b_lock, flags);
-	drive->drive_data &= 0xff00;
-	drive->drive_data |= timing;
+	config &= 0xff00;
+	config |= timing;
+	ide_set_drivedata(drive, (void *)config);
 	spin_unlock_irqrestore(&ht6560b_lock, flags);
 
 #ifdef DEBUG
@@ -299,7 +313,7 @@ static void __init ht6560b_init_dev(ide_drive_t *drive)
 	if (hwif->channel)
 		t |= (HT_SECONDARY_IF << 8);
 
-	drive->drive_data = t;
+	ide_set_drivedata(drive, (void *)t);
 }
 
 static int probe_ht6560b;
diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 4e16ce6..709a5bd 100644
--- a/drivers/ide/icside.c
+++ b/drivers/ide/icside.c
@@ -267,10 +267,11 @@ static void icside_set_dma_mode(ide_drive_t *drive, const u8 xfer_mode)
 	if (use_dma_info && drive->id[ATA_ID_EIDE_DMA_TIME] > cycle_time)
 		cycle_time = drive->id[ATA_ID_EIDE_DMA_TIME];
 
-	drive->drive_data = cycle_time;
+	ide_set_drivedata(drive, (void *)cycle_time);
 
 	printk("%s: %s selected (peak %dMB/s)\n", drive->name,
-		ide_xfer_verbose(xfer_mode), 2000 / drive->drive_data);
+		ide_xfer_verbose(xfer_mode),
+		2000 / (int)ide_get_drivedata(drive));
 }
 
 static const struct ide_port_ops icside_v6_port_ops = {
@@ -332,7 +333,7 @@ static int icside_dma_setup(ide_drive_t *drive, struct ide_cmd *cmd)
 	/*
 	 * Select the correct timing for this drive.
 	 */
-	set_dma_speed(ec->dma, drive->drive_data);
+	set_dma_speed(ec->dma, (int)ide_get_drivedata(drive));
 
 	/*
 	 * Tell the DMA engine about the SG table and
diff --git a/drivers/ide/opti621.c b/drivers/ide/opti621.c
index 6048eda..d94d0f1 100644
--- a/drivers/ide/opti621.c
+++ b/drivers/ide/opti621.c
@@ -139,6 +139,8 @@ static void opti621_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	ide_drive_t *pair = ide_get_pair_dev(drive);
 	unsigned long flags;
 	u8 tim, misc, addr_pio = pio, clk;
+	int mode = XFER_PIO_0 + pio;
+	int pair_mode;
 
 	/* DRDY is default 2 (by OPTi Databook) */
 	static const u8 addr_timings[2][5] = {
@@ -150,11 +152,12 @@ static void opti621_set_pio_mode(ide_drive_t *drive, const u8 pio)
 		{ 0x48, 0x34, 0x21, 0x10, 0x10 }	/* 25 MHz */
 	};
 
-	drive->drive_data = XFER_PIO_0 + pio;
+	ide_set_drivedata(drive, (void *)mode);
 
 	if (pair) {
-		if (pair->drive_data && pair->drive_data < drive->drive_data)
-			addr_pio = pair->drive_data - XFER_PIO_0;
+		pair_mode = (int)ide_get_drivedata(pair);
+		if (pair_mode && pair_mode < mode)
+			addr_pio = pair_mode - XFER_PIO_0;
 	}
 
 	spin_lock_irqsave(&opti621_lock, flags);
diff --git a/drivers/ide/qd65xx.c b/drivers/ide/qd65xx.c
index c9a1349..689d413 100644
--- a/drivers/ide/qd65xx.c
+++ b/drivers/ide/qd65xx.c
@@ -180,8 +180,11 @@ static int qd_find_disk_type (ide_drive_t *drive,
 
 static void qd_set_timing (ide_drive_t *drive, u8 timing)
 {
-	drive->drive_data &= 0xff00;
-	drive->drive_data |= timing;
+	int data = (int)ide_get_drivedata(drive);
+
+	data &= 0xff00;
+	data |= timing;
+	ide_set_drivedata(drive, (void *)data);
 
 	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
 }
@@ -292,7 +295,7 @@ static void __init qd6500_init_dev(ide_drive_t *drive)
 	u8 base = (hwif->config_data & 0xff00) >> 8;
 	u8 config = QD_CONFIG(hwif);
 
-	drive->drive_data = QD6500_DEF_DATA;
+	ide_set_drivedata(drive, (void *)QD6500_DEF_DATA);
 }
 
 static void __init qd6580_init_dev(ide_drive_t *drive)
@@ -308,7 +311,7 @@ static void __init qd6580_init_dev(ide_drive_t *drive)
 	} else
 		t2 = t1 = hwif->channel ? QD6580_DEF_DATA2 : QD6580_DEF_DATA;
 
-	drive->drive_data = (drive->dn & 1) ? t2 : t1;
+	ide_set_drivedata(drive, (void *)((drive->dn & 1) ? t2 : t1));
 }
 
 static const struct ide_tp_ops qd65xx_tp_ops = {
diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
index b0a4606..2d2c016 100644
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -76,6 +76,7 @@ static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	struct pci_dev *dev	= to_pci_dev(drive->hwif->dev);
 	int reg			= 0x44 + drive->dn * 4;
 	u16 drv_ctrl;
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
 
 	drv_ctrl = get_pio_timings(drive, pio);
 
@@ -83,8 +84,9 @@ static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	 * Store the PIO timings so that we can restore them
 	 * in case DMA will be turned off...
 	 */
-	drive->drive_data &= 0xffff0000;
-	drive->drive_data |= drv_ctrl;
+	timings &= 0xffff0000;
+	timings |= drv_ctrl;
+	ide_set_drivedata(drive, (void *)timings);
 
 	pci_write_config_word(dev, reg,  drv_ctrl);
 	pci_read_config_word (dev, reg, &drv_ctrl);
@@ -101,6 +103,7 @@ static void sl82c105_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	static u16 mwdma_timings[] = {0x0707, 0x0201, 0x0200};
 	u16 drv_ctrl;
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
 
  	DBG(("sl82c105_tune_chipset(drive:%s, speed:%s)\n",
 	     drive->name, ide_xfer_verbose(speed)));
@@ -111,8 +114,9 @@ static void sl82c105_set_dma_mode(ide_drive_t *drive, const u8 speed)
 	 * Store the DMA timings so that we can actually program
 	 * them when DMA will be turned on...
 	 */
-	drive->drive_data &= 0x0000ffff;
-	drive->drive_data |= (unsigned long)drv_ctrl << 16;
+	timings &= 0x0000ffff;
+	timings |= (unsigned int)drv_ctrl << 16;
+	ide_set_drivedata(drive, (void *)timings);
 }
 
 /*
@@ -181,10 +185,11 @@ static void sl82c105_dma_start(ide_drive_t *drive)
 	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	int reg 		= 0x44 + drive->dn * 4;
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
 
 	DBG(("%s(drive:%s)\n", __func__, drive->name));
 
-	pci_write_config_word(dev, reg, drive->drive_data >> 16);
+	pci_write_config_word(dev, reg, timings >> 16);
 
 	sl82c105_reset_host(dev);
 	ide_dma_start(drive);
@@ -204,12 +209,13 @@ static int sl82c105_dma_end(ide_drive_t *drive)
 	struct pci_dev *dev	= to_pci_dev(drive->hwif->dev);
 	int reg 		= 0x44 + drive->dn * 4;
 	int ret;
+	unsigned int timings = (unsigned int)ide_get_drivedata(drive);
 
 	DBG(("%s(drive:%s)\n", __func__, drive->name));
 
 	ret = ide_dma_end(drive);
 
-	pci_write_config_word(dev, reg, drive->drive_data);
+	pci_write_config_word(dev, reg, timings);
 
 	return ret;
 }
diff --git a/include/linux/ide.h b/include/linux/ide.h
index ff65fff..9bcd3a5 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -565,7 +565,7 @@ struct ide_drive_s {
 
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
-	unsigned int	drive_data;	/* used by set_pio_mode/dev_select() */
+	void			*drive_data;	/* used by set_pio_mode/dev_select() */
 	unsigned int	failures;	/* current failure count */
 	unsigned int	max_failures;	/* maximum allowed failure count */
 	u64		probed_capacity;/* initial reported media capacity (ide-cd only currently) */
@@ -1570,6 +1570,16 @@ static inline ide_drive_t *ide_get_pair_dev(ide_drive_t *drive)
 	return (peer->dev_flags & IDE_DFLAG_PRESENT) ? peer : NULL;
 }
 
+static inline void *ide_get_drivedata(ide_drive_t *drive)
+{
+	return drive->drive_data;
+}
+
+static inline void ide_set_drivedata(ide_drive_t *drive, void *data)
+{
+	drive->drive_data = data;
+}
+
 #define ide_port_for_each_dev(i, dev, port) \
 	for ((i) = 0; ((dev) = (port)->devices[i]) || (i) < MAX_DRIVES; (i)++)
 

--------------080007070906030505040104
Content-Type: text/plain;
 name="set_pio_mode.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="set_pio_mode.patch"

Initially set PIO Mode 0 for all host drivers that have a 'set_pio_mode'
method before the IDE core figures out the most suited PIO mode for the
attached device.

Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>

---

diff --git a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
index 7f264ed..7d614d8 100644
--- a/drivers/ide/ide-probe.c
+++ b/drivers/ide/ide-probe.c
@@ -1032,6 +1032,15 @@ static void ide_port_init_devices(ide_hwif_t *hwif)
 		if (port_ops && port_ops->init_dev)
 			port_ops->init_dev(drive);
 	}
+
+	ide_port_for_each_dev(i, drive, hwif) {
+		/*
+		 * default to PIO Mode 0 before we  figure out
+		 * the most suited mode for the attached device
+		 */
+		if (port_ops && port_ops->set_pio_mode)
+			port_ops->set_pio_mode(drive, 0);
+	}
 }
 
 static void ide_init_port(ide_hwif_t *hwif, unsigned int port,

--------------080007070906030505040104--
