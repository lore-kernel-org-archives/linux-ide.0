From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH libata-dev-2.6 2/3] Add CHS support
Date: Sun, 6 Feb 2005 14:05:50 +0800
Message-ID: <008401c50c11$eae8f480$a801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_0081_01C50C54.F68D78E0"
Received: from bluehawaii.tikira.net ([61.62.22.51]:41965 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S269942AbVBFGGP (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 01:06:15 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_0081_01C50C54.F68D78E0
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi Jeff,

  These are the patches for libata CHS support. 

  Attached please find the patch 2/3 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------------------------
--- libata-dev-2.6/drivers/scsi/libata-core.c 2005-02-05 10:41:49.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-core.c 2005-02-05 13:53:58.000000000 +0800
@@ -987,7 +987,7 @@
 static void ata_dev_identify(struct ata_port *ap, unsigned int device)
 {
  struct ata_device *dev = &ap->device[device];
- unsigned int i;
+ unsigned int major_version;
  u16 tmp;
  unsigned long xfer_modes;
  u8 status;
@@ -1085,9 +1085,9 @@
   * common ATA, ATAPI feature tests
   */
 
- /* we require LBA and DMA support (bits 8 & 9 of word 49) */
- if (!ata_id_has_dma(dev->id) || !ata_id_has_lba(dev->id)) {
-  printk(KERN_DEBUG "ata%u: no dma/lba\n", ap->id);
+ /* we require DMA support (bits 8 of word 49) */
+ if (!ata_id_has_dma(dev->id)) {
+  printk(KERN_DEBUG "ata%u: no dma\n", ap->id);
   goto err_out_nosup;
  }
 
@@ -1107,32 +1107,64 @@
   if (!ata_id_is_ata(dev->id)) /* sanity check */
    goto err_out_nosup;
 
+  /* get major version */
   tmp = dev->id[ATA_ID_MAJOR_VER];
-  for (i = 14; i >= 1; i--)
-   if (tmp & (1 << i))
+  for (major_version = 14; major_version >= 1; major_version--)
+   if (tmp & (1 << major_version))
     break;
 
   /* we require at least ATA-3 */
-  if (i < 3) {
+  if (major_version < 3) {
    printk(KERN_DEBUG "ata%u: no ATA-3\n", ap->id);
    goto err_out_nosup;
   }
 
-  if (ata_id_has_lba48(dev->id)) {
-   dev->flags |= ATA_DFLAG_LBA48;
-   dev->n_sectors = ata_id_u64(dev->id, 100);
-  } else {
-   dev->n_sectors = ata_id_u32(dev->id, 60);
+  if (ata_id_has_lba(dev->id)) {
+   dev->flags |= ATA_DFLAG_LBA;
+
+   if (ata_id_has_lba48(dev->id)) {
+    dev->flags |= ATA_DFLAG_LBA48;
+    dev->n_sectors = ata_id_u64(dev->id, 100);
+   } else {
+    dev->n_sectors = ata_id_u32(dev->id, 60);
+   }
+
+   /* print device info to dmesg */
+   printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors:%s\n",
+          ap->id, device,
+          major_version,
+          ata_mode_string(xfer_modes),
+          (unsigned long long)dev->n_sectors,
+          dev->flags & ATA_DFLAG_LBA48 ? " LBA48" : " LBA");
+  } else { 
+   /* CHS */
+
+   /* Default translation */
+   dev->cylinders = dev->id[1];
+   dev->heads = dev->id[3];
+   dev->sectors = dev->id[6];
+   dev->n_sectors = dev->cylinders * dev->heads * dev->sectors;
+
+   if (ata_id_current_chs_valid(dev->id)) {
+    /* Current CHS translation is valid. */
+    dev->cylinders = dev->id[54];
+    dev->heads     = dev->id[55];
+    dev->sectors   = dev->id[56];
+    
+    dev->n_sectors = ata_id_u32(dev->id, 57);
+   }
+
+   /* print device info to dmesg */
+   printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors: CHS %d/%d/%d\n",
+          ap->id, device,
+          major_version,
+          ata_mode_string(xfer_modes),
+          (unsigned long long)dev->n_sectors,
+          (int)dev->cylinders, (int)dev->heads, (int)dev->sectors);
+
   }
 
   ap->host->max_cmd_len = 16;
-
-  /* print device info to dmesg */
-  printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",
-         ap->id, device,
-         ata_mode_string(xfer_modes),
-         (unsigned long long)dev->n_sectors,
-         dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");
  }
 
  /* ATAPI-specific feature tests */
@@ -2745,8 +2777,12 @@
 
   ata_tf_init(ap, &qc->tf, dev->devno);
 
-  if (dev->flags & ATA_DFLAG_LBA48)
-   qc->tf.flags |= ATA_TFLAG_LBA48;
+  if (dev->flags & ATA_DFLAG_LBA) {
+   qc->tf.flags |= ATA_TFLAG_LBA;
+
+   if (dev->flags & ATA_DFLAG_LBA48)
+    qc->tf.flags |= ATA_TFLAG_LBA48;
+  }
  }
 
  return qc;

------=_NextPart_000_0081_01C50C54.F68D78E0
Content-Type: application/octet-stream;
	name="chs2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="chs2.diff"

--- libata-dev-2.6/drivers/scsi/libata-core.c	2005-02-05 =
10:41:49.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/scsi/libata-core.c	2005-02-05 =
13:53:58.000000000 +0800=0A=
@@ -987,7 +987,7 @@=0A=
 static void ata_dev_identify(struct ata_port *ap, unsigned int device)=0A=
 {=0A=
 	struct ata_device *dev =3D &ap->device[device];=0A=
-	unsigned int i;=0A=
+	unsigned int major_version;=0A=
 	u16 tmp;=0A=
 	unsigned long xfer_modes;=0A=
 	u8 status;=0A=
@@ -1085,9 +1085,9 @@=0A=
 	 * common ATA, ATAPI feature tests=0A=
 	 */=0A=
 =0A=
-	/* we require LBA and DMA support (bits 8 & 9 of word 49) */=0A=
-	if (!ata_id_has_dma(dev->id) || !ata_id_has_lba(dev->id)) {=0A=
-		printk(KERN_DEBUG "ata%u: no dma/lba\n", ap->id);=0A=
+	/* we require DMA support (bits 8 of word 49) */=0A=
+	if (!ata_id_has_dma(dev->id)) {=0A=
+		printk(KERN_DEBUG "ata%u: no dma\n", ap->id);=0A=
 		goto err_out_nosup;=0A=
 	}=0A=
 =0A=
@@ -1107,32 +1107,64 @@=0A=
 		if (!ata_id_is_ata(dev->id))	/* sanity check */=0A=
 			goto err_out_nosup;=0A=
 =0A=
+		/* get major version */=0A=
 		tmp =3D dev->id[ATA_ID_MAJOR_VER];=0A=
-		for (i =3D 14; i >=3D 1; i--)=0A=
-			if (tmp & (1 << i))=0A=
+		for (major_version =3D 14; major_version >=3D 1; major_version--)=0A=
+			if (tmp & (1 << major_version))=0A=
 				break;=0A=
 =0A=
 		/* we require at least ATA-3 */=0A=
-		if (i < 3) {=0A=
+		if (major_version < 3) {=0A=
 			printk(KERN_DEBUG "ata%u: no ATA-3\n", ap->id);=0A=
 			goto err_out_nosup;=0A=
 		}=0A=
 =0A=
-		if (ata_id_has_lba48(dev->id)) {=0A=
-			dev->flags |=3D ATA_DFLAG_LBA48;=0A=
-			dev->n_sectors =3D ata_id_u64(dev->id, 100);=0A=
-		} else {=0A=
-			dev->n_sectors =3D ata_id_u32(dev->id, 60);=0A=
+		if (ata_id_has_lba(dev->id)) {=0A=
+			dev->flags |=3D ATA_DFLAG_LBA;=0A=
+=0A=
+			if (ata_id_has_lba48(dev->id)) {=0A=
+				dev->flags |=3D ATA_DFLAG_LBA48;=0A=
+				dev->n_sectors =3D ata_id_u64(dev->id, 100);=0A=
+			} else {=0A=
+				dev->n_sectors =3D ata_id_u32(dev->id, 60);=0A=
+			}=0A=
+=0A=
+			/* print device info to dmesg */=0A=
+			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors:%s\n",=0A=
+			       ap->id, device,=0A=
+			       major_version,=0A=
+			       ata_mode_string(xfer_modes),=0A=
+			       (unsigned long long)dev->n_sectors,=0A=
+			       dev->flags & ATA_DFLAG_LBA48 ? " LBA48" : " LBA");=0A=
+		} else { =0A=
+			/* CHS */=0A=
+=0A=
+			/* Default translation */=0A=
+			dev->cylinders	=3D dev->id[1];=0A=
+			dev->heads	=3D dev->id[3];=0A=
+			dev->sectors	=3D dev->id[6];=0A=
+			dev->n_sectors	=3D dev->cylinders * dev->heads * dev->sectors;=0A=
+=0A=
+			if (ata_id_current_chs_valid(dev->id)) {=0A=
+				/* Current CHS translation is valid. */=0A=
+				dev->cylinders =3D dev->id[54];=0A=
+				dev->heads     =3D dev->id[55];=0A=
+				dev->sectors   =3D dev->id[56];=0A=
+				=0A=
+				dev->n_sectors =3D ata_id_u32(dev->id, 57);=0A=
+			}=0A=
+=0A=
+			/* print device info to dmesg */=0A=
+			printk(KERN_INFO "ata%u: dev %u ATA-%d, max %s, %Lu sectors: CHS =
%d/%d/%d\n",=0A=
+			       ap->id, device,=0A=
+			       major_version,=0A=
+			       ata_mode_string(xfer_modes),=0A=
+			       (unsigned long long)dev->n_sectors,=0A=
+			       (int)dev->cylinders, (int)dev->heads, (int)dev->sectors);=0A=
+=0A=
 		}=0A=
 =0A=
 		ap->host->max_cmd_len =3D 16;=0A=
-=0A=
-		/* print device info to dmesg */=0A=
-		printk(KERN_INFO "ata%u: dev %u ATA, max %s, %Lu sectors:%s\n",=0A=
-		       ap->id, device,=0A=
-		       ata_mode_string(xfer_modes),=0A=
-		       (unsigned long long)dev->n_sectors,=0A=
-		       dev->flags & ATA_DFLAG_LBA48 ? " lba48" : "");=0A=
 	}=0A=
 =0A=
 	/* ATAPI-specific feature tests */=0A=
@@ -2745,8 +2777,12 @@=0A=
 =0A=
 		ata_tf_init(ap, &qc->tf, dev->devno);=0A=
 =0A=
-		if (dev->flags & ATA_DFLAG_LBA48)=0A=
-			qc->tf.flags |=3D ATA_TFLAG_LBA48;=0A=
+		if (dev->flags & ATA_DFLAG_LBA) {=0A=
+			qc->tf.flags |=3D ATA_TFLAG_LBA;=0A=
+=0A=
+			if (dev->flags & ATA_DFLAG_LBA48)=0A=
+				qc->tf.flags |=3D ATA_TFLAG_LBA48;=0A=
+		}=0A=
 	}=0A=
 =0A=
 	return qc;=0A=

------=_NextPart_000_0081_01C50C54.F68D78E0--


