From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH 4/4] CHS: LBA28/LBA48 optimization (revise #6)
Date: Wed, 12 Oct 2005 15:12:26 +0800
Message-ID: <434CB75A.6010109@tw.ibm.com>
References: <434CAF8E.5040607@tw.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e36.co.us.ibm.com ([32.97.110.154]:17887 "EHLO
	e36.co.us.ibm.com") by vger.kernel.org with ESMTP id S932398AbVJLHMj
	(ORCPT <rfc822;linux-ide@vger.kernel.org>);
	Wed, 12 Oct 2005 03:12:39 -0400
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com [9.17.195.106])
	by e36.co.us.ibm.com (8.12.11/8.12.11) with ESMTP id j9C7AtqZ019388
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 03:10:55 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j9C7DGtu490622
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 01:13:16 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11/8.13.3) with ESMTP id j9C7CScN019248
	for <linux-ide@vger.kernel.org>; Wed, 12 Oct 2005 01:12:28 -0600
In-Reply-To: <434CAF8E.5040607@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Linux IDE <linux-ide@vger.kernel.org>

Patch 4/4: LBA28/LBA48 optimization per Mark's advice.

Changes:
     - add lba_28_ok() and lba_48_ok() to ata.h.
     - check ending block number instead of staring block number.
     - use lba_28_ok() for CHS range check
     - LBA28/LBA48 optimization

Signed-off-by: Albert Lee <albertcc@tw.ibm.com>

=====

--- ch2/include/linux/ata.h	2005-10-11 12:56:56.000000000 +0800
+++ ch4/include/linux/ata.h	2005-10-12 14:26:59.000000000 +0800
@@ -291,4 +291,16 @@ static inline int ata_ok(u8 status)
 			== ATA_DRDY);
 }
 
+static inline int lba_28_ok(u64 block, u32 n_block)
+{
+	/* check the ending block number */
+	return ((block + n_block - 1) < ((u64)1 << 28)) && (n_block <= 256);
+}
+
+static inline int lba_48_ok(u64 block, u32 n_block)
+{
+	/* check the ending block number */
+	return ((block + n_block - 1) < ((u64)1 << 48)) && (n_block <= 65536);
+}
+
 #endif /* __LINUX_ATA_H__ */
--- ch2/drivers/scsi/libata-scsi.c	2005-10-11 13:03:10.000000000 +0800
+++ ch4/drivers/scsi/libata-scsi.c	2005-10-11 13:13:19.000000000 +0800
@@ -636,9 +636,13 @@ static unsigned int ata_scsi_verify_xlat
 	if (dev->flags & ATA_DFLAG_LBA) {
 		tf->flags |= ATA_TFLAG_LBA;
 
-		if (dev->flags & ATA_DFLAG_LBA48) {
-			if (n_block > (64 * 1024))
-				goto invalid_fld;
+		if (lba_28_ok(block, n_block)) {
+			/* use LBA28 */
+			tf->command = ATA_CMD_VERIFY;
+			tf->device |= (block >> 24) & 0xf;
+		} else if (lba_48_ok(block, n_block)) {
+			if (!(dev->flags & ATA_DFLAG_LBA48))
+				goto out_of_range;
 
 			/* use LBA48 */
 			tf->flags |= ATA_TFLAG_LBA48;
@@ -649,15 +653,9 @@ static unsigned int ata_scsi_verify_xlat
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else {
-			if (n_block > 256)
-				goto invalid_fld;
-
-			/* use LBA28 */
-			tf->command = ATA_CMD_VERIFY;
-
-			tf->device |= (block >> 24) & 0xf;
-		}
+		} else
+			/* request too large even for LBA48 */
+			goto out_of_range;
 
 		tf->nsect = n_block & 0xff;
 
@@ -670,8 +668,8 @@ static unsigned int ata_scsi_verify_xlat
 		/* CHS */
 		u32 sect, head, cyl, track;
 
-		if (n_block > 256)
-			goto invalid_fld;
+		if (!lba_28_ok(block, n_block))
+			goto out_of_range;
 
 		/* Convert LBA to CHS */
 		track = (u32)block / dev->sectors;
@@ -784,9 +782,11 @@ static unsigned int ata_scsi_rw_xlat(str
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
 				goto out_of_range;
 
 			/* use LBA48 */
@@ -797,15 +797,9 @@ static unsigned int ata_scsi_rw_xlat(str
 			tf->hob_lbah = (block >> 40) & 0xff;
 			tf->hob_lbam = (block >> 32) & 0xff;
 			tf->hob_lbal = (block >> 24) & 0xff;
-		} else { 
-			/* use LBA28 */
-
-			/* The request -may- be too large for LBA28. */
-			if ((block >> 28) || (n_block > 256))
-				goto out_of_range;
-
-			tf->device |= (block >> 24) & 0xf;
-		}
+		} else
+			/* request too large even for LBA48 */
+			goto out_of_range;
 
 		ata_rwcmd_protocol(qc);
 
@@ -822,7 +816,7 @@ static unsigned int ata_scsi_rw_xlat(str
 		u32 sect, head, cyl, track;
 
 		/* The request -may- be too large for CHS addressing. */
-		if ((block >> 28) || (n_block > 256))
+		if (!lba_28_ok(block, n_block))
 			goto out_of_range;
 
 		ata_rwcmd_protocol(qc);



