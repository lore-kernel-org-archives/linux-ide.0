From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: Re: [PATCH libata-dev-2.6 1/3] Add CHS support
Date: Mon, 14 Feb 2005 19:09:13 +0800
Message-ID: <007f01c51285$a3612450$6401a8c0@tw.ibm.com>
References: <006d01c50c11$81003920$a801a8c0@tw.ibm.com> <4205B886.4070005@pobox.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_007C_01C512C8.ABBBADD0"
Received: from bluehawaii.tikira.net ([61.62.22.51]:65519 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S261414AbVBNLJy (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 14 Feb 2005 06:09:54 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>, "Mudama, Eric" <eric_mudama@Maxtor.com>, Mark Lord <mlord@pobox.com>

This is a multi-part message in MIME format.

------=_NextPart_000_007C_01C512C8.ABBBADD0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit

Dear all:

> 
> Comments:
> 
> 1) Patches #1 and #2 look OK.
> 
> 2) Patch #3 needs to be split up into three patches:
> a) rename variables (s/sector/block/),
> b) reorganize read/write translation
> c) add CHS support
> 

Happy lunar new year.

Attached pls find the split patch #3 for your review.

Patch 3-1: 
 - rename variables (s/sector/block/) in ata_scsi_verify_xlat()

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------
--- libata-dev-2.6/drivers/scsi/libata-scsi.c 2005-02-14 16:26:44.000000000 +0800
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c 2005-02-14 16:45:33.000000000 +0800
@@ -691,75 +691,75 @@
  struct ata_taskfile *tf = &qc->tf;
  unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
  u64 dev_sectors = qc->dev->n_sectors;
- u64 sect = 0;
- u32 n_sect = 0;
+ u64 block = 0;
+ u32 n_block = 0;
 
  tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
  tf->protocol = ATA_PROT_NODATA;
  tf->device |= ATA_LBA;
 
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
 
  if (lba48) {
   tf->command = ATA_CMD_VERIFY_EXT;
 
-  tf->hob_nsect = (n_sect >> 8) & 0xff;
+  tf->hob_nsect = (n_block >> 8) & 0xff;
 
-  tf->hob_lbah = (sect >> 40) & 0xff;
-  tf->hob_lbam = (sect >> 32) & 0xff;
-  tf->hob_lbal = (sect >> 24) & 0xff;
+  tf->hob_lbah = (block >> 40) & 0xff;
+  tf->hob_lbam = (block >> 32) & 0xff;
+  tf->hob_lbal = (block >> 24) & 0xff;
  } else {
   tf->command = ATA_CMD_VERIFY;
 
-  tf->device |= (sect >> 24) & 0xf;
+  tf->device |= (block >> 24) & 0xf;
  }
 
- tf->nsect = n_sect & 0xff;
+ tf->nsect = n_block & 0xff;
 
- tf->lbah = (sect >> 16) & 0xff;
- tf->lbam = (sect >> 8) & 0xff;
- tf->lbal = sect & 0xff;
+ tf->lbah = (block >> 16) & 0xff;
+ tf->lbam = (block >> 8) & 0xff;
+ tf->lbal = block & 0xff;
 
  return 0;
 }

------=_NextPart_000_007C_01C512C8.ABBBADD0
Content-Type: application/octet-stream;
	name="chs3-1.diff"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="chs3-1.diff"

--- libata-dev-2.6/drivers/scsi/libata-scsi.c	2005-02-14 =
16:26:44.000000000 +0800=0A=
+++ libata-dev-2.6-mod/drivers/scsi/libata-scsi.c	2005-02-14 =
16:45:33.000000000 +0800=0A=
@@ -691,75 +691,75 @@=0A=
 	struct ata_taskfile *tf =3D &qc->tf;=0A=
 	unsigned int lba48 =3D tf->flags & ATA_TFLAG_LBA48;=0A=
 	u64 dev_sectors =3D qc->dev->n_sectors;=0A=
-	u64 sect =3D 0;=0A=
-	u32 n_sect =3D 0;=0A=
+	u64 block =3D 0;=0A=
+	u32 n_block =3D 0;=0A=
 =0A=
 	tf->flags |=3D ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;=0A=
 	tf->protocol =3D ATA_PROT_NODATA;=0A=
 	tf->device |=3D ATA_LBA;=0A=
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
 	if (lba48) {=0A=
 		tf->command =3D ATA_CMD_VERIFY_EXT;=0A=
 =0A=
-		tf->hob_nsect =3D (n_sect >> 8) & 0xff;=0A=
+		tf->hob_nsect =3D (n_block >> 8) & 0xff;=0A=
 =0A=
-		tf->hob_lbah =3D (sect >> 40) & 0xff;=0A=
-		tf->hob_lbam =3D (sect >> 32) & 0xff;=0A=
-		tf->hob_lbal =3D (sect >> 24) & 0xff;=0A=
+		tf->hob_lbah =3D (block >> 40) & 0xff;=0A=
+		tf->hob_lbam =3D (block >> 32) & 0xff;=0A=
+		tf->hob_lbal =3D (block >> 24) & 0xff;=0A=
 	} else {=0A=
 		tf->command =3D ATA_CMD_VERIFY;=0A=
 =0A=
-		tf->device |=3D (sect >> 24) & 0xf;=0A=
+		tf->device |=3D (block >> 24) & 0xf;=0A=
 	}=0A=
 =0A=
-	tf->nsect =3D n_sect & 0xff;=0A=
+	tf->nsect =3D n_block & 0xff;=0A=
 =0A=
-	tf->lbah =3D (sect >> 16) & 0xff;=0A=
-	tf->lbam =3D (sect >> 8) & 0xff;=0A=
-	tf->lbal =3D sect & 0xff;=0A=
+	tf->lbah =3D (block >> 16) & 0xff;=0A=
+	tf->lbam =3D (block >> 8) & 0xff;=0A=
+	tf->lbal =3D block & 0xff;=0A=
 =0A=
 	return 0;=0A=
 }=0A=

------=_NextPart_000_007C_01C512C8.ABBBADD0--


