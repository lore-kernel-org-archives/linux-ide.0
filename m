From: Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH] pata_marvell: fix cable detection - take 2
Date: Mon, 20 Nov 2006 21:20:44 +0100
Message-ID: <m3psbhdg4j.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:41738 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S965862AbWKTUSO
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Mon, 20 Nov 2006 15:18:14 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@redhat.com

--=-=-=


Last time I looked at the cable detection code, I fixed the "always
detect cable as sata cable" case, but this is not enough. I didn't
notice that the 80-pin cable was seen as a 40-pin cable.
The appended patch fixes that.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline;
 filename=pata_marvell_fix_cable_detection_take2.patch

Index: libata-dev/drivers/ata/pata_marvell.c
===================================================================
--- libata-dev.orig/drivers/ata/pata_marvell.c
+++ libata-dev/drivers/ata/pata_marvell.c
@@ -57,11 +57,10 @@ static int marvell_pre_reset(struct ata_
 	switch(ap->port_no)
 	{
 	case 0:
-		/* Might be backward, docs unclear */
 		if (inb(ap->ioaddr.bmdma_addr + 1) & 1)
-			ap->cbl = ATA_CBL_PATA80;
-		else
 			ap->cbl = ATA_CBL_PATA40;
+		else
+			ap->cbl = ATA_CBL_PATA80;
 		break;
 
 	case 1: /* Legacy SATA port */

--=-=-=--

