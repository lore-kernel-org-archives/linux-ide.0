From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH libata-dev-2.6 3/3] Add CHS support
Date: Sun, 6 Feb 2005 14:08:17 +0800
Message-ID: <00a701c50c12$40c4c870$a801a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_00A4_01C50C55.4E50D180"
Received: from bluehawaii.tikira.net ([61.62.22.51]:44013 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S270419AbVBFGIm (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Sun, 6 Feb 2005 01:08:42 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_00A4_01C50C55.4E50D180
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi Jeff,

  These are the patches for libata CHS support. 

  Attached please find the patch 3/3 against the libata-dev-2.6 tree for your review. Thanks.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
-----------------------------------------------------------------------------------------
--- libata-dev-2.6/drivers/scsi/libata-scsi.c 2005-02-05 10:41:49.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c 2005-02-05 12:46:26.000000000 +0800
@@ -689,72 +689,101 @@
 static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
  struct ata_taskfile *tf = &qc->tf;
+ struct ata_device *dev = qc->dev;
+ unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
  unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
  u64 dev_sectors = qc->dev->n_sectors;
- u64 sect = 0;
- u32 n_sect = 0;
+ u64 block = 0;
+ u32 n_block = 0;
 
  tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
  tf->protocol = ATA_PROT_NODATA;
- tf->device |= ATA_LBA;
 
  if (scsicmd[0] == VERIFY) {
-  sect |= ((u64)scsicmd[2]) << 24;
-  sect |= ((u64)scsicmd[3]) << 16;
-  sect |= ((u64)scsicmd[4]) << 8;
-  sect |= ((u64)scsicmd[5]);
+  block |= ((u64)scsicmd[2]) << 24;
+  block |= ((u64)scsicmd[3]) << 16;
+  block |= ((u64)scsicmd[4]) << 8;
+  block |= ((u64)scsicmd[5]);
 
-  n_sect |= ((u32)scsicmd[7]) << 8;
-  n_sect |= ((u32)scsicmd[8]);
+  n_block |= ((u32)scsicmd[7]) << 8;
+  n_block |= ((u32)scsicmd[8]);
  }
 
  else if (scsicmd[0] == VERIFY_16) {
-  sect |= ((u64)scsicmd[2]) << 56;
-  sect |= ((u64)scsicmd[3]) << 48;
-  sect |= ((u64)scsicmd[4]) << 40;
-  sect |= ((u64)scsicmd[5]) << 32;
-  sect |= ((u64)scsicmd[6]) << 24;
-  sect |= ((u64)scsicmd[7]) << 16;
-  sect |= ((u64)scsicmd[8]) << 8;
-  sect |= ((u64)scsicmd[9]);
-
-  n_sect |= ((u32)scsicmd[10]) << 24;
-  n_sect |= ((u32)scsicmd[11]) << 16;
-  n_sect |= ((u32)scsicmd[12]) << 8;
-  n_sect |= ((u32)scsicmd[13]);
+  block |= ((u64)scsicmd[2]) << 56;
+  block |= ((u64)scsicmd[3]) << 48;
+  block |= ((u64)scsicmd[4]) << 40;
+  block |= ((u64)scsicmd[5]) << 32;
+  block |= ((u64)scsicmd[6]) << 24;
+  block |= ((u64)scsicmd[7]) << 16;
+  block |= ((u64)scsicmd[8]) << 8;
+  block |= ((u64)scsicmd[9]);
+
+  n_block |= ((u32)scsicmd[10]) << 24;
+  n_block |= ((u32)scsicmd[11]) << 16;
+  n_block |= ((u32)scsicmd[12]) << 8;
+  n_block |= ((u32)scsicmd[13]);
  }
 
  else
   return 1;
 
- if (!n_sect)
+ if (!n_block)
   return 1;
- if (sect >= dev_sectors)
+ if (block >= dev_sectors)
   return 1;
- if ((sect + n_sect) > dev_sectors)
+ if ((block + n_block) > dev_sectors)
   return 1;
  if (lba48) {
-  if (n_sect > (64 * 1024))
+  if (n_block > (64 * 1024))
    return 1;
  } else {
-  if (n_sect > 256)
+  if (n_block > 256)
    return 1;
  }
 
- if (lba48) {
-  tf->hob_nsect = (n_sect >> 8) & 0xff;
+ if (lba) {
+  if (lba48) {
+   tf->hob_nsect = (n_block >> 8) & 0xff;
 
-  tf->hob_lbah = (sect >> 40) & 0xff;
-  tf->hob_lbam = (sect >> 32) & 0xff;
-  tf->hob_lbal = (sect >> 24) & 0xff;
- } else
-  tf->device |= (sect >> 24) & 0xf;
+   tf->hob_lbah = (block >> 40) & 0xff;
+   tf->hob_lbam = (block >> 32) & 0xff;
+   tf->hob_lbal = (block >> 24) & 0xff;
+  } else
+   tf->device |= (block >> 24) & 0xf;
+
+  tf->nsect = n_block & 0xff;
 
- tf->nsect = n_sect & 0xff;
+  tf->lbah = (block >> 16) & 0xff;
+  tf->lbam = (block >> 8) & 0xff;
+  tf->lbal = block & 0xff;
 
- tf->hob_lbah = (sect >> 16) & 0xff;
- tf->hob_lbam = (sect >> 8) & 0xff;
- tf->hob_lbal = sect & 0xff;
+  tf->device |= ATA_LBA;
+ } else {
+  /* CHS */
+  u32 sect, head, cyl, track;
+
+  /* Convert LBA to CHS */
+  track = (u32)block / dev->sectors;
+  cyl   = track / dev->heads;
+  head  = track % dev->heads;
+  sect  = (u32)block % dev->sectors + 1;
+
+  DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", (u32)block, track, cyl, head, sect);
+  
+  /* Check whether the converted CHS can fit. 
+     Cylinder: 0-65535 
+     Head: 0-15
+     Sector: 1-255*/
+  if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) 
+   return 1;
+  
+  tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
+  tf->lbal = sect;
+  tf->lbam = cyl;
+  tf->lbah = cyl >> 8;
+  tf->device |= head;
+ }
 
  return 0;
 }
@@ -782,11 +811,14 @@
 static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
  struct ata_taskfile *tf = &qc->tf;
+ struct ata_device *dev = qc->dev;
+ unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
  unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+ u64 block = 0;
+ u32 n_block = 0;
 
  tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
  tf->protocol = qc->dev->xfer_protocol;
- tf->device |= ATA_LBA;
 
  if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
      scsicmd[0] == READ_16) {
@@ -796,80 +828,111 @@
   tf->flags |= ATA_TFLAG_WRITE;
  }
 
+ /* Calculate the SCSI LBA and transfer length. */
  if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
-  if (lba48) {
-   tf->hob_nsect = scsicmd[7];
-   tf->hob_lbal = scsicmd[2];
+  block |= ((u64)scsicmd[2]) << 24;
+  block |= ((u64)scsicmd[3]) << 16;
+  block |= ((u64)scsicmd[4]) << 8;
+  block |= ((u64)scsicmd[5]);
 
-   qc->nsect = ((unsigned int)scsicmd[7] << 8) |
-     scsicmd[8];
-  } else {
-   /* if we don't support LBA48 addressing, the request
-    * -may- be too large. */
-   if ((scsicmd[2] & 0xf0) || scsicmd[7])
-    return 1;
-
-   /* stores LBA27:24 in lower 4 bits of device reg */
-   tf->device |= scsicmd[2];
-
-   qc->nsect = scsicmd[8];
-  }
-
-  tf->nsect = scsicmd[8];
-  tf->lbal = scsicmd[5];
-  tf->lbam = scsicmd[4];
-  tf->lbah = scsicmd[3];
+  n_block |= ((u32)scsicmd[7]) << 8;
+  n_block |= ((u32)scsicmd[8]);
 
   VPRINTK("ten-byte command\n");
-  return 0;
- }
-
- if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
-  qc->nsect = tf->nsect = scsicmd[4];
-  tf->lbal = scsicmd[3];
-  tf->lbam = scsicmd[2];
-  tf->lbah = scsicmd[1] & 0x1f; /* mask out reserved bits */
-
+ } else if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
+  block |= ((u64)scsicmd[2]) << 8;
+  block |= ((u64)scsicmd[3]);
+  n_block |= ((u32)scsicmd[4]);
+ 
   VPRINTK("six-byte command\n");
-  return 0;
+ } else if (scsicmd[0] == READ_16 || scsicmd[0] == WRITE_16) {
+  block |= ((u64)scsicmd[2]) << 56;
+  block |= ((u64)scsicmd[3]) << 48;
+  block |= ((u64)scsicmd[4]) << 40;
+  block |= ((u64)scsicmd[5]) << 32;
+  block |= ((u64)scsicmd[6]) << 24;
+  block |= ((u64)scsicmd[7]) << 16;
+  block |= ((u64)scsicmd[8]) << 8;
+  block |= ((u64)scsicmd[9]);
+
+  n_block |= ((u32)scsicmd[10]) << 24;
+  n_block |= ((u32)scsicmd[11]) << 16;
+  n_block |= ((u32)scsicmd[12]) << 8;
+  n_block |= ((u32)scsicmd[13]);
+
+  VPRINTK("sixteen-byte command\n");
+ } else {
+  DPRINTK("no-byte command\n");
+  return 1;
  }
 
- if (scsicmd[0] == READ_16 || scsicmd[0] == WRITE_16) {
-  /* rule out impossible LBAs and sector counts */
-  if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])
-   return 1;
+ /* Check and compose ATA command */
+ if (!n_block)
+  /* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */
+  return 1;
 
+ if (lba) {
   if (lba48) {
-   tf->hob_nsect = scsicmd[12];
-   tf->hob_lbal = scsicmd[6];
-   tf->hob_lbam = scsicmd[5];
-   tf->hob_lbah = scsicmd[4];
-
-   qc->nsect = ((unsigned int)scsicmd[12] << 8) |
-     scsicmd[13];
-  } else {
-   /* once again, filter out impossible non-zero values */
-   if (scsicmd[4] || scsicmd[5] || scsicmd[12] ||
-       (scsicmd[6] & 0xf0))
+   /* The request -may- be too large for LBA48. */
+   if ((block >> 48) || (n_block > 65536))
     return 1;
 
-   /* stores LBA27:24 in lower 4 bits of device reg */
-   tf->device |= scsicmd[2];
+   tf->hob_nsect = (n_block >> 8) & 0xff;
+
+   tf->hob_lbah = (block >> 40) & 0xff;
+   tf->hob_lbam = (block >> 32) & 0xff;
+   tf->hob_lbal = (block >> 24) & 0xff;
+  } else { 
+   /* LBA28 */
 
-   qc->nsect = scsicmd[13];
+   /* The request -may- be too large for LBA28. */
+   if ((block >> 28) || (n_block > 256))
+    return 1;
+
+   tf->device |= (block >> 24) & 0xf;
   }
 
-  tf->nsect = scsicmd[13];
-  tf->lbal = scsicmd[9];
-  tf->lbam = scsicmd[8];
-  tf->lbah = scsicmd[7];
+  qc->nsect = n_block;
+  tf->nsect = n_block & 0xff;
 
-  VPRINTK("sixteen-byte command\n");
-  return 0;
+  tf->lbah = (block >> 16) & 0xff;
+  tf->lbam = (block >> 8) & 0xff;
+  tf->lbal = block & 0xff;
+
+  tf->device |= ATA_LBA;
+ } else { 
+  /* CHS */
+  u32 sect, head, cyl, track;
+
+  /* The request -may- be too large for CHS addressing. */
+  if ((block >> 28) || (n_block > 256))
+   return 1;
+   
+  /* Convert LBA to CHS */
+  track = (u32)block / dev->sectors;
+  cyl   = track / dev->heads;
+  head  = track % dev->heads;
+  sect  = (u32)block % dev->sectors + 1;
+
+  DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", 
+   (u32)block, track, cyl, head, sect);
+  
+  /* Check whether the converted CHS can fit. 
+     Cylinder: 0-65535 
+     Head: 0-15
+     Sector: 1-255*/
+  if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) 
+   return 1;
+  
+  qc->nsect = n_block;
+  tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
+  tf->lbal = sect;
+  tf->lbam = cyl;
+  tf->lbah = cyl >> 8;
+  tf->device |= head;
  }
 
- DPRINTK("no-byte command\n");
- return 1;
+ return 0;
 }
 
 static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)
@@ -1422,10 +1485,20 @@
 
  VPRINTK("ENTER\n");
 
- if (ata_id_has_lba48(args->id))
-  n_sectors = ata_id_u64(args->id, 100);
- else
-  n_sectors = ata_id_u32(args->id, 60);
+ if (ata_id_has_lba(args->id)) {
+  if (ata_id_has_lba48(args->id))
+   n_sectors = ata_id_u64(args->id, 100);
+  else
+   n_sectors = ata_id_u32(args->id, 60);
+ } else {
+  /* CHS default translation */
+  n_sectors = args->id[1] * args->id[3] * args->id[6];
+
+  if (ata_id_current_chs_valid(args->id))
+   /* CHS current translation */
+   n_sectors = ata_id_u32(args->id, 57);
+ }
+
  n_sectors--;  /* ATA TotalUserSectors - 1 */
 
  tmp = n_sectors; /* note: truncates, if lba48 */

------=_NextPart_000_00A4_01C50C55.4E50D180
Content-Type: application/octet-stream;
	name="chs3.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="chs3.diff"

--- libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-02-05 =
10:41:49.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c	2005-02-05 =
12:46:26.000000000 +0800=0A=
@@ -689,72 +689,101 @@=0A=
 static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, u8 =
*scsicmd)=0A=
 {=0A=
 	struct ata_taskfile *tf =3D &qc->tf;=0A=
+	struct ata_device *dev =3D qc->dev;=0A=
+	unsigned int lba   =3D tf->flags & ATA_TFLAG_LBA;=0A=
 	unsigned int lba48 =3D tf->flags & ATA_TFLAG_LBA48;=0A=
 	u64 dev_sectors =3D qc->dev->n_sectors;=0A=
-	u64 sect =3D 0;=0A=
-	u32 n_sect =3D 0;=0A=
+	u64 block =3D 0;=0A=
+	u32 n_block =3D 0;=0A=
 =0A=
 	tf->flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;=0A=
 	tf->protocol =3D ATA_PROT_NODATA;=0A=
-	tf->device |=3D ATA_LBA;=0A=
 =0A=
 	if (scsicmd[0] =3D=3D VERIFY) {=0A=
-		sect |=3D ((u64)scsicmd[2]) << 24;=0A=
-		sect |=3D ((u64)scsicmd[3]) << 16;=0A=
-		sect |=3D ((u64)scsicmd[4]) << 8;=0A=
-		sect |=3D ((u64)scsicmd[5]);=0A=
+		block |=3D ((u64)scsicmd[2]) << 24;=0A=
+		block |=3D ((u64)scsicmd[3]) << 16;=0A=
+		block |=3D ((u64)scsicmd[4]) << 8;=0A=
+		block |=3D ((u64)scsicmd[5]);=0A=
 =0A=
-		n_sect |=3D ((u32)scsicmd[7]) << 8;=0A=
-		n_sect |=3D ((u32)scsicmd[8]);=0A=
+		n_block |=3D ((u32)scsicmd[7]) << 8;=0A=
+		n_block |=3D ((u32)scsicmd[8]);=0A=
 	}=0A=
 =0A=
 	else if (scsicmd[0] =3D=3D VERIFY_16) {=0A=
-		sect |=3D ((u64)scsicmd[2]) << 56;=0A=
-		sect |=3D ((u64)scsicmd[3]) << 48;=0A=
-		sect |=3D ((u64)scsicmd[4]) << 40;=0A=
-		sect |=3D ((u64)scsicmd[5]) << 32;=0A=
-		sect |=3D ((u64)scsicmd[6]) << 24;=0A=
-		sect |=3D ((u64)scsicmd[7]) << 16;=0A=
-		sect |=3D ((u64)scsicmd[8]) << 8;=0A=
-		sect |=3D ((u64)scsicmd[9]);=0A=
-=0A=
-		n_sect |=3D ((u32)scsicmd[10]) << 24;=0A=
-		n_sect |=3D ((u32)scsicmd[11]) << 16;=0A=
-		n_sect |=3D ((u32)scsicmd[12]) << 8;=0A=
-		n_sect |=3D ((u32)scsicmd[13]);=0A=
+		block |=3D ((u64)scsicmd[2]) << 56;=0A=
+		block |=3D ((u64)scsicmd[3]) << 48;=0A=
+		block |=3D ((u64)scsicmd[4]) << 40;=0A=
+		block |=3D ((u64)scsicmd[5]) << 32;=0A=
+		block |=3D ((u64)scsicmd[6]) << 24;=0A=
+		block |=3D ((u64)scsicmd[7]) << 16;=0A=
+		block |=3D ((u64)scsicmd[8]) << 8;=0A=
+		block |=3D ((u64)scsicmd[9]);=0A=
+=0A=
+		n_block |=3D ((u32)scsicmd[10]) << 24;=0A=
+		n_block |=3D ((u32)scsicmd[11]) << 16;=0A=
+		n_block |=3D ((u32)scsicmd[12]) << 8;=0A=
+		n_block |=3D ((u32)scsicmd[13]);=0A=
 	}=0A=
 =0A=
 	else=0A=
 		return 1;=0A=
 =0A=
-	if (!n_sect)=0A=
+	if (!n_block)=0A=
 		return 1;=0A=
-	if (sect >=3D dev_sectors)=0A=
+	if (block >=3D dev_sectors)=0A=
 		return 1;=0A=
-	if ((sect + n_sect) > dev_sectors)=0A=
+	if ((block + n_block) > dev_sectors)=0A=
 		return 1;=0A=
 	if (lba48) {=0A=
-		if (n_sect > (64 * 1024))=0A=
+		if (n_block > (64 * 1024))=0A=
 			return 1;=0A=
 	} else {=0A=
-		if (n_sect > 256)=0A=
+		if (n_block > 256)=0A=
 			return 1;=0A=
 	}=0A=
 =0A=
-	if (lba48) {=0A=
-		tf->hob_nsect =3D (n_sect >> 8) & 0xff;=0A=
+	if (lba) {=0A=
+		if (lba48) {=0A=
+			tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
 =0A=
-		tf->hob_lbah =3D (sect >> 40) & 0xff;=0A=
-		tf->hob_lbam =3D (sect >> 32) & 0xff;=0A=
-		tf->hob_lbal =3D (sect >> 24) & 0xff;=0A=
-	} else=0A=
-		tf->device |=3D (sect >> 24) & 0xf;=0A=
+			tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
+			tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
+			tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
+		} else=0A=
+			tf->device |=3D (block >> 24) & 0xf;=0A=
+=0A=
+		tf->nsect =3D n_block & 0xff;=0A=
 =0A=
-	tf->nsect =3D n_sect & 0xff;=0A=
+		tf->lbah =3D (block >> 16) & 0xff;=0A=
+		tf->lbam =3D (block >> 8) & 0xff;=0A=
+		tf->lbal =3D block & 0xff;=0A=
 =0A=
-	tf->hob_lbah =3D (sect >> 16) & 0xff;=0A=
-	tf->hob_lbam =3D (sect >> 8) & 0xff;=0A=
-	tf->hob_lbal =3D sect & 0xff;=0A=
+		tf->device |=3D ATA_LBA;=0A=
+	} else {=0A=
+		/* CHS */=0A=
+		u32 sect, head, cyl, track;=0A=
+=0A=
+		/* Convert LBA to CHS */=0A=
+		track =3D (u32)block / dev->sectors;=0A=
+		cyl   =3D track / dev->heads;=0A=
+		head  =3D track % dev->heads;=0A=
+		sect  =3D (u32)block % dev->sectors + 1;=0A=
+=0A=
+		DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", =
(u32)block, track, cyl, head, sect);=0A=
+		=0A=
+		/* Check whether the converted CHS can fit. =0A=
+		   Cylinder: 0-65535 =0A=
+		   Head: 0-15=0A=
+		   Sector: 1-255*/=0A=
+		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) =0A=
+			return 1;=0A=
+		=0A=
+		tf->nsect =3D n_block & 0xff; /* Sector count 0 means 256 sectors */=0A=
+		tf->lbal =3D sect;=0A=
+		tf->lbam =3D cyl;=0A=
+		tf->lbah =3D cyl >> 8;=0A=
+		tf->device |=3D head;=0A=
+	}=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -782,11 +811,14 @@=0A=
 static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, u8 =
*scsicmd)=0A=
 {=0A=
 	struct ata_taskfile *tf =3D &qc->tf;=0A=
+	struct ata_device *dev =3D qc->dev;=0A=
+	unsigned int lba   =3D tf->flags & ATA_TFLAG_LBA;=0A=
 	unsigned int lba48 =3D tf->flags & ATA_TFLAG_LBA48;=0A=
+	u64 block =3D 0;=0A=
+	u32 n_block =3D 0;=0A=
 =0A=
 	tf->flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;=0A=
 	tf->protocol =3D qc->dev->xfer_protocol;=0A=
-	tf->device |=3D ATA_LBA;=0A=
 =0A=
 	if (scsicmd[0] =3D=3D READ_10 || scsicmd[0] =3D=3D READ_6 ||=0A=
 	    scsicmd[0] =3D=3D READ_16) {=0A=
@@ -796,80 +828,111 @@=0A=
 		tf->flags |=3D ATA_TFLAG_WRITE;=0A=
 	}=0A=
 =0A=
+	/* Calculate the SCSI LBA and transfer length. */=0A=
 	if (scsicmd[0] =3D=3D READ_10 || scsicmd[0] =3D=3D WRITE_10) {=0A=
-		if (lba48) {=0A=
-			tf->hob_nsect =3D scsicmd[7];=0A=
-			tf->hob_lbal =3D scsicmd[2];=0A=
+		block |=3D ((u64)scsicmd[2]) << 24;=0A=
+		block |=3D ((u64)scsicmd[3]) << 16;=0A=
+		block |=3D ((u64)scsicmd[4]) << 8;=0A=
+		block |=3D ((u64)scsicmd[5]);=0A=
 =0A=
-			qc->nsect =3D ((unsigned int)scsicmd[7] << 8) |=0A=
-					scsicmd[8];=0A=
-		} else {=0A=
-			/* if we don't support LBA48 addressing, the request=0A=
-			 * -may- be too large. */=0A=
-			if ((scsicmd[2] & 0xf0) || scsicmd[7])=0A=
-				return 1;=0A=
-=0A=
-			/* stores LBA27:24 in lower 4 bits of device reg */=0A=
-			tf->device |=3D scsicmd[2];=0A=
-=0A=
-			qc->nsect =3D scsicmd[8];=0A=
-		}=0A=
-=0A=
-		tf->nsect =3D scsicmd[8];=0A=
-		tf->lbal =3D scsicmd[5];=0A=
-		tf->lbam =3D scsicmd[4];=0A=
-		tf->lbah =3D scsicmd[3];=0A=
+		n_block |=3D ((u32)scsicmd[7]) << 8;=0A=
+		n_block |=3D ((u32)scsicmd[8]);=0A=
 =0A=
 		VPRINTK("ten-byte command\n");=0A=
-		return 0;=0A=
-	}=0A=
-=0A=
-	if (scsicmd[0] =3D=3D READ_6 || scsicmd[0] =3D=3D WRITE_6) {=0A=
-		qc->nsect =3D tf->nsect =3D scsicmd[4];=0A=
-		tf->lbal =3D scsicmd[3];=0A=
-		tf->lbam =3D scsicmd[2];=0A=
-		tf->lbah =3D scsicmd[1] & 0x1f; /* mask out reserved bits */=0A=
-=0A=
+	} else if (scsicmd[0] =3D=3D READ_6 || scsicmd[0] =3D=3D WRITE_6) {=0A=
+		block |=3D ((u64)scsicmd[2]) << 8;=0A=
+		block |=3D ((u64)scsicmd[3]);=0A=
+		n_block |=3D ((u32)scsicmd[4]);=0A=
+	=0A=
 		VPRINTK("six-byte command\n");=0A=
-		return 0;=0A=
+	} else if (scsicmd[0] =3D=3D READ_16 || scsicmd[0] =3D=3D WRITE_16) {=0A=
+		block |=3D ((u64)scsicmd[2]) << 56;=0A=
+		block |=3D ((u64)scsicmd[3]) << 48;=0A=
+		block |=3D ((u64)scsicmd[4]) << 40;=0A=
+		block |=3D ((u64)scsicmd[5]) << 32;=0A=
+		block |=3D ((u64)scsicmd[6]) << 24;=0A=
+		block |=3D ((u64)scsicmd[7]) << 16;=0A=
+		block |=3D ((u64)scsicmd[8]) << 8;=0A=
+		block |=3D ((u64)scsicmd[9]);=0A=
+=0A=
+		n_block |=3D ((u32)scsicmd[10]) << 24;=0A=
+		n_block |=3D ((u32)scsicmd[11]) << 16;=0A=
+		n_block |=3D ((u32)scsicmd[12]) << 8;=0A=
+		n_block |=3D ((u32)scsicmd[13]);=0A=
+=0A=
+		VPRINTK("sixteen-byte command\n");=0A=
+	} else {=0A=
+		DPRINTK("no-byte command\n");=0A=
+		return 1;=0A=
 	}=0A=
 =0A=
-	if (scsicmd[0] =3D=3D READ_16 || scsicmd[0] =3D=3D WRITE_16) {=0A=
-		/* rule out impossible LBAs and sector counts */=0A=
-		if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])=0A=
-			return 1;=0A=
+	/* Check and compose ATA command */=0A=
+	if (!n_block)=0A=
+		/* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */=0A=
+		return 1;=0A=
 =0A=
+	if (lba) {=0A=
 		if (lba48) {=0A=
-			tf->hob_nsect =3D scsicmd[12];=0A=
-			tf->hob_lbal =3D scsicmd[6];=0A=
-			tf->hob_lbam =3D scsicmd[5];=0A=
-			tf->hob_lbah =3D scsicmd[4];=0A=
-=0A=
-			qc->nsect =3D ((unsigned int)scsicmd[12] << 8) |=0A=
-					scsicmd[13];=0A=
-		} else {=0A=
-			/* once again, filter out impossible non-zero values */=0A=
-			if (scsicmd[4] || scsicmd[5] || scsicmd[12] ||=0A=
-			    (scsicmd[6] & 0xf0))=0A=
+			/* The request -may- be too large for LBA48. */=0A=
+			if ((block >> 48) || (n_block > 65536))=0A=
 				return 1;=0A=
 =0A=
-			/* stores LBA27:24 in lower 4 bits of device reg */=0A=
-			tf->device |=3D scsicmd[2];=0A=
+			tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
+=0A=
+			tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
+			tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
+			tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
+		} else { =0A=
+			/* LBA28 */=0A=
 =0A=
-			qc->nsect =3D scsicmd[13];=0A=
+			/* The request -may- be too large for LBA28. */=0A=
+			if ((block >> 28) || (n_block > 256))=0A=
+				return 1;=0A=
+=0A=
+			tf->device |=3D (block >> 24) & 0xf;=0A=
 		}=0A=
 =0A=
-		tf->nsect =3D scsicmd[13];=0A=
-		tf->lbal =3D scsicmd[9];=0A=
-		tf->lbam =3D scsicmd[8];=0A=
-		tf->lbah =3D scsicmd[7];=0A=
+		qc->nsect =3D n_block;=0A=
+		tf->nsect =3D n_block & 0xff;=0A=
 =0A=
-		VPRINTK("sixteen-byte command\n");=0A=
-		return 0;=0A=
+		tf->lbah =3D (block >> 16) & 0xff;=0A=
+		tf->lbam =3D (block >> 8) & 0xff;=0A=
+		tf->lbal =3D block & 0xff;=0A=
+=0A=
+		tf->device |=3D ATA_LBA;=0A=
+	} else { =0A=
+		/* CHS */=0A=
+		u32 sect, head, cyl, track;=0A=
+=0A=
+		/* The request -may- be too large for CHS addressing. */=0A=
+		if ((block >> 28) || (n_block > 256))=0A=
+			return 1;=0A=
+			=0A=
+		/* Convert LBA to CHS */=0A=
+		track =3D (u32)block / dev->sectors;=0A=
+		cyl   =3D track / dev->heads;=0A=
+		head  =3D track % dev->heads;=0A=
+		sect  =3D (u32)block % dev->sectors + 1;=0A=
+=0A=
+		DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", =0A=
+			(u32)block, track, cyl, head, sect);=0A=
+		=0A=
+		/* Check whether the converted CHS can fit. =0A=
+		   Cylinder: 0-65535 =0A=
+		   Head: 0-15=0A=
+		   Sector: 1-255*/=0A=
+		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) =0A=
+			return 1;=0A=
+		=0A=
+		qc->nsect =3D n_block;=0A=
+		tf->nsect =3D n_block & 0xff; /* Sector count 0 means 256 sectors */=0A=
+		tf->lbal =3D sect;=0A=
+		tf->lbam =3D cyl;=0A=
+		tf->lbah =3D cyl >> 8;=0A=
+		tf->device |=3D head;=0A=
 	}=0A=
 =0A=
-	DPRINTK("no-byte command\n");=0A=
-	return 1;=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)=0A=
@@ -1422,10 +1485,20 @@=0A=
 =0A=
 	VPRINTK("ENTER\n");=0A=
 =0A=
-	if (ata_id_has_lba48(args->id))=0A=
-		n_sectors =3D ata_id_u64(args->id, 100);=0A=
-	else=0A=
-		n_sectors =3D ata_id_u32(args->id, 60);=0A=
+	if (ata_id_has_lba(args->id)) {=0A=
+		if (ata_id_has_lba48(args->id))=0A=
+			n_sectors =3D ata_id_u64(args->id, 100);=0A=
+		else=0A=
+			n_sectors =3D ata_id_u32(args->id, 60);=0A=
+	} else {=0A=
+		/* CHS default translation */=0A=
+		n_sectors =3D args->id[1] * args->id[3] * args->id[6];=0A=
+=0A=
+		if (ata_id_current_chs_valid(args->id))=0A=
+			/* CHS current translation */=0A=
+			n_sectors =3D ata_id_u32(args->id, 57);=0A=
+	}=0A=
+=0A=
 	n_sectors--;		/* ATA TotalUserSectors - 1 */=0A=
 =0A=
 	tmp =3D n_sectors;	/* note: truncates, if lba48 */=0A=

------=_NextPart_000_00A4_01C50C55.4E50D180--


