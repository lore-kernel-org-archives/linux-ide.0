From: Gwendal Grignou <gwendal@google.com>
Subject: [PATCH] ata: cleanup SAT error translation
Date: Fri, 14 Jun 2013 13:48:33 -0700
Message-ID: <1371242913-10899-1-git-send-email-gwendal@google.com>
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-gh0-f202.google.com ([209.85.160.202]:37496 "EHLO
	mail-gh0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752045Ab3FNUsm (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Fri, 14 Jun 2013 16:48:42 -0400
Received: by mail-gh0-f202.google.com with SMTP id g24so104980ghb.3
        for <linux-ide@vger.kernel.org>; Fri, 14 Jun 2013 13:48:41 -0700 (PDT)
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, Gwendal Grignou <gwendal@google.com>

Remove duplicate Medium Error Entry.
Remove the ABRT entry: it is too broad: when only ABRT is set
we should look at status for more information.
Only if status does not provide information we set ABORTED_COMMAND
sense key.

Tested: When a disk fails, it sets
Status = 0x71 [DRDY DF ERR] , Error = 0x4 [ABRT]
Ensure the sense key is HARDWARE_ERROR.
When there is a simple command syntax error:
Status = 0x51 [DRDY ERR] , Error = 0x4 [ABRT]
Ensure the sense key is ABORTED_COMMAND.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
---
 drivers/ata/libata-scsi.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dd310b27..1724189 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -850,14 +850,10 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 		{0x01, 		MEDIUM_ERROR, 0x13, 0x00}, 	// Address mark not found       Address mark not found for data field
 		/* TRK0 */
 		{0x02, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Track 0 not found		  Hardware error
-		/* Abort & !ICRC */
-		{0x04, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Aborted command              Aborted command
 		/* Media change request */
 		{0x08, 		NOT_READY, 0x04, 0x00}, 	// Media change request	  FIXME: faking offline
 		/* SRV */
 		{0x10, 		ABORTED_COMMAND, 0x14, 0x00}, 	// ID not found                 Recorded entity not found
-		/* Media change */
-		{0x08,  	NOT_READY, 0x04, 0x00}, 	// Media change		  FIXME: faking offline
 		/* ECC */
 		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
 		/* BBD - block marked bad */
-- 
1.8.3

