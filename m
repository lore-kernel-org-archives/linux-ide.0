From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 1/4] ata: add missing ATA_* defines
Date: Thu, 24 Jul 2008 21:22:39 +0200
Message-ID: <200807242122.39783.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mu-out-0910.google.com ([209.85.134.187]:53596 "EHLO
	mu-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751610AbYGXT1J (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 15:27:09 -0400
Received: by mu-out-0910.google.com with SMTP id w8so2199467mue.1
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 12:27:08 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jeff Garzik <jeff@garzik.org>

Add missing ATA_* defines to <linux/ata.h>.  Also add
ATAPI_{LFS,EOM,ILI,IO,CODE} defines while at it.

Cc: Jeff Garzik <jeff@garzik.org>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
* against previous ATA_ID_* and ATA_CMD_* patchsets
* patch #1 shouldn't conflict with previous <linux/ata.h> ones

 include/linux/ata.h |   13 +++++++++++++
 1 file changed, 13 insertions(+)

Index: b/include/linux/ata.h
===================================================================
--- a/include/linux/ata.h
+++ b/include/linux/ata.h
@@ -153,13 +153,26 @@ enum {
 	ATA_BUSY		= (1 << 7),	/* BSY status bit */
 	ATA_DRDY		= (1 << 6),	/* device ready */
 	ATA_DF			= (1 << 5),	/* device fault */
+	ATA_DSC			= (1 << 4),	/* drive seek complete */
 	ATA_DRQ			= (1 << 3),	/* data request i/o */
+	ATA_CORR		= (1 << 2),	/* corrected data error */
+	ATA_IDX			= (1 << 1),	/* index */
 	ATA_ERR			= (1 << 0),	/* have an error */
 	ATA_SRST		= (1 << 2),	/* software reset */
 	ATA_ICRC		= (1 << 7),	/* interface CRC error */
+	ATA_BBK			= ATA_ICRC,	/* pre-EIDE: block marked bad */
 	ATA_UNC			= (1 << 6),	/* uncorrectable media error */
+	ATA_MC			= (1 << 5),	/* media changed */
 	ATA_IDNF		= (1 << 4),	/* ID not found */
+	ATA_MCR			= (1 << 3),	/* media change requested */
 	ATA_ABORTED		= (1 << 2),	/* command aborted */
+	ATA_TRK0NF		= (1 << 1),	/* track 0 not found */
+	ATA_AMNF		= (1 << 0),	/* address mark not found */
+	ATAPI_LFS		= 0xF0,		/* last failed sense */
+	ATAPI_EOM		= ATA_TRK0NF,	/* end of media */
+	ATAPI_ILI		= ATA_AMNF,	/* illegal length indication */
+	ATAPI_IO		= (1 << 1),
+	ATAPI_COD		= (1 << 0),
 
 	/* ATA command block registers */
 	ATA_REG_DATA		= 0x00,
