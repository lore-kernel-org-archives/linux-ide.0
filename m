From: Kyle McMartin <kyle@canonical.com>
Subject: [RFT] libata hpa support
Date: Fri, 23 Feb 2007 12:06:25 -0500
Message-ID: <20070223170625.GA29931@athena.road.mcmartin.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from stout.engsoc.carleton.ca ([134.117.69.22]:37553 "EHLO
	stout.engsoc.carleton.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932341AbXBWRaQ (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 23 Feb 2007 12:30:16 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Garzik <jeff@garzik.org>
Cc: linux-ide@vger.kernel.org, mjg59@ubuntu.com

Rough first cut at Host Protected Area support for libata. Buyer beware, I
can't guarantee it won't club baby seals or kick your cat... In particular,
the non-LBA48 codepath hasn't been tested by me...

A few questions are raised, libata SATA hasn't been resizing disks in the
past, should we only disable HPA on PATA only, a la drivers/ide? In any
event, supporting HPA lets people who had partitions which extend beyond
the protected area boot with libata PATA. Some policy decision needs to be
made too... Right now, I'm just disabling it unilaterally.

I've added 0 && to the patch where we would attempt to resize the disk to
mitigate the risk testing the reading portion of the code. I don't have a
laptop with a jumpered setting, so I've been testing by halving the disk size
as you can see in the #if 0 section of code. It seems to work and recover
alright. The SET_MAX_ADDRESS{,_EXT} is temporary, as when I reboot and look
at the disk I've been testing with, it's still full sized.

I'd appreciate a few more eyes on the code, and maybe even a tester
or two. (The box I'm beating on to test this has buggy ACPI, so I've not
had the opportunity to test resume, for instance.)

In particular, the taskfiles could use a perusing, I've noticed on my
box when the ICH8 controller is in AHCI mode, everything is fine, but when
driving it with ata_piix, the first read_native_max returns something that is
incorrect (but successive attempts work... very bizarre.)

Cheers,
	Kyle M.

Signed-off-by: Kyle McMartin <kyle@canonical.com>

---
diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 2cf8251..c3da3ea 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -804,6 +804,182 @@ void ata_id_c_string(const u16 *id, unsigned char *s,
 	*p = '\0';
 }
 
+static u64 ata_tf_to_lba48(struct ata_taskfile *tf)
+{
+	u64 sectors = 0;
+
+	sectors |= ((u64)(tf->hob_lbah & 0xff)) << 40;
+	sectors |= ((u64)(tf->hob_lbam & 0xff)) << 32;
+	sectors |= (tf->hob_lbal & 0xff) << 24;
+	sectors |= (tf->lbah & 0xff) << 16;
+	sectors |= (tf->lbam & 0xff) << 8;
+	sectors |= (tf->lbal & 0xff);
+
+	return ++sectors;
+}
+
+static u64 ata_tf_to_lba(struct ata_taskfile *tf)
+{
+	u64 sectors = 0;
+
+	sectors |= (tf->device & 0xff) << 24;
+	sectors |= (tf->lbah & 0xff) << 16;
+	sectors |= (tf->lbam & 0xff) << 8;
+	sectors |= (tf->lbal & 0xff);
+
+	return ++sectors;
+}
+
+static u64 ata_read_native_max_address_ext(struct ata_device *dev)
+{
+	unsigned int err;
+	struct ata_taskfile tf;
+
+	ata_tf_init(dev, &tf);
+
+	tf.command = ATA_CMD_READ_NATIVE_MAX_EXT;
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR;
+	tf.protocol |= ATA_PROT_NODATA;
+	tf.device = 0x40;
+
+	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	if (err)
+		return 0;
+
+	return ata_tf_to_lba48(&tf);
+}
+
+static u64 ata_read_native_max_address(struct ata_device *dev)
+{
+	unsigned int err;
+	struct ata_taskfile tf;
+
+	ata_tf_init(dev, &tf);
+
+	tf.command = ATA_CMD_READ_NATIVE_MAX;
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol |= ATA_PROT_NODATA;
+	tf.device = 0x40;
+
+	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	if (err)
+		return 0;
+
+	return ata_tf_to_lba(&tf);
+}
+
+static u64 ata_set_native_max_address_ext(struct ata_device *dev, u64 new_sectors)
+{
+	unsigned int err;
+	struct ata_taskfile tf;
+
+	new_sectors--;
+
+	ata_tf_init(dev, &tf);
+
+	tf.command = ATA_CMD_SET_MAX_EXT;
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_LBA48 | ATA_TFLAG_ISADDR;
+	tf.protocol |= ATA_PROT_NODATA;
+	tf.device = 0x40;
+
+	tf.lbal = (new_sectors >> 0) & 0xff;
+	tf.lbam = (new_sectors >> 8) & 0xff;
+	tf.lbah = (new_sectors >> 16) & 0xff;
+
+	tf.hob_lbal = (new_sectors >> 24) & 0xff;
+	tf.hob_lbam = (new_sectors >> 32) & 0xff;
+	tf.hob_lbah = (new_sectors >> 40) & 0xff;
+
+	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	if (err)
+		return 0;
+
+	return ata_tf_to_lba48(&tf);
+}
+
+static u64 ata_set_native_max_address(struct ata_device *dev, u64 new_sectors)
+{
+	unsigned int err;
+	struct ata_taskfile tf;
+
+	new_sectors--;
+
+	ata_tf_init(dev, &tf);
+
+	tf.command = ATA_CMD_SET_MAX;
+	tf.flags |= ATA_TFLAG_DEVICE | ATA_TFLAG_ISADDR;
+	tf.protocol |= ATA_PROT_NODATA;
+
+	tf.lbal = (new_sectors >> 0) & 0xff;
+	tf.lbam = (new_sectors >> 8) & 0xff;
+	tf.lbah = (new_sectors >> 16) & 0xff;
+	tf.device = ((new_sectors >> 24) & 0xff) | 0x40;
+
+	err = ata_exec_internal(dev, &tf, NULL, DMA_NONE, NULL, 0);
+	if (err)
+		return 0;
+
+	return ata_tf_to_lba(&tf);
+}
+
+static u64 ata_hpa_resize(struct ata_device *dev)
+{
+	u64 sectors = dev->n_sectors;
+	u64 hpa_sectors;
+
+	if (ata_id_has_lba48(dev->id))
+		hpa_sectors = ata_read_native_max_address_ext(dev);
+	else
+		hpa_sectors = ata_read_native_max_address(dev);
+
+#if 0 /* testing, one, two, three... */
+	/* if no hpa, both should be equal */
+	ata_dev_printk(dev, KERN_INFO, "%s 1: sectors = %lld, hpa_sectors = %lld\n",
+		__FUNCTION__, sectors, hpa_sectors);
+
+	if (hpa_sectors == sectors) {
+		if (ata_id_has_lba48(dev->id))
+			hpa_sectors = ata_set_native_max_address_ext(dev, sectors >>= 1);
+		else
+			hpa_sectors = ata_set_native_max_address(dev, sectors >>= 1);
+	}
+
+	/* we just halved the disk, both should be equal */
+	ata_dev_printk(dev, KERN_INFO, "%s 2: sectors = %lld, hpa_sectors = %lld\n",
+		__FUNCTION__, sectors, hpa_sectors);
+
+	if (ata_id_has_lba48(dev->id))
+		hpa_sectors = ata_read_native_max_address_ext(dev);
+	else
+		hpa_sectors = ata_read_native_max_address(dev);
+
+	/* read native max, hpa_sectors should be original size */
+	ata_dev_printk(dev, KERN_INFO, "%s 3: sectors = %lld, hpa_sectors = %lld\n",
+		__FUNCTION__, sectors, hpa_sectors);
+#endif
+
+	if (hpa_sectors > sectors) {
+		ata_dev_printk(dev, KERN_INFO,
+			"Host Protected Area detected:\n"
+			"\tcurrent size: %lld sectors\n"
+			"\tnative size: %lld sectors\n",
+			sectors, hpa_sectors);
+
+		if (ata_id_has_lba48(dev->id))
+			hpa_sectors = ata_set_native_max_address_ext(dev, hpa_sectors);
+		else
+			hpa_sectors = ata_set_native_max_address(dev, hpa_sectors);
+
+		if (hpa_sectors) {
+			ata_dev_printk(dev, KERN_INFO,
+				"native size increased to %lld sectors\n", hpa_sectors);
+			return hpa_sectors;
+		}
+	}
+
+	return sectors;
+}
+
 static u64 ata_id_n_sectors(const u16 *id)
 {
 	if (ata_id_has_lba(id)) {
@@ -1630,6 +1806,9 @@ int ata_dev_configure(struct ata_device *dev)
 					dev->flags |= ATA_DFLAG_FLUSH_EXT;
 			}
 
+			if (ata_id_hpa_enabled(dev->id))
+				dev->n_sectors = ata_hpa_resize(dev);
+
 			/* config NCQ */
 			ata_dev_config_ncq(dev, ncq_desc, sizeof(ncq_desc));
 
diff --git a/include/linux/ata.h b/include/linux/ata.h
index 272736e..38113ba 100644
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -158,6 +158,8 @@ enum {
 	ATA_CMD_INIT_DEV_PARAMS	= 0x91,
 	ATA_CMD_READ_NATIVE_MAX	= 0xF8,
 	ATA_CMD_READ_NATIVE_MAX_EXT = 0x27,
+	ATA_CMD_SET_MAX		= 0xF9,
+	ATA_CMD_SET_MAX_EXT	= 0x37,
 	ATA_CMD_READ_LOG_EXT	= 0x2f,
 
 	/* READ_LOG_EXT pages */
