From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 3/4] CHS: add CHS support to ata_scsi_start_stop_xlat()
Date: Tue, 04 Oct 2005 20:30:35 +0800
Message-ID: <434275EB.5080400@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------060207040502010307040204"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e4.ny.us.ibm.com ([32.97.182.144]:15036 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750832AbVJDMau (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 08:30:50 -0400
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e4.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j94CUic2000448
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:30:44 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j94CUi6C069016
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:30:44 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j94CUh0j014086
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:30:44 -0400
In-Reply-To: <43427405.80502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------060207040502010307040204
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 3/4: add CHS support to ata_scsi_start_stop_xlat()

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>


--------------060207040502010307040204
Content-Type: text/plain;
 name="chs3.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chs3.diff"

--- chs1/drivers/scsi/libata-scsi.c	2005-10-04 17:50:33.000000000 +0800
+++ chs2/drivers/scsi/libata-scsi.c	2005-10-04 19:01:17.000000000 +0800
@@ -435,10 +435,21 @@ static unsigned int ata_scsi_start_stop_
 		return 1;	/* power conditions not supported */
 	if (scsicmd[4] & 0x1) {
 		tf->nsect = 1;	/* 1 sector, lba=0 */
-		tf->lbah = 0x0;
-		tf->lbam = 0x0;
-		tf->lbal = 0x0;
-		tf->device |= ATA_LBA;
+
+		if (qc->dev->flags & ATA_DFLAG_LBA) {
+			qc->tf.flags |= ATA_TFLAG_LBA;
+
+			tf->lbah = 0x0;
+			tf->lbam = 0x0;
+			tf->lbal = 0x0;
+			tf->device |= ATA_LBA;
+		} else {
+			/* CHS */
+			tf->lbal = 0x1; /* sect */
+			tf->lbam = 0x0; /* cyl low */
+			tf->lbah = 0x0; /* cyl high */
+		}
+
 		tf->command = ATA_CMD_VERIFY;	/* READ VERIFY */
 	} else {
 		tf->nsect = 0;	/* time period value (0 implies now) */

--------------060207040502010307040204--

