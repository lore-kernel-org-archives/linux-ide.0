From: Albert Lee <albertcc@tw.ibm.com>
Subject: [PATCH/RFC 2/4] CHS: tidy up SCSI lba and transfer length calculation
Date: Tue, 04 Oct 2005 20:29:06 +0800
Message-ID: <43427592.6050200@tw.ibm.com>
References: <4321B4E0.8020801@tw.ibm.com> <4321C7DD.5050503@pobox.com>	 <43322C50.1060009@tw.ibm.com> <4333CF07.5010400@pobox.com>	 <4339116D.30908@tw.ibm.com> <433912FB.9000606@tw.ibm.com> <58cb370e05092903083e0d001c@mail.gmail.com> <433D1BC7.6060301@tw.ibm.com> <433D1FC7.2060401@pobox.com> <43411A1A.8050901@tw.ibm.com> <43412FF6.5030006@tw.ibm.com> <43413386.6000203@pobox.com> <43424EC6.2040100@pobox.com> <43426ED9.8030004@tw.ibm.com> <4342706B.3030608@pobox.com> <43427405.80502@tw.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------000308030806060508070603"
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from e2.ny.us.ibm.com ([32.97.182.142]:39349 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1750832AbVJDM3V (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 4 Oct 2005 08:29:21 -0400
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e2.ny.us.ibm.com (8.12.11/8.12.11) with ESMTP id j94CTFK3030602
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:29:15 -0400
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay04.pok.ibm.com (8.12.10/NCO/VERS6.7) with ESMTP id j94CTFhH105922
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:29:15 -0400
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11/8.13.3) with ESMTP id j94CTEqh006786
	for <linux-ide@vger.kernel.org>; Tue, 4 Oct 2005 08:29:15 -0400
In-Reply-To: <43427405.80502@tw.ibm.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Jeff Garzik <jgarzik@pobox.com>
Cc: Mark Lord <mlord@pobox.com>, Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, Linux IDE <linux-ide@vger.kernel.org>, Doug Maxey <dwm@maxeymade.com>, Tejun Heo <htejun@gmail.com>, Brett Russ <russb@emc.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>

This is a multi-part message in MIME format.
--------------000308030806060508070603
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Patch 2/4: tidy up SCSI lba and transfer length calculation

changes:
    - move the redundant SCSI lba and transfer length calculation code 
from ata_scsi_verify_xlat() and ata_scsi_rw_xlat() to common functions.


For your review, thanks.

Albert
Signed-off-by: Albert Lee <albertcc@tw.ibm.com>



--------------000308030806060508070603
Content-Type: text/plain;
 name="chs2.diff"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="chs2.diff"

--- chs0/drivers/scsi/libata-scsi.c	2005-10-04 17:50:13.000000000 +0800
+++ chs1/drivers/scsi/libata-scsi.c	2005-10-04 17:50:33.000000000 +0800
@@ -488,6 +488,99 @@ static unsigned int ata_scsi_flush_xlat(
 }
 
 /**
+ *	scsi_6_lba_len - Get LBA and transfer length
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Calculate LBA and transfer length for 6-byte commands.
+ *
+ *	RETURNS:
+ *	@plba: the LBA
+ *	@plen: the transfer length
+ */
+
+static void scsi_6_lba_len(u8 *scsicmd, u64 *plba, u32 *plen)
+{
+	u64 lba = 0;
+	u32 len = 0;
+
+	VPRINTK("six-byte command\n");
+
+	lba |= ((u64)scsicmd[2]) << 8;
+	lba |= ((u64)scsicmd[3]);
+
+	len |= ((u32)scsicmd[4]);
+
+	*plba = lba;
+	*plen = len;
+}
+
+/**
+ *	scsi_10_lba_len - Get LBA and transfer length
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Calculate LBA and transfer length for 10-byte commands.
+ *
+ *	RETURNS:
+ *	@plba: the LBA
+ *	@plen: the transfer length
+ */
+
+static void scsi_10_lba_len(u8 *scsicmd, u64 *plba, u32 *plen)
+{
+	u64 lba = 0;
+	u32 len = 0;
+
+	VPRINTK("ten-byte command\n");
+
+	lba |= ((u64)scsicmd[2]) << 24;
+	lba |= ((u64)scsicmd[3]) << 16;
+	lba |= ((u64)scsicmd[4]) << 8;
+	lba |= ((u64)scsicmd[5]);
+
+	len |= ((u32)scsicmd[7]) << 8;
+	len |= ((u32)scsicmd[8]);
+
+	*plba = lba;
+	*plen = len;
+}
+
+/**
+ *	scsi_16_lba_len - Get LBA and transfer length
+ *	@scsicmd: SCSI command to translate
+ *
+ *	Calculate LBA and transfer length for 16-byte commands.
+ *
+ *	RETURNS:
+ *	@plba: the LBA
+ *	@plen: the transfer length
+ */
+
+static void scsi_16_lba_len(u8 *scsicmd, u64 *plba, u32 *plen)
+{
+	u64 lba = 0;
+	u32 len = 0;
+
+	VPRINTK("sixteen-byte command\n");
+
+	lba |= ((u64)scsicmd[2]) << 56;
+	lba |= ((u64)scsicmd[3]) << 48;
+	lba |= ((u64)scsicmd[4]) << 40;
+	lba |= ((u64)scsicmd[5]) << 32;
+	lba |= ((u64)scsicmd[6]) << 24;
+	lba |= ((u64)scsicmd[7]) << 16;
+	lba |= ((u64)scsicmd[8]) << 8;
+	lba |= ((u64)scsicmd[9]);
+
+	len |= ((u32)scsicmd[10]) << 24;
+	len |= ((u32)scsicmd[11]) << 16;
+	len |= ((u32)scsicmd[12]) << 8;
+	len |= ((u32)scsicmd[13]);
+
+	*plba = lba;
+	*plen = len;
+}
+
+/**
  *	ata_scsi_verify_xlat - Translate SCSI VERIFY command into an ATA one
  *	@qc: Storage for translated ATA taskfile
  *	@scsicmd: SCSI command to translate
@@ -508,38 +601,16 @@ static unsigned int ata_scsi_verify_xlat
 	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
 	u64 dev_sectors = qc->dev->n_sectors;
-	u64 block = 0;
-	u32 n_block = 0;
+	u64 block;
+	u32 n_block;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = ATA_PROT_NODATA;
 
-	if (scsicmd[0] == VERIFY) {
-		block |= ((u64)scsicmd[2]) << 24;
-		block |= ((u64)scsicmd[3]) << 16;
-		block |= ((u64)scsicmd[4]) << 8;
-		block |= ((u64)scsicmd[5]);
-
-		n_block |= ((u32)scsicmd[7]) << 8;
-		n_block |= ((u32)scsicmd[8]);
-	}
-
-	else if (scsicmd[0] == VERIFY_16) {
-		block |= ((u64)scsicmd[2]) << 56;
-		block |= ((u64)scsicmd[3]) << 48;
-		block |= ((u64)scsicmd[4]) << 40;
-		block |= ((u64)scsicmd[5]) << 32;
-		block |= ((u64)scsicmd[6]) << 24;
-		block |= ((u64)scsicmd[7]) << 16;
-		block |= ((u64)scsicmd[8]) << 8;
-		block |= ((u64)scsicmd[9]);
-
-		n_block |= ((u32)scsicmd[10]) << 24;
-		n_block |= ((u32)scsicmd[11]) << 16;
-		n_block |= ((u32)scsicmd[12]) << 8;
-		n_block |= ((u32)scsicmd[13]);
-	}
-
+	if (scsicmd[0] == VERIFY)
+		scsi_10_lba_len(scsicmd, &block, &n_block);
+	else if (scsicmd[0] == VERIFY_16)
+		scsi_16_lba_len(scsicmd, &block, &n_block);
 	else
 		return 1;
 
@@ -636,8 +707,8 @@ static unsigned int ata_scsi_rw_xlat(str
 	struct ata_device *dev = qc->dev;
 	unsigned int lba   = tf->flags & ATA_TFLAG_LBA;
 	unsigned int lba48 = tf->flags & ATA_TFLAG_LBA48;
-	u64 block = 0;
-	u32 n_block = 0;
+	u64 block;
+	u32 n_block;
 
 	tf->flags |= ATA_TFLAG_ISADDR | ATA_TFLAG_DEVICE;
 	tf->protocol = qc->dev->xfer_protocol;
@@ -651,46 +722,26 @@ static unsigned int ata_scsi_rw_xlat(str
 	}
 
 	/* Calculate the SCSI LBA and transfer length. */
-	if (scsicmd[0] == READ_10 || scsicmd[0] == WRITE_10) {
-		block |= ((u64)scsicmd[2]) << 24;
-		block |= ((u64)scsicmd[3]) << 16;
-		block |= ((u64)scsicmd[4]) << 8;
-		block |= ((u64)scsicmd[5]);
-
-		n_block |= ((u32)scsicmd[7]) << 8;
-		n_block |= ((u32)scsicmd[8]);
-
-		VPRINTK("ten-byte command\n");
-	} else if (scsicmd[0] == READ_6 || scsicmd[0] == WRITE_6) {
-		block |= ((u64)scsicmd[2]) << 8;
-		block |= ((u64)scsicmd[3]);
-
-		n_block |= ((u32)scsicmd[4]);
+	switch (scsicmd[0]) {
+	case READ_10:
+	case WRITE_10:
+		scsi_10_lba_len(scsicmd, &block, &n_block);
+		break;
+	case READ_6:
+	case WRITE_6:
+		scsi_6_lba_len(scsicmd, &block, &n_block);
 
 		/* for 6-byte r/w commands, transfer length 0
 		 * means 256 blocks of data, not 0 block.
 		 */
 		if (!n_block)
 			n_block = 256;
-	
-		VPRINTK("six-byte command\n");
-	} else if (scsicmd[0] == READ_16 || scsicmd[0] == WRITE_16) {
-		block |= ((u64)scsicmd[2]) << 56;
-		block |= ((u64)scsicmd[3]) << 48;
-		block |= ((u64)scsicmd[4]) << 40;
-		block |= ((u64)scsicmd[5]) << 32;
-		block |= ((u64)scsicmd[6]) << 24;
-		block |= ((u64)scsicmd[7]) << 16;
-		block |= ((u64)scsicmd[8]) << 8;
-		block |= ((u64)scsicmd[9]);
-
-		n_block |= ((u32)scsicmd[10]) << 24;
-		n_block |= ((u32)scsicmd[11]) << 16;
-		n_block |= ((u32)scsicmd[12]) << 8;
-		n_block |= ((u32)scsicmd[13]);
-
-		VPRINTK("sixteen-byte command\n");
-	} else {
+		break;
+	case READ_16:
+	case WRITE_16:
+		scsi_16_lba_len(scsicmd, &block, &n_block);
+		break;
+	default:
 		DPRINTK("no-byte command\n");
 		return 1;
 	}

--------------000308030806060508070603--

