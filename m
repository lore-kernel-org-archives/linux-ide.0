From: Jeff Garzik <jgarzik@pobox.com>
Subject: Re: [PATCH libata-dev-2.6] Issue INITIALIZE DEVICE PARAMETERS for
 CHS only devices
Date: Thu, 24 Feb 2005 02:48:26 -0500
Message-ID: <421D86CA.3010606@pobox.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <42167CDD.50301@pobox.com> <421C6840.7090903@tw.ibm.com> <421C97C1.9090701@pobox.com> <421D3DB1.1090800@tw.ibm.com> <421D41C2.3030909@pobox.com> <421D663B.5050107@tw.ibm.com> <421D679B.7020508@pobox.com> <421D7727.4030408@tw.ibm.com> <421D78A2.8090103@pobox.com> <421D7BD2.7030309@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------070905060706090803090708"
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:50856 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262134AbVBXHss (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 24 Feb 2005 02:48:48 -0500
In-Reply-To: <421D7BD2.7030309@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Albert Lee <albertcc@tw.ibm.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.
--------------070905060706090803090708
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit


This patch similarly fails to apply:

include/linux/ata.h 1.23: 281 lines
include/linux/ata.h 1.23 -> 1.24: 281 lines
1 out of 1 hunk FAILED -- saving rejects to file include/linux/ata.h.rej
drivers/scsi/libata-core.c 1.121: 4064 lines
drivers/scsi/libata-core.c 1.121 -> 1.122: 4064 lines
2 out of 3 hunks FAILED -- saving rejects to file 
drivers/scsi/libata-core.c.rej


Here at home, I have many trees, all diff'd against 2.6.11-rc4:

adma/      atapi-enable/        iomap/     promise-sata-pata/  via-6421/
adma-mwi/  bridge-detect/       passthru/  remove-one-fix/
ahci-msi/  chs-support/         pdc2027x/  sata-sil-irq/
ALL/       ioctl-get-identity/  pdc20619/  tf-cleanup/

When I receive a C/H/S patch from you, I apply it to the "chs-support" 
tree, which is

	2.6.11-rc4 + your C/H/S patches

When I receive a pata_pdc2027x patch from you, I apply it to the 
"pdc2027x" tree, which is

	2.6.11-rc4 + your pata_pdc2027x patches

I have attached the cumulative patch for "chs-support" tree, if this 
helps you re-diff your changes.

Regards,

	Jeff



--------------070905060706090803090708
Content-Type: text/plain;
 name="patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch"

diff -Nru a/drivers/scsi/libata-core.c b/drivers/scsi/libata-core.c
--- a/drivers/scsi/libata-core.c	2005-02-24 02:47:53 -05:00
+++ b/drivers/scsi/libata-core.c	2005-02-24 02:47:53 -05:00
@@ -1008,7 +1008,7 @@
 static void ata_dev_identify(struct ata_port *ap, unsigned int device)
 {
 	struct ata_device *dev = &ap->device[device];
-	unsigned int i;
+	unsigned int major_version;
 	u16 tmp;
 	unsigned long xfer_modes;
 	u8 status;
@@ -1106,9 +1106,9 @@
 	 * common ATA, ATAPI feature tests
 	 */
 
-	/* we require LBA and DMA support (bits 8 & 9 of word 49) */
-	if (!ata_id_has_dma(dev->id) || !ata_id_has_lba(dev->id)) {
-		printk(KERN_DEBUG "ata%u: no dma/lba\n", ap->id);
+	/* we require DMA support (bits 8 of word 49) */
+	if (!ata_id_has_dma(dev->id)) {
+		printk(KERN_DEBUG "ata%u: no dma\n", ap->id);
 		goto err_out_nosup;
 	}
 
@@ -1128,32 +1128,64 @@
 		if (!ata_id_is_ata(dev->id))	/* sanity check */
 			goto err_out_nosup;
 
+		/* get major version */
 		tmp = dev->id[ATA_ID_MAJOR_VER];
-		for (i = 14; i >= 1; i--)
-			if (tmp & (1 << i))
+		for (major_version = 14; major_version >= 1; major_version--)
+			if (tmp & (1 << major_version))
 				break;
 
 		/* we require at least ATA-3 */
-		if (i < 3) {
+		if (major_version < 3) {
 			printk(KERN_DEBUG "ata%u: no ATA-3\n", ap->id);
 			goto err_out_nosup;
 		}
 
-		if (ata_id_has_lba48(dev->id)) {
-			dev->flags |= ATA_DFLAG_LBA48;
-			dev->n_sectors = ata_id_u64(dev->id, 100);
-		} else {
-			dev->n_sectors = ata_id_u32(dev->id, 60);
+		if (ata_id_has_lba(dev->id)) {
+			dev->flags |= ATA_DFLAG_LBA;
+
+			if (ata_id_has_lba48(dev->id)) {
+				dev->flags |= ATA_DFLAG_LBA48;
+				dev->n_sectors = ata_id_u64(dev->id, 100);
+			} else {
+				dev->n_sectors = ata_id_u32(dev->id, 60);
+			}
+
+			/* print device info to dmesg */
+			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors:%s\n",
+			       ap->id, device,
+			       major_version,
+			       ata_mode_string(xfer_modes),
+			       (unsigned long long)dev->n_sectors,
+			       dev->flags & ATA_DFLAG_LBA48 ? " LBA48" : " LBA");
+		} else { 
+			/* CHS */
+
+			/* Default translation */
+			dev->cylinders	= dev->id[1];
+			dev->heads	= dev->id[3];
+			dev->sectors	= dev->id[6];
+			dev->n_sectors	= dev->cylinders * dev->heads * dev->sectors;
+
+			if (ata_id_current_chs_valid(dev->id)) {
+				/* Current CHS translation is valid. */
+				dev->cylinders = dev->id[54];
+				dev->heads     = dev->id[55];
+				dev->sectors   = dev->id[56];
+				
+				dev->n_sectors = ata_id_u32(dev->id, 57);
+			}
+
+			/* print device info to dmesg */
+			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors: CHS %d/%d/%d\n",
+			       ap->id, device,
+			       major_version,
+			       ata_mode_string(xfer_modes),
+			       (unsigned long long)dev->n_sectors,
+			       (int)dev->cylinders, (int)dev->heads, (int)dev->sectors);
+
 		}
 
 		ap->host->max_cmd_len = 16;
-
-		/* print device info to dmesg */
-		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
-		       ap->id, device,
-		       ata_mode_string(xfer_modes),
-		       (unsigned long long)dev->n_sectors,
-		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");
 	}
 
 	/* ATAPI-specific feature tests */
@@ -2736,8 +2768,12 @@
 
 		ata_tf_init(ap, &qc->tf, dev->devno);
 
-		if (dev->flags & ATA_DFLAG_LBA48)
-			qc->tf.flags |= ATA_TFLAG_LBA48;
+		if (dev->flags & ATA_DFLAG_LBA) {
+			qc->tf.flags |= ATA_TFLAG_LBA;
+
+			if (dev->flags & ATA_DFLAG_LBA48)
+				qc->tf.flags |= ATA_TFLAG_LBA48;
+		}
 	}
 
 	return qc;
diff -Nru a/drivers/scsi/libata-scsi.c b/drivers/scsi/libata-scsi.c
--- a/drivers/scsi/libata-scsi.c	2005-02-24 02:47:53 -05:00
+++ b/drivers/scsi/libata-scsi.c	2005-02-24 02:47:53 -05:00
@@ -435,77 +435,106 @@
 static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
 	struct ata_taskfile *tf = &qc->tf;
+	struct ata_device *dev = qc->dev;
+	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 	u64 dev_sectors = qc->dev->n_sectors;
-	u64 sect = 0;
-	u32 n_sect = 0;
+	u64 block = 0;
+	u32 n_block = 0;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
-	tf->device |= ATA_LBA;
 
 	if (scsicmd[0] == VERIFY) {
-		sect |= ((u64)scsicmd[2]) << 24;
-		sect |= ((u64)scsicmd[3]) << 16;
-		sect |= ((u64)scsicmd[4]) << 8;
-		sect |= ((u64)scsicmd[5]);
+		block |= ((u64)scsicmd[2]) << 24;
+		block |= ((u64)scsicmd[3]) << 16;
+		block |= ((u64)scsicmd[4]) << 8;
+		block |= ((u64)scsicmd[5]);
 
-		n_sect |= ((u32)scsicmd[7]) << 8;
-		n_sect |= ((u32)scsicmd[8]);
+		n_block |= ((u32)scsicmd[7]) << 8;
+		n_block |= ((u32)scsicmd[8]);
 	}
 
 	else if (scsicmd[0] == VERIFY_16) {
-		sect |= ((u64)scsicmd[2]) << 56;
-		sect |= ((u64)scsicmd[3]) << 48;
-		sect |= ((u64)scsicmd[4]) << 40;
-		sect |= ((u64)scsicmd[5]) << 32;
-		sect |= ((u64)scsicmd[6]) << 24;
-		sect |= ((u64)scsicmd[7]) << 16;
-		sect |= ((u64)scsicmd[8]) << 8;
-		sect |= ((u64)scsicmd[9]);
-
-		n_sect |= ((u32)scsicmd[10]) << 24;
-		n_sect |= ((u32)scsicmd[11]) << 16;
-		n_sect |= ((u32)scsicmd[12]) << 8;
-		n_sect |= ((u32)scsicmd[13]);
+		block |= ((u64)scsicmd[2]) << 56;
+		block |= ((u64)scsicmd[3]) << 48;
+		block |= ((u64)scsicmd[4]) << 40;
+		block |= ((u64)scsicmd[5]) << 32;
+		block |= ((u64)scsicmd[6]) << 24;
+		block |= ((u64)scsicmd[7]) << 16;
+		block |= ((u64)scsicmd[8]) << 8;
+		block |= ((u64)scsicmd[9]);
+
+		n_block |= ((u32)scsicmd[10]) << 24;
+		n_block |= ((u32)scsicmd[11]) << 16;
+		n_block |= ((u32)scsicmd[12]) << 8;
+		n_block |= ((u32)scsicmd[13]);
 	}
 
 	else
 		return 1;
 
-	if (!n_sect)
+	if (!n_block)
 		return 1;
-	if (sect >= dev_sectors)
+	if (block >= dev_sectors)
 		return 1;
-	if ((sect + n_sect) > dev_sectors)
+	if ((block + n_block) > dev_sectors)
 		return 1;
 	if (lba48) {
-		if (n_sect > (64 * 1024))
+		if (n_block > (64 * 1024))
 			return 1;
 	} else {
-		if (n_sect > 256)
+		if (n_block > 256)
 			return 1;
 	}
 
-	if (lba48) {
-		tf->command = ATA_CMD_VERIFY_EXT;
+	if (lba) {
+		if (lba48) {
+			tf->command = ATA_CMD_VERIFY_EXT;
 
-		tf->hob_nsect = (n_sect >> 8) & 0xff;
+			tf->hob_nsect = (n_block >> 8) & 0xff;
 
-		tf->hob_lbah = (sect >> 40) & 0xff;
-		tf->hob_lbam = (sect >> 32) & 0xff;
-		tf->hob_lbal = (sect >> 24) & 0xff;
-	} else {
-		tf->command = ATA_CMD_VERIFY;
+			tf->hob_lbah = (block >> 40) & 0xff;
+			tf->hob_lbam = (block >> 32) & 0xff;
+			tf->hob_lbal = (block >> 24) & 0xff;
+		} else {
+			tf->command = ATA_CMD_VERIFY;
 
-		tf->device |= (sect >> 24) & 0xf;
-	}
+			tf->device |= (block >> 24) & 0xf;
+		}
 
-	tf->nsect = n_sect & 0xff;
+		tf->nsect = n_block & 0xff;
 
-	tf->lbah = (sect >> 16) & 0xff;
-	tf->lbam = (sect >> 8) & 0xff;
-	tf->lbal = sect & 0xff;
+		tf->lbah = (block >> 16) & 0xff;
+		tf->lbam = (block >> 8) & 0xff;
+		tf->lbal = block & 0xff;
+
+		tf->device |= ATA_LBA;
+	} else {
+		/* CHS */
+		u32 sect, head, cyl, track;
+
+		/* Convert LBA to CHS */
+		track = (u32)block / dev->sectors;
+		cyl   = track / dev->heads;
+		head  = track % dev->heads;
+		sect  = (u32)block % dev->sectors + 1;
+
+		DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", (u32)block, track, cyl, head, sect);
+		
+		/* Check whether the converted CHS can fit. 
+		   Cylinder: 0-65535 
+		   Head: 0-15
+		   Sector: 1-255*/
+		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) 
+			return 1;
+		
+		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
+		tf->lbal = sect;
+		tf->lbam = cyl;
+		tf->lbah = cyl >> 8;
+		tf->device |= head;
+	}
 
 	return 0;
 }
@@ -533,11 +562,14 @@
 static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
 	struct ata_taskfile *tf = &qc->tf;
+	struct ata_device *dev = qc->dev;
+	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+	u64 block = 0;
+	u32 n_block = 0;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = qc->dev->xfer_protocol;
-	tf->device |= ATA_LBA;
 
 	if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
 	    scsicmd[0] == READ_16) {
@@ -547,80 +579,111 @@
 		tf->flags |= ATA_TFLAG_WRITE;
 	}
 
+	/* Calculate the SCSI LBA and transfer length. */
 	if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
-		if (lba48) {
-			tf->hob_nsect = scsicmd[7];
-			tf->hob_lbal = scsicmd[2];
-
-			qc->nsect = ((unsigned int)scsicmd[7] << 8) |
-					scsicmd[8];
-		} else {
-			/* if we don't support LBA48 addressing, the request
-			 * -may- be too large. */
-			if ((scsicmd[2] & 0xf0) || scsicmd[7])
-				return 1;
-
-			/* stores LBA27:24 in lower 4 bits of device reg */
-			tf->device |= scsicmd[2];
+		block |= ((u64)scsicmd[2]) << 24;
+		block |= ((u64)scsicmd[3]) << 16;
+		block |= ((u64)scsicmd[4]) << 8;
+		block |= ((u64)scsicmd[5]);
 
-			qc->nsect = scsicmd[8];
-		}
-
-		tf->nsect = scsicmd[8];
-		tf->lbal = scsicmd[5];
-		tf->lbam = scsicmd[4];
-		tf->lbah = scsicmd[3];
+		n_block |= ((u32)scsicmd[7]) << 8;
+		n_block |= ((u32)scsicmd[8]);
 
 		VPRINTK("ten-byte command\n");
-		return 0;
-	}
-
-	if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
-		qc->nsect = tf->nsect = scsicmd[4];
-		tf->lbal = scsicmd[3];
-		tf->lbam = scsicmd[2];
-		tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
-
+	} else if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
+		block |= ((u64)scsicmd[2]) << 8;
+		block |= ((u64)scsicmd[3]);
+		n_block |= ((u32)scsicmd[4]);
+	
 		VPRINTK("six-byte command\n");
-		return 0;
+	} else if (scsicmd[0] == READ_16 || scsicmd[0] == WRITE_16) {
+		block |= ((u64)scsicmd[2]) << 56;
+		block |= ((u64)scsicmd[3]) << 48;
+		block |= ((u64)scsicmd[4]) << 40;
+		block |= ((u64)scsicmd[5]) << 32;
+		block |= ((u64)scsicmd[6]) << 24;
+		block |= ((u64)scsicmd[7]) << 16;
+		block |= ((u64)scsicmd[8]) << 8;
+		block |= ((u64)scsicmd[9]);
+
+		n_block |= ((u32)scsicmd[10]) << 24;
+		n_block |= ((u32)scsicmd[11]) << 16;
+		n_block |= ((u32)scsicmd[12]) << 8;
+		n_block |= ((u32)scsicmd[13]);
+
+		VPRINTK("sixteen-byte command\n");
+	} else {
+		DPRINTK("no-byte command\n");
+		return 1;
 	}
 
-	if (scsicmd[0] == READ_16 || scsicmd[0] == WRITE_16) {
-		/* rule out impossible LBAs and sector counts */
-		if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])
-			return 1;
+	/* Check and compose ATA command */
+	if (!n_block)
+		/* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */
+		return 1;
 
+	if (lba) {
 		if (lba48) {
-			tf->hob_nsect = scsicmd[12];
-			tf->hob_lbal = scsicmd[6];
-			tf->hob_lbam = scsicmd[5];
-			tf->hob_lbah = scsicmd[4];
-
-			qc->nsect = ((unsigned int)scsicmd[12] << 8) |
-					scsicmd[13];
-		} else {
-			/* once again, filter out impossible non-zero values */
-			if (scsicmd[4] || scsicmd[5] || scsicmd[12] ||
-			    (scsicmd[6] & 0xf0))
+			/* The request -may- be too large for LBA48. */
+			if ((block >> 48) || (n_block > 65536))
 				return 1;
 
-			/* stores LBA27:24 in lower 4 bits of device reg */
-			tf->device |= scsicmd[6];
+			tf->hob_nsect = (n_block >> 8) & 0xff;
 
-			qc->nsect = scsicmd[13];
-		}
+			tf->hob_lbah = (block >> 40) & 0xff;
+			tf->hob_lbam = (block >> 32) & 0xff;
+			tf->hob_lbal = (block >> 24) & 0xff;
+		} else { 
+			/* LBA28 */
 
-		tf->nsect = scsicmd[13];
-		tf->lbal = scsicmd[9];
-		tf->lbam = scsicmd[8];
-		tf->lbah = scsicmd[7];
+			/* The request -may- be too large for LBA28. */
+			if ((block >> 28) || (n_block > 256))
+				return 1;
 
-		VPRINTK("sixteen-byte command\n");
-		return 0;
+			tf->device |= (block >> 24) & 0xf;
+		}
+	
+		qc->nsect = n_block;
+		tf->nsect = n_block & 0xff;
+
+		tf->lbah = (block >> 16) & 0xff;
+		tf->lbam = (block >> 8) & 0xff;
+		tf->lbal = block & 0xff;
+
+		tf->device |= ATA_LBA;
+	} else { 
+		/* CHS */
+		u32 sect, head, cyl, track;
+
+		/* The request -may- be too large for CHS addressing. */
+		if ((block >> 28) || (n_block > 256))
+			return 1;
+			
+		/* Convert LBA to CHS */
+		track = (u32)block / dev->sectors;
+		cyl   = track / dev->heads;
+		head  = track % dev->heads;
+		sect  = (u32)block % dev->sectors + 1;
+
+		DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", 
+			(u32)block, track, cyl, head, sect);
+		
+		/* Check whether the converted CHS can fit. 
+		   Cylinder: 0-65535 
+		   Head: 0-15
+		   Sector: 1-255*/
+		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) 
+			return 1;
+		
+		qc->nsect = n_block;
+		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
+		tf->lbal = sect;
+		tf->lbam = cyl;
+		tf->lbah = cyl >> 8;
+		tf->device |= head;
 	}
 
-	DPRINTK("no-byte command\n");
-	return 1;
+	return 0;
 }
 
 static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
@@ -1162,10 +1225,20 @@
 
 	VPRINTK("ENTER\n");
 
-	if (ata_id_has_lba48(args->id))
-		n_sectors = ata_id_u64(args->id, 100);
-	else
-		n_sectors = ata_id_u32(args->id, 60);
+	if (ata_id_has_lba(args->id)) {
+		if (ata_id_has_lba48(args->id))
+			n_sectors = ata_id_u64(args->id, 100);
+		else
+			n_sectors = ata_id_u32(args->id, 60);
+	} else {
+		/* CHS default translation */
+		n_sectors = args->id[1] * args->id[3] * args->id[6];
+
+		if (ata_id_current_chs_valid(args->id))
+			/* CHS current translation */
+			n_sectors = ata_id_u32(args->id, 57);
+	}
+
 	n_sectors--;		/* ATA TotalUserSectors - 1 */
 
 	tmp = n_sectors;	/* note: truncates, if lba48 */
diff -Nru a/include/linux/ata.h b/include/linux/ata.h
--- a/include/linux/ata.h	2005-02-24 02:47:53 -05:00
+++ b/include/linux/ata.h	2005-02-24 02:47:53 -05:00
@@ -174,6 +174,7 @@
 	ATA_TFLAG_ISADDR	= (1 << 1), /* enable r/w to nsect/lba regs */
 	ATA_TFLAG_DEVICE	= (1 << 2), /* enable r/w to device reg */
 	ATA_TFLAG_WRITE		= (1 << 3), /* data dir: host->dev==1 (write) */
+	ATA_TFLAG_LBA		= (1 << 4), /* enable LBA */
 };
 
 enum ata_tf_protocols {
@@ -241,6 +242,18 @@
 	  ((u64) (id)[(n) + 2] << 32) |	\
 	  ((u64) (id)[(n) + 1] << 16) |	\
 	  ((u64) (id)[(n) + 0]) )
+
+static inline int ata_id_current_chs_valid(u16 *id)
+{
+	/* For ATA-1 devices, if the INITIALIZE DEVICE PARAMETERS command 
+	   has not been issued to the device then the values of 
+	   id[54] to id[56] are vendor specific. */
+	return (id[53] & 0x01) && /* Current translation valid */
+		id[54] &&  /* cylinders in current translation */
+		id[55] &&  /* heads in current translation */
+		id[55] <= 16 &&
+		id[56];    /* sectors in current translation */
+}
 
 static inline int atapi_cdb_len(u16 *dev_id)
 {
diff -Nru a/include/linux/libata.h b/include/linux/libata.h
--- a/include/linux/libata.h	2005-02-24 02:47:53 -05:00
+++ b/include/linux/libata.h	2005-02-24 02:47:53 -05:00
@@ -95,6 +95,7 @@
 	ATA_DFLAG_LBA48		= (1 << 0), /* device supports LBA48 */
 	ATA_DFLAG_PIO		= (1 << 1), /* device currently in PIO mode */
 	ATA_DFLAG_LOCK_SECTORS	= (1 << 2), /* don't adjust max_sectors */
+	ATA_DFLAG_LBA		= (1 << 3), /* device supports LBA */
 
 	ATA_DEV_UNKNOWN		= 0,	/* unknown device */
 	ATA_DEV_ATA		= 1,	/* ATA device */
@@ -278,6 +279,11 @@
 	u8			xfer_protocol;	/* taskfile xfer protocol */
 	u8			read_cmd;	/* opcode to use on read */
 	u8			write_cmd;	/* opcode to use on write */
+
+	/* for CHS addressing */
+	u16			cylinders;	/* Number of cylinders */
+	u16			heads;		/* Number of heads */
+	u16			sectors;	/* Number of sectors per track */
 };
 
 struct ata_port {

--------------070905060706090803090708--
