From: =?ISO-8859-1?Q?Jo=E3o_Ramos?= <joao.ramos@inov.pt>
Subject: Re: EP93xx PIO IDE driver proposal
Date: Mon, 11 May 2009 12:10:18 +0100
Message-ID: <4A08079A.9080803@inov.pt>
References: <49CCD7C4.8000207@inov.pt> <20090508212457.fxyzi9gk3cw4ksw0@webmail.inov.pt> <4A049D99.3050203@ru.mvista.com> <200905090007.10827.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------020800040407020304080106"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from lmv.inov.pt ([146.193.64.2]:48619 "EHLO lmv.inov.pt"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752329AbZEKLLM (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 11 May 2009 07:11:12 -0400
In-Reply-To: <200905090007.10827.bzolnier@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.mvista.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------020800040407020304080106
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit


>>> Same: I will fix that and propose a patch.
>>>       
>>    Hey, don't do this please! This is actually a bad idea as some 
>> drivers (e.g. sl82c105) use drive_data as an integer entity. Bart, stop 
>> giving such advices please. :-)
>>     
>
> I'm not sure what you're getting at with "such advices"... :)
>
> We need to cast somewhere anyway so we may as well cast from 'void *' to
> 'unsigned int' where needed and not the other way around (or rather from
> 'unsigned int' to 'struct ide_timing *') -- which would be an ugly hack
> and could cause maintainability/portability problems later.
>
> BTW it seems like a good occasion to add ide_{get,set}_drivedata() helpers
> (ala existing ide_{get,set}_hwifdata() ones) to <linux/ide.h> and thus make
> internal IDE API more coherent.
>
> [ Yes, I know that we may get away with s/unsigned int/unsigned long/
>   and casting it to 'struct ide_timing *' for now but it always better
>   to at least consider more elegant solution first... ]
>
> Thanks,
> Bart
>
>   

Here is a proposed patch to fix 'drive_data' field to a 'void *' type.
I've also added the 'ide_{get,set}_drivedata' helpers you hinted, and 
I've fixed all the host drivers which used the 'drive_data' field, 
making them use the new 'ide_{get,set}_drivedata' helpers and casting 
them accordingly to both the new 'drive_data' type and the type of value 
being stored.

I've attached the patch to avoid line-wrapping and deformed output.

If you can, please test the patch with the fixed drivers, I can't test 
those since I don't have hardware for it.
However, I will test for compilation.

Please comment, and if there's any fix to be made, just let me know.

Regards,
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


--------------020800040407020304080106
Content-Type: text/plain;
 name="ide_drive_data.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ide_drive_data.patch"

Change ide_drive_t 'drive_data' field from 'unsigned int' type to 'void *' type,
allowing a wider range of values/types to be stored in this field.
Added 'ide_get_drivedata' and 'ide_set_drivedata' helpers to get and set
the 'drive_data' field.
Fixed all host drivers to maintain coherency with the change in the 'drive_data'
field type.

Signed-off-by: Joao Ramos <joao.ramos@inov.pt>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Cc: Sergei Shtylyov <sshtylyov@ru.montavista.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>

---

diff --git a/drivers/ide/cmd64x.c b/drivers/ide/cmd64x.c
index 80b777e..c8df34c 100644
--- a/drivers/ide/cmd64x.c
+++ b/drivers/ide/cmd64x.c
@@ -140,10 +140,11 @@ static void cmd64x_tune_pio(ide_drive_t *drive, const u8 pio)
 	if (hwif->channel) {
 		ide_drive_t *pair = ide_get_pair_dev(drive);
 
-		drive->drive_data = setup_count;
+		ide_set_drivedata(drive, (void *) setup_count);
 
 		if (pair)
-			setup_count = max_t(u8, setup_count, pair->drive_data);
+			setup_count = max_t(u8, setup_count,
+							(u8) ide_get_drivedata(pair));
 	}
 
 	if (setup_count > 5)		/* shouldn't actually happen... */
diff --git a/drivers/ide/cs5536.c b/drivers/ide/cs5536.c
index 0332a95..f9e349e 100644
--- a/drivers/ide/cs5536.c
+++ b/drivers/ide/cs5536.c
@@ -143,6 +143,8 @@ static void cs5536_set_pio_mode(ide_drive_t *drive, const u8 pio)
 		0x99, 0x92, 0x90, 0x22, 0x20,
 	};
 
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
+
 	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
 	ide_drive_t *pair = ide_get_pair_dev(drive);
 	int cshift = (drive->dn & 1) ? IDE_CAST_D1_SHIFT : IDE_CAST_D0_SHIFT;
@@ -152,8 +154,9 @@ static void cs5536_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	if (pair)
 		cmd_pio = min(pio, ide_get_best_pio_mode(pair, 255, 4));
 
-	drive->drive_data &= (IDE_DRV_MASK << 8);
-	drive->drive_data |= drv_timings[pio];
+	drivedata &= (IDE_DRV_MASK << 8);
+	drivedata |= drv_timings[pio];
+	ide_set_drivedata(drive, (void *) drivedata);
 
 	cs5536_program_dtc(drive, drv_timings[pio]);
 
@@ -184,6 +187,8 @@ static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
 		0x67, 0x21, 0x20,
 	};
 
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
+
 	struct pci_dev *pdev = to_pci_dev(drive->hwif->dev);
 	int dshift = (drive->dn & 1) ? IDE_D1_SHIFT : IDE_D0_SHIFT;
 	u32 etc;
@@ -195,8 +200,9 @@ static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
 		etc |= udma_timings[mode - XFER_UDMA_0] << dshift;
 	} else { /* MWDMA */
 		etc &= ~(IDE_ETC_UDMA_MASK << dshift);
-		drive->drive_data &= IDE_DRV_MASK;
-		drive->drive_data |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
+		drivedata &= IDE_DRV_MASK;
+		drivedata |= mwdma_timings[mode - XFER_MW_DMA_0] << 8;
+		ide_set_drivedata(drive, (void *) drivedata);
 	}
 
 	cs5536_write(pdev, ETC, etc);
@@ -204,9 +210,11 @@ static void cs5536_set_dma_mode(ide_drive_t *drive, const u8 mode)
 
 static void cs5536_dma_start(ide_drive_t *drive)
 {
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
+
 	if (drive->current_speed < XFER_UDMA_0 &&
-	    (drive->drive_data >> 8) != (drive->drive_data & IDE_DRV_MASK))
-		cs5536_program_dtc(drive, drive->drive_data >> 8);
+	    (drivedata >> 8) != (drivedata & IDE_DRV_MASK))
+		cs5536_program_dtc(drive, drivedata >> 8);
 
 	ide_dma_start(drive);
 }
@@ -214,10 +222,11 @@ static void cs5536_dma_start(ide_drive_t *drive)
 static int cs5536_dma_end(ide_drive_t *drive)
 {
 	int ret = ide_dma_end(drive);
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
 
 	if (drive->current_speed < XFER_UDMA_0 &&
-	    (drive->drive_data >> 8) != (drive->drive_data & IDE_DRV_MASK))
-		cs5536_program_dtc(drive, drive->drive_data & IDE_DRV_MASK);
+	    (drivedata >> 8) != (drivedata & IDE_DRV_MASK))
+		cs5536_program_dtc(drive, drivedata & IDE_DRV_MASK);
 
 	return ret;
 }
diff --git a/drivers/ide/ht6560b.c b/drivers/ide/ht6560b.c
index 2fb0f29..158aeae 100644
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
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
+	return (drivedata & 0xff00) >> 8;
+}
 /*
  * FIFO + PREFETCH (both a/b-model)
  */
@@ -90,7 +95,12 @@
  * Active Time for each drive. Smaller value gives higher speed.
  * In case of failures you should probably fall back to a higher value.
  */
-#define HT_TIMING(drivea) (u8)((drivea)->drive_data & 0x00ff)
+static inline u8 HT_TIMING(ide_drive_t *drive)
+{
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
+	return drivedata & 0x00ff;
+}
+
 #define HT_TIMING_DEFAULT 0xff
 
 /*
@@ -244,6 +254,7 @@ static void ht_set_prefetch(ide_drive_t *drive, u8 state)
 {
 	unsigned long flags;
 	int t = HT_PREFETCH_MODE << 8;
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
 
 	spin_lock_irqsave(&ht6560b_lock, flags);
 
@@ -251,14 +262,16 @@ static void ht_set_prefetch(ide_drive_t *drive, u8 state)
 	 *  Prefetch mode and unmask irq seems to conflict
 	 */
 	if (state) {
-		drive->drive_data |= t;   /* enable prefetch mode */
+		drivedata |= t;   /* enable prefetch mode */
 		drive->dev_flags |= IDE_DFLAG_NO_UNMASK;
 		drive->dev_flags &= ~IDE_DFLAG_UNMASK;
 	} else {
-		drive->drive_data &= ~t;  /* disable prefetch mode */
+		drivedata &= ~t;  /* disable prefetch mode */
 		drive->dev_flags &= ~IDE_DFLAG_NO_UNMASK;
 	}
 
+	ide_set_drivedata(drive, (void *) drivedata);
+
 	spin_unlock_irqrestore(&ht6560b_lock, flags);
 
 #ifdef DEBUG
@@ -270,6 +283,7 @@ static void ht6560b_set_pio_mode(ide_drive_t *drive, const u8 pio)
 {
 	unsigned long flags;
 	u8 timing;
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
 	
 	switch (pio) {
 	case 8:         /* set prefetch off */
@@ -281,8 +295,9 @@ static void ht6560b_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	timing = ht_pio2timings(drive, pio);
 
 	spin_lock_irqsave(&ht6560b_lock, flags);
-	drive->drive_data &= 0xff00;
-	drive->drive_data |= timing;
+	drivedata &= 0xff00;
+	drivedata |= timing;
+	ide_set_drivedata(drive, (void *) drivedata);
 	spin_unlock_irqrestore(&ht6560b_lock, flags);
 
 #ifdef DEBUG
@@ -299,7 +314,7 @@ static void __init ht6560b_init_dev(ide_drive_t *drive)
 	if (hwif->channel)
 		t |= (HT_SECONDARY_IF << 8);
 
-	drive->drive_data = t;
+	ide_set_drivedata(drive, (void *)t);
 }
 
 static int probe_ht6560b;
diff --git a/drivers/ide/icside.c b/drivers/ide/icside.c
index 4e16ce6..c96f87a 100644
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
+		2000 / (int) ide_get_drivedata(drive));
 }
 
 static const struct ide_port_ops icside_v6_port_ops = {
@@ -332,7 +333,7 @@ static int icside_dma_setup(ide_drive_t *drive, struct ide_cmd *cmd)
 	/*
 	 * Select the correct timing for this drive.
 	 */
-	set_dma_speed(ec->dma, drive->drive_data);
+	set_dma_speed(ec->dma, (int) ide_get_drivedata(drive));
 
 	/*
 	 * Tell the DMA engine about the SG table and
diff --git a/drivers/ide/opti621.c b/drivers/ide/opti621.c
index 6048eda..d545f01 100644
--- a/drivers/ide/opti621.c
+++ b/drivers/ide/opti621.c
@@ -139,6 +139,8 @@ static void opti621_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	ide_drive_t *pair = ide_get_pair_dev(drive);
 	unsigned long flags;
 	u8 tim, misc, addr_pio = pio, clk;
+	int drivedata = XFER_PIO_0 + pio;
+	int pair_drivedata;
 
 	/* DRDY is default 2 (by OPTi Databook) */
 	static const u8 addr_timings[2][5] = {
@@ -150,11 +152,12 @@ static void opti621_set_pio_mode(ide_drive_t *drive, const u8 pio)
 		{ 0x48, 0x34, 0x21, 0x10, 0x10 }	/* 25 MHz */
 	};
 
-	drive->drive_data = XFER_PIO_0 + pio;
+	ide_set_drivedata(drive, (void *) drivedata);
 
 	if (pair) {
-		if (pair->drive_data && pair->drive_data < drive->drive_data)
-			addr_pio = pair->drive_data - XFER_PIO_0;
+		pair_drivedata = (int) ide_get_drivedata(pair);
+		if (pair_drivedata && pair_drivedata < drivedata)
+			addr_pio = pair_drivedata - XFER_PIO_0;
 	}
 
 	spin_lock_irqsave(&opti621_lock, flags);
diff --git a/drivers/ide/qd65xx.c b/drivers/ide/qd65xx.c
index c9a1349..2cd350c 100644
--- a/drivers/ide/qd65xx.c
+++ b/drivers/ide/qd65xx.c
@@ -180,8 +180,11 @@ static int qd_find_disk_type (ide_drive_t *drive,
 
 static void qd_set_timing (ide_drive_t *drive, u8 timing)
 {
-	drive->drive_data &= 0xff00;
-	drive->drive_data |= timing;
+	int drivedata = (int) ide_get_drivedata(drive);
+
+	drivedata &= 0xff00;
+	drivedata |= timing;
+	ide_set_drivedata(drive, (void *)drivedata);
 
 	printk(KERN_DEBUG "%s: %#x\n", drive->name, timing);
 }
@@ -291,8 +294,9 @@ static void __init qd6500_init_dev(ide_drive_t *drive)
 	ide_hwif_t *hwif = drive->hwif;
 	u8 base = (hwif->config_data & 0xff00) >> 8;
 	u8 config = QD_CONFIG(hwif);
+	int drivedata = QD6500_DEF_DATA;
 
-	drive->drive_data = QD6500_DEF_DATA;
+	ide_set_drivedata(drive, (void *) drivedata);
 }
 
 static void __init qd6580_init_dev(ide_drive_t *drive)
@@ -301,6 +305,7 @@ static void __init qd6580_init_dev(ide_drive_t *drive)
 	u16 t1, t2;
 	u8 base = (hwif->config_data & 0xff00) >> 8;
 	u8 config = QD_CONFIG(hwif);
+	int drivedata = (drive->dn & 1) ? t2 : t1;
 
 	if (hwif->host_flags & IDE_HFLAG_SINGLE) {
 		t1 = QD6580_DEF_DATA;
@@ -308,7 +313,7 @@ static void __init qd6580_init_dev(ide_drive_t *drive)
 	} else
 		t2 = t1 = hwif->channel ? QD6580_DEF_DATA2 : QD6580_DEF_DATA;
 
-	drive->drive_data = (drive->dn & 1) ? t2 : t1;
+	ide_set_drivedata(drive, (void *) drivedata);
 }
 
 static const struct ide_tp_ops qd65xx_tp_ops = {
diff --git a/drivers/ide/sl82c105.c b/drivers/ide/sl82c105.c
index b0a4606..5e42eaa 100644
--- a/drivers/ide/sl82c105.c
+++ b/drivers/ide/sl82c105.c
@@ -76,6 +76,7 @@ static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	struct pci_dev *dev	= to_pci_dev(drive->hwif->dev);
 	int reg			= 0x44 + drive->dn * 4;
 	u16 drv_ctrl;
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
 
 	drv_ctrl = get_pio_timings(drive, pio);
 
@@ -83,8 +84,9 @@ static void sl82c105_set_pio_mode(ide_drive_t *drive, const u8 pio)
 	 * Store the PIO timings so that we can restore them
 	 * in case DMA will be turned off...
 	 */
-	drive->drive_data &= 0xffff0000;
-	drive->drive_data |= drv_ctrl;
+	drivedata &= 0xffff0000;
+	drivedata |= drv_ctrl;
+	ide_set_drivedata(drive, (void *) drivedata);
 
 	pci_write_config_word(dev, reg,  drv_ctrl);
 	pci_read_config_word (dev, reg, &drv_ctrl);
@@ -101,6 +103,7 @@ static void sl82c105_set_dma_mode(ide_drive_t *drive, const u8 speed)
 {
 	static u16 mwdma_timings[] = {0x0707, 0x0201, 0x0200};
 	u16 drv_ctrl;
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
 
  	DBG(("sl82c105_tune_chipset(drive:%s, speed:%s)\n",
 	     drive->name, ide_xfer_verbose(speed)));
@@ -111,8 +114,9 @@ static void sl82c105_set_dma_mode(ide_drive_t *drive, const u8 speed)
 	 * Store the DMA timings so that we can actually program
 	 * them when DMA will be turned on...
 	 */
-	drive->drive_data &= 0x0000ffff;
-	drive->drive_data |= (unsigned long)drv_ctrl << 16;
+	drivedata &= 0x0000ffff;
+	drivedata |= (unsigned int)drv_ctrl << 16;
+	ide_set_drivedata(drive, (void *) drivedata);
 }
 
 /*
@@ -181,10 +185,11 @@ static void sl82c105_dma_start(ide_drive_t *drive)
 	ide_hwif_t *hwif	= drive->hwif;
 	struct pci_dev *dev	= to_pci_dev(hwif->dev);
 	int reg 		= 0x44 + drive->dn * 4;
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
 
 	DBG(("%s(drive:%s)\n", __func__, drive->name));
 
-	pci_write_config_word(dev, reg, drive->drive_data >> 16);
+	pci_write_config_word(dev, reg, drivedata >> 16);
 
 	sl82c105_reset_host(dev);
 	ide_dma_start(drive);
@@ -204,12 +209,13 @@ static int sl82c105_dma_end(ide_drive_t *drive)
 	struct pci_dev *dev	= to_pci_dev(drive->hwif->dev);
 	int reg 		= 0x44 + drive->dn * 4;
 	int ret;
+	unsigned int drivedata = (unsigned int) ide_get_drivedata(drive);
 
 	DBG(("%s(drive:%s)\n", __func__, drive->name));
 
 	ret = ide_dma_end(drive);
 
-	pci_write_config_word(dev, reg, drive->drive_data);
+	pci_write_config_word(dev, reg, drivedata);
 
 	return ret;
 }
diff --git a/include/linux/ide.h b/include/linux/ide.h
index ff65fff..4ab9859 100644
--- a/include/linux/ide.h
+++ b/include/linux/ide.h
@@ -565,7 +565,7 @@ struct ide_drive_s {
 
 	unsigned int	bios_cyl;	/* BIOS/fdisk/LILO number of cyls */
 	unsigned int	cyl;		/* "real" number of cyls */
-	unsigned int	drive_data;	/* used by set_pio_mode/dev_select() */
+	void	*drive_data;		/* used by set_pio_mode/dev_select() */
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
 

--------------020800040407020304080106--
