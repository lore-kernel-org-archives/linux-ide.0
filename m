From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6 1/3] Add CHS support
Date: Mon, 14 Feb 2005 19:17:43 +0800
Message-ID: <008e01c51286$d2f8b740$6401a8c0@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <4205B886.4070005@pobox.com> <007f01c51285$a3612450$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_008B_01C512C9.DBFFD470"
Received: from bluehawaii.tikira.net ([61.62.22.51]:39408 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261392AbVBNLSV (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Feb 2005 06:18:21 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, "Mudama, Eric" <eric_mudama@Maxtor.com>, Mark Lord <mlord@pobox.com>

This is a multi-part message in MIME format.

------=_NextPart_000_008B_01C512C9.DBFFD470
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit


> 2) Patch #3 needs to be split up into three patches:
>   a) rename variables (s/sector/block/),
>   b) reorganize read/write translation
>   c) add CHS support
> 

Patch 3-2: 
 - reorganize read/write translation in ata_scsi_rw_xlat()

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
------------------------------------------------------------------
--- libata-dev-2.6/drivers/scsi/libata-scsi.c 2005-02-14 16:54:47.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c 2005-02-14 17:05:12.000000000 +0800
@@ -788,10 +788,11 @@
 {
  struct ata_taskfile *tf = &qc->tf;
  unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
+ u64 block = 0;
+ u32 n_block = 0;
 
  tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
  tf->protocol = qc->dev->xfer_protocol;
- tf->device |= ATA_LBA;
 
  if (scsicmd[0] == READ_10 || scsicmd[0] == READ_6 ||
      scsicmd[0] == READ_16) {
@@ -801,80 +802,79 @@
   tf->flags |= ATA_TFLAG_WRITE;
  }
 
+ /* Calculate the SCSI LBA and transfer length. */
  if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
-  if (lba48) {
-   tf->hob_nsect = scsicmd[7];
-   tf->hob_lbal = scsicmd[2];
-
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
+  block |= ((u64)scsicmd[2]) << 24;
+  block |= ((u64)scsicmd[3]) << 16;
+  block |= ((u64)scsicmd[4]) << 8;
+  block |= ((u64)scsicmd[5]);
 
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
- }
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
 
- if (scsicmd[0] == READ_16 || scsicmd[0] == WRITE_16) {
-  /* rule out impossible LBAs and sector counts */
-  if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])
-   return 1;
+  VPRINTK("sixteen-byte command\n");
+ } else {
+  DPRINTK("no-byte command\n");
+  return 1;
+ }
 
-  if (lba48) {
-   tf->hob_nsect = scsicmd[12];
-   tf->hob_lbal = scsicmd[6];
-   tf->hob_lbam = scsicmd[5];
-   tf->hob_lbah = scsicmd[4];
+ /* Check and compose ATA command */
+ if (!n_block)
+  /* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */
+  return 1;
 
-   qc->nsect = ((unsigned int)scsicmd[12] << 8) |
-     scsicmd[13];
-  } else {
-   /* once again, filter out impossible non-zero values */
-   if (scsicmd[4] || scsicmd[5] || scsicmd[12] ||
-       (scsicmd[6] & 0xf0))
-    return 1;
+ if (lba48) {
+  /* The request -may- be too large for LBA48. */
+  if ((block >> 48) || (n_block > 65536))
+   return 1;
 
-   /* stores LBA27:24 in lower 4 bits of device reg */
-   tf->device |= scsicmd[6];
+  tf->hob_nsect = (n_block >> 8) & 0xff;
 
-   qc->nsect = scsicmd[13];
-  }
+  tf->hob_lbah = (block >> 40) & 0xff;
+  tf->hob_lbam = (block >> 32) & 0xff;
+  tf->hob_lbal = (block >> 24) & 0xff;
+ } else { 
+  /* LBA28 */
 
-  tf->nsect = scsicmd[13];
-  tf->lbal = scsicmd[9];
-  tf->lbam = scsicmd[8];
-  tf->lbah = scsicmd[7];
+  /* The request -may- be too large for LBA28. */
+  if ((block >> 28) || (n_block > 256))
+   return 1;
 
-  VPRINTK("sixteen-byte command\n");
-  return 0;
+  tf->device |= (block >> 24) & 0xf;
  }
+ 
+ qc->nsect = n_block;
+ tf->nsect = n_block & 0xff;
+
+ tf->lbah = (block >> 16) & 0xff;
+ tf->lbam = (block >> 8) & 0xff;
+ tf->lbal = block & 0xff;
 
- DPRINTK("no-byte command\n");
- return 1;
+ tf->device |= ATA_LBA;
+
+ return 0;
 }
 
 static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)

------=_NextPart_000_008B_01C512C9.DBFFD470
Content-Type: application/octet-stream;
	name="chs3-2.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="chs3-2.diff"

--- libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-02-14 =
16:54:47.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c	2005-02-14 =
17:05:12.000000000 +0800=0A=
@@ -788,10 +788,11 @@=0A=
 {=0A=
 	struct ata_taskfile *tf =3D &qc->tf;=0A=
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
@@ -801,80 +802,79 @@=0A=
 		tf->flags |=3D ATA_TFLAG_WRITE;=0A=
 	}=0A=
 =0A=
+	/* Calculate the SCSI LBA and transfer length. */=0A=
 	if (scsicmd[0] =3D=3D READ_10 || scsicmd[0] =3D=3D WRITE_10) {=0A=
-		if (lba48) {=0A=
-			tf->hob_nsect =3D scsicmd[7];=0A=
-			tf->hob_lbal =3D scsicmd[2];=0A=
-=0A=
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
+		block |=3D ((u64)scsicmd[2]) << 24;=0A=
+		block |=3D ((u64)scsicmd[3]) << 16;=0A=
+		block |=3D ((u64)scsicmd[4]) << 8;=0A=
+		block |=3D ((u64)scsicmd[5]);=0A=
 =0A=
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
-	}=0A=
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
 =0A=
-	if (scsicmd[0] =3D=3D READ_16 || scsicmd[0] =3D=3D WRITE_16) {=0A=
-		/* rule out impossible LBAs and sector counts */=0A=
-		if (scsicmd[2] || scsicmd[3] || scsicmd[10] || scsicmd[11])=0A=
-			return 1;=0A=
+		VPRINTK("sixteen-byte command\n");=0A=
+	} else {=0A=
+		DPRINTK("no-byte command\n");=0A=
+		return 1;=0A=
+	}=0A=
 =0A=
-		if (lba48) {=0A=
-			tf->hob_nsect =3D scsicmd[12];=0A=
-			tf->hob_lbal =3D scsicmd[6];=0A=
-			tf->hob_lbam =3D scsicmd[5];=0A=
-			tf->hob_lbah =3D scsicmd[4];=0A=
+	/* Check and compose ATA command */=0A=
+	if (!n_block)=0A=
+		/* In ATA, sector count 0 are 256 or 65536 sectors, not 0 sectors. */=0A=
+		return 1;=0A=
 =0A=
-			qc->nsect =3D ((unsigned int)scsicmd[12] << 8) |=0A=
-					scsicmd[13];=0A=
-		} else {=0A=
-			/* once again, filter out impossible non-zero values */=0A=
-			if (scsicmd[4] || scsicmd[5] || scsicmd[12] ||=0A=
-			    (scsicmd[6] & 0xf0))=0A=
-				return 1;=0A=
+	if (lba48) {=0A=
+		/* The request -may- be too large for LBA48. */=0A=
+		if ((block >> 48) || (n_block > 65536))=0A=
+			return 1;=0A=
 =0A=
-			/* stores LBA27:24 in lower 4 bits of device reg */=0A=
-			tf->device |=3D scsicmd[6];=0A=
+		tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
 =0A=
-			qc->nsect =3D scsicmd[13];=0A=
-		}=0A=
+		tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
+		tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
+		tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
+	} else { =0A=
+		/* LBA28 */=0A=
 =0A=
-		tf->nsect =3D scsicmd[13];=0A=
-		tf->lbal =3D scsicmd[9];=0A=
-		tf->lbam =3D scsicmd[8];=0A=
-		tf->lbah =3D scsicmd[7];=0A=
+		/* The request -may- be too large for LBA28. */=0A=
+		if ((block >> 28) || (n_block > 256))=0A=
+			return 1;=0A=
 =0A=
-		VPRINTK("sixteen-byte command\n");=0A=
-		return 0;=0A=
+		tf->device |=3D (block >> 24) & 0xf;=0A=
 	}=0A=
+	=0A=
+	qc->nsect =3D n_block;=0A=
+	tf->nsect =3D n_block & 0xff;=0A=
+=0A=
+	tf->lbah =3D (block >> 16) & 0xff;=0A=
+	tf->lbam =3D (block >> 8) & 0xff;=0A=
+	tf->lbal =3D block & 0xff;=0A=
 =0A=
-	DPRINTK("no-byte command\n");=0A=
-	return 1;=0A=
+	tf->device |=3D ATA_LBA;=0A=
+=0A=
+	return 0;=0A=
 }=0A=
 =0A=
 static int ata_scsi_qc_complete(struct ata_queued_cmd *qc, u8 drv_stat)=0A=

------=_NextPart_000_008B_01C512C9.DBFFD470--


