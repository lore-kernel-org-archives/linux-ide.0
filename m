From: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: [PATCH 3/4] isd200: use ATA_* defines instead of *_STAT and *_ERR ones
Date: Thu, 24 Jul 2008 21:23:42 +0200
Message-ID: <200807242123.42923.bzolnier@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from nf-out-0910.google.com ([64.233.182.187]:19769 "EHLO
	nf-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753000AbYGXT1L (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Thu, 24 Jul 2008 15:27:11 -0400
Received: by nf-out-0910.google.com with SMTP id d3so1152972nfc.21
        for <linux-ide@vger.kernel.org>; Thu, 24 Jul 2008 12:27:11 -0700 (PDT)
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: linux-ide@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Greg Kroah-Hartman <gregkh@suse.de>

Cc: Greg Kroah-Hartman <gregkh@suse.de>
Signed-off-by: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
---
 drivers/usb/storage/isd200.c |   18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

Index: b/drivers/usb/storage/isd200.c
===================================================================
--- a/drivers/usb/storage/isd200.c
+++ b/drivers/usb/storage/isd200.c
@@ -373,19 +373,19 @@ static void isd200_build_sense(struct us
 		buf->Flags = UNIT_ATTENTION;
 		buf->AdditionalSenseCode = 0;
 		buf->AdditionalSenseCodeQualifier = 0;
-	} else if(error & MCR_ERR) {
+	} else if (error & ATA_MCR) {
 		buf->ErrorCode = 0x70 | SENSE_ERRCODE_VALID;
 		buf->AdditionalSenseLength = 0xb;
 		buf->Flags =  UNIT_ATTENTION;
 		buf->AdditionalSenseCode = 0;
 		buf->AdditionalSenseCodeQualifier = 0;
-	} else if(error & TRK0_ERR) {
+	} else if (error & ATA_TRK0NF) {
 		buf->ErrorCode = 0x70 | SENSE_ERRCODE_VALID;
 		buf->AdditionalSenseLength = 0xb;
 		buf->Flags =  NOT_READY;
 		buf->AdditionalSenseCode = 0;
 		buf->AdditionalSenseCodeQualifier = 0;
-	} else if(error & ECC_ERR) {
+	} else if (error & ATA_UNC) {
 		buf->ErrorCode = 0x70 | SENSE_ERRCODE_VALID;
 		buf->AdditionalSenseLength = 0xb;
 		buf->Flags =  DATA_PROTECT;
@@ -898,22 +898,22 @@ static int isd200_try_enum(struct us_dat
 			break;
 
 		if (!detect) {
-			if (regs[ATA_REG_STATUS_OFFSET] & BUSY_STAT) {
+			if (regs[ATA_REG_STATUS_OFFSET] & ATA_BUSY) {
 				US_DEBUGP("   %s status is still BSY, try again...\n",mstr);
 			} else {
 				US_DEBUGP("   %s status !BSY, continue with next operation\n",mstr);
 				break;
 			}
 		}
-		/* check for BUSY_STAT and */
-		/* WRERR_STAT (workaround ATA Zip drive) and */ 
-		/* ERR_STAT (workaround for Archos CD-ROM) */
+		/* check for ATA_BUSY and */
+		/* ATA_DF (workaround ATA Zip drive) and */
+		/* ATA_ERR (workaround for Archos CD-ROM) */
 		else if (regs[ATA_REG_STATUS_OFFSET] &
-			 (BUSY_STAT | WRERR_STAT | ERR_STAT )) {
+			 (ATA_BUSY | ATA_DF | ATA_ERR)) {
 			US_DEBUGP("   Status indicates it is not ready, try again...\n");
 		}
 		/* check for DRDY, ATA devices set DRDY after SRST */
-		else if (regs[ATA_REG_STATUS_OFFSET] & READY_STAT) {
+		else if (regs[ATA_REG_STATUS_OFFSET] & ATA_DRDY) {
 			US_DEBUGP("   Identified ATA device\n");
 			info->DeviceFlags |= DF_ATA_DEVICE;
 			info->DeviceHead = master_slave;
