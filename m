From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6 1/3] Add CHS support
Date: Mon, 14 Feb 2005 19:23:50 +0800
Message-ID: <00a101c51287$ac4c65a0$6401a8c0@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <4205B886.4070005@pobox.com> <007f01c51285$a3612450$6401a8c0@tw.ibm.com> <008e01c51286$d2f8b740$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_009E_01C512CA.B680B830"
Received: from bluehawaii.tikira.net ([61.62.22.51]:38898 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261414AbVBNLY2 (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Feb 2005 06:24:28 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, "Mudama, Eric" <eric_mudama@Maxtor.com>, Mark Lord <mlord@pobox.com>

This is a multi-part message in MIME format.

------=_NextPart_000_009E_01C512CA.B680B830
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

> 2) Patch #3 needs to be split up into three patches:
>   a) rename variables (s/sector/block/),
>   b) reorganize read/write translation
>   c) add CHS support
> 

Patch 3-3: 
 - add CHS support to ata_scsi_verify_xlat(), ata_scsi_rw_xlat() and ata_scsiop_read_cap().

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
------------------------------------------------------------------
--- libata-dev-2.6/drivers/scsi/libata-scsi.c 2005-02-14 17:18:22.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c 2005-02-14 17:25:43.000000000 +0800
@@ -689,6 +689,8 @@
 static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
  struct ata_taskfile *tf = &qc->tf;
+ struct ata_device *dev = qc->dev;
+ unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
  unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
  u64 dev_sectors = qc->dev->n_sectors;
  u64 block = 0;
@@ -696,7 +698,6 @@
 
  tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
  tf->protocol = ATA_PROT_NODATA;
- tf->device |= ATA_LBA;
 
  if (scsicmd[0] == VERIFY) {
   block |= ((u64)scsicmd[2]) << 24;
@@ -741,25 +742,53 @@
    return 1;
  }
 
- if (lba48) {
-  tf->command = ATA_CMD_VERIFY_EXT;
+ if (lba) {
+  if (lba48) {
+   tf->command = ATA_CMD_VERIFY_EXT;
+
+   tf->hob_nsect = (n_block >> 8) & 0xff;
+
+   tf->hob_lbah = (block >> 40) & 0xff;
+   tf->hob_lbam = (block >> 32) & 0xff;
+   tf->hob_lbal = (block >> 24) & 0xff;
+  } else {
+   tf->command = ATA_CMD_VERIFY;
 
-  tf->hob_nsect = (n_block >> 8) & 0xff;
+   tf->device |= (block >> 24) & 0xf;
+  }
 
-  tf->hob_lbah = (block >> 40) & 0xff;
-  tf->hob_lbam = (block >> 32) & 0xff;
-  tf->hob_lbal = (block >> 24) & 0xff;
- } else {
-  tf->command = ATA_CMD_VERIFY;
+  tf->nsect = n_block & 0xff;
 
-  tf->device |= (block >> 24) & 0xf;
- }
+  tf->lbah = (block >> 16) & 0xff;
+  tf->lbam = (block >> 8) & 0xff;
+  tf->lbal = block & 0xff;
 
- tf->nsect = n_block & 0xff;
+  tf->device |= ATA_LBA;
+ } else {
+  /* CHS */
+  u32 sect, head, cyl, track;
 
- tf->lbah = (block >> 16) & 0xff;
- tf->lbam = (block >> 8) & 0xff;
- tf->lbal = block & 0xff;
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
@@ -787,6 +816,8 @@
 static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, u8 *scsicmd)
 {
  struct ata_taskfile *tf = &qc->tf;
+ struct ata_device *dev = qc->dev;
+ unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
  unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
  u64 block = 0;
  u32 n_block = 0;
@@ -845,34 +876,66 @@
   /* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */
   return 1;
 
- if (lba48) {
-  /* The request -may- be too large for LBA48. */
-  if ((block >> 48) || (n_block > 65536))
-   return 1;
+ if (lba) {
+  if (lba48) {
+   /* The request -may- be too large for LBA48. */
+   if ((block >> 48) || (n_block > 65536))
+    return 1;
+
+   tf->hob_nsect = (n_block >> 8) & 0xff;
+
+   tf->hob_lbah = (block >> 40) & 0xff;
+   tf->hob_lbam = (block >> 32) & 0xff;
+   tf->hob_lbal = (block >> 24) & 0xff;
+  } else { 
+   /* LBA28 */
+
+   /* The request -may- be too large for LBA28. */
+   if ((block >> 28) || (n_block > 256))
+    return 1;
+
+   tf->device |= (block >> 24) & 0xf;
+  }
+ 
+  qc->nsect = n_block;
+  tf->nsect = n_block & 0xff;
 
-  tf->hob_nsect = (n_block >> 8) & 0xff;
+  tf->lbah = (block >> 16) & 0xff;
+  tf->lbam = (block >> 8) & 0xff;
+  tf->lbal = block & 0xff;
 
-  tf->hob_lbah = (block >> 40) & 0xff;
-  tf->hob_lbam = (block >> 32) & 0xff;
-  tf->hob_lbal = (block >> 24) & 0xff;
+  tf->device |= ATA_LBA;
  } else { 
-  /* LBA28 */
+  /* CHS */
+  u32 sect, head, cyl, track;
 
-  /* The request -may- be too large for LBA28. */
+  /* The request -may- be too large for CHS addressing. */
   if ((block >> 28) || (n_block > 256))
    return 1;
-
-  tf->device |= (block >> 24) & 0xf;
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
- 
- qc->nsect = n_block;
- tf->nsect = n_block & 0xff;
-
- tf->lbah = (block >> 16) & 0xff;
- tf->lbam = (block >> 8) & 0xff;
- tf->lbal = block & 0xff;
-
- tf->device |= ATA_LBA;
 
  return 0;
 }
@@ -1427,10 +1490,20 @@
 
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

------=_NextPart_000_009E_01C512CA.B680B830
Content-Type: application/octet-stream;
	name="chs3-3.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="chs3-3.diff"

--- libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-02-14 =
17:18:22.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c	2005-02-14 =
17:25:43.000000000 +0800=0A=
@@ -689,6 +689,8 @@=0A=
 static unsigned int ata_scsi_verify_xlat(struct ata_queued_cmd *qc, u8 =
*scsicmd)=0A=
 {=0A=
 	struct ata_taskfile *tf =3D &qc->tf;=0A=
+	struct ata_device *dev =3D qc->dev;=0A=
+	unsigned int lba   =3D tf->flags & ATA_TFLAG_LBA;=0A=
 	unsigned int lba48 =3D tf->flags & ATA_TFLAG_LBA48;=0A=
 	u64 dev_sectors =3D qc->dev->n_sectors;=0A=
 	u64 block =3D 0;=0A=
@@ -696,7 +698,6 @@=0A=
 =0A=
 	tf->flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;=0A=
 	tf->protocol =3D ATA_PROT_NODATA;=0A=
-	tf->device |=3D ATA_LBA;=0A=
 =0A=
 	if (scsicmd[0] =3D=3D VERIFY) {=0A=
 		block |=3D ((u64)scsicmd[2]) << 24;=0A=
@@ -741,25 +742,53 @@=0A=
 			return 1;=0A=
 	}=0A=
 =0A=
-	if (lba48) {=0A=
-		tf->command =3D ATA_CMD_VERIFY_EXT;=0A=
+	if (lba) {=0A=
+		if (lba48) {=0A=
+			tf->command =3D ATA_CMD_VERIFY_EXT;=0A=
+=0A=
+			tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
+=0A=
+			tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
+			tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
+			tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
+		} else {=0A=
+			tf->command =3D ATA_CMD_VERIFY;=0A=
 =0A=
-		tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
+			tf->device |=3D (block >> 24) & 0xf;=0A=
+		}=0A=
 =0A=
-		tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
-		tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
-		tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
-	} else {=0A=
-		tf->command =3D ATA_CMD_VERIFY;=0A=
+		tf->nsect =3D n_block & 0xff;=0A=
 =0A=
-		tf->device |=3D (block >> 24) & 0xf;=0A=
-	}=0A=
+		tf->lbah =3D (block >> 16) & 0xff;=0A=
+		tf->lbam =3D (block >> 8) & 0xff;=0A=
+		tf->lbal =3D block & 0xff;=0A=
 =0A=
-	tf->nsect =3D n_block & 0xff;=0A=
+		tf->device |=3D ATA_LBA;=0A=
+	} else {=0A=
+		/* CHS */=0A=
+		u32 sect, head, cyl, track;=0A=
 =0A=
-	tf->lbah =3D (block >> 16) & 0xff;=0A=
-	tf->lbam =3D (block >> 8) & 0xff;=0A=
-	tf->lbal =3D block & 0xff;=0A=
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
@@ -787,6 +816,8 @@=0A=
 static unsigned int ata_scsi_rw_xlat(struct ata_queued_cmd *qc, u8 =
*scsicmd)=0A=
 {=0A=
 	struct ata_taskfile *tf =3D &qc->tf;=0A=
+	struct ata_device *dev =3D qc->dev;=0A=
+	unsigned int lba   =3D tf->flags & ATA_TFLAG_LBA;=0A=
 	unsigned int lba48 =3D tf->flags & ATA_TFLAG_LBA48;=0A=
 	u64 block =3D 0;=0A=
 	u32 n_block =3D 0;=0A=
@@ -845,34 +876,66 @@=0A=
 		/* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */=0A=
 		return 1;=0A=
 =0A=
-	if (lba48) {=0A=
-		/* The request -may- be too large for LBA48. */=0A=
-		if ((block >> 48) || (n_block > 65536))=0A=
-			return 1;=0A=
+	if (lba) {=0A=
+		if (lba48) {=0A=
+			/* The request -may- be too large for LBA48. */=0A=
+			if ((block >> 48) || (n_block > 65536))=0A=
+				return 1;=0A=
+=0A=
+			tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
+=0A=
+			tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
+			tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
+			tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
+		} else { =0A=
+			/* LBA28 */=0A=
+=0A=
+			/* The request -may- be too large for LBA28. */=0A=
+			if ((block >> 28) || (n_block > 256))=0A=
+				return 1;=0A=
+=0A=
+			tf->device |=3D (block >> 24) & 0xf;=0A=
+		}=0A=
+	=0A=
+		qc->nsect =3D n_block;=0A=
+		tf->nsect =3D n_block & 0xff;=0A=
 =0A=
-		tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
+		tf->lbah =3D (block >> 16) & 0xff;=0A=
+		tf->lbam =3D (block >> 8) & 0xff;=0A=
+		tf->lbal =3D block & 0xff;=0A=
 =0A=
-		tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
-		tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
-		tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
+		tf->device |=3D ATA_LBA;=0A=
 	} else { =0A=
-		/* LBA28 */=0A=
+		/* CHS */=0A=
+		u32 sect, head, cyl, track;=0A=
 =0A=
-		/* The request -may- be too large for LBA28. */=0A=
+		/* The request -may- be too large for CHS addressing. */=0A=
 		if ((block >> 28) || (n_block > 256))=0A=
 			return 1;=0A=
-=0A=
-		tf->device |=3D (block >> 24) & 0xf;=0A=
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
-	=0A=
-	qc->nsect =3D n_block;=0A=
-	tf->nsect =3D n_block & 0xff;=0A=
-=0A=
-	tf->lbah =3D (block >> 16) & 0xff;=0A=
-	tf->lbam =3D (block >> 8) & 0xff;=0A=
-	tf->lbal =3D block & 0xff;=0A=
-=0A=
-	tf->device |=3D ATA_LBA;=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -1427,10 +1490,20 @@=0A=
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

------=_NextPart_000_009E_01C512CA.B680B830--


