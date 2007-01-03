From: Mark Lord <liml@rtr.ca>
Subject: [PATCH] libata: add support for ATA_16 commands to ATAPI devices
Date: Tue, 2 Jan 2007 19:39:10 -0500
Message-ID: <200701021939.10496.liml@rtr.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from rtr.ca ([64.26.128.89]:1130 "EHLO mail.rtr.ca"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752415AbXACAjI convert rfc822-to-8bit (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 2 Jan 2007 19:39:08 -0500
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Linux IDE <linux-ide@vger.kernel.org>, Tejun Heo <htejun@gmail.com>, Jeff Garzik <jeff@garzik.org>

This patch adds support for passing ATA_16 commands
through to ATAPI devices in libata. =A0In practice, the upper layers wi=
ll
still currently prevent ATA_16 commands, as no (?) ATAPI drives support
them yet. =A0But it will work if such a drive is ever encountered.

Support for ATA_16 is necessary for using SG_IO from userspace,
and an upcoming hdparm release will be updated to use this interface.

This version is very similar to the earlier first submission,
except that ATA_12 is no longer passed through to ATAPI
because of the conflict it has with the SCSI BLANK opcode.

Signed-off-by:  Mark Lord <mlord@pobox.com>

--- old/drivers/ata/libata-scsi.c	2007-01-02 19:20:23.000000000 -0500
+++ new/drivers/ata/libata-scsi.c	2007-01-02 19:20:49.000000000 -0500
@@ -2650,6 +2650,12 @@
=20
 static inline ata_xlat_func_t ata_get_xlat_func(struct ata_device *dev=
, u8 cmd)
 {
+	if (cmd =3D=3D ATA_16)
+		return ata_scsi_pass_thru;
+
+	if (dev->class =3D=3D ATA_DEV_ATAPI)
+		return atapi_xlat;
+
 	switch (cmd) {
 	case READ_6:
 	case READ_10:
@@ -2670,7 +2676,6 @@
 		return ata_scsi_verify_xlat;
=20
 	case ATA_12:
-	case ATA_16:
 		return ata_scsi_pass_thru;
=20
 	case START_STOP:
@@ -2708,6 +2713,7 @@
 				      void (*done)(struct scsi_cmnd *),
 				      struct ata_device *dev)
 {
+	ata_xlat_func_t xlat_func;
 	int rc =3D 0;
=20
 	if (unlikely(!scmd->cmd_len)) {
@@ -2717,17 +2723,11 @@
 		return 0;
 	}
=20
-	if (dev->class =3D=3D ATA_DEV_ATA) {
-		ata_xlat_func_t xlat_func =3D ata_get_xlat_func(dev,
-							      scmd->cmnd[0]);
-
-		if (xlat_func)
-			rc =3D ata_scsi_translate(dev, scmd, done, xlat_func);
-		else
-			ata_scsi_simulate(dev, scmd, done);
-	} else
-		rc =3D ata_scsi_translate(dev, scmd, done, atapi_xlat);
-
+	xlat_func =3D ata_get_xlat_func(dev, scmd->cmnd[0]);
+	if (xlat_func)
+		rc =3D ata_scsi_translate(dev, scmd, done, xlat_func);
+	else
+		ata_scsi_simulate(dev, scmd, done);
 	return rc;
 }
=20
