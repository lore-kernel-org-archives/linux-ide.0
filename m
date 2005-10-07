From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 3/3] CHS: LBA28/LBA48 optimization (resend #4)
Date: Fri, 07 Oct 2005 16:37:43 +0800
Message-ID: <434633D7.4090601@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com> <434276B9.7080807@tw.ibm.com> <43427AFD.1020405@pobox.com> <4343B5F5.4090402@tw.ibm.com> <434509EF.3040307@pobox.com> <43461B81.1090808@tw.ibm.com> <43463296.3090007@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e35.co.us.ibm.com ([32.97.110.153]:44753 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751284AbVJGIhv
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Fri, 7 Oct 2005 04:37:51 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e35.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j978Z28U018084
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 04:35:02 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j978cZ9L545402
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:38:35 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j978bo9T015171
	for <linux-ide@vger.kernel.org>; Fri, 7 Oct 2005 02:37:50 -0600
In-Reply-To: <43463296.3090007@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

(resend #4)

Patch 3/3: LBA28/LBA48 optimization per Mark's advice.

Changes:
     - add lba_28_ok() and lba_48_ok() to ata.h
     - use lba_28_ok() for CHS range check
     - LBA28/LBA48 optimization

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=====

--- ch2/include/linux/ata.h	2005-10-05 18:11:12.000000000 +0800
+++ ch4/include/linux/ata.h	2005-10-05 18:47:29.000000000 +0800
@@ -291,4 +291,14 @@ static inline int ata_ok(u8 status)
 			== ATA_DRDY);
 }
 
+static inline int lba_28_ok(u64 block, u32 n_block)
+{
+	return (block < ((u64)1 << 28)) && (n_block <= 256);
+}
+
+static inline int lba_48_ok(u64 block, u32 n_block)
+{
+	return (block < ((u64)1 << 48)) && (n_block <= 65536);
+}
+
 #endif /* __LINUX_ATA_H__ */
--- ch3/drivers/scsi/libata-scsi.c	2005-10-05 18:11:12.000000000 +0800
+++ ch4/drivers/scsi/libata-scsi.c	2005-10-05 18:12:09.000000000 +0800
@@ -633,8 +633,12 @@ static unsigned int ata_scsi_verify_xlat
 	if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |= ATA_TFLAG_LBA;
 
-		if (dev->flags & ATA_DFLAG_LBA48) {
-			if (n_block > (64 * 1024))
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->command = ATA_CMD_VERIFY;
+			tf->device |= (block >> 24) & 0xf;
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
 				return 1;
 
 			/* use LBA48 */
@@ -646,14 +650,9 @@ static unsigned int ata_scsi_verify_xlat
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else {
-			if (n_block > 256)
-				return 1;
-
-			/* use LBA28 */
-			tf->command = ATA_CMD_VERIFY;
-			tf->device |= (block >> 24) & 0xf;
-		}
+		} else
+			/* request too large even for LBA48 */
+			return 1;
 
 		tf->nsect = n_block & 0xff;
 
@@ -666,7 +665,7 @@ static unsigned int ata_scsi_verify_xlat
 		/* CHS */
 		u32 sect, head, cyl, track;
 
-		if (n_block > 256)
+		if (!lba_28_ok(block, n_block))
 			return 1;
 
 		/* Convert LBA to CHS */
@@ -766,9 +765,11 @@ static unsigned int ata_scsi_rw_xlat(str
 	if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |= ATA_TFLAG_LBA;
 
-		if (dev->flags & ATA_DFLAG_LBA48) {
-			/* The request -may- be too large for LBA48. */
-			if ((block >> 48) || (n_block > 65536))
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->device |= (block >> 24) & 0xf;
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
 				return 1;
 
 			/* use LBA48 */
@@ -779,15 +780,9 @@ static unsigned int ata_scsi_rw_xlat(str
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else { 
-			/* use LBA28 */
-
-			/* The request -may- be too large for LBA28. */
-			if ((block >> 28) || (n_block > 256))
-				return 1;
-
-			tf->device |= (block >> 24) & 0xf;
-		}
+		} else
+			/* request too large even for LBA48 */
+			return 1;
 
 		ata_rwcmd_protocol(qc);
 
@@ -804,7 +799,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		u32 sect, head, cyl, track;
 
 		/* The request -may- be too large for CHS addressing. */
-		if ((block >> 28) || (n_block > 256))
+		if (!lba_28_ok(block, n_block))
 			return 1;
 
 		ata_rwcmd_protocol(qc);


