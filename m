From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH] libata: SCSI to ATA translation fix
Date: Thu, 27 Jan 2005 18:30:10 +0800
Message-ID: <007101c5045b$b8ec0de0$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_006E_01C5049E.3BE75F50"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:22496 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262565AbVA0Keg (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jan 2005 05:34:36 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_006E_01C5049E.3BE75F50
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi Jeff,

Attached please find the patch against libata-2.6 for your review.

Changes:
  #1. ata_scsi_rw_xlat():  
    Fix  incorrect SCSI to ATA translation for 16 bytes SCSI Read/Write commands. 
   (Already submitted in the previous patch. Merged with change #2 and resubmitted again.)

  #2. Fix ata_scsi_verify_xlat():
    Fix incorrect tf->hob_lbax translation.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------------------------
--- libata-2.6/drivers/scsi/libata-scsi.c 2005-01-27 10:41:46.000000000 +0800
+++ libata-2.6-mod/drivers/scsi/libata-scsi.c 2005-01-27 18:10:20.261707752 +0800
@@ -497,9 +497,9 @@
 
  tf->nsect = n_sect & 0xff;
 
- tf->hob_lbah = (sect >> 16) & 0xff;
- tf->hob_lbam = (sect >> 8) & 0xff;
- tf->hob_lbal = sect & 0xff;
+ tf->lbah = (sect >> 16) & 0xff;
+ tf->lbam = (sect >> 8) & 0xff;
+ tf->lbal = sect & 0xff;
 
  return 0;
 }
@@ -599,7 +599,7 @@
     return 1;
 
    /* stores LBA27:24 in lower 4 bits of device reg */
-   tf->device |= scsicmd[2];
+   tf->device |= scsicmd[6];
 
    qc->nsect = scsicmd[13];
   }

------=_NextPart_000_006E_01C5049E.3BE75F50
Content-Type: application/octet-stream;
	name="ata_xlat.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ata_xlat.patch"

--- libata-2.6/drivers/scsi/libata-scsi.c	2005-01-27 10:41:46.000000000 =
+0800=0A=
+++ libata-2.6-mod/drivers/scsi/libata-scsi.c	2005-01-27 =
18:10:20.261707752 +0800=0A=
@@ -497,9 +497,9 @@=0A=
 =0A=
 	tf->nsect =3D n_sect & 0xff;=0A=
 =0A=
-	tf->hob_lbah =3D (sect >> 16) & 0xff;=0A=
-	tf->hob_lbam =3D (sect >> 8) & 0xff;=0A=
-	tf->hob_lbal =3D sect & 0xff;=0A=
+	tf->lbah =3D (sect >> 16) & 0xff;=0A=
+	tf->lbam =3D (sect >> 8) & 0xff;=0A=
+	tf->lbal =3D sect & 0xff;=0A=
 =0A=
 	return 0;=0A=
 }=0A=
@@ -599,7 +599,7 @@=0A=
 				return 1;=0A=
 =0A=
 			/* stores LBA27:24 in lower 4 bits of device reg */=0A=
-			tf->device |=3D scsicmd[2];=0A=
+			tf->device |=3D scsicmd[6];=0A=
 =0A=
 			qc->nsect =3D scsicmd[13];=0A=
 		}=0A=

------=_NextPart_000_006E_01C5049E.3BE75F50--


