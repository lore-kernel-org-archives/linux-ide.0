From: "Albert Lee" <albertcc@tw.ibm.com>
Subject: [PATCH] libata - Fix SCSI to ATA translation for 16 bytes R/W SCSI commands
Date: Thu, 27 Jan 2005 13:22:34 +0800
Message-ID: <001201c50430$3c890080$6401a8c0@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_NextPart_000_000F_01C50473.4300C040"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from bluehawaii.tikira.net ([61.62.22.51]:1505 "EHLO
	bluehawaii.tikira.net") by vger.kernel.org with ESMTP
	id S262469AbVA0FXR (ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Thu, 27 Jan 2005 00:23:17 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Doug Maxey <dwm@maxeymade.com>, IDE Linux <linux-ide@vger.kernel.org>

This is a multi-part message in MIME format.

------=_NextPart_000_000F_01C50473.4300C040
Content-Type: text/plain;
	charset="big5"
Content-Transfer-Encoding: 7bit

Hi Jeff,

Attached please find the patch against libata-2.6 for your review.

Changes:
  Fix SCSI to ATA translation for 16 bytes Read/Write SCSI commands.

Albert

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>
----------------------------------------------------------------------------------------------
--- libata-2.6/drivers/scsi/libata-scsi.c 2005-01-27 10:41:46.000000000 +0800
+++ libata-2.6-mod/drivers/scsi/libata-scsi.c 2005-01-27 11:57:53.356234000 +0800
@@ -599,7 +599,7 @@
     return 1;
 
    /* stores LBA27:24 in lower 4 bits of device reg */
-   tf->device |= scsicmd[2];
+   tf->device |= scsicmd[6];
 
    qc->nsect = scsicmd[13];
   }

------=_NextPart_000_000F_01C50473.4300C040
Content-Type: application/octet-stream;
	name="ata_scsi_rw_xlat.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
	filename="ata_scsi_rw_xlat.patch"

--- libata-2.6/drivers/scsi/libata-scsi.c	2005-01-27 10:41:46.000000000 =
+0800=0A=
+++ libata-2.6-mod/drivers/scsi/libata-scsi.c	2005-01-27 =
11:57:53.356234000 +0800=0A=
@@ -599,7 +599,7 @@=0A=
 				return 1;=0A=
 =0A=
 			/* stores LBA27:24 in lower 4 bits of device reg */=0A=
-			tf->device |=3D scsicmd[2];=0A=
+			tf->device |=3D scsicmd[6];=0A=
 =0A=
 			qc->nsect =3D scsicmd[13];=0A=
 		}=0A=

------=_NextPart_000_000F_01C50473.4300C040--


