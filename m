From: Arnaud Patard <apatard@mandriva.com>
Subject: [PATCH] pata_marvell: fix cable detection
Date: Fri, 17 Nov 2006 19:04:06 +0100
Message-ID: <m3fycidk6h.fsf@anduin.mandriva.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from ezoffice.mandriva.com ([84.14.106.134]:47373 "EHLO
	office.mandriva.com") by vger.kernel.org with ESMTP id S932975AbWKQSCC
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 17 Nov 2006 13:02:02 -0500
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: alan@redhat.com

--=-=-=


A "break;" is missing in the cable detection switch() statement, leading
to a wrong detection of the cable type.

Signed-off-by: Arnaud Patard <apatard@mandriva.com>
---

--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=pata_marvell_fix_cbl_detect.patch

Index: libata-dev/drivers/ata/pata_marvell.c
===================================================================
--- libata-dev.orig/drivers/ata/pata_marvell.c
+++ libata-dev/drivers/ata/pata_marvell.c
@@ -62,6 +62,7 @@ static int marvell_pre_reset(struct ata_
 			ap->cbl = ATA_CBL_PATA80;
 		else
 			ap->cbl = ATA_CBL_PATA40;
+		break;
 
 	case 1: /* Legacy SATA port */
 		ap->cbl = ATA_CBL_SATA;

--=-=-=--

