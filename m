From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: piix dma setup code
Date: Thu, 20 May 2004 02:10:43 +0200
Sender: linux-ide-owner@vger.kernel.org
Message-ID: <200405200210.43329.bzolnier@elka.pw.edu.pl>
References: <40A9F150.4070209@turbolinux.co.jp> <200405200059.19575.bzolnier@elka.pw.edu.pl> <40ABEB77.4090109@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:61120 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264711AbUETAJg
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 19 May 2004 20:09:36 -0400
In-Reply-To: <40ABEB77.4090109@pobox.com>
Content-Disposition: inline
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Go Taniguchi <go@turbolinux.co.jp>, linux-ide@vger.kernel.org, "Nakajima, Jun" <jun.nakajima@intel.com>

On Thursday 20 of May 2004 01:19, Jeff Garzik wrote:
> Bartlomiej Zolnierkiewicz wrote:
> > On Thursday 20 of May 2004 00:31, Jeff Garzik wrote:
> >>(added Jun to CC)
> >>
> >>Bartlomiej Zolnierkiewicz wrote:
> >>>On Tuesday 18 of May 2004 13:19, Go Taniguchi wrote:
> >>>>If speed is XFER_UDMA_6, base clock is set to low base clock.
> >>>>It should be "speed >= XFER_UDMA_5". My ICH6 system reported
> >>>> XFER_UDMA_6,
> >>>
> >>>Jeff, does ICH6 support UDMA6?
> >>>ICH5 doesn't but ata_piix.c allows it.
> >>
> >>Good question.  AFAICS ICH5 and ICH6 are the same such that:
> >>* PATA does not support UDMA6
> >>* internal base clock is 133Mhz for UDMA5
> >
> > strange, it is 100MHz according to the datasheet
>
> Grab the latest ICH5 docs from developer.intel.com, they say the same
> thing as the ICH6 docs.  Section 5.16.6, "Ultra ATA/33/66/100 Timing":

Thanks.

> > The internal Base Clock for Ultra ATA/100 (Mode 5) runs at 133 MHz, and
> > the Cycle Time (CT) must be set for three Base Clocks. The ICH5 thus
> > toggles the write strobe signal every 22.5 ns, transferring two bytes of
> >
> >>* SATA PCI device exports, but completely ignores, PATA timing registers
> >>
> >>So for ata_piix at least, I would prefer to do
> >>* patch1: your patch, based on Go's patch
> >>* patch2: only configure timing registers for PATA port (PATA is only
> >>used when an #ifdef is defined)
> >>* patch3: do not limit SATA to udma5
> >
> > OK
> >
> > this reminds me that long time ago I spotted small bug in configuring
> > PATA timing registers in ata_piix.c but was too lazy to send a patch
> > because code is #ifdef-ed and bug was (is?) only for slave device 8)
>
> Patches welcome :)  Slave device is a possibility on ICH6, which maps 4
> SATA ports onto IDE primary/secondary master/slave, when not in evil
> combined mode.
>
> If you are motivated, I need to re-copy the drivers/ide/pci/piix.c
> tune_chipset function to ata_piix.c, because I need to add MWDMA support
> back to that function.

no ->set_mwdmamode()?  That is how I added MWDMA to libata.

The only change visible to existing drivers is that ata_host_set_udma()
no longer limits UDMA mode to the one of the slowest device (master & slave).

Dunno if it works now (it worked in 2.6.1).

 linux-2.6.6-bk3-bzolnier/drivers/scsi/libata-core.c |  233 ++++++++++++++------
 linux-2.6.6-bk3-bzolnier/include/linux/ata.h        |    4 
 linux-2.6.6-bk3-bzolnier/include/linux/libata.h     |    8 
 3 files changed, 181 insertions(+), 64 deletions(-)

diff -puN drivers/scsi/libata-core.c~pata_mwdma drivers/scsi/libata-core.c
--- linux-2.6.6-bk3/drivers/scsi/libata-core.c~pata_mwdma	2004-05-20 01:43:09.001800544 +0200
+++ linux-2.6.6-bk3-bzolnier/drivers/scsi/libata-core.c	2004-05-20 01:58:14.602128368 +0200
@@ -52,9 +52,10 @@ static unsigned int ata_busy_sleep (stru
 static void __ata_dev_select (struct ata_port *ap, unsigned int device);
 static void ata_dma_complete(struct ata_queued_cmd *qc, u8 host_stat);
 static void ata_host_set_pio(struct ata_port *ap);
-static void ata_host_set_udma(struct ata_port *ap);
+static int ata_host_set_udma(struct ata_port *ap);
+static int ata_host_set_mwdma(struct ata_port *ap);
 static void ata_dev_set_pio(struct ata_port *ap, unsigned int device);
-static void ata_dev_set_udma(struct ata_port *ap, unsigned int device);
+static void ata_dev_set_dma(struct ata_port *ap, unsigned int device);
 static void ata_set_mode(struct ata_port *ap);
 static int ata_qc_issue_prot(struct ata_queued_cmd *qc);
 
@@ -573,6 +574,12 @@ static void ata_dev_set_protocol(struct 
 	dev->write_cmd = (cmd >> 8) & 0xff;
 }
 
+static const char * mwdma_str[] = {
+	"MWDMA0",
+	"MWDMA1",
+	"MWDMA2",
+};
+
 static const char * udma_str[] = {
 	"UDMA/16",
 	"UDMA/25",
@@ -585,32 +592,66 @@ static const char * udma_str[] = {
 };
 
 /**
- *	ata_udma_string - convert UDMA bit offset to string
- *	@udma_mask: mask of bits supported; only highest bit counts.
+ *	ata_mode_string - convert mode bit offset to string
+ *	@mode_mask: mask of bits supported; only highest bit counts.
+ *	@max_mode: no. of bit to start checking from (counted from zero)
+ *	@mode_str: pointer to array of strings representing speeds
  *
  *	Determine string which represents the highest speed
- *	(highest bit in @udma_mask).
+ *	(highest bit in @mode_mask).
  *
  *	LOCKING:
  *	None.
  *
  *	RETURNS:
  *	Constant C string representing highest speed listed in
- *	@udma_mask, or the constant C string "<n/a>".
+ *	@mode_mask, or the constant C string "<n/a>".
  */
 
-static const char *ata_udma_string(unsigned int udma_mask)
+static const char *ata_mode_string(unsigned int mode_mask,
+				   const unsigned int max_mode,
+				   const char *mode_str[])
 {
 	int i;
 
-	for (i = 7; i >= 0; i--) {
-		if (udma_mask & (1 << i))
-			return udma_str[i];
+	for (i = max_mode; i >= 0; i--) {
+		if (mode_mask & (1 << i))
+			return mode_str[i];
 	}
 
 	return "<n/a>";
 }
 
+static const char *ata_host_dma_string(struct ata_port *ap)
+{
+	u16 modes;
+
+	modes = ap->udma_mask;
+	if (modes & 0xff)
+		return ata_mode_string(modes, 7, udma_str);
+
+	modes = ap->mwdma_mask;
+	if (modes & 0xff)
+		return ata_mode_string(modes, 2, mwdma_str);
+
+	return "<n/a>";
+}
+
+static const char *ata_dev_dma_string(struct ata_device *dev)
+{
+	u16 modes;
+
+	modes = dev->id[ATA_ID_UDMA_MODES];
+	if (modes & 0xff)
+		return ata_mode_string(modes, 7, udma_str);
+
+	modes = dev->id[ATA_ID_MWDMA_MODES];
+	if (modes & 0xff)
+		return ata_mode_string(modes, 2, mwdma_str);
+
+	return "<n/a>";
+}
+
 /**
  *	ata_pio_devchk - PATA device presence detection
  *	@ap: ATA channel to examine
@@ -976,6 +1017,15 @@ static inline void ata_dump_id(struct at
 		dev->id[93]);
 }
 
+static int ata_dev_check_dma(struct ata_device *dev)
+{
+	if ((dev->id[ATA_ID_UDMA_MODES] & 0xff) ||
+	    (dev->id[ATA_ID_MWDMA_MODES] & 0xff))
+		return 1;
+
+	return 0;
+}
+
 /**
  *	ata_dev_identify - obtain IDENTIFY x DEVICE page
  *	@ap: port on which device we wish to probe resides
@@ -1002,7 +1052,7 @@ static void ata_dev_identify(struct ata_
 {
 	struct ata_device *dev = &ap->device[device];
 	unsigned int i;
-	u16 tmp, udma_modes;
+	u16 tmp;
 	u8 status;
 	struct ata_taskfile tf;
 	unsigned int using_edd;
@@ -1117,11 +1167,9 @@ retry:
 		goto err_out_nosup;
 	}
 
-	/* we require UDMA support */
-	udma_modes =
-	tmp = dev->id[ATA_ID_UDMA_MODES];
-	if ((tmp & 0xff) == 0) {
-		printk(KERN_DEBUG "ata%u: no udma\n", ap->id);
+	/* we require UDMA or MWDMA support */
+	if (!ata_dev_check_dma(dev)) {
+		printk(KERN_DEBUG "ata%u: no udma or mwdma\n", ap->id);
 		goto err_out_nosup;
 	}
 
@@ -1157,7 +1205,7 @@ retry:
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes),
+		       ata_dev_dma_string(dev),
 		       (unsigned long long)dev->n_sectors,
 		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");
 	}
@@ -1175,7 +1223,7 @@ retry:
 		/* print device info to dmesg */
 		printk(KERN_INFO "ata%u: dev %u ATAPI, max %s\n",
 		       ap->id, device,
-		       ata_udma_string(udma_modes));
+		       ata_dev_dma_string(dev));
 	}
 
 	DPRINTK("EXIT, drv_stat = 0x%x\n", ata_chk_status(ap));
@@ -1320,7 +1368,15 @@ static void ata_set_mode(struct ata_port
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
 
-	ata_host_set_udma(ap);
+	if (ata_host_set_udma(ap)) {
+		printk(KERN_WARNING "ata%u: no UDMA support, trying MWDMA\n",
+				    ap->id);
+		if (ata_host_set_mwdma(ap)) {
+			printk(KERN_WARNING "ata%u: no MWDMA support, ignoring\n",
+					     ap->id);
+			ap->ops->port_disable(ap);
+		}
+	}
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
 		return;
 
@@ -1334,8 +1390,8 @@ static void ata_set_mode(struct ata_port
 		ata_dev_set_pio(ap, 0);
 		ata_dev_set_pio(ap, 1);
 	} else {
-		ata_dev_set_udma(ap, 0);
-		ata_dev_set_udma(ap, 1);
+		ata_dev_set_dma(ap, 0);
+		ata_dev_set_dma(ap, 1);
 	}
 
 	if (ap->flags & ATA_FLAG_PORT_DISABLED)
@@ -1656,17 +1712,69 @@ err_out:
 }
 
 /**
+ *	ata_host_set_mwdma -
+ *	@ap:
+ *
+ *	LOCKING:
+ */
+
+static int ata_host_set_mwdma(struct ata_port *ap)
+{
+	struct ata_device *master, *slave;
+	int mask;
+	unsigned int i;
+	int mwdma_mode = -1;
+
+	master = &ap->device[0];
+	slave = &ap->device[1];
+
+	assert(ata_dev_present(master) || ata_dev_present(slave));
+	assert((ap->flags & ATA_FLAG_PORT_DISABLED) == 0);
+
+	DPRINTK("mwdma masks: host 0x%X, master 0x%X, slave 0x%X\n",
+		ap->mwdma_mask,
+		(!ata_dev_present(master)) ? 0xff :
+			(master->id[ATA_ID_MWDMA_MODES] & 0xff),
+		(!ata_dev_present(slave)) ? 0xff :
+			(slave->id[ATA_ID_MWDMA_MODES] & 0xff));
+
+	/* require mwdma for host */
+	if (!ap->mwdma_mask)
+		return 1;
+
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
+
+		if (ata_dev_present(dev)) {
+			mask = ap->mwdma_mask;
+			mask &= (dev->id[ATA_ID_MWDMA_MODES] & 0xff);
+			mwdma_mode = XFER_MW_DMA_0 + fls(mask) - 1;
+			DPRINTK("mask 0x%X fls(mask)-1 %u mwdma_mode 0x%X\n",
+				mask, fls(mask) - 1, mwdma_mode);
+			if (!mask)
+				continue;
+			dev->dma_mode = mwdma_mode;
+			dev->flags |= ATA_DFLAG_MWDMA;
+			if (ap->ops->set_mwdmamode)
+				ap->ops->set_mwdmamode(ap, dev, mwdma_mode);
+		}
+	}
+
+	return 0;
+}
+
+/**
  *	ata_host_set_udma -
  *	@ap:
  *
  *	LOCKING:
  */
 
-static void ata_host_set_udma(struct ata_port *ap)
+static int ata_host_set_udma(struct ata_port *ap)
 {
 	struct ata_device *master, *slave;
-	u16 mask;
-	unsigned int i, j;
+	int mask;
+	unsigned int i;
 	int udma_mode = -1;
 
 	master = &ap->device[0];
@@ -1682,43 +1790,28 @@ static void ata_host_set_udma(struct ata
 		(!ata_dev_present(slave)) ? 0xff :
 			(slave->id[ATA_ID_UDMA_MODES] & 0xff));
 
-	mask = ap->udma_mask;
-	if (ata_dev_present(master))
-		mask &= (master->id[ATA_ID_UDMA_MODES] & 0xff);
-	if (ata_dev_present(slave))
-		mask &= (slave->id[ATA_ID_UDMA_MODES] & 0xff);
-
-	i = XFER_UDMA_7;
-	while (i >= XFER_UDMA_0) {
-		j = i - XFER_UDMA_0;
-		DPRINTK("mask 0x%X i 0x%X j %u\n", mask, i, j);
-		if (mask & (1 << j)) {
-			udma_mode = i;
-			break;
-		}
-
-		i--;
-	}
+	/* require udma for host */
+	if (ap->udma_mask < 0)
+		return 1;
 
-	/* require udma for host and all attached devices */
-	if (udma_mode < 0) {
-		printk(KERN_WARNING "ata%u: no UltraDMA support, ignoring\n",
-		       ap->id);
-		goto err_out;
-	}
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *dev = &ap->device[i];
 
-	for (i = 0; i < ATA_MAX_DEVICES; i++)
-		if (ata_dev_present(&ap->device[i])) {
-			ap->device[i].udma_mode = udma_mode;
+		if (ata_dev_present(dev)) {
+			mask = ap->udma_mask;
+			mask &= (dev->id[ATA_ID_UDMA_MODES] & 0xff);
+			udma_mode = XFER_UDMA_0 + fls(mask) - 1;
+			DPRINTK("mask 0x%X fls(mask)-1 %u udma_mode 0x%X\n",
+				mask, fls(mask) - 1, umda_mode);
+ 			if (!mask)
+				continue;
+			dev->dma_mode = udma_mode;
 			if (ap->ops->set_udmamode)
-				ap->ops->set_udmamode(ap, &ap->device[i],
-						      udma_mode);
+				ap->ops->set_udmamode(ap, dev, udma_mode);
 		}
+	}
 
-	return;
-
-err_out:
-	ap->ops->port_disable(ap);
+	return 0;
 }
 
 /**
@@ -1744,7 +1837,7 @@ static void ata_dev_set_xfermode(struct 
 	if (dev->flags & ATA_DFLAG_PIO)
 		tf.nsect = dev->pio_mode;
 	else
-		tf.nsect = dev->udma_mode;
+		tf.nsect = dev->dma_mode;
 
 	/* do bus reset */
 	ata_tf_to_host(ap, &tf);
@@ -1763,14 +1856,14 @@ static void ata_dev_set_xfermode(struct 
 }
 
 /**
- *	ata_dev_set_udma -
+ *	ata_dev_set_dma -
  *	@ap:
  *	@device:
  *
  *	LOCKING:
  */
 
-static void ata_dev_set_udma(struct ata_port *ap, unsigned int device)
+static void ata_dev_set_dma(struct ata_port *ap, unsigned int device)
 {
 	struct ata_device *dev = &ap->device[device];
 
@@ -1779,11 +1872,22 @@ static void ata_dev_set_udma(struct ata_
 
 	ata_dev_set_xfermode(ap, dev);
 
-	assert((dev->udma_mode >= XFER_UDMA_0) &&
-	       (dev->udma_mode <= XFER_UDMA_7));
+	if (dev->flags & ATA_DFLAG_MWDMA)
+		goto mwdma_mode;
+
+	assert((dev->dma_mode >= XFER_UDMA_0) &&
+	       (dev->dma_mode <= XFER_UDMA_7));
+	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
+	       ap->id, device,
+	       udma_str[dev->dma_mode - XFER_UDMA_0]);
+	return;
+
+mwdma_mode:
+	assert((dev->dma_mode >= XFER_MW_DMA_0) &&
+	       (dev->dma_mode <= XFER_MW_DMA_2));
 	printk(KERN_INFO "ata%u: dev %u configured for %s\n",
 	       ap->id, device,
-	       udma_str[dev->udma_mode - XFER_UDMA_0]);
+	       mwdma_str[dev->dma_mode - XFER_MW_DMA_0]);
 }
 
 /**
@@ -2936,6 +3040,7 @@ static void ata_host_init(struct ata_por
 	ap->host_set = host_set;
 	ap->port_no = port_no;
 	ap->pio_mask = ent->pio_mask;
+	ap->mwdma_mask = ent->mwdma_mask;
 	ap->udma_mask = ent->udma_mask;
 	ap->flags |= ent->host_flags;
 	ap->ops = ent->port_ops;
@@ -3048,7 +3153,7 @@ int ata_device_add(struct ata_probe_ent 
 				 "bmdma 0x%lX irq %lu\n",
 			ap->id,
 			ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-			ata_udma_string(ent->udma_mask),
+			ata_host_dma_string(ap),
 	       		ap->ioaddr.cmd_addr,
 	       		ap->ioaddr.ctl_addr,
 	       		ap->ioaddr.bmdma_addr,
@@ -3280,6 +3385,7 @@ int ata_pci_init_one (struct pci_dev *pd
 	probe_ent->sht = port0->sht;
 	probe_ent->host_flags = port0->host_flags;
 	probe_ent->pio_mask = port0->pio_mask;
+	probe_ent->mwdma_mask = port0->mwdma_mask;
 	probe_ent->udma_mask = port0->udma_mask;
 	probe_ent->port_ops = port0->port_ops;
 
@@ -3302,6 +3408,7 @@ int ata_pci_init_one (struct pci_dev *pd
 		probe_ent2->sht = port1->sht;
 		probe_ent2->host_flags = port1->host_flags;
 		probe_ent2->pio_mask = port1->pio_mask;
+		probe_ent2->mwdma_mask = port1->mwdma_mask;
 		probe_ent2->udma_mask = port1->udma_mask;
 		probe_ent2->port_ops = port1->port_ops;
 	} else {
diff -puN include/linux/ata.h~pata_mwdma include/linux/ata.h
--- linux-2.6.6-bk3/include/linux/ata.h~pata_mwdma	2004-05-20 01:43:09.008799480 +0200
+++ linux-2.6.6-bk3-bzolnier/include/linux/ata.h	2004-05-20 01:43:09.019797808 +0200
@@ -41,6 +41,7 @@ enum {
 	ATA_ID_SERNO_OFS	= 10,
 	ATA_ID_MAJOR_VER	= 80,
 	ATA_ID_PIO_MODES	= 64,
+	ATA_ID_MWDMA_MODES	= 63,
 	ATA_ID_UDMA_MODES	= 88,
 	ATA_ID_PIO4		= (1 << 1),
 
@@ -129,6 +130,9 @@ enum {
 	XFER_UDMA_2		= 0x42,
 	XFER_UDMA_1		= 0x41,
 	XFER_UDMA_0		= 0x40,
+	XFER_MW_DMA_2		= 0x22,
+	XFER_MW_DMA_1		= 0x21,
+	XFER_MW_DMA_0		= 0x20,
 	XFER_PIO_4		= 0x0C,
 	XFER_PIO_3		= 0x0B,
 
diff -puN include/linux/libata.h~pata_mwdma include/linux/libata.h
--- linux-2.6.6-bk3/include/linux/libata.h~pata_mwdma	2004-05-20 01:43:09.012798872 +0200
+++ linux-2.6.6-bk3-bzolnier/include/linux/libata.h	2004-05-20 01:43:09.020797656 +0200
@@ -90,6 +90,7 @@ enum {
 	ATA_DFLAG_MASTER	= (1 << 2), /* is device 0? */
 	ATA_DFLAG_WCACHE	= (1 << 3), /* has write cache we can
 					     * (hopefully) flush? */
+	ATA_DFLAG_MWDMA		= (1 << 4), /* use MWDMA instead of UDMA */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -199,6 +200,7 @@ struct ata_probe_ent {
 	struct ata_ioports	port[ATA_MAX_PORTS];
 	unsigned int		n_ports;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		legacy_mode;
 	unsigned long		irq;
@@ -257,7 +259,7 @@ struct ata_device {
 	unsigned int		devno;		/* 0 or 1 */
 	u16			id[ATA_ID_WORDS]; /* IDENTIFY xxx DEVICE data */
 	unsigned int		pio_mode;
-	unsigned int		udma_mode;
+	unsigned int		dma_mode;
 
 	unsigned char		vendor[8];	/* space-padded, not ASCIIZ */
 	unsigned char		product[32];	/* WARNING: shorter than
@@ -288,6 +290,7 @@ struct ata_port {
 	unsigned int		bus_state;
 	unsigned int		port_state;
 	unsigned int		pio_mask;
+	unsigned int		mwdma_mask;
 	unsigned int		udma_mask;
 	unsigned int		cbl;	/* cable type; ATA_CBL_xxx */
 
@@ -322,6 +325,8 @@ struct ata_port_operations {
 
 	void (*set_piomode) (struct ata_port *, struct ata_device *,
 			     unsigned int);
+	void (*set_mwdmamode) (struct ata_port *, struct ata_device *,
+			       unsigned int);
 	void (*set_udmamode) (struct ata_port *, struct ata_device *,
 			     unsigned int);
 
@@ -355,6 +360,7 @@ struct ata_port_info {
 	Scsi_Host_Template	*sht;
 	unsigned long		host_flags;
 	unsigned long		pio_mask;
+	unsigned long		mwdma_mask;
 	unsigned long		udma_mask;
 	struct ata_port_operations	*port_ops;
 };

_

