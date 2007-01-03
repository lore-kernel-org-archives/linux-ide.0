From: Tejun Heo <htejun@gmail.com>
Subject: Re: CDROM drive not found when booting using new libata code
Date: Wed, 03 Jan 2007 12:31:39 +0900
Message-ID: <459B239B.90204@gmail.com>
References: <20060924221020.GB2080@artsapartment.org> <4562C65C.2010802@gmail.com> <20061206181652.GA3107@artsapartment.org> <45779852.1030909@gmail.com> <20061207105525.4ebb4547@localhost.localdomain> <45780AF5.2020605@gmail.com> <20061208010626.GA1856@artsapartment.org> <45927532.3060404@gmail.com> <45933F2A.5070304@gmail.com> <20070102210708.GI24909@artsapartment.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040604090606050300000800"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from wx-out-0506.google.com ([66.249.82.238]:13085 "EHLO
	wx-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753846AbXACDbw (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 22:31:52 -0500
Received: by wx-out-0506.google.com with SMTP id h27so6288098wxd
        for <linux-ide@vger.kernel.org>; Tue, 02 Jan 2007 19:31:51 -0800 (PST)
In-Reply-To: <20070102210708.GI24909@artsapartment.org>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Art Haas <ahaas@airmail.net>
Cc: linux-ide@vger.kernel.org

This is a multi-part message in MIME format.
--------------040604090606050300000800
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Art Haas wrote:
> Hi.
> 
> I wanted to try the two patches you've sent against the current
> 2.6.20-rc3, but there have been numerous changes to the files
> so neither patch can apply cleanly. I'm not familiar enough
> with the libata to try and make similar changes to the current
> files to match your patch. :-(
> 
> Any possiblity of generating patches against the 2.6.20-rc3 tree?

Yeap, please try the attached patch.  Thanks.

-- 
tejun

--------------040604090606050300000800
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

Index: work/drivers/ata/libata-core.c
===================================================================
--- work.orig/drivers/ata/libata-core.c	2007-01-03 12:30:18.000000000 +0900
+++ work/drivers/ata/libata-core.c	2007-01-03 12:30:19.000000000 +0900
@@ -59,6 +59,10 @@
 
 #include "libata.h"
 
+enum {
+	ATA_MODE_STRING_MAX	= 16,
+};
+
 /* debounce timing parameters in msecs { interval, duration, timeout } */
 const unsigned long sata_deb_timing_normal[]		= {   5,  100, 2000 };
 const unsigned long sata_deb_timing_hotplug[]		= {  25,  500, 2000 };
@@ -534,6 +538,7 @@ static int ata_xfer_mode2shift(unsigned 
 /**
  *	ata_mode_string - convert xfer_mask to string
  *	@xfer_mask: mask of bits supported; only highest bit counts.
+ *	@buf: buffer of ATA_MODE_STRING_MAX bytes
  *
  *	Determine string which represents the highest speed
  *	(highest bit in @modemask).
@@ -542,10 +547,10 @@ static int ata_xfer_mode2shift(unsigned 
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
@@ -570,11 +575,24 @@ static const char *ata_mode_string(unsig
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
@@ -1605,7 +1623,7 @@ int ata_dev_configure(struct ata_device 
 	struct ata_port *ap = dev->ap;
 	int print_info = ap->eh_context.i.flags & ATA_EHI_PRINTINFO;
 	const u16 *id = dev->id;
-	unsigned int xfer_mask;
+	char xfer_buf[ATA_MODE_STRING_MAX];
 	char revbuf[7];		/* XYZ-99\0 */
 	int rc;
 
@@ -1643,7 +1661,7 @@ int ata_dev_configure(struct ata_device 
 	 */
 
 	/* find max transfer mode; for printk only */
-	xfer_mask = ata_id_xfermask(id);
+	ata_mode_string(ata_id_xfermask(id), xfer_buf);
 
 	if (ata_msg_probe(ap))
 		ata_dump_id(id);
@@ -1683,8 +1701,7 @@ int ata_dev_configure(struct ata_device 
 			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "%s, "
 					"max %s, %Lu sectors: %s %s\n",
-					revbuf,
-					ata_mode_string(xfer_mask),
+					revbuf, xfer_buf,
 					(unsigned long long)dev->n_sectors,
 					lba_desc, ncq_desc);
 		} else {
@@ -1706,8 +1723,7 @@ int ata_dev_configure(struct ata_device 
 			if (ata_msg_drv(ap) && print_info)
 				ata_dev_printk(dev, KERN_INFO, "%s, "
 					"max %s, %Lu sectors: CHS %u/%u/%u\n",
-					revbuf,
-					ata_mode_string(xfer_mask),
+					revbuf, xfer_buf,
 					(unsigned long long)dev->n_sectors,
 					dev->cylinders, dev->heads,
 					dev->sectors);
@@ -1746,8 +1762,7 @@ int ata_dev_configure(struct ata_device 
 		/* print device info to dmesg */
 		if (ata_msg_drv(ap) && print_info)
 			ata_dev_printk(dev, KERN_INFO, "ATAPI, max %s%s\n",
-				       ata_mode_string(xfer_mask),
-				       cdb_intr_string);
+				       xfer_buf, cdb_intr_string);
 	}
 
 	/* determine max_sectors */
@@ -2349,6 +2364,7 @@ int ata_timing_compute(struct ata_device
 int ata_down_xfermask_limit(struct ata_device *dev, int force_pio0)
 {
 	unsigned long xfer_mask;
+	char xfer_buf[ATA_MODE_STRING_MAX];
 	int highbit;
 
 	xfer_mask = ata_pack_xfermask(dev->pio_mask, dev->mwdma_mask,
@@ -2371,7 +2387,7 @@ int ata_down_xfermask_limit(struct ata_d
 			    &dev->udma_mask);
 
 	ata_dev_printk(dev, KERN_WARNING, "limiting speed to %s\n",
-		       ata_mode_string(xfer_mask));
+		       ata_mode_string(xfer_mask, xfer_buf));
 
 	return 0;
 
@@ -2383,6 +2399,7 @@ static int ata_dev_set_mode(struct ata_d
 {
 	struct ata_eh_context *ehc = &dev->ap->eh_context;
 	unsigned int err_mask;
+	char xfer_buf[ATA_MODE_STRING_MAX];
 	int rc;
 
 	dev->flags &= ~ATA_DFLAG_PIO;
@@ -2405,8 +2422,10 @@ static int ata_dev_set_mode(struct ata_d
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
 
@@ -2458,6 +2477,9 @@ int ata_set_mode(struct ata_port *ap, st
 		pio_mask = ata_pack_xfermask(dev->pio_mask, 0, 0);
 		dma_mask = ata_pack_xfermask(0, dev->mwdma_mask, dev->udma_mask);
 		dev->pio_mode = ata_xfer_mask2mode(pio_mask);
+		/* XXX - debug */
+		if (dev->pio_mode)
+			dev->pio_mode = XFER_PIO_0;
 		dev->dma_mode = ata_xfer_mask2mode(dma_mask);
 
 		found = 1;
@@ -3400,6 +3422,7 @@ static void ata_dev_xfermask(struct ata_
 	struct ata_port *ap = dev->ap;
 	struct ata_host *host = ap->host;
 	unsigned long xfer_mask;
+	int i;
 
 	/* controller modes available */
 	xfer_mask = ata_pack_xfermask(ap->pio_mask,
@@ -3418,10 +3441,27 @@ static void ata_dev_xfermask(struct ata_
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
@@ -5800,7 +5840,7 @@ int ata_device_add(const struct ata_prob
 	/* register each port bound to this device */
 	for (i = 0; i < host->n_ports; i++) {
 		struct ata_port *ap;
-		unsigned long xfer_mode_mask;
+		char xfer_buf[ATA_MODE_STRING_MAX];
 		int irq_line = ent->irq;
 
 		ap = ata_port_add(ent, host, i);
@@ -5827,18 +5867,16 @@ int ata_device_add(const struct ata_prob
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
 
 		/* freeze port before requesting IRQ */
Index: work/drivers/ata/libata-sff.c
===================================================================
--- work.orig/drivers/ata/libata-sff.c	2007-01-03 12:30:18.000000000 +0900
+++ work/drivers/ata/libata-sff.c	2007-01-03 12:30:19.000000000 +0900
@@ -691,6 +691,7 @@ void ata_bmdma_stop(struct ata_queued_cm
  */
 void ata_bmdma_freeze(struct ata_port *ap)
 {
+#if 0
 	struct ata_ioports *ioaddr = &ap->ioaddr;
 
 	ap->ctl |= ATA_NIEN;
@@ -701,6 +702,7 @@ void ata_bmdma_freeze(struct ata_port *a
 	else
 		outb(ap->ctl, ioaddr->ctl_addr);
 
+#endif
 	/* Under certain circumstances, some controllers raise IRQ on
 	 * ATA_NIEN manipulation.  Also, many controllers fail to mask
 	 * previously pending IRQ on ATA_NIEN assertion.  Clear it.

--------------040604090606050300000800--
