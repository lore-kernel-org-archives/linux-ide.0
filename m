From: Tejun Heo <htejun@gmail.com>
Subject: Re: ICH7m problem using libata
Date: Wed, 03 Jan 2007 12:44:25 +0900
Message-ID: <459B2699.8090506@gmail.com>
References: <1165253799.16504.37.camel@laundromat.jangutter.com> <45888144.9070608@gmail.com> <200701031307.23024.matthew4196@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070406030406060505050001"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.236]:18124 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbXACDom (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 22:44:42 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6291096wxd
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2007 19:44:42 -0800 (PST)
In-Reply-To: <200701031307.23024.matthew4196@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Matthew Stapleton <matthew4196@gmail.com>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------070406030406060505050001
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit

Matthew Stapleton wrote:
> Tejun Heo wrote:
>> Please apply the attached patch over 2.6.19 and report what the kernel says.
>>
>> Thanks.
>>
> 
> I got the following errors during the timeout when running hald:
> 
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.01: cmd a0/00:00:00:00:20/00:00:00:00:00/b0 tag 0 cdb 0x1e data 0 in
>          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
> ata1.01: CDB: 1e:00:00:00:00:00:00:00 00:00:00:00:00:00:00:00 p=6
> 
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.01: (BMDMA stat 0x64)
> ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x25 data 8 in
>          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
> ata1.01: CDB: 25:00:00:00:00:00:00:00 00:00:00:00:00:00:00:00 p=7
> 
> With my test program that opens and closes the cdrom drive every second, I got 
> the following errors during the timeout:
> 
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.01: (BMDMA stat 0x64)
> ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x43 data 12 in
>          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
> ata1.01: CDB: 43:00:00:00:00:00:00:00 0c:40:00:00:00:00:00:00 p=7
> 
> ata1.01: exception Emask 0x0 SAct 0x0 SErr 0x0 action 0x2 frozen
> ata1.01: (BMDMA stat 0x4)
> ata1.01: cmd a0/01:00:00:00:00/00:00:00:00:00/b0 tag 0 cdb 0x25 data 8 in
>          res 40/00:03:00:00:00/00:00:00:00:00/b0 Emask 0x4 (timeout)
> ata1.01: CDB: 25:00:00:00:00:00:00:00 00:00:00:00:00:00:00:00 p=7

Can you try the attached patch over 2.6.19 and report full dmesg?  Thanks.

-- 
tejun

--------------070406030406060505050001
Content-Type: text/x-patch;
 name="cocktail-2.6.19.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cocktail-2.6.19.patch"

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c	2007-01-03 12:33:36.000000000 +0900
+++ work/drivers/ata/libata-core.c	2007-01-03 12:36:28.000000000 +0900
@@ -59,6 +59,10 @@
 
 #include "libata.h"
 
+enum {
+	ATA_MODE_STRING_MAX	= 16,
+};
+
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
 const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
@@ -367,6 +371,7 @@ static int ata_xfer_mode2shift(unsigned 
 /**
  *	ata_mode_string - convert xfer_mask to string
  *	@xfer_mask: mask of bits supported; only highest bit counts.
+ *	@buf: buffer of ATA_MODE_STRING_MAX bytes
  *
  *	Determine string which represents the highest speed
  *	(highest bit in @modemask).
@@ -375,10 +380,10 @@ static int ata_xfer_mode2shift(unsigned 
  *	None.
  *
  *	RETURNS:
- *	Constant C string representing highest speed listed in
- *	@mode_mask, or the constant C string "<n/a>".
+ *	Pointer to @buf which contains C string representing highest
+ *	DMA and PIO speeds listed in @mode_mask.
  */
-static const char *ata_mode_string(unsigned int xfer_mask)
+static const char *ata_mode_string(unsigned int xfer_mask, char *buf)
 {
 	static const char * const xfer_mode_str[] = {
 		"PIO0",
@@ -403,11 +408,24 @@ static const char *ata_mode_string(unsig
 		"UDMA7",
 	};
 	int highbit;
+	const char *str, *pio_str;
+
+	str = pio_str = "<n/a>";
 
 	highbit = fls(xfer_mask) - 1;
 	if (highbit >= 0 && highbit < ARRAY_SIZE(xfer_mode_str))
-		return xfer_mode_str[highbit];
-	return "<n/a>";
+		str = xfer_mode_str[highbit];
+
+	highbit = fls(xfer_mask & ATA_MASK_PIO) - 1;
+	if (highbit >= 0 && highbit < ARRAY_SIZE(xfer_mode_str))
+		pio_str = xfer_mode_str[highbit];
+
+	if (str != pio_str)
+		snprintf(buf, ATA_MODE_STRING_MAX, "%s:%s", str, pio_str);
+	else
+		snprintf(buf, ATA_MODE_STRING_MAX, "%s", str);
+
+	return buf;
 }
 
 static const char *sata_spd_string(unsigned int spd)
@@ -1389,7 +1407,7 @@ int ata_dev_configure(struct ata_device 
 {
 	struct ata_port *ap = dev->ap;
 	const u16 *id = dev->id;
-	unsigned int xfer_mask;
+	char xfer_buf[ATA_MODE_STRING_MAX];
 	char revbuf[7];		/* XYZ-99\0 */
 	int rc;
 
@@ -1427,7 +1445,7 @@ int ata_dev_configure(struct ata_device 
 	 */
 
 	/* find max transfer mode; for printk only */
-	xfer_mask = ata_id_xfermask(id);
+	ata_mode_string(ata_id_xfermask(id), xfer_buf);
 
 	if (ata_msg_probe(ap))
 		ata_dump_id(id);
@@ -1463,8 +1481,7 @@ int ata_dev_configure(struct ata_device 
 			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "%s, "
 					"max %s, %Lu sectors: %s %s\n",
-					revbuf,
-					ata_mode_string(xfer_mask),
+					revbuf, xfer_buf,
 					(unsigned long long)dev->n_sectors,
 					lba_desc, ncq_desc);
 		} else {
@@ -1486,8 +1503,7 @@ int ata_dev_configure(struct ata_device 
 			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "%s, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
-					revbuf,
-					ata_mode_string(xfer_mask),
+					revbuf, xfer_buf,
 					(unsigned long long)dev->n_sectors,
 					dev->cylinders, dev->heads,
 					dev->sectors);
@@ -1526,8 +1542,7 @@ int ata_dev_configure(struct ata_device 
 		/* print device info to dmesg */
 		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
-				       ata_mode_string(xfer_mask),
-				       cdb_intr_string);
+				       xfer_buf, cdb_intr_string);
 	}
 
 	if (dev->horkage & ATA_HORKAGE_DIAGNOSTIC) {
@@ -2121,6 +2136,7 @@ int ata_timing_compute(struct ata_device
 int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0)
 {
 	unsigned long xfer_mask;
+	char xfer_buf[ATA_MODE_STRING_MAX];
 	int highbit;
 
 	xfer_mask = ata_pack_xfermask(dev->pio_mask, dev->mwdma_mask,
@@ -2143,7 +2159,7 @@ int ata_down_xfermask_limit(struct ata_d
 			    &dev->udma_mask);
 
 	ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
-		       ata_mode_string(xfer_mask));
+		       ata_mode_string(xfer_mask, xfer_buf));
 
 	return 0;
 
@@ -2154,6 +2170,7 @@ int ata_down_xfermask_limit(struct ata_d
 static int ata_dev_set_mode(struct ata_device *dev)
 {
 	unsigned int err_mask;
+	char xfer_buf[ATA_MODE_STRING_MAX];
 	int rc;
 
 	dev->flags &= ~ATA_DFLAG_PIO;
@@ -2174,8 +2191,10 @@ static int ata_dev_set_mode(struct ata_d
 	DPRINTK("xfer_shift=%u, xfer_mode=0x%x\n",
 		dev->xfer_shift, (int)dev->xfer_mode);
 
-	ata_dev_printk(dev, KERN_INFO, "configured for %s\n",
-		       ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode)));
+	ata_mode_string(ata_xfer_mode2mask(dev->xfer_mode) |
+			ata_xfer_mode2mask(dev->pio_mode), xfer_buf);
+	ata_dev_printk(dev, KERN_INFO, "configured for %s\n", xfer_buf);
+
 	return 0;
 }
 
@@ -2227,6 +2246,9 @@ int ata_set_mode(struct ata_port *ap, st
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
+		/* XXX - debug */
+		if (dev->pio_mode)
+			dev->pio_mode = XFER_PIO_0;
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 
 		found = 1;
@@ -3109,6 +3131,7 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_port *ap = dev->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
+	int i;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -3120,10 +3143,27 @@ static void ata_dev_xfermask(struct ata_
 	if (ap->cbl == ATA_CBL_PATA40)
 		xfer_mask &= ~(0xF8 << ATA_SHIFT_UDMA);
 
+	/* apply xfermask limits of this device */
 	xfer_mask &= ata_pack_xfermask(dev->pio_mask,
 				       dev->mwdma_mask, dev->udma_mask);
 	xfer_mask &= ata_id_xfermask(dev->id);
 
+	/* PIO xfermask limits are shared by all devices on the same
+	 * channel to avoid violating device selection timing.
+	 */
+	for (i = 0; i < ATA_MAX_DEVICES; i++) {
+		struct ata_device *d = &ap->device[i];
+		unsigned int pio_mask;
+
+		if (ata_dev_absent(d))
+			continue;
+
+		ata_unpack_xfermask(ata_id_xfermask(d->id),
+				    &pio_mask, NULL, NULL);
+		pio_mask &= d->pio_mask;
+		xfer_mask &= ata_pack_xfermask(pio_mask, UINT_MAX, UINT_MAX);
+	}
+
 	/*
 	 *	CFA Advanced TrueIDE timings are not allowed on a shared
 	 *	cable
@@ -5479,7 +5519,7 @@ int ata_device_add(const struct ata_prob
 	/* register each port bound to this device */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap;
-		unsigned long xfer_mode_mask;
+		char xfer_buf[ATA_MODE_STRING_MAX];
 		int irq_line = ent->irq;
 
 		ap = ata_port_add(ent, host, i);
@@ -5506,18 +5546,16 @@ int ata_device_add(const struct ata_prob
 		if (i == 1 && ent->irq2)
 			irq_line = ent->irq2;
 
-		xfer_mode_mask =(ap->udma_mask << ATA_SHIFT_UDMA) |
-				(ap->mwdma_mask << ATA_SHIFT_MWDMA) |
-				(ap->pio_mask << ATA_SHIFT_PIO);
+		ata_mode_string(ap->udma_mask << ATA_SHIFT_UDMA |
+				ap->mwdma_mask << ATA_SHIFT_MWDMA |
+				ap->pio_mask << ATA_SHIFT_PIO, xfer_buf);
 
 		/* print per-port info to dmesg */
 		ata_port_printk(ap, KERN_INFO, "%cATA max %s cmd 0x%lX "
 				"ctl 0x%lX bmdma 0x%lX irq %d\n",
 				ap->flags & ATA_FLAG_SATA ? 'S' : 'P',
-				ata_mode_string(xfer_mode_mask),
-				ap->ioaddr.cmd_addr,
-				ap->ioaddr.ctl_addr,
-				ap->ioaddr.bmdma_addr,
+				xfer_buf, ap->ioaddr.cmd_addr,
+				ap->ioaddr.ctl_addr, ap->ioaddr.bmdma_addr,
 				irq_line);
 
 		ata_chk_status(ap);
Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c	2007-01-03 12:33:36.000000000 +0900
+++ work/drivers/ata/libata-sff.c	2007-01-03 12:36:19.000000000 +0900
@@ -662,6 +662,7 @@ void ata_bmdma_stop(struct ata_queued_cm
  */
 void ata_bmdma_freeze(struct ata_port *ap)
 {
+#if 0
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	ap->ctl |= ATA_NIEN;
@@ -671,6 +672,7 @@ void ata_bmdma_freeze(struct ata_port *a
 		writeb(ap->ctl, (void __iomem *)ioaddr->ctl_addr);
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
+#endif
 }
 
 /**

--------------070406030406060505050001--
