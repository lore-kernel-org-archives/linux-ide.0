From: Tejun Heo <tj@kernel.org>
Subject: Re: [PATCH v2] ata: cleanup SAT error translation
Date: Tue, 18 Jun 2013 11:37:02 -0700
Message-ID: <20130618183702.GD1596@htj.dyndns.org>
References: <20130617194855.GL32663@mtj.dyndns.org>
 <1371578088-31855-1-git-send-email-gwendal@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Received: from mail-yh0-f47.google.com ([209.85.213.47]:46656 "EHLO
	mail-yh0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756197Ab3FRShH (ORCPT
	<rfc822;linux-ide@vger.kernel.org>); Tue, 18 Jun 2013 14:37:07 -0400
Received: by mail-yh0-f47.google.com with SMTP id f64so1674271yha.34
        for <linux-ide@vger.kernel.org>; Tue, 18 Jun 2013 11:37:06 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1371578088-31855-1-git-send-email-gwendal@google.com>
Sender: linux-ide-owner@vger.kernel.org
List-Id: linux-ide@vger.kernel.org
To: Gwendal Grignou <gwendal@google.com>
Cc: linux-ide@vger.kernel.org

Applied to libata/for-3.11 with some description / comment updates.

Thanks!

>From 78062c50d15d6a0adfa09f6e35a6c52abcc9a32d Mon Sep 17 00:00:00 2001
From: Gwendal Grignou <gwendal@google.com>
Date: Tue, 18 Jun 2013 10:54:48 -0700
Subject: [PATCH] libata: cleanup SAT error translation

- Remove duplicate Medium Error Entry.

- Fix translations to match SAT2 translation table.

- Remove warning messages when translation is not found when decoding
  error or status register.

- Goes through status register decoding when only ABRT bit is set in
  error register.

Tested: When a disk fails, it sets

  Status = 0x71 [DRDY DF ERR] , Error = 0x4 [ABRT]

This patch will make the sense key HARDWARE_ERROR instead.

When there is a simple command syntax error:

  Status = 0x51 [DRDY ERR] , Error = 0x4 [ABRT]

The sense key remains ABORTED_COMMAND.

tj: Some updates to the description and comments.

Signed-off-by: Gwendal Grignou <gwendal@google.com>
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 drivers/ata/libata-scsi.c | 37 +++++++++++++++++--------------------
 1 file changed, 17 insertions(+), 20 deletions(-)

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index dd310b27..006f1bf 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -849,25 +849,24 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 		/*  Bad address mark */
 		{0x01, 		MEDIUM_ERROR, 0x13, 0x00}, 	// Address mark not found       Address mark not found for data field
 		/* TRK0 */
-		{0x02, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Track 0 not found		  Hardware error
-		/* Abort & !ICRC */
-		{0x04, 		ABORTED_COMMAND, 0x00, 0x00}, 	// Aborted command              Aborted command
+		{0x02, 		HARDWARE_ERROR, 0x00, 0x00}, 	// Track 0 not found		Hardware error
+		/* Abort: 0x04 is not translated here, see below */
 		/* Media change request */
 		{0x08, 		NOT_READY, 0x04, 0x00}, 	// Media change request	  FIXME: faking offline
-		/* SRV */
-		{0x10, 		ABORTED_COMMAND, 0x14, 0x00}, 	// ID not found                 Recorded entity not found
-		/* Media change */
-		{0x08,  	NOT_READY, 0x04, 0x00}, 	// Media change		  FIXME: faking offline
+		/* SRV/IDNF */
+		{0x10, 		ILLEGAL_REQUEST, 0x21, 0x00}, 	// ID not found                 Logical address out of range
+		/* MC */
+		{0x20, 		UNIT_ATTENTION, 0x28, 0x00}, 	// Media Changed		Not ready to ready change, medium may have changed
 		/* ECC */
 		{0x40, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Uncorrectable ECC error      Unrecovered read error
 		/* BBD - block marked bad */
-		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		  Medium error, unrecovered read error
+		{0x80, 		MEDIUM_ERROR, 0x11, 0x04}, 	// Block marked bad		Medium error, unrecovered read error
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
 	};
 	static const unsigned char stat_table[][4] = {
 		/* Must be first because BUSY means no other bits valid */
 		{0x80, 		ABORTED_COMMAND, 0x47, 0x00},	// Busy, fake parity for now
-		{0x20, 		HARDWARE_ERROR,  0x00, 0x00}, 	// Device fault
+		{0x20, 		HARDWARE_ERROR,  0x44, 0x00}, 	// Device fault, internal target failure
 		{0x08, 		ABORTED_COMMAND, 0x47, 0x00},	// Timed out in xfer, fake parity for now
 		{0x04, 		RECOVERED_ERROR, 0x11, 0x00},	// Recovered ECC error	  Medium error, recovered
 		{0xFF, 0xFF, 0xFF, 0xFF}, // END mark
@@ -892,13 +891,13 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 				goto translate_done;
 			}
 		}
-		/* No immediate match */
-		if (verbose)
-			printk(KERN_WARNING "ata%u: no sense translation for "
-			       "error 0x%02x\n", id, drv_err);
 	}
 
-	/* Fall back to interpreting status bits */
+	/*
+	 * Fall back to interpreting status bits.  Note that if the drv_err
+	 * has only the ABRT bit set, we decode drv_stat.  ABRT by itself
+	 * is not descriptive enough.
+	 */
 	for (i = 0; stat_table[i][0] != 0xFF; i++) {
 		if (stat_table[i][0] & drv_stat) {
 			*sk = stat_table[i][1];
@@ -907,13 +906,11 @@ static void ata_to_sense_error(unsigned id, u8 drv_stat, u8 drv_err, u8 *sk,
 			goto translate_done;
 		}
 	}
-	/* No error?  Undecoded? */
-	if (verbose)
-		printk(KERN_WARNING "ata%u: no sense translation for "
-		       "status: 0x%02x\n", id, drv_stat);
 
-	/* We need a sensible error return here, which is tricky, and one
-	   that won't cause people to do things like return a disk wrongly */
+	/*
+	 * We need a sensible error return here, which is tricky, and one
+	 * that won't cause people to do things like return a disk wrongly.
+	 */
 	*sk = ABORTED_COMMAND;
 	*asc = 0x00;
 	*ascq = 0x00;
-- 
1.8.2.1

