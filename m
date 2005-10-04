From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 1/4] CHS: white space beautification
Date: Tue, 04 Oct 2005 20:27:14 +0800
Message-ID: <43427522.5000802@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------080600060507030103000904"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:43951 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750832AbVJDM1e (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 08:27:34 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j94CRPb1026078
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:27:25 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j94CRPhH070284
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:27:25 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j94CROs0031603
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:27:25 -0400
In-Reply-To: <43427405.80502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------080600060507030103000904
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 1/4:
  white space, comments and debug message beautification

For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------080600060507030103000904
Content-Type: text/plain;
 name="chs1.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chs1.diff"

--- upstream/drivers/scsi/libata-scsi.c	2005-09-29 15:32:03.000000000 +0800
+++ chs0/drivers/scsi/libata-scsi.c	2005-10-04 17:50:13.000000000 +0800
@@ -589,7 +589,8 @@ static unsigned int ata_scsi_verify_xlat
 		head  = track % dev->heads;
 		sect  = (u32)block % dev->sectors + 1;
 
-		DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", (u32)block, track, cyl, head, sect);
+		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
+			(u32)block, track, cyl, head, sect);
 		
 		/* Check whether the converted CHS can fit. 
 		   Cylinder: 0-65535 
@@ -665,6 +666,10 @@ static unsigned int ata_scsi_rw_xlat(str
 		block |= ((u64)scsicmd[3]);
 
 		n_block |= ((u32)scsicmd[4]);
+
+		/* for 6-byte r/w commands, transfer length 0
+		 * means 256 blocks of data, not 0 block.
+		 */
 		if (!n_block)
 			n_block = 256;
 	
@@ -692,7 +697,11 @@ static unsigned int ata_scsi_rw_xlat(str
 
 	/* Check and compose ATA command */
 	if (!n_block)
-		/* In ATA, sector count 0 means 256 or 65536 sectors, not 0 sectors. */
+		/* For 10-byte and 16-byte SCSI R/W commands, transfer
+		 * length 0 means transfer 0 block of data.
+		 * However, for ATA R/W commands, sector count 0 means
+		 * 256 or 65536 sectors, not 0 sectors as in SCSI.
+		 */
 		return 1;
 
 	if (lba) {
@@ -715,7 +724,7 @@ static unsigned int ata_scsi_rw_xlat(str
 
 			tf->device |= (block >> 24) & 0xf;
 		}
-	
+
 		qc->nsect = n_block;
 		tf->nsect = n_block & 0xff;
 
@@ -731,23 +740,23 @@ static unsigned int ata_scsi_rw_xlat(str
 		/* The request -may- be too large for CHS addressing. */
 		if ((block >> 28) || (n_block > 256))
 			return 1;
-			
+
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
 		cyl   = track / dev->heads;
 		head  = track % dev->heads;
 		sect  = (u32)block % dev->sectors + 1;
 
-		DPRINTK("block[%u] track[%u] cyl[%u] head[%u] sect[%u] \n", 
+		DPRINTK("block %u track %u cyl %u head %u sect %u\n",
 			(u32)block, track, cyl, head, sect);
-		
+
 		/* Check whether the converted CHS can fit. 
 		   Cylinder: 0-65535 
 		   Head: 0-15
 		   Sector: 1-255*/
-		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect)) 
+		if ((cyl >> 16) || (head >> 4) || (sect >> 8) || (!sect))
 			return 1;
-		
+
 		qc->nsect = n_block;
 		tf->nsect = n_block & 0xff; /* Sector count 0 means 256 sectors */
 		tf->lbal = sect;

--------------080600060507030103000904--

